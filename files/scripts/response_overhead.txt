import subprocess
import os

def run_r_script(filename, target):
	"""
	Runs the provided R script with 
	@param filename: a string which contains the filename of the R script
	@param target: the argument which is passed to the script
	"""
	process = "Rscript"
	command = [process, filename, target]
	subprocess.call(command)
	
def get_all_xls():
	"""
	@return: a list of strings containing all the filenames of .xls
	files within the input/ directory
	"""
	files = os.listdir("input/")
	csvs = ["input/" + name for name in files if name.endswith(".xls")]
	return csvs

def run_analyses(filename):
	"""
	Runs the specified script on a list of xls files, passing the filename
	of each excel file as an argument to the R script.
	@param filename: the name of the R script which will be run
	"""
	xls = get_all_xls()
	for target in xls:
		run_r_script(filename, target)

os.makedirs("responses")
run_analyses("response_analysis.R")