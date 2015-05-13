function out = Mskew( in )
% EM = Mskew( M )
%   Input:
%       M   - 3x3 matrix of the form [M1|M2|M3] where Mi is the i-th column
%   Output:
%       EM  - [ skew(M1) ; skew(M2) ; skew(M3) ]
%       EM is the matrix built from skews of every column, put each one below
%       previous one

out = [ skew(in(:,1)); skew(in(:,2)); skew(in(:,3)) ];
   
end