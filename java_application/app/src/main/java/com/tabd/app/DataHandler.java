/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.tabd.app;

/**
 *
 * @author lopez
 */
import java.sql.*;
import oracle.jdbc.pool.OracleDataSource;

public class DataHandler
{
    private final String jdbcUrl = "jdbc:oracle:thin:@//localhost:1521/XE";
    private final String userid = "system";
    private final String password = "root";
    private Connection conn;
    
    public DataHandler() {}
    
        
    public void setDBConnection() throws SQLException
    {
        OracleDataSource ds = new OracleDataSource();
        ds.setURL(this.jdbcUrl);
        this.conn = ds.getConnection(this.userid, this.password);
    }
    
    public Connection getDBConnection() throws SQLException
    {
        return this.conn;
    }
    
    public void closeDBConnection() throws SQLException
    {
        this.conn.close();
    }
    
    public ResultSet genericSelect(String table) throws SQLException
    {
        PreparedStatement pstmt = this.conn.prepareStatement("select * from " + table);
        // pstmt.setString(1, table);
        ResultSet rset = pstmt.executeQuery();
        return rset;
        
        // Example code
        // CallableStatement pstmt = this.conn.prepareCall("{callAdd_proyecto(?,?)}");
        // pstmt.setString(1, table);
    }
}