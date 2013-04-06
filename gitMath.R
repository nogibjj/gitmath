#R Code Metrics Library about a Git Repository
#Relates to 'Use of Relative Code Churn Measures to Predict System Defect Density'

#Usage example:
#source('/Users/noah/src/boundary/git-math/gitMath.R')
#gs <- mkchurnline()	#lines, churn, churn/lines
#OR
#mkreport()				#generates report of top values, all and a plot of top values
#gitMathAll.txt and gitMathtop.txt is created in current working directory
#also creates pdf called topchurn.pdf

#TO DO
#1.  Consider what to do with files that have never changed (1 value), currently they are discarded
#2.  Break out a new matrix for each file extension
#3.  Figure out what to do for file counts on historical churn metrics
#4.  Fix divide by zero infinity in relcodechurn

#Get linecount from file
linecount <- function(filename){
	sargs <- sprintf(" %s | awk '{print $1}'", filename)
	lines <- system2("wc",sargs, stdout=TRUE)
	#Only give line counts if the file exists
	if (length(lines) > 0){
			lines <- as.numeric(lines)
		}
	else{
		lines <- NA 
	}
	return(lines) 

}

#Generates churned file list for git repository via git log shell command
#To query churn by time range pass in i.e. "1 month ago"
gitchurn <- function(git_date_range) {
	if(missing(git_date_range)){
		sargs <- "log --all -M -C --name-only --format='format:' | grep -v '^$'" 
	}
		else{
		sargs <- sprintf("log --all -M -C --name-only --format='format:' --since='%s' | grep -v '^$'", git_date_range)
	} 
	churnoutput <- system2("git", sargs, stdout=TRUE, stderr=TRUE)
	return(churnoutput)
}

#Helper function generates frequency matrix of churned files
#Accepts the output of gitchurn
churnhelper <- function(churnfiles) {
	gitstats <- as.matrix(table(churnfiles))
	colnames(gitstats) <- c("churn")
	return(gitstats)
}

#Returns code statistics matrix
churn <- function(git_date_range) {
	if(missing(git_date_range)){
		churnfiles <- gitchurn()
	}
		else{
		churnfiles <- gitchurn(git_date_range)
	}
	gsmatrix <- churnhelper(churnfiles)
	return(gsmatrix)
}

#Gets linescounts from matrix of source code files
mklinecount <- function(churnmatrix) {
	clcmatrix <- sapply(row.names(churnmatrix),linecount)
	#colnames(clcmatrix) <- c("linecount")
	return(clcmatrix)
}

#Merges linecount and code churn matrix
churnline <- function (cmatrix, lmatrix){
	churnlinematrix <- merge(cmatrix, lmatrix, by = "row.names", all = TRUE)
	return(churnlinematrix)
}

#Generates relative churn/loc metric and adds to matrix
#relchurn <- function (clc) {
#	clc <- cbind(clc,clc$churn/clc$linecount)
#	return(clc)
#}

#Generates churn/line matrix and returns merged matrix
#Omits NA values..i.e. files no longer in repo
mkchurnline <- function () {
	cmatrix <- churn()
	lmatrix <- mklinecount(cmatrix)
	clcmatrix <- churnline(cmatrix, lmatrix)
	clcmatrix <- na.omit(clcmatrix)
	colnames(clcmatrix) <- c("files", "churn", "linecount")
	clcmatrix.relchurn <- clcmatrix$churn/clcmatrix$linecount
	clcmatrix <- cbind(clcmatrix, clcmatrix.relchurn)
	colnames(clcmatrix) <- c("files", "churn", "linecount", "relchurn")
	return(clcmatrix)
}

#Generate top values for report, default to top 25
mkreport <- function (topval=25){
	clc <- mkchurnline()
	#order matrix by highest churn file
	clco <- clc[order(clc$churn, decreasing=TRUE),]
	clcotop <- clco[1:topval,]
	plot(clcotop$churn, clcotop$relchurn, main="Churn vs relchurn", xlab="Churn", ylab="Churn/LOC", pch=18,col="blue")
	text(clcotop$churn, clcotop$relchurn, clcotop$files, cex=0.8, pos=4, col="red")
	#now save pdf
	pdf(file="topchurn.pdf")
	plot(clcotop$churn, clcotop$relchurn, main="Churn vs relchurn", xlab="Churn", ylab="Churn/LOC", pch=18,col="blue")
	text(clcotop$churn, clcotop$relchurn, clcotop$files, cex=0.8, pos=4, col="red")
	dev.off()
	#write report
	write.table(clc, file="gitMathAll.txt")
	write.table(clcotop, file="gitMathtop.txt")

}
churnplot <- function() {
	plot(churn(), ylab="file churn", xlab="file count")
}

churnlineplot <- function () {
	res <- mkchurnline()
	plot(res$churn, res$linecount)
}

