const idInput = document.getElementById('id');
	
function showError(input, errorElement, message) {
    input.classList.add('error');
    input.classList.remove('success');
    errorElement.querySelector('span').textContent = message;
    errorElement.classList.add('show');
}

function showSuccess(input, errorElement) {
    input.classList.remove('error');
    input.classList.add('success');
    errorElement.classList.remove('show');
}

idInput.addEventListener('blur', function() {
    const idError = document.getElementById('idError');
    if(!this.value || this.value < 1) {
        showError(this, idError, 'ID deve ser um número válido');
    } else {
        showSuccess(this, idError);
    }
});

// Validação no submit
document.getElementById('searchForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const id = idInput.value;
    let isValid = true;

    if(!id || id < 1) {
        showError(idInput, document.getElementById('idError'), 'ID deve ser um número válido');
        isValid = false;
    }

    if(isValid) {
        this.submit();
    } else {
        showAlert('Por favor, informe um ID válido', 'error');
    }
});

function showAlert(message, type) {
    const alertBox = document.getElementById('alertBox');
    alertBox.textContent = (type === 'error' ? '❌ ' : '✅ ') + message;
    alertBox.className = 'alert ' + type + ' show';

    setTimeout(() => {
        alertBox.classList.remove('show');
    }, 5000);
}