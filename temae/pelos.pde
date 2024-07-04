// Damped spring between two particles:
//
// Fp1 = Fe - Fd
// Fp2 = -Fe + Fd = -(Fe - Fd) = -Fp1
//
//    Fe = Ke·(l - l0)·eN
//    Fd = -Kd·eN·v
//
//    e = s2 - s1  : current elongation vector between the particles
//    l = |e|      : current length
//    eN = e/l     : current normalized elongation vector
//    v = dl/dt    : rate of change of length

public class DampedSpring
{
   Particle part1;     // Primera partícula unida al resorte
   Particle part2;     // Segunda partícula unida al resorte

   float elasticConstant;        // Constante elástica (N/m)
   float dampingCoefficient;     // Coeficiente de amortiguamiento (kg/m)

   float restLength;             // Longitud en reposo (m)
   float currentLength;          // Longitud actual (m)
   float previousLength;
   float lengthChangeRate;       // Tasa de cambio de longitud actual (m/s)

   PVector elongationVector;     // Vector de elongación actual (m)
   PVector normalizedElongationVector; // Vector de elongación normalizada actual (sin unidades)
   PVector force;                // Fuerza aplicada por el resorte en la partícula 1 (la fuerza en la partícula 2 es -force) (N)
   
   boolean enabled; // Para habilitar/deshabilitar el resorte

   DampedSpring(Particle p1, Particle p2, float l0) {
      part1 = p1;
      part2 = p2;
      elasticConstant = Ke;
      restLength = l0;
      previousLength = l0;

      force = new PVector();
      elongationVector = new PVector();
      normalizedElongationVector = new PVector();
   }

   Particle getFirstParticle() {
      return part1;
   }

   Particle getSecondParticle() {
      return part2;
   }

   void update(float simStep) {
      elongationVector = PVector.sub(part2.getPosition(), part1.getPosition());
      normalizedElongationVector = elongationVector.copy().normalize();
      currentLength = elongationVector.mag();
      float elasticForce = elasticConstant * (currentLength - restLength);
      PVector elasticForceVector = PVector.mult(normalizedElongationVector, elasticForce);
      force.set(elasticForceVector);

      applyForces();
      
      previousLength = currentLength;
   }

   void applyForces() {
      part1.addExternalForce(force);
      part2.addExternalForce(PVector.mult(force, -1.0));
   }

   boolean isEnabled() {
      return enabled;
   }
   
   void render() {
      line(part1.position.x, part1.position.y, part2.position.x, part2.position.y);
   }

}

public class Hilo
{
   
    PVector startPosition;
    float length;
    ArrayList<DampedSpring> dampers;
    ArrayList<Particle> particles;

    Hilo(PVector pos) {
        startPosition = pos;
        length = hairLength;
        dampers = new ArrayList<DampedSpring>();
        particles = new ArrayList<Particle>();
        float springLength = hairLength / numSprings;
        for (int i = 0; i <= numSprings; i++) {
            particles.add(new Particle(new PVector(startPosition.x + i * springLength, startPosition.y)));
            if (i > 0) {
                dampers.add(new DampedSpring(particles.get(i - 1), particles.get(i), springLength));
            }
        }
    }

    void update(float simStep) {
        for (int i = 0; i < dampers.size(); i++) {
            dampers.get(i).update(simStep);
        }
        for (int i = 1; i < particles.size(); i++) {
            particles.get(i).update(simStep);
        }
    }

    void render() {
        for (int i = 0; i < dampers.size(); i++) {
            dampers.get(i).render();
        }
    }
}

static int _lastParticleId = 0; //<>//

public class Particle
{
   int id;          // Identificador único para cada partícula

   PVector position; // Posición (m)
   PVector velocity; // Velocidad (m/s)
   PVector acceleration; // Aceleración (m/(s*s))
   PVector force;    // Fuerza (N)
   float mass;       // Masa (kg)

   Particle(PVector pos) {
      id = lastParticleId++;

      position = pos.copy();
      velocity = new PVector(0, 0);
      acceleration = new PVector(0, 0);
      force = new PVector(0, 0);
      mass = massConstant;
   }

   void update(float simStep) {
      applyGravity();
      PVector dampingForce = PVector.mult(velocity, -dampingFactor);
      force.add(dampingForce);

      acceleration = PVector.div(force, mass);
      velocity.add(PVector.mult(acceleration, simStep));
      position.add(PVector.mult(velocity, simStep));

      force.set(0.0, 0.0);
   }

   int getId() {
      return id;
   }

   PVector getPosition() {
      return position;
   }

   void setPosition(PVector pos) {
      position = pos.copy();
      acceleration.set(0.0, 0.0);
      force.set(0.0, 0.0);
   }

   void setVelocity(PVector vel) {
      velocity = vel.copy();
   }

   void applyGravity() {
      PVector gravityForce = new PVector(0, gravity * mass);
      force.add(gravityForce);
   }

   void addExternalForce(PVector extForce) {
      force.add(extForce);
   }
}


// Simulation values:

static int lastParticleId = 0;

final boolean REAL_TIME = true;
final float TIME_ACCEL = 1.0;
final int DRAW_FREQ = 60;
final int DISPLAY_SIZE_X = 1920;
final int DISPLAY_SIZE_Y = 1080;

final float TS = 0.01;
final float gravity = 9.81;

final int numHairs = 50;
final int numSprings = 40;
final float hairLength = 200.0;
final float massConstant = 1;
final float Ke = 900;
final float dampingFactor = 0.01;

float simTimeStep;
int lastDrawTime = 0;
float deltaTimeDraw = 0.0;
float simTime = 0.0;
float elapsedTime = 0.0;

ArrayList<Hilo> pelos;

void settings() {
   size(DISPLAY_SIZE_X, DISPLAY_SIZE_Y);
}

void setup() {
   frameRate(DRAW_FREQ);
   lastDrawTime = millis();
   initializeSimulation();
}

void initializeSimulation() {
   simTime = 0.0;
   simTimeStep = TS * TIME_ACCEL;
   elapsedTime = 0.0;
 pelos = new ArrayList<Hilo>();
   for (int i = 0; i < numHairs; i++) {
      PVector pos = new PVector(width / 2 + random(-100, 100), height / 3 + random(-50, 50));
     pelos.add(new Hilo(pos));
   }
}

void draw() {
   int now = millis();
   deltaTimeDraw = (now - lastDrawTime) / 1000.0;
   elapsedTime += deltaTimeDraw;
   lastDrawTime = now;

   background(255);
   drawEnvironment();
   updateSimulation();
}

void drawEnvironment() {
   for (int i = 0; i < pelos.size(); i++)
     pelos.get(i).render();
}

void updateSimulation() {
   for (Hilo h : pelos)
      h.update(simTimeStep);
   simTime += simTimeStep;
}
