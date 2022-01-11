const Chart = require('/usr/share/nodejs/chart.js')
const data = JSON.parse(document.getElementById('data').textContent)

// From Chart.js samples
const chartColors = [
  'rgb(255, 99, 132)',
  'rgb(255, 159, 64)',
  'rgb(255, 205, 86)',
  'rgb(75, 192, 192)',
  'rgb(54, 162, 235)',
  'rgb(153, 102, 255)',
  'rgb(201, 203, 207)'
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
