package com.tabd.app;

import java.sql.*;
import java.math.*;
import java.util.Scanner;
import oracle.jdbc.*;
import oracle.jdbc.pool.*;
import oracle.sql.*;

public class Main
{
    public static void gestionarFamilias() throws SQLException
    {
        DataHandler dh = new DataHandler();
        dh.setDBConnection();
        ResultSet rset = dh.genericSelect("Family_objtab"); // TreatmentType_objtab, Family_objtab, Pet_objtab
        
        while (rset.next()) System.out.println (rset.getString(1));
        return;
        
        System.out.println("Bienvenido a la gestión de las familias.");
        System.out.println("¿Que desea hacer?");
        System.out.println("1º) Mostrar todas las familias existentes");
        System.out.println("2º) Buscar una familia por su nombre");
        System.out.println("3º) Modificar la direccion de una familia existente");
        System.out.println("4º) Modificar el telefono de una familia existente");
        System.out.println("5º) Modificar el email de una familia existente");
        System.out.println("6º) Borrar una familia existente");
        System.out.print("Su elección (escriba '0' para salir) ==> ");
        
        int option;
        
        do
        {
            try
            {
                Scanner s = new Scanner(System.in);
                option = s.nextInt();
            } catch(Exception e)
            {
                option = -1;
            }
            
            switch(option)
            {
                case 0: {} ; break;
                case 1: gestionarFamilias(); break;
                case 2: gestionarAnimales(); break;
                case 3: gestionarTratamientos(); break;
                default:
                {
                    System.out.println("Elección incorrecta. Por favor, introduzca una opción valida.");
                    System.out.print("Su elección (escriba '0' para salir) ==> ");
                }
            }
        } while(option < 0 || option > 6);
    }
    
    public static void gestionarAnimales()
    {
        
    }
    
    public static void gestionarTratamientos()
    {
        
    }
    
    public static void main(String[] args) throws SQLException
    {
        System.out.println("Bienvenido a la aplicación de gestión de la Veterinaria.");
        System.out.println("¿Que desea hacer?");
        System.out.println("1º) Gestionar Familias");
        System.out.println("2º) Gestionar Animales");
        System.out.println("3º) Gestionar Tratamientos");
        
        System.out.print("Su elección (escriba '0' para salir) ==> ");
        
        int option;
        
        do
        {
            try
            {
                Scanner s = new Scanner(System.in);
                option = s.nextInt();
            } catch(Exception e)
            {
                option = -1;
            }
            
            switch(option)
            {
                case 0: {} ; break;
                case 1: gestionarFamilias(); break;
                case 2: gestionarAnimales(); break;
                case 3: gestionarTratamientos(); break;
                default:
                {
                    System.out.println("Elección incorrecta. Por favor, introduzca una opción valida.");
                    System.out.print("Su elección (escriba '0' para salir) ==> ");
                }
            }
        } while(option < 0 || option > 3);
    }
}