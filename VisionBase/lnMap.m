function [u, theta] = lnMap(R)
%lnMap The Rodrigues' formula for rotation matrices.
%   [theta, u] = lnMap(R) The formula recieves a rotation matrix and returns
%   an angle of rotation given by theta and a unit vector, u, that
%   defines the axis of rotation.
%   u = lnMap(R) The formula recieves a rotation matrix and returns
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
%   [theta, u] = lnMap( eye(3) )
% 

%__________________________________________________________________________
%  Rodrigues' rotation formula.
% u = null( R - eye(3) ); % Falla si hay ruido

s = size(R);
if length(s) == 2
% Case in which input is a 3x3 matrix
    [~,~,V] = svd(R - eye(3));
    u = V(:,3);
    
    c2 = trace(R) - 1; % cos(theta)*2
    s2 = u' * [R(3,2)-R(2,3) , R(1,3)-R(3,1) , R(2,1)-R(1,2)]';
    theta = atan2(s2,c2);
    
    if theta < 0
        u = -u;
        theta = -theta;
    end
    
    if nargout == 1
        u = u * theta;
        
        % Normalization of angle-axis representation so that angle < pi
        if theta > pi
            u = u * ( 1 - 2*pi/theta );
        end
    end
    
elseif length(s) == 3
% Case in which input is a 3x3xn tensor
    n  = s(3);
    tr = R(1,1,:) + R(2,2,:) + R(3,3,:);
    theta = acos( (tr-1)/2 );
        mask = (abs(theta)<eps);
        theta_mask = theta; % Use to avoid NaN when theta = 0
        theta_mask(mask) = 1;
    v  = [ R(3,2,:) - R(2,3,:)
           R(1,3,:) - R(3,1,:)
           R(2,1,:) - R(1,2,:) ];
    v  = reshape(v(:),[3,n]);
    om = spdiags( 1./( 2*sin(theta_mask(:)) ),0,n,n); % diagonal index is 0 for principal!
    
%     Tv = tensor(v);
%     Tu = ttm(Tv, om, 3);
%     u  = Tu.data;

    u = v * om;
    
    if nargout == 1
        u = u * spdiags( theta(:), 0,n,n );
    end
else
    error('There was some mistake with dimensions in lnMap');
end

end
