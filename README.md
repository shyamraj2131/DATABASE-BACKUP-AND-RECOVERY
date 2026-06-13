
COMPANY: CODTECH IT SOLUTIONS

NAME: SOLOMON SHYAM RAJ

INTERN ID: CTIS9521

DURATION: 6 WEEKS

MENTOR: NEELA SANTOSH

# Task 4: Database Backup and Recovery using MySQL

This project demonstrates the implementation of a complete Database Backup and Recovery system for a Library Management System using MySQL Workbench. The objective of this task is to understand the importance of data protection, backup strategies, and recovery mechanisms in database management. In real-world applications, accidental deletion, incorrect updates, hardware failures, or system crashes can lead to data loss. Therefore, maintaining reliable backups and having an effective recovery plan are essential for ensuring data integrity and business continuity.

The project begins with the creation of a database named `library_db`, which represents a Library Management System. The database consists of five tables: `Members`, `Authors`, `Books`, `Issued_Books`, and `Backup_Log`. These tables store information related to library members, book authors, available books, issued book transactions, and backup activity records. Appropriate primary keys, foreign key relationships, and constraints are used to maintain data consistency and establish relationships between tables.

After designing the database schema, sample records are inserted into all tables to simulate a real-world library environment. The data includes multiple authors, members, books, and book issue transactions. This sample dataset serves as the foundation for testing backup and recovery operations.

The project implements two different backup methods. The first method is a table-level backup strategy where backup copies of important tables are created within the same database using the `CREATE TABLE AS SELECT` statement.

<img width="210" height="91" alt="image" src="https://github.com/user-attachments/assets/70514c9e-3664-4ace-8f5a-c1a2c584b854" />

Separate backup tables such as `Members_Backup`, `Authors_Backup`, `Books_Backup`, and `Issued_Books_Backup` are generated. This method is useful when a specific table needs to be restored after accidental modification or deletion.

<img width="264" height="93" alt="image" src="https://github.com/user-attachments/assets/6b4b4ab0-6def-48b6-9042-dc0b48bdcdba" />

The second method is a database snapshot backup. A separate database named `library_db_backup` is created, and complete copies of the original tables are stored within it. This approach simulates a full database backup and can be used when an entire database becomes corrupted or unavailable. Verification queries are executed after backup creation to ensure that the row counts in backup tables match the original tables.

<img width="207" height="96" alt="image" src="https://github.com/user-attachments/assets/c60c44ce-8872-4717-915a-c5ed2662142f" />

To demonstrate the recovery process, several failure scenarios are intentionally simulated. These include deleting all records from the `Issued_Books` table, deleting selected member records, and incorrectly updating the number of available book copies. These scenarios mimic common database issues that may occur in production environments due to human error or system failures.

<img width="258" height="96" alt="image" src="https://github.com/user-attachments/assets/e25e971c-6adc-4aff-9b99-8ecaf5456a39" />
<img width="462" height="147" alt="image" src="https://github.com/user-attachments/assets/08ab94cd-e610-4828-a46f-e319d95bc528" />

The recovery phase uses different techniques depending on the type of data loss. Complete table restoration is performed using backup tables and `INSERT INTO ... SELECT` statements. Missing records are recovered by comparing current data with backup data and inserting only the lost records. Incorrectly modified values are restored using `UPDATE` statements combined with joins between the original and backup tables. Additionally, a full database restoration process is demonstrated using the snapshot database.

<img width="207" height="58" alt="image" src="https://github.com/user-attachments/assets/5bcaf915-8654-4e75-b94e-5d17eb9374c2" />
<img width="159" height="54" alt="image" src="https://github.com/user-attachments/assets/e2b8abdf-59a6-4eef-8985-091c970a261a" />
<img width="403" height="141" alt="image" src="https://github.com/user-attachments/assets/ae5fa283-37d6-4b77-8088-872fd62f7e82" />

After recovery, multiple verification checks are performed to confirm successful restoration. Row counts are compared with the original data, member records and issued book records are validated, book inventory values are checked, and aggregate calculations such as total fines are verified. These validation steps ensure that the recovered database matches the original dataset and maintains complete data integrity.

<img width="252" height="96" alt="image" src="https://github.com/user-attachments/assets/2a234562-07ff-45ab-8505-691a570bf8f5" />
<img width="358" height="141" alt="image" src="https://github.com/user-attachments/assets/d1661f8a-0084-478c-9a7c-649fcbfad7a3" />
<img width="351" height="150" alt="image" src="https://github.com/user-attachments/assets/32db31a1-a28d-4402-b4ad-6737474d2635" />
<img width="399" height="148" alt="image" src="https://github.com/user-attachments/assets/af5cf252-7c2b-4430-a827-0ca616c32eb8" />
<img width="130" height="54" alt="image" src="https://github.com/user-attachments/assets/0627542a-2fa4-4a3e-a429-ab1aeb88fc54" />


A dedicated `Backup_Log` table is used to record backup and recovery activities, providing an audit trail of operations performed on the database. This helps improve accountability and monitoring of backup processes.

<img width="748" height="137" alt="image" src="https://github.com/user-attachments/assets/f9cc4e41-3dc9-4749-b355-7b5311efd5c8" />

Overall, this project provides practical experience in implementing backup strategies, simulating database failures, restoring lost data, and validating recovery results. It highlights the critical role of backup and recovery mechanisms in database administration and demonstrates how organizations can protect valuable information against unexpected data loss while ensuring system reliability and continuity.
