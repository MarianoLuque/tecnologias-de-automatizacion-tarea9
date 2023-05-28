clear;close;clc;

a2 = 7; a3 = 3; d1 = 15;
L1 = Revolute('d', d1, 'a', 0 , 'alpha', -pi/2);
L2 = Revolute('d', 0 , 'a', a2, 'alpha', 0);
L3 = Revolute('d', 0 , 'a', a3, 'alpha', 0);

bot = SerialLink([L1, L2, L3]);
%animarlo
%min y max de cada eje
ws = [-15,20,-20,20,-5,25];
bot.teach([0, 0, 0], 'workspace', ws, 'noname');
%bot.plot();

%bucle para cambiar la posicion manualmente
while(true)
    
    t = 0:0.1:2*pi;
    x = 5+sin(t)*2;
    y = 5+cos(t)*2;
    for i=1:63
        p = [x(i), y(i), 15];
        plot_sphere(p, 0.5, 'y');
        k = invkin(p(1), p(2), p(3));
        bot.plot([k(1), k(2), k(3)], 'workspace', ws, 'noname')
    end
end

function P = dickin(q)
    P = zeros(3,1);
    %inserte ecuaciones de CD
    P(1) = -3*sin(q(2))*sin(q(3))*cos(q(1)) + 3*cos(q(1))*cos(q(2))*cos(q(3)) + 7*cos(q(1))*cos(q(2));
    P(2) = -3*sin(q(1))*sin(q(2))*sin(q(3)) + 3*sin(q(1))*cos(q(2))*cos(q(3)) + 7*sin(q(1))*cos(q(2));
    P(3) = -3*sin(q(2))*cos(q(3)) - 7*sin(q(2)) - 3*sin(q(3))*cos(q(2)) + 15;
    fprintf('La posicion del TCP es: [%.4f, %.4f, %.4f]\n', P(1), P(2), P(3));
end
function k = invkin(x, y, z)
    a2 = 7;
    a3 = 3;
    d1 = 15;
    
    q1 = atan2(y,x);
    try
        cosenoQ3 = (x^2 + y^2 + (z-d1)^2 - a2*a2 - a3*a3) / (2*a2*a3);
        q3 = atan2(-sqrt(1-cosenoQ3^2), cosenoQ3);
    catch
        % Manejo de la excepción cuando cosenoQ3 es mayor que 1
        disp('El punto no es alcanzable. Ajusta el punto a los límites del espacio de trabajo.');
        k = [];
        return;
    end
    q2 = atan2(z-d1, sqrt(x^2+y^2)) - atan2(a3*sin(q3),a2+a3*cos(q3));
    
    k = [q1, q2, q3];
end

