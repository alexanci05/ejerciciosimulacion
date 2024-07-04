import java.util.ArrayList; // Importar ArrayList

float x, y; // Posición de la partícula
float v; // Velocidad de la partícula
float amplitude1, amplitude2; // Amplitudes de las funciones osciladoras
float frequency1, frequency2; // Frecuencias de las funciones osciladoras
ArrayList<PVector> path; // Almacenar el recorrido de la partícula

void setup() {
    size(1920, 1080);
    x = 0;
    y = height / 2;
    v = 2;
    amplitude1 = 100;
    amplitude2 = 50;
    frequency1 = 1;
    frequency2 = 2.5;
    path = new ArrayList<PVector>(); // Inicializar el ArrayList
}

void draw() {
    background(0);
    
    // Actualizar la posición de la partícula
    x += v;
    y = height / 2 + amplitude1 * sin(frequency1 * x) + amplitude2 * sin(frequency2 * x);
    
    // Agregar la posición actual al recorrido
    path.add(new PVector(x, y));
    
    
    // Dibujar la partícula
    fill(255, 0, 0);
    ellipse(x, y, 50, 50);
}
