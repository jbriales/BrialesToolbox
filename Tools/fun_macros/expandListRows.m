function varargout = expandListRows( M )
% out = expandListRows( M )
% Input:
%   M - Nr x Nc matrix
% Output:
%   out - expanded list with Nr elements, a 1xNc array each
%
% Examples of use:

% Create intermediate cell array
c = mat2cell( M, ones(1,size(M,1)) );

% Expand list
varargout = {c{:}};
end
