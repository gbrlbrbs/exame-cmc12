function controlador = projetarControladorVerticalAnalitico(requisitos, planta)
% controlador = projetarControladorVerticalAnalitico(requisitos, planta) 
% projeta o controlador vertical de forma analitica. As entradas da 
% funcao sao as structs requisitos e planta, que contem os requisitos e os 
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

tr = requisitos.tr;
Mp = requisitos.Mp;

xi = sqrt( log(Mp)^2/(pi^2 + log(Mp)^2) );
wn = (pi - acos(xi))/(tr * sqrt(1 - xi^2));

m = planta.m;

controlador.Kd = 7*xi*wn*m;
controlador.Kp = (10*(xi^2) + 1)*(wn^2)*m;
controlador.Ki = 5*xi*(wn^3)*m;

end
