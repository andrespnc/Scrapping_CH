# Scrapping Speeches from the Press Presidential Website of Chile #
**Date**:  20.07.2020
**Author**: Andrés Ponce

### Table of contents
1. [Introduction](#introduction)
2. [Scrapping Presidential Press Website](#paragraph1)
3. [Analysing text & structured topic modelling](#paragraph2)
4. [Final Thoughts](#paragraph3)

## Introduction <a name="introduction"></a>
As a Public Policy graduate I see great challenges in **_open government policies and, in particular, access to public data_**. I started this project with the idea of using coding skills to gather and analyze public sources available to any citizen. As of January 2020, the presidential press website of Chile [prensa.presidencia](https://prensa.presidencia.cl/discursos.aspx) contained a large source of official speeches for president Piñera, since the time of his election to January 2020. These releases reflect the president´s communication strategy, even if they are subject to editorial control from presidential staff.

This project, runned completely in R, consists of two parts. First, the scrapping strategy, gathering speeches from March 2018 to Jan 2020. And second, structured topic modelling using date as covariate to understand how topic proportion change over time.  

<p align="center">
<img src="/assets/Screenshot%202020-07-19%20at%2012.13.08.png" height="600">
</p>

## Scrapping Presidential Press Website <a name="paragraph1"></a>
The scrapping process takes advantage of the URL structure `https://prensa.presidencia.cl/discursos.aspx` by using the Rcrawler library [^1] and Rvest [^2]. The speeches tab "discursos" contains 97 pages (at the time I did this). Each of these pages has at most 6 links to speeches, so 582 separate pages containing one speech each one. If we access a particular page we notice that each one of them has a URL pattern followed by a number https://prensa.presidencia.cl/discurso.aspx?id=135058. This pattern is used to identify speech pages from `Rcrawler` output.

<p align="center">
<img src="/assets/Lists of urls.png">
</p>

Scraping text is straightforward with Rvest. I created a function containing three processes `read_html()`, `html_nodes()`, and `html_text()`. I also used the same process to retrieve other useful information, such as date and speech title.

<p align="center">
<img src="/assets/speech.png">
</p>  
## Analysing text & structured topic modelling <a name="paragraph2"></a>
By plotting the numer of times the Chilean president appears in public to give public speeches I found a substantial decrease after November of 2020. This is coincidental with the fact that, during this time, Chile experienced a social uprising leading the government to an all-time minimun rate of public support according to **_CADEM_** [^3].

<p align="center">
<img src="/assets/graph1.png">
</p>  

In the second step I apply the structural topic modelling with the `stm` package. The stm packages allows the researcher to estimate a model using document covariates. In this case I used date to see how the proportion of topics varies across time (months). I choosed `Plotly` _(hosted in plotly studio: [Click here or image](https://chart-studio.plotly.com/~Andres1986/1.embed?share_key=hkHUmY5lfL9zZc8nYvfVga))_ to visualize topic trends over time. For instance, the topic of **_Security & Crime_** is a recurrent topic in the president's speeches. Coincidentally, this topic shows a proportion spike by the end of 2018 and 2019, when the government suffered from police brutality scandals, first for killing an unarmed indigenous civilian and then for police repression in the social upheaval.    

<p align="center">
<img src="/assets/captura.png">
</p>  

## Final Thoughts <a name="paragraph3"></a>

This exercise had no other purpose but to train coding skills and apply empirical methods to text data, and more specifically, to data that should be available to all citizens. However, it is important to point out that by the end of this project, **the speeches from president Piñera are no longer available in the Press website**. It is possible to access only speeches for the present month, without an option to access all the past speeches.

[^1]: https://github.com/salimk/Rcrawler

[^2]: https://github.com/tidyverse/rvest

[^3]: https://www.cadem.cl/
