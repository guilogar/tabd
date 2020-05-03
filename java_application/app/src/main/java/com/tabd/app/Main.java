package com.tabd.app;

import java.sql.*;
import java.math.*;
import oracle.jdbc.*;
import oracle.jdbc.pool.*;
import oracle.sql.*;

public class Main
{
  public static void main(String[] args) throws SQLException
  {
    OracleDataSource ods = new OracleDataSource();
    ods.setURL("");
    ods.setUser("");
    ods.setPassword("");
  }
}