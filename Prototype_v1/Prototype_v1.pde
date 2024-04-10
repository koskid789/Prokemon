//Owen Koslowsky
//The following is a prototype for the Prokemon game that I will be developing along with Aiden Preza and Manit Sethi

import controlP5.*;
//Rows in the table are: Name, Type, Power, PP, UB1, UB2, UB3, UB4, UB5, UB6, UB7, UB8, UB9, UB10
//Name will be a string
//Type is an int, with 0-fire, 1-water, 2-grass, 3-flying, 4-normal
Table moves;
Table specialMoves;

//Creates the 3 pokemon
Pokemon charizard;
Pokemon blastoise;
Pokemon venusaur;

void setup() {
    size(1200,900);
    moves = loadTable("Prokemon_Moves.csv");
    specialMoves = loadTable("Prokemon_Special_Moves.csv");

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

    Pokemon(String typE) {
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
        }
    }
}

class Move {


    Move() {

    }

    void assign(String name) {
        int[] info = getMoveInfo(name);
        println(info);
    }
}

int[] getMoveInfo(String name) {
    int count = 0;
    int[] output = new int[13];
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