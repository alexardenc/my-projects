#  File: sumMaze.py
#  Description: Simulate a maze
#  Student's Name: Alexandria Collins
#  Student's UT EID: aac3665
#  Course Name: CS 313E 
#  Unique Number: 51470
#
#  Date Created: 11/15/17
#  Date Last Modified: 11/17/17

# define new class State to keep each new move's data as an instance
class State():
	# create the instance variables
	def __init__(self, grid, hist, row, col):
		self.grid = grid
		
		self.hist = []
		for ele in hist:
			self.hist.append(ele)
		
		self.row = row
		self.col = col
		
		for ele in hist:
			self.sum = sum(self.hist)

	# print the grid and data clearly
	def __str__(self):
		st = "   Grid:"
		for i in range(len(self.grid)):
			st += "\n      "
			for j in range(len(self.grid[0])):
				row = self.grid[i][j]
				st += "{:5}".format(str(row))
		st += "\n   history: " + str(self.hist)
		st += "\n   start point: (" + str(self.row) + ", " + str(self.col) + ")"
		st += "\n   sum so far: " + str(self.sum)

		return(st)

# define a function to see if the move is valid
def isValid(grid, row, col):
	
	# cannot move somewhere you have already been or hit a dead end
	if (row > len(grid)-1) or (col > len(grid[0])-1):
		return False
	
	elif (grid[row][col] == "X"):
		return False
	
	else:
		return True

# define the recursive function to find soultion
def solve(pos, end_row, end_col, targetValue):
	
	# if instance is the end position and sum is target value, return soultion
	print("\nIs this a goal state?")
	
	if (pos.row == end_row) and (pos.col == end_col) and (pos.sum == targetValue):
		print("Soultion found!")
		return (pos.hist)

	# if target exceeded, return none
	elif pos.sum >= targetValue:
		print("No. Target exceeded:  abandoning path")
		return None
			
	else:
		print("No.  Can I move right?")
		
		# try to move right
		if isValid(pos.grid, pos.row, pos.col+1):
			print("Yes!")
			
			new_hist = pos.hist
			new_hist.append(pos.grid[pos.row][pos.col+1])
			new_grid = pos.grid[:]
			new_grid[pos.row][pos.col+1] = "X"
			new_pos = State(new_grid, new_hist, pos.row, pos.col+1)
			pause = input("Paused...")
			
			print("\nProblem is now:\n", new_pos)
			
			# move right as far as you can
			result = solve(new_pos, end_row, end_col, targetValue)

			if result != None:
				return result
			
			# if you reach a problem, go back one
			else:
				new_grid[pos.row][pos.col+1] = new_hist.pop()

		print("No.  Can I move up?")

		# try to move up
		if isValid(pos.grid, pos.row-1, pos.col):
			print("Yes!")

			new_hist = pos.hist
			new_hist.append(pos.grid[pos.row-1][pos.col])
			new_grid = pos.grid[:]
			new_grid[pos.row-1][pos.col] = "X"
			new_pos = State(new_grid, new_hist, pos.row-1, pos.col)
			pause = input("Paused...")

			print("\nProblem is now:\n", new_pos)
			
			result = solve(new_pos, end_row, end_col, targetValue)
			
			if result != None:
				return result
			else:
				new_grid[pos.row-1][pos.col] = new_hist.pop()
		
		print("No.  Can I move down?")

		# try to move down
		if isValid(pos.grid, pos.row+1, pos.col):
			print("Yes!")

			new_hist = pos.hist
			new_hist.append(pos.grid[pos.row+1][pos.col])
			new_grid = pos.grid[:]
			new_grid[pos.row+1][pos.col] = "X"
			new_pos = State(new_grid, new_hist, pos.row+1, pos.col)
			pause = input("Paused...")

			print("\nProblem is now:\n", new_pos)
			
			result = solve(new_pos, end_row, end_col, targetValue)
			
			if result != None:
				return result
			else:
				new_grid[pos.row+1][pos.col] = new_hist.pop()
		
		print("No.  Can I move left?")

		# try to move left
		if isValid(pos.grid, pos.row, pos.col-1):
			print("Yes!")

			new_hist = pos.hist
			new_hist.append(pos.grid[pos.row][pos.col-1])
			new_grid = pos.grid[:]
			new_grid[pos.row][pos.col-1] = "X"
			new_pos = State(new_grid, new_hist, pos.row, pos.col-1)
			pause = input("Paused...")

			print("\nProblem is now:\n", new_pos)
			
			result = solve(new_pos, end_row, end_col, targetValue)

			if result != None:
				return result
			else:
				new_grid[pos.row][pos.col-1] = new_hist.pop()
		
		print("Couldn't move in any direction.  Backtracking.")
		print(pos)
		new_grid = pos.grid[:]
		new_grid[pos.row][pos.col] = pos.hist.pop()
		print(pos)


def main():
	
	f = open("mazedata.txt", "r")
	grid = []
	count = 0
	
	for line in f:
		# split the string into a list representing each row
		row = line.split()	
		
		# take the first line as variables
		if count== 0:
			targetValue = int(row[0])
			grid_rows = int(row[1])
			grid_cols = int(row[2])
			start_row = int(row[3])
			start_col = int(row[4])
			end_row = int(row[5])
			end_col = int(row[6])
		
		# the remaining lines are the grid
		else:
			# create a 2D list to represent the grid
			row = list(map(int, row))
			grid.append(row)
		
		count += 1
	
	# mark the starting point
	hist = [grid[start_row][start_col]]
	grid[start_row][start_col] = "X"
	pos = State(grid, hist, start_row, start_col)
	print(pos)
	print(solve(pos, end_row, end_col, targetValue))

	#close the file
	f.close()

main()

