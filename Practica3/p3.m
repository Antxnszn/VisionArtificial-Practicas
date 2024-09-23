clc; % limpia pantalla
clear; % limpia todas las variables
close all; % cierra todos los procesos
warning off all;
continuarClases = 'S';
while continuarClases ~= 'N'

n_clases = input('Seleccione numero de clases: ');
n_representantes = input('Seleccione el numero de representantes que tendran las clases: ');
colores = {'ro', 'go', 'bo', 'co', 'mo', 'yo', 'ko'};
clases = cell(1, n_clases);

for c = 1:n_clases
    fprintf('Seleccione la posición en x del vector %d: ', c);
    px = input('');
    fprintf('Seleccione la posición en y del vector %d: ', c);
    py = input('');
    p = [px; py];
    fprintf('Seleccione la dispersion en x del vector %d: ', c);
    dx = input('');
    fprintf('Seleccione la dispersion en y del vector %d: ', c);
    dy = input('');
    d = [dx; dy];
    fprintf('\n');

    % Genera la matriz de puntos para cada clase
    clases{c} = p + randn(2, n_representantes) .* d;
end

continuarPuntos = 'S';
while continuarPuntos ~= 'N'

vx = input('Dame el valor de x = ');
vy = input('Dame el valor de y = ');
vector = [vx; vy];
figure; % Abre una nueva figura
plot(vector(1), vector(2), 'k*', 'MarkerSize', 10);
hold on;
grid on;

for i = 1:n_clases
    plot(clases{i}(1, :), clases{i}(2, :), colores{mod(i-1, length(colores)) + 1}, 'MarkerFaceColor', colores{mod(i-1, length(colores)) + 1}(1), 'MarkerSize', 10);
end 

legend_items = [{'Vector desconocido'}, strcat('Clase ', arrayfun(@num2str, 1:n_clases, 'UniformOutput', false))];
legend(legend_items);

% SELECCIONAR MÉTODO DE DISTANCIA
fprintf('Elige el método de cálculo de distancia:\n1. Euclidiana\n2. Mahalanobis\n3. Teorema de Bayes\n');
opcion_distancia = input('Introduce el número de la opción: ');

% CALCULAR CENTROIDES
centroides = zeros(2, n_clases);
for i = 1:n_clases
    centroides(:, i) = mean(clases{i}, 2); % Media por columnas para obtener el centroide
end

% CALCULAR LAS DISTANCIAS O PROBABILIDADES CON BAYES
distancias = zeros(1, n_clases);
switch opcion_distancia
    case 1 % Distancia Euclidiana
        for i = 1:n_clases
            distancias(i) = norm(vector - centroides(:, i)); % Distancia euclidiana
        end
    case 2 % Distancia de Mahalanobis
        for i = 1:n_clases
            cov_matrix = cov(clases{i}'); % Matriz de covarianza
            distancias(i) = sqrt((vector - centroides(:, i))' * inv(cov_matrix) * (vector - centroides(:, i))); % Distancia de Mahalanobis
        end
    case 3 % Teorema de Bayes
        probabilidades_a_priori = ones(1, n_clases) / n_clases; % Probabilidad a priori uniforme
        verosimilitud = zeros(1, n_clases);
        for i = 1:n_clases
            cov_matrix = cov(clases{i}'); % Matriz de covarianza
            cov_det = det(cov_matrix);
            cov_inv = inv(cov_matrix);
            verosimilitud(i) = (1 / ((2 * pi) ^ (2/2) * sqrt(cov_det))) * exp(-0.5 * (vector - centroides(:, i))' * cov_inv * (vector - centroides(:, i))); % Función de densidad Gaussiana
        end
        
        probabilidades_posteriori = verosimilitud .* probabilidades_a_priori;
        probabilidades_posteriori = probabilidades_posteriori / sum(probabilidades_posteriori); % Normalización
        [~, indice] = max(probabilidades_posteriori);
end

% DETERMINAR A QUÉ CLASE PERTENECE
if opcion_distancia ~= 3
    [minimo, indice] = min(distancias);
    if minimo > 1000 % Criterio de no pertenencia
        fprintf('El vector desconocido NO pertenece a ninguna clase\n');
    else
        fprintf('El vector desconocido pertenece a la clase %d\n', indice);
    end
else
    fprintf('El vector desconocido pertenece a la clase %d\n', indice);
end

continuarPuntos = upper(input('¿Deseas probar con otro vector? S/N\n', 's'));
end
continuarClases = upper(input('¿Deseas probar con otras clases? S/N\n', 's'));
end
disp('Adios');
