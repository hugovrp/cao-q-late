const cpfInput = document.getElementById('cpf');
const telephoneInput = document.getElementById('telephone');
const birthDateInput = document.getElementById('birth_date');

// Máscara CPF
cpfInput.addEventListener('input', function(e) {
    let value = e.target.value.replace(/\D/g, '');
    if(value.length <= 11) {
        value = value.replace(/(\d{3})(\d)/, '$1.$2');
        value = value.replace(/(\d{3})(\d)/, '$1.$2');
        value = value.replace(/(\d{3})(\d{1,2})$/, '$1-$2');
        e.target.value = value;
    }
});

// Máscara Telefone
telephoneInput.addEventListener('input', function(e) {
    let value = e.target.value.replace(/\D/g, '');
    if(value.length <= 11) {
        value = value.replace(/(\d{2})(\d)/, '($1) $2');
        value = value.replace(/(\d{5})(\d)/, '$1-$2');
        e.target.value = value;
    }
});

// Máscara Data
birthDateInput.addEventListener('input', function(e) {
    let value = e.target.value.replace(/\D/g, '');
    if(value.length <= 8) {
        value = value.replace(/(\d{2})(\d)/, '$1/$2');
        value = value.replace(/(\d{2})(\d)/, '$1/$2');
        e.target.value = value;
    }
});

// Validações
function validateCPF(cpf) {
    cpf = cpf.replace(/\D/g, '');
    if(cpf.length !== 11 || /^(\d)\1{10}$/.test(cpf)) return false;

    let sum = 0;
    for(let i = 0; i < 9; i++) {
        sum += parseInt(cpf.charAt(i)) * (10 - i);
    }
    let digit1 = 11 - (sum % 11);
    if(digit1 >= 10) digit1 = 0;

    sum = 0;
    for(let i = 0; i < 10; i++) {
        sum += parseInt(cpf.charAt(i)) * (11 - i);
    }
    let digit2 = 11 - (sum % 11);
    if(digit2 >= 10) digit2 = 0;

    return (parseInt(cpf.charAt(9)) === digit1 && parseInt(cpf.charAt(10)) === digit2);
}

function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}

function validateDate(date) {
    const parts = date.split('/');
    if(parts.length !== 3) return false;

    const day = parseInt(parts[0], 10);
    const month = parseInt(parts[1], 10);
    const year = parseInt(parts[2], 10);

    if(year < 1900 || year > new Date().getFullYear()) return false;
    if(month < 1 || month > 12) return false;
    if(day < 1 || day > 31) return false;

    const dateObj = new Date(year, month - 1, day);
    return dateObj.getDate() === day && dateObj.getMonth() === month - 1 && dateObj.getFullYear() === year;
}

function validatePhone(phone) {
    const cleaned = phone.replace(/\D/g, '');
    return cleaned.length === 10 || cleaned.length === 11;
}

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

// Validações
cpfInput.addEventListener('blur', function() {
    const cpfError = document.getElementById('cpfError');
    if(!validateCPF(this.value)) {
        showError(this, cpfError, 'CPF inválido');
    } else {
        showSuccess(this, cpfError);
    }
});

document.getElementById('name').addEventListener('blur', function() {
    const nameError = document.getElementById('nameError');
    if(this.value.trim().length < 3) {
        showError(this, nameError, 'Nome deve ter pelo menos 3 caracteres');
    } else {
        showSuccess(this, nameError);
    }
});

document.getElementById('email').addEventListener('blur', function() {
    const emailError = document.getElementById('emailError');
    if(!validateEmail(this.value)) {
        showError(this, emailError, 'E-mail inválido');
    } else {
        showSuccess(this, emailError);
    }
});

telephoneInput.addEventListener('blur', function() {
    const telephoneError = document.getElementById('telephoneError');
    if(!validatePhone(this.value)) {
        showError(this, telephoneError, 'Telefone deve ter 10 ou 11 dígitos');
    } else {
        showSuccess(this, telephoneError);
    }
});

birthDateInput.addEventListener('blur', function() {
    const birthDateError = document.getElementById('birthDateError');
    if(!validateDate(this.value)) {
        showError(this, birthDateError, 'Data inválida. Use DD/MM/AAAA');
    } else {
        showSuccess(this, birthDateError);
    }
});

// Validação no submit
document.getElementById('clientForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const cpf = cpfInput.value;
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const telephone = telephoneInput.value;
    const birthDate = birthDateInput.value;

    let isValid = true;

    if(!validateCPF(cpf)) {
        showError(cpfInput, document.getElementById('cpfError'), 'CPF inválido');
        isValid = false;
    }

    if(name.trim().length < 3) {
        showError(document.getElementById('name'), document.getElementById('nameError'), 'Nome deve ter pelo menos 3 caracteres');
        isValid = false;
    }

    if(!validateEmail(email)) {
        showError(document.getElementById('email'), document.getElementById('emailError'), 'E-mail inválido');
        isValid = false;
    }

    if(!validatePhone(telephone)) {
        showError(telephoneInput, document.getElementById('telephoneError'), 'Telefone inválido');
        isValid = false;
    }

    if(!validateDate(birthDate)) {
        showError(birthDateInput, document.getElementById('birthDateError'), 'Data inválida');
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
        showAlert('Cliente cadastrado com sucesso!', 'success');
    } else if (alertBox.dataset.error === "true") {
        showAlert('Erro ao cadastrar cliente. Tente novamente.', 'error');
    }
}

document.addEventListener('DOMContentLoaded', checkServerMessages);