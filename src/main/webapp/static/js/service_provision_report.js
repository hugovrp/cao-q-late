// Validação de datas
const startDateInput = document.getElementById('start_date');
const endDateInput = document.getElementById('end_date');

endDateInput.addEventListener('change', function() {
    const startDate = new Date(startDateInput.value);
    const endDate = new Date(this.value);

    if(endDate < startDate) {
        alert('A data final não pode ser anterior à data inicial!');
        this.value = startDateInput.value;
    }
});

document.getElementById('reportForm').addEventListener('submit', function(e) {
    const startDate = startDateInput.value;
    const endDate = endDateInput.value;

    if(!startDate || !endDate) {
        e.preventDefault();
        alert('Por favor, preencha ambas as datas.');
    }
});