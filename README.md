I performed two different analysis in this project, which is the descriptive analysis and sentiment analysis. For both analysis, Reviews were collected by scraping 10 review pages for the series Chernobyl on IMDB.com. I used an R script to loop over ten pages of the site, with each page containing approximately 25 reviews, yielding a dataset of 250 reviews. The reviews were saved into a data frame and then read into R for processing. 
#1. Steps taken in the descriptive analysis: 
##Creating corpus: A text corpus (text database) was created from this file, which serves as the input for text analysis. 
###Text Cleaning: The corpus was cleansed by removing extraneous elements such as irrelevant text snippets, HTML tags, and any non-textual, non-meaningful information. This step is crucial for reducing noise in the data. All text was converted to lowercase to maintain consistency, numbers and punctuation, stopwords and URLs were removed to focus on textual content. I also stripped the whitespace from the text, leaving only meaningful content for the descriptive analysis. 
###Stemming and lemmatization: Words were stemmed and lemmatized to reduce them to their root forms. This process helps to consolidate different forms of a word so that they can be analyzed as a single item, improving the accuracy of the analysis 
###Tokenization and Term- Document Matrix: The cleansed text was tokenized, breaking the text into individual units or tokens, typically words or phrases. A term-document matrix was then created, which structures text data into a matrix format. The TDM provides a simple way to see how often each word appears across different documents. 
###Visualization: A word cloud were generated from the term-document matrix. By doing this we can have an immediate, graphical representation of the data, highlighting the most frequent and significant terms within the reviews. 
![Uploading image.png…]()

#2. Steps taken in the Sentiment Analysis: 
##The sentimentr library was employed to classify the sentiment of each review. This tool analyzes sentiment at the sentence level, allowing us to calculate the average sentiment score for each review. Reviews with an average score greater than 0 are then classified as Positive, while those with scores less than 0 are classified as Negative. 
A bar chart was then generated to display the distribution of positiveversus negative reviews. The visualization revealed that roughly 48% of the total reviews were categorized as positive and around 52% of the total reviews were classified as negative. 
We can also create a scatter plot to show the Spearman Correlation between Sentiment and Rating 
We can interpret from the plot: 
###There is a variety of sentiment scores associated with each rating level.
###There is no obvious trend or pattern that indicates a strong relationship between sentiment and ratings.

