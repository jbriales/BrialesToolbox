function color = customColor( selection )
% color = customColor( selection )
% Choose a customized color for plot
% Input:
%   selection - a string with color name or index in the list below

% Build matrix with custom colors
customColors = 1/255 * ...
    [ 51 51 255     % blue
      255 128 0     % orange
      102 255 102   % green
    ];
numColors = size(customColors,1);
% Build list of color names corresponding to matrix rows
names = {'blue','orange','green'};
assert(numColors==length(names),'Complete list of names');

% If the input is a color name
if ischar( selection )
    % Search corresponding index
    cIndex = strfind( names, lower(selection) );
    for i=1:numColors
        if cIndex{i}==true
            selection = i;
            break;
        end
    end
end

assert(selection>0 && selection <=numColors,'Color index out of range');
color = customColors(selection,:);