function R_c_ = rotate_LRF2cam( R_s_ )
% R_Cam_... = rotate_LRF2cam( R_LRF_... )
% (LRF -> Camera)
% Transform input rotation (expressed in LRF coordinate system) to
% rotation as seen from Camera.
% The standard reference systems for camera and LRF are used:
%   - Camera: +Z points forwards, +X right and +Y down (image in XY plane)
%   - LRF: +X points forwards, +Y left and +Z up (scan in XY plane)
%
% See also: rotate_cam2LRF

% Transformation matrix between standard systems
% From camera to RLF (Cam->LRF)
R_c_s = [  0 -1  0 ;
           0  0 -1 ;
          +1  0  0 ];

R_c_ = R_c_s * R_s_;