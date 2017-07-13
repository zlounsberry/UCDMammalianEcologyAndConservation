library(seqinr)

#The code below is code from Benjamin Tovar's blag (http://tata-box-blog.blogspot.com/2012/06/handling-large-fasta-sequence-datasets.html)
#	I modified it to add a random number to the output file and then repeat this step n times, generating n new Fasta files (randomly resampled).
#	So execute this whole mess up to the last } (that makes the function, I left his notes in there), 
#		and then the final line in this script is the one you should change to suit your needs.

shuffleAndExtract <- function(inputFastaFile,
                              numberOfoutputSeqs,
                              lengthOutputSeqs,
                              initialPos=1,
                              outputFileName = paste("Resample",floor(runif(1,1,99999999)),
                                                     "fas",sep=".")
                              ){

    #
    #    handleFastaDatasets.R   
    #
    #    This function in R is designed to open a fasta file dataset, shuffle the 
    #    sequences and extract the desired sequences wanted by the user to generate 
    #    a new dataset of fixed size (number of required sequences) and with the 
    #    same length for each sequence. 
    #
    #    Author: Benjamin Tovar
    #    Date: 22/JUNE/2012
    #
    ################################################################################

    #    run example:
    #    source("handleFastaDatasets.R")
    #    shuffleAndExtract("example.fasta",1000,200)

    # inputFastaFile: name of the input fasta file
    # numberOfoutputSeqs: number of desired sequences in the output file 
    # lengthOutputSeqs: fixed length of every sequence in the output file
    # initialPos: Position where the new window sizing will begin, default = 1
    # outputFileName: name of the output file, by default will be (e.g):
    #                 "inputFastaFile.fasta.output.fasta"

    cat("*** Starting computations |",date(),"****\n")    
        
    # Load the seqinr package
    require(seqinr)

    # Load the large seq and not shuffled dataset
    inputSeqs <- read.fasta(inputFastaFile)

    cat("\tProcessing for",length(inputSeqs),"sequences |",date(),"\n")    

    # Extract the length of every sequence and store the results in a vector.
    inputSeqsSize <- rep(NA,length(inputSeqs))
    for(i in 1:length(inputSeqs)){ 
        inputSeqsSize[i] <- summary(inputSeqs[[i]])$length
    }

inputSeqsLongSeqIndex <- which(inputSeqsSize > (lengthOutputSeqs+initialPos))

    # randomly pick numberOfoutputSeqs indexes that will be used to create 
    # the output dataset 
    inputSeqsIndex <- sample(inputSeqsLongSeqIndex,numberOfoutputSeqs,rep=F)
    
    # Store the Fasta header of each selected sequence in a vector
    inputSeqsIndexNames <- rep(NA,numberOfoutputSeqs)
    
    # create output object 
    outputSeqs <- list()
    for(i in 1:numberOfoutputSeqs){
        # Extract the fasta headers 
        inputSeqsIndexNames[i] <- attr(inputSeqs[[inputSeqsIndex[i]]],"name")
        # Extract the sequence
        outputSeqs[[i]] <- inputSeqs[[inputSeqsIndex[i]]][initialPos:((initialPos+lengthOutputSeqs)-1)]
    }
 
    # Export the sequences in a new fasta file 
    write.fasta(outputSeqs,inputSeqsIndexNames,outputFileName)
    
    cat("\n*** DONE |",date(),"****\n")
}

#SO here's the part that I wrote. The first number there is the number of resamples. It'll make new fasta files into your working directory folder!
#HEADS UP: For some reason I can't figure, it only takes up to n-2 nucleotides in your sequence. 
	#If you have 200, use 198. If you need all 200, add 2 dummy nucleotides to end of your file...
	#I might need to figure out and fix that, because of course you need all 200 why else would you have sequenced 200-bp??

replicate(501, shuffleAndExtract("Sequences.fas", 400, 550)) #replicate(resamples, shuffleAndExtract("yourfile.fas", [number of sequences resampled], [total length of sequence]))
