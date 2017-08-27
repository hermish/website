library(gdata)
library(plyr)
library(xlsx)

get_responses <- function(data) {
	# Complies the frequencies of all student responses in the dataframe,
	# (in .xls format) and returns a dataframe containing this frequency 
	# information.
	#
	# @param data: the dataframe containg the reponses that need to be
	# analyzed
	# @return: a dataframe with the frequency information

	questions <- sort(unique(data$Master.Order))

	cumulative <- data.frame()
	for (question in questions) {
		relevant <- subset(data, Master.Order == question)

		counts <- count(relevant, "Student.Response")
		percentages <- counts$freq / sum(counts$freq) * 100
		question_label <- rep(question, nrow(counts))
		correct <- rep(relevant$Correct.Response[1], nrow(counts))

		output <- cbind(question_label, counts, percentages, correct)
		cumulative <- rbind(cumulative, output)
	}
	
	names(cumulative) <- c("question", "response", "frequency",
			"percentages", "correct")
	cumulative <- cumulative[order(cumulative$frequency, decreasing=TRUE),,
		drop=FALSE]
	cumulative <- cumulative[order(cumulative$question),,
		drop=FALSE]
	cumulative
}

main <- function() {
	# Grabs target file from the command line and runs the function
	# get_responses. Outputs the data frame into an excel file with the
	# same name in the "reponses/"
	#
	# @precondition: reponses/ folder must exist in the directory where
	# this is run

	target <- commandArgs(trailingOnly = TRUE)
	output <- get_responses(read.xls(target))
	root <- strsplit(target, "/")[[1]][2]
	write.xlsx(output, paste("responses/", "(responses) ", root, "x", sep=""),
		sheetName="All", row.names=FALSE)
}

main()
