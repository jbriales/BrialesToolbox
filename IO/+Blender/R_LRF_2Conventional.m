function Rout = R_LRF_2Conventional( Rin )
% Rout = Blender2Conventional_R_cam( Rin )
% Convert camera coordinate system from Blender to conventional:
%   Blensor: scan in XZ plane (X right, Z backwards), Y normal up
%   Conventional: scan in XY plane (X forwards, Y left), Z normal up

R_s_b = [ 0 0 -1
         -1 0  0
          0 1  0 ];
Rout = Rin * R_s_b';