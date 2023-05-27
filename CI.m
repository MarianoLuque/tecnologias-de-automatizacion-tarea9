function q = CI(p)

%% Dimensiones de los eslabones
d1 = 15;
a2 = 7;
a3 = 3;

%% Matriz de Posicion P
x = p(1);
y = p(2);
z = p(3);

%% Calculo de la Cinematica inversa
%% Calculo de q1
q1(1) = atan2d(y,x);
q1(2) = atan2d(y,x);
q1(3) = atan2d(y,x);
q1(4) = atan2d(y,x);

%% Calculo de q3
cosenoQ3 = (x^2+y^2+z^2-a2^2-a3^2)/(2*a2*a3)
q3(1) = atan2d(-sqrt(1-(cosenoQ3)^2), cosenoQ3);
q3(2) = atan2d(sqrt(1-(cosenoQ3)^2), cosenoQ3);
q3(3) = atan2d(-sqrt(1-(cosenoQ3)^2), cosenoQ3);
q3(4) = atan2d(sqrt(1-(cosenoQ3)^2), cosenoQ3);

%% Calculo de q2
q2(1) = atan2d(z, -sqrt(x^2+y^2)) - atan2d(a3*sind(q3(1)),a2+a3*cosd(q3(1)));
q2(2) = atan2d(z, -sqrt(x^2+y^2)) - atan2d(a3*sind(q3(2)),a2+a3*cosd(q3(2)));
q2(3) = atan2d(z, sqrt(x^2+y^2)) - atan2d(a3*sind(q3(3)),a2+a3*cosd(q3(3)));
q2(4) = atan2d(z, sqrt(x^2+y^2)) - atan2d(a3*sind(q3(4)),a2+a3*cosd(q3(4)));

%% Transponer la matriz para tener las soluciones en columnas
q = [q1' q2' q3'];

end






