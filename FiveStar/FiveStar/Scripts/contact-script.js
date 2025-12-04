/* Toggles the visibility of the user dropdown menu (Sign In, Sign Up, Cart).*/
function toggleDropdown() {
    // Chooses the dropdown content
    const dropdown = document.getElementById("userDropdown");
    
    // shows/hides the menu by adding/removing the show-dropdown class
    dropdown.classList.toggle("show-dropdown");
}

/* Closes the dropdown menu when a click occurs outside of the menu button.*/
window.onclick = function(event) {
     // Check if the clicked element is the menu icon
    if (!event.target.matches('.menu-button') && !event.target.matches('.menu-button i')) {
        const dropdown = document.getElementById("userDropdown");
        
        // If the menu is visible, close it
        if (dropdown && dropdown.classList.contains('show-dropdown')) {
            dropdown.classList.remove('show-dropdown');
        }
    }
}

// Live chat system
class LiveChat {
    constructor() {
        this.chatButton = document.getElementById('chatButton');
        this.chatBox = document.getElementById('chatBox');
        this.closeChat = document.getElementById('closeChat');
        this.messageInput = document.getElementById('messageInput');
        this.sendMessage = document.getElementById('sendMessage');
        this.chatMessages = document.getElementById('chatMessages');
        
        // The bot's predefined responses
        this.botResponses = [
            "I see, how can I assist you?",
            "Could you provide more information about this?",
            "Our team will contact you as soon as possible.",
            "Thank you! We are evaluating your query.",
            "How else may I help you?"
        ];
        
        this.init();
    }
    
    init() {
        if (this.chatButton) this.chatButton.addEventListener('click', () => this.toggleChat());
        if (this.closeChat) this.closeChat.addEventListener('click', () => this.closeChatBox());
        if (this.sendMessage) this.sendMessage.addEventListener('click', () => this.sendUserMessage());
        
        if (this.messageInput) {
            this.messageInput.addEventListener('keypress', (e) => {
                if (e.key === 'Enter') {
                    this.sendUserMessage();
                }
            });
        }
    }
    
    toggleChat() {
        if (!this.chatBox) return;
        this.chatBox.classList.toggle('active');
        if (this.chatBox.classList.contains('active')) {
            if (this.messageInput) this.messageInput.focus();
        }
    }
    
    closeChatBox() {
        if (this.chatBox) this.chatBox.classList.remove('active');
    }
    
    sendUserMessage() {
        if (!this.messageInput) return;

        const message = this.messageInput.value.trim();
        
        if (message === '') return;
        
        //Add user message to chat
        this.addMessage(message, 'user');
        this.messageInput.value = '';
        
        //simulate bot response after a delay
        setTimeout(() => {
            this.addBotResponse();
        }, 1000 + Math.random() * 1000);
    }
    
    addMessage(text, sender) {
        if (!this.chatMessages) return;

        const messageDiv = document.createElement('div');
        messageDiv.className = `message ${sender}-message`;
        
        const time = new Date().toLocaleTimeString('tr-TR', { 
            hour: '2-digit', 
            minute: '2-digit' 
        });
        
        messageDiv.innerHTML = `
            <p>${this.escapeHtml(text)}</p>
            <span class="time">${time}</span>
        `;
        
        this.chatMessages.appendChild(messageDiv);
        this.scrollToBottom();
    }
    
    addBotResponse() {
        const randomResponse = this.botResponses[
            Math.floor(Math.random() * this.botResponses.length)
        ];
        this.addMessage(randomResponse, 'bot');
    }
    
    scrollToBottom() {
        if (this.chatMessages) this.chatMessages.scrollTop = this.chatMessages.scrollHeight;
    }
    
    // FOR SECURITY: Escape HTML to prevent XSS
    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}


//DOMContentLoaded event to ensure the DOM is fully loaded before running scripts

document.addEventListener('DOMContentLoaded', function() {
    // 1. Contact Form Submission Handling
    const contactForm = document.getElementById('contactForm');
    
    if (contactForm) {
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            //Check if necessary fields are filled
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const subject = document.getElementById('subject').value;
            const message = document.getElementById('message').value;

            if (!name || !email || subject === "" || !message) {
                 alert('Fill neccesary fields.');
                 return;
            }

            const formData = {
                name: name,
                email: email,
                subject: subject,
                message: message
            };
            
            console.log('Form data:', formData);
            alert('Your message has been sent, we will contact you later.');
            contactForm.reset();
        });
    }

    // 2. Initialize Live Chat
    new LiveChat();

    // 3. Close chat box when clicking outside
    const chatBox = document.getElementById('chatBox');
    const chatButton = document.getElementById('chatButton');
    
    document.addEventListener('click', (e) => {
        // Close chat box if click is outside chat box and chat button
        if (chatBox && chatBox.classList.contains('active') && 
            chatButton && !chatBox.contains(e.target) && 
            !chatButton.contains(e.target)) {
            chatBox.classList.remove('active');
        }
    });
});
