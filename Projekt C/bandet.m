function [z_ny,zp_ny] = bandet(z,zp,h)

% Givna konstanter

m = 50*0.001; % [kg]
L_0 = 10*0.01; % [m]
B = 12*0.01; % [m]
k = 950; % [N/m]

% Beräkna längden på L 

L = 2*sqrt(z^2+(B/2)^2);

% System av första ordningens differential ekvationer

z_ny = z-h*zp;
zp_ny = zp+h*(k/m)*(L-L_0);

end
