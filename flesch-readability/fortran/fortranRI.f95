program fortranRI

character(:), allocatable  :: claString
character(len=50) :: cla
integer :: counter, wordCount, sentenceCount, syllableCount, easyWordCount,hardWordCount
integer :: fileSize,check,tracker, wordSize, percentHard
real :: a, b, indexSum
character (LEN=1) :: input
character (LEN=1) :: prevChar
character (LEN=20):: WTCompare



interface

subroutine wordCompare(compareWord, EWCount)
character, dimension (:), allocatable :: string, long_string, comparison
integer :: counter, i, j, EWCount
character(*), parameter   :: upp = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
character(*), parameter   :: low = 'abcdefghijklmnopqrstuvwxyz'
character(:), allocatable  :: compareWord
end subroutine wordCompare

end interface

!Get the command line argument file path
call get_command_argument(1, cla )

inquire(file = cla, size = fileSize)

open(unit=5,status="old",access="direct",form="unformatted",recl=1,&
        file= cla)

check=0
counter=1
indexSum=0
a=0
b=0
easyWordCount=0

110 read (5,rec=counter,err=210) input

!Check if the current character that input is at is either a space or \n(char(10)
!If it is one or the other than run on the wordCompare subroutine on the fully
!constructed word

        if( input .eq. " " .OR. input .eq. char(10)) then
                wordCount = wordCount +1
                call wordCompare(claString, easyWordCount)

!Clear claString so you can create the next word
                claString=""
        endif

!Figure out if input is a ending puncuation, if it is then increment the
!sentence count

        if( input .eq. '.' .OR. input .eq. '!' .OR. input .eq. '?') then
                sentenceCount = sentenceCount +1
        endif

!Syllable Counter
!Using the previous character and the current character determine if the
!syllable counter should be incremented or decremented

        if( input .eq. 'a' .OR. input .eq. 'e' .OR. input .eq. 'i' .OR. input .eq. 'o' .OR. input .eq. 'u' .OR. input .eq. 'y')then
                syllableCount= syllableCount +1
                check=1            
            
        else if (input .eq. 'A' .OR. input .eq. 'E' .OR. input .eq. 'I' .OR. input .eq. 'O')then
                syllableCount = syllableCount +1
                check=1

        else if (input .eq. 'U' .OR. input .eq. 'Y' ) then
                syllableCount = syllableCount +1
                 check=1

        endif

!check is used to determine if since the current character is a vowel then what
!was the previous character. If the previous character was also a vowel then
!decrement the syllable counter

        if(check .eq. 1)then    

                        if( prevChar .eq. 'a' .OR. prevChar .eq. 'e' .OR. prevChar .eq. 'i' .OR. prevChar .eq. 'o')then
                                syllableCount = syllableCount-1
                                check=0

                        else if(prevChar .eq. 'u' .OR. prevChar .eq. 'y'.OR. prevChar .eq. 'A' .OR. prevChar .eq. 'E')then
                                syllableCount = syllableCount-1
                                check=0

                        else if(prevChar .eq. 'I' .OR. prevChar .eq. 'O' .OR. prevChar .eq. 'U' .OR. prevChar .eq. 'Y') then
                                syllableCount = syllableCount-1
                                check=0

                        endif
          endif

!If e was the last letter in the word, decrement syllable counter

        if(input .eq. " " .OR. input .eq. '.' .OR. input .eq. '!' .OR. input .eq. '?' .OR. input .eq. char(10)) then
                if(prevChar .eq. "e") then
                        syllableCount = syllableCount -1
                endif
        endif

!Concatenate input on to claString, and keep doing so until a full word is
!created
        claString = trim(adjustl(claString))//input
        prevChar = input
        check=0

        counter=counter+1
        goto 110
        210 continue
        counter=counter-1

close(5)

!Calculate number of hard words

hardWordCount = wordCount - easyWordCount

!FleschIndex

a =(syllableCount/ wordCount)

b = wordCount / sentenceCount

indexSum = NINT(206.835 -(a*84.6)-(b*1.015))

print*,"The Flesch Index sum is: ", indexSum

!Flesch-Kincaid

a = syllableCount/ wordCount

b = wordCount/ sentenceCount

indexSum = ( (a*11.8) + (b*0.39) - 15.59)
indexSum = NINT(indexSum*10)/10

print*, "The Flesch-Kincaid index sum is: ", indexSum

!DaleChall

a = hardWordCount / wordCount

b = wordCount / sentenceCount

percentHard = (a *100)

if( percentHard > 5) then
        indexSum = (0.1579 + (b*0.0496) + 3.6365)
else
        indexSum = (0.1579 + (b*0.0496))
end if

indexSum =NINT(indexSum*10)/10

print*, "The Dale-Chall score is:", indexSum

if( score <= 4.9)then
        print*, "Based on the Dale-Chall Readability score this is easily understandable by 4th graders(and possibly lower grades)."

else if( score >= 5.0 .AND. score <= 5.9)then
        print*, "Based on the Dale-Chall Readability score this is easily understandable by 5th or 6th graders."


else if( score >= 6.0 .AND. score <= 6.9)then
        print*, "Based on the Dale-Chall Readablitiy score this is easily understandable by 7th or 8th graders."


else if( score >= 7.0 .AND. score <= 7.9)then
        print*, "Based on the Dale-Chall Readablitiy score this is easily understandable by 8th or 9th graders."


else if( score >= 8.0 .AND. score <= 8.9)then
        print*, "Based on the Dale-Chall Readablitiy score this is easily understandable by 11th or 12th graders."

else if( score >= 9.0 .AND. score <= 9.9)then
        print*, "Based on the Dale-Chall Readablitiy score this is easily understandable by college students."

end if
end program fortranRI

subroutine wordCompare(compareWord, EWCount)
!inquire (file="/pub/pounds/CSC330/dalechall/wordlist1995.txt", size=fileSize)
integer :: counter, i, j, EWCount
character(*), parameter   :: upp = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
character(*), parameter   :: low = 'abcdefghijklmnopqrstuvwxyz'
character, dimension(:), allocatable :: string
character (LEN=1) :: input
character(:), allocatable  :: long_string, comparison, compareWord
real, dimension(15) :: EasyWords


open(unit=10,status="old",access="direct",form="unformatted",recl=1,&
        file="/pub/pounds/CSC330/dalechall/wordlist1995.txt")

comparison = compareWord
long_string = ""

counter=1

100 read (10,rec=counter,err=200) input
       
        if( input .eq. " " .OR. input .eq. char(10)) then
            
!Full capitalize the comparison word and the current easy word, and see if they
!are equal to each other. If they are increment the easy word counter and then
!return to the main program

                do i = 1, LEN_TRIM(comparison)             
                       j = INDEX(low, comparison(i:i))        
                       if (j > 0) comparison(i:i) = upp(j:j)  
                end do

                do i = 1, LEN_TRIM(long_string)             
                       j = INDEX(low, long_string(i:i))        
                       if (j > 0) long_string(i:i) = upp(j:j)  

                end do


                if( trim(adjustl(comparison)) ==  trim(adjustl(long_string))) then
                        EWCount= EWCount+1

                        close(10)
                        RETURN
                endif
                        
!If the words do not equal each other empty the easy word, and start building
!the next one

                long_string=""
        else
                long_string = trim(adjustl(long_string))//input
        endif
        
        counter=counter+1
        goto 100
        200 continue
        counter=counter-1

close(10)

end subroutine wordCompare

