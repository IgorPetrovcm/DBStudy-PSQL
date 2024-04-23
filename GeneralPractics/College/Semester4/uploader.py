import psycopg2 
from dotenv import load_dotenv
import os

load_dotenv()

try: 
    connection = psycopg2.connect(host = "localhost", 
                                     port = os.getenv("CONTAINER_IN_PORT"), 
                                     password = os.getenv("POSTGRES_PASSWORD"), 
                                     user = os.getenv("POSTGRES_USERNAME"),
                                     dbname = "college"
                                     )
    connection.autocommit = True
    
    db_console_cursor = connection.cursor()

    with open("college-init.sql", "r") as file_with_init:
        sql_script = file_with_init.read()
        db_console_cursor.execute(sql_script)
        connection.commit()

    with open("college-fill.sql", "r", encoding="utf-8") as file_with_fill:
        sql_script = file_with_fill.read()
        db_console_cursor.execute(sql_script)
        connection.commit()
        

except (Exception, psycopg2.DatabaseError) as e:
    print(f"Exception: {e}")

finally:
    db_console_cursor.close()
    connection.close()
