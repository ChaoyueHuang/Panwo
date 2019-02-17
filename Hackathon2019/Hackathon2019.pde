import processing.serial.*;
import processing.sound.*;
import de.looksgood.ani.*;
import java.util.Random; 
import processing.svg.*;

PImage bg;
PShape star;
float delay;
SoundFile[] notes; // empty place for notes
Circle[] noteCircles; //first 7 circles
AniSequence seq;
float x,y,diameter;
ArrayList<Integer> melodyNotes; // array of notes
ArrayList<Circle> melodyNoteCircles; 


int option = -1; // note option from 1-7, for C-A
int playPointer=0; // pointer for playing composed melody

static int canvasWidth, canvasHeight;
static final Random delayGenerator = new Random();

Serial port;

//from arduino
int button;

//define a variable of the motor iondex
int motor = 5;

boolean nyuMode=true;

void setup(){
  
    nyu();
    canvasWidth = 1200;
    canvasHeight = 675;
    size(1200, 675);
    
    initializeNotes();
    initializeMolodyNotes();
    
    //ani inti
    smooth();
    noStroke();
    
  //  star = loadShape("s1.svg");
  
    //viberation TODO
     String portName = Serial.list()[3]; // replace this number with the port you are using
     port = new Serial(this, portName, 9600);

    //bg = loadImage("bg.jpg");
    background(255);
    //background(67, 97, 127, frameCount/5); //night
    //fill(255,255,255,2);
    //rect(0,0,width,height);

}

void draw() {
  if (nyuMode)
    display();
    
  else{
    //background stars
    float star_alpha = random(10,50);
    float ra = random(10, 20);
    fill(252,249,237,star_alpha);
    stroke(252,249,237, star_alpha/5);
    strokeWeight(ra/5);
    if(frameCount % 30 == 0){
      ellipse(random(width),random(height), ra, ra);
    }
   
    //fill(255,255,255,0.1);
    //rect(0,0,width,height);
    
    //moving circles
    if(x>0 && y>0){
      fill(255,255,255,40);
      noStroke();
      ellipse(x,y,30,30);
    }
    
    pushStyle();
    for (int i=0; i<7; i++){
      Circle noteCircle=noteCircles[i];
      //filling of the 7 circles -- when browsing
      fill(255,255,255,noteCircle.alpha);
      stroke(255,186,91, frameCount % 30);
      strokeWeight(10);
      ellipse(noteCircle.x, noteCircle.y, 3*noteCircle.width, 3*noteCircle.height);
    }
    
    for (int i=0; i<melodyNoteCircles.size(); i++){
      Circle noteCircle=melodyNoteCircles.get(i);
      
      //fillinf of the selected circle -- after "enter"
      fill(0,0,0,noteCircle.alpha);
      ellipse(noteCircle.x, noteCircle.y, 5*noteCircle.width, 5*noteCircle.height);
    }
    popStyle();
  }
  
  if (0 < port.available()) {         // If data is available,
            button = port.read();            // read it and store it in val
           
          }
      
      //browse all the note options
    if(button == 12 || button == 13 || button == 3 || button == 4){
        for (int i=0; i<7; i++){
          noteCircles[i].alpha=0 * 255;
        }
        
       if(button == 12 || button == 13){
          option++;
          port.write(motor);
          motor++;

        }
        if(button == 3 || button == 4){
          option--;
          port.write(motor);
          motor--;
        }
        
       if(option > 6 || option < 0 || motor > 11 || motor < 5){
          option = 0;
          motor = 5;
        }
        notes[option].play();
        noteCircles[option].alpha = 1 * 255;
       

    }
    

    
    if(button == 30 || button == 31){
        if(option == -1) return;
        melodyNotes.add(option); //put selected notes into melodynotes array
        notes[melodyNotes.get(melodyNotes.size()-1)].play();  // play currently selected note
        Circle circle=noteCircles[option];

        //shapeMode(CENTER);       
        //shape(star, circle.x, circle.y,36,36);

        melodyNoteCircles.add(Circle.copy(circle)); 
        port.write(melodyNotes.get(melodyNotes.size()-1)+5);
         println(button);

    }
    
}

void keyPressed(){
    
  if(keyCode == 81){
    nyuMode=false;
    fill(255);
    rect(0,0,width,height);
    background(102, 92, 132, frameCount/50); //night
  }
    
    
    //browse all the note options
    if(keyCode == UP || keyCode == DOWN){
        for (int i=0; i<7; i++){
          noteCircles[i].alpha=0 * 255;
        }
        
       if(keyCode == UP){
          option++;
        }
        if(keyCode == DOWN){
          option--;
        }
        
       if(option > 6 || option < 0){
          option = 0;
        }
        notes[option].play();
        noteCircles[option].alpha = 0.05 * 255;

    }

  

    //confirm note selection
    if(keyCode == ENTER){
        if(option == -1) return;
        melodyNotes.add(option); //put selected notes into melodynotes array
        notes[melodyNotes.get(melodyNotes.size()-1)].play();  // play currently selected note
        Circle circle=noteCircles[option];

        //shapeMode(CENTER);       
        //shape(star, circle.x, circle.y,36,36);

        melodyNoteCircles.add(Circle.copy(circle));    

    }


    // play molody notes
    if(keyCode == SHIFT){
      if(melodyNoteCircles.isEmpty()) return;
      Circle initCircle=melodyNoteCircles.get(0);
      x=initCircle.x;
      y=initCircle.y;
      diameter = 5;
      
      //animation
      Ani.init(this);
      seq = new AniSequence(this);
      seq.beginSequence();
      seq.add(Ani.to(this, 0.5 ,"diameter", 5));
      
      for(int i=1; i<melodyNoteCircles.size(); i++){

         String coo = "x:"+melodyNoteCircles.get(i).x+",y:"+melodyNoteCircles.get(i).y;
         seq.add(Ani.to(this, 1, coo)); //delay by seconds
      }
      
      seq.beginStep();
      String initCoo = "x:"+initCircle.x+",y:"+initCircle.y;
      seq.add(Ani.to(this, 0.5 ,initCoo));
      seq.add(Ani.to(this, 0.5 ,"diameter",5));
      seq.endStep();
      seq.endSequence();
      
      seq.start();

      
      println("play music");
      
      new Thread(new Runnable(){
        public void run(){
          while(playPointer < melodyNotes.size()) {
       
            notes[melodyNotes.get(playPointer)].play();
            port.write(melodyNotes.get(playPointer)+5);
            // sleep 0.5 sec before play the next note.
            try{
         
              Thread.sleep(1000);
            } catch (Exception e){
              e.printStackTrace();
            }
            playPointer++;
          }
  
        }
      }).start();
      
      playPointer = 0;
    }

}

//load sound files into array
void initializeNotes(){
    notes = new SoundFile[7];
    notes[0] = new SoundFile (this,"C.wav");
    notes[1] = new SoundFile (this,"D.wav");
    notes[2] = new SoundFile (this,"E.wav");
    notes[3] = new SoundFile (this,"F.wav");
    notes[4] = new SoundFile (this,"G.wav");
    notes[5] = new SoundFile (this,"A.wav");
    notes[6] = new SoundFile (this,"B.wav");
    
    noteCircles = new Circle[7];
    for (int i=0; i<7; i++){
      noteCircles[i]=Circle.getCircle();
    }
}

void initializeMolodyNotes(){
    melodyNotes = new ArrayList<Integer>();
    melodyNoteCircles = new ArrayList<Circle>();

}



static class Circle{
   public int x,y; // x-, y- corrds
   public int width, height; // default 30
   public float alpha; // default 0
   static Random rand=new Random(); 
   
   static void randomCoords(Circle circle){
       //generate the 7 circles
       circle.x=rand.nextInt(canvasWidth) % 1000 + 100; 
       circle.y=rand.nextInt(canvasHeight) % 550 + 50;
   }
   
   static Circle getCircle(){
        
       Circle circle=new Circle();
       
       randomCoords(circle);
       
       circle.width=circle.height=10;
       
       circle.alpha=0;
       
       return circle;  
   }
   
   static Circle copy(Circle circle){
        Circle newCircle = new Circle();
        newCircle.x=circle.x;
        newCircle.y=circle.y;
        newCircle.width=circle.width;
        newCircle.height=circle.height;
        newCircle.alpha=0.01 * 255;
        
        circle.alpha=0;
        Circle.randomCoords(circle);
        return newCircle;
   }
  
}
