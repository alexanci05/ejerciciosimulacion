float x = 50; // Posición inicial de la partícula en x
float y; // Posición de la partícula en y
float t = 0; // Tiempo inicial
float velocidad_x = 1; // Velocidad en x
float amplitud = 100; // Amplitud de la oscilación en y
float velocidad_y; // Velocidad en y

void setup() {
  size(800, 600);

}

void draw() {
  background(255);

  
  // Calcular la posición de la partícula en x (avance horizontal constante)
  x += velocidad_x;
  
  // Calcular la velocidad en y en función de la derivada de la función sinusoidal
  float velocidad_max = 10; // Velocidad máxima en y cuando está bajando
  float velocidad_min = 1; // Velocidad mínima en y cuando está subiendo
  float derivada = cos(t); // Derivada de sin(t)
  
  // Ajustar velocidad en y basada en la dirección del movimiento
  if (derivada < 0) { // Bajando
    velocidad_y = map(abs(derivada), 0, 1, velocidad_max, velocidad_min);
  } else { // Subiendo
    velocidad_y = map(abs(derivada), 0, 1, velocidad_min, velocidad_max);
  }
  
  // Calcular la posición de la partícula en y usando una función sinusoidal
  y = height / 2 + sin(t) * amplitud;
  
  // Dibujar la partícula
  fill(255, 0, 0);
  ellipse(x, y, 10, 10);
  
  // Incrementar el tiempo
  t += 0.05 * velocidad_y / velocidad_max; // Ajusta la velocidad de oscilación según la velocidad en y
}


