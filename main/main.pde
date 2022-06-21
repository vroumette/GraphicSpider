Camera camera;
Hud hud;

PShape toile;
PShape arraignee;
float a,b, rotate;


/** settings
 * met en place les paramètres du sketch
 */
void settings(){
    // Désactive une propriété du système pour que ça marche
    System.setProperty("jogl.disable.openglcore", "true");
    // Antianialasing
    smooth(16);
    
    size(displayWidth-100, displayHeight-100, P3D);
}


void setup() {
  this.hud = new Hud();
  this.camera = new Camera(54*PI/180,90*PI/180,130);
  background(0);
  a=0;
  b=0;
  arraignee = loadShape("Spider.obj");
  arraignee.setFill(color(200, 0, 0));
  
  this.toile = createShape(GROUP);
  
  //PShape e = createShape(ARC,200*sqrt(2 + sqrt(2))/2, 200*sqrt(2 - sqrt(2))/2, 200*sqrt(2 + sqrt(2))/2,200*sqrt(2 + sqrt(2))/2, PI, 5*PI/4);
  

  PShape l = createShape();
  l.beginShape();
  l.stroke(255);
  l.noFill();
  l.vertex(0, 0, 0);
  for(int i=0; i<=5; i++){
    l.vertex(0, i*100, 0);
    PShape cercle = createShape(ELLIPSE,0,i*100, 10,10);
    this.toile.addChild(cercle);
    l.vertex(i*100*sqrt(2)/2, i*100*sqrt(2)/2, 0);
    l.vertex(0, i*100, 0);
  }
  l.endShape();
  
  //this.toile.addChild(e);
  
  this.toile.addChild(l);
  
}

void draw() {
  background(0);
  this.camera.update();
  lights();
  
  pushMatrix();
  fill(255,255,255);
  ellipse(0,0,10,10);
  popMatrix();
  
  //z en rouge
  pushMatrix();
  fill(255,0,0);
  translate(0, 0, 100);
  box(5);
  popMatrix();
  
  //y en vert
  pushMatrix();
  fill(0,255,0);
  translate(0, 100, 0);
  ellipse(0,0,10,10);
  popMatrix();
  
  //x en bleu
  pushMatrix();
  fill(0,0,255);
  translate(100, 0, 0);
  ellipse(0,0,10,10);
  popMatrix();
  
  for(int i=0; i<8; i++){
    shape(toile,0,0);
    rotate(PI/4);
  }
  pushMatrix();
  translate(0,0,1);
  scale(4);
  stroke(150,255,0);
  rotate(rotate);
  shape(arraignee,a,b);
  popMatrix();
   //Il faut mettre le hud en dernier pour être sur qu'il soit affiché au bon endroit
   this.hud.update();
}

void adjustSpider(float aAdj, float bAdj, float r){
    b=b+bAdj;
    a=a+aAdj;
    rotate = rotate + r;
    

}

/** keyPressed
 * Récupère les actions au clavier de l'utilisateur pour gérer les contrôles du sketch
 */
void keyPressed(){
    if (key == CODED) {
        switch (keyCode) {
            // Oriente vers le dessus
            case UP:
                this.camera.adjustColatitude(-PI/4);
                break;
            // Oriente vers le dessous
            case DOWN:
                this.camera.adjustColatitude(PI/4);
                break;
            // Tourne vers la gauche
            case LEFT:
                this.camera.adjustLongitude(-PI/4);
                break;
            // Tourne vers la droite
            case RIGHT:
                this.camera.adjustLongitude(PI/4);
                break;
        }
    } else {
        switch (key) {
            // Zoom
            case '+':
            case 'p':
                this.camera.adjustRadius(-10);
                break;
            // Dézoom
            case '-':
            case 'm':
                this.camera.adjustRadius(10);
                break;
            //On/off lights
            case 'l':
            case 'L':
                this.camera.toggle();
                break;
            // Déplace vers l'avant
            case 'z':
            case 'Z':
                this.adjustSpider(0,25,0);
                this.camera.moveZS(100);
                break;
            // Déplace vers l'arrière
            case 's':
            case 'S':
                this.adjustSpider(0,-25,0);
                this.camera.moveZS(-100);
                break;
            // Déplace vers la gauche
            case 'q':
            case 'Q':
                this.adjustSpider(0,0,PI/4);
                //this.camera.moveQD(100);
                break;
            // Déplace vers la droite
            case 'd':
            case 'D':
                this.adjustSpider(0,0,-PI/4);
                //this.camera.moveQD(-100);
                break;
        }
    }
}


/** mouseWheel
 * Récupère les actions de molette de la souris clavier de l'utilisateur pour gérer les contrôles du sketch
 */
void mouseWheel(MouseEvent event) {
   float ec = event.getCount();
   // Zoom
   this.camera.adjustRadius(20*ec);
}

/** mouseDragged
 * Récupère les actions de cliquer-glisser à la souris au clavier de l'utilisateur pour gérer les contrôles du sketch
 */
void mouseDragged() {
    // Tourne la caméra
   if (mouseButton == CENTER) {
       // Camera Horizontal
       float dx = mouseX - pmouseX;
       this.camera.adjustLongitude((dx/10)*(-PI)/100);

       // Camera Vertical
       float dy = mouseY - pmouseY;
       this.camera.adjustColatitude((dy/10)*PI/100);
   }
   // Déplace l'origine
   if (mouseButton == LEFT){
       // Déplace droite gauche
       this.camera.moveQD(mouseX - pmouseX);

       // Déplace avant arrière
       this.camera.moveZS(mouseY - pmouseY);
   }
}

/** radToDegree
 * Fonction de conversion de radian vers degrés
 */
float radToDegree(float angle){
    return angle*180/PI;
}
