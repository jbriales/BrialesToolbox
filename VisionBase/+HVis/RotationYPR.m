function R = RotationYPR( y, p, r )
%R = RotationYPR( y, p, r )
%R = RotationYPR( ypr )
%   Input (option 1):
%       y - yaw   angle [rad]
%       p - pitch angle [rad]
%       r - roll  angle [rad]
%   Input (option 2):
%       ypr - angles vector [rad]
% 
%   Output:
%       R  - rotation matrix

ypr = y; % First argument
if nargin == 1
    y = ypr(1);
    p = ypr(2);
    r = ypr(3);
end

cy = cos(y); cp = cos(p); cr = cos(r);
sy = sin(y); sp = sin(p); sr = sin(r);

% R = [ cp*cy, cy*sp*sr - cr*sy, sr*sy + cr*cy*sp
%       cp*sy, cr*cy + sp*sr*sy, cr*sp*sy - cy*sr
%         -sp,            cp*sr,            cp*cr];

R =   [	cy*cp,      cy*sp*sr-sy*cr,     cy*sp*cr+sy*sr
		sy*cp,      sy*sp*sr+cy*cr,     sy*sp*cr-cy*sr
		-sp,        cp*sr,              cp*cr          ];

end

