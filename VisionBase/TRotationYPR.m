function TR = TRotationYPR( y, p, r )
% TR = TRotationYPR( y, p, r )
% Gives 4x4 matrix with rotation ypr

TR = [ RotationYPR(y,p,r), zeros(3,1) ; zeros(1,3) , 1];

end