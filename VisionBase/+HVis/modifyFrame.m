function NF=modifyFrame(F,T)

XF=T*[F.L;0;0;1]; YF=T*[0;F.L;0;1]; ZF=T*[0;0;F.L;1];

EjeX.x=[T(1,4),XF(1)];
EjeX.y=[T(2,4),XF(2)];
EjeX.z=[T(3,4),XF(3)];

EjeY.x=[T(1,4),YF(1)];
EjeY.y=[T(2,4),YF(2)];
EjeY.z=[T(3,4),YF(3)];

EjeZ.x=[T(1,4),ZF(1)];
EjeZ.y=[T(2,4),ZF(2)];
EjeZ.z=[T(3,4),ZF(3)];

set(F.x,'XData',EjeX.x,'YData',EjeX.y,'ZData',EjeX.z); 
set(F.y,'XData',EjeY.x,'YData',EjeY.y,'ZData',EjeY.z); 
set(F.z,'XData',EjeZ.x,'YData',EjeZ.y,'ZData',EjeZ.z); 

set(F.tx,'Position',XF(1:3));
set(F.ty,'Position',YF(1:3));
set(F.tz,'Position',ZF(1:3));

NF=F;
NF.T=T;