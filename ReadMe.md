Visualization, Data Analysis, and Interaction Discussion
========================================================
Speedups
--------------------------------------------------------
### Ways to minimize the vocabulary.

 * Replace words that are highly specialized with a category, eg H2O->Chemical.
 * Remove words that are below some threshold in commonality.  (Word  * occurs in 1 out of 50,000 articles)
 * Remove words that are above some threshold. (Stop Words)
 * Use only pre-selected keywords eg. MeSH, or ones the client selects.

### Encode in a Sparse Matrix.

W is all words in all documents
V is set of all works in all documents
D is set of all documents
1. For each Document, create a list of words and their count.
 * Dictionary<int,List<KeyValuePair<string,int>> Documents;
2. For each Word, create a list of Documents and their count.
 * Dictionary<string,Dictionary<int,int>> Words
3. Space for each Word would be
 * P(W|D) * N(D)
4. Space for each Document would be
 * P(W|D) * N(W|D)
 
#### Sparse vs Normal Matrix:
Number of unique words in document * number of documents
$$\sum_w^V{[P(w|\overline{D}) * N(D)]} + P(w \in D) * N(W|D) * N(D) vs N(W)*N(D)$$

###Contact for the Fast PMI Network: : FLAG
 * amit@umiacs.umd.edu

