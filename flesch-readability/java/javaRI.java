import java.lang.Math;
import java.io.*;
import java.util.Scanner;
import java.util.Vector;

public class javaRI{

	static void FleschIndex(double syllables, double words, double sentences){
	
		double indexScore = 0;
		double a = syllables/words;
		double b = words/sentences;

		indexScore =206.835 - (a * 84) - ( b * 1.015);
		indexScore = Math.round(indexScore);
		System.out.println("The Flesch Index score is " + indexScore);

	}	

	static void FleschKincaidIndex(double syllables, double words, double sentences){
	
		double indexScore = 0;
                double a = syllables/words;
                double b = words/sentences;

		indexScore =  ((a* 11.8) + (b * 0.39) - 15.59);
		indexScore = Math.round(indexScore*10)/10;
                System.out.println("The Flesch-Kincaid Index score is " + indexScore);
	}
	

	static void DaleChallScore(double words, double difficultWords, double sentences){
	
		double difficultWordPercentage = 0;
		double score = 0;
		double a = difficultWords/words;
		double b = words/sentences;

		difficultWordPercentage = (a * 100);
		score = 0.1579 + (b * 0.0496);

//If the current calculated score is greater than 5.0, then 3.6365 must be added to the calculations
		if( difficultWordPercentage > 5)
			score += 3.6365;

		score = Math.round(score*10)/10;
		System.out.println("The Dale-Chall score is: " + score);

//These if statements determine the readability grade level for the score previously calculated		
		if( score <= 4.9)
			System.out.println("Based on the Dale-Chall Readability score this is easily understandable by 4th graders (and possibly lower grades).");
	
		else if( score >= 5.0 && score <= 5.9)	
			System.out.println("Based on the Dale-Chall Readability score this is easily understandable by 5th or 6th graders.");
	
		else if( score >= 6.0 && score <= 6.9)
			System.out.println("Based on the Dale-Chall Readablitiy score this is easily understandable by 7th or 8th graders.");
	
		else if( score >= 7.0 && score <= 7.9)
			System.out.println("Based on the Dale-Chall Readablitiy score this is easily understandable by 8th or 9th graders.");

		else if( score >= 8.0 && score <= 8.9)
			System.out.println("Based on the Dale-Chall Readablitiy score this is easily understandable by 11th or 12th graders.");

		else if( score >= 9.0 && score <= 9.9)
			System.out.println("Based on the Dale-Chall Readablitiy score this is easily understandable by college students.");
	
}

	static int syllableCounter(String word){

		int wordLength = word.length();
		int vowelCount = 0;
		char lastLetter = word.charAt(wordLength - 1);
		char nextLetter = ' ';

//This loops through each letter in the word provided
	        for( int i=0;i<wordLength;i++)
      	 	{
			char letter = word.charAt(i);
			if( wordLength- i != 1)
				nextLetter = word.charAt(i+1);

//The first letter is checked to see if its a vowel
			if ((letter == 'a') || (letter == 'e') || (letter == 'i') || (letter == 'o') || (letter == 'u') || (letter == 'y') || (letter == 'A') || (letter == 'E') || (letter == 'I') || (letter == 'O') || (letter == 'U') || (letter == 'Y') )
	 		{
 				vowelCount += 1;
                                
//The letter after the current letter is checked. If it is a vowel then the 2 vowels are not counted as 2 syllables
//The if statement here is used as a stringIndexOutOfBounds catcher, so that we dont check the next space past the last letter
			if(wordLength - i != 1)
			{
	 			if ((nextLetter == 'a') || (nextLetter == 'e') || (nextLetter == 'i') || (nextLetter == 'o') || (nextLetter == 'u') || (nextLetter == 'y') || (nextLetter == 'A') || (nextLetter == 'E') || (nextLetter == 'I') || (nextLetter == 'O') || (nextLetter == 'U') || (nextLetter == 'Y') )
 				{
 					vowelCount -=1;
 				}
			}

        		}
            	}	
//If the word ends in a 'e' then it is not counted as a syllable
		if(lastLetter == 'e')
 		{
 			vowelCount -=1;
 		}

        	return vowelCount;
	}



public static void main(String[] args) throws FileNotFoundException  {

	String currentWord;
	char period = '.';
	int wordCount=0;
	int numberCount=0;
	int syllableCount=0;
	int sentenceCount=0;
	int difficultWordCount =0;
	int easyWordCount =0;
	Scanner wordListScanner = null;
	Scanner translatedText = null;
	Vector<String> easyWords = new Vector<String>();

//The try catch loop looks for the file supplied in the command line argument. If there is no file supplied then the catch part 
//catches that exception and tells the user that a file was not supplied correctly
	try
	{
		translatedText = new Scanner(new File(args[0]));
	 	wordListScanner = new Scanner(new File("/pub/pounds/CSC330/dalechall/wordlist1995.txt"));
	}
	catch (FileNotFoundException e)
	{
		System.out.println("A text file must be supplied with this command.");
		throw e;
	}

//2 scanners are used to read in the easy words list test file and a vector is filled with each individual word
	while(wordListScanner.hasNextLine())
	{
		Scanner m = new Scanner(wordListScanner.nextLine());
		while(m.hasNext())
		{
			easyWords.addElement(m.next());
		}
	}

//The same 2 scanner set up is used again but instead the word is tested to see if it is a number and if it matches a easy word
//Sentence count, word count, and easy word count, are all checked here
	while(translatedText.hasNextLine())
	{
		Scanner n = new Scanner(translatedText.nextLine());
		while(n.hasNext())
		{
			wordCount++;
			currentWord = n.next();		

if( currentWord == "1"|| currentWord == "2" || currentWord == "3" || currentWord == "4" || currentWord == "5" || currentWord == "6" || currentWord == "7" || currentWord == "8" || currentWord == "9" || currentWord == "0")
			{
				wordCount--;
			}
					
			syllableCount += syllableCounter(currentWord);		
			
			if(currentWord.charAt(currentWord.length() -1) == '.')
			{
				sentenceCount++;
			}

			if(easyWords.contains(currentWord))
			{
				easyWordCount++;				
			}	
		}
	}

//The methods to calculate each index are all ran and display the results to the user
	difficultWordCount = wordCount - easyWordCount;

	FleschIndex( syllableCount, wordCount, sentenceCount);
	FleschKincaidIndex( syllableCount, wordCount, sentenceCount);
	DaleChallScore( wordCount, difficultWordCount, sentenceCount);
	System.out.println();
}
}

