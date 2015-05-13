function vNorms = normOfColumns( mVectors )
% vNorms = normOfColumns( mVectors )
% Compute the 2-norm of each column in a NxM matrix,
% that is, norm of M Nx1-vectors

vNorms = sqrt( sum( mVectors.^2, 1 ) );