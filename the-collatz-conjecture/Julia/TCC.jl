#!/usr/bin/julia

#Simple Bubblesort

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


function collatz(mid::Int64,steps::Int64)

	while mid != 1

		if mid % 2 == 0
			mid = mid÷2
		else
			mid = (mid*3) + 1
		end
		
		steps = steps + 1
	end

	return steps
end

function main()
	i = 1
	track = 0
	steps = 0
	big = 5000000000
	

#Initial 2 arrays filled will all ones

	smallestColNum = [1,1,1,1,1,1,1,1,1,1]
	longestColSteps = [1,1,1,1,1,1,1,1,1,1]


#While the current number is less than 5,000,000,000 run through this loop

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

#Sort one final time and then print out results

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
