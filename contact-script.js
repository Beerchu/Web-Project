// ⭐ Canlı Destek Sistemi Sınıfı
class LiveChat {
    constructor() {
        // Gerekli DOM elementlerini seç
        this.chatButton = document.getElementById('chatButton');
        this.chatBox = document.getElementById('chatBox');
        this.closeChat = document.getElementById('closeChat');
        this.messageInput = document.getElementById('messageInput');
        this.sendMessage = document.getElementById('sendMessage');
        this.chatMessages = document.getElementById('chatMessages');
        
        // Botun vereceği rastgele cevaplar
        this.botResponses = [
            "Anladım, size nasıl yardımcı olabilirim?",
            "Bu konuda daha fazla bilgi verebilir misiniz?",
            "Ekibimiz en kısa sürede sizinle iletişime geçecektir.",
            "Teşekkür ederiz! Sorunuzu değerlendiriyoruz.",
            "Size başka nasıl yardımcı olabilirim?"
        ];
        
        this.init();
    }
    
    init() {
        // Event listener'ları ekle
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
        
        // Kullanıcı mesajını ekle
        this.addMessage(message, 'user');
        this.messageInput.value = '';
        
        // Bot yanıtını simüle et (1-2 saniye gecikmeli)
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
    
    // Güvenlik için HTML karakterlerini kaçış dizisine dönüştürür
    escapeHtml(text) {
        const div = document.createElement('div');
        div.textContent = text;
        return div.innerHTML;
    }
}


// 🚀 Tüm Sayfa Yükleme İşlemleri (DOMContentLoaded)

document.addEventListener('DOMContentLoaded', function() {
    // 1. İletişim Formu İşleyicisi
    const contactForm = document.getElementById('contactForm');
    
    if (contactForm) {
        // İki kere yazılan form işleyiciyi birleştirdik.
        contactForm.addEventListener('submit', function(e) {
            e.preventDefault();
            
            // Basit doğrulama (HTML'de 'required' olsa da iyi bir kontrol)
            const name = document.getElementById('name').value;
            const email = document.getElementById('email').value;
            const subject = document.getElementById('subject').value;
            const message = document.getElementById('message').value;

            if (!name || !email || subject === "" || !message) {
                 alert('Lütfen tüm alanları doldurun.');
                 return;
            }

            const formData = {
                name: name,
                email: email,
                subject: subject,
                message: message
            };
            
            console.log('Form verileri:', formData);
            alert('Mesajınız başarıyla gönderildi! En kısa sürede size dönüş yapacağız.');
            contactForm.reset();
        });
    }

    // 2. Canlı Destek Sistemi Başlatma
    new LiveChat();

    // 3. Ekstra Özellik: Sayfa dışına tıklayınca chat'i kapat
    const chatBox = document.getElementById('chatBox');
    const chatButton = document.getElementById('chatButton');
    
    document.addEventListener('click', (e) => {
        // Chat kutusu açıksa ve tıklanan yer kutunun veya butonun içi değilse kapat
        if (chatBox && chatBox.classList.contains('active') && 
            chatButton && !chatBox.contains(e.target) && 
            !chatButton.contains(e.target)) {
            chatBox.classList.remove('active');
        }
    });

    // 4. Yıldız Yağmuru Efekti (Eski kodunuzdan korundu)
    const navBrand = document.querySelector('.nav-brand');
    if (navBrand) {
        navBrand.style.cursor = 'pointer';
        // showStarRain fonksiyonu bu kodda tanımlı değil, ancak olay dinleyiciyi koruyoruz.
        // navBrand.addEventListener('click', showStarRain); 
    }
});