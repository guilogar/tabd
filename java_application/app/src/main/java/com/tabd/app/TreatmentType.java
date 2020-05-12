/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tabd.app;


import java.math.BigDecimal;
import java.sql.Array;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Struct;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.Map;

public class TreatmentType {
    
    private Database db;
    private BigDecimal id;
    private String table;
    
    public TreatmentType(Database db, BigDecimal id) throws SQLException
    {
        this.db = db;
        this.id = id;
        this.table = " TreatmentType_objtab ";
    }
    
    public Map<String, Object> getAttributes() throws SQLException
    {
        Map<String, Object> atributos = new LinkedHashMap<>();
        
        String[] columns    = { "id" };
        BigDecimal[] values = { this.id };
        ResultSet rs = this.db.searchInTableByValue(this.table, columns, values);
        
        if(rs.next())
        {
            ResultSetMetaData rsmd = rs.getMetaData();
            int columnCount = rsmd.getColumnCount();
            for (int i = 1; i <= columnCount; i++ )
            {
                String nameAttr = rsmd.getColumnName(i);
                atributos.put(nameAttr, rs.getObject(nameAttr));
            }
        }
        
        return atributos;
    }
    
    public void printTreatmentType() throws SQLException
    {
        Map<String, Object> atributos = getAttributes();
        
        for(String key : atributos.keySet())
        {
            Object value = (Object) atributos.get(key);
            
            if(value instanceof Struct)
            {
                Struct valueStruct = (Struct) value;
                Object[] valueAttributes = valueStruct.getAttributes();
                
                System.out.println(key + ": ");
                System.out.println("======================");
                
                for(Object attribute : valueAttributes)
                {
                    System.out.println(attribute);
                }
                System.out.println("======================");
            } else if(value instanceof Array)
            {
                Array valueArray = (Array) value;
                ResultSet rs = valueArray.getResultSet();
                
                System.out.println(key + ": ");
                System.out.println("======================");
                
                while(rs.next())
                {
                    ResultSetMetaData rsmd = rs.getMetaData();
                    int columnCount = rsmd.getColumnCount();
                    
                    for(int i = 0; i < columnCount; i++)
                    {
                        System.out.println(rs.getObject(i));
                    }
                }
                
                System.out.println("======================");
            } else
            {
                System.out.println(key + ": " + value);
            }
        }
    }
    
    public static boolean createTreatmentType(Database db, Object[] values) throws SQLException
    {
        String procedure = "createTreatmentType";
        return db.insertInTable(procedure, values) > 0;
    }
    
    public static ArrayList<TreatmentType> listAllTreatmentTypes(Database db) throws SQLException
    {
        ResultSet rset = db.selectByTable("TreatmentType_objtab");
        ArrayList<TreatmentType> t = new ArrayList<>();
        
        while(rset.next())
        {
            Object id = rset.getObject("id");
            t.add(new TreatmentType(db, (BigDecimal) id));
        }
        
        return t;
    }
    
    public static void printTreatmentTypes(ArrayList<TreatmentType> treatments) throws SQLException
    {
        for(TreatmentType t : treatments)
        {
            t.printTreatmentType();
            System.out.println("=======================================");
            System.out.println("=======================================");
        }
    }
}
