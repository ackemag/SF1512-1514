% Projekt C, Leksaks-slangbella, Basnivå
% Axel Magnusson, Numeriska Metoder SF1512/1514
%----------------------------------------------
clc; clear; close all; format long

% Hitta distansen för uppgift b)
d_0 = 0.2;
uppgift_b = @(d) hitta_distans(d) - 4;
L_b = fzero(uppgift_b,d_0); 
% Svar b) = 0.031066274268961 [m]
%----------------------------------------------

% Uppgift c) variera phi fritt för att se hur långt man kan komma
vektor_phi = 0:0.05:pi/2;
vektor_distans = zeros(length(vektor_phi),1);
for i = 1:length(vektor_phi)
    vektor_distans(i) = hitta_phi(vektor_phi(i));
end

% Hitta det index som tillhör vinkeln för den längsta banan
i = 1;
while i < length(vektor_distans) && vektor_distans(i+1) > vektor_distans(i)
    i = i+1;
end

% Gör polyfit, skriv något mer här
p = polyfit(vektor_phi(i-1:i+1),vektor_distans(i-1:i+1),2);
s = @(t) p(1).*t.^2 + p(2).*t+p(3);

% För att beräkna relativa felet
vektor_error = zeros(length(vektor_distans),1);
for i = 1:length(vektor_distans)
    vektor_error(i) = abs(vektor_distans(i) - s(vektor_phi(i)))/s(vektor_phi(i));
end

% Tabell för vinkeln, distansen och det relativa felet till varje distans
Vinkel = vektor_phi';
Distans = vektor_distans;
Relativfel = vektor_error;
T = table(Vinkel,Distans,Relativfel); 

% Hitta maxvärdet genom derivatan av s
s_p = @(t) 2*p(1).*t + p(2);
phi_max = fzero(s_p, [vektor_phi(i-1),vektor_phi(i+1)]);
% phi max = 0.661292886524427,
vinkel_phi_max = asind(phi_max); %  41.398550357390633 grader
% längd phi max = 7.005690914916987 [m]
