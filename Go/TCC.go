package main

import "fmt"

func main(){

var i int = 1
var steps int = 0
var big int = 5000000000

//Create 2 arrays filled with 1s, one that holds the integer thats been through the collatz function
// the second array holds the number of steps it took for that integer to reach 1

smallestColNum := []int{1,1,1,1,1,1,1,1,1,1}
longestColSteps := []int{1,1,1,1,1,1,1,1,1,1}


	for  i  <= big {

		steps = 0
		steps = collatz(i,steps)

// First sort both arrays then check if the first position steps to see if it is smaller than the current steps for a i
// if so then change both array's position 0 numbers

			sort(smallestColNum,longestColSteps)

			if longestColSteps[0] < steps {
	
				smallestColNum[0] = i
				longestColSteps[0] = steps
			
			}

		i = i + 1
	}

// Final sort of both arrays then print them out

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

	for mid != 1{

		if  (mid % 2 == 0) {
			mid = (mid/2)
		} else {
			mid = (mid *3) +1
		}

		steps = steps + 1

	}

	return steps
}

