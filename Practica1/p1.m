
%Programa que dadas las clases de peretencia, hace
%La toma de deciciosn de asignacion de un vector deconocido
%Introduce clases
c1=[0 1 0 3; 0 2 3 0];
c2=[4 4 4 5; 0 3 2 6];
c3=[6 7 7 8; 0 1 3 -2];
c4=[0 2 1 4; 5 3 4 4];
c5=[6 6 6 6; 1 4 3 7];
c6=[10 8 8 9; 5 2 4 5];
vx=input('Dame el valor de x')
vy=input('Dame el calor de y=')
vector=[vx;vy];

%Calculando los centroides
media1=mean(c1,2)
media2=mean(c2,2)
media3=mean(c3,2)


%Graficando
plot(c1(1,:),c1(2,:),'ro','MarkerFaceColor','r','MarkerSize',10)
grid on
hold on

plot(c2(1,:),c2(2,:),'go','MarkerFaceColor','g','MarkerSize',10)
plot(c3(1,:),c3(2,:),'bo','MarkerFaceColor','b','MarkerSize',10)
plot(c4(1,:),c4(2,:),'co','MarkerFaceColor','c','MarkerSize',10)
plot(c5(1,:),c5(2,:),'mo','MarkerFaceColor','m','MarkerSize',10)
plot(c6(1,:),c6(2,:),'yo','MarkerFaceColor','y','MarkerSize',10)


plot(vector(1,:),vector(2,:),'*','MarkerSize',10)

%Calcular las distancias
dist1=norm(vector-media1)
dist2=norm(vector-media2)
dist3=norm(vector-media3)

dist_total=[dist1 dist2 dist3]
minimo=min(dist_total)
dato=find(minimo==dist_total)

fprintf('El vector desconocido pertenece a las clase %d\n',dato)