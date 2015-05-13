function setPropertyInput( Var, Val )
% setVarDefault( var, val )
% Check if variable Var already exists
% If not, assign value Val to it

vars = evalin('caller','whos');
if ~any( strcmp({vars.name}, Var) )
    assignin('caller',['this.',Var],Val);
end

end