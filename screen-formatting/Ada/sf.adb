with Ada.Text_IO.Unbounded_IO;
use Ada.Text_IO.Unbounded_IO;
with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
use Ada.Strings.Unbounded;
with Ada.Command_Line;
use Ada.Command_Line;

procedure sf is

	fileName : String := Argument(1);
	In_File : Ada.Text_IO.File_Type;

--Using unbounded strings because they make life so much more easier
	longString : Ada.Strings.unbounded.Unbounded_String;
	savedLine : Ada.Strings.unbounded.Unbounded_String;
	savedWord : Ada.Strings.unbounded.Unbounded_String;
	largestLine : Ada.Strings.unbounded.Unbounded_String;
	smallestLine : Ada.Strings.unbounded.Unbounded_String;

	numCheck: Integer :=0;
	prevSpace: Integer :=0;
	charLimit: Integer :=0;
	lineNum: Integer :=0;	

	largestLineNum: Integer :=0;
	largestWordCount: Integer :=0;

	smallestLineNum: Integer :=0;
	smallestWordCount : Integer :=100;
	
	wordCount: Integer :=0;


begin

	Ada.Text_IO.New_Line;
	Ada.Text_IO.Open (File => In_File, Mode => Ada.Text_IO.In_File, Name => fileName);	
	
--Read in the cla, concatenate each character to a long string, and eliminate all newline characters
	while not Ada.Text_IO.End_Of_File(In_File) loop

		Ada.Strings.Unbounded.Append(Source => longString,New_Item => Ada.Text_IO.Get_Line(File => In_File));
		Ada.Strings.Unbounded.Append(Source => longString,New_Item => " ");

	end loop;

	lineNum := lineNum +1;
	Ada.Text_IO.Put(Item => " " & Integer'Image (lineNum)) ;
	Ada.Text_IO.Put("      ");

--This next loop goes throught the whole long string to: eliminate all numbers, limit each line to 60 chars,
--and find the shortest and longest strings
--
	for i in 1..Length(longString) loop

		--determine if current char is a number

		if element(longString,i) = '1' then
			numCheck :=1;
		elsif element(longString,i) = '2' then
			numCheck :=1;
		elsif element(longString,i) = '3' then
			numCheck :=1;
		elsif element(longString,i) = '4' then
			numCheck :=1;
		elsif element(longString,i) = '5' then
			numCheck :=1;
		elsif element(longString,i) = '6' then
			numCheck :=1;
		elsif element(longString,i) = '7' then
			numCheck :=1;
		elsif element(longString,i) = '8' then
			numCheck :=1;
		elsif element(longString,i) = '9' then
			numCheck :=1;
		elsif element(longString,i) = '0' then
			numCheck :=1;
		end if;
		
		if numCheck = 1 then
			numCheck :=0;

--prevSpace helps keep track of double,triple, etc spaces
--If the current and previous character are both spaces then the current space is ignored

		elsif prevSpace = 1 and element(longString,i) = ' ' then
			prevSpace :=1;

		else
			charLimit := charLimit + 1;

--savedWord builds words from each char input and once you reach a space then the word created 
--with savedWord is concatenated to the long string

			if charLimit > 61 then

				Ada.Text_IO.New_Line;
				lineNum := lineNum +1;
				Ada.Text_IO.Put(Item => " " & Integer'Image (lineNum)) ;
				Ada.Text_IO.Put("      ");
				Ada.Strings.Unbounded.Append(Source => savedWord,New_Item => element(longString,i));
				charLimit := Length(savedWord);
				

				if wordCount < smallestWordCount then

					delete(smallestLine,1,Length(smallestLine));
					smallestLineNum := lineNum;
					smallestWordCount := wordCount;
					Ada.Strings.Unbounded.Append(Source => smallestLine, New_Item => savedLine);
					
				end if;

				if wordCount > largestWordCount then

					delete(largestLine,1,Length(largestLine));
					largestLineNum := lineNum;
					largestWordCount := wordCount;
					Ada.Strings.Unbounded.Append(Source => largestLine, New_Item => savedLine);
			
				end if;

				delete(savedLine,1,Length(savedLine));
				wordCount := 0;

			else
				if element(longString,i) = ' ' then
			
					Ada.Strings.Unbounded.Append(Source => savedWord, New_Item => element(longString,i));
					Ada.Strings.Unbounded.Append(Source => savedLine, New_Item => element(longString,i));

					put(savedWord & "");
					delete(savedWord,1,Length(savedWord));
			 		
					prevSpace:=1;
					wordCount := wordCount +1;

				else
					Ada.Strings.Unbounded.Append(Source => savedWord,New_Item => element(longString,i));
					Ada.Strings.Unbounded.Append(Source => savedLine, New_Item => element(longString,i));
					prevSpace :=0;


				end if;

			end if;

		end if;
	end loop;


	put(savedWord & "");

--This is specifically for the last line of the textfile
--Just like the loop, the final line is checked for the longest and shortest lines
--and their line number

	if wordCount > largestWordCount then

		delete(largestLine,1,Length(largestLine));
		largestLineNum := lineNum;
		largestWordCount := wordCount;
		Ada.Strings.Unbounded.Append(Source => largestLine, New_Item => savedLine);
	end if;


	if wordCount < smallestWordCount then

		delete(smallestLine,1,Length(smallestLine));
		smallestLineNum := lineNum;
		smallestWordCount := wordCount;
		Ada.Strings.Unbounded.Append(Source => smallestLine, New_Item => savedWord);
	end if;

	Ada.Text_IO.New_Line;

--Print out the longest and shortest lines

	Put_Line("The Longest Line was:");
	Ada.Text_IO.Put(Item => " " & Integer'Image (largestLineNum));
	Put("      ");
	put(largestLine & "");
	Ada.Text_IO.New_Line;

	Put_Line("The Smallest Line was:");
	Ada.Text_IO.Put(Item => " " & Integer'Image (smallestLineNum));
	Put("      ");
	put(smallestLine & "");
	Ada.Text_IO.New_Line;


end sf;


