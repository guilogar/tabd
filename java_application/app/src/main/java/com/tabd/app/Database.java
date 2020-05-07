/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tabd.app;

import java.math.BigDecimal;
import java.util.Map;
import java.sql.*;
import oracle.jdbc.pool.OracleDataSource;

/**
 *
 * @author oem
 */
public class Database
{
    
    private ProcessBuilder pb;
    private Map<String, String> env;
    private Connection con;
    
    public Database(ProcessBuilder pb) throws SQLException
    {
        this.pb = pb;
        this.env = pb.environment();
        
        this.createConnection();
    }
    
    public Database(ProcessBuilder pb, boolean createConnection) throws SQLException
    {
        this.pb = pb;
        this.env = pb.environment();
        
        if(createConnection)
            this.createConnection();
    }
    
    public boolean createConnection()
    {
        try
        {
            String host   = this.env.get("DB_HOST");
            String dbuser = this.env.get("DB_USER");
            String dbpass = this.env.get("DB_PASS");
            
            if(this.con == null || this.con.isClosed())
            {
                OracleDataSource ds = new OracleDataSource();
                ds.setURL("jdbc:oracle:thin:@//" + host + ":1521/XE");
                this.con = ds.getConnection(dbuser, dbpass);
            }
            return true;
        } catch(Exception ex)
        {
            return false;
        }
    }
    
    public Connection getConnection()
    {
        return this.con;
    }
    
    public boolean destroyConnection()
    {
        try
        {
            if(!this.con.isClosed())
                this.con.close();
            
            return this.con.isClosed();
        } catch(Exception ex)
        {
            return false;
        }
    }
    
    public ResultSet selectByTable(String table) throws SQLException
    {
        return selectByTable(this.con, table);
    }
    
    public ResultSet selectByTable(Connection con, String table) throws SQLException
    {
        
        String query = "select * from " + table;
        Statement ps = this.con.createStatement();
        
        ResultSet rs = ps.executeQuery(query);
        
        return rs;
    }
    
    public ResultSet searchInTableByValue(String table, String[] columns, Object[] values, boolean condi) throws SQLException
    {
        String[] conditions = new String[columns.length];
        for (int i = 0; i < conditions.length; i++)
        {
            if(condi) conditions[i] = " and ";
            else      conditions[i] = " or ";
        }
        return searchInTableByValue(this.con, table, columns, values, conditions);
    }
    
    public ResultSet searchInTableByValue(String table, String[] columns, Object[] values, String[] conditions) throws SQLException
    {
        return searchInTableByValue(this.con, table, columns, values, conditions);
    }
    
    public ResultSet searchInTableByValue(String table, String[] columns, Object[] values) throws SQLException
    {
        String[] conditions = {};
        return searchInTableByValue(this.con, table, columns, values, conditions);
    }
    
    public ResultSet searchInTableByValue(Connection con, String table, String[] columns, Object[] values, String[] conditions) throws SQLException
    {
        if(columns.length > 0)
        {
            String query = "select * from " + table + " where ";
            
            for (int i = 0; i < columns.length - 1; i++)
            {
                String condi = (conditions.length > 0) ? conditions[i] : "";
                
                if(values[i] != null)
                    if(columns[i].indexOf("like") >= 0)
                        query += columns[i] + " ? " + condi;
                    else
                        query += columns[i] + " = ? " + condi;
                else
                    query += columns[i] + " is ? " + condi;
            }
            
            if(values[columns.length - 1] != null)
                if(columns[columns.length - 1].indexOf("like") >= 0)
                    query += columns[columns.length - 1] + " ? ";
                else
                    query += columns[columns.length - 1] + " = ? ";
            else
                query += columns[columns.length - 1] + " is ? ";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            int i = 1;
            for (Object value : values)
            {
                ps.setObject(i++, value);
            }
            
            ResultSet rs = ps.executeQuery();
            return rs;
        } else
        {
            return this.selectByTable(con, table);
        }
    }
    
    public int insertIntoTable(String table, String[] columns, Object[] values) throws SQLException
    {
        return insertIntoTable(this.con, table, columns, values);
    }
    
    public int insertIntoTable(Connection con, String table, String[] columns, Object[] values) throws SQLException
    {
        int cambios = 0;
        
        if(columns.length > 0)
        {
            String query = "insert into " + table + "(";
            
            for (int i = 0; i < columns.length - 1; i++)
            {
                query += columns[i] + ", ";
            }
            
            query += columns[columns.length - 1] + ")";
            query += " values(";
            
            for (int i = 0; i < columns.length - 1; i++)
            {
                query += "?, ";
            }
            
            query += "?)";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            int i = 1;
            for (Object value : values)
            {
                ps.setObject(i++, value);
            }
            
            cambios = ps.executeUpdate();
        }
        
        return cambios;
    }
    
    // New code with call to procedures and functions of oracle database
    public int updateInTable(String table, String procedure, BigDecimal id, Object newValue) throws SQLException
    {
        CallableStatement cs = this.con.prepareCall ( "{call " + procedure + " (?, ?)}" );
        cs.setBigDecimal(1, id);
        cs.setObject(2, newValue);
        return cs.executeUpdate();
    }
    
    // Old code with the order update, of MySQL project...
    public int updateInTable(String table, String[] columns, Object[] values,
                           String[] columnsConditions, Object[] valuesConditions,
                           boolean condi) throws SQLException
    {
        String[] conditions = new String[columns.length];
        for (int i = 0; i < conditions.length; i++)
        {
            if(condi) conditions[i] = " and ";
            else      conditions[i] = " or ";
        }
        return updateInTable(this.con, table, columns, values, columnsConditions, valuesConditions, conditions);
    }
    
    public int updateInTable(String table, String[] columns, Object[] values,
                           String[] columnsConditions, Object[] valuesConditions,
                           String[] conditions) throws SQLException
    {
        return updateInTable(this.con, table, columns, values, columnsConditions, valuesConditions, conditions);
    }
    
    public int updateInTable(Connection con, String table, String[] columns, Object[] values,
                             String[] columnsConditions, Object[] valuesConditions,
                             String[] conditions) throws SQLException
    {
        int cambios = 0;
        if(columns.length > 0)
        {
            String query = "update " + table + "set ";
            
            for (int i = 0; i < columns.length - 1; i++)
            {
                query += columns[i] + " = ?, ";
            }
            
            query += columns[columns.length - 1] + " = ? ";
            
            query += " where ";
            
            for (int i = 0; i < columnsConditions.length - 1; i++)
            {
                String condi = (conditions.length > 0) ? conditions[i] : "";
                if(valuesConditions[i] != null)
                    query += columnsConditions[i] + " = ? " + condi;
                else
                    query += columnsConditions[i] + " is ? " + condi;
            }
            
            if(valuesConditions[columnsConditions.length - 1] != null)
                query += columnsConditions[columnsConditions.length - 1] + " = ? ";
            else
                query += columnsConditions[columnsConditions.length - 1] + " is ? ";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            int i = 1;
            for (Object value : values)
            {
                ps.setObject(i++, value);
            }
            
            for (Object value : valuesConditions)
            {
                ps.setObject(i++, value);
            }
            
            cambios = ps.executeUpdate();
        }
        return cambios;
    }
    
    public int deleteInTable(String table, String[] columns, Object[] values,
                             boolean condi)
                             throws SQLException
    {
        String[] conditions = new String[columns.length];
        for (int i = 0; i < conditions.length; i++)
        {
            if(condi) conditions[i] = " and ";
            else      conditions[i] = " or ";
        }
        return deleteInTable(this.con, table, columns, values, conditions);
    }
    
    public int deleteInTable(String table, String[] columns, Object[] values,
                             String[] conditions)
                             throws SQLException
    {
        return deleteInTable(this.con, table, columns, values, conditions);
    }
    
    public int deleteInTable(Connection con, String table, String[] columns,
                             Object[] values, String[] conditions)
                             throws SQLException
    {
        int cambios = 0;
        
        if(columns.length > 0)
        {
            String query = "delete from " + table + " where ";
            
            for (int i = 0; i < columns.length - 1; i++)
            {
                String condi = (conditions.length > 0) ? conditions[i] : "";
                if(values[i] != null)
                    query += columns[i] + " = ? " + condi;
                else
                    query += columns[i] + " is ? " + condi;
            }
            
            if(values[columns.length - 1] != null)
                query += columns[columns.length - 1] + " = ? ";
            else
                query += columns[columns.length - 1] + " is ? ";
            
            PreparedStatement ps = con.prepareStatement(query);
            
            int i = 1;
            for (Object value : values)
            {
                ps.setObject(i++, value);
            }
            
            cambios = ps.executeUpdate();
        }
        
        return cambios;
    }
}
