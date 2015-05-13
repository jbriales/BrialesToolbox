function RZ=rotZ(theta)

s=sin(theta); c=cos(theta);

RZ=[c,-s,0,0;s,c,0,0;0,0,1,0;0,0,0,1];