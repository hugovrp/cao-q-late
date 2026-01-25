const loginForm = document.getElementById('loginForm');
const loginInput = document.getElementById('login');
const passwordInput = document.getElementById('password');
const loginError = document.getElementById('loginError');
const passwordError = document.getElementById('passwordError');
const alertBox = document.getElementById('alertBox');
const hashedPasswordInput = document.getElementById('hashedPassword');

// Função para hash 
async function hashPassword(password) {
    const encoder = new TextEncoder();
    const data = encoder.encode(password);
    const hashBuffer = await crypto.subtle.digest('SHA-256', data);
    const hashArray = Array.from(new Uint8Array(hashBuffer));
    const hashHex = hashArray.map(b => b.toString(16).padStart(2, '0')).join('');
    return hashHex;
}

// Validação em tempo real
loginInput.addEventListener('input', function() {
    if(this.value.trim() !== '') {
        this.classList.remove('error');
        this.classList.add('success');
        loginError.classList.remove('show');
    }
});

passwordInput.addEventListener('input', function() {
    if(this.value.length >= 4) {
        this.classList.remove('error');
        this.classList.add('success');
        passwordError.classList.remove('show');
    }
});

// Validação no submit
loginForm.addEventListener('submit', async function(e) {
    e.preventDefault();
    
    let isValid = true;
    
    // Valida login
    if(loginInput.value.trim() === '') {
        loginInput.classList.add('error');
        loginError.classList.add('show');
        isValid = false;
    } else {
        loginInput.classList.remove('error');
        loginError.classList.remove('show');
    }
    
    // Valida senha
    if(passwordInput.value === '') {
        passwordInput.classList.add('error');
        passwordError.querySelector('span').textContent = 'Por favor, insira sua senha';
        passwordError.classList.add('show');
        isValid = false;
    } else if(passwordInput.value.length < 4) {
        passwordInput.classList.add('error');
        passwordError.querySelector('span').textContent = 'A senha deve ter pelo menos 4 caracteres';
        passwordError.classList.add('show');
        isValid = false;
    } else {
        passwordInput.classList.remove('error');
        passwordError.classList.remove('show');
    }
    
    if(isValid) {
        try {
            // Gera hash da senha
            const hash = await hashPassword(passwordInput.value);
            hashedPasswordInput.value = hash;
            
            // Limpa a senha original antes de enviar
            passwordInput.value = '';
            
            // Envia o formulário
            this.submit();
        } catch(error) {
            showAlert('Erro ao processar login. Tente novamente.', 'error');
        }
    }
});

function showAlert(message, type) {
    alertBox.textContent = (type === 'error' ? '❌ ' : '✅ ') + message;
    alertBox.className = 'alert ' + type + ' show';
    
    setTimeout(() => {
        alertBox.classList.remove('show');
    }, 5000);
}

window.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    
    if (urlParams.get('error') === 'invalid') {
        showAlert('Login ou senha incorretos!', 'error');
        
        window.history.replaceState({}, document.title, window.location.pathname);
    }
});