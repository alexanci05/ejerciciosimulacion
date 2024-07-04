float centerX;  // Coordenada x del centro
float centerY;  // Coordenada y del centro
float radius;   // Distancia entre el centro y la bola
float angle;    // Ángulo actual

void setup() {
    size(800, 600);
    
    centerX = width / 2;
    centerY = height / 2;
    radius = 100;
    angle = 0;
}

void draw() {
    background(255);
    
    // Calcular las coordenadas x e y de la bola
    float x = centerX + cos(angle) * radius;
    float y = centerY + sin(angle) * radius;
    
    // Dibujar el centro
    fill(255, 0, 0);
    ellipse(centerX, centerY, 10, 10);
    
    // Dibujar la bola
    fill(0, 0, 255);
    ellipse(x, y, 20, 20);
    
    // Actualizar el ángulo para que la bola dé una vuelta por segundo
    angle += TWO_PI / frameRate;
}
