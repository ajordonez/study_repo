#Reverse the sentence word by word

sentence = 'Python is amazing'
reverse = ''
split_sentence = sentence.split()

for i in range(0, len(split_sentence)):
    reverse += split_sentence[i][::-1]
    reverse += " "
print(reverse)

#Or you can do this:


reversed_words = []
for word in sentence.split():
    reversed_words.append(word[::-1])
print(" ".join(reversed_words))
    
    

