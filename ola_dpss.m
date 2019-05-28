function vopt = ola_dpss(W,L, T)
% function vopt = ola_dpss(W, L, T)
% DPSS window for overlap-add processing
% Input parameters:
%   W - bandwidth (typically in the range 4 to 10)
%   L - total length of window
%   T - length of flat top (default: 0); overlap length is then (L-T)/2.
% Output:
%   vopt - optimal window

% Use of QCQP optimization alogrithm adapted from
% https://se.mathworks.com/help/optim/ug/linear-or-quadratic-problem-with-quadratic-constraints.html


if nargin < 3
    T = 0;
end

Lx = L;
L = L-T;



S = toeplitz(sinc(W*(0:Lx-1)/Lx));

A = [eye(L/2); zeros(T,L/2); flipud(eye(L/2))];

ws = sin(pi*(.5:L/2)/L)';
ws = [ws; ones(T,1); flipud(ws)];

Q = -A'*S*A;
b = [zeros(L/2,1); ones(T,1); zeros(L/2,1)];
c = -A'*S*b;
for k=1:L/4
    foo = zeros(L/2,1);
    foo([k (L/2 + 1 -k)]) = 1;
    H{k} = diag(foo);
    g{k} = zeros(L/2,1);
    d{k} = -.5;
end

options = optimoptions(@fmincon,'Algorithm','interior-point',...
    'SpecifyObjectiveGradient',true,'SpecifyConstraintGradient',true,...
    'HessianFcn',@(x,lambda)quadhess(x,lambda,Q,H,[]),...
    'Display','notify',...
    'MaxFunctionEvaluations',L*100);

fun = @(x)quadobj(x,Q,c,0);
nonlconstr = @(x)quadconstr(x,H,g,d,[],[],[]);
x0 = pinv(A)*ws;
[x,fval,eflag,output,lambda] = fmincon(fun,x0,...
    [],[],[],[],[],[],nonlconstr,options);

vopt = A*x + b;

