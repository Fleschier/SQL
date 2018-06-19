package simpledb;

import java.io.Serializable;

/**
 * A RecordId is a reference to a specific tuple on a specific page of a
 * specific table.
 */
public class RecordId implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * Creates a new RecordId referring to the specified PageId and tuple
     * number.
     * 
     * @param pid
     *            the pageid of the page on which the tuple resides
     * @param tupleno
     *            the tuple number within the page.
     */
    //add some private members
    private PageId pgID;
    private Integer tupleNo;

    public RecordId(PageId pid, int tupleno) {
        // some code goes here
        pgID = pid;
        tupleNo = tupleno;
    }

    /**
     * @return the tuple number this RecordId references.
     */
    public int tupleno() {
        // some code goes here
        return tupleNo;
    }

    /**
     * @return the page id this RecordId references.
     */
    public PageId getPageId() {
        // some code goes here
        return pgID;
    }

    /**
     * Two RecordId objects are considered equal if they represent the same
     * tuple.
     * 
     * @return True if this and o represent the same tuple
     */
    @Override
    public boolean equals(Object o) {
        // some code goes here
        //throw new UnsupportedOperationException("implement this");
        if (o instanceof RecordId) {
            RecordId arg = (RecordId) o;
            if (this.pgID.equals(arg.pgID) && this.tupleNo == arg.tupleNo){
                return true;
            }
        }
        return false;
    }

    /**
     * You should implement the hashCode() so that two equal RecordId instances
     * (with respect to equals()) have the same hashCode().
     * 
     * @return An int that is the same for equal RecordId objects.
     */
    @Override
    public int hashCode() {
        // some code goes here
        //throw new UnsupportedOperationException("implement this");
        String hash = this.pgID.hashCode() + this.tupleNo.toString();
        return hash.hashCode();
    }

}
