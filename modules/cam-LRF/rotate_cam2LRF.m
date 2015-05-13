function R_s_ = rotate_cam2LRF( R_c_ )
% R_LRF_... = rotate_cam2LRF( R_Cam_... )
% (Camera -> LRF)
% Transform input rotation (expressed in camera coordinate system) to
% rotation as seen from LRF.
% The standard reference systems for camera and LRF are used:
%   - Camera: +Z points forwards, +X right and +Y down (image in XY plane)
%   - LRF: +X points forwards, +Y left and +Z up (scan in XY plane)
%
% See also: rotate_LRF2cam

% Transformation matrix between standard systems
% From camera to RLF (Cam->LRF)
R_c_s = [  0 -1  0 ;
           0  0 -1 ;
          +1  0  0 ];

R_s_ = R_c_s' * R_c_;