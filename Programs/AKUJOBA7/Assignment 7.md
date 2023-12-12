Assembly

Assign #7 (35 points)

Hamer

Due: 12/15/23 by 5:00 PM

Write an assembly program that will read in a persons name
and then print it in lastname, firstname [middle name] order.

The notation [middle name] means zero or more middle names. For example using an input of:

John James Smith

You will print

Smith, John James

You will need to write a procedure that will read in
characters until the enter key is pressed.

Store the characters in an array of characters defined in your data segment.

As you read the characters you will need to count the number of characters entered by the user, this may also be
stored in a data segment variable.

The maximum length of a name will be 80 characters.

You will then need to start at the right end of the name and
search backwards for a blank.

At this point, you can now print out the last name, a comma, and go back to the beginning of the array and print the rest of the name.

Make sure to properly test you program before submitting it.

You should test single names such as:

- Rihanna
- no name (hit enter key immediately)
- names with no middle name
- multiple middle names.
