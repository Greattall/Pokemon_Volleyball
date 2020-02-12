import gifAnimation.*;
import processing.sound.*;
SoundFile soundfile,BGM,hitsound,startsound;
PImage[] animation;
Gif Player1,Player2,ball,hit1,hit2,P1jump,P2jump,P1hitball,P2hitball;
Gif Candidate1,Candidate2,G_candidate;
Gif lose1,lose2;
int CandidateKey1=1,CandidateKey2=1;
int fixCandidateKey1,fixCandidateKey2;
PImage BGimg,column;
int score1=0,score2=0;
int overscore=10;
float ballX=100,ballY=0;
float ballVX=0,ballVY=10;
float player1X=0,player1Y=700,player1V=0;
float player2X=1600,player2Y=700,player2V=0;
int windowsizeX=1800;
int windowsizeY=900;

int normalpower=10,hitpower=20;
int power1=normalpower,power2=normalpower;
int up1=0, down1=0, left1=0, right1=0;
int up2=0, down2=0, left2=0, right2=0;
int i=0;//
boolean ballhit=false;
int whoballhit=0;
boolean entry=false;
boolean P1win=false,P2win=false;

void setup(){

size(1800,900);

BGimg=loadImage("gameBgImage.png");
column=loadImage("column.png");
soundfile = new SoundFile(this,"coinsound.mp3");
BGM=new SoundFile(this,"gameBGM.mp3");
startsound=new SoundFile(this,"start_game.mp3");
hitsound=new SoundFile(this,"hitsound.wav");

BGM.loop();


Player1 = new Gif(this,"picha.gif");
Player1.loop();
Player2 = new Gif(this,"picha2.gif");
Player2.loop();
ball = new Gif(this,"pokeball.gif");
ball.loop();
P1hitball = new Gif(this,"pichahit.gif");
P1hitball.loop();
P2hitball = new Gif(this,"pichahit.gif");
P2hitball.loop();
hit1 = new Gif(this,"hit1.gif");
hit1.loop();
hit2 = new Gif(this,"hit2.gif");
hit2.loop();
P1jump = new Gif(this,"jump1.gif");
P1jump.loop();
P2jump = new Gif(this,"jump2.gif");
P2jump.loop();
Candidate1 = new Gif(this,"Candidate1.gif");
Candidate1.loop();
Candidate2 = new Gif(this,"Candidate2.gif");
Candidate2.loop();
G_candidate = new Gif(this,"G_candidate.gif");
G_candidate.loop();

lose1 = new Gif(this,"LOSE1.gif");
lose1.loop();
lose2 = new Gif(this,"LOSE2.gif");
lose2.loop();




}

void draw(){
if(entry==false){
//initial background~~~~~~~~~~~~~~~~~~~~~~~`  
  frameRate(100);
  PImage b;
  b = loadImage("entry.png");
  image(b, i, 0);
  i=i-10;
  if (i <= -1800) 
  {
    i = 0;
  }
  image(b, 1800+i, 0);
//initial background~~~~~~~~~~~~~~~~~~~~~~~~~~``

if(P1win==true){
  fill(255,0,0);textSize(150);text("P1win",700,250);
  image(Player1,205,450,400,400);
  image(Player2,1150,450,400,400);
  image(lose1,700,450,756,485);}
else if(P2win==true){
  fill(255,0,0);textSize(150);text("P2win",700,250);
  image(Player1,205,450,400,400);
  image(Player2,1150,450,400,400);
  image(lose2,550,350,839,549);}
else{
  fill(255,0,0);textSize(150);text("Pokémon",550,150);
  text("Volleyball",550,300);
  image(ball, 200, 20,360,280);
  image(ball, 1250, 20,360,280);
  textSize(80);
  text("Player1",255,400);
  text("Player2",1200,400);
  textSize(30);
  text("Press'K' to Start Normal Speed",700,650);
  text("Press'L' to Start Lower  Speed",700,750);
  fill(255);//white
  textSize(80);
  rect(205,450,400,400);
  rect(1150,450,400,400);
//siwtch player1
  CandidateKey1=CandidateKey1%3;
  fixCandidateKey1=CandidateKey1;
  switch(CandidateKey1){
  case 1:image(Candidate1,205,450,400,400);
  break;
  case 2:image(Candidate2,205,450,400,400);
  break;
  case 0:image(G_candidate,205,450,400,400);
  break;
  }
//siwtch player1
//siwtch player2
  CandidateKey2=CandidateKey2%3;
  fixCandidateKey2=CandidateKey2;
  switch(CandidateKey2){
  case 1:image(Candidate1,1150,450,400,400);
  break;
  case 2:image(Candidate2,1150,450,400,400);
  break;
  case 0:image(G_candidate,1150,450,400,400);
  }
} 

}
  
if(entry==true){


  background(BGimg);//bg
 image(column,windowsizeX/2,windowsizeY-350,40,350);

  if(down1==1){image(hit1,player1X,player1Y,200,200);}//P1 hit1
  else if(player1Y!=700){image(P1jump,player1X,player1Y,200,200);}//in air
  else {image(Player1,player1X,player1Y,200,200);}//normal

  if(down2==1){image(hit2,player2X,player2Y,200,200);}//P2 hit1
  else if(player2Y!=700){image(P2jump,player2X,player2Y,200,200);}//in air
  else {image(Player2,player2X,player2Y,200,200);}//normal

  if (right1==1)player1X+=10;
  if (left1==1) player1X-=10;
  if (right2==1)player2X+=10;
  if (left2==1) player2X-=10;
  
  
  if(player1V!=0&& player1Y<=700){player1Y+=player1V; player1V+=0.98;}
  if(player2V!=0&& player2Y<=700){player2Y+=player2V; player2V+=0.98;}
  //bound player 
  if(player1Y>700){player1Y=700;}
   if(player2Y>700){player2Y=700;}
  if(player1X<0){player1X=0;}
  if(player1X>windowsizeX/2-200){player1X=windowsizeX/2-200;}
  if(player2X>windowsizeX-200){player2X=windowsizeX-200;}
  if(player2X<windowsizeX/2){player2X=windowsizeX/2;}
  
  //bound player
  ballY+=ballVY;
  ballX+=ballVX;
  //image(img,ballX,ballY,100,100);
  if(ballhit){// if ballhit is true 
    if(whoballhit==1){image(P1hitball,ballX,ballY,214,200);}
    else if(whoballhit==2){image(P2hitball,ballX,ballY,214,200);}
   
  }
  
  else{image(ball,ballX,ballY,180,142);}
 
//Ball touch ceiling~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  if(ballX<0){if(ballVX<0)ballVX=-ballVX;}
  if(ballX>windowsizeX-100){if(ballVX>0)ballVX=-ballVX;}
  if(ballY<0){
    if(ballVY<0){ballVY=-ballVY;}
   }
  if(ballY>windowsizeY){  update();  }
//Ball touch ceiling~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  
  
  //~~~~~~~~~~~fence~~~~~~~~~~~
  if(ballX>windowsizeX/2-100&&ballX<windowsizeX/2){
    
    if(ballY>windowsizeY/2&&ballY<windowsizeY/1.5){
      ballVX=-ballVX;
      ballVY=-ballVY;
      }
    if(ballY>windowsizeY/2&&ballY>windowsizeY/1.5){
      ballVX=-ballVX;
      }
  }
  //~~~~~~~~~~~fence~~~~~~~~~~~
  //ball touch player
 // if(dist(mouseX,750,ballX,ballY)<100){
  if(dist(player1X,player1Y,ballX,ballY)<150){
    PVector dir = new PVector(ballX-player1X,ballY-player1Y);
    dir.normalize();
    dir.mult(power1);
    ballVX=dir.x;
    ballVY=dir.y;
    if(power1!=normalpower){ballhit=true;whoballhit=1;hitsound.play();}
    else{ballhit=false;}
  
  }
    if(dist(player2X,player2Y,ballX,ballY)<150){
    PVector dir = new PVector(ballX-player2X,ballY-player2Y);
    dir.normalize();
    dir.mult(power2);
    ballVX=dir.x;
    ballVY=dir.y;
    if(power2!=normalpower){ballhit=true;whoballhit=2;hitsound.play();}
    else{ballhit=false;}
  }
  fill(255,0,0);textSize(80);
 // text("score1:",40,60);
  text(score1,100,80);
  fill(255,0,0);textSize(80);
 // text("score2:",1400,60);
  text(score2,1690,80);
}
}

void keyPressed() {
  if (keyCode==UP){
      if(player2Y==700){
          player2V=-30;
           // player2V=-30; it will jump continuous
        }
  }
  if (keyCode==RIGHT)right2=1;
  if (keyCode==DOWN){down2=1;power2=hitpower;CandidateKey2++;}
  if (keyCode==LEFT)left2=1;
  
  if (keyCode=='R'){
  if(player1Y==700){
      player1V=-30;
       // player2V=-30; it will jump continuous
  }
  }
  if (keyCode=='G')right1=1;
  if (keyCode=='F'){down1=1;power1=hitpower;CandidateKey1++;}
  if (keyCode=='D')left1=1;
  if(keyCode=='K'){
      switch(CandidateKey1){
      case 1:Player1 = new Gif(this,"picha.gif");
             Player1.loop();
             P1jump = new Gif(this,"jump1.gif");
             P1jump.loop();
             hit1 = new Gif(this,"hit1.gif");
             hit1.loop();
             P1hitball = new Gif(this,"pichahit.gif");
             P1hitball.loop();
             
             
      break;
      case 2:Player1 = new Gif(this,"dragon1.gif");
             Player1.loop();
             P1jump = new Gif(this,"dragon1.gif");
             P1jump.loop();
             hit1 = new Gif(this,"dragon2.gif");
             hit1.loop();
             P1hitball = new Gif(this,"fireballhit.gif");
             P1hitball.loop();
      break;
      case 0:Player1 = new Gif(this,"G_standby1.gif");
             Player1.loop();
             P1jump = new Gif(this,"G_jump.gif");
             P1jump.loop();
             hit1 = new Gif(this,"G_hit1.gif");
             hit1.loop();
             P1hitball = new Gif(this,"G_hitball.gif");
             P1hitball.loop();
      break;
      }
      switch(CandidateKey2){
      case 1:Player2 = new Gif(this,"picha2.gif");
             Player2.loop();
             P2jump = new Gif(this,"jump2.gif");
             P2jump.loop();
             hit2 = new Gif(this,"hit2.gif");
             hit2.loop();
             P2hitball = new Gif(this,"pichahit.gif");
             P2hitball.loop();
      break;
      case 2:Player2 = new Gif(this,"dragon2.gif");
             Player2.loop();         
             P2jump = new Gif(this,"dragon2.gif");
             P2jump.loop();
             hit2 = new Gif(this,"dragon1.gif");
             hit2.loop();
             P2hitball = new Gif(this,"fireballhit.gif");
             P2hitball.loop();
      break;
      case 0:Player2 = new Gif(this,"G_standby2.gif");
             Player2.loop();
             P2jump = new Gif(this,"G_jump.gif");
             P2jump.loop();
             hit2 = new Gif(this,"G_hit2.gif");
             hit2.loop();
             P2hitball = new Gif(this,"G_hitball.gif");
             P2hitball.loop();
      break;
      }


  
  if(P1win==true||P2win==true){P1win=false;P2win=false;}
  else{entry=true;}
  
  startsound.play();
  normalpower=15;
  hitpower=30;
  power1=normalpower;
  power2=normalpower;
 }
if(keyCode=='L'){
      switch(CandidateKey1){
      case 1:Player1 = new Gif(this,"picha.gif");
             Player1.loop();
             P1jump = new Gif(this,"jump1.gif");
             P1jump.loop();
             hit1 = new Gif(this,"hit1.gif");
             hit1.loop();
             P1hitball = new Gif(this,"pichahit.gif");
             P1hitball.loop();
             
             
      break;
      case 2:Player1 = new Gif(this,"dragon1.gif");
             Player1.loop();
             P1jump = new Gif(this,"dragon1.gif");
             P1jump.loop();
             hit1 = new Gif(this,"dragon2.gif");
             hit1.loop();
             P1hitball = new Gif(this,"fireballhit.gif");
             P1hitball.loop();
      break;
      case 0:Player1 = new Gif(this,"G_standby1.gif");
             Player1.loop();
             P1jump = new Gif(this,"G_jump.gif");
             P1jump.loop();
             hit1 = new Gif(this,"G_hit1.gif");
             hit1.loop();
             P1hitball = new Gif(this,"G_hitball.gif");
             P1hitball.loop();
      break;
      }
      switch(CandidateKey2){
      case 1:Player2 = new Gif(this,"picha2.gif");
             Player2.loop();
             P2jump = new Gif(this,"jump2.gif");
             P2jump.loop();
             hit2 = new Gif(this,"hit2.gif");
             hit2.loop();
             P2hitball = new Gif(this,"pichahit.gif");
             P2hitball.loop();
      break;
      case 2:Player2 = new Gif(this,"dragon2.gif");
             Player2.loop();         
             P2jump = new Gif(this,"dragon2.gif");
             P2jump.loop();
             hit2 = new Gif(this,"dragon1.gif");
             hit2.loop();
             P2hitball = new Gif(this,"fireballhit.gif");
             P2hitball.loop();
      break;
      case 0:Player2 = new Gif(this,"G_standby2.gif");
             Player2.loop();
             P2jump = new Gif(this,"G_jump.gif");
             P2jump.loop();
             hit2 = new Gif(this,"G_hit2.gif");
             hit2.loop();
             P2hitball = new Gif(this,"G_hitball.gif");
             P2hitball.loop();
      break;
      }


  
  if(P1win==true||P2win==true){P1win=false;P2win=false;}
  else{entry=true;}
  
  startsound.play();
  normalpower=10;
  hitpower=20;
  power1=normalpower;
  power2=normalpower;
}
}
  
void keyReleased() {
  if (keyCode==UP)
    up2=0;
  if (keyCode==RIGHT)
    right2=0;
  if (keyCode==DOWN)
   { down2=0;power2=normalpower;}
  if (keyCode==LEFT)
    left2=0;
    
  if (keyCode=='R')
    up1=0;
  if (keyCode=='G')
    right1=0;
  if (keyCode=='F')
    {down1=0;power1=normalpower;}
  if (keyCode=='D')
    left1=0;
}
void update(){

  
  ballhit=false;
  soundfile.play();//sound effect
  delay(100);
  player1X=0;
  player2X=1600;
  
  
  if(ballX<windowsizeX/2){
  score2++;
  ballX=player2X-80;
  }
  else if(ballX>windowsizeX/2){
  score1++;
  ballX=100;
  }
  
  ballY=0;
  ballVX=0;
  ballVY=10;
  if(score1==overscore){score1=0;score2=0;entry=false; P1win=true; }
  else if(score2==overscore){score1=0;score2=0;entry=false; P2win=true; }
//evolution  

  if(score1==overscore/2){ 
    switch(fixCandidateKey1){
      case 1:Player1 = new Gif(this,"bigpicha.gif");
             Player1.loop();
             P1jump = new Gif(this,"bigpichajump.gif");
             P1jump.loop();
             hit1 = new Gif(this,"bigpichahit.gif");
             hit1.loop();
             P1hitball = new Gif(this,"pichahit3.gif");
             P1hitball.loop();
      break;
      case 2:Player1 = new Gif(this,"bigdragon1.gif");
             Player1.loop();
             P1jump = new Gif(this,"bigdragon1.gif");
             P1jump.loop();
             hit1 = new Gif(this,"bigdragon2.gif");
             hit1.loop();
             P1hitball = new Gif(this,"bigfireballhit.gif");
             P1hitball.loop();
      break;
      case 0:Player1 = new Gif(this,"bigG_standby1.gif");
             Player1.loop();
             P1jump = new Gif(this,"bigG_jump.gif");
             P1jump.loop();
             hit1 = new Gif(this,"bigG_hit1.gif");
             hit1.loop();
             P1hitball = new Gif(this,"bigG_hitball.gif");
             P1hitball.loop();
      break;
      }
 
             }
  if(score2==overscore/2){
    switch(fixCandidateKey2){
      case 1:Player2 = new Gif(this,"bigpicha.gif");
             Player2.loop();
             P2jump = new Gif(this,"bigpichajump.gif");
             P2jump.loop();
             hit2 = new Gif(this,"bigpichahit.gif");
             hit2.loop();
             P2hitball = new Gif(this,"pichahit3.gif");
             P2hitball.loop();
      break;
      case 2:Player2 = new Gif(this,"bigdragon2.gif");
             Player2.loop();         
             P2jump = new Gif(this,"bigdragon2.gif");
             P2jump.loop();
             hit2 = new Gif(this,"bigdragon1.gif");
             hit2.loop();
             P2hitball = new Gif(this,"bigfireballhit.gif");
             P2hitball.loop();
      break;
      case 0:Player2 = new Gif(this,"bigG_standby2.gif");
             Player2.loop();
             P2jump = new Gif(this,"bigG_jump.gif");
             P2jump.loop();
             hit2 = new Gif(this,"bigG_hit2.gif");
             hit2.loop();
             P2hitball = new Gif(this,"bigG_hitball.gif");
             P2hitball.loop();
      break;
      }
             
             }
//evolution 
}
