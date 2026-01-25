function updateDateTime() {
    const now = new Date();
    const options = { 
	    weekday: 'long', 
	    year: 'numeric', 
	    month: 'long', 
	    day: 'numeric',
	    hour: '2-digit',
	    minute: '2-digit'
    };
    document.getElementById('dateTime').textContent = now.toLocaleDateString('pt-BR', options);
}

updateDateTime();
setInterval(updateDateTime, 60000); // Atualiza a cada minuto