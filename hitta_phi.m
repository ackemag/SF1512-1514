function slut_position = hitta_phi(phi)

% Steglängd
h_0 = 1e-8;

% Begynnelse förhållanden
z = 0.05; % Sätter 5cm 
zp = 0;

max_i = 10;
slut_hastighet = zeros(1,max_i);
for i = 1:max_i
    h = h_0*0.5^i;
    while z > 0
        [z, zp] = bandet(z,zp,h);
    end
    slut_hastighet(i) = zp;
end

% Ny steglängd
h_0 = 1e-2;

slut_position_vektor = zeros(1,max_i);
max_i = 10;
for i = 1:max_i
    % Start förhållande för vår bana, söker phi nu
    v = zp; % Starthastighet
    x = 0; % Kastets start
    xp = v*cos(phi); 
    y = 1.65; % Höjd
    yp = v*sin(phi); 
    
    % Skapar listor
    vektor_x = zeros(1,1);
    vektor_y = zeros(1,1);
    vektor_x(1) = x;
    vektor_y(1) = y;
    h = h_0*0.5^i;

    [x_ny,~,y_ny,~,~] = system_diff_ekv(x,xp,y,yp,v,h);
    n = 1;
    while vektor_y(end) > 0
        % Fyller ut listorna
        n = n + 1;
        vektor_x(n) = x_ny;
        vektor_y(n) = y_ny;
        [x_ny,xp_ny,y_ny,yp_ny,v_ny] = system_diff_ekv(x,xp,y,yp,v,h);
        x = x_ny;
        xp = xp_ny;
        y = y_ny;
        yp = yp_ny;
        v = v_ny; 
    end
    % Trimar listorna för att få korrekt storlek
    vektor_x = vektor_x(1:n);
    vektor_y = vektor_y(1:n);

    % Plottar våra listor
    plot(vektor_x,vektor_y,'b-',xlabel('Längd [m]'),ylabel('Höjd [m]'))
    title('Stenens luftbana')
    hold on

    % Linjär interpolering för att hitta vårt slutgiltiga x-värde
    gradient = (vektor_y(end)-vektor_y(end-1))/(vektor_x(end)-vektor_x(end-1));
    linje = @(t) vektor_y(end-1) + gradient*(t-vektor_x(end-1));
    plot(linspace(vektor_x(end-1), vektor_x(end)), linje(linspace(vektor_x(end-1), vektor_x(end))),'b-')
    slut_position = fzero(linje,[vektor_x(end-1), vektor_x(end)]);
    slut_position_vektor(i) = slut_position;   
end
% skriv något här
distans_c = slut_position_vektor(end); % Göm output
end