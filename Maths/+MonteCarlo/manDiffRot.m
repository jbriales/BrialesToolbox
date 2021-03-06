function [J_spa_man, J_man_spa] = manDiffRot( X )
% Jacobian of complete SO(3) space wrt tangent space so(3)

if isvector( X )
    R  = reshape( X, 3,3, [] );
elseif all( size(X) == [3 3] )
    R = X;
else
    error('Wrong dimensions')
end

J_R_eps  = [ -skew(R(:,1))
             -skew(R(:,2))
             -skew(R(:,3)) ];
J_eps_R  = 0.5 * J_R_eps';

J_spa_man = J_R_eps;
J_man_spa = J_eps_R;

end