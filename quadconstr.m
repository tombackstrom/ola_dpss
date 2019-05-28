function [y,yeq,grady,gradyeq] = quadconstr(x,H,k,d,Heq,keq,deq)
jj = length(H); % jj is the number of inequality constraints
y = zeros(1,jj);
for i = 1:jj
    y(i) = 1/2*x'*H{i}*x + k{i}'*x + d{i};
end
jjeq = length(Heq); % jj is the number of inequality constraints
yeq = zeros(1,jjeq);
for i = 1:jjeq
    yeq(i) = 1/2*x'*Heq{i}*x + keq{i}'*x + deq{i};
end

    
if nargout > 2
    grady = zeros(length(x),jj);
    for i = 1:jj
        grady(:,i) = H{i}*x + k{i};
    end
    gradyeq = zeros(length(x),jjeq);
    for i = 1:jjeq
        gradyeq(:,i) = Heq{i}*x + keq{i};
    end
end

