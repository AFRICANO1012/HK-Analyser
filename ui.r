
library(shiny)
library(shinydashboard)
library(shinythemes)
library(DT)
library(tidyverse)
library(highcharter)
library(dplyr)
library(magrittr)
library(rsconnect)
library(htmltools)
library(htmlwidgets)
library(shinyWidgets)

setBackgroundColor(
  color = "#FFA500",
  shinydashboard = TRUE
)

allthemes<-function(){
  themes <- dir(system.file("shinythemes/css", package = "shinythemes"), 
                "*.min.css")
  sub(".min.css", "", themes)
}

dashboardPage(
  skin = "yellow",
  dashboardHeader(
    title = "*HK Analyser*",
    dropdownMenu(
      type = "notifications",
      notificationItem(
        text = "Level of Significance = 5%",
        icon("info-circle"),
        status = "success"
      ),
      notificationItem(
        text = tags$p("Data Accuracy depends on that data cleaning ",tags$br("SACCO system")),
        icon("link"),
        status = "warning"
      )
    ),
    dropdownMenu(
      type = "messages",
      messageItem(
        from = "For Support",
        message = h6(tags$a(href = "mailto:afrinetanalytics@gmail.com","afrinetanalytics@gmail.com")),
        icon = icon("comments"),
        time = Sys.time()
      ),
      messageItem(
        from = "Researcher",
        message="BYAMUGISHA AFRICANO",
        icon = icon("hand-o-right")
      ),
      messageItem(
        from = "For Inquiries",
        message = "Submit to +256 706107619",
        icon = icon("question"),
        time = Sys.time()
      )
    )
  ),
  
  #SideBar setup
  dashboardSidebar(
    sidebarMenu(
      menuItem("DASHBOARD",tabName = "dashboard",icon = icon("dashboard"),badgeLabel ="Read Me",badgeColor = "red"
              
               ),
      
      menuItem("ANALYSIS",tabName = "analysis",icon = icon("bar-chart-o")
              
               ),
      
      menuItem("ABOUT",tabName = "about",icon = icon("th")
               
               )
    ),
 
      tags$div(
        h5(icon("accusoft")," Developed By :",style="text-align:center;"),
        h6(icon("laptop-code "),"Africano BYAMUGISHA",style="text-align:center;"),
        h6(icon("envelope-open-text  "),tags$a(href = "mailto:afrinetanalytics@gmail.com","africanobyamugisha12@gmail.com")),style="text-align:center;",
        div(tags$img(height=160,width=160,src="africano.png"),style="text-align:center;")
        )
  ),
  
  #Dashboard body setup
  dashboardBody(
    
    setBackgroundColor(
      color = "#90EE90",
      gradient = "radial",
      direction = "bottom",
      shinydashboard = TRUE
    ),
    
    h6("* (hk-sacco) *",
            icon("expeditedssl"),"copyright ",icon("at"),"afinet-analytics,2022\t",style="text-align:right;"),
    tabItems(
      #_____________________________________________________________________-
        tabItem(tabName = "dashboard",
              h3(icon("atom")," DASHBOARD ",style="text-align:center;"),
              tabsetPanel(
                tabPanel("Data Cleaning and Upload",icon = icon("data"),
                         tags$br(),
                         
                         sidebarLayout(
                           sidebarPanel(
                             background = "olive",
                             
                             fileInput(inputId = "datafile", label = "Upload The DataSet",accept = ".csv", placeholder = "Please Upload a dataset"),
                             
                             tags$br()  ,
                             height = 120,
                             background = "yellow",
                             tags$a(h3("*EffortLess Analysis For Your Comfort & with Creativity*",style="text-align:center;")),
                             div(tags$img(height="100%",width="90%",src="DA1.png"),style="text-align:center;"),
                             div(tags$br()),
                             
                             downloadButton("sample", label = "Get Sample Data",icon = shiny::icon("download"))
                           ),
                           mainPanel(
                             
                             title = "Data Cleaning Steps", status = "warning",
                             div(tags$h5("Step1: Open DataSet exported from the SACCO system in Excel")),
                             div(h5("Step2: Modify the Columns and Rows of the Dataset with respect to Attributes in the format shown in the Image")),
                             div(h5("Step3: Make Sure the Spelling and case of the Headers is exactly as shown in the image")),
                             div(h5("Step4: Save the Edited file as a csv.")),
                             div(h5("Step5: And then you can Upload the Data To the System")),
                             
                             div(h4("DataSet Format",style="text-align:center;"),
                                 tags$img(height="100%",width="90%",src="FORMAT.png"),style="text-align:left;")
                           )
                         ),
                         
                         
                         
                         
                         
                         
                ),
                tabPanel("View Uploaded Data",icon = icon("car"),
                         tags$br(),
                         
                         fluidPage(
                           dataTableOutput("head"),
                         ),
                         tags$br(),
                         downloadButton(outputId = "RawData",label = "Download Data File")
                    )
                  )
  
               ),
        #___________________________________________________________________-
        tabItem(tabName = "analysis",
                h3(icon("baby-carriage")," ANALYSIS ",style="text-align:center;"),
                fluidPage(
                  tabsetPanel(
                    tabPanel("Share Amount",icon = icon("line-chart"),
                             highchartOutput("S_Amount"),
                             
                             
                    ),
                    tabPanel("Number Of Shares",icon = icon("gg-circle"),
                             highchartOutput("S_Number"),
                             
                    ),
                    tabPanel("Share Value",icon = icon("table"),
                             highchartOutput("S_Value"),
                            
                    ),
                    tabPanel("Correlation",icon = icon("houzz"),
                             highchartOutput("S_Correlation"),
                             
                    ),
                    tabPanel("Description",icon = icon("safari"),
                             
                             DTOutput ("Describe"),
                             
                             
                    ),
                    tabPanel("Interest Rate",icon = icon("sellsy"),
                             highchartOutput("S_Interest"),
                             
                    )
                  )
                )
              ),
  #_______________________________________________________________________    
        tabItem(tabName = "about",
                h3(icon("th")," COMPANY ",style="text-align:center;"),
                div(
                  tags$h3(
                    tags$a(href="https://bit.ly/31vM9LF", "* Afrinet Analytics*"),
                    class = "text-center", style = "padding-top: 0;color:#8B0000; font-weight:600;",
                    tags$img(height="100%%",width="100%%", src="afrinet website header.png"),
            )
        ),
        
        h3(icon("user")," DEVELOPER ",style="text-align:center;"),
        div(
          tags$h3(
            tags$a(href="https://ug.linkedin.com/in/africanobyamugisha?trk=profile-badge", " > Africano BYAMUGISHA <"),
            class="badge-base LI-profile-badge : text-center", style = "padding-top: 0;color:#8B0000; font-weight:600;",
          )
        )
      )
    )
  )
)