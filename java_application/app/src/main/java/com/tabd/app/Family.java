/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tabd.app;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Struct;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedHashMap;
import java.util.Map;
import java.util.Set;

public class Family {
    
    private Database db;
    private BigDecimal id;
    private String table;
    
    public Family(Database db, BigDecimal id) throws SQLException
    {
        this.db = db;
        this.id = id;
        this.table = " Family_objtab ";
    }
    
    public boolean familyExists() throws SQLException
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
    
    public Map<String, Object> updateAttributes(String[] columns, Object[] values) throws SQLException
    {
        Map<String, Object> atributos = getAttributes();
        
        Set<String> k        = atributos.keySet();
        Collection<Object> v = (Collection<Object>) atributos.values();
        
        String[] columnsConditions = (String[]) k.toArray(new String[0]);
        Object[] valuesConditions  = (Object[]) v.toArray();
        
        this.db.updateInTable(this.table, columns, values, columnsConditions, valuesConditions, true);
        
        atributos = getAttributes();
        
        return atributos;
    }
    
    public boolean update(String procedure, String newValue) throws SQLException
    {
        return this.db.updateInTable(this.table, procedure, this.id, newValue) > 0;
    }
    
    public boolean destroy() throws SQLException
    {
        Map<String, Object> atributos = getAttributes();
        
        Set<String> k        = atributos.keySet();
        Collection<Object> v = (Collection<Object>) atributos.values();
        
        String[] columnsConditions = (String[]) k.toArray(new String[0]);
        Object[] valuesConditions  = (Object[]) v.toArray();
        
        int cambios = this.db.deleteInTable(this.table, columnsConditions, valuesConditions, true);
        
        return (cambios > 0);
    }
    
    public void printFamily() throws SQLException
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
            } else
            {
                System.out.println(key + ": " + value);
            }
        }
    }
    
    public static ArrayList<Family> listAllFamilys(Database db) throws SQLException
    {
        ResultSet rset = db.selectByTable("Family_objtab");
        ArrayList<Family> f = new ArrayList<>();
        
        while(rset.next())
        {
            Object id = rset.getObject("id");
            f.add(new Family(db, (BigDecimal) id));
        }
        
        return f;
    }
    
    public static ArrayList<Family> searchFamilys(Database db, String familyName, boolean useLike) throws SQLException
    {
        String[] columns = { " lower(familyname) like " };
        Object[] values  = { (useLike) ? "%" + familyName + "%" : familyName };
        ResultSet rset = db.searchInTableByValue("Family_objtab", columns, values);
        
        ArrayList<Family> f = new ArrayList<>();
        System.out.println(rset.getRow());
            
        while(rset.next())
        {
            Object id = rset.getObject("id");
            f.add(new Family(db, (BigDecimal) id));
        }
        
        return f;
    }
    
    public static void printFamilys(ArrayList<Family> familys) throws SQLException
    {
        for(Family f : familys)
        {
            f.printFamily();
            System.out.println("=======================================");
            System.out.println("=======================================");
        }
    }
}
