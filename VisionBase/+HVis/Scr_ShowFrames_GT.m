% Ejemplo de coordenas homogeneas

view(45,45);
xlim([-1,1]); ylim([-1,1]); zlim([-1,1]);
grid

% *****************
% Data adquisition
% *****************
% Set the path to dataset and the images to compute from
% ------------------------------------------------------------------
datasetPath = '/media/jesus/STORAGE/Research/Dataset/rgbd_dataset_freiburg2_rpy/rgb/';
datasetFile = dir( datasetPath );
    datasetFile(1:2) = []; % Deletes first two elements
    datasetFile = {datasetFile(:).name}; % Keeps only the names of files
img_name1 = datasetFile{1}; % Choose the indexes of images to process

% ****************************
% Find groundtruth in dataset
% ****************************
gtPath = datasetPath(1:end-4); % The same path as datasetPath but previous folder
ts1 = str2double( img_name1(1:end-4) );
gt1 = findPose( ts1, gtPath );
    R1 = gt1.R;

% ****************************
% Plot frames
% ****************************

HVis.createFrame(eye(4),'k','W');
HVis.createFrame(rot2T(R1),'b','1');

figure, hold on

for i=2:40:400
    img_name = datasetFile{i};
    ts = str2double( img_name(1:end-4) );
    gt = findPose( ts, gtPath );
    R  = gt.R;

    HVis.createFrame(rot2T(R),'b',num2str(i));
end

rotate3d on