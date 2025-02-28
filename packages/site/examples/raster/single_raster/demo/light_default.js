// https://gw.alipayobjects.com/zos/antvdemo/assets/2019_clip/ndvi_201905.tif
import { RasterLayer, Scene } from '@antv/l7';
import { GaodeMap } from '@antv/l7-maps';
import * as GeoTIFF from 'geotiff';
const scene = new Scene({
  id: 'map',
  map: new GaodeMap({
    style: 'dark',
    center: [105, 37.5],
    zoom: 2.5,
  }),
});
scene.on('loaded', () => {
  addLayer();
});
async function getTiffData() {
  const response = await fetch(
    'https://gw.alipayobjects.com/zos/antvdemo/assets/light_clip/lightF182013.tiff',
  );
  const arrayBuffer = await response.arrayBuffer();
  const tiff = await GeoTIFF.fromArrayBuffer(arrayBuffer);
  const image = await tiff.getImage();
  const width = image.getWidth();
  const height = image.getHeight();
  const values = await image.readRasters();
  return {
    data: values[0],
    width,
    height,
  };
}

async function addLayer() {
  const tiffdata = await getTiffData();

  const layer = new RasterLayer({});
  layer
    .source(tiffdata.data, {
      parser: {
        type: 'raster',
        width: tiffdata.width,
        height: tiffdata.height,
        extent: [
          73.4821902409999979, 3.8150178409999995, 135.1066187319999869,
          57.6300459959999998,
        ],
      },
    })
    .style({
      clampLow: false,
      clampHigh: false,
      domain: [0, 90],
      noDataValue: 0,
      rampColors: {
        positions: [0, 0.05, 0.1, 0.25, 0.5, 1.0], // 数据需要换成 0-1
        colors: [
          'rgba(92,58,16,0)',
          'rgba(92,58,16,0)',
          '#fabd08',
          '#f1e93f',
          '#f1ff8f',
          '#fcfff7',
        ],
      },
    });

  scene.addLayer(layer);
}
