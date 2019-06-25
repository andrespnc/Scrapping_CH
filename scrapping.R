library(RSelenium)
library(wdman)

url <- 'https://www.contraloria.cl/web/cgr/buscar-jurisprudencia2'
server <- phantomjs(port=5000L)
browser <- remoteDriver(browserName = "phantomjs", port=5000L)
browser$open()
browser$navigate(url)

src <- browser$getPageSource()
substr(src, 1, 1000)
browser$screenshot(display=TRUE)

#select elements from the website
# municipales
state <- browser$findElement(using = 'id', value="muni-search")
state$sendKeysToElement(list("Municipales"))
browser$screenshot(display=TRUE)

#fecha
party <- browser$findElement(using = 'id', value="muni-search")
party$sendKeysToElement(list(01-06-2007:01-06-2010))
browser$screenshot(display=TRUE)

#enviar
send <- browser$findElement(using = 'id', value="enviar")
send$clickElement()
browser$screenshot(display=TRUE)