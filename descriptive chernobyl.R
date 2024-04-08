# load library
library(tm)

# import text
doc2 <- read.delim("Chernobyl.txt", quote = "")
colnames(doc2) <- c("review_title", "review_content", "movie_rating")

# Build corpus
corpus <- iconv(doc2$review_content)
corpus <- Corpus(VectorSource(corpus))
inspect(corpus[1:5])

# Clean text
corpus <- tm_map(corpus, tolower)
inspect(corpus[1:5])

corpus <- tm_map(corpus, removePunctuation)
inspect(corpus[1:5])

corpus <- tm_map(corpus, removeNumbers)
inspect(corpus[1:5])

cleanset <- tm_map(corpus, removeWords, stopwords('english'))
inspect(cleanset[1:5])

removeURL <- function(x) gsub('http[[:alnum:]]*', '', x)
cleanset <- tm_map(cleanset, content_transformer(removeURL))
inspect(cleanset[1:5])

cleanset <- tm_map(cleanset, gsub, 
                   pattern = 'ambiance', 
                   replacement = 'ambience')

cleanset <- tm_map(cleanset, stripWhitespace)
inspect(cleanset[1:5])


# Tokenization: Create Term document matrix (Bag of words)
tdm <- TermDocumentMatrix(cleanset)
#tdm <- TermDocumentMatrix(doc$text) # this would use the non-cleaned dataset instead
tdm
tdm <- as.matrix(tdm)
tdm[1:10, 1:10]

# Bar plot
w <- rowSums(tdm)
w <- sort(w, decreasing = TRUE)
w <- subset(w, w>=25)

barplot(w, las = 2, col = rainbow(20))

# Create a wordcloud
library(wordcloud2)
w <- rowSums(tdm)
w <- data.frame(names(w), w)
colnames(w) <- c('word', 'freq')
wordcloud2(w[which(w$freq > 10),],
           size = 0.7,
           shape = 'circle',
           rotateRatio = 0.5,
           minSize = 1)

