#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application 
ui <- fluidPage(
   
   # Application title
   titlePanel("Funksjonell respons"),
   
   # Sidebar with a slider input
   sidebarLayout(
      sidebarPanel(
        h2("Simuler forskjellige parameterverdier for funksjonell respons type II"),
        p("Pannelene under endrer paramtrene a, T og h i funksjonell respons type II likninga."),
        p(""),
        p("E = (a*T*N) / (1 + (a*h*N))"),
        p("E er energi inn (en eller annen enhet for næringsinntak), a er angrepsraten, T er total tid brukt i søk etter bytte, Th er behandlingstid på hvert bytter og N er totalt antall bytte tilgjengelig (byttetetthet)"),
         sliderInput("a",
                     "Angrepsrate (a):",
                     min = 1,
                     max = 50,
                     value = 30),
         sliderInput("Ttot",
                     "Total tid brukt på byttesøk (T):",
                     min = 1,
                     max = 50,
                     value = 30),
         sliderInput("h",
                     "Håndteringstid for hvert bytte (h):",
                     min = 0.00000000001,
                     max = 0.1,
                     value = 0.05),
        p(""),
        p("Endre parametre i pannelet over og se resultatene på grafen til høyre (eller under i tilfelle mobilversjon)"),
        p("")
      ),
      
      # Show a plot 
      mainPanel(
         plotOutput("funcresp_plot")
      )
   )
)

# Define server logic 
server <- function(input, output) {
   
  output$funcresp_plot <- renderPlot({
    # generate values to plot based on input from ui.R
    N <- seq(from=0.01,to=100,by=1)
    an <- (input$a*input$Ttot*N) / (1 + (input$a*input$h*N))
    
    # draw the plot
    plot(N,an,type="l",xlab="(N) Mengde bytte",ylab="(E) næringsinntak",
         ylim=c(0,1000))
  })
      
}

# Run the application 
shinyApp(ui = ui, server = server)

