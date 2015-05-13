function F = drawSR( T, e, L)
% SR = drawSR( T, 'e', L=1 )
% Draws System of Reference with pose T, name 'e' and, by default,
%length L=1

if nargin==2,
    L=1;
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
EjeZ.z=[T(3,4),ZF(3)];

F.x=line(EjeX.x, EjeX.y,EjeX.z,'LineWidth', 3,'Color',[1 0 0]); 
F.y=line(EjeY.x, EjeY.y,EjeY.z,'LineWidth', 3,'Color',[0 1 0]); 
F.z=line(EjeZ.x, EjeZ.y,EjeZ.z,'LineWidth', 3,'Color',[0 0 1]); 

F.tx=text(XF(1),XF(2),XF(3),strcat(e,'x'),'Color',[0 0 0]);
F.ty=text(YF(1),YF(2),YF(3),strcat(e,'y'),'Color',[0 0 0]);
F.tz=text(ZF(1),ZF(2),ZF(3),strcat(e,'z'),'Color',[0 0 0]);

F.T=T;
F.L=L;