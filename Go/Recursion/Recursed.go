package main

import "fmt"

func main(){

var i int = 1
var steps int = 0
var big int = 5000000000


// Fill both arrays with intial all 1s, one array holds the number and the other holds that numbers # of steps

smallestColNum := []int{1,1,1,1,1,1,1,1,1,1}
longestColSteps := []int{1,1,1,1,1,1,1,1,1,1}


	for  i  <= big {
		
		steps =0
		steps = collatz(i,steps)

// Sort then compare i and its # of steps with the first position of the current stored number

			sort(smallestColNum,longestColSteps)

			if longestColSteps[0] < steps {
	
				smallestColNum[0] = i
				longestColSteps[0] = steps
			
			}
		
		i = i + 1
	}

// Final sort and then print out both arrays

	sort(smallestColNum,longestColSteps)
	fmt.Println("Shortest Collatz numbers with the longest steps")

	for a := 0; a < 10; a++{
	
		fmt.Println("")
		fmt.Println("Number: ",smallestColNum[a],"   Number of Steps: ", longestColSteps[a])
		fmt.Println("")

	}

}

func sort(Narray []int, Sarray []int){

	var n = len(Narray)
	sorted := false

	for !sorted {

		swapped := false

		for b := 0; b < n-1; b++{
		
			if Narray[b] > Narray[b+1]{
			
				Narray[b+1], Narray[b] = Narray[b], Narray[b+1]
				Sarray[b+1], Sarray[b] = Sarray[b], Sarray[b+1]
				swapped = true
			
			}
		
		}
		if !swapped {


			sorted = true

		}
		n = n-1
	}
}




func collatz(mid, steps int) int {
	
	if (mid == 1){
		return steps

	} else if (mid%2 == 0) {
		steps = steps + 1
		steps = collatz(mid/2,steps)
	
	} else {
		steps = steps + 1
		steps = collatz((mid*3)+1,steps)
	}
		return steps
}

