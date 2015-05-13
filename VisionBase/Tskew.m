function out = Tskew( in )
% EM = Tskew( M )
%   Input:
%       M   - 3xN matrix of the form [m1|...|mN] where mi is the i-th column
%   Output:
%       TM  - { skew(M1) , skew(M2) , skew(M3) }
%       TM is the tensor built from skews of every column
%       Each skew-matrix is stacked along third dimension
%       This tensor is firstly represented in Matlab as a multidimensional
%       array of dimensions 3x3xN

[r,N] = size( in );
if r~=3
    warning('Nr of rows should be 3');
end

out = zeros(3,3,N);
% for i=1:N
%     out(:,:,i) = skew(in(:,i));
% end

% Faster: assign each complete row to each 3mode-vector in tensor
out(1,2,:)=-in(3,:); out(1,3,:)=in(2,:); 
out(2,1,:)=in(3,:); out(2,3,:)=-in(1,:); 
out(3,1,:)=-in(2,:); out(3,2,:)=in(1,:);
   
end