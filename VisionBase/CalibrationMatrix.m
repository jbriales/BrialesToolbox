function K = CalibrationMatrix( alpha_x, alpha_y, x0, y0 )
%K = Calibration( alpha_x, alpha_y, x0, y0 ) Summary of this function goes here
%   Detailed explanation goes here

K = [alpha_x , 0 , x0 ;
     0 , alpha_y , y0 ;
     0 , 0 , 1];

end

