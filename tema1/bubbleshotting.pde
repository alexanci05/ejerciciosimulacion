int shooterX, shooterY; 
int bubbleX, bubbleY; 
float bubbleSpeed = 5; 
float dx, dy; // Dirección del movimiento de la burbuja
boolean shooting = false; // Indica si se está disparando una burbuja

void setup() {
    size(1920, 1080);
    shooterX = width / 2;
    shooterY = height - 50;
    bubbleX = shooterX;
    bubbleY = shooterY;
}

void draw() {
    background(0);
    
    fill(0);
    rect(shooterX - 10, shooterY - 10, 20, 20);
    
    fill(255, 0, 0);
    ellipse(bubbleX, bubbleY, 20, 20);
    
    if (shooting) {
        bubbleX += dx * bubbleSpeed;
        bubbleY += dy * bubbleSpeed;
    }
    
    if (bubbleY < 0 || bubbleX < 0 || bubbleX > width) {
        shooting = false; 
    }
    
    if (!shooting) {
        bubbleX = shooterX;
        bubbleY = shooterY;
    }
}

void keyPressed() {
    if (keyCode == LEFT) {
        shooterX -= 10;
    } else if (keyCode == RIGHT) {
        shooterX += 10;
    }
}

void mousePressed() {
    if (!shooting) { 
       
        float angle = atan2(mouseY - shooterY, mouseX - shooterX);
        dx = cos(angle);
        dy = sin(angle);
        shooting = true; 
    }
}
