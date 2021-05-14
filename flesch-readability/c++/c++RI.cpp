// Cevontae Miller 
// CSC 330
// Assignment 1 Readability Index

#include <iostream>
#include <fstream>
#include <stdio.h>
#include <math.h>
#include <vector>
#include <cmath>


using namespace std;


int syllableCounter(string word)
{
	int wordLength = word.length();
	int vowelCount = 0;

//This loops through each letter in the word provided
	for( int i=0;i<wordLength;i++)
	{
//The first letter is checked to see if its a vowel	
	if ((word[i] == 'a') || (word[i] == 'e') || (word[i] == 'i') || (word[i] == 'o') || (word[i] == 'u') || (word[i] == 'y')|| (word[i] == 'A') || (word[i] == 'E') || (word[i] == 'I') || (word[i] == 'O') || (word[i] == 'U') || (word[i] == 'Y') )
		{
			vowelCount += 1;		

//The letter after the current letter is checked. If it is a vowel then the 2 vowels are not counted as 2 syllables	

if ((word[i+1] == 'a') || (word[i+1] == 'e') || (word[i+1] == 'i') || (word[i+1] == 'o') || (word[i+1] == 'u') || (word[i+1] == 'y'))
			{
				vowelCount -=1;
			}
		}	
	}
//If the word ends in a 'e' then it is not counted as a syllable

	if(word[word.length() -1] == 'e')
	{
		vowelCount -=1;
	}

	return vowelCount;	

}

void FleschIndex( double syllables, double words, double sentences)
{
	double indexScore = 0;
	double a = (syllables/words);
	double b = words/sentences;

	a = a*84.6;
	b = b*1.015;

	indexScore = round(206.835 - a - b);

	cout  <<"The Flesch Index score is " << indexScore << endl;	 
}

void FleschKincaidIndex(double syllables, double words, double sentences)
{
	double indexScore = 0;
	double a = syllables/words;
	double b = words/sentences;
	
	indexScore = ( (a * 11.8) + (b *  0.39) - 15.59);
	indexScore = round(indexScore*10)/10;
	
	cout <<"The Flesch-Kincaid Index score is " << indexScore << endl;

}
void DaleChallScore(double words, double difficultWords, double sentences)
{
	double difficultWordPercentage = 0;
	double score = 0;
	double a = difficultWords/words;
	double b = words/sentences;

	difficultWordPercentage = (a * 100);
	score = 0.1579 + (b * 0.0496);

	if( difficultWordPercentage > 5)
	{
		score += (3.6365); 
	}

	score = round(score*10)/10;

	cout << "The Dale-Chall Score is: " << score << endl;

//These if statements determine the readability grade level for the score previously calculated
	
	if( score <= 4.9)
		cout << "Based on the Dale-Chall Readability score this is easily understandable by 4th graders (and possibly lower grades)." << endl;
	
	else if( score >= 5.0 && score <= 5.9)	
		cout << "Based on the Dale-Chall Readability score this is easily understandable by 5th or 6th graders." << endl;
	
	else if( score >= 6.0 && score <= 6.9)
		cout << "Based on the Dale-Chall Readablitiy score this is easily understandable by 7th or 8th graders." << endl;
	
	else if( score >= 7.0 && score <= 7.9)
		cout << "Based on the Dale-Chall Readablitiy score this is easily understandable by 8th or 9th graders." << endl;

	else if( score >= 8.0 && score <= 8.9)
		cout << "Based on the Dale-Chall Readablitiy score this is easily understandable by 11th or 12th graders." << endl;

	else if( score >= 9.0 && score <= 9.9)
		cout << "Based on the Dale-Chall Readablitiy score this is easily understandable by college students." << endl;

	
}

int main(int argc, char *argv[])
{
	string nextWord;
	char period = '.';
	int wordCount=0;
	int numberCount=0;
	int syllableCount=0;
	int sentenceCount=0;
	int difficultWordCount =0;
	int easyWordCount =0;
	ifstream textFile;
	ifstream wordList;


//If a file to evaluate is not given or more arguments are given, then an appropraite message is printed out

	if( argc > 2) 
	{
		cout << "To many arguments provided." << endl;
	}
	else if ( argc < 2 )
	{
		cout << "Not enough arguments supplied" << endl;	
	}
	else
	{
//The easyWords vector holds a list of all the easy words supplied by the wordlist1995 text
		vector<string> easyWords;

		wordList.open("/pub/pounds/CSC330/dalechall/wordlist1995.txt");
		while( wordList >> nextWord)
		{
			easyWords.push_back(nextWord);	
		}
//The supplied argument file is opened
		textFile.open(argv[1]);
		if(textFile.is_open())
		{
			while(textFile >> nextWord)
			{
//If the current "nextWord" is a number then it is not counted as an actual word for the final calculations			
				if( nextWord[0] == '1'|| nextWord[0] == '2' || nextWord[0] == '3' || nextWord[0] == '4' || nextWord[0] == '5' || nextWord[0] == '6' || nextWord[0] == '7'|| nextWord[0] == '8' || nextWord[0] == '9' || nextWord[0] == '0')
				{
					wordCount--;
				}
				wordCount++;

				for(int x=0; x<easyWords.size(); x++)
				{
//The current "nextWord" is checked to see if it is considered a easy word and if it is then the easyWordCount goes up	
					if( nextWord == easyWords[x])				
					{
						easyWordCount++;				
					}	
				}
//The syllableCounter method is ran for each word and the resulting amount of syllables is then added to the total			
				syllableCount += syllableCounter(nextWord);
					
				if(nextWord[nextWord.length() -1] == period)
				{
					sentenceCount++;
				}
			}
//The final 3 methods that calculate each readability are ran and in those methods the results are printed
// And the amount of hard words is also calculated and used as a parameter
//
			difficultWordCount = wordCount - easyWordCount;

			FleschIndex( syllableCount, wordCount, sentenceCount);
			FleschKincaidIndex( syllableCount, wordCount, sentenceCount);			
			DaleChallScore( wordCount, difficultWordCount, sentenceCount);				
			cout<< endl;
}
		else
			cout << "Could not open file" << endl;
	}
	textFile.close();
	return 0;
}
