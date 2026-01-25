// Define data mínima como hoje
const today = new Date().toISOString().split('T')[0];
document.getElementById('start_date').setAttribute('min', today);

function showAlert(message, type) {
    const alertBox = document.getElementById('alertBox');
    alertBox.textContent = (type === 'error' ? '❌ ' : '✅ ') + message;
    alertBox.className = 'alert ' + type + ' show';

    setTimeout(() => {
        alertBox.classList.remove('show');
    }, 5000);
}

function checkServerMessages() {
    const alertBox = document.getElementById('alertBox');
    
    // O dataset converte o atributo data-success para a propriedade success
    if (alertBox.dataset.success === "true") {
        showAlert('Sucesso!', 'success');
    } else if (alertBox.dataset.error === "true") {
        showAlert('Erro!', 'error');
    }
}

document.addEventListener('DOMContentLoaded', checkServerMessages);	        