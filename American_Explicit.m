function V = BS_American_Explicit(xspan,Nx,ic,bcl,bcr,ee,tspan,Nt,r,v)

% xspan = [log(Smin) log(Smax)]; Log stock price ( x = log S ) interval
% Nx; Number of x nodes

% ic;  initial condition, i.e., payoff as a function form 
% bcl; boundary condition at left end as a function form 
% bcr; boundary condition at right end as a function form 
% ee;  early exercise payoff as a function form 

% tspan = [0 T]; Time to maturity interval 
% Nt; Number of t nodes

% r; interest
% v; volatility

x = linspace(xspan(1),xspan(2),Nx);
dx = x(2)-x(1);

t = linspace(tspan(1),tspan(2),Nt);
dt = t(2)-t(1); 

rho = dt/dx^2;

L =                 0.5*v^2*rho - (r-0.5*v^2)*(dt/(2*dx));
C = (1-r*dt) + (-2)*0.5*v^2*rho;
R =                 0.5*v^2*rho + (r-0.5*v^2)*(dt/(2*dx));

V       = zeros(Nx,Nt);
V(:,1)  = ic(x');  % initial condition, i.e., payoff
V(1,:)  = bcl(t'); % boundary condition at left end
V(Nx,:) = bcr(t'); % boundary condition at right end

for j=2:Nt
    V(2:Nx-1,j) = L*V(1:Nx-2,j-1)+C*V(2:Nx-1,j-1)+R*V(3:Nx,j-1); % Explicit
    V(:,j) = max(V(:,j),ee(x'));
end
end
