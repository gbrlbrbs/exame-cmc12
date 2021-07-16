function controlador = projetarControladorHorizontalCMAES(...
    requisitos, planta)
% controlador = projetarControladorHorizontalCMAES(requisitos, planta)
%   Projeta o controlador horizontal a partir do algoritmo de 
%   otimização CMA-ES, diferentemente do projeto a partir de uma busca.
%   Devido a construção das funções de fitness, o algoritmo retorna o vetor
%   de ganhos [Kd, Kp, Ki]' que minimiza o valor que a função calcula. O 
%   valor inicial K0 é dado pelo valor analiticamente calculado, que foi
%   mostrado no relatório que não atende aos requisitos pedidos.
%   
%   requisitos: os requisitos para o controlador vertical
%   planta: os dados do multicóptero;
% 

controladorX = projetarControladorHorizontalAnalitico(requisitos, planta);

K0_x = [controladorX.Kd, controladorX.Kp, controladorX.Ki];
K_x = cmaes('fitness_x', K0_x, 0.1);
controlador.Kd = K_x(1);
controlador.Kp = K_x(2);
controlador.Ki = K_x(3);
end

