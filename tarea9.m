pkg load symbolic
%%Variables
syms q1 q2 q3 nx ny nz ox oy oz ax ay az px py pz real
pi1 = sym('pi');

d1 = 15;
a2 = 7;
a3 = 3;

%%Parametros
q = [q1 q2 q3];
d = [d1 0 0];
a = [0 a2 a3];
alfa = [-90 0 0] * pi1 / 180 ;

%%Matrices de DH
A01 = matrizDH(q(1), d(1), a(1), alfa(1));
A12 = matrizDH(q(2), d(2), a(2), alfa(2));
A23 = matrizDH(q(3), d(3), a(3), alfa(3));

%%Modelo cinematico
T = A01*A12*A23;

%%inversas de A01 y A12
IA01 = inv(A01);
IA12 = inv(A12);
IA23 = inv(A23);

%%IA01 * T = A12 * A23
TIA01 = IA01 * T;
A13 = A12 * A23;
IA02 = IA12 * IA01;

T1 = [[nx, ox, ax, px]; [ny, oy, ay, py];[ nz, oz, az, pz]; [0, 0, 0, 1]];
Otro = IA01 * T1 * IA23;

%%Solucion como lo hace el profe
p0TCP = A01 * A12 * [A23(1,4), A23(2,4), A23(3,4), A23(4,4)]';



























