#' Time Span Code Sheet
#'
#' Generates a time span coding sheet and coding format sheet.
#' 
#' @param codes List of codes.
#' @param start A character string in the form of "00:00" indicating start time 
#' (default is ":00").
#' @param end A character string in the form of "00:00" indicating end time.
#' @param file A connection, or a character string naming the file to print to 
#' (.txt or .doc is recommended).
#' @references Miles, M. B. & Huberman, A. M. (1994). An expanded sourcebook: 
#' Qualitative   data analysis. 2nd ed. Thousand Oaks, CA: SAGE Publications.
#' @keywords coding
#' @seealso 
#' \code{\link[qdap]{cm_range.temp}},
#' @export
#' @examples
#' ## cm_time.temp(qcv(AA, BB, CC), ":30", "7:40", file = "foo.txt")
#' ## delete("foo.txt")
#' cm_time.temp(qcv(AA, BB, CC), ":30", "7:40")
#' 
#' x <- list(
#'     transcript_time_span = qcv(terms="00:00 - 1:12:00"),
#'     A = qcv(terms="2.40:3.00, 5.01, 6.52:7.00, 9.00"),
#'     B = qcv(terms="2.40, 3.01:3.02, 5.01, 6.52:7.00, 9.00, 1.12.00:1.19.01"),
#'     C = qcv(terms="2.40:3.00, 5.01, 6.52:7.00, 9.00, 17.01")
#' )
#' cm_time2long(x)
#' cm_time.temp(qcv(AA, BB, CC))
cm_time.temp <-
function(codes, start = ":00", end = NULL, file=NULL) {
    if (!is.null(end)) {
        wid <- options()$width
        options(width=1000)
        x1 <- matrix(c("list(", 
            "    transcript_time_span = qcv(terms=\"00:00 - 00:00\"),", 
            paste0("    ", codes[1:(length(codes)-1)], " = qcv(terms=\"\"),"),
            paste0("    ", codes[length(codes)], " = qcv(terms=\"\")"),
            ")"), ncol = 1)
        st <- unlist(strsplit(start, ":"))
        en <- as.numeric(unlist(strsplit(end, ":")))
        st[1] <- ifelse(st[1]=="", "0", st[1])
        st <- as.numeric(st)
        x <- (en[1] - st[1]) + 1
        z <- matrix(rep(0:59, x), nrow = x, byrow = TRUE)
        rownames(z) <- c(paste0("[", st[1]:en[1], "]"))
        colnames(z) <- rep("", ncol(z))
        if (st[2] > 0) {
            z[1, 0:(st[2])] <- NA
        }
        if (en[2] < 59) {
            z[x, (en[2] + 2):60] <- NA
        }
        zz <- matrix(capture.output(print(z, na.print=""))[-1], ncol =1)
        print(z, na.print=""); cat("\n\n")
        cat(paste0("list(\n",
            "    transcript_time_span = qcv(terms=\"00:00 - 00:00\"),\n",
            paste0("    ", paste0(paste(codes, 
            collapse = " = qcv(terms=\"\"),\n    "), " = qcv(terms=\"\")")), "\n)\n"))
        dimnames(zz) <- list(c(rep("", x)), c(""))
        if (Sys.info()["sysname"] == "Windows") {
            writeClipboard(noquote(rbind(zz, "", "", x1)), format = 1)                        
        }                                                        
        if (Sys.info()["sysname"] == "Darwin") {                 
            j <- pipe("pbcopy", "w")                             
            writeLines(noquote(rbind(zz, "", "", x1)), con = j)                               
            close(j)  
        }
        if (!is.null(file)) { 
            v <- paste0(zz, "\n")
            cat(v[1], file=file)   
            lapply(2:x, function(i) cat(v[i], file=file, append = TRUE))                                     
            cat(paste0("list(\n",
                "    transcript_time_span = qcv(terms=\"00:00 - 00:00\"),\n",
                paste0("    ", paste0(paste(codes, 
                    collapse = " = qcv(terms=\"\"),\n    "), " = qcv(terms=\"\")")), 
                    "\n)\n"), file = file, append = TRUE) 
        }   
        options(width=wid)
    } else {
        zz <- x1 <- matrix(c("list(", 
            "    transcript_time_span = qcv(terms=\"00:00 - 00:00\"),", 
            paste0("    ", codes[1:(length(codes)-1)], " = qcv(terms=\"\"),"),
            paste0("    ", codes[length(codes)], " = qcv(terms=\"\")"),
            ")"), ncol = 1)
        dimnames(zz) <- list(c(rep("", nrow(zz))), c(""))
        print(noquote(zz))
        if (Sys.info()["sysname"] == "Windows") {
            writeClipboard(noquote(x1), format = 1)                        
        }                                                        
        if (Sys.info()["sysname"] == "Darwin") {                 
            j <- pipe("pbcopy", "w")                             
            writeLines(noquote(x1), con = j)                               
            close(j)  
        }
        if (!is.null(file)) {                                    
            cat(paste0("list(\n",
                "    transcript_time_span = qcv(terms=\"00:00 - 00:00\"),\n",
                paste0("    ", paste0(paste(codes, 
                collapse = " = qcv(terms=\"\"),\n    "), " = qcv(terms=\"\")")), 
                "\n)\n"), file = file, append = TRUE) 
        } 
    }
}