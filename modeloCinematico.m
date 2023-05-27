function p = modeloCinematico(w)

pkg load symbolic
%%Variables
pi1 = sym('pi');

d1 = 15;
a2 = 7;
a3 = 3;

q1 = w(1);
q2 = w(2);
q3 = w(3);

%%Parametros
q = [q1+pi1/2 q2 q3];
d = [d1 0 0];
a = [0 a2 a3];
alfa = [-90 0 0] * pi1 / 180 ;

%%Matrices de DH
A01 = matrizDH(q(1), d(1), a(1), alfa(1));
A12 = matrizDH(q(2), d(2), a(2), alfa(2));
A23 = matrizDH(q(3), d(3), a(3), alfa(3));

%%Modelo cinematico
T = A01*A12*A23;

T1 = eval(T);
px = T1(1,4)
py = T1(2,4)
pz = T1(3,4)
p = [px py pz];

end
