exportButton = document.getElementById("export_button");

exportButton.addEventListener("click", (e) => {
	console.log("Clicked!");
	let chart = document.getElementById("chart-d3");
	let title = chart.dataset.title;
	saveSvgAsPng(chart, `${title}.png`);
})