## sentiment analysis simple
library(syuzhet)

get_sentiment("this is good")
get_sentiment("this is very good")
get_sentiment("this is bad")
get_sentiment("this is not bad")
get_sentiment(":)")

get_sentiment("this is good", method = "afinn") # use afinn dictionary
get_sentiment("this is good", method = "bing") # use bing dictionary
get_nrc_sentiment("this is good") # use NRC dictionary
get_nrc_sentiment("this is not good")
get_nrc_sentiment("this is bad")
get_nrc_sentiment("I HATE THIS")


### sentiment analysis better
library(sentimentr)

sentiment("this is good")
sentiment("this is very good")
sentiment("this is slightly good")
sentiment("this is not good")
sentiment("this is not bad")
sentiment("this is a great disappointment")
sentiment(":)")


# application to IMDB reviews

doc2 <- read.delim("Chernobyl.txt", quote = "")
colnames(doc2) <- c("review_title", "review_content", "movie_rating")

doc2$syuzhet <- get_sentiment(doc2$review_content) # use syuzhet library for classification
#we dont run the t-test because we dont have the sentiment binary col to compare
#t.test(doc$syuzhet ~ doc$sentiment)
#boxplot(doc$syuzhet ~ doc$sentiment, outline = F)

temp <- sentiment(doc2$review_content) # use sentimentr library for classification
temp <- sentiment_by(doc2$review_content) #this library consider each sentence in the review so we get the avg score
doc2 <- cbind(doc2, sentiment_by(doc2$review_content))

#we dont run the t-test because we dont have the sentiment binary col to compare
#t.test(doc$ave_sentiment ~ doc$sentiment)
#boxplot(doc$ave_sentiment ~ doc$sentiment, outline = F)

plot(doc2$syuzhet, doc2$ave_sentiment)

# classify into positive or not
doc2$pos_syuzhet <- doc2$syuzhet > 0
doc2$pos_sentimentr <- doc2$ave_sentiment > 0

# Spearman's rank correlation
correlation_spearman <- cor(doc2$ave_sentiment, doc2$movie_rating, method = "spearman", use = "complete.obs")
correlation_spearman
# Create a basic scatter plot
plot(doc2$ave_sentiment, doc2$movie_rating, main = "Spearman Correlation between Sentiment and Rating",
     xlab = "Average Sentiment", ylab = "Movie Rating", pch = 19, frame = FALSE)

# Bar plot for negative and positive result
library(ggplot2)

positive_negative_counts <- table(doc$pos_sentimentr)
ggplot(data = as.data.frame(positive_negative_counts), aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity", fill = c("red", "green")) + 
  labs(x = "Sentiment", y = "Count", title = "Count of Positive and Negative Reviews") +
  scale_x_discrete(labels = c("Negative", "Positive")) + 
  theme_minimal()