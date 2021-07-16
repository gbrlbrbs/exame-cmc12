function controlador = projetarControladorVerticalCMAES(requisitos, planta)
% controlador = projetarControladorVerticalCMAES(requisitos, planta)
%   Projeta o controlador vertical a partir do algoritmo de 
%   otimização CMA-ES, diferentemente do projeto a partir de uma busca.
%   Devido a construção das funções de fitness, o algoritmo retorna o vetor
%   de ganhos [Kd, Kp, Ki]' que minimiza o valor que a função calcula. O 
%   valor inicial K0 é dado pelo valor analiticamente calculado, que foi
%   mostrado no relatório que não atende aos requisitos pedidos.
%   
%   requisitos: os requisitos para o controlador vertical
%   planta: os dados do multicóptero;
%   

controladorZ = projetarControladorVerticalAnalitico(requisitos, planta);

K0_z = [controladorZ.Kd, controladorZ.Kp, controladorZ.Ki];
K_z = cmaes('fitness_z', K0_z, 0.1);
controlador.Kd = K_z(1);
controlador.Kp = K_z(2);
controlador.Ki = K_z(3);
end

