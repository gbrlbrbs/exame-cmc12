function J = fitness_z(K)
% função de fitness para a malha vertical enviado ao CMA-ES
% K é um vetor [Kd, Kp, Ki]'
% J é a função de fitness propriamente dita

Kd = K(1);
Kp = K(2);
Ki = K(3);

planta = obterPlantaMulticoptero();
requisitos = obterRequisitos();
dinamica = tf(Ki, [planta.m, Kd, Kp, Ki]);
info = stepinfo(dinamica, 'RiseTimeLimits', [0, 1]);

trs = info.RiseTime;
Mps = info.Overshoot/100;

J = abs(requisitos.z.tr - trs)./abs(requisitos.z.tr) ...
    + abs(requisitos.z.Mp - Mps)./abs(requisitos.z.Mp);

end