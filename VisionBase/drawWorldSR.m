function WSR = drawWorldSR( )
%drawWorldSR( ) Summary of this function goes here
%   Detailed explanation goes here

TW  = [ eye(3), zeros(3,1) ; zeros(1,3) , 1];
WSR = drawSR( TW, 'W' );

end

