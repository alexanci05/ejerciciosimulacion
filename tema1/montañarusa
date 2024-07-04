float x = 50; // Posición inicial de la partícula en x
float y; // Posición de la partícula en y
float t = 0; // Tiempo inicial
float velocidad_x_base = 1; // Velocidad base en x
float velocidad_x; // Velocidad actual en x
float amplitud = 100; // Amplitud de la oscilación en y
float velocidad_y; // Velocidad en y

void setup() {
  size(800, 600);
  dibujarRecorrido(); // Dibuja el recorrido antes de comenzar la simulación
}

void draw() {
  background(255);
  dibujarRecorrido();

  // Calcular la velocidad en y en función de la derivada de la función sinusoidal
  float velocidad_max = 10; // Velocidad máxima en y cuando está bajando
  float velocidad_min = 1; // Velocidad mínima en y cuando está subiendo
  float derivada_abs = abs(cos(t)); // Valor absoluto de la derivada de sin(t)
  velocidad_y = map(derivada_abs, 0, 1, velocidad_min, velocidad_max);

  // Ajustar la velocidad en x basándose en la velocidad en y
  velocidad_x = map(velocidad_y, velocidad_min, velocidad_max, velocidad_x_base, velocidad_x_base * 2);

  // Calcular la posición de la partícula en x (avance horizontal constante)
  x += velocidad_x;

  // Calcular la posición de la partícula en y usando una función sinusoidal
  y = height / 2 + sin(t) * amplitud;

  // Dibujar la partícula
  fill(255, 0, 0);
  ellipse(x, y, 10, 10);

  // Incrementar el tiempo
  t += 0.05; // Ajusta la velocidad de oscilación según tus necesidades
}

void dibujarRecorrido() {
  float tempX = 50;
  float tempT = 0;
  for (int i = 0; i < width; i++) {
    float tempY = height / 2 + sin(tempT) * amplitud;
    point(tempX, tempY);
    tempX += velocidad_x_base; // Usa la velocidad base en x para el recorrido
    tempT += 0.05;
  }
}
