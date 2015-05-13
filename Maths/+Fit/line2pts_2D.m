function [c, v, A_c, A_v] = line2pts_2D( pts, sd )
% [c, v, A_c, A_v] = line2pts_2D( pts, sd )
% Fit 2D line to group of 2D points and propagate covariance is required
% Input:
%   pts - 2xN array of point coordinates
%   sd - standard deviation of 2D points, considered isotropic gaussian sigma*eye(2)
% Output:
%   c - 2x1 center of gravity for points
%   v - 2x1 direction for line (up to sign!)
%   A_c - 2x2 (rank 2) cov matrix of c
%   A_v - 2x2 (rank 1) cov matrix of v (in S1)

% Check if covariance propagation should be computed
%if nargin < 2
hasCovProp = ( nargout > 2 );

N = size(pts,2);

%% Central point
% Compute variable
c = mean(pts,2);
if hasCovProp
    % Uncertainty propagation
    A_c = sd^2 * eye(2) / N;
end

%% Line direction
% TODO: Normalize points as in PeterKoversi fitline
% Compute covariance matrix
L = pts - repmat( c, 1, N );
M = L * L';

[~, ~, V] = svd(M);
% Get output values
v = V(:,1); % Line direction
n = V(:,2);

if hasCovProp
    % Uncertainty propagation
    A_pts = kron( eye(N), sd^2*eye(2) );

    % Jacobian of n wrt p_i
    J_M_p = cell(1,N);
    for k=1:N
        J_M_p{k} = kron(L(:,k),eye(2)) + kron(eye(2),L(:,k));
    end
    J_M_p = cell2mat( J_M_p );

    % Implicit Function Theorem
    Hess_C_nn = -n'*(M'*M)*n + v'*(M'*M)*v;
    Jac_C_nM  = (M*n)' * kron( -v',eye(2) ) + ...
                (-M*v)'* kron( +n',eye(2) );
    J = - Hess_C_nn \ ( Jac_C_nM * J_M_p );
    % Apply derivative to uncertainty propagation
    A_ang = J * A_pts * J';
    A_v   = n * A_ang * n';
end