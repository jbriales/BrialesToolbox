function [u, theta] = logmap(R)
%LOGMAP The Rodrigues' formula for rotation matrices.
%   [theta, u] = angle_axis_rotation(R) The formula recieves a rotation matrix and returns
%   an angle of rotation given by theta and a unit vector, u, that
%   defines the axis of rotation.
%   u = angle_axis_rotation(R) The formula recieves a rotation matrix and returns
%   an angle of rotation given by non-unit vector, u, that
%   defines the axis of rotation and the angle.
% 
%       ARGUMENT DESCRIPTION:
%               R - rotation matrix.
% 
%       OUTPUT DESCRIPTION:
%           THETA - angle of rotation (radians).
%               U - unit vector
% 
%   Example
%   -------------
%   [theta, u] = angle_axis_rotation( eye(3) )
% 

%__________________________________________________________________________
%  Rodrigues' rotation formula.
N = size(R,3);
if N > 1 % Parallel computation
    % No SVD parallel computation is available yet, so recursive calls are
    % done (this is not really efficient)
    u = zeros(3,N);
    for k = 1:N
        u(:,k) = logmap( R(:,:,k) );
    end
    if nargout == 2
        theta = sqrt( sum( u.^2,1 ) );
        u = snormalize( u );
    end
    
else % For single matrix
    [~,~,V] = svd(R - eye(3));
    u = V(:,3);
    
    c2 = trace(R) - 1; % cos(theta)*2
    s2 = u' * [R(3,2)-R(2,3) , R(1,3)-R(3,1) , R(2,1)-R(1,2)]';
    theta = atan2(s2,c2);
    
    if theta < 0
        u = -u;
        theta = -theta;
    end
    
    if nargout == 1 || nargout == 0 % Without assignment
        u = u * theta;
        
        % Normalization of angle-axis representation so that angle < pi
        %     if theta > pi
        %         u = u * ( 1 - 2*pi/theta );
        %     end
    end
end
