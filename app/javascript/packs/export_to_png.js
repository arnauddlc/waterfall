exportButton = document.getElementById("export_button");

exportButton.addEventListener("click", (e) => {
	let chart = document.getElementById("chart-d3");
	let title = chart.dataset.title;
	saveSvgAsPng(chart, `${title}.png`);
})
