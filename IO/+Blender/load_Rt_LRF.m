function [R,t] = load_Rt_LRF( path, step )

name = sprintf('pose_LRF_%d',step);
Rt = load( fullfile(path,name) );
R = Rt(1:3,1:3);
t = Rt(1:3,4);

% Correct LRF rotation to usual axes (scan XY, X forwards, Z up)
R = Blender.R_LRF_2Conventional( R );
% R_s_b = [ 0 0 -1
%          -1 0  0
%           0 1  0 ];
% R = R * R_s_b';
