function xyz = loadPCD( file )
% xy = loadPCD( file )
% Input:
%   file - path to the .pcd file with stored point of clouds
% Output:
%   xyz - 3xN array with xyz coordinates of scanned points
pts = double(loadpcd( file ));
% Correct Blender coordinates: Blender weird axes wrt common LRF axes (XY plane, X forwards)
R_s_b = [ 0 0 -1
         -1 0  0
          0 1  0 ];
xyz = R_s_b * pts(1:3,:);
end
