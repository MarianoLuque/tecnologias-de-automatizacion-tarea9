clear;close;clc;
%% Posicion inicial y final
pinicial = [5 2 3];   % Posicion Inicial
pf = [6 4 3];   % Posicion Final

deltap = [0.01 0.01];      % Error tolerado en la posicion
wmax = [2 2];       % Velocidades maximas de las articulaciones
h = 1;            % paso de integracion

%% Calculo de la cinematica inversa.
% Se devuelven dos configuraciones posibles: codo arriba y codo abajo
qi = CI(pinicial);
qf = CI(pf);

%% Verificacion usando la cinematica directa
% Puede ocurrir que alguna de las configuraciones propuestas por la CI no sea correcta.
pi1 = modeloCinematico(qi(1,:));
pi2 = modeloCinematico(qi(2,:));
pi3 = modeloCinematico(qi(3,:));
pi4 = modeloCinematico(qi(4,:));

pf1 = modeloCinematico(qf(1,:));
pf2 = modeloCinematico(qf(2,:));
pf3 = modeloCinematico(qf(3,:));
pf4 = modeloCinematico(qf(4,:));








