%Homography when angles are low and linear approximations can be done

syms y1 p1 r1 y2 p2 r2 real
syms alpha_x alpha_y x0 y0 real

My = simplify( RotationY(y2)' * RotationY(y1) );
syms Ay real;
My_ = subs( My, [cos(y1-y2) sin(y1-y2)], [1 Ay] );

Mx = simplify( RotationX(p2)' * My_ * RotationX(p1) );
syms Ap real;
Mx_ = subs( Mx, [cos(p1 - p2) sin(p1 - p2)], [1 Ap] );

% Este último resultado es ya horrible
Mz = RotationZ(r2)' * Mx_ * RotationZ(r1);
