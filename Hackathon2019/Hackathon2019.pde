import processing.serial.*;
import processing.sound.*;
import java.util.Random; 

SoundFile[] notes; // empty place for notes
Circle[] noteCircles;

ArrayList<Integer> melodyNotes; // array of notes
ArrayList<Circle> melodyNoteCircles; 

int option = -1; // note option from 1-7, for C-A
int playPointer=0; // pointer for playing composed melody

static int canvasWidth, canvasHeight;

Serial port;

void setup(){
    canvasWidth = 1200;
    canvasHeight = 1200;
    size(1200, 1200);
    
    initializeNotes();
    initializeMolodyNotes();
    
    
    //viberation TODO
    // String portName = Serial.list()[3]; // replace this number with the port you are using
    // port = new Serial(this, portName, 9600);

}
int z=0;
void draw() {
    background(255, 255, 255);
    for (int i=0; i<7; i++){
      Circle noteCircle=noteCircles[i];
      fill(0,0,0,noteCircle.alpha);
      ellipse(noteCircle.x, noteCircle.y, noteCircle.width, noteCircle.height);
    }
    for (int i=0; i<melodyNoteCircles.size(); i++){
      Circle noteCircle=melodyNoteCircles.get(i);
      fill(0,0,0,noteCircle.alpha);
      ellipse(noteCircle.x, noteCircle.y, noteCircle.width, noteCircle.height);
    }
   
}

void keyPressed(){
    
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
        noteCircles[option].alpha = 1 * 255;

    }

  

    //confirm note selection
    if(keyCode == ENTER){
        melodyNotes.add(option); //put selected notes into melodynotes array
        notes[melodyNotes.get(melodyNotes.size()-1)].play();  // play currently selected note
        melodyNoteCircles.add(Circle.copy(noteCircles[option]));
        option = -1;
    }


    // play molody notes
    if(keyCode == SHIFT){
      new Thread(new Runnable(){
        public void run(){
          while(playPointer < melodyNotes.size()) {
            notes[melodyNotes.get(playPointer)].play();
            melodyNoteCircles.get(playPointer).alpha=100; // TODO
            
            // sleep 0.5 sec before play the next note.
            try{
              Thread.sleep(500);
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
   private int x,y; // x-, y- corrds
   private int width, height; // default 30
   public int alpha; // default 0
   static Random rand=new Random(); 
   
   static void randomCoords(Circle circle){
       circle.x=rand.nextInt(canvasWidth) % 800 + 200;
       circle.y=rand.nextInt(canvasHeight) % 800 + 200;
   }
   
   static Circle  getCircle(){
        
       Circle circle=new Circle();
       
       randomCoords(circle);
       
       circle.width=circle.height=30;
       
       circle.alpha=0;
       
       return circle;  
   }
   
   static Circle copy(Circle circle){
        Circle newCircle = new Circle();
        newCircle.x=circle.x;
        newCircle.y=circle.y;
        newCircle.width=circle.width;
        newCircle.height=circle.height;
        newCircle.alpha=1 * 255;
        
        circle.alpha=0;
        Circle.randomCoords(circle);
        return newCircle;
   }
  
}
