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
h_sphere = [];
while(true)
    P = input('Introduzca un vector de posicion deseada [x,y,z]: ');
    % Borra la esfera anterior si existe
    if ~isempty(h_sphere)
        delete(h_sphere);
    end
    %imprimimos una esfera en el punto con grosor 2 y color amarillo
    h_sphere = plot_sphere(P, 2, 'y');
    input('Presiona una tecla para mover al robot');
    k = invkin(P(1), P(2), P(3));
    if isempty(k)
        continue;
    end
    bot.plot(k, 'workspace', ws, 'noname')
    dickin(k);
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
        disp('El punto no es alcanzable. Ajusta los límites del espacio de trabajo.');
        k = [];
        return;
    end
    q2 = atan2(z-d1, sqrt(x^2+y^2)) - atan2(a3*sin(q3),a2+a3*cos(q3));
    
    q = [q1, q2, q3];
    k = q;
    fprintf('Los valores de los angulos en radianes son: [%.4f, %.4f, %.4f]\n', k(1), k(2), k(3));
    fprintf('Los valores de los angulos en grados son: [%.4f, %.4f, %.4f]\n', rad2deg(q(1)), rad2deg(q(2)), rad2deg(q(3)));
end








