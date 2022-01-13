const Chart = require('/usr/share/nodejs/chart.js')
const data = JSON.parse(document.getElementById('data').textContent)

const chartColors = [
  '#DB7F7E',
  '#9E6363',
  '#83D9D9',
  '#69A0A0',
  '#ACD980',
  '#82A067',
  '#AB7DDA'
]

for (const entry of data) {
  // eslint-disable-next-line no-new
  new Chart(document.getElementById(`canvas-${entry.id}`), {
    type: 'bar',
    data: {
      labels: entry.labels,
      datasets: entry.datasets.map((dataset, index) => {
        return Object.assign({
          backgroundColor:
            Chart.helpers.color(chartColors[index]).alpha(0.8).rgbString(),
          borderColor: chartColors[index],
          borderWidth: 1
        }, dataset)
      })
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
