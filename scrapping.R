#####################
#Andres Ponce Morales
#Jan 2019

#install.packages("Rcrawler")
library(Rcrawler)
library(rvest)
library(dplyr)
library(stringr)
library(purrr)

###### STEP1
# create a numerical variable to match number of total urls with speeches to be crawled
cr <-seq(1, 96)

##Building a list of URL for accessing
# URL 
base_url_cr <- "https://prensa.presidencia.cl/discursos.aspx?page="

## 2. biding the list of URL
l_one <- expand.grid(base_url_cr, cr)

#Total url sets binding (all countries urls)
total <- rbind(l_one)
total$urls <- paste0(total$Var1, total$Var2)
total_urls <- total$urls
total_urls

###### STEP2
#Use the index variable from crawler for creating the var for loop
new<- INDEX # i have to run the loop once to copy the format of INDEX and use it later
# with rbind

#crawler for websites
for(i in total_urls[1:96]){
  try(Rcrawler(Website = i, no_cores = 4, no_conn = 4,DIR = "./myrepo", MaxDepth = 1))
      new <- rbind(new, INDEX)} #new has to previously exist for the loop to work

#Filter for the Urls with speeches
discursos<-new %>% filter(grepl("id=", Url)) %>% 
  filter(!grepl(".presidencia\\.aspx.", Url))# matching only websites with speches

# removing this section of the url /discursos.aspx?page=
discursos<-str_remove_all(discursos$Url,"/discursos\\.aspx.page=[0-9]+")

###### STEP3
#scrape data, speeches and Titles

sample_data<- tibble::tibble(url=discursos)

#save a copy of required urls to avoid the previous process
write.csv(sample_data, "presidente.csv")

#Functions to scrape speeches and dates
text_func <- function(x){
  read_html(x) %>%
    html_nodes(css = "#main_ltContenido") %>%
    html_text()
}

fecha_func <- function(x){
  read_html(x) %>%
    html_nodes(css = "#main_ltFEcha") %>%
    html_text()
}

tit_func <- function(x){
  read_html(x) %>%
    html_nodes(css = "#main_ltTitulo") %>%
    html_text()
}

#apply functions with mutate
sample_data_rev <- sample_data %>%
  mutate(., discursos = map_chr(.x = url, .f = text_func))


sample_data_fecha <- sample_data %>%
  mutate(., fecha = map_chr(.x = url, .f= fecha_func))

sample_tit <- sample_data %>%
  mutate(., tit = map_chr(.x = url, .f= tit_func))

# erasing pattern 
sample_data_rev$discursos<-gsub("\\r\\n", "",sample_data_rev$discursos)#eliminar el patron que viene desde el scrapping structure

#Parsing dates and merging
sample_disc$fecha <- sample_fecha$fecha %>% {gsub("ENE", "JAN",.)} %>% {gsub("DIC", "DEC",.)} %>% {gsub("AGO", "AUG",.)}%>% {gsub("ABR", "APR",.)} 

  #parse_date(sample_fecha$fecha,"%d %b %Y")

#merging datasets
sample_disc$fecha <- parse_date(sample_disc$fecha,"%d %b %Y")
sample_disc$tit <- sample_tit$tit

write.csv(sample_disc, "pinera.csv")
