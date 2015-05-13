classdef CRawlogLRF
    %CRawlogLRF Container for Rawlog laser data
    %   The rawlog LRF data should be previously extracted through
    %   RawlogViewer into txt files
    % The files structure is:
    % dataset_date_tag(_file).txt
    %   dataset - dataset name (typically dataset)
    %   date    - date and time of dataset
    %   tag     - sensorLabel given in .ini
    %   file    - could be empty (for ranges), _times
    
    properties
        scans % Array of scans
        
        % Useful data
        Nobs
        
        % Auxiliary rawlog data
        typeOfSource
        dataset
        date
        tag
    end
    
    methods
        function obj = CRawlogLRF( folder, config, typeOfSource )
            % obj = CRawlogLRF( folder, config, typeOfSource )
            % Create a Mrawlog object from LRF text data exported from
            % RawlogViewer
            % Input:
            %   folder - folder with LRF .txt data
            %   config - config file (only for Blender)
            %   typeOfSource - Rawlog, Blender
            
            % Get directory files
            files = dir(folder);
            files(1:2) = [];
            
            if ~exist('typeOfSource','var')
                typeOfSource = 'Rawlog';
            end
            
            switch typeOfSource
                case 'Rawlog'
                    % Extract filename parts of range file (basename) and use to take the rest:
                    [~,name,ext] = fileparts( files(1).name );
                    file_range = fullfile( folder, strcat( name, ''      , ext ) );
                    file_times = fullfile( folder, strcat( name, '_times', ext ) );
                    
                    rr = load( file_range );
                    ts = load( file_times );
                    
                    Nobs = numel( ts );
                    
                    % Store object properties
                    obj.Nobs = Nobs;
                    obj.dataset = []; % Read from auxiliary file?
                    obj.date = [];
                    obj.tag = [];
                    
                    % Create array of scans objects and store (in parallel
                    % assignment with deal)
                    cell_rr = num2cell( rr, 2 );
                    cell_ts = num2cell( ts );
                    obj.scans = CScan( cell_rr, cell_ts );
                case 'Blender'
                    Nobs = length(files);
                    obj.Nobs = Nobs;
                    
                    obj.scans = CScan;
                    for i=1:Nobs
                        name = files(i).name;
                        ts = sscanf(name,'%d.pcd');
                        
                        pts = Blender.loadPCD( fullfile(folder,name) );
                        pts(3,:) = [];
                        
                        % Work-around to detect null simulated measurements
                        ang = atan2( pts(2,:), pts(1,:) ); % Recover angles
                        % Round computed angles to discrete angles in
                        % config
                        res = config.resolution_r;
                        % Integer values (to compare)
                        ang_int = round( ang / res );
                        theta_int = round( config.theta / res );
                        [~,Iempty] = setdiff( theta_int, ang_int );
                        Iread = setdiff( 1:config.N, Iempty );
                        
                        r = zeros(1, config.N);
                        r(Iread) = sqrt( sum( pts.^2, 1 ) );
                        % Iempty values are kept zero
                        
                        obj.scans(i) = CScan( r, ts );
                    end
            end
            
            % Assign metafile path for every scan
            if folder(end) == '/', folder(end) = []; end
            folder_meta = fileparts( folder );
            for i=1:length(obj.scans)
                obj.scans(i).metafile = fullfile( ...
                    folder_meta, 'meta_laser',...
                    strcat(num2str(obj.scans(i).ts),'.mat') );
            end
            
        end
        
    end
    
end

