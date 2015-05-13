function [R,t] = load_Rt_Cam( path, step )

name = sprintf('pose_cam_%d',step);
Rt = load( fullfile(path,name) );
R = Rt(1:3,1:3);
t = Rt(1:3,4);

% Correct Camera rotation to usual axes (image XY, Z forward)
R = Blender.R_cam_2Conventional( R );
% R = R * diag([+1 -1 -1]);