document.addEventListener("submit", async (e) => {
    const form = e.target.closest("form.js-campaign-apply");
    if (!form) return;

    e.preventDefault();

    const footer = form.closest(".card-footer") || form.parentElement;
    const status = footer.querySelector(".apply-status");
    const btn = form.querySelector("button[type='submit']");
    const oldHtml = btn ? btn.innerHTML : "";

    if (btn) { btn.disabled = true; btn.innerHTML = "Applying..."; }
    if (status) status.textContent = "";

    try {
        const res = await fetch(form.action, {
            method: "POST",
            body: new FormData(form),
            headers: { "X-Requested-With": "XMLHttpRequest" }
        });

        // Try JSON first (even if content-type is wrong)
        let data = null;
        try {
            data = await res.json();
        } catch (jsonErr) {
            // Server returned HTML (likely login redirect) -> still alert
            alert("You must be logged in to apply this offer.");
            window.location.href = "/Campaigns";
            return;
        }

        // ✅ Not logged in -> ALERT + refresh
        if (data && data.requiresLogin) {
            alert(data.message || "You must be logged in to apply this offer.");
            window.location.href = "/Campaigns";
            return;
        }

        // Normal error
        if (!res.ok || !data || !data.ok) {
            if (status) status.textContent = (data && data.message) ? data.message : "Failed to apply.";
            if (btn) { btn.disabled = false; btn.innerHTML = oldHtml; }
            return;
        }

        // Success UI
        form.remove();

        const appliedBtn = document.createElement("button");
        appliedBtn.className = "btn-apply";
        appliedBtn.disabled = true;
        appliedBtn.innerHTML = `<i class="fas fa-check-circle"></i><span>ALREADY APPLIED</span>`;
        footer.insertBefore(appliedBtn, footer.firstChild);

        if (status) status.textContent = data.message || "Campaign applied!";
    } catch {
        if (status) status.textContent = "Network error. Try again.";
        if (btn) { btn.disabled = false; btn.innerHTML = oldHtml; }
    }
});
