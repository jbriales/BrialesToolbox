function TRz = TRotationZ( theta )
%TRz = TRotationZ( theta ) Summary of this function goes here
%   Detailed explanation goes here

TRz = [ RotationZ(theta), zeros(3,1) ; zeros(1,3) , 1];

end
