function hess = quadhess(x,lambda,Q,H,Heq)
hess = Q;
jj = length(H); % jj is the number of inequality constraints
for i = 1:jj
    hess = hess + lambda.ineqnonlin(i)*H{i};
end
jjeq = length(Heq); % jj is the number of inequality constraints
for i = 1:jjeq
    hess = hess + lambda.eqnonlin(i)*Heq{i};
end