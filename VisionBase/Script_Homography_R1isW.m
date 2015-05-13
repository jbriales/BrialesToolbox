%Homography when first orientation is the same as for world (angles are low
%and linear approximations can be done)

y1=0; p1=0; r1=0;
syms y2 p2 r2 real
syms alpha_x alpha_y x0 y0 real

My = simplify( RotationY(y2)' * RotationY(y1) );
syms Ay real;
My_ = subs( My, [cos(y2) sin(y2)], [1 Ay] );

Mx = simplify( RotationX(p2)' * My_ * RotationX(p1) );
syms Ap real;
Mx_ = subs( Mx, [cos(p2) sin(p2)], [1 Ap] );

% Resultado final de mult. de matrices
Mz = RotationZ(r2)' * Mx_ * RotationZ(r1);
syms Ar real;
Mz_ = subs( Mz, [cos(r2) sin(r2)], [1 Ar] );

% Resultado al afectarlo de las matrices de calibración
syms ax ay x0 y0 real
K = CalibrationMatrix( ax, ay, x0, y0 );
H  = K\Mz_*K;


