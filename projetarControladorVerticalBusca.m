function controlador = projetarControladorVerticalBusca(requisitos, planta)
% controlador = projetarControladorVerticalBusca(requisitos, planta) 
% projeta o controlador vertical com um refinamento atraves de busca em 
% grade para um melhor atendimento aos requisitos. As entradas da funcao 
% sao as structs requisitos e planta, que contem os requisitos e os 
% parametros da planta, respectivamente. Os requisitos sao:
% requisitos.tr: tempo de subidade de 0 a 100%.
% requisitos.Mp: sobressinal.
% A planta eh dada por:
% planta.m: massa.
% planta.J: inercia.
% planta.l: distancia entre os rotores.
% planta.g: aceleracao da gravidade.
% A saida da funcao eh a struct controlador com:
% controlador.Kp: ganho proporcional.
% controlador.Ki: ganho integrativo.
% controlador.Kd: ganho derivativo.

% controlador = projetarControladorVerticalAnalitico(requisitos, planta);
% K0 = [controlador.Kd; controlador.Kp; controlador.Ki];
% func = @fitness;
% Kmin = cmaes(func, K0, 1)

% Numero de valores de cada parametro usados na grade
N = 20;

% Gerando os valores na grade
trs = linspace(0.8 * requisitos.tr, 1.2 * requisitos.tr, N);
Mps = linspace(0.8 * requisitos.Mp, 1.2 * requisitos.Mp, N);

trsim = zeros(N);
Mpsim = zeros(N);

% Iterar sobre a grade de trs e Mps para determinar o par tr e Mp que
% melhor atende aos requisitos
for i=1:N
    tmp.tr = trs(i);
    for j=1:N
        tmp.Mp = Mps(j);
    
        controlador_tmp = projetarControladorVerticalAnalitico(tmp, planta);
        dinamica = obterMalhaVertical(controlador_tmp, planta);
        info = stepinfo(dinamica, 'RiseTimeLimits', [0, 1]);
    
        trsim(i,j) = info.RiseTime;
        Mpsim(i,j) = info.Overshoot/100;
    end
end

J = @(trs, Mps) abs(requisitos.tr - trs)./abs(requisitos.tr) ...
    + abs(requisitos.Mp - Mps)./abs(requisitos.Mp);
measure_error = J(trsim, Mpsim);

[min_vector, idxrow] = min(measure_error);
[~, idxcol] = min(min_vector);
idxrow = idxrow(idxcol);

% selecionando tr e Mp que melhor atendem aos requisitos e calculando
% os ganhos
tmp.tr = trs(idxrow);
tmp.Mp = Mps(idxcol);

controlador = projetarControladorVerticalAnalitico(tmp, planta);

% mostrar o valor de tr e Mp que foi escolhido
% disp('A busca resultou em:');
% disp(tmp);

end