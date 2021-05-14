#!/usr/bin/perl
use strict;
use warnings;


## Grab the name of the file from the command line, exit if no name given
my $translatedFile = $ARGV[0] or die "Need to get file name on the command line\n";

my $easyWords = "/pub/pounds/CSC330/dalechall/wordlist1995.txt";

## Use both filenames
open(DATA, "<$translatedFile") or die "Couldn't open file $translatedFile, $!"; 

open(WORDS,"<$easyWords") or die "Couldnt open file $easyWords, $!";

## Transfer the files into data
my @Translated_Array = <DATA>; 

my @EasyWords_Array= <WORDS>;

my @EasyWordsToken_Array = ();

## Some early variable creation
my $easyWordCount =0;

my $wordCount =0;

my $sentenceCount =0;

my $syllableCount =0;

## Each word is then seperated by spaces and the list of easy words is pushed into an array
foreach my $line (@EasyWords_Array) {
	push @EasyWordsToken_Array, split(' ', $line);

	#use Hash to for tokens then use exist function to check them
}  
             
## The same is done for the actual command line file, except now each word is checked for various conditions
foreach my $line (@Translated_Array) {
	my @tokens = split(' ', $line);

## The first condition is to see if the command line file word matches a word in the easy word arrray
	foreach my $token (@tokens) {
		foreach my $easyWord (@EasyWordsToken_Array){
			if ($token eq  $easyWord)
			{
				++$easyWordCount;
			}

	}
## No matter what the word count is increased
		$wordCount++;	

## A sentence is determined if a word includes a . ! or ?
		if ($token  =~ /[.!?]+/g)
		{
			$sentenceCount++;
		}

		my $previousChar = 'q';

## Now break the word further down into just a single character

		foreach my $char (split //, $token) {

## If the character is a number comma or period then nothing happens

			if( $char =~ /^[0-9,.]+$/ ) 
			{

			}

			else
			{
## First vowel check
				if( $char =~ /^[a,e,i,o,u,y,A,E,I,O,U,Y]+$/)
				{
					$syllableCount++;

## This preivousChar check, checks to see if the previous charcter was vowel

					if($previousChar =~ /^[a,e,i,o,u,y,A,E,I,O,U,Y]+$/)
					{
						$syllableCount--;
					}
				}
## The current character is then set as the previousChar and the loop runs again

					$previousChar = $char;			
			}
		}
## If the last char in a word is e, then decrease the syllableCount

		if( $previousChar eq 'e')
		{
			$syllableCount--;
		}
	}
}

## How many actual difficult words are in this text
my $difficultWordCount = $wordCount - $easyWordCount;

##FleschIndex

my $indexScore = 0;
my $a = $syllableCount/$wordCount;
my $b = $wordCount/$sentenceCount;
   
$indexScore =206.835 - ($a * 84) - ( $b * 1.015);
$indexScore = sprintf("%.0f", $indexScore);

print("The Flesch Index score is: $indexScore\n");
	    
	
##FleschKincaidIndex

$indexScore = 0;
$a = $syllableCount/$wordCount;
$b = $wordCount/$sentenceCount;
     
$indexScore = ($a* 11.8) + ($b * 0.39) - 15.59;
$indexScore = sprintf("%.1f", $indexScore);
print("The Flesch-Kincaid Index score is: $indexScore\n");



##DaleChall

my $difficultWordPercentage = 0;
my $score = 0;
$a = $difficultWordCount/$wordCount;
$b = $wordCount/$sentenceCount;

$difficultWordPercentage = ($a * 100);
$score = 0.1579 + ($b * 0.0496);

##If the current calculated score is greater than 5.0, then 3.6365 must be added to the calculations
if( $difficultWordPercentage > 5)
{
	$score += 3.6365;
}

$score = sprintf("%.1f", $score);

print("The Dale-Chall score is: $score \n");

##These if statements determine the readability grade level for the score previously calculated		
if( $score <= 4.9)
{
	print("Based on the Dale-Chall Readability score this is easily understandable by 4th graders (and possibly lower grades).\n");
}	
elsif( $score >= 5.0 && $score <= 5.9)	
{
	print("Based on the Dale-Chall Readability score this is easily understandable by 5th or 6th graders.\n");
}	
elsif( $score >= 6.0 && $score <= 6.9)
{
	print("Based on the Dale-Chall Readablitiy score this is easily understandable by 7th or 8th graders.\n");
}	
elsif( $score >= 7.0 && $score <= 7.9)
{
	print("Based on the Dale-Chall Readablitiy score this is easily understandable by 8th or 9th graders.\n");
}
elsif( $score >= 8.0 && $score <= 8.9)
{
	print("Based on the Dale-Chall Readablitiy score this is easily understandable by 11th or 12th graders.\n");
}
elsif( $score >= 9.0 && $score <= 9.9)
{
	print("Based on the Dale-Chall Readablitiy score this is easily understandable by college students.\n");
}	
##Helps clean up bash script
print("\n")





                     
