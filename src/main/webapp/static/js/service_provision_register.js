function selectRow(row, schedulingId) {
    // Remove seleção de todas as linhas
    const allRows = document.querySelectorAll('tbody tr');
    allRows.forEach(r => r.classList.remove('selected'));

    // Adiciona seleção na linha clicada
    row.classList.add('selected');

    // Marca o radio button
    document.getElementById('scheduling_' + schedulingId).checked = true;
}

// Validação do formulário
document.getElementById('provisionForm')?.addEventListener('submit', function(e) {
    const selectedRadio = document.querySelector('input[name="scheduling_id"]:checked');
    
    if(!selectedRadio) {
        e.preventDefault();
        alert('Por favor, selecione um agendamento.');
    }
});