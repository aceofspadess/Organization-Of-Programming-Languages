program Sf
character(:),allocatable :: longestLine,shortestLine
character(LEN=75) :: line,savedWord
character(LEN=50):: cla
character(LEN=1) :: input
integer :: counter, fileSize, lineNumber, numberCheck, charLimit,wordCount
integer :: currentLongestSize, currentShortestSize, longLineNum, shortLineNum

interface


end interface

!Get command line argument
call get_command_argument(1,cla)
inquire(file = cla, size = fileSize)

!open the cla file
open(unit=5,status="old",access="direct",form="unformatted",recl=1,&
        file= cla)

counter=1
lineNumber=0
numberCheck=0
charLimit=0

line=""

shortestLine=""
shortLineNum=0
currentShortestSize=10000

longestLine=""
longLineNum=0
currentLongestSize=0

savedWord=""
input=""
wordCount=0

print*,char(10)



100 read (5,rec=counter,err=200) input

!increment char limit count
       charLimit = charLimit+1

!if the current input is a number then set numberCheck to true and later on
!decrement the char limit count

        if( input .eq. "0" .OR. input .eq. "1" .OR. input .eq."2" .OR. input .eq. "3")then
                numberCheck =1

        else if(input .eq. "4" .OR. input .eq. "5" .OR. input .eq. "6")then
                numberCheck =1

        else if(input .eq. "7" .OR. input .eq. "8" .OR. input .eq. "9")then
                numberCheck =1

        endif

!If the current input is not a number and you havent reached the char limit then
!use savedWord to form words with the char input and everytime you reach a space
!char then concatenate savedWord onto line
        if( numberCheck .NE. 1 .AND. charLimit .LT. 61)then

                if( input .NE. ' ' .AND. input .NE. char(10) .AND. input .NE. '')then
                        
                        savedWord= TRIM(savedWord)//input
                  
                else
                        wordCount = wordCount+1
                        line= TRIM(line)//" "//savedWord         
                        savedWord=""

                endif

!If you reached the char limit then print the current line and check for longest
!and shortest lines
!Use savedWord for the next line

        elseif(numberCheck .NE. 1 .AND. charLimit .GT. 60)then

                lineNumber=lineNumber+1

                 if( wordCount .GT. currentLongestSize)then
                        longestLine=line
                        longLineNum=lineNumber
                        currentLongestSize= wordCount
                endif


                 if( wordCount .LT. currentShortestSize)then
                        shortestLine=line
                        shortLineNum=lineNumber
                        currentShortestSize= wordCount
                endif
        
                wordCount=0
                print*,lineNumber,line
                line=""
                savedWord = TRIM(savedWord)//input
                charLimit= LEN(TRIM(ADJUSTL(savedWord)))

        endif
         
        if(numberCheck .EQ. 1)then
                numberCheck=0
                charLimit= charLimit-1
        endif

        counter=counter+1
        goto 100
        200 continue
        counter=counter-1

close(5)

!Last line specific longest and shortest line checking and printing
lineNumber=lineNumber+1
print*,lineNumber,line


if( wordCount .GT. currentLongestSize)then
        longestLine=line
        longLineNum=lineNumber
        currentLongestSize= wordCount
endif


if( wordCount .LT. currentShortestSize)then
        shortestLine=line
        shortLineNum=lineNumber
        currentShortestSize= wordCount
endif

!Print the longest and shortest lines, along with their line number

print*,char(10)
print*,"Long ",longLineNum,longestLine

print*,char(10)
print*,"Short",shortLineNum,shortestLine

print*,char(10)
end program Sf
