//used to save gifs
//https://github.com/01010101/GifAnimation
import gifAnimation.*;

GifMaker gifExport;

String CURRENT_ITERATION_NAME = "gear_gridRandomRotating";

int[] teethNumbers;
float[] gearRadi;
int numberOfGearsX = 5;
int numberOfGearsY = 5;
int numberOfGearsTotal = numberOfGearsX*numberOfGearsY;
void setup() {
  size(360, 360, P3D);
  stroke(255);
  
  gifExport = new GifMaker(this, CURRENT_ITERATION_NAME + ".gif");
  gifExport.setRepeat(0);            // make it an "endless" animation
  gifExport.setTransparent(0,0,0);     // black is transparent
  
  teethNumbers = new int[numberOfGearsTotal];
  gearRadi = new float[numberOfGearsTotal];
  float maxRadius = min(width/numberOfGearsX,height/numberOfGearsY) * 0.4;
  for(int i = 0; i < teethNumbers.length; i++)
  {
    teethNumbers[i] = (int)random(5,25);
    gearRadi[i] = random(maxRadius*0.5,maxRadius);
  }
}

void draw() {
  //set origin at the center
  translate(width/2, height/2, 0);
  background(0);
  
  strokeWeight(2);
  stroke(101,81,16,255);
  fill(201,181,86,255);
  int arrayIndex;
  for(int x = 0; x < numberOfGearsX; x++)
  {
    for(int y = 0; y < numberOfGearsY; y++)
    {
      arrayIndex = x*numberOfGearsY+y;
      beginShape();
      drawGear((x+0.5) * width/numberOfGearsX - width/2,(y+0.5)* height/numberOfGearsY - height/2,teethNumbers[arrayIndex],
       gearRadi[arrayIndex], gearRadi[arrayIndex] * (numberOfGearsTotal - arrayIndex) / numberOfGearsTotal ,10,millis()/1000.0);
      endShape(CLOSE);
    }
  }
  
  gifExport.setDelay(1);
  gifExport.addFrame();
}

void drawGear(float cx, float cy, int numberOfTeeth, float radius, float innerRadius, float toothHeight, float initialAngle)
{
  float toothAngle = 2*PI / numberOfTeeth;
  float angle, x, y;
  for (int t = 0; t <= numberOfTeeth; t++) {
    angle = t * toothAngle + initialAngle;
    x = cx + cos(angle) * radius;
    y = cy + sin(angle) * radius;
    vertex(x, y);
    angle = (t+0.5)*toothAngle + initialAngle;
    x = cx + cos(angle) * (radius + toothHeight);
    y = cy + sin(angle) * (radius + toothHeight);
    vertex(x, y);
  }
  beginContour();
  for (int t = numberOfTeeth; t >= 0; t--) {
    angle = t * toothAngle + initialAngle;
    x = cx + cos(angle) * innerRadius;
    y = cy + sin(angle) * innerRadius;
    vertex(x, y);
  }
  endContour();
}

//used to facilitate taking screenshots
boolean pressed = false;
void keyPressed() {
  if(key == 'r')
  println("r");
  if (key == 'p') {
    if(!pressed)
    {
      saveFrame(CURRENT_ITERATION_NAME + ".jpg");
      println("saved frame");
      pressed = true;
    }
  }
  else
  {
    pressed = false;
  }
  if (key == 'g') {
    gifExport.finish();          // write file
    println("saved gif");
  }

}