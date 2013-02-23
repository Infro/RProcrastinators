Visualization, Data Analysis, and Interaction Discussion
========================================================

Clustering Methods
==================
* Lantent Semantic Analysis
* Positive Pointwise Mutual Information
* WordNet/MeSH

Custom
-------------------
* Get AverageArcLength
* BeginRepeat
* Take Smallest Arc
* Place Point in middle of arc called NewCenter
* Calculate Distance of all Points to the NewCenter and remove if Distance < (Threshold * AverageArcLength) 
* If Arcs Removed > Threshold2 GoTo BeginRepeat
* Preform K-Means Clustering


Speedups
--------------------------------------------------------
### Best Bet
* http://www.indiana.edu/~clcl/Papers/BSC901.pdf
 
### Ways to minimize the vocabulary.

* Replace words that are highly specialized with a category, eg H2O->Chemical.
* Remove words that are below some threshold in commonality.  (Word  * occurs in 1 out of 50,000 articles)
* Remove words that are above some threshold. (Stop Words)
* Use only pre-selected keywords eg. MeSH, or ones the client selects.

### Encode in a Sparse Matrix.

W is all words in all documents
V is set of all works in all documents
D is set of all documents
* For each Document, create a list of words and their count.
 * Dictionary<int,List<KeyValuePair<string,int>> Documents;
* For each Word, create a list of Documents and their count.
 * Dictionary<string,Dictionary<int,int>> Words
* Space for each Word would be
 * P(W|D) * N(D)
* Space for each Document would be
 * P(W|D) * N(W|D)
 
#### Sparse vs Normal Matrix:
Number of unique words in document * number of documents
$$\sum_w^V{[P(w|\overline{D}) * N(D)]} + P(w \in D) * N(W|D) * N(D) vs N(W)*N(D)$$

## Improved Sparse Matrix
```
Dictionary<int, Dictionary<string,int>> Documents;
Dictionary<int, Dictionary<string,double>> PPMI;
Dictionary<int, int> DocumentWordCounts;
//Dictionary<string, int> WordCounts;
HashSet Vocabulary;
int WordCount;
int UniqueWordCount;
int DocumentCount;

UniqueWordCount = Vocabulary.Count;
DocumentCount = Documents.Count;
while(Documents.Count > 0)
{
  KeyValuePair<int,Dictionary<string,int>> doc = Documents.First();
  while(doc.Value.Count > 0)
  {
    Dictionary<string,int> dic = doc.Values.First();
    //foreach(string word in Vocabulary)
    foreach(string word in dic.Keys)
    {
      List<int> DocumentsContainingWord = Documents.Where(o=>o.Value.ContainsKey(word)).Select(o=>o.Key).AsList();
      int WordCount2 = 0;
      foreach(int doc2 in DocumentsContainingWord)
        WordCount2 += Documents[doc2][word];
      foreach(int doc2 in DocumentsContainingWord)
      {
        double P_of_w_given_d = ((double)(Documents[doc2][word] + DirichletSmoothAmmount) / (double)(UniqueWordCount*DirichletSmoothAmmount + DocumentWordCount[doc2]));
        double P_of_w = ((double)(/*WordCounts[word]*/ WordCount2 + DirichletSmoothAmmount)/(double)(WordCount+DirichletSmoothAmmount*UniqueWordCount*DocumentCount)) 
        int MI =  P_of_w_given_d/P_of_w;
        PMI = log2(MI);
        if(PMI >= PostiveThreshold)
        {
          PPMI[doc2].Add(word, PMI)
          if(PPMI[doc2]==null)
            PPMI.add(doc2, new Dictionary<string,int>());
        }
        Documents[doc2].RemoveKey(word);
        if(Documents[doc2].Count == 0)
          Documents.RemoveKey(doc2)
        //PPMI = max(P(W|C)/P(W),PostiveThreshold)
      }
    }
  }
}
```

```
Dictionary<int, Dictionary<string,int>> Documents;
Dictionary<int, Dictionary<string,double>> PPMI;
Dictionary<int, int> DocumentWordCounts;
//Dictionary<string, int> WordCounts;
HashSet Vocabulary;
int WordCount;
int UniqueWordCount;
int DocumentCount;

UniqueWordCount = Vocabulary.Count;
DocumentCount = Documents.Count;
foreach(string word in Vocabulary)
{
  List<int> DocumentsContainingWord = Documents.Where(o=>o.Value.ContainsKey(word)).Select(o=>o.Key).AsList();
  int WordCount2 = 0;
  foreach(int doc2 in DocumentsContainingWord)
    WordCount2 += Documents[doc2][word];
  foreach(int doc2 in DocumentsContainingWord)
  {
    double P_of_w_given_d = ((double)(Documents[doc2][word] + DirichletSmoothAmmount) / (double)(UniqueWordCount*DirichletSmoothAmmount + DocumentWordCount[doc2]));
        double P_of_w = ((double)(/*WordCounts[word]*/ WordCount2 + DirichletSmoothAmmount)/(double)(WordCount+DirichletSmoothAmmount*UniqueWordCount*DocumentCount)) 
    int MI =  P_of_w_given_d/P_of_w;
    PMI = log2(MI);
    if(PMI >= PostiveThreshold)
    {
      if(PPMI[doc2]==null)
        PPMI.add(doc2, new Dictionary<string,int>());
      PPMI[doc2].Add(word, PMI)
    }
    //PPMI = max(P(W|C)/P(W),PostiveThreshold)
  }
}
```

Cosine Similarity
```
CosineSimilarity(int doc1, int doc2)
{
  PPMI[doc1]
}
```

### Contact for the Fast PMI Network: : FLAG
 * amit@umiacs.umd.edu