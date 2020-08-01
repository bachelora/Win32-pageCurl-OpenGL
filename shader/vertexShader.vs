#version 330 core
layout (location = 0) in vec2 aPos;
layout (location = 1) in vec2 aTexCoord;

uniform vec4 m_n;
uniform vec3 direction;
uniform vec2 point;

uniform mat4 model;
uniform mat4 projection;
uniform mat4 view;


out vec2 texcoord; 

#define PI  3.141592653589793238462643383279502884197169399


void main()
{
   int row = gl_InstanceID/(int(m_n.z));
   int col = gl_InstanceID%(int(m_n.z));
   texcoord = vec2(aTexCoord.x + col/m_n.z,aTexCoord.y + row/m_n.w);
   vec3 pos = vec3(aPos.x + col * m_n.x,aPos.y + row * m_n.y,0);


   float distance = dot((point - pos.xy),direction.xy);

   if(distance > 0){
     vec2 bottom = pos.xy + distance * direction.xy;
     float moreThanHalfCir = (distance -  PI * direction.z);

      if(moreThanHalfCir >= 0){//exceed
        vec3 topPoint = vec3(bottom, 2 * direction.z);
        pos = topPoint + moreThanHalfCir * vec3(direction.xy,0);
      }else{

        float angle = PI - distance / (2*direction.z);
        float h = distance - sin(angle)*direction.z;
        float z = direction.z + cos(angle)*direction.z;
        vec3 vD = pos + h * vec3(direction.xy,0);
        pos = vec3(vD.xy,z);

      }
     
   }

   gl_Position =  projection * view * model * vec4(pos,1);
}
