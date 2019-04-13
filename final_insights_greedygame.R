data_gg <- read.csv(file.choose())

#Finding-1  Games Sorted based on their revenue generated
sqldf("select game_id, sum(revenue)  from data_gg  group by 1 order by 2 desc ")

#2 Games and the number of campaigns along with the revenue generated
sqldf("select game_id, count(distinct campaign_id) , sum(revenue) from tab_3 group by 1 order by 3 desc")


#3 Top Performing Campaigns for every game
sqldf("select game_id,country_id,campaign_id,sum(revenue) as rev from data_gg group by 1,2,3 order by 1,4 desc")


#4  Top Performing Images(SUB-ID) in generating revenue for every game
tab <- sqldf("select game_id,country_id,campaign_id,adgroup_id,sum(revenue) as revenue, sum(total_impressions) as impressions, sum(total_clicks) as clicks from data_gg group by 1,2,3,4 order by 1,2,3,5 desc ")
tab$ctr <- (tab$clicks/tab$impressions)*100
tab$eCPM <- tab$revenue/(tab$impressions/1000) 
tab_2 <-sqldf("select * from tab group by 1,2,3,4 order by 1,3,5 desc ")
tab_2


#Goal - to improve revenue for each game or cut cost in terms of non-revenue generating ads

#Insight-1 :
#There are certain adgroups that are underperforming in certain campaigns. they can be removed to decrease source allocated and yet maintain stable revenue generation.


#Insight-2:
#There are certain campaigns that are recieving very less impressions and clicks and generate very negligible amount of revenue, they can be removed and yet maintained a stable yet optimised campaigns generating revenue

#Insight-3 
#The vice-versa of insight-2, there are certain games that doesn't have enough campaigns running, yet have decent impressions, meaning the revenue generated can be increased 


#Insight-4
#The campaigns that are being run for country_id- 1643084 is just 2 campaigns, they have decent click rate and impressions so the revenue generated can be improved provided more campaigns are run for this country as well.
