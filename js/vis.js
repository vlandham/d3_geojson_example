
$(document).ready(function() {
  console.log('ready');
  var width = 900;
  var height = 900;

  var projection = d3.geo.albersUsa().scale(1).translate([0,0]);
  var path = d3.geo.path().projection(projection);

  var vis = d3.select("#vis")
    .append("svg")
    .attr("width", width)
    .attr("height", height);

  d3.json("data/kc_tracts.json", function(json) {
    console.log("loaded geojson");
    var bounds = path.bounds(json);
    var s = 0.95 / Math.max((bounds[1][0] - bounds[0][0]) / width, (bounds[1][1] - bounds[0][1]) / height);
    var t = [(width - s * (bounds[1][0] + bounds[0][0])) / 2, (height - s * (bounds[1][1] + bounds[0][1])) / 2];

    projection
      .scale(s)
      .translate(t);

    vis.append("g")
      .attr("class", "tracts")
    .selectAll("path")
      .data(json.features)
      .enter().append("path")
        .attr("d", path)
        .attr("fill-opacity", 0.8)
        .attr("stroke", "#222")
        .attr("fill", function(d) { return (d.properties["STATEFP10"] == "20") ? "#B5D9B9" :  "#85C3C0"; });

  });
});
