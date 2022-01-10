const Chart = require('chart.js/dist/chart.js')
const autocolors = require('chartjs-plugin-autocolors/dist/chartjs-plugin-autocolors.js')
const data = JSON.parse(document.getElementById('data').textContent)

Chart.register(autocolors)

for (const entry of data) {
  // eslint-disable-next-line no-new
  new Chart(document.getElementById(`canvas-${entry.id}`), {
    type: 'bar',
    data: {
      labels: entry.labels,
      datasets: entry.datasets
    },
    options: {
      scales: {
        // eslint-disable-next-line id-length
        x: {
          ticks: {
            minRotation: 90,
            maxRotation: 90
          }
        },
        // eslint-disable-next-line id-length
        y: {
          beginAtZero: true
        }
      }
    }
  })
}
