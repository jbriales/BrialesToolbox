function RY=rotY(theta)

s=sin(theta); c=cos(theta);

RY=[c,0,s,0;0,1,0,0;-s,0,c,0;0,0,0,1];