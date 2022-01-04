import mysql.connector
import time

start = time.time()

databaseOld =  mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = 'root',
    database = "employees"
)

databaseNew =  mysql.connector.connect(
    host = "localhost",
    user = "root",
    password = 'root',
    database = "employeesnew"
)

cursorOld = databaseOld.cursor()
cursorNew = databaseNew.cursor()
cursorOld.execute('Select * from employees')
oldData = cursorOld.fetchall()

query = 'INSERT IGNORE INTO employee(EMPLOYE_NUMBER, EMPLOYE_BIRTH_DATE, EMPLOYE_FIRST_NAME, EMPLOYE_LAST_NAME,\
            EMPLOYE_SEX, EMPLOYE_HIRE_DATE) '\
        ' VALUES (%s, %s, %s, %s, %s, %s)'

i = 1
for row in oldData:
    i = i + 1
    cursorNew.execute(query, [row[0], row[1], row[2], row[3], row[4], row[5]])
    if i % 10000 == 0:
        print(i)
databaseNew.commit()
print("employee done")

cursorOld = databaseOld.cursor()
cursorNew = databaseNew.cursor()
cursorOld.execute('Select * from departments')
oldData = cursorOld.fetchall()

query = 'INSERT IGNORE INTO department(DEPARTMENT_NUMBER, DEPARTMENT_NAME) VALUES (%s, %s)'

for row in oldData:
    cursorNew.execute(query, [row[0], row[1]])
databaseNew.commit()
print("department done")

cursorOld = databaseOld.cursor()
cursorNew = databaseNew.cursor()
cursorOld.execute('Select * from dept_emp')
oldData = cursorOld.fetchall()

query = 'INSERT IGNORE INTO department_employee(EMPLOYE_NUMBER, DEPARTMENT_NUMBER, FROM_DATE, TO_DATE)\
            VALUES (%s, %s, %s, %s)'

i = 1
for row in oldData:
    cursorNew.execute(query, [row[0], row[1], row[2], row[3]])
    i = i + 1
    if i % 10000 == 0:
        print(i)
databaseNew.commit()
print("department_employee done")

cursorOld = databaseOld.cursor()
cursorNew = databaseNew.cursor()
cursorOld.execute('Select * from dept_manager')
oldData = cursorOld.fetchall()

query = 'INSERT IGNORE INTO department_manager(EMPLOYE_NUMBER, DEPARTMENT_NUMBER, FROM_DATE, TO_DATE)\
            VALUES (%s, %s, %s, %s)'
i = 1
for row in oldData:
    cursorNew.execute(query, [row[0], row[1], row[2], row[3]])
    i = i + 1
    if i % 10000 == 0:
        print(i)
databaseNew.commit()
print("department_manager done")

cursorOld = databaseOld.cursor()
cursorNew = databaseNew.cursor()
cursorOld.execute('Select * from titles')
oldData = cursorOld.fetchall()

query = 'INSERT IGNORE INTO titles(EMPLOYE_NUMBER, TITLE, FROM_DATE, TO_DATE)\
            VALUES (%s, %s, %s, %s)'
i = 1
for row in oldData:
    cursorNew.execute(query, [row[0], row[1], row[2], row[3]])
    i = i + 1
    if i % 10000 == 0:
        print(i)
databaseNew.commit()
print("titles done")

cursorOld = databaseOld.cursor()
cursorNew = databaseNew.cursor()
cursorOld.execute('Select * from salaries')
oldData = cursorOld.fetchall()

query = 'INSERT IGNORE INTO salaries(EMPLOYE_NUMBER, SALARY, FROM_DATE, TO_DATE)\
            VALUES (%s, %s, %s, %s)'
i = 1
for row in oldData:
    cursorNew.execute(query, [row[0], row[1], row[2], row[3]])
    i = i + 1
    if i % 10000 == 0:
        print(i)
databaseNew.commit()
print("salaries done")

end = time.time()
print("Whole transfer took this many seconds:")
print(end - start)