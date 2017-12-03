import os
path = "F:/01_WORK/Symphoisis/appli_graphism/medias/explications"

def list_files(path):
    # returns a list of names (with extension, without full path) of all files 
    # in folder path
    files = []
    for root, dirs, files in os.walk(path):
		for file in files:
			with open("F:/01_WORK/Symphoisis/appli_graphism/medias/explications/imgs_list.txt","a") as text_file:
				text_file.write("%s\n" %file)
list_files(path)