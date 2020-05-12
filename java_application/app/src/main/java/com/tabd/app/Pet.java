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

public class Pet {
    
    private Database db;
    private BigDecimal id;
    private String table;
    
    public Pet(Database db, BigDecimal id) throws SQLException
    {
        this.db = db;
        this.id = id;
        this.table = " Pet_objtab ";
    }
    
    public boolean petExists() throws SQLException
    {
        return !this.getAttributes().isEmpty();
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
    
    public boolean update(String procedure, Object newValue) throws SQLException
    {
        return this.db.updateInTable(procedure, this.id, newValue) > 0;
    }
    
    public boolean updateDateBirth(String date) throws SQLException
    {
        return this.update("setPetDateOfBirth", date);
    }
    
    public boolean updateName(String name) throws SQLException
    {
        return this.update("setPetName", name);
    }
    
    public boolean updateType(String type) throws SQLException
    {
        return this.update("setPetType", type);
    }
    
    public boolean destroy() throws SQLException
    {
        String procedure = "deletePet";
        return this.db.destroyInTable(procedure, this.id) > 0;
    }
    
    public void printTreatmentList() throws SQLException
    {
        Map<String, Object> atributos = this.getAttributes();
        
        Array valueArray = (Array) atributos.get("TREATMENTS_LIST");
        ResultSet rs = valueArray.getResultSet();

        System.out.println("Treatments List: ");
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
    }
    
    public void printPet() throws SQLException
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
    
    public static boolean createPet(Database db, Object[] values) throws SQLException
    {
        String procedure = "createPet";
        return db.insertInTable(procedure, values) > 0;
    }
    
    public static ArrayList<Pet> listAllPets(Database db) throws SQLException
    {
        ResultSet rset = db.selectByTable("Pet_objtab");
        ArrayList<Pet> p = new ArrayList<>();
        
        while(rset.next())
        {
            Object id = rset.getObject("id");
            p.add(new Pet(db, (BigDecimal) id));
        }
        
        return p;
    }
    
    public static ArrayList<Pet> searchPets(Database db, String name, boolean useLike) throws SQLException
    {
        String[] columns = { " lower(name) like " };
        Object[] values  = { (useLike) ? "%" + name + "%" : name };
        ResultSet rset = db.searchInTableByValue("Pet_objtab", columns, values);
        
        ArrayList<Pet> p = new ArrayList<>();
            
        while(rset.next())
        {
            Object id = rset.getObject("id");
            p.add(new Pet(db, (BigDecimal) id));
        }
        
        return p;
    }
    
    public static void printPets(ArrayList<Pet> pets) throws SQLException
    {
        for(Pet p : pets)
        {
            p.printPet();
            System.out.println("=======================================");
            System.out.println("=======================================");
        }
    }
}
