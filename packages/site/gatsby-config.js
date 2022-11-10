module.exports = {
  plugins: [
    {
      resolve: '@antv/gatsby-theme-antv',
      options: {
        GATrackingId: 'UA-148148901-7',
      },
    },
  ],
  siteMetadata: {
    title: 'L7',
    isAntVSite: false,
    description:
      'Large-scale WebGL-powered Geospatial data visualization analysis framework',
    siteUrl: 'https://l7.antv.vision',
    githubUrl: 'https://github.com/antvis/L7',
    keywords:
      'l7, L7, antv/l7, 地理, 空间可视化, Webgl, webgl, 地图, webgis, 3d, GIS, gis, Mapbox, deckgl, g2, g6, antv,',
    showChartResize: true, // 是否在demo页展示图表视图切换
    showAPIDoc: true, // 是否在demo页展示API文档
    navs: [
      {
        slug: 'docs/tutorial/l7',
        title: {
          zh: '使用教程',
          en: 'Tutorial',
        },
        redirect: 'api/quickstart',
      },
      {
        slug: 'docs/api',
        title: {
          zh: 'API 文档',
          en: 'Document',
        },
        redirect: 'api/scene',
      },
      {
        slug: 'examples',
        title: {
          zh: '图表演示',
          en: 'Examples',
        },
      },
    ],
    ecosystems: [
      {
        name: {
          zh: 'L7 React 组件',
          en: 'L7 For React',
        },
        url: 'http://antv.vision/L7-react/',
      },
      {
        name: {
          zh: 'L7 Plot 图表',
          en: 'L7Plot',
        },
        url: 'https://l7plot.antv.vision/',
      },
      {
        name: {
          zh: 'L7 地理围栏绘制组件库',
          en: 'L7Draw',
        },
        url: 'http://antv.vision/L7Draw/',
      },
      {
        name: {
          zh: 'L7 行政区划可视化库',
          en: 'L7Boundary',
        },
        url: 'http://antv.vision/L7-boundary/',
      },
      {
        name: {
          zh: 'Dipper 地理可视分开发框架',
          en: 'Dipper',
        },
        url: 'http://antv.vision/Dipper',
      },
    ],
    docs: [
      // ****** tutorial
      // quickStart 0
      {
        slug: 'tutorial/l7',
        title: {
          zh: '简介',
          en: 'introduce',
        },
        order: 1,
      },
      {
        slug: 'tutorial/quickstart',
        title: {
          zh: '快速上手',
          en: 'quickStart',
        },
        order: 2,
      },
      // demo 1
      // data 2
      {
        slug: 'tutorial/map',
        title: {
          zh: '地图使用',
          en: 'Map Usage',
        },
        order: 3,
      },
      {
        slug: 'tutorial/interactive',
        title: {
          zh: '图层交互',
          en: 'Layer Interactive',
        },
        order: 4,
      },
      {
        slug: 'tutorial/demo',
        icon: 'map',
        title: {
          zh: '教程示例',
          en: 'Tutorial demo',
        },
        order: 5,
      },
      {
        slug: 'tutorial/point',
        icon: 'map',
        title: {
          zh: '点图层 PointLayer',
          en: 'PointLayer',
        },
        order: 6,
      },
      {
        slug: 'tutorial/line',
        icon: 'map',
        title: {
          zh: '线图层 LineLayer',
          en: 'LineLayer',
        },
        order: 7,
      },
      {
        slug: 'tutorial/polygon',
        icon: 'map',
        title: {
          zh: '面图层 PolygonLayer',
          en: 'PolygonLayer',
        },
        order: 8,
      },
      {
        slug: 'tutorial/heatmap',
        icon: 'map',
        title: {
          zh: '热力图层 HeatmapLayer',
          en: 'HeatmapLayer',
        },
        order: 9,
      },
      {
        slug: 'tutorial/tile',
        icon: 'map',
        title: {
          zh: '瓦片图层 TileLayer',
          en: 'TileLayer',
        },
        order: 10,
      },
      // ****** api
      {
        slug: 'api/base',
        title: {
          zh: '图层 BaseLayer',
          en: 'Layer',
        },
        order: 2,
      },
      {
        slug: 'api/source',
        title: {
          zh: '数据 Source',
          en: 'Source',
        },
        order: 3,
      },
      {
        slug: 'api/point_layer',
        title: {
          zh: '点图层 PointLayer',
          en: 'PointLayer',
        },
        order: 3,
      },
      {
        slug: 'api/line_layer',
        title: {
          zh: '线图层 LineLayer',
          en: 'LineLayer',
        },
        order: 4,
      },
      {
        slug: 'api/polygon_layer',
        title: {
          zh: '面图层 PolygonLayer',
          en: 'PolygonLayer',
        },
        order: 5,
      },
      {
        slug: 'api/heatmap_layer',
        title: {
          zh: '热力图层 HeatMapLayer',
          en: 'HeatMapLayer',
        },
        order: 6,
      },
      {
        slug: 'api/imageLayer',
        title: {
          zh: '图片图层 ImageLayer',
          en: 'ImageLayer',
        },
        order: 7,
      },
      {
        slug: 'api/raster',
        title: {
          zh: '栅格图层 RasterLayer',
          en: 'RasterLayer',
        },
        order: 8,
      },
      {
        slug: 'api/vectortile',
        title: {
          zh: '矢量瓦片 TileLayer',
          en: 'VectorTile',
        },
        order: 8,
      },
      {
        slug: 'api/rastertile',
        title: {
          zh: '栅格瓦片 TileLayer',
          en: 'rasterTile',
        },
        order: 8,
      },
      
      {
        slug: 'api/other',
        title: {
          zh: '其他图层 Other',
          en: 'Other Layers',
        },
        order: 10,
      },
      {
        slug: 'api/component',
        title: {
          zh: '组件 Component',
          en: 'Component',
        },
        order: 11,
      },
      {
        slug: 'api/component/control',
        title: {
          zh: '控件类型 Control',
          en: 'Control',
        },
        order: 1,
      },
      {
        slug: 'api/component/popup',
        title: {
          zh: '气泡类型 Popup',
          en: 'Popup',
        },
        order: 2,
      },
      {
        slug: 'api/component/marker',
        title: {
          zh: 'Marker 类型',
          en: 'Marker',
        },
        order: 3,
      },
      {
        slug: 'api/experiment/earth',
        title: {
          zh: '地球模式',
          en: 'Earth Mode',
        },
        order: 0,
      },
      // {
      //   slug: 'api/mini',
      //   title: {
      //     zh: '小程序',
      //     en: 'mini',
      //   },
      //   order: 9,
      // },
      // {
      //   slug: 'api/mini/demos',
      //   title: {
      //     zh: '案例集合',
      //     en: 'demos',
      //   },
      //   order: 14,
      // },
      {
        slug: 'api/experiment',
        title: {
          zh: '实验特性',
          en: 'experiment',
        },
        order: 12,
      },
    ],
    examples: [
      {
        slug: 'gallery',
        icon: 'gallery',
        title: {
          zh: '官方精品库',
          en: 'Featured',
        },
        order: 0,
      },
      {
        slug: 'point',
        icon: 'point',
        title: {
          zh: '点图层',
          en: 'Point Layer',
        },
        order: 1,
      },
      {
        slug: 'line',
        icon: 'line',
        title: {
          zh: '线图层',
          en: 'Line Layer',
        },
        order: 2,
      },
      {
        slug: 'polygon',
        icon: 'polygon',
        title: {
          zh: '面图层',
          en: 'Polygon Layer',
        },
        order: 3,
      },
      {
        slug: 'earth',
        icon: 'map',
        title: {
          zh: '地球模式',
          en: 'Earth Mode',
        },
        order: 4,
      },
      {
        slug: 'heatmap',
        icon: 'heatmap',
        title: {
          zh: '热力图',
          en: 'HeatMap Layer',
        },
        order: 6,
      },
      {
        slug: 'tile',
        icon: 'raster',
        title: {
          zh: '瓦片图层',
          en: 'Tile Layer',
        },
        order: 7,
      },
      {
        slug: 'raster',
        icon: 'raster',
        title: {
          zh: '栅格图层',
          en: 'Raster Layer',
        },
        order: 7,
      },
      {
        slug: 'wind',
        icon: 'raster',
        title: {
          zh: '风场图层',
          en: 'Wind Layer',
        },
        order: 7,
      },
      {
        slug: 'geometry',
        icon: 'raster',
        title: {
          zh: '几何体图层',
          en: 'Geometry Layer',
        },
        order: 7,
      },
      {
        slug: 'engine',
        icon: 'map',
        title: {
          zh: '第三方引擎',
          en: 'other engine',
        },
        order: 8,
      },
      {
        slug: 'component',
        icon: 'map',
        title: {
          zh: '组件',
          en: 'Component',
        },
        order: 9,
      },
      {
        slug: 'react',
        icon: 'map',
        title: {
          zh: 'React 组件',
          en: 'React Demo',
        },
        order: 9,
      },
      {
        slug: 'amapPlugin',
        icon: 'map',
        title: {
          zh: '高德地图插件',
          en: 'amapPlugin',
        },
        order: 10,
      },
      {
        slug: 'choropleth',
        icon: 'map',
        title: {
          zh: '行政区划 🌟',
          en: 'Choropleth',
        },
        order: 11,
      },
      {
        slug: 'draw',
        icon: 'map',
        title: {
          zh: '绘制组件',
          en: 'L7Draw',
        },
        order: 12,
      },
      {
        slug: 'tutorial',
        icon: 'map',
        title: {
          zh: '教程示例',
          en: 'Tutorial demo',
        },
      },
    ],
    playground: {
      container:
        '<div style="height: 100vh;justify-content: center; position: relative" id="map"/>',
      dependencies: {
        '@antv/l7': 'latest',
        '@antv/l7-maps': 'latest',
      },
    },
    mdPlayground: {
      // markdown 文档中的 playground 若干设置
      splitPaneMainSize: '50%',
    },
    docsearchOptions: {
      apiKey: '97db146dbe490416af81ef3a8923bcaa',
      indexName: 'antv_l7',
    },
  },
};
