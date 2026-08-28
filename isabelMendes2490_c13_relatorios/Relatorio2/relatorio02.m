clc; 
clear all;
close all;
%% Relatório 02 - Exercício 1: Sistema massa-atrito e comparação de gráficos

% Parâmetros da Caixa Branca
M1 = 2; 
B1 = 3; 
M2 = 4;
B2 = 6;   

% Numerador e Denominadores da função de transferência
num = 1;  
den1 = [M1 B1]; 
den2 = [M2 B2];  

% Criando as funções de transferência
G1 = tf(num, den1); 
G2 = tf(num, den2); 

disp('Funções de transferência: ');
display(G1);
display(G2);

t = 0:1:20;
y1 = step(G1, t); 
y2 = step(G2, t);

% Primeira figura - Resposta ao degrau dos dois sistemas juntos
figure(1);
plot(t, y1, 'k-', 'LineWidth', 1.5); 
hold on;
plot(t, y2, 'r-', 'LineWidth', 1.5);
plot(t, ones(size(t)), 'b--', 'LineWidth', 1.5); % Entrada unitária
hold off;
ylim([0 1.2]);

% Configurações do gráfico principal
title('Resposta ao Degrau Unitário - Sistemas Comparados');
xlabel('Tempo (s)');
ylabel('Velocidade (m/s)');
legend('Sistema 1 ', 'Sistema 2', 'Força Unitária', 'Location', 'southeast');
grid on;

% Criação da pequena janela interna (Zoom 0 a 5 segundos)
ax_zoom = axes('Position', [0.55, 0.40, 0.32, 0.32]); 
plot(ax_zoom, t, y1, 'k-', 'LineWidth', 1.5); hold(ax_zoom, 'on');
plot(ax_zoom, t, y2, 'r-', 'LineWidth', 1.5);
plot(ax_zoom, t, ones(size(t)), 'b--', 'LineWidth', 1.5);
hold(ax_zoom, 'off');

xlim(ax_zoom, [0 5]);
ylim(ax_zoom, [0 0.4]);
grid(ax_zoom, "on");

%Segunda figura
figure(2)
subplot(2,1,1);
plot(t, y1, 'k ', "LineWidth", 1.5);
grid on;
xlabel("Tempo (s)");
ylabel("Velocidade (m/s)");
title("Resposta do Sistema 1");


subplot(2,1,2);
plot(t, y2, 'r ', "LineWidth", 1.5);
grid on;
xlabel("Tempo (s)");
ylabel("Velocidade (m/s)");
title("Resposta do Sistema 2");

%% Exercício 2 - Circuito RC e comparação de escalas — Caixa Cinza

R = 2000;
tau = 2.5;
C = tau/R;

num = 1;

% Denominador da funcao de transferencia
den = [R*C 1];

% Criando a funcao de transferencia do circuito
G1 = tf(num, den);
disp('Função de tansferência: ');
display(G1);

% Resposta ao degrau

figure(1)
step(G1, 15)
grid on

xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC - Caixa cinza")

% Vetor de resistências e constante de tempo
Rteste = 100:100:1000;
tauResultado = Rteste*C;

figure(2)
subplot(2,2,1)
plot(Rteste, tauResultado)
xlabel('resistência')
ylabel('tau')
title('Escala comum')
grid on

subplot(2,2,2)
semilogy(Rteste, tauResultado)
xlabel('resistência')
ylabel('tau')
title('Escala log de y')
grid on

subplot(2,2,3)
semilogx(Rteste, tauResultado)
xlabel('resistência')
ylabel('tau')
title('Escala log de x')
grid on

subplot(2,2,4)
loglog(Rteste, tauResultado)
xlabel('resistência')
ylabel('tau')
title('Escala log dos eixos')
grid on

%% Exercício 3 - Identificação e visualização de dados experimentais
%Caixa preta

t = (0:25)';

% u = sinal de entrada aplicado ao sistema
u = [0 0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1];

% y = sinal de saida medido no experimento
y = [0.008 0.012 0.006 0.010 0.020 0.382 0.671 0.903 1.082 1.226 1.335 1.425 1.492 1.547 1.587 1.618 1.642 1.660 1.674 1.684 1.692 1.698 1.702 1.706 1.709 1.711];

% Convertendo os sinais para vetores coluna
u = u(:);
y = y(:);

% Visualizacao dos dados do experimento

figure(1)

subplot(2,1,1)
plot(t, u, 'm ')
grid on
xlabel("Tempo (s)")
ylabel("Entrada u")
title("Dados do experimento")
ylim([0 1.5]);
 
subplot(2,1,2)
plot(t, y, 'y ')
grid on
xlabel("Tempo (s)")
ylabel("Saida y")

figure(2)
plot3(u,y,t, 'm-o')
grid on
xlabel('x')
ylabel('y')
zlabel('t')
title('Representação Simultânea: Tempo x Entrada x Saída');


% Identificacao do sistema

% Ts = tempo de amostragem dos dados
Ts = 1;

% Organizando entrada, saida e tempo de amostragem
dados = iddata(y, u, Ts);

% Estimando uma funcao de transferencia
% tfest(dados, quantidade de polos, quantidade de zeros)
G1 = tfest(dados, 1, 0);
disp('Função de tansferência: ');
display(G1);

% Comparacao entre os dados e o modelo identificado

figure(3)
compare(dados, G1)
grid on

% Resposta ao degrau do modelo identificado

figure(4)
step(G1, 25)
grid on

xlabel("Tempo (s)")
ylabel("Saida")
title("Modelo identificado - Caixa preta")

%% Exercício 4 - Análise de diferentes circuitos RC -
% Caixa cinza

R1 = 1000;
tau1 = 1.2;
R2 = 2000;
tau2 = 2.8;
R3 = 3000;
tau3 = 3.9;
R4 = 5000;
tau4 = 7;

R = [R1, R2, R3, R4];
tau = [tau1, tau2, tau3, tau4];

C1 = tau1/R1;
C2 = tau2/R2;
C3 = tau3/R3;
C4 = tau4/R4;

C = [C1, C2, C3, C4];
disp('Valores de Capacitância (C):');
disp(C);

figure
plot3(R,tau,C, 'b-o')
grid on
xlabel('Resistência')
ylabel('Constante de tempo')
zlabel('Capacitância')
title('Análise de diferentes circuitos RC');

%Com base no experimento 3:
num = 1;
den = [R3*C3 1];

G1 = tf(num, den);
disp('Função de tansferência: ');
display(G1);

% Resposta ao degrau

figure(2)
step(G1, 20)
grid on
xlabel("Tempo (s)")
ylabel("Tensao de saida (V)")
title("Circuito RC do experimento 3 - Caixa cinza")
ylim([0 1.2])

t = 0:5;
y_exp3 = step(G1, t);

% [posicao horizontal, posicao vertical, largura, altura]
%axes('Position',[0.2 0.3 0.2 0.4])% cria gráfico menor dentro da figura

%box on % Mostra a borda da nova janela
%plot (5,y_exp3,'g')
%grid on

% Criação da pequena janela interna (Zoom 0 a 5 segundos)
ax_zoom = axes('Position', [0.55, 0.40, 0.32, 0.32]); 
plot(ax_zoom, t, y_exp3, 'k-', 'LineWidth', 1.5); hold(ax_zoom, 'on');

plot(ax_zoom, t, ones(size(t)), 'b--', 'LineWidth', 1.5);
hold(ax_zoom, 'off');

xlim(ax_zoom, [0 5]);
grid(ax_zoom, "on");


%% Exercício 5 - Análise completa de três tipos de modelagem

%Sistema A - Caixa branca
M = 3;
B = 5;
num = 1;
denA = [M B];
G1 = tf(num, denA);
disp('Função de transferência do Sistema A: ');
display(G1);

%Sistema B - Caixa cinza
R = 1500;
tau = 3;
num = 1;
C = tau/R;
disp('A capacitância do sistema B é: ')
disp(C)
% Criando a função de transferência do Sistema B
denB = [R tau];
G2 = tf(num, denB);
disp('Função de transferência do Sistema B: ');
display(G2);

% Sistema C - Caixa preta
t = (0:20)'; 
u = [0 0 0 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1]'; 
y = [0.010 0.006 0.012 0.018 0.408 0.706 0.934 1.103 1.229 1.322 1.391 1.441 1.479 1.505 1.526 1.540 1.551 1.558 1.564 1.568 1.571]'; 
Ts = 1;  

dadosC = iddata(y, u, Ts); 
G3 = tfest(dadosC, 1, 0); 
disp('Função de transferência do Sistema C: '); 
display(G3);  

%Criar uma figura com os três gráficos
t = 0:0.1:20;

figure(1)

subplot(3,1,1);
step(G1, t);
title('Sistema A');
grid on;
xlabel('Tempo');
ylabel('Amplitude');

subplot(3,1,2);
step(G2, t);
title('Sistema B');
grid on;
xlabel('Tempo');
ylabel('Amplitude');

% --- Subplot 3: Sistema C (Caixa Preta) ---
subplot(3, 1, 3);

% Converte o modelo identificado idtf para a classe tf padrão, limpando incompatibilidades
G3_padrao = tf(G3); 

% Força os vetores de tempo e entrada a serem vetores coluna estritos compatíveis
t_estimado = (0:length(u)-1)'; 
u_coluna = u(:);                

% Simula o comportamento dinâmico exato do modelo estimado
lsim(G3_padrao, u_coluna, t_estimado); 

title('Sistema C');
xlabel('Tempo');
ylabel('Amplitude');
xlim([0 20]); 
grid on;

%Gráficos do Sistema C
figure(4);
compare(dadosC, G3);
grid on;
title('Comparação: Dados Experimentais vs Modelo Identificado');
xlabel('Tempo');
ylabel('Saída');


%Explicando os sistemas:
%Caixa branca - Sistema A: Todos os parâmetros são conhecidos, logo o
%sistema é transparente e de fácil compreensão.

%Caixa Cinza - Sistema B: Usa-se dados de tau e resistência para o cálculo 
% indireto da capacitância, 
% tornando o sistema compreensivo de maneira geral.

%Caixa preta - Sistema C: Não se sabe como o sistema funciona por dentro.
%Há uma tentativa de aproximação matemática de uma função transferência.
