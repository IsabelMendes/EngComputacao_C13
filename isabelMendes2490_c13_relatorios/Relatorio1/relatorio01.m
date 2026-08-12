%% Sempre faça
clc;
clear all;
close all;

%% Exercício 1 - Análise de três medições
m1 = input('Digite o valor da primeira medição: ');
m2 = input('Digite o valor da segunda medição: ');
m3 = input('Digite o valor da terceira medição: ');

v = [m1 m2 m3];
media = mean(v);
fprintf('A média das medições é: %.2f\n', media);
maiorValor = max(v);
disp(['O maior valor das medições é: ', num2str(maiorValor)]);
menorValor = min(v);
disp(['O menor valor das medições é: ', num2str(menorValor)]);

if media >= 8
    disp('Resultado alto');
elseif (media>=5) && (media<8)
    disp('Resultado intermediário');
else 
    disp('Resultado baixo');
end

%% Exercício 2 - Processamento de um vetor com for

A = [3 8 2 10 5 7 1 6];
B = zeros(size(A));

for i = 1:numel(A)
    %numel(A) retorna todos os elementos de A
    if A(i) >= 6
        B(i) = A(i) * 2; 
    else
        B(i) = A(i) + 3; 
    end
end
% Mostre:
disp('O vetor original de A é:');
disp(A);
disp('O vetor resultante de B é:');
disp(B);
somaB = sum(B);
disp(['A soma dos elemento de B é: ', num2str(somaB)]);
mediaB = mean(B);
fprintf('A média dos elementos de B é: %.2f\n', mediaB);
maiorB = max(B);
disp(['O maior elemento de B é: ', num2str(maiorB)]);
menorB = min(B);
disp(['O menor elemento de B é: ', num2str(menorB)]);

%% Exercício 3 - Identificação de números pares em um vetor
A = [14 7 20 9 6 11 18 5];
B = zeros(size(A));
cont = 0;
for i = 1:numel(A)
    if rem(A(i),2) == 0
        B(i) = A(i);
        cont = cont + 1;
    else 
        B(i) = 0;
    end
end
disp('O vetor resultante de B é:');
disp(B);
disp(['A quantidade de números pares é: ', num2str(cont)]);

%% Exercício 4 - Calculadora com menu usando switch
num1 = input('Digite o primeiro valor: ');
num2 = input('Digite o segundo valor: ');
disp('Menu de operação:');
disp('1 - Soma');
disp('2 - Subtração');
disp('3 - Multiplicação');
disp('4 - Divisão');
opcao = input('Digite o número da operação desejada: ');

switch opcao
    case 1
        resultado = num1 + num2;
        fprintf('Resultado da soma: %.2f\n', resultado);
    case 2
        resultado = num1 - num2;
        fprintf('Resultado da subtração: %.2f\n', resultado);
    case 3
        resultado = num1 * num2;
        fprintf('Resultado da multiplicação: %.2f\n', resultado);
    case 4
        if num2 ~= 0
            resultado = num1 / num2;
            fprintf('Resultado da divisão: %.2f\n', resultado);
        else
            disp('Erro: Divisão por zero. Operação não pode ser realizada');
        end
    otherwise
        disp('Opção inválida.');
end

%% Exercício 5 - Acumulador com while
soma = 0;
contador = 0;

while soma <= 4
    valor = rand;
    soma = soma + valor; 
    contador = contador + 1;
    disp(['Valor sorteado: ', num2str(valor)]);
    disp(['Soma atual: ', num2str(soma)]);
end
if contador > 8
    disp(['Muitas repetiçoes: ' num2str(contador)]);
    
else 
    disp(['Poucas repetiçoes: ' num2str(contador)]);
end

%% Exercício 6 - Processamento de uma matriz com dois laços for
A = [2 7 4 9; 6 1 8 3];
B = zeros(size(A));

for j = 1:size(A,1) % cria um vetor que começa em 1 e vai até o número de linhas da matriz
    for i = 1:size(A,2)
        if A(j,i) > 5
            B(j,i) = 2 * A(j,i);
        else
            B(j,i) = A(j,i) + 5;
        end
    end
end

% Mostre:
disp(" A matriz A é:");
disp(A);
disp('A matriz resultante de B é:');
disp(B);

disp('A transposta da matriz A é:');
disp(transpose(A));

disp('A primeira linda de B é:');
disp(B(1,:));

disp('A terceira coluna de B é:');
disp(B(:, 3));

%% Exercício 7 - Função com duas saídas para analiar um vetor
A = [5 12 7 3 9 14];

% Chamar a função analisa_vetor:
[somaA, mediaA] = analisa_vetor (A);
fprintf('Soma de A é: %.2f\n', somaA);
fprintf('Média de A é: %.2f\n', mediaA);
if mediaA > 8
    disp('Média elevada.');
else
    disp('Média abaixo de 8.');
end

%% Exercício 8 - Função para tranformar uma matriz
A = [1 5 3 8;6 2 7 4];
B = zeros(size(A));

% Chamar a função transforma_matriz

resultadoTransformado = transforma_matriz(A);
disp('A matriz transformada é:');
disp(resultadoTransformado);

%% Exercício 9 - Entrada como texto e conversão numérica
primeiroValor = input('Digite o primeiro valor: ', 's');
segundoValor = input ('Digite o segundo valor: ', 's');
disp(primeiroValor);
disp(segundoValor);

% Converter os valores de entrada para numéricos
num1 = str2num(primeiroValor);
num2 = str2num(segundoValor);
soma = num1 + num2;
fprintf('A soma dos dois valores é: %.2f\n', soma);
mult = num1*num2;
fprintf('A multiplicação dos dois valores é:  %.2f\n', mult);
if soma > 20
    disp('Soma alta');
elseif soma == 20
    disp('Soma igual a 20');
else
    disp ('Soma baixa');
end

%% Exercício 10 - Desafio integrador: análise de dados e escolha de gráfico
dados = [12 18 10 25 15];
% Mostre
somaDados = sum(dados);
fprintf('A soma dos dados é: %.2f\n', somaDados);
mediaDados = mean(dados);
fprintf('A média dos dados é: %.2f\n', mediaDados);
maiorValor = max(dados);
fprintf('O maior valor é: %.f\n', maiorValor);
menorValor = min(dados);
fprintf('O menor valor é: %.f\n', menorValor);

count = 0;
for i = 1:numel(dados)
    if dados(i) >= mediaDados
    count = count + 1;
    end
end    
disp(['Quantidade de elementos com valores maiores que a média é: ' num2str(count)])

if count >= (numel(dados)/2)
    disp('Maioria dos valores acima ou igual à média');
else
    disp('Menos da metade dos valores acima ou igual à média');
end

% Gráficos
disp('Opções de gráficos')
disp('1 - Gráfico de barras')
disp('2 - Gráfico de pizza')
opcao = input('Digite a opcão desejada: ', 's');

switch opcao
    case '1'
        bar(dados);
        title('Gráfico de barras dos Dados');
    case '2'
        pie3(dados);
        title('Gráfico de pizza dos Dados');
    otherwise
        warning('Nenhum gráfico foi criado'); 
end

