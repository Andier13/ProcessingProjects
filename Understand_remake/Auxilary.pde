class pairInt{
    int i, j;
    
    pairInt(int i, int j){
        this.i = i;
        this.j = j;
    }
}

pairInt last(ArrayList<pairInt> arr){
    return arr.get(arr.size()-1);
}

boolean adjacent(pairInt p1, pairInt p2){
    return (abs(p2.i-p1.i)==1 && p2.j-p1.j==0) || (abs(p2.j-p1.j)==1 && p2.i-p1.i==0);
}

int random_int(int max){
    return floor(random(max+1));
}
