% 
% figure
% rotate3d on
% axis('equal')
% grid on
% 
% drawWorldSR();

% cy*cp,      cy*sp*sr-sy*cr,     cy*sp*cr+sy*sr,
% 		sy*cp,      sy*sp*sr+cy*cr,     sy*sp*cr-cy*sr,
% 		-sp,        cp*sr,              cp*cr

% drawSR( TRotationX(pi/3), '1', 0.5 );

% syms y p r real %y p r stands for 'yaw', 'pitch' and 'roll'
% R = RotationZ(y)*RotationY(p)*RotationX(r);
% 
% drawSR( TRotationYPR( pi/4, -pi/3, pi/8 ), 'YPR', 0.5 )

syms y1 p1 r1 y2 p2 r2 real
syms alpha_x alpha_y x0 y0 real

% H = (CalibrationMatrix(alpha_x,alpha_y,x0,y0) * RotationYPR( y2,p2,r2 )) *...
%     inv( CalibrationMatrix(alpha_x,alpha_y,x0,y0) * RotationYPR( y1,p1,r1 ) ); %#ok<MINV>
% H = (CalibrationMatrix(1,1,0,0) * RotationYPR( 0,0,0 )) *...
%     inv( CalibrationMatrix(1,1,0,0) * RotationYPR( y1,p1,r1 ) ); %#ok<MINV>
% H = simplify(H);

My = simplify( RotationY(y2)' * RotationY(y1) );
Mx = RotationX(p2)' * My * RotationX(p1);

Mx2 = RotationX(p2)' * My;
Mx1 = My * RotationX(p1);

syms a b real
My_  = subs( My, [cos(y1 - y2) sin(y1 - y2)], [a b] );
Mx2_ = subs( Mx2, [cos(y1 - y2) sin(y1 - y2)], [a b] );
Mx1_ = subs( Mx1, [cos(y1 - y2) sin(y1 - y2)], [a b] );
Mx_  = subs( Mx, [cos(y1 - y2) sin(y1 - y2)], [a b] );
% 
% syms Ay real;
% My_ = [ 1 0 Ay ; 0 1 0 ; -Ay 0 1 ];
% Mx_ = RotationX(p2) * My_ * RotationX(p1)