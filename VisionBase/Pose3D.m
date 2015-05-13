function T = Pose3D( vx, vy, vz, Pb )
%T = Transformation( vx, vy, vz, Pb ) Transformation in 3D homogeneous
%coordinates, using vectors proyection (column) over the world reference and the
%position Pb of the new reference since world
%   theta in rads
    T = [vx, vy, vz, Pb ; 0 0 0 1];
end