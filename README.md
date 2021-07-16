# Exame CMC-12

## Alunos: Gabriel Martinz e Marina Moreira

### Como rodar:

Para gerar os gráficos de resposta ao degrau, utiliza as funções `avaliarMalhaArfagem()`, `avaliarMalhaVertical()` e `avaliarMalhaHorizontal()`. Para gerar os gráficos das simulações, utilize o *script* rodarTodasSimu. Este *script* está configurado para gerar controladores otimizados pelo CMA-ES, para mudar para o controlador de busca basta mudar a string `'cmaes'` para `'busca'`. Qualquer outra string gera o controlador analítico. Se quiser, pode adicionar mais simulações a partir do vetor `simus`. Existem 7 simulações, listadas a seguir:

- Simulação a): um voo de 10s com `x_r = 1` e `z_r = 1`;
- Simulação b): uma preparação inicial de 1s com `x_r = 0` e `z_r = 1`, após isso, é comandado `x_r = 1` e `z_r = 1`;
- Simulação c): mesma preparação de b), com o comando sendo `vx_r = 1` (velocidade horizontal = 1 m/s);
- Simulação d): mesmo comando do experimento a), porém uma carga de 0.2 kg é adicionada no tempo t = 3s;
- Simulação e): mesmo comando do experimento c), porém uma força de -2N na direção horizontal empurra o multicóptero a partir de t = 3s;
- Simulação f): curva de Lissajous similar à do relatório, mas com período 8s;
- Simulação g): curva de Lissajous utilizada no relatório.

Todos os gráficos são salvos em `png` na pasta `figures`. Estão inclusos neste repositório os gráficos de respota ao degrau da malha horizontal e da malha vertical.
