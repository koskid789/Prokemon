import at.mukprojects.console.*;
Console console;

void setup() {
    size(800,800);
    println("Hello, World!");

    console = new Console(this);

    console.start();
}

void draw() {
    console.draw();

    console.print();
}