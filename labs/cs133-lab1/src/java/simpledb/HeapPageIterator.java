package simpledb;

import java.util.Iterator;

public class HeapPageIterator implements Iterator<Tuple> {
    private HeapPage heapPage;
    private int numTuples;
    private int curTuple;

    public boolean hasNext() {

        return (this.curTuple < this.numTuples);
    }

    public Tuple next() {
        return heapPage.tuples[curTuple++];
    }

    public void remove() throws UnsupportedOperationException{
        throw new UnsupportedOperationException("Invalid remove operation");
    }

    public HeapPageIterator(HeapPage heapPage) {
        this.heapPage = heapPage;
        this.curTuple = 0;
        this.numTuples = heapPage.getAvailableTuples();
    }
}
