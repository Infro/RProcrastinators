#Links
{
#Dataset Extraction
#http://www.r-bloggers.com/how-to-download-complete-xml-records-from-pubmed-and-extract-data/
#http://www.nlm.nih.gov/databases/license/weblic/index.html
#http://www.nlm.nih.gov/databases/journal.html
#http://hlwiki.slais.ubc.ca/index.php/PubMed_Alternative_Interfaces
#http://www.ncbi.nlm.nih.gov/pmc/articles/PMC3000749/
#http://dtd.nlm.nih.gov/archiving/tag-library/3.0/index.html

#Bibliotools
#http://www.sebastian-grauwin.com/?page_id=492

#Visualizations
#http://flowingdata.com/2012/01/01/visualizing-citations-in-research-literature/
#http://flowingdata.com/2010/11/03/review-atlas-of-science-visualizing-what-we-know/
#http://www.visualcomplexity.com/vc/project.cfm?id=364
#http://casoilresource.lawr.ucdavis.edu/drupal/node/630
#http://www.visualizing.org/
#http://www.counterspill.org/

#Group
#https://trello.com/board/ivmooc-hiv-niaid-project/5122ce18d415aa52790007c0
#Write.Up https://docs.google.com/document/d/1ZqjVarifamrinMy7mBizqJq0MpvQ7J7GaKjXqjuF7oY/edit
#IV.MOOC Group https://plus.google.com/u/0/communities/117132749483688407840?cfem=1

#Group Vis
#https://docs.google.com/file/d/0B9L5KYxCrlD7WGp4Nm9uVU1aZzQ/edit
#https://docs.google.com/file/d/0B9L5KYxCrlD7MHV6amN2UzBacGM/edit
}
#Universal Functions
{
  plotit <- function(x, y, funding, selection, edgeSource, edgeDestination) {
    xyplot(
      x~y,
      key=list(
        lines= list(col=c("black","black","black","#00CCCC"),
                    type=c("p", "p", "p", "l"),
                    pch=c(19,1,2,1),
                    cex=c(1,1.5,2,1)),
        padding.text = c(0.2,0.6,6),
        text=list(c('Article','Funding Source(s)','Selected Articles','Citations'))),,
      panel=function(x,y,...) {
        panel.xyplot(x,            y,            col="blue",  pch=19,          ...)
        panel.xyplot(x[funding], y[funding], col="red",   pch=1,  cex=1.5, ...)
        panel.xyplot(x[selection],  y[selection],  col="black", pch=2,  cex=2,   ...)
        panel.arrows(x[edgeSource],y[edgeSource],x[edgeDestination], y[edgeDestination], col="#00CCCC99", angle=180/6, length = 0.1)
        panel.rect(-2,-2.5,3,-1,col="#00000033")
        panel.rect(-2,-1,  3, 0,col="#CCCC0033")
        panel.rect(-2, 0, 3,0.5,col="#00CCCC33")
        panel.rect(-2,0.5, 3,2.5,col="#FFFFCC33")
      },
      xlab="Year of Publication",
      ylab="Category of Publication")
  }
}

DoISI = F
DoTestPlot = T
DoHIV = T

if(DoHIV)
{
  d1<-read.table(file='data/raw/25 years of HIVAIDS Research at NIAID/Reduced NIH Grants Table 02.20.13.csv',       sep=",", quote="\"", nrows=100)
  d2<-read.table(file='data/raw/25 years of HIVAIDS Research at NIAID/Reduced NIH Publications Table 02.20.13.csv', sep=",", quote="\"", nrows=100)
  d3<-read.table(file='data/raw/25 years of HIVAIDS Research at NIAID/hiv_aids_pubmed_2003-2013.csv',               sep=",", quote="\"", nrows=100)
}

if(DoISI)
{
  data<-read.csv('X:/pubmed/ISIDataset_HIV_EndnoteExport.csv')
  #Ref Type, Year, Title, Journal, Volume,
  #Number, Pages, Date, Notes, ISBN/ISSN,
  #Accession Number, Keywords, URL, Language,
  #Electronic Resource Number, Abstract,
  #Authors, Author Address
  paste("Percent of Keywordless Entries:", sum(data$Keywords == "")/dim(data)[1])
  paste("Number of Years without an entry:", sum(is.na(data$Year)))
  paste("Number of abstracts with copies:", sum(table(data$Abstract)>=2))
}