function [segs, hg] = scan_corner( xy, mask, doOptimization, hF, format )
% pts = points_2D( n )
% [pts, h] = points_2D( n, format )
%
% Return n points selected from current image
% Input:
%   n - number of points to select
%  *format - format for plotting points
% Output:
%   pts - 2xn array with points coordinates
%  *h - handles for plotted points (if not returned, points are removed)

%% Set default inputs
if ~exist('mask','var')
    mask = true(1,3);
end
if ~exist('doOptimization','var')
    doOptimization = true;
end

% Set new figure for hinting or use given axes
if exist('hF','var') && ~isempty(hF)
    figure(hF);
else
    figure;
end
% Plot scan from LRF
hold on
hxy = CScan.plotXY( xy, '.k' );
hfr = CScan.plotLRFframe;

% Set style parameters for representation
if ~exist('format','var')
    cols = {'r','g','b'};
else
    error('What to do with format?');
end
tags = {'yz','zx','xy'};
tags_color = {'red','green','blue'};

%% Main code
% For result storage
segs = repmat( CSegment2D, 1,3 );
% For representation
h = zeros(1,3);
g = zeros(1,3);
for k=1:3
    if ~mask(k)
        % Skip this step is mask==0
        continue
    end
    
    idx = NaN(1,2);
    for i=1:2
        title( sprintf('Segment in plane %s (%s) - Click point %d',...
               tags{k}, tags_color{k}, i) );
        % Get first point for segment
        [x,y] = ginput(1); pt = [x;y];
        % Find closest point in xy cloud
        idx(i) = CScan.mindist( xy, pt );
    end
    idx = sort( idx );
    p1 = xy(:,idx(1));
    p2 = xy(:,idx(2));
    if doOptimization
        inliers = idx(1):idx(2);
        [c,v] = Fit.line2pts_2D( xy(:,inliers) );
        segs(k) = CSegment2D( c,v, norm(p2-p1) );
    else
        segs(k) = CSegment2D( p1, p2 );
    end
%     [h(k),g(k)] = segs(k).plot( cols{k}, tags{k} );
    [h(k),g(k)] = segs(k).plot( cols{k} );
end

% delete( hxy );
% delete( hfr );
if nargout < 2 % If handle is not returned, remove points
    delete_secure(h);
    delete_secure(g);
else
    hg = [ h; g ];
end
end