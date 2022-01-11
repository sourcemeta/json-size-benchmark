const Chart = require('/usr/share/nodejs/chart.js')
const data = JSON.parse(document.getElementById('data').textContent)

for (const entry of data) {
  // eslint-disable-next-line no-new
  new Chart(document.getElementById(`canvas-${entry.id}`), {
    type: 'bar',
    data: {
      labels: entry.labels,
      datasets: entry.datasets
    },
    options: {
      responsive: true,
      legend: {
        position: 'top'
      },
      scales: {
        xAxes: [
          {
            ticks: {
              minRotation: 90,
              maxRotation: 90
            }
          }
        ],
        yAxes: [
          {
            ticks: {
              beginAtZero: true
            }
          }
        ]
      }
    }
  })
}
