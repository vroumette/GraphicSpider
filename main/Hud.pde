class Hud {
    private PMatrix3D hud;
    private boolean helper;

    /** Constructeur du Hud
     */
    Hud() {
        // Should be constructed just after P3D size() or fullScreen()
        this.hud = g.getMatrix((PMatrix3D) null);
        // booléen testé pour afficher l'aide aux contrôles
        this.helper = true;
    }

    /** begin
     * Modifie les paramètre du sketch pour l'affichage du Hud
      */
    private void begin() {
        g.noLights();
        g.pushMatrix();
        g.hint(PConstants.DISABLE_DEPTH_TEST);
        g.resetMatrix();
        g.applyMatrix(this.hud);
    }

    /** end
     * Rétabli les paramètre du sketch après l'affichage du Hud
     */
    private void end() {
        g.hint(PConstants.ENABLE_DEPTH_TEST);
        g.popMatrix();
    }

    /** displayFPS
     * Affiche le nombre de fps dans le coin inférieur gauche
     */
    private void displayFPS() {
        // Bottom left area
        noStroke();
        fill(96);
        rectMode(CORNER);
        // On place le cadre en 10, height-30 avec une largeur de 60 et une hauteur de 20
        rect(10, height-30, 60, 20, 5, 5, 5, 5);
        // Value
        fill(0xF0);
        textMode(SHAPE);
        textSize(14);
        // On alligne le texte au milieu horizontalement et verticalement
        textAlign(CENTER, CENTER);
        // On écrit le nombre de fps au bon endroit
        text(String.valueOf((int)frameRate) + " fps", 40, height-20);
    }

    /** displayCamera
     * Affiche les informations relatives au positionnement de la caméra
     */
    private void displayCamera(Camera  camera){
        // Bottom left area
        noStroke();
        fill(96);
        rectMode(CORNER);
        // On place le cadre en 10, 10 avec une largeur de 150 et une hauteur de 150
        rect(10,10,150, 150, 5, 5, 5, 5);
        // Value
        fill(0xF0);
        textMode(SHAPE);
        textSize(14);
        textAlign(LEFT, CENTER);
        // On place les informations dans la box, avec le titre de la boîte un peu décalé
        text("Camera :", 25, 20);
        text("Longitude : "+String.valueOf((int)radToDegree(camera.longitude%(2*PI))+"°") , 20, 40);
        text("Colatitude : "+String.valueOf((int)radToDegree(camera.colatitude)+"°") , 20, 60);
        text("Radius : "+String.valueOf((int)camera.radius+"m") , 20, 80);
        text("Lightning : "+String.valueOf(camera.lightning) , 20, 100);
        text("X : "+String.valueOf(camera.rootX),20,120);
        text("Y : "+String.valueOf(camera.rootY),20,140);

    }

    /** update
     * Met à jour le hud
     */
    void update(){
        // Ouvre l'environnement du hud
        this.begin();
        // Affiche les fps
        this.displayFPS();
        // Affiche les informations de caméra
        this.displayCamera(camera);
        this.end();
    }
}
