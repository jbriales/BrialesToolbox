function [pts, im, Rig, N, V] = loadIROS( path, step )
% [pts, im, Rig] = loadIROS( path, step )
% [pts, im, Rig, N, V] = loadIROS( path, step )
% Load data from Blender simulation for minimal calibration solution
% Input:
%   path - path to containing folder of the simulation data
%   step - number of step inside the Blender scene
% Output:
%   pts - 2xN array of LRF points (and NaN in non-valid points)
%   im - image rendered by Blender
%   Rig - CSimRig object with GT pose and configuration of Camera y LRF
%   N - 3x(3x1) plane normals for (1,2,3)={YZ,ZX,XY}={X,Y,Z} trihedron planes
%   V - 3x(3x1) ray directions for (1,2,3)={X,Y,Z} trihedron lines

% Load experiment configuration data from .ini file
conf = readConfigFile( fullfile(path,'config.ini'), '[Exp]' );

% Load point cloud
% Take several scans and average them
c_pts = cell(10,1);
for i=1:conf.N_scans
    name = sprintf('scan_%d_%d_noisy.pcd',step,i);
    pts = Blender.loadPCD( fullfile(path,name) );
    pts(3,:) = []; % Remove extra row (z=0)
    c_pts{i} = pts;
end
% Compute average of all scans
c_pts = reshape(c_pts,1,1,[]);
pts = mean( cell2mat(c_pts), 3 );

% Load image
name = sprintf('img_%d.png',step);
im  = imread( fullfile(path,name) );

% Set Rig from Blender data
[R_cam,t_cam] = Blender.load_Rt_Cam( path, step );
[R_LRF,t_LRF] = Blender.load_Rt_LRF( path, step );
R_c_s = R_cam' * R_LRF;
t_c_s = R_cam'*(-t_cam + t_LRF);
% parent_path = fileparts(fileparts(path));
% [R_c_s,t_c_s] = Blender.load_Rt_c_s( parent_path );

% Rt_c_s = load( fullfile(path,'pose_rel') );
% R_c_s = Rt_c_s(1:3,1:3);
% t_c_s = Rt_c_s(1:3,4);
%
% Rt_cam = load( fullfile(path,'pose_cam') );
% R_cam = Rt_cam(1:3,1:3);
% t_cam = Rt_cam(1:3,4);

rig_config_file = fullfile( path, 'rig.ini' );
camOpts = readConfigFile( rig_config_file, '[Cam]' );
LRFOpts = readConfigFile( rig_config_file, '[LRF]' );
c_camOpts = struct2cell( camOpts );
c_LRFOpts = struct2cell( LRFOpts );
Rig = CSimRig( eye(3), zeros(3,1), R_c_s, t_c_s,... % Extrinsic options
    c_LRFOpts{:},... % Lidar options
    c_camOpts{:} ); % Camera options
Rig.updateCamPose( R_cam, t_cam );

if nargout > 3
    %% Load trihedron real configuration
    name = sprintf('Ntrih_%d',step);
    N = load( fullfile(path,name) ); % Plane normals
    % Compute ray direction as cross product of both intersecting planes
    V = NaN(3,3);
    for m=1:3
        ijk = circshift(1:3,[0 m]); ijk=num2cell(ijk); [i,j,k] = deal(ijk{:});
        V(:,k) = snormalize( cross( N(:,i),N(:,j) ) );
    end
end
end