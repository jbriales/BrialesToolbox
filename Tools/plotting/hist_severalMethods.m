function hist_severalMethods( cY, edges, colors, doNormalization )
% hist_severalMethods( cY, edges, colors, doNormalization )
% Plot the histogram of each variable in cY showing all together.
% Input:
%   cY - a cell array with vectors of elements
%
% See also hist, histc.

assert(iscell(cY),'Input must be a cell array of vectors');
numVars = length(cY);

% Complete default values for input variables
if ~exist('edges','var') || isempty(edges)
%     edges = linspace(min(cY{1}),max(cY{1}),10);
    edges = logspace(round(log10(min(cY{1}))),...
                     round(log10(max(cY{1}))),10);
end
if ~exist('colors','var') || isempty(colors)
    for i=1:numVars
        colors{i} = customColor(i);
    end
end
if ~exist('doNormalization','var') || isempty(doNormalization)
    doNormalization = false;
end

% Count the number of elements in specified bins for each variable
cN = cell(numVars,1);
for i=1:numVars
    cN{i} = histc( cY{i}, edges );
    % Normalize the number of occurrences as percentages (if chosen)
    if doNormalization
%         cN{i} = cN{i} / numel(cY{i});
        cN{i} = cN{i} / sum(~isnan(cY{i}));
    end
end
% Convert cell array to matrix
mN = cell2mat(cN);

% Plot bar figure
bar(edges,mN','histc'); % Rows are edges dimension

% Apply chosen colors to bar faces
% Find patch objects
h = findobj(gca,'Type','patch');
h = sort(h);
for i=1:numVars
    set(h(i),'FaceColor',colors{i},'EdgeColor','w');
end