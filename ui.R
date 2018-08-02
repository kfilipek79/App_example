#install.packages("shinydashboard")
#install.packages("plotly")
#install.packages("googleVis")
#install.packages("data.table")

library(plotly)
library(shinydashboard)
library(googleVis)
library(data.table)
library(shiny)
library(xtable)



header <- dashboardHeader(title = "BEZROBOCIE W UE")
sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem(text = "Zmienne", tabName = "main")
  ),
  selectInput(
    inputId =  "year", 
    label = " Wybierz rok:", 
    choices = 1995:2017
  ),
  radioButtons("age", "Wiek: ",
               c("< 25 lat" = "Y_LT25",
                 "> 25 lat" = "Y25-74",
                 "Razem" = "TOTAL")),
  uiOutput("ui"),
  htmlOutput("helptext")
)

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "main",
            fluidRow(
              tabBox(title="Dane Eurostat", id="tabs", height = "700px", width = "700px",
                     tabPanel("Graf", value="barplot", htmlOutput("gvisbarplot")),
                     tabPanel("Mapa", value="map", htmlOutput("maptitle"), htmlOutput("gvismap"), 
                              helpText("Szary obszar: brak danych")),
                     tabPanel("Graf roczny", value="contryplot",  htmlOutput("gviscontryplot")),
                     tabPanel("Wybrane parametry", value="values", 
                              h4("Wybrany rok:"), verbatimTextOutput("oyear"), 
                              h4("Wiek:"), verbatimTextOutput("oage"), 
                              h4("Wybrane państwo:"), verbatimTextOutput("ocountry")))
            )
            
    )
  )
  
)
dashboardPage(header, sidebar, body, skin = "blue")