#version 330 core
out vec4 FragColor;

in vec2 texcoord; 

uniform sampler2D texture1;
uniform sampler2D texture2;

void main()
{
  if(gl_FrontFacing){
    FragColor = texture2D(texture1, texcoord);
  }else{
    FragColor =  texture2D(texture2, texcoord);
  }
  ;//vec4(0.85,0.5,0.51,0);//vec4(ourColor,0);
    //vec3(0.5,0.5,0.1);//
} 