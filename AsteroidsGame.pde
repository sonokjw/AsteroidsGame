//your variable declarations here
SpaceShip bob = new SpaceShip();
Star [] stars = new Star[100];

// Asteroids [] manyAsteroids = new Asteroids[10];
ArrayList <Asteroids> manyAsteroids;

ArrayList <Bullet> manyBullets;

public void setup() 
{
  //your code here
  size(800, 500);
  manyAsteroids = new ArrayList <Asteroids>();
  for(int i = 0; i<stars.length; i++)
  {
    stars[i] = new Star();
  }

  for(int i = 0; i< 10; i++)
  {
    manyAsteroids.add(i, new Asteroids());
  }

  manyBullets = new ArrayList <Bullet>();

}
public void draw() 
{
  // your code here
  background(0, 0, 0, 20);


  for(int i = 0; i<stars.length; i++)
  {
    stars[i].show();
  }

  for(int i = 0; i<manyAsteroids.size(); i++)
  {
    manyAsteroids.get(i).show();
    manyAsteroids.get(i).move();
    if (manyAsteroids.get(i).collide(bob.getX(), bob.getY()) == true)
      manyAsteroids.remove(i);
  }

  bob.show();
  bob.move();

  for(int i = 0; i < manyBullets.size(); i++)
  {
    manyBullets.get(i).show();
    manyBullets.get(i).move();
    for(int j = 0; j < manyAsteroids.size(); j++)
    {
      if(manyBullets.get(i).collide(manyAsteroids.get(j).getX(),manyAsteroids.get(j).getY()) == true)
      {
        manyBullets.remove(i);
        manyAsteroids.remove(j);
        break;
      }
    }
  }
}

public void keyPressed()
{
  if(keyCode == UP)
  {
    bob.accelerate(1.0);
  }
  else if(keyCode == DOWN)
  {
    bob.setX((int)(Math.random()*750)+25);
    bob.setY((int)(Math.random()*450)+25);
    bob.setDirectionX(0);
    bob.setDirectionY(0);
    bob.setPointDirection((int)(Math.random()*360));
  }

  else if(keyCode == LEFT)
  {
    bob.rotate(-15);
  }
  else if (keyCode == RIGHT)
  {
    bob.rotate(15);
  }

  if(key == ' ')
  {
    manyBullets.add(new Bullet(bob));
  }
}

class SpaceShip extends Floater  
{   
    //your code here
    public SpaceShip()
    {
      corners = 12;
      myColor = color(196, 221, 229);
      myCenterX = 400;
      myCenterY = 250;
      myDirectionX = 0;
      myDirectionY = 0;
      myPointDirection = 0;
      int [] xs = {16, 12, 4, 0, -8, -4, -8, -4, -8, 0, 4, 12};
      int [] ys = {0, 4, 4, 12, 16, 4, 0, -4, -16, -12, -4, -4};
      xCorners = xs;
      yCorners = ys;
    }



    public void setX(int x){myCenterX = x;}
    public int getX(){return (int)myCenterX;}
    public void setY(int y){myCenterY = y;}
    public int getY(){return (int)myCenterY;}
    public void setDirectionX(double x){myDirectionX = x;}
    public double getDirectionX(){return myDirectionX;}
    public void setDirectionY(double y){myDirectionY = y;}
    public double getDirectionY(){return myDirectionY;}
    public void setPointDirection(int degrees){myPointDirection = degrees;}
    public double getPointDirection(){return myPointDirection;}
}

abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {          
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));       
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     

    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);      
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

class Star
{
  private int myX, myY, mySize, myColor;
  public Star(){
    myX = (int)(Math.random()*800);
    myY = (int)(Math.random()*500);
    mySize = (int)(Math.random()*4);
    myColor = color(249, 201, 71);
  }

  public void show()
  {
    noStroke();
    fill(myColor);
    ellipse(myX, myY, mySize, mySize);
  }

}


class Asteroids extends Floater
{
  private int speedOfRotation;
  public Asteroids()
  {
    speedOfRotation = (int)(Math.random()*11)-5;
    myColor = color(100);
    myCenterX = Math.random()*800;
    myCenterY = Math.random()*500;
    myDirectionX = Math.random()*5-2;
    myDirectionY = Math.random()*5-2;
    myPointDirection = (int)(Math.random()*360);
    corners = 12;
    int [] xs = {8, 8, 6, 2, 0, -6, -10, -8, -4, 0, 4, 6};
    int [] ys = {0, 2, 4, 6, 8, 6, 2, -6, -8, -8, -6, -4};
    xCorners = xs;
    yCorners = ys;
  }

  public boolean collide(int x, int y)
  {
    if(dist((int)myCenterX, (int)myCenterY, x, y) < 20)
      return true;
    else {
      return false;
    }
  }

  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}

  public void move()
  {
    super.move();
    super.rotate(speedOfRotation);
  }
}

public class Bullet extends Floater
{
  private double dRadians;
  public Bullet(SpaceShip theShip)
  {
    myCenterX = theShip.getX();
    myCenterY = theShip.getY();
    myPointDirection = theShip.getPointDirection();
    dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + theShip.getDirectionX();
    myDirectionY = 5 * Math.sin(dRadians) + theShip.getDirectionY();
  }

  public void show()
  {
    fill(254, 241, 90);
    ellipse((int)myCenterX, (int)myCenterY, 10, 10);
  }

  public void move()
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
  }

  public boolean collide(int x, int y)
  {
    if(dist((int)myCenterX, (int)myCenterY, x, y) < 10)
      return true;
    else {
      return false;
    }
  }

  public void setX(int x){myCenterX = x;}
  public int getX(){return (int)myCenterX;}
  public void setY(int y){myCenterY = y;}
  public int getY(){return (int)myCenterY;}
  public void setDirectionX(double x){myDirectionX = x;}
  public double getDirectionX(){return myDirectionX;}
  public void setDirectionY(double y){myDirectionY = y;}
  public double getDirectionY(){return myDirectionY;}
  public void setPointDirection(int degrees){myPointDirection = degrees;}
  public double getPointDirection(){return myPointDirection;}
}
