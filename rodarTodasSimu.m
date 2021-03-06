simus = ['f', 'g'];  % vetor de char para selecionar as simus
planta = obterPlantaMulticoptero();
requisitos = obterRequisitos();
controlador = projetarControladorMulticoptero(requisitos, planta, 'cmaes');

% gerar graficos
for char = simus
    simulacao = simularExperimentoMulticoptero(controlador, planta, char);
    tracarGraficosSimulacao(simulacao);
end

% gerar animaçoes
% cada uma demora 10s, rode por sua conta e risco
% for char = simus(4:6)
%     simulacao = simularExperimentoMulticoptero(controlador, planta, char);
%     fazerAnimacaoMulticoptero(simulacao, planta);
% end