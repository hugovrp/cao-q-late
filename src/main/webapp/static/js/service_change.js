const priceInput = document.getElementById('price');
	
// Converte ponto para vírgula na inicialização
window.addEventListener('DOMContentLoaded', function() {
    priceInput.value = priceInput.value.replace('.', ',');
});

// Máscara de preço (formato brasileiro)
priceInput.addEventListener('input', function(e) {
    let value = e.target.value.replace(/\D/g, '');
    
    if(value.length === 0) {
        e.target.value = '';
        return;
    }
    
    value = value.padStart(3, '0');
    const intPart = value.slice(0, -2);
    const decPart = value.slice(-2);
    const cleanIntPart = intPart.replace(/^0+/, '') || '0';
    
    e.target.value = cleanIntPart + ',' + decPart;
});

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

function parsePrice(priceStr) {
    return parseFloat(priceStr.replace(',', '.'));
}

// Validação em tempo real
priceInput.addEventListener('blur', function() {
    const priceError = document.getElementById('priceError');
    const price = parsePrice(this.value);
    
    if(isNaN(price) || price <= 0) {
        showError(this, priceError, 'Preço deve ser maior que R$ 0,00');
    } else if(price > 9999.99) {
        showError(this, priceError, 'Preço máximo: R$ 9.999,99');
    } else {
        showSuccess(this, priceError);
    }
});

// Validação no submit
document.getElementById('changeForm').addEventListener('submit', function(e) {
    e.preventDefault();

    const priceStr = priceInput.value;
    const price = parsePrice(priceStr);

    let isValid = true;

    if(isNaN(price) || price <= 0) {
        showError(priceInput, document.getElementById('priceError'), 'Preço deve ser maior que R$ 0,00');
        isValid = false;
    } else if(price > 9999.99) {
        showError(priceInput, document.getElementById('priceError'), 'Preço máximo: R$ 9.999,99');
        isValid = false;
    }

    if(isValid) {
        // Converte vírgula para ponto antes de enviar
        const hiddenPrice = document.createElement('input');
        hiddenPrice.type = 'hidden';
        hiddenPrice.name = 'price';
        hiddenPrice.value = price.toString();
        
        priceInput.disabled = true;
        this.appendChild(hiddenPrice);
        
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