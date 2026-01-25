const clientInput = document.getElementById('client_id');
const dogInput = document.getElementById('dog_id');
const dateInput = document.getElementById('date');

// Definir data mínima como hoje
const today = new Date().toISOString().split('T')[0];
dateInput.setAttribute('min', today);

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

clientInput.addEventListener('blur', function() {
    const clientError = document.getElementById('clientError');
    if(!this.value || this.value < 1) {
        showError(this, clientError, 'ID do cliente deve ser um número válido');
    } else {
        showSuccess(this, clientError);
    }
});

dogInput.addEventListener('blur', function() {
    const dogError = document.getElementById('dogError');
    if(!this.value || this.value < 1) {
        showError(this, dogError, 'ID do cão deve ser um número válido');
    } else {
        showSuccess(this, dogError);
    }
});

dateInput.addEventListener('blur', function() {
    const dateError = document.getElementById('dateError');
    const selectedDate = new Date(this.value);
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    if(!this.value) {
        showError(this, dateError, 'Por favor, selecione uma data');
    } else if(selectedDate < today) {
        showError(this, dateError, 'A data não pode ser no passado');
    } else {
        showSuccess(this, dateError);
    }
});

// Validação no submit
document.getElementById('schedulingForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const clientId = clientInput.value;
    const dogId = dogInput.value;
    const date = dateInput.value;
    const selectedServices = document.querySelectorAll('input[name="services_id"]:checked');

    let isValid = true;

    // Valida cliente
    if(!clientId || clientId < 1) {
        showError(clientInput, document.getElementById('clientError'), 'ID do cliente deve ser um número válido');
        isValid = false;
    }

    // Valida cão
    if(!dogId || dogId < 1) {
        showError(dogInput, document.getElementById('dogError'), 'ID do cão deve ser um número válido');
        isValid = false;
    }

    // Valida data
    const selectedDate = new Date(date);
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    if(!date) {
        showError(dateInput, document.getElementById('dateError'), 'Por favor, selecione uma data');
        isValid = false;
    } else if(selectedDate < today) {
        showError(dateInput, document.getElementById('dateError'), 'A data não pode ser no passado');
        isValid = false;
    }

    // Valida serviços
    if(selectedServices.length === 0) {
        showError(null, document.getElementById('servicesError'), 'Selecione pelo menos um serviço');
        isValid = false;
    } else {
        document.getElementById('servicesError').classList.remove('show');
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