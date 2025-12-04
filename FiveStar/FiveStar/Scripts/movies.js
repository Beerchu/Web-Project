document.addEventListener("DOMContentLoaded", function () {
    var form = document.getElementById("movies-filter-form");
    if (!form) return;

    var genreSelect = document.getElementById("genreSelect");
    var cinemaSelect = document.getElementById("cinemaSelect");

    function wire(select) {
        if (!select) return;
        select.addEventListener("change", function () {
            form.submit();
        });
    }

    wire(genreSelect);
    wire(cinemaSelect);
});
