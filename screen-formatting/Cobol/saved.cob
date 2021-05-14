       IDENTIFICATION DIVISION.
       PROGRAM-ID. sf.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
      
       SELECT Cus ASSIGN TO "/home/miller_cm/screen-formatting/test.txt"
               ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD Cus.
       01 CustomerDetails.
          02  CustomerId       PIC X(60).
      *    02  CustomerName.
      *       03 Lastname      PIC X(15).
      *        03 Firstname     PIC X(15).
      *        03 Middlename    PIC X(20).
       WORKING-STORAGE SECTION.
       01 END-OF-FILE PIC Z(1).
      * 01 fileName PIC X(32).

       PROCEDURE DIVISION.
       Begin.
          OPEN INPUT Cus
          READ Cus
             AT END MOVE 1 TO END-OF-FILE
          END-READ
          
          IF END-OF-FILE = 1
            CLOSE Cus
          END-IF
          
          MOVE 0 TO END-OF-FILE.
          
          PERFORM UNTIL END-OF-FILE = 1
      *      DISPLAY CustomerId SPACE Lastname SPACE Firstname
            
             DISPLAY CustomerId 
             READ Cus
                AT END MOVE 1 TO END-OF-FILE
             END-READ
          END-PERFORM
          CLOSE Cus.
       STOP RUN.
