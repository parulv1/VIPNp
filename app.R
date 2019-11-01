# Code from UserInterfaceCode.r will be copied and pasted into here. Input and output
# commands can be found on https://shiny.rstudio.com/. The user will first upload the
# .csv of their raw datam the model will be selected, the calculation will be run 
# from there.

library('shiny')
library(caret)
library(e1071)

ui <- fluidPage(
  titlePanel("Welcome to VIPNp!"),
  tags$p("Here, you can upload metabolite profile of patients. 
         On the right, you will get model prediction. 
         Probability greater than 0.7 implies high neuropathy. 
         If you have actual data, you can upload it as well to check the performance of our model.
         Note: Model will not accept missing data. Please estimate them before uploading your files."),
  fluidRow(
    column(4,
           wellPanel(
           fileInput('file1', 'Choose file to upload',
                     accept = c('.csv')
           ),
           selectInput(
             "select",
             label = p("Select time point"),
             choices = c(Choose='',"Day 8", "6 Months"),
             selected = NULL
           ),
           actionButton("goButton","Run Model"),
           fileInput('file2','Choose actual data', accept = c('.csv')),
           actionButton("goButton2","Compare results")
    )),
    column(3,
           tableOutput('prediction')
    ),
    column(5,
           verbatimTextOutput('confusionm'))
  )
)

server <- function(input, output) {
  load("Mean_day8.Rdata")
  load("sd_day8.Rdata")
  load("Mean_6mo.Rdata")
  load("sd_6mo.Rdata")
  FinalResult <- eventReactive(input$goButton,{
    inFile <- isolate(input$file1)
    inSelect <- isolate(input$select)
    if (is.null(inFile))
      return(NULL)
    metdatacsv <- read.csv(inFile$datapath, header = FALSE)
    n1 <- ncol(metdatacsv)
    metdata <- metdatacsv[,2:n1]
    if (inSelect=="Day 8"){
      MyModel <- readRDS("day8Final.rds")
      Data <- data.frame(scale(t(metdata),center=t(Mean_day8),scale=t(sd_day8)))
    }
    else{
      MyModel <- readRDS("mo6Final.rds")
      Data <- data.frame(scale(t(metdata),center=t(Mean_6mo),scale=t(sd_6mo)))
    }
    
    temp = predict(MyModel, newdata = Data, probability = TRUE)
    tempProbs <- attr(temp,"probabilities")
    threshold = 0.7
    prednew <- factor( ifelse(tempProbs[, "High"] > threshold, "High", "Low") )
    FinalResult1 <- data.frame(tempProbs[,1],prednew)
    names(FinalResult1) <- c('Probability','High/Low')
    FinalResult <- FinalResult1
  })
  
  actual <- eventReactive(input$goButton2,{
    validate(
      need(input$file2 != "", "")
    )
    inFile2 <- isolate(input$file2)
    actual <- read.csv(inFile2$datapath, header = FALSE)
    actual
  })
  
  observeEvent(input$goButton,{output$prediction <- renderTable({
    Results <- FinalResult()
    Results
  })
  # output$confusionm <- renderPrint({Confusionm <- ""
  # Confusionm})
  })
  
  observeEvent(input$goButton2,{output$confusionm <- renderPrint(isolate({
    Results <- FinalResult()
    actual1 <- actual()
    Confusionm <- confusionMatrix(Results$`High/Low`,actual1$V1)
    Confusionm
  }))})
}

shinyApp(ui = ui, server = server)

