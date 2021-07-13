function controlador = projetarControladorHorizontalBusca(requisitosX,...
    requisitosTheta, planta)
% controlador = projetarControladorHorizontalBusca(requisitosX,
% requisitosTheta, planta) projeta o controlador horizontal com um 
% refinamento atraves de busca em grade para um melhor atendimento aos 
% requisitos. As entradas da funcao sao as structs requisitosX, 
% requisitosTheta e planta, que contem os requisitos da malha horizontal,
% os requisitos da malha de arfagem e os parametros da planta, 
% respectivamente. requisitosX e requisitosTheta sao da forma:
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

% Numero de valores de cada parametro usados na grade
N = 20;

% Gerando os valores na grade
trs = linspace(0.8 * requisitosX.tr, 1.2 * requisitosX.tr, N);
Mps = linspace(0.8 * requisitosX.Mp, 1.2 * requisitosX.Mp, N);

controladorTheta = projetarControladorArfagem(requisitosTheta, planta);

trsim = zeros(N);
Mpsim = zeros(N);

% Iterar sobre a grade de trs e Mps para determinar o par tr e Mp que
% melhor atende aos requisitos
for i=1:N
    tmp.tr = trs(i);
    for j=1:N
        tmp.Mp = Mps(j);
    
        controladorX_tmp = projetarControladorHorizontalAnalitico(tmp, ...
            planta);
        dinamica = obterMalhaHorizontal(controladorX_tmp, ...
            controladorTheta, planta);
        info = stepinfo(dinamica, 'RiseTimeLimits', [0, 1]);
    
        trsim(i,j) = info.RiseTime;
        Mpsim(i,j) = info.Overshoot/100;
    end
end

J = @(trs, Mps) abs(requisitosX.tr - trs)./abs(requisitosX.tr) ...
    + abs(requisitosX.Mp - Mps)./abs(requisitosX.Mp);
measure_error = J(trsim, Mpsim);

[min_vector, idxrow] = min(measure_error);
[~, idxcol] = min(min_vector);
idxrow = idxrow(idxcol);

% selecionando tr e Mp que melhor atendem aos requisitos e calculando
% os ganhos
tmp.tr = trs(idxrow);
tmp.Mp = Mps(idxcol);

controlador = projetarControladorHorizontalAnalitico(tmp, planta);

end