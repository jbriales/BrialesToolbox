function [R,t] = load_Rt_c_s( path )

Rt = load( fullfile(path,'pose_rel') );
R = Rt(1:3,1:3);
t = Rt(1:3,4);

% Correct Camera rotation to usual axes (image XY, Z forward)
R_c_b = diag([+1 -1 -1]);
R_s_b = [ 0 0 -1
         -1 0  0
          0 1  0 ];
R = R_c_b * R * R_s_b';

% Correct LRF translation to Camera axes (image XY, Z forward)
t = R_c_b * t;