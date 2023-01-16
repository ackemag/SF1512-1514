function [x_ny,xp_ny,y_ny,yp_ny,v_ny] = system_diff_ekv(x,xp,y,yp,v,h)

% Givna konstanter

m = 50*0.001; % [kg]
g = 9.81; % [m/s^2]
K = 0.0005;

% System av första ordningens differential ekvationer

x_ny = x + h*xp;
xp_ny = xp + h*(-(K/m)*xp*v^(3/2));
y_ny = y + h*yp;
yp_ny = yp + h*(-g - (K/m)*yp*v^(3/2));
v_ny = sqrt(xp_ny^2 + yp_ny^2);

end
