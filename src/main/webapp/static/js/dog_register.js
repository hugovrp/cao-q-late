const nameInput = document.getElementById('name');
const breedInput = document.getElementById('breed');
const ownerIdInput = document.getElementById('owner_id');
const sizeRadios = document.querySelectorAll('input[name="size"]');

function showError(input, errorElement, message) {
    if(input) {
        input.classList.add('error');
        input.classList.remove('success');
    }
    errorElement.querySelector('span').textContent = message;
    errorElement.classList.add('show');
}

function showSuccess(input, errorElement) {
    if(input) {
        input.classList.remove('error');
        input.classList.add('success');
    }
    errorElement.classList.remove('show');
}

// Validação em tempo real
nameInput.addEventListener('blur', function() {
    const nameError = document.getElementById('nameError');
    if(this.value.trim().length < 2) {
        showError(this, nameError, 'Nome deve ter pelo menos 2 caracteres');
    } else {
        showSuccess(this, nameError);
    }
});

breedInput.addEventListener('blur', function() {
    const breedError = document.getElementById('breedError');
    if(this.value.trim().length < 2) {
        showError(this, breedError, 'Raça deve ter pelo menos 2 caracteres');
    } else {
        showSuccess(this, breedError);
    }
});

ownerIdInput.addEventListener('blur', function() {
    const ownerError = document.getElementById('ownerError');
    if(!this.value || this.value < 1) {
        showError(this, ownerError, 'ID do dono deve ser um número válido');
    } else {
        showSuccess(this, ownerError);
    }
});

// Validação no submit
document.getElementById('dogForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const name = nameInput.value.trim();
    const breed = breedInput.value.trim();
    const ownerId = ownerIdInput.value;
    const sizeSelected = document.querySelector('input[name="size"]:checked');

    let isValid = true;

    // Valida nome
    if(name.length < 2) {
        showError(nameInput, document.getElementById('nameError'), 'Nome deve ter pelo menos 2 caracteres');
        isValid = false;
    }

    // Valida raça
    if(breed.length < 2) {
        showError(breedInput, document.getElementById('breedError'), 'Raça deve ter pelo menos 2 caracteres');
        isValid = false;
    }

    // Valida porte
    if(!sizeSelected) {
        showError(null, document.getElementById('sizeError'), 'Selecione o porte do cão');
        isValid = false;
    } else {
        document.getElementById('sizeError').classList.remove('show');
    }

    // Valida ID do dono
    if(!ownerId || ownerId < 1) {
        showError(ownerIdInput, document.getElementById('ownerError'), 'ID do dono deve ser um número válido');
        isValid = false;
    }

    if(isValid) {
        this.submit();
    } else {
        showAlert('Por favor, corrija os erros no formulário', 'error');
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

// Verifica mensagem de sucesso/erro do servidor
function checkServerMessages() {
    const alertBox = document.getElementById('alertBox');
    
    // O dataset converte o atributo data-success para a propriedade success
    if (alertBox.dataset.success === "true") {
        showAlert('Cão cadastrado com sucesso!', 'success');
    } else if (alertBox.dataset.error === "true") {
        showAlert('Erro ao cadastrar cão. Tente novamente.', 'error');
    }
}
document.addEventListener('DOMContentLoaded', checkServerMessages);
