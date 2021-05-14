#!/usr/bin/julia

#Bubblesort
#Sorting both number array and number of steps array at once

function bubbleSort(Narry::AbstractVector, Sarry::AbstractVector)
	numberOfSwaps = 0
	numberOfComparisons = 0
	len = length(Narry)

	for i = 1: len-1
		for j = 2: len
			numberOfComparisons +=1
			if Narry[j-1] > Narry[j]

				tmp = Narry[j-1]
				stmp = Sarry[j-1]

				Narry[j-1] = Narry[j]
				Sarry[j-1] = Sarry[j]

				Narry[j] = tmp
				Sarry[j] = stmp

				numberOfSwaps += 1
			end
		end
	end
end

#Recursive call for collatz

function collatz(mid::Int64,steps::Int64)

	if mid == 1
		return steps

	elseif mid % 2 == 0

		steps = steps + 1
		steps = collatz(mid÷2,steps)

	else
		steps = steps + 1
		steps = collatz((mid*3)+1,steps)
	end
		
	return steps
end

function main()
	i = 1
	track = 0
	steps = 0
	big = 5000000000

	smallestColNum = [1,1,1,1,1,1,1,1,1,1]
	longestColSteps = [1,1,1,1,1,1,1,1,1,1]



	while i <= big

		steps = 0 
		steps = collatz(i,steps)
	
		bubbleSort(smallestColNum,longestColSteps)
	
		if longestColSteps[1] < steps 

			smallestColNum[1] = i
			longestColSteps[1] = steps
		end
	
		i = i + 1
	end

#Bubble sort again and print results

	bubbleSort(smallestColNum,longestColSteps)

	println("The smallest numbers with the largest steps")
	println("")

	for a in 1:10
		println("Number: ", smallestColNum[a],"   Number of Steps: ", longestColSteps[a])
		println("")
	end
end


main()
exit(0)
