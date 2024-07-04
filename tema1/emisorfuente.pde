class Particle {
  PVector position; // Posición de la partícula
  PVector velocity; // Velocidad de la partícula
  float lifespan; // Vida útil de la partícula
  
  Particle(PVector position, PVector velocity) {
    this.position = position.copy();
    this.velocity = velocity.copy();
    this.lifespan = 500; // Vida útil inicial (valor máximo)
  }
  
  void update() {
    velocity.y += 0.1; // Simular la gravedad en las partículas de agua
    position.add(velocity); // Actualizar la posición
    lifespan -= 3; // Reducir la vida útil
  }
  
  void display() {
    stroke(0, 0, 255, lifespan); // Ajustar la opacidad según la vida útil
    fill(0, 0, 255, lifespan);
    ellipse(position.x, position.y, 5, 5); // Dibujar la partícula
  }
  
  boolean isDead() {
    return lifespan <= 0; // Comprobar si la partícula ha muerto
  }
}

ArrayList<Particle> waterParticles = new ArrayList<Particle>(); // Lista de partículas de agua
PVector fountainOrigin; // Origen de la fuente
int particleCount = 0; // Contador de partículas

void setup() {
  size(1920, 1080);
  fountainOrigin = new PVector(width / 2, height / 2); // Origen de la fuente en la parte inferior central
}

void draw() {
  background(255);
  
  updateWaterParticles(); // Actualizar las partículas de agua
  generateWaterParticles(); // Generar nuevas partículas de agua

  // Dibujar las partículas de agua
  for (Particle wp : waterParticles) {
    wp.display();
  }
}

void generateWaterParticles() {
  float magnitude = 10; // Magnitud de la velocidad de la partícula
  int particlesPerFrame = 10; // Número de partículas generadas por cuadro

  // Generar un número fijo de partículas por cuadro
  for (int i = 0; i < particlesPerFrame; i++) {
    int n = particleCount % 7;
    float angle = radians(-(60 + 10 * n)); // Convertir el ángulo a radianes

    PVector position = fountainOrigin.copy();
    PVector velocity = PVector.fromAngle(angle).mult(magnitude); // Crear la velocidad con magnitud y ángulo específicos
    Particle wp = new Particle(position, velocity);
    waterParticles.add(wp);
    
    particleCount++; // Incrementar el contador de partículas
  }
}

void updateWaterParticles() {
  for (int i = waterParticles.size() - 1; i >= 0; i--) {
    Particle wp = waterParticles.get(i);
    wp.update();
    if (wp.isDead()) {
      waterParticles.remove(i);
    }
  }
}

