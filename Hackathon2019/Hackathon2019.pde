import processing.serial.*;
import processing.sound.*;

SoundFile[] notes; // empty place for notes
ArrayList<Integer> melodyNotes; // array of notes

int option = -1; // note option from 1-7, for C-A
int playPointer=0; // pointer for playing composed melody

Serial port;

void setup(){
    size(800,1200);
    background(255, 204, 0);
    initializeNotes();
    initializeMolodyNotes();
    
    
    //viberation TODO
    // String portName = Serial.list()[3]; // replace this number with the port you are using
    // port = new Serial(this, portName, 9600);

}

void draw() {
    fill(0);
    ellipse(playPointer*50, playPointer*50, 30, 30);
}

void keyPressed(){
    
    //browse all the note options
    if(keyCode == UP || keyCode == DOWN){
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
    }

  

    //confirm note selection
    if(keyCode == ENTER){
        melodyNotes.add(option); //put selected notes into melodynotes array
        notes[melodyNotes.get(melodyNotes.size()-1)].play();  // play currently selected note
        option = -1;
    }


    // play molody notes
    if(keyCode == SHIFT){
      new Thread(new Runnable(){
        public void run(){
          while(playPointer < melodyNotes.size()) {
            notes[melodyNotes.get(playPointer)].play();
            playPointer++;
            
            try{
              Thread.sleep(500);
            } catch (Exception e){
              e.printStackTrace();
            }
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
}

void initializeMolodyNotes(){
    melodyNotes = new ArrayList<Integer>();
}
