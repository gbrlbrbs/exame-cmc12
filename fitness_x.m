function J = fitness_x(K)

Kd = K(1);
Kp = K(2);
Ki = K(3);

planta = obterPlantaMulticoptero();
requisitos = obterRequisitos();
dinamica = tf(Ki, [planta.m, Kd, Kp, Ki]);
info = stepinfo(dinamica, 'RiseTimeLimits', [0, 1]);

trs = info.RiseTime;
Mps = info.Overshoot/100;

J = abs(requisitos.x.tr - trs)./abs(requisitos.x.tr) ...
    + abs(requisitos.x.Mp - Mps)./abs(requisitos.x.Mp);

end