function TRy = TRotationY( theta )
%TRy = TRotationY( theta ) Summary of this function goes here
%   Detailed explanation goes here

TRy = [ RotationY(theta), zeros(3,1) ; zeros(1,3) , 1];

end

