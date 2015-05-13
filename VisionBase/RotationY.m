function Ry = RotationY( theta )
%Ry = RotationY( theta ) Summary of this function goes here
%   Detailed explanation goes here

s=sin(theta); c=cos(theta);

Ry = [c , 0 , s ;
      0 , 1 , 0;
      -s, 0 , c ];

end

