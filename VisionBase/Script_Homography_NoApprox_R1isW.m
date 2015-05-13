%Homography when first orientation is the same as for world, keeping angles

y1=0; p1=0; r1=0;
syms y p r real

R = simplify( RotationZ(y) * RotationY(p) * RotationX(r) );
