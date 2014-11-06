class LayerAdder extends Backbone.View
  className : 'layer-adder'
  events :
    "change .layer-add" : "layerAdd"
  render : (category, breakLine) =>
    @category = category
    @$el.append "<label><input type='checkbox' class='layer-add'/>#{@circle(category.color)} #{category.label}</label>"
    @$el.css('margin-top','1em') if breakLine
    @
  layerAdd : (e) =>
    layer = layersByName[@category.name]
    if $(e.target).prop('checked')
      map.addLayer(layer)
    else
      map.removeLayer(layer)
  circle : (color) ->
    "<svg height='1em' width='1em'><circle cx='0.5em' cy='0.5em' r='0.4em' stroke-width='1px' stroke='black' fill='#{color}' /></svg>"

onEachFeature = (feature, layer)->
  if feature.properties.comment.length
    layer.bindPopup("<h4>#{humanReadableNames[feature.properties.name]}</h4><p>#{feature.properties.comment}</p>")

makeStyle = (category)->
  color = category.color
  if category.type == 'line'
    return -> (
      color: color
      weight: 2
    )
  return (feature) -> (
    radius: 5
    fillColor: color
    color: "#000"
    weight: if feature.properties.comment.length then 2 else 1
    opacity: 1
    fillOpacity: 1
  )

window.initLayers = (layersByName, categories, features)->
  window.humanReadableNames = {}
  lastGroup = categories[0].group
  for c in categories
    breakLine = lastGroup != c.group
    lastGroup = c.group
    $('.layer-adders').append(new LayerAdder().render(c, breakLine).el)
    humanReadableNames[c.name] = c.label
  for f in features
    name = f.properties.name
    if name of layersByName
      layersByName[name].addData f
    else
      category = _.filter(categories, (x)->x.name == name)[0]
      layersByName[name] = L.geoJson(f,
        onEachFeature: onEachFeature
        style : makeStyle(category)
        pointToLayer : (feature, latlng) -> L.circleMarker(latlng)
      )
