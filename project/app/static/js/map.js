function initMap() {
  var crs = new L.Proj.CRS('EPSG:3067',
      '+proj=utm +zone=35 +ellps=GRS80 +towgs84=0,0,0,0,0,0,0 +units=m +no_defs',
      {
        resolutions  : [8192, 4096, 2048, 1024, 512, 256, 128, 64, 32, 16, 8, 4, 2, 1, 0.5, 0.25 ],
        origin  : [-548576.0,6291456.0]
      });
  var tileLayer = new L.tileLayer.wms("http://map.mapita.fi/gwc/service/wms", {
    layers: 'suomi_kartta',
    format: 'image/png',
    transparent: true,
    crs : crs,
    attribution: "Maastotietokanta, Maanmittauslaitos",
    continuousWorld: true,
    minZoom : 0,
    maxZoom : 13
  });
  var map = new L.map('map', {
    center : [60.188390615746805, 25.007457733154297],
    zoom : 9,
    crs: tileLayer.options.crs,
    continuousWorld: true,
    worldCopyJump: false
  });
  map.addLayer(tileLayer);
  return map;
}
