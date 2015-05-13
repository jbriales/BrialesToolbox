function F=createFrame(T,col,e,L)

if nargin==3,
    L=1;
end

if length(col)==1
    c.x = col; c.y = col; c.z = col;
elseif length(col)==3
    c.x = col(1); c.y = col(2); c.z = col(3);
else
    warning('Color argument should have 1 or 3 letters')
end

XF=T*[L;0;0;1]; YF=T*[0;L;0;1]; ZF=T*[0;0;L;1];

EjeX.x=[T(1,4),XF(1)];
EjeX.y=[T(2,4),XF(2)];
EjeX.z=[T(3,4),XF(3)];

EjeY.x=[T(1,4),YF(1)];
EjeY.y=[T(2,4),YF(2)];
EjeY.z=[T(3,4),YF(3)];

EjeZ.x=[T(1,4),ZF(1)];
EjeZ.y=[T(2,4),ZF(2)];
% EjeZ.z=[T(3,4),ZF(3)];

F.x=line(EjeX.x, EjeX.y,EjeX.z,'Color',c.x); 
F.y=line(EjeY.x, EjeY.y,EjeY.z,'Color',c.y); 
% F.z=line(EjeZ.x, EjeZ.y,EjeZ.z,'LineWidth', 3,'Color',c); 
% F.z=quiver3(T(1,4),T(2,4),T(3,4), EjeZ.x, EjeZ.y,EjeZ.z,'LineWidth', 3,'Color',c);
hold on;
F.z=quiver3( T(1,4),T(2,4),T(3,4), T(1,3), T(2,3), T(3,3), 'LineWidth', 3,'Color',c.z ); 
hold off;

F.tx=text(XF(1),XF(2),XF(3),strcat(e,'x'),'Color',c.x);
F.ty=text(YF(1),YF(2),YF(3),strcat(e,'y'),'Color',c.y);
F.tz=text(ZF(1),ZF(2),ZF(3),strcat(e,'z'),'Color',c.z);

F.T=T;
F.L=L;