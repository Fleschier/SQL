package simpledb;

import sun.net.www.HeaderParser;

import java.util.Iterator;
import java.util.NoSuchElementException;

//a class that implements the heapFileIterator
public class HeapFileIterator implements DbFileIterator{
    private Iterator<Tuple> iterTuple;
    private int currentPageNum;
    private TransactionId transID;
    private HeapFile heapFile;
    private Tuple next = null;

    public HeapFileIterator(HeapFile hpFile,TransactionId tranId){
        heapFile = hpFile;
        transID = tranId;
    }

   public void open(){
        currentPageNum = -1;
   }

   public void close(){
        next = null;
        iterTuple = null;
        currentPageNum = Integer.MAX_VALUE;
   }

   public void rewind(){
        this.close();
        this.open();
   }

    //complete the interface funcs
   public Tuple readNext() throws DbException, TransactionAbortedException{
        //no more tuples in iterator
       if(iterTuple != null && !iterTuple.hasNext()){
           iterTuple = null;
       }

       while (iterTuple == null && currentPageNum < heapFile.numPages() - 1){
           currentPageNum ++;

           HeapPageId currPageID = new HeapPageId(heapFile.getId(),currentPageNum);
           HeapPage currentPage = (HeapPage) Database.getBufferPool().getPage(transID, currPageID, Permissions.READ_ONLY);

            iterTuple = currentPage.iterator();

            if(!iterTuple.hasNext()){
                iterTuple = null;
            }

       }

       if(iterTuple == null){
           return null;
       }

       return iterTuple.next();
   }

   public Tuple next() throws DbException, TransactionAbortedException,
           NoSuchElementException {
       if (next == null) {
           next = readNext();
           if (next == null) throw new NoSuchElementException();
       }

       Tuple result = next;
       next = null;
       return result;
   }

    public boolean hasNext() throws DbException, TransactionAbortedException {
        if (next == null) next = readNext();
        return next != null;
    }

}
