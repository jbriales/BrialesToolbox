function R = expmap(u, theta)
% EXPMAP The Rodrigues' formula for rotation matrices.
%   R = ROTATION_ANGLE_AXIS(U, THETA) The formula recieves an angle of rotation given by theta and a unit vector, u, that
%   defines the axis of rotation.
% 
%       ARGUMENT DESCRIPTION:
%           THETA - angle of rotation (radians).
%               U - unit vector
% 
%       OUTPUT DESCRIPTION:
%               R - rotation matrix.
% 
%   Example
%   -------------
%   R = rotation_angle_axis(deg2rad(pi/6),[sqrt(2)/2, 0.0, sqrt(2)/2])
% 

% Credits:
% Daniel Simoes Lopes
% IDMEC
% Instituto Superior Tecnico - Universidade Tecnica de Lisboa
% danlopes (at) dem ist utl pt
% http://web.ist.utl.pt/daniel.s.lopes/
%
% July 2011 original version.


%__________________________________________________________________________
%  Rodrigues' rotation formula.
if ~isvector(u) % Parallel computation
    N = size(u,2); % Column vectors
    if nargin==1
        theta = sqrt( sum(u.^2,1) );
    end
    
    % Normalize rotation vectors
    u = u./repmat(theta,3,1);
    u(:,theta==0) = 0; % Fix zero-modulus vectors
    
    S = zeros(3,3,N);
    S(1,2,:) = -u(3,:);
    S(1,3,:) = +u(2,:);
    S(2,1,:) = +u(3,:);
    S(2,3,:) = -u(1,:);
    S(3,1,:) = -u(2,:);
    S(3,2,:) = +u(1,:);
    
    if ~exist('multiscale','file')
        warning('Add manopt tools');
    end
    R = repmat( eye(3), [1 1 N] ) + ...
        multiscale( sin(theta), S ) + ...
        multiscale( 1-cos(theta), multiprod(S,S) );
else
    if nargin==1
        theta = norm(u,2);
    end
    
    if theta == 0
        R = eye(3);
    else
        u = u./norm(u,2);
        S = [   0 -u(3)  u(2);
            u(3)   0  -u(1);
            -u(2) u(1)   0  ];
        R = eye(3) + sin(theta)*S + (1-cos(theta))*S^2;
    end
end

