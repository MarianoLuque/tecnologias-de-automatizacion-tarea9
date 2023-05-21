pkg load symbolic
%%Variables
syms q1 q2 q3 real
pi1 = sym('pi');

d1 = 15;
a2 = 7;
a3 = 3;

%%Parametros
q = [q1+90 q2 q3];
d = [d1 0 0];
a = [0 a2 a3];
alfa = [-90 0 0] * pi1 / 180 ;

%%Matrices de DH
A01 = matrizDH(q(1), d(1), a(1), alfa(1));
A12 = matrizDH(q(2), d(2), a(2), alfa(2));
A23 = matrizDH(q(3), d(3), a(3), alfa(3));

%%Modelo cinematico
T = A01*A12*A23;
%%T1 = A01*A12*[0, 0, q3, 1]';

%%Pxyz
Pxyz = [-q3*sin(q2)*cos(q1);
        -q3*sin(q1)*cos(q2);
        q3*(cos(q2)+5);
        1];

%%inversas de A01 y A12
IA01 = inv(A01);
IA12 = inv(A12);

%%IA01 * T = A12 * A23
TIA01 = IA01 * T
A13 = A12 * A23

m1 = [[cos(q1) sin(q1) 0 0];[ 0 0 1 l1];[ sin(q1) -cos(q1) 0 0];[ 0 0 0 1]];
