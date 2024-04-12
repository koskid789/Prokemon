//Owen Koslowsky
//The following is a prototype for the Prokemon game that I will be developing along with Aiden Preza and Manit Sethi

import controlP5.*;
//Rows in the table are: Name, Type, Power, PP, UB1, UB2, UB3, UB4, UB5, UB6, UB7, UB8, UB9, UB10,type (physical, mental, etc.)
//Name will be a string
//Type is an int, with 0-fire, 1-water, 2-grass, 3-flying, 4-normal
//For special moves, second row is stat (0 - attack, 1 - defence, 2 - specattack, 3- specdefence, 4 - speed)
//third is up(0)/down(1), fourth is self(0)/opponent(1), fifth is strength of change (1 being one stage, 2 being 2 stages, etc.)
Table moves;
Table specialMoves;

//Creates the 3 pokemon
Pokemon charizard;
Pokemon blastoise;
Pokemon venusaur;

Gui startScreen;

void setup() {
    size(1200,900);
    moves = loadTable("Prokemon_Moves.csv");
    specialMoves = loadTable("Prokemon_Special_Moves.csv");

    startScreen = new Gui();

    charizard = new Pokemon("Fire");
    charizard.assignMove("Ember", 1);
    charizard.assignMove("Scratch", 1);
    charizard.assignMove("Growl", 1);
    charizard.assignMove("Flamethrower", 1);

    venusaur = new Pokemon("Grass");
    venusaur.assignMove("Petal_Dance", 1);
    venusaur.assignMove("Tackle", 1);
    venusaur.assignMove("Growl", 1);
    venusaur.assignMove("Vine_Whip", 1);

    blastoise = new Pokemon("Water");
    blastoise.assignMove("Tackle", 1);
    blastoise.assignMove("Tail_Whip", 1);
    blastoise.assignMove("Bubble", 1);
    blastoise.assignMove("Water_Gun", 1);
}

void draw() {

}

class Pokemon{
    //Gives the pokemon a type
    String type;
    //Sets the 4 move slots
    Move move1;
    Move move2;
    Move move3;
    Move move4;
    Health health;
    Attack attack;
    Defence defence;
    SpecAttack specAttack;
    SpecDefence specDefence;
    Speed speed;

    boolean unconscious = false;

    Pokemon(String typE) {
        attack = new Attack(100);
        type = typE;
        move1 = new Move();
        move2 = new Move();
        move3 = new Move();
        move4 = new Move();
    }
    //Function to assign a move to a certain slot
    void assignMove(String moveName, int slot) {
        switch (slot) {
            case 1:
                move1.assign(moveName);
                break;
            case 2:
                move2.assign(moveName);
                break;
            case 3:
                move3.assign(moveName);
                break;
            case 4:
                move4.assign(moveName);
                break;
        }
    }
}

class Move {

    int[] info;
    boolean specialMove = false;
    int[] specialInfo;
    boolean buff = false;
    boolean attack = false;
    boolean defence = false;
    boolean sAttack = false;
    boolean sDefence = false;
    boolean speed = false;

    Move() {
        specialInfo = new int[9]; 
    }

    void assign(String name) {
        specialMove = false;
        info = getMoveInfo(name);
        if (info[1] == 0) {
            specialMove = true;
            TableRow result = specialMoves.findRow(name, 0);
            specialInfo[0] = result.getInt(1);
            specialInfo[1] = result.getInt(2);
            specialInfo[2] = result.getInt(3);
            specialInfo[3] = result.getInt(4);
        }
    }

    int[] giveInfo() {
        int[] output = new int[4];
        if (specialMove == false) {
            //Specifies the action the move takes. 0 = attack, 1 = buff, 2 = debuff, 3 = protect
            output[0] = 0;
            //The elemental type that the move has
            output[1] = info[0];
            //The power of the move
            output[2] = info[1];
            //The damage type (physical, mental, etc.)
            output[3] = info[13];
        }
        else if (specialMove == true) {
            switch(specialInfo[0]) {
                case 0:
                    output[0] = specialInfo[1] + 1;
                    //elemental type
                    output[1] = info[0];
                    //Target self - 0, opponent - 1
                    output[2] = specialInfo[2];
                    //Stages of change
                    output[3] = specialInfo[3];
            }
        }
        return output;
    }
}

int[] getMoveInfo(String name) {
    int count = 0;
    int[] output = new int[14];
    while (count < moves.getRowCount()) {
        if (name.equals(moves.getString(count, 0)) == true) {
            output[0] = moves.getInt(count, 1);
            output[1] = moves.getInt(count, 2);
            output[2] = moves.getInt(count, 3);
            output[3] = moves.getInt(count, 4);
            output[4] = moves.getInt(count, 5);
            output[5] = moves.getInt(count, 6);
            output[6] = moves.getInt(count, 7);
            output[7] = moves.getInt(count, 8);
            output[8] = moves.getInt(count, 9);
            output[9] = moves.getInt(count, 10);
            output[10] = moves.getInt(count, 11);
            output[11] = moves.getInt(count, 12);
            output[12] = moves.getInt(count, 13);
            output[13] = moves.getInt(count,14);
        }
        count++;
    }
    return output;
}

void keyPressed() {
    if (key == 'l') {
        exit();
    }
}

class Gui {

    Button team;
    color c = color(250,250,250);

    Gui() {
        team = new Button(100,100,20,120,"Hello",c, 20);
        team.display();
    }

    void displayStart() {

    }
}

class Button {

    float x;
    float y;
    float hei;
    float wid;
    color fill;
    String text;
    float tX;
    float tY;
    int tSize;

    Button(float cordsX, float cordsY, float heighT, float widtH, String texts, color fills, int size) {
        x = cordsX;
        y = cordsY;
        hei = heighT;
        wid = widtH;
        text = texts;
        fill = fills;
        tY = ((hei/2) + y);
        tX = ((wid/2) + x);
        tSize = size;
    }

    void display() {
        fill(fill);
        stroke(fill);
        rect(x,y,wid,hei);
        fill(0);
        textAlign(CENTER,CENTER);
        textSize(tSize);
        text(text,tX, tY);
    }

    boolean mouseHover() {
        boolean output = false;
        if (mouseX >= x && mouseX <= x+wid) {
            if (mouseY >= y && mouseY <= y+hei) {
                output = true;
            }
        }
        return output;
    }
}


class Attack {

    int baseStat;
    int buffStage = 0;
    int debuffStage = 0;
    int currentStat;
    int buffStat;
    int debuffStat;
    float buffAmount;
    float debuffAmount;

    Attack(int input) {
        baseStat = input;
    }

    void buff(int magnitude) {
        buffStage = buffStage + magnitude;
        if (buffStage > 6) {
            buffStage = 6;
        }
        switch (buffStage) {
            case 1:
                buffAmount = 1.5;
                break;
            case 2:
                buffAmount = 2;
                break;
            case 3:
                buffAmount = 2.5;
                break;
            case 4:
                buffAmount = 3;
                break;
            case 5:
                buffAmount = 3.5;
                break;
            case 6:
                buffAmount = 4;
                break;
        }
    }

    void debuff(int magnitude) {
        debuffStage = debuffStage + magnitude;
        if (debuffStage > 6) {
            debuffStage = 6;
            switch (debuffStage) {
            case 1:
                debuffAmount = .666;
                break;
            case 2:
                debuffAmount = .5;
                break;
            case 3:
                debuffAmount = .4;
                break;
            case 4:
                debuffAmount = .333;
                break;
            case 5:
                debuffAmount = .285;
                break;
            case 6:
                debuffAmount = .25;
                break;
        }
        }
    }

    void change(int newValue) {
        baseStat = newValue;
    }

    int returnStats() {
        return currentStat;
    }
}

class Defence {

    int baseStat;
    int buffStage = 0;
    int debuffStage = 0;
    int currentStat;
    int buffStat;
    int debuffStat;
    float buffAmount;
    float debuffAmount;

    Defence(int input) {
        baseStat = input;
    }

    void buff(int magnitude) {
        buffStage = buffStage + magnitude;
        if (buffStage > 6) {
            buffStage = 6;
        }
        switch (buffStage) {
            case 1:
                buffAmount = 1.5;
                break;
            case 2:
                buffAmount = 2;
                break;
            case 3:
                buffAmount = 2.5;
                break;
            case 4:
                buffAmount = 3;
                break;
            case 5:
                buffAmount = 3.5;
                break;
            case 6:
                buffAmount = 4;
                break;
        }
    }

    void debuff(int magnitude) {
        debuffStage = debuffStage + magnitude;
        if (debuffStage > 6) {
            debuffStage = 6;
            switch (debuffStage) {
            case 1:
                debuffAmount = .666;
                break;
            case 2:
                debuffAmount = .5;
                break;
            case 3:
                debuffAmount = .4;
                break;
            case 4:
                debuffAmount = .333;
                break;
            case 5:
                debuffAmount = .285;
                break;
            case 6:
                debuffAmount = .25;
                break;
        }
        }
    }

    void change(int newValue) {
        baseStat = newValue;
    }

    int returnStats() {
        return currentStat;
    }
}

class Health {
    int totalHealth;
    int currentHealth;

    Health(int value) {
        totalHealth = value;
    }

    boolean checkState() {
        boolean output = false;
        if (currentHealth <= 0) {
            output = true;
        }
        return output;
    }

    int checkHealth() {
        return currentHealth;
    }
    
    boolean canBeHealed() {
        boolean output = false;
        if (currentHealth < totalHealth) {
            output = true;
        }
        return output;
    }
    
    int heal(int amountHealed) {
        currentHealth = currentHealth + amountHealed;
        if (currentHealth > totalHealth) {
            currentHealth = totalHealth;
        }
        return currentHealth;
    }
    
    int damage(int amountDamaged) {
        currentHealth = currentHealth - amountDamaged;
        if (currentHealth < 0) {
            currentHealth = 0;
        }
        return currentHealth;
    }

    void increaseHealth(int amount) {
        totalHealth = amount;
    }
}

class SpecAttack {

    int baseStat;
    int buffStage = 0;
    int debuffStage = 0;
    int currentStat;
    int buffStat;
    int debuffStat;
    float buffAmount;
    float debuffAmount;

    SpecAttack(int amount) {
        baseStat = amount;
    }

    void buff(int magnitude) {
        buffStage = buffStage + magnitude;
        if (buffStage > 6) {
            buffStage = 6;
        }
        switch (buffStage) {
            case 1:
                buffAmount = 1.5;
                break;
            case 2:
                buffAmount = 2;
                break;
            case 3:
                buffAmount = 2.5;
                break;
            case 4:
                buffAmount = 3;
                break;
            case 5:
                buffAmount = 3.5;
                break;
            case 6:
                buffAmount = 4;
                break;
        }
    }

    void debuff(int magnitude) {
        debuffStage = debuffStage + magnitude;
        if (debuffStage > 6) {
            debuffStage = 6;
            switch (debuffStage) {
            case 1:
                debuffAmount = .666;
                break;
            case 2:
                debuffAmount = .5;
                break;
            case 3:
                debuffAmount = .4;
                break;
            case 4:
                debuffAmount = .333;
                break;
            case 5:
                debuffAmount = .285;
                break;
            case 6:
                debuffAmount = .25;
                break;
        }
        }
    }

    void change(int newValue) {
        baseStat = newValue;
    }

    int returnStats() {
        return currentStat;
    }
}

class SpecDefence {
    
    int baseStat;
    int buffStage = 0;
    int debuffStage = 0;
    int currentStat;
    int buffStat;
    int debuffStat;
    float buffAmount;
    float debuffAmount;

    SpecDefence() {

    }

    void buff(int magnitude) {
        buffStage = buffStage + magnitude;
        if (buffStage > 6) {
            buffStage = 6;
        }
        switch (buffStage) {
            case 1:
                buffAmount = 1.5;
                break;
            case 2:
                buffAmount = 2;
                break;
            case 3:
                buffAmount = 2.5;
                break;
            case 4:
                buffAmount = 3;
                break;
            case 5:
                buffAmount = 3.5;
                break;
            case 6:
                buffAmount = 4;
                break;
        }
    }

    void debuff(int magnitude) {
        debuffStage = debuffStage + magnitude;
        if (debuffStage > 6) {
            debuffStage = 6;
            switch (debuffStage) {
            case 1:
                debuffAmount = .666;
                break;
            case 2:
                debuffAmount = .5;
                break;
            case 3:
                debuffAmount = .4;
                break;
            case 4:
                debuffAmount = .333;
                break;
            case 5:
                debuffAmount = .285;
                break;
            case 6:
                debuffAmount = .25;
                break;
        }
        }
    }

    void change(int newValue) {
        baseStat = newValue;
    }

    int returnStats() {
        return currentStat;
    }
}

class Speed {

    int baseStat;
    int buffStage = 0;
    int debuffStage = 0;
    int currentStat;
    int buffStat;
    int debuffStat;
    float buffAmount;
    float debuffAmount;

    Speed() {

    }

    void buff(int magnitude) {
        buffStage = buffStage + magnitude;
        if (buffStage > 6) {
            buffStage = 6;
        }
        switch (buffStage) {
            case 1:
                buffAmount = 1.5;
                break;
            case 2:
                buffAmount = 2;
                break;
            case 3:
                buffAmount = 2.5;
                break;
            case 4:
                buffAmount = 3;
                break;
            case 5:
                buffAmount = 3.5;
                break;
            case 6:
                buffAmount = 4;
                break;
        }
    }

    void debuff(int magnitude) {
        debuffStage = debuffStage + magnitude;
        if (debuffStage > 6) {
            debuffStage = 6;
            switch (debuffStage) {
            case 1:
                debuffAmount = .666;
                break;
            case 2:
                debuffAmount = .5;
                break;
            case 3:
                debuffAmount = .4;
                break;
            case 4:
                debuffAmount = .333;
                break;
            case 5:
                debuffAmount = .285;
                break;
            case 6:
                debuffAmount = .25;
                break;
        }
        }
    }

    void change(int newValue) {
        baseStat = newValue;
    }

    int returnStats() {
        return currentStat;
    }
}