float radius;
float cx;
float cy;

void setup() {
  size(360, 360, P3D);
  stroke(255);
  
  //used to move gear around
  cx = 0;
  cy = 0;
}

void draw() {
  //set origin at the center
  translate(width/2, height/2, 0);
  background(0);
  
  float radius = 100;
  int numberOfTeeth = 50;
  float toothHeight = 10;
  float toothAngle = 2*PI / numberOfTeeth;
  
  strokeWeight(2);
  stroke(101,81,16,255);
  fill(201,181,86,255);
  
  beginShape();
  
  float angle, x, y;
  for (int t = 0; t <= numberOfTeeth; t++) {
    angle = t * toothAngle;
    x = cx + cos(angle) * radius;
    y = cy + sin(angle) * radius;
    vertex(x, y);
    angle = (t+0.5)*toothAngle;
    x = cx + cos(angle) * (radius + toothHeight);
    y = cy + sin(angle) * (radius + toothHeight);
    vertex(x, y);
  }
  endShape(CLOSE);
}

//used to facilitate taking screenshots
boolean pressed = false;
void keyPressed() {
  if (key == 'p') {
    if(!pressed)
    {
      saveFrame("gear_outer.jpg");
      println("saved frame");
      pressed = true;
    }
  }
  else
  {
    pressed = false;
  }

}