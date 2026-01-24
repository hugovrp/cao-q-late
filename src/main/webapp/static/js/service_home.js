const searchInput = document.getElementById('searchInput');
const table = document.getElementById('serviceTable');

if(searchInput && table) {
    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

        for(let row of rows) {
            const serviceName = row.getElementsByTagName('td')[0].textContent.toLowerCase();
            row.style.display = serviceName.includes(searchTerm) ? '' : 'none';
        }
    });
}