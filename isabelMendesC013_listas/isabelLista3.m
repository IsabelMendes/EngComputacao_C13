clc;
clear all;
close all;

% Lista 3
%% Exercício 1 - Funções e gráficos

t = 0:0.1:10;
y = 2*sin(3*t);
z = 2*cos(3*t);
length(t)

figure
plot(t,y,'b-',t,z,'r'),grid;

title('Função seno e cosseno')
xlabel('Tempo (s)')
ylabel('Amplitude')
legend ('seno de t', 'cosseno de t')

%% Exercício 2 - Entrada de dados, condição e gráfico

a = str2double( input('Digite o valor de a e tecle enter: ', 's') );

% Validação de entrada para evitar erros
if isnan(a)
    error('Entrada inválida: insira um número para o coeficiente a.');
end

% Verifica sinal do coeficiente
if a > 0
    disp('Coeficiente é positivo');
elseif a == 0
    disp('Coeficiente é igual a 0');
else
    disp('Coeficiente é negativo');
end

% Definição dos vetores
x = -10:1:10;
y = a .* x + 2;   % Cálculo da função 

% Plot principal
figure
plot(x, y, 'g', 'LineWidth', 1.5)
grid on
title('Função de y')
xlabel('Eixo X')
ylabel('Eixo Y')


axes('Position', [0.2 0.5 0.25 0.3]) 
box on 
plot(x, y, 'g', 'LineWidth', 1.5) 
grid on
xlim([-2 2]) 

% Encerra a execução do script/programa após gerar o gráfico
return

%% Exercício 3 - Repetição e organização de gráficos
vetor = zeros(1,5);

for i = 1:5
    vetor(i) = 3 * i;
end    

vetorDobro = 2 * vetor;
x = 1:5;

figure
subplot(2, 1, 1)
plot(x, vetor, 'r-.','LineWidth',2)
xlabel('i')
ylabel('vetor')

subplot(2, 1, 2)
plot(x, vetorDobro)
xlabel('i')
ylabel('Dobro do vetor inicial')   

%% Exercício 4 - Comparação de escalas
t = 0:1:1000;
y = 50000 * exp(-0.05*t);


figure
subplot(2, 1, 1)
plot(t, y, 'r-.', 'LineWidth',2)
grid on
xlabel('Tempo (s)')
ylabel('Exponencial de x')
title('Escala normal')

subplot(2, 1, 2)
grid on
semilogy(t, y, 'LineWidth',2)
xlabel('Tempo (s)')
ylabel('Exponencial de x')
title('Escala logarítmica')

%% Exercício 5 - Gráfico 3D
[x,y] = meshgrid(1:10, 1:20);
z = sin(x) + cos(y);

figure

subplot(2,1,1)
colormap('hot')
shading interp
surf(x,y,z)
xlabel('x')
ylabel('y')
zlabel('z')
title('Superfície 3D da função')

subplot(2,1,2)
contour(z,5)
colormap default
xlabel('x')
ylabel('y')
zlabel('z')
title('Curvas de nível')
