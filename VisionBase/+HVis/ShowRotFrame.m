function F = ShowRotFrame( R, str, HF )

if nargin == 1
    HF = figure;
    view(45,45);
    xlim([-1,1]); ylim([-1,1]); zlim([-1,1]);
    grid
    rotate3d on;
end

% ****************************
% Plot frames
% ****************************
figure( HF );
T = rot2T( R );
F = HVis.createFrame( T, 'rgb', str );