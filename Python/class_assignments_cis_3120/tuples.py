#Learning about Tuples

programming_languages = ("Python", "Java", "C++")

"C++" in programming_languages

numbers_1 = (1,2,3)
numbers_2 = (4,5,6)

numbers_3 = numbers_1 + numbers_2
print(numbers_3)

greeting = ("hello",) * 3
print(greeting)

#Practical uses for tuples:

#Use Tuples as dictionary keys for example, google maps and GPS systems use tuples to store data that does not need to be changed.

locations = {
    (40.7128, -74.0060): "New York",
    (34.0522, -1118.2437): "Los Angeles"
}

print(locations[((40.7128, -74.0060))])

