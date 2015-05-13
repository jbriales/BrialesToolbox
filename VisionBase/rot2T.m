function T = rot2T( arg1, arg2 )
%T = rot2T( R )
%T = rot2T( t )
%T = rot2T( R, t )
%   Input:
%      *R - rotation matrix (3x3)
%      *t - translation vector (3x1)
%   *Optional
% 
%   Output:
%       T - transformation matrix (homogeneous)

if nargin==1
    s = size( arg1 );
    if s(1) ~= 3
        error('Dim(1) should be 3');
    else
        if s(2) == 1 % rot2T( t ) case
            t = arg1;
            R = eye(3);
        elseif s(2) == 3 % rot2T( R ) case
            t = [0 0 0]';
            R = arg1;
        else
            error('Dim(2) should be 1 or 3');
        end
    end
else
    R = arg1;
    t = arg2;
end

T = [R, t; 0 0 0 1];

end

