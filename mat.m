clear;close;clc;

a2 = 7;
a3 = 3;
d1 = 15;

L1 = Revolute('a', 0, 'alpha', -pi/2, 'd', d1);
L2 = Revolute('a', a2, 'alpha', 0, 'd', 0);
L3 = Revolute('a', a3, 'alpha', 0, 'd', 0);

bot = SerialLink([L1, L2, L3]);
%animarlo
%min y max de cada eje
ws = [-20,25,-25,25,-25,25];
bot.teach([0, 0, 0], 'workspace', ws, 'noname');
%bot.plot();

%bucle para cambiar la posicion manualmente
while(true)
    P = input('Introduzca un vector de posicion deseada [x,y,z]: ');
    %imprimimos una esfera en el punto con grosor 0.2 y color amarillo
    plot_sphere(P, 2, 'y')
    input('Presiona una tecla para mover al robot');
    bot.plot(invkin(P(1), P(2), P(3)), 'workspace', ws, 'noname')
end

%{
P = zeros(3,1);
while(true)
    input('¿Calcular?')
    q = bot.getpos();
    %inserte ecuaciones de CD
    P(1) = -3*sin(q(2))*sin(q(3))*cos(q(1)) + 3*cos(q(1))*cos(q(2))*cos(q(3)) + 7*cos(q(1))*cos(q(2));
    P(2) = -3*sin(q(1))*sin(q(2))*sin(q(3)) + 3*sin(q(1))*cos(q(2))*cos(q(3)) + 7*sin(q(1))*cos(q(2));
    P(3) = -3*sin(q(2))*cos(q(3)) - 7*sin(q(2)) - 3*sin(q(3))*cos(q(2)) + 15;

    disp(P)
end
%}
function k = invkin(x, y, z)
    a2 = 7;
    a3 = 3;
    d1 = 15;
    q1 = atan2d(y,x);
    cosenoQ3 = (x^2+y^2+z^2-a2^2-a3^2)/(2*a2*a3);
    %q3 = atan2d(sqrt(1-(cosenoQ3)^2), cosenoQ3);
    %q2 = atan2d(z, sqrt(x^2+y^2)) - atan2d(a3*sind(q3),a2+a3*cosd(q3));

    xc = x;
    yc = y;
    zc = z;
    D=(xc^2+yc^2-a2^2-a3^2)/(2*a2*a3);
    
    d = sqrt(xc^2 + yc^2);
    h = zc - d1;
    r = sqrt(d^2 + h^2);
    alfa = atan2(h, d);
    beta = acos((a2^2 + r^2 - a3^2) / (2 * a2 * r));
    theta1 = atan2(yc,xc);
    theta2 = - alfa - beta + 50 * 180 / pi;
    theta3 = atan2(z - d1, r) - pi/2 + beta;
    
    k = [theta1*180/pi,theta2*180/pi,theta3*180/pi]
end








