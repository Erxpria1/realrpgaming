// MTA'dan gelecek olan gerçek zamanlı yüzde verisini işleyen fonksiyon
function setProgress(value) {
    let rawValue = parseFloat(value);
    if (isNaN(rawValue)) return;
    
    // Yüzdeyi 0-100 arasına sabitle
    let progress = Math.min(Math.max(rawValue, 0), 100);
    
    const bar = document.getElementById('bar');
    const percentText = document.getElementById('percent-text');
    const statusText = document.getElementById('status-text');

    bar.style.width = progress + '%';
    percentText.innerText = Math.floor(progress) + '%';
    
    // Yüzdeye göre durum metni değişimi
    if (progress < 25) {
        statusText.innerText = "Sunucu verileri çekiliyor...";
    } else if (progress < 50) {
        statusText.innerText = "Modeller yükleniyor...";
    } else if (progress < 75) {
        statusText.innerText = "Harita senkronize ediliyor...";
    } else if (progress < 100) {
        statusText.innerText = "Son hazırlıklar yapılıyor...";
    } else {
        statusText.innerText = "Hoş geldiniz! Giriş yapılıyor...";
    }
}

// Global scope'a açalım ki Lua'dan erişilebilsin
window.setProgress = setProgress;
