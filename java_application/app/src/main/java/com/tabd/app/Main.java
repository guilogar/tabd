package com.tabd.app;

import java.math.BigDecimal;
import java.sql.*;
import java.util.Map;
import java.sql.Struct;
import java.util.Scanner;
import oracle.jdbc.internal.OracleTypes;
import oracle.sql.STRUCT;

public class Main
{
    public static void gestionarFamilias(Database db) throws SQLException
    {
        System.out.println("Bienvenido a la gestión de las familias.");
        System.out.println("¿Que desea hacer?");
        
        System.out.println("1º) Mostrar todas las familias existentes");
        System.out.println("2º) Buscar una familia por su nombre");
        System.out.println("3º) Modificar el telefono de una familia existente");
        System.out.println("4º) Modificar el email de una familia existente");
        System.out.println("5º) Modificar la direccion de una familia existente");
        System.out.println("6º) Borrar una familia existente");
        System.out.println("7º) Crear una familia");
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
                case 1: {
                    Family.printFamilys(
                        Family.listAllFamilys(db)
                    );
                }; break;
                case 2: {
                    Scanner s = new Scanner(System.in);
                    System.out.print("Introduzca el nombre de la familia a buscar ==> ");
                    String line = s.nextLine();
                    
                    Family.printFamilys(
                        Family.searchFamilys(db, line, true)
                    );
                }; break;
                case 3: {
                    Scanner s = new Scanner(System.in);
                    Scanner ss = new Scanner(System.in);
                    
                    System.out.print("Introduzca el id de la familia a modificar ==> ");
                    BigDecimal id = s.nextBigDecimal();
                    
                    System.out.print("Introduzca el nuevo telefono ==> ");
                    String phone = ss.nextLine();
                    
                    Family f = new Family(db, id);
                    
                    if(f.familyExists())
                    {
                        if(f.updatePhone(phone))
                        {
                            System.out.println("Familia actualizada correctamente.");
                        } else
                        {
                            System.out.println("Familia no actualizada. Vuelva a intentarlo.");
                        }
                    } else
                    {
                        System.out.println("La familia con el id " + id + " no existe. Por favor, pruebe otro id.");
                    }
                }; break;
                case 4: {
                    Scanner s = new Scanner(System.in);
                    Scanner ss = new Scanner(System.in);
                    
                    System.out.print("Introduzca el id de la familia a modificar ==> ");
                    BigDecimal id = s.nextBigDecimal();
                    
                    System.out.print("Introduzca el nuevo email ==> ");
                    String email = ss.nextLine();
                    
                    Family f = new Family(db, id);
                    
                    if(f.familyExists())
                    {
                        if(f.updateEmail(email))
                        {
                            System.out.println("Familia actualizada correctamente.");
                        } else
                        {
                            System.out.println("Familia no actualizada. Vuelva a intentarlo.");
                        }
                    } else
                    {
                        System.out.println("La familia con el id " + id + " no existe. Por favor, pruebe otro id.");
                    }
                }; break;
                case 5: {
                    Scanner s = new Scanner(System.in);
                    
                    System.out.print("Introduzca el id de la familia a modificar la dirección ==> ");
                    BigDecimal id = s.nextBigDecimal();
                    
                    Family f = new Family(db, id);
                    
                    if(f.familyExists())
                    {
                        Object[] dir = new Object[4];
                        s = new Scanner(System.in);
                        
                        System.out.print("Introduzca la calle de la dirección ==> ");
                        dir[0] = s.nextLine();

                        s = new Scanner(System.in);

                        System.out.print("Introduzca el numero de la casa de la dirección (introduzca un número, cualquier otra cosa dara un error) ==> ");
                        dir[1] = s.nextInt();

                        s = new Scanner(System.in);

                        System.out.print("Introduzca el apartamento de la dirección ==> ");
                        dir[2] = s.nextLine();

                        s = new Scanner(System.in);

                        System.out.print("Introduzca el codigo postal de la dirección ==> ");
                        dir[3] = s.nextLine();

                        Struct address = db.callFunction("createAddress", dir, OracleTypes.STRUCT, "ADDRESS_OBJTYP");
                        
                        if(f.updateAddress(address))
                        {
                            System.out.println("La dirección de la familia ha sido actualizada correctamente.");
                        } else
                        {
                            System.out.println("Ha ocurrido un error con la actualización. Por favor, vuelta a intentarlo.");
                        }
                    } else
                    {
                        System.out.println("La familia con el id " + id + " no existe. Por favor, pruebe otro id.");
                    }
                }; break;
                case 6: {
                    Scanner s = new Scanner(System.in);
                    Scanner ss = new Scanner(System.in);
                    
                    System.out.print("Introduzca el id de la familia a borrar ==> ");
                    BigDecimal id = s.nextBigDecimal();
                    
                    Family f = new Family(db, id);
                    
                    if(f.familyExists())
                    {
                        if(f.destroy())
                        {
                            System.out.println("Familia borrada correctamente.");
                        } else
                        {
                            System.out.println("Familia no borrada. Vuelva a intentarlo.");
                        }
                    } else
                    {
                        System.out.println("La familia con el id " + id + " no existe. Por favor, pruebe otro id.");
                    }
                }; break;
                case 7: {
                    Scanner s = new Scanner(System.in);
                    Object[] values = new Object[5];
                    
                    System.out.print("Introduzca el nombre ==> ");
                    values[0] = s.nextLine();
                    
                    s = new Scanner(System.in);
                    
                    System.out.print("Introduzca el nombre de contacto ==> ");
                    values[1] = s.nextLine();
                    
                    s = new Scanner(System.in);
                    
                    System.out.print("Introduzca el telefono ==> ");
                    values[2] = s.nextLine();
                    
                    s = new Scanner(System.in);
                    
                    System.out.print("Introduzca el email ==> ");
                    values[3] = s.nextLine();
                    
                    s = new Scanner(System.in);
                    
                    Object[] dir = new Object[4];
                    
                    System.out.print("Introduzca la calle de la dirección ==> ");
                    dir[0] = s.nextLine();
                    
                    s = new Scanner(System.in);
                    
                    System.out.print("Introduzca el numero de la casa de la dirección (introduzca un número, cualquier otra cosa dara un error) ==> ");
                    dir[1] = s.nextInt();
                    
                    s = new Scanner(System.in);
                    
                    System.out.print("Introduzca el apartamento de la dirección ==> ");
                    dir[2] = s.nextLine();
                    
                    s = new Scanner(System.in);
                    
                    System.out.print("Introduzca el codigo postal de la dirección ==> ");
                    dir[3] = s.nextLine();
                    
                    values[4] = db.callFunction("createAddress", dir, OracleTypes.STRUCT, "ADDRESS_OBJTYP");
                    
                    if(Family.createFamily(db, values))
                    {
                        System.out.println("Familia creada correctamente.");
                    } else
                    {
                        System.out.println("Familia no creada. Vuelva a intentarlo.");
                    }
                }; break;
                default:
                {
                    System.out.println("Elección incorrecta. Por favor, introduzca una opción valida.");
                    System.out.print("Su elección (escriba '0' para salir) ==> ");
                }
            }
        } while(option < 0 || option > 6);
    }
    
    public static void gestionarAnimales(Database db)
    {
        
    }
    
    public static void gestionarTratamientos(Database db)
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
            ProcessBuilder pb = new ProcessBuilder();
            Map<String, String> env = pb.environment();
            env.put("DB_HOST", "localhost");
            env.put("DB_USER", "guillermo");
            env.put("DB_PASS", "guillermo");
            Database db = new Database(pb);
            
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
                case 1: gestionarFamilias(db); break;
                case 2: gestionarAnimales(db); break;
                case 3: gestionarTratamientos(db); break;
                default:
                {
                    System.out.println("Elección incorrecta. Por favor, introduzca una opción valida.");
                    System.out.print("Su elección (escriba '0' para salir) ==> ");
                }
            }
        } while(option < 0 || option > 3);
    }
}