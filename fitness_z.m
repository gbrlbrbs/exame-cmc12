function f = fitness_z(K)

Kd = K(1);
Kp = K(2);
Ki = K(3);

planta = obterPlantaMulticoptero();
requisitos = obterRequisitos();
dinamica = tf(Ki, [planta.m, Kd, Kp, Ki]);
info = stepinfo(dinamica, 'RiseTimeLimits', [0, 1]);

trise = info.RiseTime;
Mp = info.Overshoot/100;

J = @(trs, Mps) abs(requisitos.z.tr - trs)./abs(requisitos.z.tr) ...
    + abs(requisitos.z.Mp - Mps)./abs(requisitos.z.Mp);

f = J(trise, Mp);

end