

Write a program that will move a character from left to
right and then back again across the monitor of the PC a number of times as
specified by the user's input.  The user
is to be prompted for the character to display and how many times to move it
back and forth.  An input of '?' and 1
would cause the '?' to move back and forth across the monitor 1 trip.

Your program must only allow entry of numbers from 1 to 3
inclusive.  Use a loop that allows an
exit only if the value is greater than zero and less than four.  If the user enters an illegal value you must
remind him/her of the values that are allowed and re-prompt for the numeric
value.  You do not have to do any error
checking on the character as any printable character is fine.

Remember if you have just displayed a character the cursor
will be just to the right of it.  In
order to display the next character you will have to erase the previous
character and then display the character in the new location.  The backspace character is character number 8
and a space is character number 32.  Do
not display a character in the 80th position as this will cause the cursor to
advance to the next line.  All output
must be on the same line.

You will also have to write a procedure that will slow the
cursor movement across the screen.  A modern
CPU will move the cursor so fast that the user will not see it move.  Your delay procedure needs to be a loop that
does nothing an appropriate number of times.



Assembly Program: Character Movement Across Screen

1. Start
2. Setup:

   - Define data segment for storing character and number of trips
   - Define stack segment for subroutine calls
3. Main Procedure:

   - Initialize data segment
   - Initialize stack segment
   - Call InputCharacter procedure
   - Call InputNumberOfTrips procedure
   - Call MoveCharacter procedure
   - Terminate program
4. InputCharacter Procedure:

   - Display prompt for character input
   - Read character from user
   - Store character in a specific memory location
5. InputNumberOfTrips Procedure:

   - Initialize validInput flag to false
   - While validInput is false:
     - Display prompt for number of trips
     - Read number from user
     - Check if number is between 1 and 3
     - If valid, set validInput to true, else display error message
6. MoveCharacter Procedure:

   - For each trip (from 1 to numberOfTrips):
     - Move character from left to right across the screen
     - Then move character from right to left back to the start
7. CharacterMovement Subprocedure:

   - Use loop to move character across the screen
   - Use BIOS interrupt or direct video memory access for display
   - Call Delay procedure between each movement
8. Delay Procedure:

   - Implement a delay loop to slow down character movement
9. End
