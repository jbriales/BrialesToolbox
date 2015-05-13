function r = xy2polar( xy, res, N )
% r = xy2polar( xy, res, N )
% Input:
%   xy - 2xM array with plane points obtained from PCD
% Output:
%   xyz - 3xN array with xyz coordinates of scanned points

% Work-around to detect null simulated measurements
ang = atan2( xy(2,:), xy(1,:) ); % Recover angles

% Round computed angles to discrete angles in config
% Integer values (to compare)
ang_int = round( ang / res );
theta_int = round( config.theta / res );
[~,Iempty] = setdiff( theta_int, ang_int );
Iread = setdiff( 1:config.N, Iempty );

r = zeros(1, N);
r(Iread) = sqrt( sum( pts.^2, 1 ) );