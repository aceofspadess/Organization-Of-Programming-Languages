#!/usr/bin/python3
import sys

class mainMethods:

	def SyllableCounter(word):    #THIS IS THE PROBLEM MAYBE IDK
		wordLength = len(word);
		vowelCount = 0;
		lastLetter = word[-1];
		i = 0;

#This loops through each letter in the word provided
		while i < wordLength:

			letter = word[i];
			if wordLength -i != 1:
				nextLetter = word[i+1];
			else:
				nextLetter = '';
#The first letter is checked to see if its a vowel
			if letter == 'a' or letter == 'e' or letter == 'i' or letter == 'o' or letter == 'u' or letter == 'y' or letter == 'A' or letter == 'E' or letter == 'I' or letter == 'O' or letter == 'U' or letter == 'Y':

				vowelCount += 1;
				
#The letter after the current letter is checked. If it is a vowel then the 2 vowels are not counted as 2 syllables
#The if statement here is used as a stringIndexOutOfBounds catcher, so that we dont check the next space past the last letter

				if nextLetter == 'a' or nextLetter == 'e' or nextLetter == 'i' or nextLetter == 'o' or nextLetter == 'u' or nextLetter == 'y' or nextLetter == 'A' or nextLetter == 'E' or nextLetter == 'I' or nextLetter == 'O' or nextLetter == 'U' or nextLetter == 'Y':

					vowelCount -=1;
					


			i += 1;

#If the word ends in a 'e' then it is not counted as a syllable
		if lastLetter == 'e':
			vowelCount -=1;

		return vowelCount


	def FleschIndex(syllables, words,sentences):

		indexScore = 0;
		a = syllables/words;
		b = words/sentences;

		indexScore = 206.835 - (a * 84) - ( b * 1.015);
		indexScore = str(round(indexScore));
		print("The Flesch Index score is ", indexScore);



	def FleschKincaidIndex(syllables,words,sentences):

		indexScore = 0;
		a = syllables/words;
		b = words/sentences;

		indexScore = str(round( (a* 11.8) + (b * 0.39) - 15.59,1));
		print("The Flesch-Kincaid Index score is ", indexScore);



	def DaleChallScore(words, difficultWords, sentences):

		difficultWordPercentage = 0;
		score = 0;
		intermediateScore=0;
		a = difficultWords/words;
		b = words/sentences;
		difficultWordPercentage = (a * 100);
		score = 0.1579 + (b * 0.0496);

#If the current calculated score is greater than 5.0, then 3.6365 must be added to the calculations
		if difficultWordPercentage > 5:
			score += 3.6365;

		intermediateScore = str(round(score,1));
		print("The Dale-Chall score is: ",intermediateScore);
#These if statements determine the readability grade level for the score previously calculated		
		if score <= 4.9:
			print("Based on the Dale-Chall Readability score this is easily understandable by 4th graders (and possibly lower grades). \n" );

		elif score >= 5.0 and score <= 5.9:
			print("Based on the Dale-Chall Readability score this is easily understandable by 5th or 6th graders. \n");

		elif score >= 6.0 and score <= 6.9:
			print("Based on the Dale-Chall Readablitiy score this is easily understandable by 7th or 8th graders. \n");

		elif score >= 7.0 and score <= 7.9:
			print("Based on the Dale-Chall Readablitiy score this is easily understandable by 8th or 9th graders. \n");



	wordCount =0;
	sentenceCount =0;
	easyWordCount =0;
	syllableCount =0;
	easyWordList =[];
	hardWordCount =0;
	compareCount=0;

	with open('/pub/pounds/CSC330/dalechall/wordlist1995.txt', 'r') as easyWordsFile:
	
		for line in easyWordsFile:
			for word in line.split():
				easyWordList.append(word);
					


	with open( sys.argv[1], 'r') as translatedFile:

		for line in translatedFile:
			for word in line.split():
				wordCount +=1;

				compareCount = easyWordList.count(word)		
				if compareCount > 0:
					easyWordCount +=1;

				compareCount=0;
				
				if word[-1] == '.':	
					sentenceCount +=1;			
			

				if word == "1" or word == "2" or word == "3" or word == "4" or word == "5" or word == "6" or word == "7" or word == "8" or word == "9" or word == "0":
					wordCount -=1;

				syllableCount += SyllableCounter(word);


	translatedFile.close()
	easyWordsFile.close()

	hardWordCount = wordCount - easyWordCount;

	FleschIndex(syllableCount, wordCount ,sentenceCount);
	FleschKincaidIndex(syllableCount,wordCount,sentenceCount)
	DaleChallScore(wordCount, hardWordCount, sentenceCount)


