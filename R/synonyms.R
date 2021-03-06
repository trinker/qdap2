#' Search For Synonyms
#' 
#' Search for synonyms that match term(s).
#' 
#' @param terms The terms to find synonyms for.  
#' @param return.list logical.  If TRUE returns the output for multiple synonyms 
#' as a list by search term rather than a vector.
#' @param multiwords logical.  IF TRUE retains vector elements that contain 
#' phrases (defined as having one or more spaces) rather than a single word.
#' @param report.null logical.  If TRUE reports the words that no match was 
#' found at the head of the output.
#' @return Returns a list of vectors or vector of possible words that match 
#' term(s).
#' @rdname synonyms
#' @references The synonyms dictionary (see \code{\link[qdap]{SYNONYM}}) was 
#' generated by web scraping the 
#' \href{http://dictionary.reverso.net/english-synonyms/}{Reverso Online Dictionary}.
#' The word list fed to \href{http://dictionary.reverso.net/english-synonyms/}{Reverso} 
#' is the unique words from the combination of \code{\link[qdap]{DICTIONARY}} and
#' \code{\link[qdap]{labMT}}.
#' @export
#' @examples
#' synonyms(c("the", "cat", "job", "environment", "read", "teach"))
#' head(syn(c("the", "cat", "job", "environment", "read", "teach"), 
#'     return.list = FALSE), 30)
#' syn(c("the", "cat", "job", "environment", "read", "teach"), multiwords = FALSE)
synonyms <- function(terms, return.list = TRUE, 
    multiwords = TRUE, report.null = TRUE){
    recoder <- function(x, missing){                               
        x <- as.character(x)    
        rc <- function(x, envr){                                    
            if(exists(x, envir = envr)) {
                get(x, envir = envr) 
            } else {
                NULL     
            }
        }                                                      
        sapply(x, rc, USE.NAMES = FALSE, envr = env.syn)                       
    }   
    rcst <- function(x) {              
        y <- c(sapply(strsplit(x, "@@@@"), Trim))
        nms <- bracketXtract(y, "square")
        y <- bracketX(y, "square")
        names(y) <- paste0("def_", nms)
        lapply(lapply(y, strsplit, "\\,"), function(x){
            Trim(unlist(x))
        })
    }
    out <- lapply(recoder(terms), function(z) {
        if (is.null(z)){
            return(NULL)
        } else {
            x <- rcst(z)
        }
        if (!multiwords){
            x <- lapply(x, function(y) {
                mults <- grepl("\\s", y)
                if (any(mults)){
                    y <- y[!mults]
                }
                return(y)
            })
        }
        return(x)
    })
    names(out) <- terms
    if (report.null & any(sapply(out, is.null))) {
        cat("no match for the following:\n\n")
        cat(paste(names(out)[sapply(out, is.null)], collapse = ", "))
        cat("\n========================\n\n")
    }
    if (return.list) {
        unlist(out, recursive = FALSE)
    } else {
        outs2 <- unlist(out)
        names(outs2) <- NULL
        unique(outs2)
    }
}

#' @rdname synonyms
#' @export
syn <- synonyms