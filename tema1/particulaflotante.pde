PVector position = new PVector(); // Posición de la partícula
PVector velocity = new PVector(); // Velocidad de la partícula
PVector acceleration = new PVector(); // Aceleración de la partícula
PVector netForce = new PVector(); // Fuerza neta actuando sobre la partícula
PVector gravityForce = new PVector(0, 9.81); // Fuerza de gravedad
PVector buoyantForce = new PVector(); // Fuerza de flotación
float gravity = -9.81; // Aceleración debida a la gravedad
float timeStep = 0.01; // Incremento de tiempo para la simulación
float mass = 0.01; // Masa de la partícula
float waterLevel; // Nivel del agua
float fluidDensity = 0.000005; // Densidad del fluido
float submergedVolume; // Volumen sumergido de la partícula
float buoyancy; // Fuerza de flotación
float radius = 50; // Radio de la partícula

void setup() {
  size(1920, 1080);
  waterLevel = 2 * height / 3; // Establecer el nivel del agua
  position.x = width / 2; // Posición inicial en x
  position.y = height / 3; // Posición inicial en y
}

void draw() {
  background(0);
  
  updatePhysics(); // Actualizar la física de la partícula

  // Dibujar la partícula
  fill(255, 0, 0);
  ellipse(position.x, position.y, radius * 2, radius * 2);

  // Dibujar el agua
  fill(0, 0, 255, 50);
  rect(0, waterLevel, width, height);
}

void updatePhysics() {
  netForce.set(gravityForce); // Comenzar con la fuerza de gravedad

  if (position.y - radius >= waterLevel) {
    // La partícula está completamente sumergida
    submergedVolume = 4 * PI * radius * radius * radius / 3; // Volumen de la partícula (esfera)
    buoyancy = fluidDensity * gravity * submergedVolume; // Calcular la fuerza de flotación
    netForce.add(0, buoyancy); // Añadir la fuerza de flotación a la fuerza neta
  } else if (position.y + radius > waterLevel) {
    // La partícula está parcialmente sumergida
    float heightSubmerged = position.y + radius - waterLevel;
    float submergedArea = sqrt(2 * heightSubmerged * radius - heightSubmerged * heightSubmerged);
    submergedVolume = (3 * submergedArea * submergedArea + heightSubmerged * heightSubmerged) * PI * heightSubmerged / 6;
    buoyancy = fluidDensity * gravity * submergedVolume; // Calcular la fuerza de flotación
    netForce.set(0, buoyancy); // Establecer la fuerza de flotación en la fuerza neta
  }

  // Calcular la aceleración a partir de la fuerza neta
  acceleration = PVector.div(netForce, mass);
  // Actualizar la velocidad y la posición
  velocity.add(PVector.mult(acceleration, timeStep));
  position.add(PVector.mult(velocity, timeStep));
}
