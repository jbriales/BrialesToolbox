function TRx = TRotationX( theta )
%Rx = RotationX( theta ) Summary of this function goes here
%   Detailed explanation goes here

TRx = [ RotationX(theta), zeros(3,1) ; zeros(1,3) , 1];

end

