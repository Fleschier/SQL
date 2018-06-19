package simpledb;

import java.io.Serializable;
import java.util.*;

/**
 * TupleDesc describes the schema of a tuple.
 */
public class TupleDesc implements Serializable {

    /**
     * A help class to facilitate organizing the information of each field
     * */
    public static class TDItem implements Serializable {

        private static final long serialVersionUID = 1L;

        /**
         * The type of the field
         * */
        public final Type fieldType;
        
        /**
         * The name of the field
         * */
        public final String fieldName;

        public TDItem(Type t, String n) {
            this.fieldName = n;
            this.fieldType = t;
        }

        public String toString() {
            return fieldName + "(" + fieldType + ")";
        }
    }

    /**
     * @return
     *        An iterator which iterates over all the field TDItems
     *        that are included in this TupleDesc
     * */

    //创建向量
    public Vector<TDItem> tdVec;

    public Iterator<TDItem> iterator() {
        // some code goes here
        return tdVec.iterator();
    }

    private static final long serialVersionUID = 1L;

    /**
     * Create a new TupleDesc with typeAr.length fields with fields of the
     * specified types, with associated named fields.
     * 
     * @param typeAr
     *            array specifying the number of and types of fields in this
     *            TupleDesc. It must contain at least one entry.
     * @param fieldAr
     *            array specifying the names of the fields. Note that names may
     *            be null.
     */
    public TupleDesc(Type[] typeAr, String[] fieldAr) {
        // some code goes here
        int len = typeAr.length;
        tdVec = new Vector<TDItem>(len);
        for (int i = 0; i< len; i ++){
            tdVec.add(new TDItem(typeAr[i],fieldAr[i]));
        }
    }

    /**
     * Constructor. Create a new tuple desc with typeAr.length fields with
     * fields of the specified types, with anonymous (unnamed) fields.
     * 
     * @param typeAr
     *            array specifying the number of and types of fields in this
     *            TupleDesc. It must contain at least one entry.
     */
    public TupleDesc(Type[] typeAr) {
        // some code goes here
        int len = typeAr.length;
        tdVec = new Vector<TDItem>(len);
        for (int i = 0; i < len; i++){
            tdVec.add(new TDItem(typeAr[i],null));
        }
    }

    /**
     * @return the number of fields in this TupleDesc
     */
    public int numFields() {
        // some code goes here
        return tdVec.size();
    }

    /**
     * Gets the (possibly null) field name of the ith field of this TupleDesc.
     * 
     * @param i
     *            index of the field name to return. It must be a valid index.
     * @return the name of the ith field
     * @throws NoSuchElementException
     *             if i is not a valid field reference.
     */
    public String getFieldName(int i) throws NoSuchElementException {
        // some code goes here
        if(i<0 || i > numFields()){
            throw  new NoSuchElementException("please check input values");
        }
        return tdVec.get(i).fieldName;
    }

    /**
     * Gets the type of the ith field of this TupleDesc.
     * 
     * @param i
     *            The index of the field to get the type of. It must be a valid
     *            index.
     * @return the type of the ith field
     * @throws NoSuchElementException
     *             if i is not a valid field reference.
     */
    public Type getFieldType(int i) throws NoSuchElementException {
        if(i<0 || i > numFields()){
            throw new NoSuchElementException("please check input values");
        }
        return tdVec.get(i).fieldType;
    }

    /**
     * Find the index of the field with a given name.
     * 
     * @param name
     *            name of the field.
     * @return the index of the field that is first to have the given name.
     * @throws NoSuchElementException
     *             if no field with a matching name is found.
     */
    public int fieldNameToIndex(String name) throws NoSuchElementException {
        // some code goes here
        if(name == null) throw new NoSuchElementException("null value for field name");

        boolean isNull = true;
        int len = tdVec.size();
        for(int i =0; i < len; i++){
            String s = tdVec.get(i).fieldName;
            if(s == null) continue;
            isNull = false;

            if(s.equals(name)){
                return i;
            }
        }
        if (isNull)
            throw new NoSuchElementException("null for all field name!");
        throw new NoSuchElementException("can't found the name");
    }

    /**
     * @return The size (in bytes) of tuples corresponding to this TupleDesc.
     *         Note that tuples from a given TupleDesc are of a fixed size.
     */
    public int getSize() {
        // some code goes here
        int n =0;
        for(TDItem itm : tdVec){
            n += itm.fieldType.getLen();
        }
        return n;
    }

    /**
     * Merge two TupleDescs into one, with td1.numFields + td2.numFields fields,
     * with the first td1.numFields coming from td1 and the remaining from td2.
     * 
     * @param td1
     *            The TupleDesc with the first fields of the new TupleDesc
     * @param td2
     *            The TupleDesc with the last fields of the TupleDesc
     * @return the new TupleDesc
     */
    public static TupleDesc merge(TupleDesc td1, TupleDesc td2) {
        // some code goes here
        int newSize = td1.numFields() + td2.numFields();
        Type[] nTypes = new Type[newSize];
        String[] nNames = new String[newSize];
        for(int i = 0; i < td1.numFields(); i++){
            nTypes[i] = td1.getFieldType(i);
            nNames[i] = td1.getFieldName(i);
        }
        for(int i = 0; i < td2.numFields(); i++){
            nTypes[i + td1.numFields()] = td2.getFieldType(i);
            nNames[i + td1.numFields()] = td2.getFieldName(i);
        }
        return new TupleDesc(nTypes,nNames);
    }

    /**
     * Compares the specified object with this TupleDesc for equality. Two
     * TupleDescs are considered equal if they are the same size and if the n-th
     * type in this TupleDesc is equal to the n-th type in td.
     * 
     * @param o
     *            the Object to be compared for equality with this TupleDesc.
     * @return true if the object is equal to this TupleDesc.
     */
    public boolean equals(Object o) {
        // some code goes here

        if(o == null) return false;
        if (!(o instanceof TupleDesc))
            return false;
        //convert o to TupleDesc
        TupleDesc tpDesc = (TupleDesc) o;
        if(this.getSize() == tpDesc.getSize() && this.numFields() == tpDesc.numFields()){
            //one difference would return false
            for(int i =0; i< this.numFields(); i++){
                if(this.getFieldType(i) != tpDesc.getFieldType(i))
                    return false;
            }
            return true; //all same will lead to true
        }
        //other conditions
        return false;
    }

    public int hashCode() {
        // If you want to use TupleDesc as keys for HashMap, implement this so
        // that equal objects have equals hashCode() results
        //throw new UnsupportedOperationException("unimplemented");
        return this.toString().hashCode();
    }

    /**
     * Returns a String describing this descriptor. It should be of the form
     * "fieldName[0](fieldType[0]), ..., fieldName[M](fieldType[M])", although
     * the exact format does not matter.
     * 
     * @return String describing this descriptor.
     */
    public String toString() {
        // some code goes here
        StringBuffer sbuff = new StringBuffer();
        for(int i = 0; i < this.numFields(); i++){
            sbuff.append(tdVec.get(i).fieldType + "[" + i + "]" + "(" + tdVec.get(i).fieldName+ "), ");
        }
        return sbuff.toString();
    }
}
