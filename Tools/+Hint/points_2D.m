function [pts, h] = points_2D( n, format )
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

if ~exist('format','var')
    format = '*k'; % Default format for plotted points
end

pts = zeros(2,n);
h = zeros(1,n); % Handles for points
for k=1:n
    title( sprintf('Point %d - Zoom the image - Press key to continue', k) );
    zoom on; pause;
    title( sprintf('Point %d - Click point',k) );
    [x,y] = ginput(1);
    zoom out;
    h(k) = plot(x,y,format);
    
    % Store new point
    pts(:,k) = [x;y];
end
title( '' );

if nargout < 2 % If handle is not returned, remove points
    delete(h);
end
end