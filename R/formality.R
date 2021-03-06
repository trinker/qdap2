#' Formality Score
#' 
#' Transcript apply formality score by grouping variable(s) and optionally plot 
#' the breakdown of the model.
#' 
#' @param text.var The text variable (or an object from \code{\link[qdap]{pos}},
#' \code{\link[qdap]{pos.by}} or \code{\link[qdap]{formality}}.  Passing the 
#' later three object will greatly reduce run time.
#' @param grouping.var The grouping variables.  Default NULL generates formality 
#' score for all text.  Also takes a single grouping variable or a list of 1 or 
#' more grouping variables.
#' @param sort.by.formality logical.  If TRUE orders the results by formality 
#' score.
#' @param digits The number of digits displayed.
#' @param \ldots Other arguments passed to \code{\link[qdap]{pos.by}}.
#' @section Warning: Heylighen & Dewaele(2002) state, "At present, a sample would 
#' probably need to contain a few hundred words for the measure to be minimally 
#' reliable. For single sentences, the F-value should only be computed for 
#' purposes of illustration".
#' @details Heylighen & Dewaele(2002)'s formality score is calculated as:
#' \deqn{F = 50(\frac{n_{f}-n_{c}}{N} + 1)}
#'
#' Where:
#' \deqn{f = \left \{noun, \;adjective, \;preposition, \;article\right \}}
#' \deqn{c = \left \{pronoun, \;verb, \;adverb, \;interjection\right \}}
#' \deqn{N = \sum{(f \;+ \;c \;+ \;conjunctions)}}
#' @return A list containing at the following components: 
#' \item{text}{The text variable} 
#' \item{POStagged}{Raw part of speech for every word of the text variable} 
#' \item{POSprop}{Part of speech proportion for every word of the text variable} 
#' \item{POSfreq}{Part of speech count for every word of the text variable} 
#' \item{pos.by.freq}{The part of speech count for every word of the text 
#' variable by grouping variable(s)} 
#' \item{pos.by.prop}{The part of speech proportion for every word of the text 
#' variable by grouping variable(s)} 
#' \item{form.freq.by}{The nine broad part of speech categories count for every 
#' word of the text variable by grouping variable(s)} 
#' \item{form.prop.by}{The nine broad part of speech categories proportion for 
#' every word of the text variable by grouping variable(s)} 
#' \item{formality}{Formality scores by grouping variable(s)} 
#' \item{pos.reshaped}{An expanded formality scores output (grouping, 
#' word.count, pos & form.class) by word}
#' @references Heylighen, F., & Dewaele, J.M. (2002). Variation in the 
#' contextuality of language: An empirical measure. Context in Context, Special 
#' issue of Foundations of Science, 7 (3), 293-340.
#' @keywords formality, explicit, parts-of-speech, pos
#' @export
#' @import ggplot2 gridExtra scales RColorBrewer
#' @examples
#' with(DATA, formality(state, person))
#' (x1 <- with(DATA, formality(state, list(sex, adult))))
#' plot(x1)
#' plot(x1, short.names = TRUE)
#' data(rajPOS) #A data set consisting of a pos list object
#' x2 <- with(raj, formality(rajPOS, act))
#' plot(x2)
#' x3 <- with(raj, formality(rajPOS, person))
#' plot(x3, bar.colors="Dark2")
#' plot(x3, bar.colors=c("Dark2", "Set1"))
#' x4 <- with(raj, formality(rajPOS, list(person, act)))
#' plot(x4, bar.colors=c("Dark2", "Set1"))
#' 
#' rajDEM <- key_merge(raj, raj.demographics) #merge demographics with transcript.
#' x5 <- with(rajDEM, formality(rajPOS, sex))
#' plot(x5, bar.colors="RdBu")
#' x6 <- with(rajDEM, formality(rajPOS, list(fam.aff, sex)))
#' plot(x6, bar.colors="RdBu")
#' x7 <- with(rajDEM, formality(rajPOS, list(died, fam.aff)))
#' plot(x7, bar.colors="RdBu",  point.cex=2, point.pch = 3)
#' x8 <- with(rajDEM, formality(rajPOS, list(died, sex)))
#' plot(x8, bar.colors="RdBu",  point.cex=2, point.pch = "|")
#' 
#' names(x8)
#' colsplit2df(x8$formality)
#' 
#' #pass an object from pos or pos.by
#' ltruncdf(with(raj, formality(x8 , list(act, person))), 6, 4)
formality <- function(text.var, grouping.var = NULL,                    
    sort.by.formality = TRUE, digits = 2, ...){        
    G <- if(is.null(grouping.var)) {                                                 
             gv <- TRUE                                                              
             "all"                                                                   
         } else {                                                                    
             gv <- FALSE                                                             
             if (is.list(grouping.var)) {                                            
                 m <- unlist(as.character(substitute(grouping.var))[-1])             
                 m <- sapply(strsplit(m, "$", fixed=TRUE), function(x) x[length(x)]) 
                     paste(m, collapse="&")                                          
             } else {                                                                
                  G <- as.character(substitute(grouping.var))                        
                  G[length(G)]                                                       
             }                                                                       
         }                                                                           
    if(is.null(grouping.var)){                                       
        grouping.var <- rep("all", length(text.var))                                                 
    } else {                                                                         
        if(is.list(grouping.var) & length(grouping.var)>1) {                             
            grouping.var <- apply(data.frame(grouping.var), 1, function(x){                             
                     if (any(is.na(x))){                                             
                         NA                                                          
                     }else{                                                          
                         paste(x, collapse = ".")                                    
                     }                                                               
                 }                                                                   
             )                                                                       
        } else {                                                                     
            grouping.var <-  unlist(grouping.var)                                                     
        }                                                                            
    }                                                                          
    if (!gv) {                                                                       
        pos.list <- pos.by(text.var = text.var,                                      
            grouping.var = grouping.var, digits = digits, ...)                            
    } else {                                                                         
        pos.list <- suppressWarnings(pos.by(text.var = text.var,                     
            grouping.var = NULL, digits = digits, ...))                                   
    }                                                                                
    text.var <- pos.list$text                                                        
    WOR <- word.count(text.var)                                                      
    X <- pos.list[["pos.by.freq"]]                                                   
    nameX <- rownames(X)                                                             
    X <- data.frame(X)                                                               
    xn <- nrow(X)                                                                    
    X$JI <- rep(0, xn)                                                               
    X$JK <- rep(0, xn)                                                               
    article <- function(x) {                                                         
        if (identical(x, character(0))) {                                            
            return(0)                                                                
        } else {                                                                     
            WORDS <- stopwords(x, stopwords = NULL,                                  
                unlist = FALSE, strip = TRUE)                                        
            sapply(WORDS, function(x) sum(x %in% c("the", "an", "a"),                
                na.rm = TRUE ))                                                      
        }                                                                            
    }                                                                                
    if (!gv){                                                                        
        stv <- split(text.var, grouping.var)                                         
        stv <- stv[sapply(stv, function(x) !identical(x, character(0)))]             
        articles <- unlist(lapply(stv, function(x){                                  
                sum(article(x))                                                      
            }                                                                        
        ))                                                                           
    } else {                                                                         
        articles <- sum(article(text.var))                                           
    }                                                                                
    if (!is.null(X$DT)) {                                                            
        PD <- X$DT-articles                                                          
    }                                                                                
    DF1 <- DF2 <- data.frame(                                                        
        noun = rowSums(X[, names(X) %in% c("NN", "NNS", "NNP", "NNPS",               
            "POS", "JI", "JK")]),                                                    
        adj = rowSums(cbind(X[, names(X) %in% c("CD", "JJ", "JJR", "JJS",            
            "JI", "JK")], PD)),                                                      
        prep = rowSums(X[, names(X) %in% c("IN", "RP", "TO", "JI", "JK")]),          
        articles = articles,                                                         
        pronoun = rowSums(X[, names(X) %in% c("PRP", "PRP$", "PRP.", "WDT",          
            "WP", "WP$", "WP.", "JI", "JK", "EX")]),                                 
        verb = rowSums(X[, names(X) %in% c("MD", "VB", "VBD", "VBG",                 
            "VBN", "VBP", "VBZ", "JI", "JK")]),                                      
        adverb = rowSums(X[, names(X) %in% c("RB", "RBR", "RBS", "WRB",              
            "JI", "JK")]),                                                           
        interj = rowSums(X[, names(X) %in% c("UH", "JI", "JK")]))                    
    DF1RS <- rowSums(DF1)       
    if (!gv) {                                                                       
        WOR <- sapply(split(WOR, grouping.var), sum, na.rm = TRUE)                   
    } else {                                                                         
        WOR <- sum(WOR, na.rm=TRUE)                                                  
    } 
    DF2$other <- DF1$other <- WOR - DF1RS                                                  
    DF1 <- do.call(rbind, lapply(1:nrow(DF1), function(i) 100*(DF1[i, ]/WOR[i])))  
    FOR <- (rowSums(cbind(DF1$noun, DF1$article, DF1$adj, DF1$prep)) -               
        rowSums(cbind(DF1$pronoun, DF1$verb, DF1$adverb, DF1$interj)) + 100)/2                                                                                      
    if(!gv) {                                                                        
        FOR <- data.frame(replace = X[, 1], word.count = WOR, formality = FOR)       
        colnames(FOR)[1] <- G                                                        
    } else {                                                                         
        FOR <- data.frame(replace = X[, 1], word.count = WOR,                        
            formality = FOR)                                                         
        colnames(FOR)[1] <- G                                                        
    }                                                                                
    FOR[, "formality"] <- round(FOR[, "formality"], digits = digits)                 
    if (!gv & sort.by.formality) {                                                   
        FOR <- FOR[order(-FOR$formality), ]                                          
        rownames(FOR) <- NULL                                                        
    }                                                                                
    if (!gv) {                                                                       
        prop.by <- data.frame(var=names(WOR),                                        
            word.count = WOR,                                                        
            apply(DF1, 2, round, digits = digits))                                   
        freq.by <- data.frame(var=names(WOR),                                        
            word.count = WOR, DF2)                                                   
    } else {                                                                         
        prop.by <- data.frame(var="all",                                             
            word.count = sum(WOR, na.rm = TRUE), DF1)                                
        freq.by <- data.frame(var="all",                                             
            word.count = sum(WOR, na.rm = TRUE), DF2)                                
    }                                                                                
    colnames(prop.by)[1] <- colnames(freq.by)[1] <- colnames(FOR)[1]                 
    rownames(prop.by) <- rownames(freq.by) <- NULL                                   
    o <- unclass(pos.list)                                                           
    o$form.freq.by <- freq.by                                                        
    o$form.prop.by <- prop.by                                                        
    o$formality <- FOR                                                               
    dat <- reshape(freq.by,                                                          
        direction="long",                                                            
        varying=list(c(3:11)),                                                       
        idvar= names(freq.by)[c(1:2)],                                                  
        timevar="pos",                                                               
        v.names=c("freq"),                                                           
        times =names(freq.by)[-c(1:2)])                                              
    colnames(dat)[1] <- "grouping"   
    ON <- sum(dat[, "pos"] == "other")
    dat[, "form.class"] <- c(rep(c("formal", "contectual"), 
        each = (nrow(dat) - ON)/2), rep("other", ON))      
    dat <- dat[rep(seq_len(dim(dat)[1]), dat[, 4]), -4]                              
    dat[, "pos"] <- factor(dat[, "pos"], levels=unique(dat[, "pos"]))                
    dat[, "form.class"] <- factor(dat[, "form.class"],                               
        levels=unique(dat[, "form.class"]))                                          
    row.names(dat) <- NULL                                                           
    o$pos.reshaped <- dat  
    o$group <- G                                                                                                                                                                                                      
    class(o) <- "formality"                                                  
    return(o)                                                                        
}


#' Plots a formality Object
#' 
#' Plots a formality object including the parts of speech used to 
#' calculate contextual/formal speech.
#' 
#' @param x The formality object.
#' @param point.pch The plotting symbol.
#' @param point.cex  The plotting symbol size.
#' @param point.colors A vector of colors (length of two) to plot word count and 
#' formality score.
#' @param bar.colors A palette of colors to supply to the bars in the 
#' visualization.  If two palettes are provided to the two bar plots 
#' respectively.
#' @param short.names logical.  If TRUE shortens the length of legend and label 
#' names for more compact plot width.
#' @param min.wrdcnt A minimum word count threshold that must be achieved to be 
#' considered in the results.  Default includes all subgroups.
#' @param \ldots ignored
#' @return Invisibly returns the \code{ggplot2} objects that form the larger 
#' plot.
#' @method plot formality
#' @import ggplot2 gridExtra scales RColorBrewer
#' @S3method plot formality
plot.formality <- function(x, point.pch = 20, point.cex = .5,            
    point.colors = c("gray65", "red"), bar.colors = NULL, 
    short.names = FALSE, min.wrdcnt = NULL, ...) {
    grouping <- form.class <- NULL
    dat <- x$pos.reshaped   
    FOR <- x$formality
    G <- x$group
    if (!is.null(min.wrdcnt)){                                                       
        dat <- dat[dat[, "word.count"] > min.wrdcnt, ,drop = TRUE]                   
        dat[, 1] <- factor(dat[, 1])                                                 
        FOR <- FOR[FOR[, "word.count"] > min.wrdcnt, ,drop = TRUE]                   
    }   
    if(short.names){
        dat[, "form.class"] <- lookup(dat[, "form.class"], 
            c("formal", "contectual", "other"),
            c("form", "cont", "other"))
    }                                                                                                                
    YY <- ggplot(dat, aes(grouping,  fill=form.class)) +                         
        geom_bar(position='fill') +                                              
        coord_flip() +  labs(fill=NULL) +                                        
        ylab("proportion") + xlab(G)  +                                          
        theme(legend.position = 'bottom') +
        ggtitle("Percent Contextual-Formal") +
        scale_y_continuous(breaks = c(0, .25, .5, .75, 1),
            labels=c("0", ".25", ".5", ".75", "1"))  
        if (!is.null(bar.colors)) {  
            if (length(bar.colors) == 1) {
                YY <- YY + suppressWarnings(scale_fill_brewer(palette = 
                    bar.colors))
            } else {
                YY <- YY + suppressWarnings(scale_fill_brewer(palette = 
                    bar.colors[2]))
        }
    }        
    dat2 <- dat[dat[, "pos"] != "other", ] 
    dat2[, "pos"] <- factor(dat2[, "pos"])
    dat2[, "form.class"] <- factor(dat2[, "form.class"])
    if(short.names) {
        LAB <- c("noun", "adj", "prep", "art", "pro", "verb", 
            "adverb", "interj")
    } else {
        LAB <- c("noun", "adjective", "preposition",                         
            "articles", "pronoun", "verb", "adverb", "interjection")  
    }
    LAB2 <- LAB[substring(LAB, 1, 3) %in% substring(levels(dat2$pos), 1, 3)]
    XX <- ggplot(data=dat2, aes(grouping,  fill=pos)) +                           
        geom_bar(position='fill') + coord_flip() +                               
        facet_grid(~form.class, scales="free", margins = TRUE) +                 
        scale_x_discrete(drop=F) +  labs(fill=NULL) +   
        scale_y_continuous(breaks = c(0, .25, .5, .75, 1),
            labels=c("0", ".25", ".5", ".75", "1")) +
        ylab("proportion") + xlab(G)  +                                              
        theme(legend.position = 'bottom') +
        ggtitle("Percent Parts of Speech By Contextual-Formal")                                         
    if (!is.null(bar.colors)) {  
        if (length(bar.colors) == 1) {
            XX <- XX + scale_fill_brewer(palette=bar.colors,                     
                name = "", breaks=levels(dat2$pos),                               
                labels = LAB2) 
        } else {
            XX <- XX + scale_fill_brewer(palette=bar.colors [2],                     
                name = "", breaks=levels(dat2$pos),                               
                labels = LAB2)  
        }
    } else {
             XX <- XX + scale_fill_discrete(name = "", 
                 breaks=levels(dat2$pos), labels = LAB2)
    }
    names(FOR)[1] <- "grouping"                                                  
    buffer <- diff(range(FOR$formality))*.05                                   
    ZZ <- ggplot(data=FOR, aes(grouping,  formality, size=word.count)) +         
        geom_point(colour=point.colors[1]) + coord_flip()+                       
        geom_text(aes(label = word.count), vjust = 1.2, size = 3,                
            position = "identity",colour = "grey30") +                           
        labs(size="word count") +                                                
        theme(legend.position = 'bottom') +      
        ggtitle("F Measure (Formality)") +
        scale_y_continuous(limits=c(min(FOR$formality)-buffer,                   
            max(FOR$formality) + buffer)) +                                      
        scale_size_continuous(range = c(1, 8)) + xlab(G)  +                      
    if (point.pch == "|") {                                                  
        geom_text(aes(label = "|"), colour=point.colors[2], 
            size=point.cex, position = "identity", hjust = .25, 
            vjust = .25)                 
    } else {                                                                 
        geom_point(colour=point.colors[2], shape=point.pch, 
            size=point.cex)  
    }                                                                     
    suppressWarnings(grid.arrange(YY, XX,                         
        ZZ, widths=c(.24, .47, .29), ncol=3))     
    invisible(list(f1 = XX, f2 = YY, f3 = ZZ))
}

#' Prints a formality Object
#' 
#' Prints a formality  object.
#' 
#' @param x The formality object.
#' @param \ldots ignored
#' @method print formality
#' @S3method print formality
print.formality <-
function(x, ...) {
    print(x$formality)
}