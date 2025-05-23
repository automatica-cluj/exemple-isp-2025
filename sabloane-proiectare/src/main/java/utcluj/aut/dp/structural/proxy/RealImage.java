package utcluj.aut.dp.structural.proxy;

public class RealImage implements Image {
    private String fileName;
    
    public RealImage(String fileName) {
        this.fileName = fileName;
        loadFromDisk();
    }
    
    private void loadFromDisk() {
        System.out.println("Încărcare imagine: " + fileName);
    }
    
    @Override
    public void display() {
        System.out.println("Afișare imagine: " + fileName);
    }
}
