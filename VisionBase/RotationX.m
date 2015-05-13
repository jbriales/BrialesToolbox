function Rx = RotationX( theta )
%Rx = RotationX( theta ) Summary of this function goes here
%   Detailed explanation goes here

s=sin(theta); c=cos(theta);

Rx = [1 , 0 , 0 ;
      0 , c , -s;
      0 , s , c ];

end

