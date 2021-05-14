       IDENTIFICATION DIVISION.
       PROGRAM-ID. sf.
       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
     
      * Read in command line argument
       SELECT Cla ASSIGN TO filename
               ORGANIZATION IS LINE SEQUENTIAL.
       
       DATA DIVISION.
       FILE SECTION.
       FD Cla.
       01 CustomerDetails.
          02  CustomerID       PIC X(60).
      
       WORKING-STORAGE SECTION.
       01 END-OF-FILE PIC Z(1).
       01 fileName PIC X(60).

       PROCEDURE DIVISION CHAINING filename.
       Begin.
          OPEN INPUT Cla
          READ Cla
             AT END MOVE 1 TO END-OF-FILE
          END-READ
          
          IF END-OF-FILE = 1
            CLOSE Cla
          END-IF
          
          MOVE 0 TO END-OF-FILE.
          
          PERFORM UNTIL END-OF-FILE = 1
            
             DISPLAY CustomerID 
             READ Cla
                AT END MOVE 1 TO END-OF-FILE
             END-READ
          END-PERFORM
          CLOSE Cla.
       STOP RUN.
