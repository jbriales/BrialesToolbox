function out = skew( in )
% v_x = skew( v )
%   Input:
%       v   - 3D vector
%   Output:
%       v_x - 3x3 correspondent skew matrix
% 
% v   = skew( v_x )
%   Input:
%       v_x - 3x3 skew symmetric matrix
%   Output:
%       v   - 3D correspondent vector

   if isvector( in )
       if isnumeric(in)
           out=zeros(3,3);
       end

       out(1,2)=-in(3); out(1,3)=in(2); 
       out(2,1)=in(3); out(2,3)=-in(1); 
       out(3,1)=-in(2); out(3,2)=in(1);
   elseif ismatrix( in )
%        warning('TODO: Implement ismatrix case');
%        if ~all(in==-in')
       if ~all(abs(in-(-in'))<1e-10)
           error('Non skew-symmetric matrix')
       end
       out = zeros(3,1);
       out(1) = in(3,2);
       out(2) = in(1,3);
       out(3) = in(2,1);
   end


   
end