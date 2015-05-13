function Rout = R_cam_2Conventional( Rin )
% Rout = Blender2Conventional_R_cam( Rin )
% Convert camera coordinate system from Blender to conventional:
%   Blender: image in XY plane (X right, Y up), Z backwards
%   Conventional: image in XY plane (X right, Y down), Z forwards

Rout = Rin * diag([+1 -1 -1]);