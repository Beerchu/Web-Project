// ===============================
// FIREBASE CONFIG
// ===============================
const firebaseConfig = {
    apiKey: "AIzaSyA8sZZD3rDM_4IfcfT2aTOEmNGLPSrzwzg",
    authDomain: "live-support-c2260.firebaseapp.com",
    projectId: "live-support-c2260",
    storageBucket: "live-support-c2260.firebasestorage.app",
    messagingSenderId: "1076806111910",
    appId: "1:1076806111910:web:d88db157573ddf25255a67",
    measurementId: "G-Y3804JJ84N"
};
// Initialize Firebase
if (!firebase.apps.length) {
    firebase.initializeApp(firebaseConfig);
}

const db = firebase.firestore();

// ===============================
// RULE BASED RESPONSES
// ===============================
const rules = [
    {
        keywords: ["refund", "return", "cancel"],
        answer: "Refunds are available up to 2 hours before the movie session. After this time, refunds cannot be processed."
    },
    {
        keywords: ["ticket", "booking", "reserve"],
        answer: "You can book tickets directly from our website by selecting your movie, cinema location, date, and session time."
    },
    {
        keywords: ["payment", "credit card", "debit card"],
        answer: "We accept all major credit and debit cards. All payments are processed securely through our payment system."
    },
    {
        keywords: ["working hours", "support hours", "open", "available"],
        answer: "Live support is available every day between 09:00 AM and 10:00 PM, including weekends."
    },
    {
        keywords: ["contact", "phone", "email", "reach"],
        answer: "You can reach us using the contact form on this page or by calling +90 (553) 777 06 03."
    },
    {
        keywords: ["seat", "seating", "choose seat"],
        answer: "You can select your preferred seats during the booking process before completing your payment."
    },
    {
        keywords: ["movie", "movies", "now playing"],
        answer: "You can view currently playing movies and upcoming releases on our Movies page."
    },
    {
        keywords: ["location", "cinema", "theater"],
        answer: "Our cinema locations and addresses are listed on the Contact Us page."
    },
    {
        keywords: ["problem", "issue", "error"],
        answer: "If you are experiencing a technical issue, please describe the problem in detail and our support team will assist you."
    },
    {
        keywords: ["lost", "forgot", "email confirmation"],
        answer: "If you did not receive your confirmation email, please check your spam folder or contact support."
    }
];


function getRuleBasedResponse(message) {
    const lowerMessage = message.toLowerCase();

    for (let rule of rules) {
        if (rule.keywords.some(keyword => lowerMessage.includes(keyword))) {
            return rule.answer;
        }
    }

    return "Thank you for your message. A support agent will contact you shortly.";
}

// ===============================
// LIVE CHAT CLASS
// ===============================
class LiveChat {
    constructor() {
        this.chatButton = document.getElementById('chatButton');
        this.chatBox = document.getElementById('chatBox');
        this.closeChat = document.getElementById('closeChat');
        this.messageInput = document.getElementById('messageInput');
        this.sendMessageBtn = document.getElementById('sendMessage');
        this.chatMessages = document.getElementById('chatMessages');

        this.init();
        this.listenMessages();
    }

    init() {
        this.chatButton.onclick = () => {
            this.chatBox.classList.toggle('open');
            this.scrollToBottom();
        };

        this.closeChat.onclick = () => {
            this.chatBox.classList.remove('open');
        };

        this.sendMessageBtn.onclick = () => {
            this.sendMessage();
        };

        this.messageInput.addEventListener("keypress", (e) => {
            if (e.key === "Enter") this.sendMessage();
        });
    }

    listenMessages() {
        // .orderBy("timestamp", "asc") kýsmýndan sonra .limitToLast(0) gibi 
        // bir kýsýtlama yerine, Snapshot'ý sadece yeni gelenler için kullanacaðýz.

        db.collection("messages")
            .where("timestamp", ">", new Date()) // Sadece þu andan sonraki mesajlarý dinle
            .orderBy("timestamp", "asc")
            .onSnapshot(snapshot => {
                snapshot.docChanges().forEach(change => {
                    if (change.type === "added") {
                        const data = change.doc.data();
                        this.renderMessage(data.text, data.sender, data.timestamp);
                    }
                });
                this.scrollToBottom();
            });
    }

    async sendMessage() {
        const text = this.messageInput.value.trim();
        if (!text) return;

        this.messageInput.value = "";

        await db.collection("messages").add({
            text: text,
            sender: "user",
            timestamp: firebase.firestore.FieldValue.serverTimestamp()
        });

        const reply = getRuleBasedResponse(text);

        setTimeout(async () => {
            await db.collection("messages").add({
                text: reply,
                sender: "bot",
                timestamp: firebase.firestore.FieldValue.serverTimestamp()
            });
        }, 800);
    }

    renderMessage(text, sender, timestamp) {
        const div = document.createElement("div");
        div.className = `message ${sender}-message`;

        const time = timestamp
            ? new Date(timestamp.seconds * 1000).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })
            : "Now";

        div.innerHTML = `<p>${text}</p><span class="time">${time}</span>`;
        this.chatMessages.appendChild(div);
    }

    scrollToBottom() {
        this.chatMessages.scrollTop = this.chatMessages.scrollHeight;
    }
}

document.addEventListener("DOMContentLoaded", () => {
    new LiveChat();
});
