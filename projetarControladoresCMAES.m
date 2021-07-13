function [controladorZ, controladorX] = ...
    projetarControladoresCMAES(requisitos, planta)
% [controladorZ, controladorX] = projetarControladoresCMAES(requisitos, planta)
%   Detailed explanation goes here
controladorZ = projetarControladorVerticalAnalitico(requisitos.z, planta);
controladorX = projetarControladorHorizontalAnalitico(requisitos.x, planta);

K0_z = [controladorZ.Kd, controladorZ.Kp, controladorZ.Ki];
K_z = cmaes('fitness_z', K0_z, 0.1);
controladorZ.Kd = K_z(1);
controladorZ.Kp = K_z(2);
controladorZ.Ki = K_z(3);

K0_x = [controladorX.Kd, controladorX.Kp, controladorX.Ki];
K_x = cmaes('fitness_x', K0_x, 0.1);
controladorX.Kd = K_x(1);
controladorX.Kp = K_x(2);
controladorX.Ki = K_x(3);
end

