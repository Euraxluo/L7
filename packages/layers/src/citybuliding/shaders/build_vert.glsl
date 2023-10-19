#define ambientRatio 0.5
#define diffuseRatio 0.3
#define specularRatio 0.2

layout(location = 0) in vec3 a_Position;
layout(location = 1) in vec4 a_Color;
layout(location = 7) in vec3 a_Normal;
layout(location = 8) in float a_Size;
layout(location = 9) in vec2 a_Uv;

layout(std140) uniform ModelUniforms {
  vec4 u_baseColor;
  vec4 u_brightColor;
  vec4 u_windowColor;
  vec3 u_circleSweepColor;
  float u_cityMinSize;
  vec2 u_cityCenter;
  float u_circleSweep;
  float u_circleSweepSpeed;
  float u_opacity;
  float u_time;
};

out vec2 v_texCoord;
out vec4 v_Color;
out float v_worldDis;

#pragma include "projection"
#pragma include "light"
#pragma include "picking"

void main() {
  vec4 pos = vec4(a_Position.xy, a_Position.z * a_Size, 1.0);
  vec4 project_pos = project_position(pos);

   v_texCoord = a_Uv;

  if(u_circleSweep > 0.0) {
     vec2 lnglatscale = vec2(0.0);
    if(u_CoordinateSystem != COORDINATE_SYSTEM_P20_2) {
      lnglatscale = (a_Position.xy - u_cityCenter) * vec2(0.0, 0.135);
    }
    v_worldDis = length(a_Position.xy + lnglatscale - u_cityCenter);
  }
 
  if(u_CoordinateSystem == COORDINATE_SYSTEM_P20_2) { // gaode2.x
    gl_Position = u_Mvp * (vec4(project_pos.xyz, 1.0));
  } else {
    gl_Position = project_common_position_to_clipspace(vec4(project_pos.xyz, 1.0));
  }

  float lightWeight = calc_lighting(pos);
  // v_Color = a_Color;
  v_Color = vec4(a_Color.rgb * lightWeight, a_Color.w);

  setPickingColor(a_PickingColor);
}
