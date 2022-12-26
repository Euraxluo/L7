---
title: Style
order: 4
---

<embed src="@/docs/common/style.md"></embed>

`style` 方法用于配制图层的样式，相同图层拥有不同的 `shape` 图形，不同 `shape` 的图层 `style` 方法接受不同的参数。

🌟 蜂窝热力图和网格热力图的 `style` 样式可以参考实际绘制的图层。

```js
layer.style({
  opacity: 0.5,
});
```

### common

通用 `style` 参数，所有图形都支持的参数。

| style   | 类型     | 描述         | 默认值 |
| ------- | -------- | ------------ | ------ |
| opacity | `number` | 图形的透明度 | `1`    |

### heatmap

`shape` 为 `heatmap`、`heatmap3D` 类型的时候，绘制经典热力图。

| style      | 类型     | 描述         | 默认值 |
| ---------- | -------- | ------------ | ------ |
| intensity  | `number` | 热力的强度   | `10`   |
| radius     | `number` | 热力点的半径 | `10`   |
| rampColors | `number` | 热力的色值   | `1`    |

#### rampColors

1. 连续色带，根据 `colors`  和 `positions` 设置色带。

- `colors`  颜色数组
- `positions` 数据区间

配置值域映射颜色的色带，值域的范围为 `[0 - 1]`, 对应的我们需要为每一个 `position` 位置设置一个颜色值。

⚠️ `colors`, `positions` 的长度要相同。

```javascript
layer.style({
  rampColors: {
    colors: ['#FF4818', '#F7B74A', '#FFF598', '#91EABC', '#2EA9A1', '#206C7C'],
    positions: [0, 0.2, 0.4, 0.6, 0.8, 1.0],
  },
});
```

2. 枚举色带
   枚举模式下色带不再是连续的，而是分段的，同时用户可以选择直接传入颜色或者指定具体的分布。

- 直接传入

```js
layer.style({
  rampColors: {
    c1: '#f00',
    c2: '#ff0',
  },
});
```

c1 和 c2 平均分布，前一半色带为 #f00，后一半为 #ff0。

- 指定具体的分布

```js
layer.style({
  rampColors: {
    c1: [0, 0.3 '#f00'],
    c2: [0.3, 1.0, '#ff0']
  },
});
```

c1 和 c2 三七分布，前三色带为 #f00，后七为 #ff0。

- 混合使用

```js
layer.style({
  rampColors: {
    c1: [0, 0.3 '#f00'],
    c2: '#0f0',
    c3: [0.7, 1.0, '#ff0']
  },
});
```

在混合使用的情况下，使用直接传入方式指定的色值会填满空隙，上面的分布 c1:c2:c3 为 3:4:3

- 默认色
  当用户仅指定部分色值分布或者使用错误的颜色值时，其余色值用默认色进行填充，可以动过 default 指定默认色，未指定时默认色为 #fff。

```js
layer.style({
  rampColors: {
    c1: [0, 0.3 '#f00'],
  },
});

// => 上面的写法在内部会被默认填充
layer.style({
  rampColors: {
    c1: [0, 0.3 '#f00'],
    defaultFill: '#fff' // 等价写法
  },
});

layer.style({
  rampColors: {
    default: '#ff0', // 指定默认填充色
    c1: [0, 0.3 '#f00'],
    defaultFill: '#ff0' // 等价写法
  },
});
```

### hexagon

绘制蜂窝热力图。

| style    | 类型     | 描述         | 默认值 |
| -------- | -------- | ------------ | ------ |
| angle    | `number` | 图形旋转角度 | `0`    |
| coverage | `number` | 图形覆盖比率 | `0.9`  |

### grid

绘制网格热力图。

| style    | 类型     | 描述         | 默认值 |
| -------- | -------- | ------------ | ------ |
| coverage | `number` | 图形覆盖比率 | `1`    |
