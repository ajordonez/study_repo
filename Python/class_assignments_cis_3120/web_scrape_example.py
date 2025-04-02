import webbrowser

# This line of code will take a google maps request and will send you to the url.
google = input("Enter a value to search via Google Maps: ")
webbrowser.open_new_tab('http://www.google.com/maps?btnG=1&q=%s' % google)




#webbrowser.open_new_tab("https://www.brooklyn.cuny.edu/")


#if not successful, replace the above line with the following
#webbrowser.open(“https://www.baruch.cuny.edu/”)