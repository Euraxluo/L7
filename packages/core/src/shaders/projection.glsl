#define TILE_SIZE 512.0
#define PI 3.1415926536
#define WORLD_SCALE TILE_SIZE / (PI * 2.0)

#define COORDINATE_SYSTEM_LNGLAT 1.0
#define COORDINATE_SYSTEM_LNGLAT_OFFSET 2.0
#define COORDINATE_SYSTEM_VECTOR_TILE 3.0
#define COORDINATE_SYSTEM_IDENTITY 4.0
#define COORDINATE_SYSTEM_P20 5.0
#define COORDINATE_SYSTEM_P20_OFFSET 6.0
#define COORDINATE_SYSTEM_METER_OFFSET 7.0

#define COORDINATE_SYSTEM_P20_2 8.0

uniform mat4 u_ViewMatrix;
uniform mat4 u_ProjectionMatrix;
uniform mat4 u_ViewProjectionMatrix;
uniform float u_Zoom : 1;
uniform float u_ZoomScale : 1;

uniform float u_CoordinateSystem;
uniform vec2 u_ViewportCenter;
uniform vec4 u_ViewportCenterProjection;
uniform vec3 u_PixelsPerDegree;
uniform vec3 u_PixelsPerDegree2;
uniform vec3 u_PixelsPerMeter;

uniform vec2 u_ViewportSize;
uniform float u_DevicePixelRatio;
uniform float u_FocalDistance;
uniform vec3 u_CameraPosition;

// uniform mat4 u_Mvp;

// web mercator coords -> world coords
vec2 project_mercator(vec2 lnglat) {
  float x = lnglat.x;
  return vec2(
    radians(x) + PI,
    PI - log(tan(PI * 0.25 + radians(lnglat.y) * 0.5))
  );
}

float project_scale(float meters) {
  return meters * u_PixelsPerMeter.z;
}


// offset coords -> world coords
vec4 project_offset(vec4 offset) {
  float dy = offset.y;
  dy = clamp(dy, -1., 1.);
  vec3 pixels_per_unit = u_PixelsPerDegree + u_PixelsPerDegree2 * dy;
  return vec4(offset.xyz * pixels_per_unit, offset.w);
}

vec3 project_normal(vec3 normal) {
  vec4 normal_modelspace = u_ModelMatrix * vec4(normal, 0.0);
  return normalize(normal_modelspace.xyz * u_PixelsPerMeter);
}

vec3 project_offset_normal(vec3 vector) {
  if (u_CoordinateSystem < COORDINATE_SYSTEM_LNGLAT + 0.01 && u_CoordinateSystem >COORDINATE_SYSTEM_LNGLAT - 0.01
    || u_CoordinateSystem == COORDINATE_SYSTEM_LNGLAT_OFFSET) {
    // normals generated by the polygon tesselator are in lnglat offsets instead of meters
    return normalize(vector * u_PixelsPerDegree);
  }
  return project_normal(vector);
}
// || u_CoordinateSystem < COORDINATE_SYSTEM_P20_OFFSET + 0.01 && u_CoordinateSystem >COORDINATE_SYSTEM_P20_OFFSET - 0.01
// reverse Y
vec3 reverse_offset_normal(vec3 vector) {
  if (u_CoordinateSystem == COORDINATE_SYSTEM_P20 ||u_CoordinateSystem == COORDINATE_SYSTEM_P20_OFFSET ) {
    return vector * vec3(1.0, -1.0, 1.0);
  }

  if (u_CoordinateSystem == COORDINATE_SYSTEM_P20_2) { // gaode2.0
    return vector;
  }
  return vector;
}

vec4 project_position(vec4 position) {
  float a = COORDINATE_SYSTEM_LNGLAT_OFFSET;
  float b = COORDINATE_SYSTEM_P20_OFFSET;
  float c = COORDINATE_SYSTEM_LNGLAT;
  if (u_CoordinateSystem == COORDINATE_SYSTEM_LNGLAT_OFFSET
    || u_CoordinateSystem == COORDINATE_SYSTEM_P20_OFFSET) {
    float X = position.x - u_ViewportCenter.x;
    float Y = position.y - u_ViewportCenter.y;
    return project_offset(vec4(X, Y, position.z, position.w));
  }
  if (u_CoordinateSystem < COORDINATE_SYSTEM_LNGLAT + 0.01 && u_CoordinateSystem >COORDINATE_SYSTEM_LNGLAT - 0.01) {
    return vec4(
      project_mercator(position.xy) * WORLD_SCALE * u_ZoomScale,
      project_scale(position.z),
      position.w
    );
  }

  if (u_CoordinateSystem == COORDINATE_SYSTEM_P20) {
    return vec4(
      (project_mercator(position.xy) * WORLD_SCALE * u_ZoomScale - vec2(215440491., 106744817.)) * vec2(1., -1.),
      project_scale(position.z),
      position.w
    );
  }

  if(u_CoordinateSystem == COORDINATE_SYSTEM_P20_2) {
    // return vec4(
    //   (position.xy * WORLD_SCALE * u_ZoomScale) * vec2(1., -1.), 
    //   project_scale(position.z), 
    //   position.w);

     return vec4(
      position.xy, 
      project_scale(position.z), 
      position.w);
  }
  return position;

  // TODO: 瓦片坐标系 & 常规世界坐标系
}
vec2 project_pixel_size_to_clipspace(vec2 pixels) {
  vec2 offset = pixels / u_ViewportSize * u_DevicePixelRatio * 2.0;
  return offset * u_FocalDistance;
}

float project_pixel_allmap(float pixel) {
  if(u_CoordinateSystem == COORDINATE_SYSTEM_LNGLAT) {
    return pixel * pow(2.0, u_Zoom);
  }
  return pixel;
}

// 适配纹理贴图的等像素大小
float project_pixel_texture(float pixel) {
  // mapbox zoom > 12
  if(u_CoordinateSystem == COORDINATE_SYSTEM_LNGLAT_OFFSET) {
    return pixel * pow(0.5, u_Zoom);
  }

  // amap2 zoom > 12
  if(u_CoordinateSystem == COORDINATE_SYSTEM_P20_2) {
    return pixel * pow(2.0, (19.0 - 3.0 - u_Zoom));
  }

  // amap zoom > 12
  if (u_CoordinateSystem == COORDINATE_SYSTEM_P20_OFFSET) {
    return pixel * pow(0.5, u_Zoom);
  }
  
  // amap zoom < 12
  if (u_CoordinateSystem == COORDINATE_SYSTEM_P20) {
    return pixel * pow(2.0, (20.0 - u_Zoom));
  }
  return pixel * 2.0;
}

// 在不论什么底图下需要统一处理的时候使用
float project_float_pixel(float pixel) {
  if (u_CoordinateSystem == COORDINATE_SYSTEM_LNGLAT || u_CoordinateSystem == COORDINATE_SYSTEM_LNGLAT_OFFSET) {
    // mapbox P20 坐标系下，为了和 Web 墨卡托坐标系统一，zoom 默认减1
    return pixel * pow(2.0, (19.0 - u_Zoom));
  }
  if (u_CoordinateSystem == COORDINATE_SYSTEM_P20 || u_CoordinateSystem == COORDINATE_SYSTEM_P20_OFFSET) {
    // amap P20 坐标系下，为了和 Web 墨卡托坐标系统一，zoom 默认减1
    return pixel * pow(2.0, (19.0 - u_Zoom));
  }
  if(u_CoordinateSystem == COORDINATE_SYSTEM_P20_2) {
    // amap2 P20_2 坐标系下，为了和 Web 墨卡托坐标系统一，zoom 默认减3
    return pixel * pow(2.0, (19.0 - 3.0 - u_Zoom));
  }
  return pixel;
}

float project_pixel(float pixel) {
  if (u_CoordinateSystem == COORDINATE_SYSTEM_P20 || u_CoordinateSystem == COORDINATE_SYSTEM_P20_OFFSET) {
    // amap P20 坐标系下，为了和 Web 墨卡托坐标系统一，zoom 默认减1
    return pixel * pow(2.0, (19.0 - u_Zoom));
  }
  if(u_CoordinateSystem == COORDINATE_SYSTEM_P20_2) {
    // amap2 P20_2 坐标系下，为了和 Web 墨卡托坐标系统一，zoom 默认减3
    return pixel * pow(2.0, (19.0 - 3.0 - u_Zoom));
  }
  return pixel;
}
vec2 project_pixel(vec2 pixel) {
  if (u_CoordinateSystem == COORDINATE_SYSTEM_P20 || u_CoordinateSystem == COORDINATE_SYSTEM_P20_OFFSET) {
    // P20 坐标系下，为了和 Web 墨卡托坐标系统一，zoom 默认减1
    return pixel * pow(2.0, (19.0 - u_Zoom));
  }
  if(u_CoordinateSystem == COORDINATE_SYSTEM_P20_2) {
    // P20_2 坐标系下，为了和 Web 墨卡托坐标系统一，zoom 默认减3
    return pixel * pow(2.0, (19.0 - 3.0 - u_Zoom));
  }
  return pixel * -1.;
}

vec4 project_common_position_to_clipspace(vec4 position, mat4 viewProjectionMatrix, vec4 center) {
  if (u_CoordinateSystem == COORDINATE_SYSTEM_METER_OFFSET ||
    u_CoordinateSystem == COORDINATE_SYSTEM_LNGLAT_OFFSET) {
    // Needs to be divided with project_uCommonUnitsPerMeter
    position.w *= u_PixelsPerMeter.z;
  }

  return viewProjectionMatrix * position + center;
}

// Projects from common space coordinates to clip space
vec4 project_common_position_to_clipspace(vec4 position) {
  return project_common_position_to_clipspace(
    position,
    u_ViewProjectionMatrix,
    u_ViewportCenterProjection
  );
}

vec4 unproject_clipspace_to_position(vec4 clipspacePos, mat4 u_InverseViewProjectionMatrix) {
  vec4 pos = u_InverseViewProjectionMatrix * (clipspacePos - u_ViewportCenterProjection);

  if (u_CoordinateSystem == COORDINATE_SYSTEM_METER_OFFSET ||
    u_CoordinateSystem == COORDINATE_SYSTEM_LNGLAT_OFFSET) {
    // Needs to be divided with project_uCommonUnitsPerMeter
     pos.w = pos.w / u_PixelsPerMeter.z;
  }
  return pos;
}


bool isEqual( float a,  float b) {
    return  a< b + 0.001 && a > b - 0.001;
}