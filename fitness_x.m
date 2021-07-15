function J = fitness_x(K)
% função de fitness para a malha horizontal enviado ao CMA-ES
% K é um vetor [Kd, Kp, Ki]', nesta ordem
% J é a função de fitness propriamente dita

controladorX.Kd = K(1);
controladorX.Kp = K(2);
controladorX.Ki = K(3);

planta = obterPlantaMulticoptero();
requisitos = obterRequisitos();
controladorTheta = projetarControladorArfagem(requisitos.theta, planta);
dinamica = obterMalhaHorizontal(controladorX, controladorTheta, planta);
info = stepinfo(dinamica, 'RiseTimeLimits', [0, 1]);

trs = info.RiseTime;
Mps = info.Overshoot/100;

J = abs(requisitos.x.tr - trs)./abs(requisitos.x.tr) ...
    + abs(requisitos.x.Mp - Mps)./abs(requisitos.x.Mp);

end