//Owen Koslowsky
//The following is a prototype for the Prokemon game that I will be developing along with Aiden Preza and Manit Sethi

import controlP5.*;
//Rows in the table are: Name, Type, PP, UB1, UB2, UB3, UB4, UB5
//Name will be a string
//Type is an int, with 0-fire, 1-water, 2-grass, 3-flying, 4-normal
Table moves;

//Creates the 3 pokemon
Pokemon charizard;
Pokemon squirtle;
Pokemon bulbasoar;

void setup() {
    moves = loadTable("Prokemon_Moves.csv");
    charizard = new Pokemon("Fire");
    charizard.assignMove("Ember", 1);
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
    int[] output = new int[7];
    while (count < moves.getRowCount()) {
        if (name.equals(moves.getString(count, 0)) == true) {
            output[0] = moves.getInt(count, 1);
            output[1] = moves.getInt(count, 2);
            output[2] = moves.getInt(count, 3);
            output[3] = moves.getInt(count, 4);
            output[4] = moves.getInt(count, 5);
            output[5] = moves.getInt(count, 6);
            output[6] = moves.getInt(count, 7);
        }
        count++;
    }
    return output;
}