// Busca em tempo real
const searchInput = document.getElementById('searchInput');
const table = document.getElementById('clientTable');

if(searchInput && table) {
    searchInput.addEventListener('input', function() {
        const searchTerm = this.value.toLowerCase();
        const rows = table.getElementsByTagName('tbody')[0].getElementsByTagName('tr');

        for(let row of rows) {
            const cells = row.getElementsByTagName('td');
            let found = false;

            for(let cell of cells) {
                if(cell.textContent.toLowerCase().includes(searchTerm)) {
                    found = true;
                    break;
                }
            }

            row.style.display = found ? '' : 'none';
        }
    });
}