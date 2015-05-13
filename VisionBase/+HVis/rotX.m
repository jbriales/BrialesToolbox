function RX=rotX(theta)

s=sin(theta); c=cos(theta);

RX=[1,0,0,0;0,c,-s,0;0,s,c,0;0,0,0,1];