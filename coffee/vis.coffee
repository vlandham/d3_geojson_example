
$ ->
  console.log('ready')

  width = 900
  height = 900

  projection = d3.geo.albersUsa().scale(1).translate([0,0])
  path = d3.geo.path().projection(projection)

  vis = d3.select("#vis")
    .append("svg")
    .attr("width", width)
    .attr("height", height)

  d3.json "data/kc_tracts.json", (json) ->
    console.log('loaded geojson')
    # code to automatically figure out projection scale and translation
    # from: http://bl.ocks.org/mbostock/4707858
    bounds = path.bounds(json)
    s = .95 / Math.max((bounds[1][0] - bounds[0][0]) / width, (bounds[1][1] - bounds[0][1]) / height)
    t = [(width - s * (bounds[1][0] + bounds[0][0])) / 2, (height - s * (bounds[1][1] + bounds[0][1])) / 2]

    projection
      .scale(s)
      .translate(t)

    vis.append("g")
      .attr("class", "tracts")
    .selectAll("path")
      .data(json.features)
    .enter().append("path")
      .attr("d", path)
      .attr("fill-opacity", 0.5)
      .attr("fill", (d) -> if d.properties["STATEFP10"] == "20" then "#B5D9B9" else "#85C3C0")
      .attr("stroke", "#222")

