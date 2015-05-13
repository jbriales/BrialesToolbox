function Rz = RotationZ( theta )
%Rz = RotationZ( theta ) Summary of this function goes here
%   Detailed explanation goes here

s=sin(theta); c=cos(theta);

Rz = [c , -s, 0 ;
      s , c , 0 ;
      0 , 0 , 1 ];

end

