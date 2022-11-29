library(shiny)

library(shinylogs)
library(rjson)

ui=fluidPage(
  
  tags$head(tags$script('
                                var dimension = [0, 0];
                                $(document).on("shiny:connected", function(e) {
                                    dimension[0] = window.innerWidth;
                                    dimension[1] = window.innerHeight;
                                    Shiny.onInputChange("dimension", dimension);
                                });
                                $(window).resize(function(e) {
                                    dimension[0] = window.innerWidth;
                                    dimension[1] = window.innerHeight;
                                    Shiny.onInputChange("dimension", dimension);
                                });
                            ')),
  
  theme = "bootstrap.min.css",
  #starting page of the experiment, demographic data and group sorting
  
  
  
  
  tabsetPanel(
                     id = "conditions",
                    
                     
                     tabPanel("Decorative static pictures", 
                              sidebarLayout(mainPanel(br(),
                                                      h1("Der Kometenschweif", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                      br(),
                                                      h4("Kometenschweife gehören zu den eindrucksvollsten astronomischen Erscheinungen.
                Eine interessante Frage ist, in welche Richtung sie weisen. Manchmal haben Kometen 
                sogar einen doppelten Schweif, einen aus glühendem, ionisiertem Gas und einen Staubschweif. 
                Beide zeigen grundsätzlich dasselbe Richtungsverhalten, ebenso wie Kometen mit nur einem 
                Schweif: immer von der Sonne weg. Die folgenden Überlegungen gelten nur für den Gasschweif.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"), 
                                                      h4("Für die Alltagserwartung könne die Richtung eines Kometenschweifes in die gleiche Richtung 
                weisen, wie der eines gallopierenden Pferdes. Der Schweif weist in diesem Beispiel durch 
                den Fahrtwind entgegen der Bewegungsrichtung. Ein erhebliches Problem stellt bei näherer Betrachtung dieses Beispiels jedoch die Umgebung 
                dar. Astronaut*innen tragen im Weltall Weltraumanzüge, weil es keine Luft zum atmen gibt. 
                Gibt es aber keine Luft, gibt es aber auch keinen Fahrtwind in dem sich der Kometenschweif 
                verhalten könnte wie der Pferdeschweif.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                      
                                                      h4("Man stellt aber fest, dass die Helligkeit von Kometenschweifen weit weg von der Sonne 
                praktisch Null ist, und mit zunehmender Annäherung an die Sonne immer größer wird. 
                Die von der Sonne ausgehende Lichtstrahlung reicht zur Erklärung des Gasschweifes nicht aus. 
                Damit wird die einfache Vorstellung Kometenschweif - Pferdeschweif unter einer 
                Voraussetzung wieder eher denkbar. Es muss etwas in der Nähe der Sonne geben, das den 
                Kometenschweif auslöst, und das mit zunehmender Nähe zu Sonne mehr wird; außer der 
                elektromagnetischen Strahlung gehen von einem heißen Körper auch Teilchen aus, die dafür 
                in Frage kommen. Das wäre der Sonnenwind – zunächst eine Hypothese – durch den der Komet 
                fliegt, und der den Gasschweif durch Stöße auslöst und zum Leuchten bringt.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                      h4("Bis zu dieser Stelle haben wir (in einfachster Form) den Grundgedanken einer bedeutenden 
                astrophysikalischen Entdeckung nachvollzogen, nämlich die Vorhersage der Existenz des 
                Sonnenwindes durch L. Biermann (1951; experimenteller Nachweis 1959). Es gibt also doch eine Art Wind im Sonnensystem, der den Kometenschweif 
                   hervorruft (nämlich den Sonnenwind). Für das Verhältnis der Geschwindigkeiten 
                   von Sonnenwind und Komet ist die Tatsache, dass der Schweif immer von der Sonne 
                   weggerichtet ist von großer Bedeutung. Da die Teilchen des Schweifes durch den 
                   Sonnenwind immer von der Sonne weggeblasen waren – unabhängig von der 
                   Bewegungsrichtung des Kometen – muss die Geschwindigkeit des Sonnenwindes viel 
                   größer als die des Kometen sein.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                      br(),
                                                      h4("Quelle: Biermann, L. (1951). Kometenschweife und solare Korpuskularstrahlung.", em("Zeitschrift fur Astrophysik,"), "29, 274-286.", 
                                                         style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                      br(),
                                                      h4("Überlegen Sie:", style = "font-family: Times New Roman; line-height: 1.5;", width= "100%"), 
                                                      h4("Wie passen die Bilder zum Lerntext? Nutzen Sie bitte die Fragen und darunter liegenden Optionen.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                      br(),
                                                      fluidRow(column(12, h4(radioButtons("refl1_dec_stat", h4("1. Wie verändern sich Bewegungsrichtungen von Schweifen?",
                                                                                                      style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                                                          choices = sample(list("Die Bewegungsrichtungen von Schweifen verändern sich mit Richtungsänderungen	eines Kometen oder Tiers.",
                                                                                                                "Die Bewegungsrichtungen von Schweifen können sich sowohl abhängig als auch unabhängig verändern.",
                                                                                                                "Die Bewegungsrichtungen von Schweifen verändern sich unabhängig vom Kometen	oder Tier.")),
                                                                                          selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))), 
                                                      
                                                      fluidRow(column(12, h4(radioButtons("refl2_dec_stat", h4("2. Denken Sie an Schweife von Pferden oder Rauchschwaden, 
                                                         wie können Sie diese mit Kometen verbinden?", 
                                                                                                      style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                                                          choices = sample(list("Der Fahrtwind ist ein zentrales Konzept für die Bewegung von Rauchschwaden und 	Schweifen und besteht im All durch den Sonnenwind.",
                                                                                                                "Die Zusammensetzung des Schweifs oder der Rauchschwaden ist ein zentrales Konzept für die Bewegung selbiger, ebenso wie von Kometen.",
                                                                                                                "Die Form von Schweifen ist ein zentrales Konzept für deren Bewegung und trifft ebenfalls auf Kometen zu.")), 
                                                                                          selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))),
                                                      fluidRow(column(12, h4(radioButtons("refl3_dec_stat", h4("3. Denken Sie an Kometenschweife, wie richten sie sich aus und wie
                                                          können Sie diese Überlegungen mit Alltagsbeispielen verbinden?", 
                                                                                                      style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"), 
                                                                                          choices = sample(list("Kometenschweife richten sich nach dem Sonnenwind aus, ähnlich der Rauchschwaden eines Dampfschiffs im Fahrtwind.", 
                                                                                                                "Kometenschweife haben keine festgelegte Ausrichtung und sind spontan sichtbar, ähnlich eines Blitzes bei Gewitter.", 
                                                                                                                "Kometenschweife sind zu sehen, wenn sie nahe der Sonne verglühen, ähnlich verbrennender Partikel am Kerzendocht.")),
                                                                                          selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))), 
                                                      br(),
                                                      br(),
                                                      conditionalPanel(condition= "input.continue4", actionButton("continue5_dec_stat", h4("Weiter", style = "font-family: Times New Roman; font-weight: 200; color: black; border: 2px black"),
                                                                                                                  style= "float: left",class="btn btn-outline-secondary")),
                                                      width = 7),
                                            
                                            sidebarPanel(br(),
                                                         h4("Betrachten Sie die verschiedenen Optionen:", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                         imageOutput("Komet"),
                                                         br(),
                                                         br(),
                                                         br(),
                                                         br(),
                                                         br(),
                                                         br(),
                                                         br(),
                                                         br(),
                                                         br(),
                                                         br(), width = 5
                                            )))
                     ,
                     tabPanel("Decorative interactive pictures", 
                              
                              mainPanel(br(),
                                        h1("Der Kometenschweif", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Kometenschweife gehören zu den eindrucksvollsten astronomischen Erscheinungen.
                Eine interessante Frage ist, in welche Richtung sie weisen. Manchmal haben Kometen 
                sogar einen doppelten Schweif, einen aus glühendem, ionisiertem Gas und einen Staubschweif. 
                Beide zeigen grundsätzlich dasselbe Richtungsverhalten, ebenso wie Kometen mit nur einem 
                Schweif: immer von der Sonne weg. Die folgenden Überlegungen gelten nur für den Gasschweif.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"), 
                                        h4("Für die Alltagserwartung könne die Richtung eines Kometenschweifes in die gleiche Richtung 
                weisen, wie der eines gallopierenden Pferdes. Der Schweif weist in diesem Beispiel durch 
                den Fahrtwind entgegen der Bewegungsrichtung. Ein erhebliches Problem stellt bei näherer Betrachtung dieses Beispiels jedoch die Umgebung 
                dar. Astronaut*innen tragen im Weltall Weltraumanzüge, weil es keine Luft zum atmen gibt. 
                Gibt es aber keine Luft, gibt es aber auch keinen Fahrtwind in dem sich der Kometenschweif 
                verhalten könnte wie der Pferdeschweif.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        
                                        h4("Man stellt aber fest, dass die Helligkeit von Kometenschweifen weit weg von der Sonne 
                praktisch Null ist, und mit zunehmender Annäherung an die Sonne immer größer wird. 
                Die von der Sonne ausgehende Lichtstrahlung reicht zur Erklärung des Gasschweifes nicht aus. 
                Damit wird die einfache Vorstellung Kometenschweif - Pferdeschweif unter einer 
                Voraussetzung wieder eher denkbar. Es muss etwas in der Nähe der Sonne geben, das den 
                Kometenschweif auslöst, und das mit zunehmender Nähe zu Sonne mehr wird; außer der 
                elektromagnetischen Strahlung gehen von einem heißen Körper auch Teilchen aus, die dafür 
                in Frage kommen. Das wäre der Sonnenwind – zunächst eine Hypothese – durch den der Komet 
                fliegt, und der den Gasschweif durch Stöße auslöst und zum Leuchten bringt.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        h4("Bis zu dieser Stelle haben wir (in einfachster Form) den Grundgedanken einer bedeutenden 
                astrophysikalischen Entdeckung nachvollzogen, nämlich die Vorhersage der Existenz des 
                Sonnenwindes durch L. Biermann (1951; experimenteller Nachweis 1959). Es gibt also doch eine Art Wind im Sonnensystem, der den Kometenschweif 
                   hervorruft (nämlich den Sonnenwind). Für das Verhältnis der Geschwindigkeiten 
                   von Sonnenwind und Komet ist die Tatsache, dass der Schweif immer von der Sonne 
                   weggerichtet ist von großer Bedeutung. Da die Teilchen des Schweifes durch den 
                   Sonnenwind immer von der Sonne weggeblasen waren – unabhängig von der 
                   Bewegungsrichtung des Kometen", "–", "muss die Geschwindigkeit des Sonnenwindes viel 
                   größer als die des Kometen sein.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Quelle: Biermann, L. (1951). Kometenschweife und solare Korpuskularstrahlung.", em("Zeitschrift fur Astrophysik,"), "29, 274-286.", 
                                           style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Überlegen Sie:", style = "font-family: Times New Roman; line-height: 1.5;", width= "100%"), 
                                        h4("Wie passen die Bilder zum Lerntext? Nutzen Sie bitte die Fragen und darunter liegenden Optionen.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                        br(),
                                        fluidRow(column(12, h4(radioButtons("refl1_dec_int", h4("1. Wie verändern sich Bewegungsrichtungen von Schweifen?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                                            choices = sample(list("Die Bewegungsrichtungen von Schweifen verändern sich mit Richtungsänderungen	eines Kometen oder Tiers.",
                                                                                                  "Die Bewegungsrichtungen von Schweifen können sich sowohl abhängig als auch unabhängig verändern.",
                                                                                                  "Die Bewegungsrichtungen von Schweifen verändern sich unabhängig vom Kometen	oder Tier.")),
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))), 
                                        
                                        fluidRow(column(12, h4(radioButtons("refl2_dec_int", h4("2. Denken Sie an Schweife von Pferden oder Rauchschwaden, 
                                                         wie können Sie diese mit Kometen verbinden?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                                            choices = sample(list("Der Fahrtwind ist ein zentrales Konzept für die Bewegung von Rauchschwaden und 	Schweifen und besteht im All durch den Sonnenwind.",
                                                                                                  "Die Zusammensetzung des Schweifs oder der Rauchschwaden ist ein zentrales Konzept für die Bewegung selbiger, ebenso wie von Kometen.",
                                                                                                  "Die Form von Schweifen ist ein zentrales Konzept für deren Bewegung und trifft ebenfalls auf Kometen zu.")), 
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))),
                                        fluidRow(column(12, h4(radioButtons("refl3_dec_int", h4("3. Denken Sie an Kometenschweife, wie richten sie sich aus und wie
                                                          können Sie diese Überlegungen mit Alltagsbeispielen verbinden?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"), 
                                                                            choices = sample(list("Kometenschweife richten sich nach dem Sonnenwind aus, ähnlich der Rauchschwaden eines Dampfschiffs im Fahrtwind.", 
                                                                                                  "Kometenschweife haben keine festgelegte Ausrichtung und sind spontan sichtbar, ähnlich eines Blitzes bei Gewitter.", 
                                                                                                  "Kometenschweife sind zu sehen, wenn sie nahe der Sonne verglühen, ähnlich verbrennender Partikel am Kerzendocht.")),
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))), 
                                        br(),
                                        br(),
                                        conditionalPanel(condition= "input.continue4", actionButton("continue5_dec_int", h4("Weiter", style = "font-family: Times New Roman; font-weight: 200; color: black; border: 2px black"),
                                                                                                    style= "float: left",class="btn btn-outline-secondary")),
                                        width = 7),
                              
                              sidebarPanel(br(),
                                           h4("Betrachten Sie die verschiedenen Optionen.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                           fluidRow(column(7, h4(selectInput("image", h4("Bitte wählen Sie aus:", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                             choices= c(" " = "none" ,"Fotorealistisch" = "FOT", "Abstrakt" = "ABS", "Astronautin" = "AST", "'Erd'-Beispiel" = "ERD"),
                                                                             selected = "none"), style = "font-family: Times New Roman; font-weight: 100;"))),
                                           
                                           conditionalPanel(condition= "input.image == 'FOT'",
                                                            imageOutput("Komet1")),
                                           conditionalPanel(condition= "input.image == 'ABS'",
                                                            imageOutput("Komet2")),
                                           conditionalPanel(condition= "input.image == 'AST'",
                                                            imageOutput("Komet3")),
                                           conditionalPanel(condition= "input.image == 'ERD'",
                                                            imageOutput("Komet4")),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(), width = 5
                                           
                              ))
                     
                     ,
                     tabPanel("Informative static pictures", 
                              
                              mainPanel(br(),
                                        h1("Der Kometenschweif", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Kometenschweife gehören zu den eindrucksvollsten astronomischen Erscheinungen.
                Eine interessante Frage ist, in welche Richtung sie weisen. Manchmal haben Kometen 
                sogar einen doppelten Schweif, einen aus glühendem, ionisiertem Gas und einen Staubschweif. 
                Beide zeigen grundsätzlich dasselbe Richtungsverhalten, ebenso wie Kometen mit nur einem 
                Schweif: immer von der Sonne weg. Die folgenden Überlegungen gelten nur für den Gasschweif.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"), 
                                        h4("Für die Alltagserwartung könne die Richtung eines Kometenschweifes in die gleiche Richtung 
                weisen, wie der eines gallopierenden Pferdes. Der Schweif weist in diesem Beispiel durch 
                den Fahrtwind entgegen der Bewegungsrichtung. Ein erhebliches Problem stellt bei näherer Betrachtung dieses Beispiels jedoch die Umgebung 
                dar. Astronaut*innen tragen im Weltall Weltraumanzüge, weil es keine Luft zum atmen gibt. 
                Gibt es aber keine Luft, gibt es aber auch keinen Fahrtwind in dem sich der Kometenschweif 
                verhalten könnte wie der Pferdeschweif.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        
                                        h4("Man stellt aber fest, dass die Helligkeit von Kometenschweifen weit weg von der Sonne 
                praktisch Null ist, und mit zunehmender Annäherung an die Sonne immer größer wird. 
                Die von der Sonne ausgehende Lichtstrahlung reicht zur Erklärung des Gasschweifes nicht aus. 
                Damit wird die einfache Vorstellung Kometenschweif - Pferdeschweif unter einer 
                Voraussetzung wieder eher denkbar. Es muss etwas in der Nähe der Sonne geben, das den 
                Kometenschweif auslöst, und das mit zunehmender Nähe zu Sonne mehr wird; außer der 
                elektromagnetischen Strahlung gehen von einem heißen Körper auch Teilchen aus, die dafür 
                in Frage kommen. Das wäre der Sonnenwind – zunächst eine Hypothese – durch den der Komet 
                fliegt, und der den Gasschweif durch Stöße auslöst und zum Leuchten bringt.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        h4("Bis zu dieser Stelle haben wir (in einfachster Form) den Grundgedanken einer bedeutenden 
                astrophysikalischen Entdeckung nachvollzogen, nämlich die Vorhersage der Existenz des 
                Sonnenwindes durch L. Biermann (1951; experimenteller Nachweis 1959). Es gibt also doch eine Art Wind im Sonnensystem, der den Kometenschweif 
                   hervorruft (nämlich den Sonnenwind). Für das Verhältnis der Geschwindigkeiten 
                   von Sonnenwind und Komet ist die Tatsache, dass der Schweif immer von der Sonne 
                   weggerichtet ist von großer Bedeutung. Da die Teilchen des Schweifes durch den 
                   Sonnenwind immer von der Sonne weggeblasen waren – unabhängig von der 
                   Bewegungsrichtung des Kometen – muss die Geschwindigkeit des Sonnenwindes viel 
                   größer als die des Kometen sein.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Quelle: Biermann, L. (1951). Kometenschweife und solare Korpuskularstrahlung.", em("Zeitschrift fur Astrophysik,"), "29, 274-286.", 
                                           style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Überlegen Sie:", style = "font-family: Times New Roman; line-height: 1.5;", width= "100%"), 
                                        h4("Wie passen die Bilder zum Lerntext? Nutzen Sie bitte die Fragen und darunter liegenden Optionen.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                        br(),
                                        fluidRow(column(12, h4(radioButtons("refl1_inf_stat", h4("1. Wie verändern sich Bewegungsrichtungen von Schweifen?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                                            choices = sample(list("Die Bewegungsrichtungen von Schweifen verändern sich mit Richtungsänderungen	eines Kometen oder Tiers.",
                                                                                                  "Die Bewegungsrichtungen von Schweifen können sich sowohl abhängig als auch unabhängig verändern.",
                                                                                                  "Die Bewegungsrichtungen von Schweifen verändern sich unabhängig vom Kometen	oder Tier.")),
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))), 
                                        
                                        fluidRow(column(12, h4(radioButtons("refl2_inf_stat", h4("2. Denken Sie an Schweife von Pferden oder Rauchschwaden, 
                                                         wie können Sie diese mit Kometen verbinden?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                                            choices = sample(list("Der Fahrtwind ist ein zentrales Konzept für die Bewegung von Rauchschwaden und 	Schweifen und besteht im All durch den Sonnenwind.",
                                                                                                  "Die Zusammensetzung des Schweifs oder der Rauchschwaden ist ein zentrales Konzept für die Bewegung selbiger, ebenso wie von Kometen.",
                                                                                                  "Die Form von Schweifen ist ein zentrales Konzept für deren Bewegung und trifft ebenfalls auf Kometen zu.")), 
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))),
                                        fluidRow(column(12, h4(radioButtons("refl3_inf_stat", h4("3. Denken Sie an Kometenschweife, wie richten sie sich aus und wie
                                                          können Sie diese Überlegungen mit Alltagsbeispielen verbinden?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"), 
                                                                            choices = sample(list("Kometenschweife richten sich nach dem Sonnenwind aus, ähnlich der Rauchschwaden eines Dampfschiffs im Fahrtwind.", 
                                                                                                  "Kometenschweife haben keine festgelegte Ausrichtung und sind spontan sichtbar, ähnlich eines Blitzes bei Gewitter.", 
                                                                                                  "Kometenschweife sind zu sehen, wenn sie nahe der Sonne verglühen, ähnlich verbrennender Partikel am Kerzendocht.")),
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))),
                                        br(),
                                        br(),
                                        conditionalPanel(condition= "input.continue4", actionButton("continue5_inf_stat", h4("Weiter", style = "font-family: Times New Roman; font-weight: 200; color: black; border: 2px black"),
                                                                                                    style= "float: left",class="btn btn-outline-secondary"))
                                        , width = 7),
                              
                              sidebarPanel(br(),
                                           h4("Betrachten Sie die verschiedenen Zeitpunkte:", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                           imageOutput("Kometen_inf"),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(), width = 5
                              ))
                     
                     ,
                     tabPanel("Informative interactive pictures", 
                              
                              mainPanel(br(),
                                        h1("Der Kometenschweif", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Kometenschweife gehören zu den eindrucksvollsten astronomischen Erscheinungen.
                Eine interessante Frage ist, in welche Richtung sie weisen. Manchmal haben Kometen 
                sogar einen doppelten Schweif, einen aus glühendem, ionisiertem Gas und einen Staubschweif. 
                Beide zeigen grundsätzlich dasselbe Richtungsverhalten, ebenso wie Kometen mit nur einem 
                Schweif: immer von der Sonne weg. Die folgenden Überlegungen gelten nur für den Gasschweif.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"), 
                                        h4("Für die Alltagserwartung könne die Richtung eines Kometenschweifes in die gleiche Richtung 
                                            weisen, wie der eines gallopierenden Pferdes. Der Schweif weist in diesem Beispiel durch 
                den Fahrtwind entgegen der Bewegungsrichtung. Ein erhebliches Problem stellt bei näherer Betrachtung dieses Beispiels jedoch die Umgebung 
                dar. Astronaut*innen tragen im Weltall Weltraumanzüge, weil es keine Luft zum atmen gibt. 
                Gibt es aber keine Luft, gibt es aber auch keinen Fahrtwind in dem sich der Kometenschweif 
                verhalten könnte wie der Pferdeschweif.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        
                                        h4("Man stellt aber fest, dass die Helligkeit von Kometenschweifen weit weg von der Sonne 
                praktisch Null ist, und mit zunehmender Annäherung an die Sonne immer größer wird. 
                Die von der Sonne ausgehende Lichtstrahlung reicht zur Erklärung des Gasschweifes nicht aus. 
                Damit wird die einfache Vorstellung Kometenschweif - Pferdeschweif unter einer 
                Voraussetzung wieder eher denkbar. Es muss etwas in der Nähe der Sonne geben, das den 
                Kometenschweif auslöst, und das mit zunehmender Nähe zu Sonne mehr wird; außer der 
                elektromagnetischen Strahlung gehen von einem heißen Körper auch Teilchen aus, die dafür 
                in Frage kommen. Das wäre der Sonnenwind – zunächst eine Hypothese – durch den der Komet 
                fliegt, und der den Gasschweif durch Stöße auslöst und zum Leuchten bringt.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        h4("Bis zu dieser Stelle haben wir (in einfachster Form) den Grundgedanken einer bedeutenden 
                astrophysikalischen Entdeckung nachvollzogen, nämlich die Vorhersage der Existenz des 
                Sonnenwindes durch L. Biermann (1951; experimenteller Nachweis 1959). Es gibt also doch eine Art Wind im Sonnensystem, der den Kometenschweif 
                   hervorruft (nämlich den Sonnenwind). Für das Verhältnis der Geschwindigkeiten 
                   von Sonnenwind und Komet ist die Tatsache, dass der Schweif immer von der Sonne 
                   weggerichtet ist von großer Bedeutung. Da die Teilchen des Schweifes durch den 
                   Sonnenwind immer von der Sonne weggeblasen waren – unabhängig von der 
                   Bewegungsrichtung des Kometen – muss die Geschwindigkeit des Sonnenwindes viel 
                   größer als die des Kometen sein.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Quelle: Biermann, L. (1951). Kometenschweife und solare Korpuskularstrahlung.", em("Zeitschrift fur Astrophysik,"), "29, 274-286.", 
                                           style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                        br(),
                                        h4("Überlegen Sie:", style = "font-family: Times New Roman; line-height: 1.5;", width= "100%"), 
                                        h4("Wie passen die Bilder zum Lerntext? Nutzen Sie bitte die Fragen und darunter liegenden Optionen.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                        br(),
                                        fluidRow(column(12, h4(radioButtons("refl1_inf_int", h4("1. Wie verändern sich Bewegungsrichtungen von Schweifen?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                                            choices = sample(list("Die Bewegungsrichtungen von Schweifen verändern sich mit Richtungsänderungen	eines Kometen oder Tiers.",
                                                                                                  "Die Bewegungsrichtungen von Schweifen können sich sowohl abhängig als auch unabhängig verändern.",
                                                                                                  "Die Bewegungsrichtungen von Schweifen verändern sich unabhängig vom Kometen	oder Tier.")),
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))), 
                                        
                                        fluidRow(column(12, h4(radioButtons("refl2_inf_int", h4("2. Denken Sie an Schweife von Pferden oder Rauchschwaden, 
                                                         wie können Sie diese mit Kometen verbinden?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"),
                                                                            choices = sample(list("Der Fahrtwind ist ein zentrales Konzept für die Bewegung von Rauchschwaden und 	Schweifen und besteht im All durch den Sonnenwind.",
                                                                                                  "Die Zusammensetzung des Schweifs oder der Rauchschwaden ist ein zentrales Konzept für die Bewegung selbiger, ebenso wie von Kometen.",
                                                                                                  "Die Form von Schweifen ist ein zentrales Konzept für deren Bewegung und trifft ebenfalls auf Kometen zu.")), 
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))),
                                        fluidRow(column(12, h4(radioButtons("refl3_inf_int", h4("3. Denken Sie an Kometenschweife, wie richten sie sich aus und wie
                                                          können Sie diese Überlegungen mit Alltagsbeispielen verbinden?", 
                                                                                        style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;", width= "100%"), 
                                                                            choices = sample(list("Kometenschweife richten sich nach dem Sonnenwind aus, ähnlich der Rauchschwaden eines Dampfschiffs im Fahrtwind.", 
                                                                                                  "Kometenschweife haben keine festgelegte Ausrichtung und sind spontan sichtbar, ähnlich eines Blitzes bei Gewitter.", 
                                                                                                  "Kometenschweife sind zu sehen, wenn sie nahe der Sonne verglühen, ähnlich verbrennender Partikel am Kerzendocht.")),
                                                                            selected = "default", width = "100%"), style = "font-family: Times New Roman; font-weight: 100;", width = "100%"))),
                                        br(),
                                        br(),
                                        conditionalPanel(condition= "input.continue4", actionButton("continue5_inf_int", h4("Weiter", style = "font-family: Times New Roman; font-weight: 200; color: black; border: 2px black"),
                                                                                                    style= "float: left",class="btn btn-outline-secondary")), width = 7),
                              
                              sidebarPanel(br(),
                                           h4("Betrachten Sie die verschiedenen Zeitpunkte.", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                           fluidRow(column(5, h4(selectInput("time", h4("Bitte wählen Sie aus:", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                             choices = c(" " = "no","01.12.1973"= "T1", "01.01.1974"= "T2", "01.02.1974"= "T3"),
                                                                             selected = "no"), style = "font-family: Times New Roman; font-weight: 100;"))),
                                           conditionalPanel(condition= "input.time == 'T1'",
                                                            imageOutput("Komet_inf_1")),
                                           conditionalPanel(condition= "input.time == 'T2'",
                                                            imageOutput("Komet_inf_2")),
                                           conditionalPanel(condition= "input.time == 'T3'",
                                                            imageOutput("Komet_inf_3")),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(),
                                           br(), width = 5
                              )
                   ), 
                   tags$script(" $(document).ready(function () {          $('#continue5_dec_stat').on('click', function (f) {           window.scrollTo(0, 0)                });                 });"),
                   tags$script(" $(document).ready(function () {          $('#continue5_dec_int').on('click', function (h) {           window.scrollTo(0, 0)                });                 });"),
                   tags$script(" $(document).ready(function () {          $('#continue5_inf_stat').on('click', function (j) {           window.scrollTo(0, 0)                });                 });"),
                   tags$script(" $(document).ready(function () {          $('#continue5_inf_int').on('click', function (k) {           window.scrollTo(0, 0)                });                 });")),
  

)

# Define server logic required to draw a histogram
server= function(input, output, session){
  
  track_usage(storage_mode = store_json(path = "logs/"))
  
  output$dimension_display <- renderText({
    paste(input$dimension[1], input$dimension[2], input$dimension[2]/input$dimension[1])
  })
  
  numbers <- 0 
  # observe button 1 press. 
  observeEvent(session$clientData, { 
    #input$randomCond
    numbers1 <- seq(1:4)
    numbers <- sample(numbers1, 1, replace = FALSE)
    switch_page(numbers)
  })
  
  output$numbers <- renderDataTable(numbers[0])
  
  switch_page <- function(i) {
    updateTabsetPanel(inputId = "confirmation", selected = paste0("condition_", i))
    updateTabsetPanel(inputId = "conditions", selected = paste0("page_", i))
    
  }
  
  
  # first group decorative static image
  output$Komet<- renderImage(
    {list(src= "image_dec/Komet_stat_dek.PNG",
          height= "550px",
          width= "550px")},
    deleteFile = FALSE
  )
  
  
  # second group informative static image
  output$Kometen_inf <- renderImage(
    
    {list(src="image_inf/Kometinf_stat_new.png",
          height= "550px",
          width= "550px")},
    deleteFile= FALSE
  ) 
  # third group decorative interactive images  
  output$Komet1 <- renderImage(
    {list(src="images_decI/Komet1_dek.png",
          height= "550px",
          width= "550px")},
    deleteFile=FALSE
  )
  output$Komet2<- renderImage(
    {list(src="images_decI/Komet2_dek.png",
          height= "550px",
          width= "550px")},
    deleteFile=FALSE
  )
  output$Komet3<- renderImage(
    {list(src="images_decI/Komet3_dek.png",
          height= "550px",
          width= "550px")},
    deleteFile=FALSE
  )
  output$Komet4<- renderImage(
    {list(src="images_decI/Komet4_dek.png",
          height= "550px",
          width= "550px")},
    deleteFile=FALSE
  )  
  #fourth group informative interactive images
  output$Komet_inf_1 <- renderImage(
    {list(src=("images_infI/Komet1_inf_int_new.png"),
          height= "550px",
          width= "550px")},
    deleteFile= FALSE
    
  )
  output$Komet_inf_2 <- renderImage(
    {list(src=("images_infI/Komet2_inf_int_new.PNG"),
          height= "550px",
          width= "550px")},
    deleteFile= FALSE
    
  )
  output$Komet_inf_3 <- renderImage(
    {list(src=("images_infI/Komet3_inf_int_new.PNG"),
          height= "550px",
          width= "550px")},
    deleteFile= FALSE
    
  )
  
  output$battery1 <- renderUI(fluidRow(column(12, h4(radioButtons("PW1", h4("1. Wie viele Schweife hat ein Komet und wie lassen sich diese beschreiben?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                  choices= sample(list("Bis zu zwei - einen Gasschweif und einen Staubschweif.", 
                                                                                       "Bis zu drei - einen Glühschweif, einen Gasschweif und einen Staubschweif.", 
                                                                                       "Bis zu drei - drei Staubschweife mit verschiedenen Zusammensetzungen.", 
                                                                                       "Bis zu zwei - zwei Gasschweife aus verschiedenen Gasen.")),
                                                                  selected = "default",
                                                                  width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery2<- renderUI(fluidRow(column(12, h4(radioButtons("PW2", h4("2. Was stimmt im Unterschied zur alltäglichen Intuition für die Richtung eines Kometenschweifes?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                 choices= sample(list("Hinter dem Kometen.", 
                                                                                      "Vor dem Kometen.", 
                                                                                      "In Richtung der Sonne.", 
                                                                                      "In entgegengesetzter Richtung der Sonne.")),
                                                                 selected = "default",
                                                                 width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery3<- renderUI(fluidRow(column(12, h4(radioButtons("PW3", h4("3. Warum könnten Pferdeschweife ein alltägliches Beispiel für Kometenschweife sein?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                 choices= sample(list("Weil sie ähnliche Bewegungseigenschaften zu besitzen scheinen.", 
                                                                                      "Weil sie die gleiche chemische Zusammensetzung besitzen.", 
                                                                                      "Weil sie gleich aussehen.", 
                                                                                      "Weil sie die gleiche Bezeichnung tragen.")),
                                                                 selected = "default",
                                                                 width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery4<- renderUI(fluidRow(column(12, h4(radioButtons("PW4", h4("4. Kometenschweife zeigen ein unerwartetes Richtungsverhalten, inwiefern 
                                                          betrifft das die Schweife?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                 choices= c("Es gibt einen Schweif, der ein unabhängiges Richtungsverhalten hat.", 
                                                                            "Die Schweife zeigen das gleiche Richtungsverhalten.",
                                                                            "Die Schweife zeigen ein entgegengesetztes Richtungsverhalten.", 
                                                                            "Das Richtungsverhalten der Schweife ist voneinander unabhängig."),
                                                                 selected = "default",
                                                                 width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery5<- renderUI(fluidRow(column(12, h4(radioButtons("PW5", h4("5. Astronaut*innen tragen Weltraumanzüge, weil es dort keine Luft gibt. 
                                                          Wieso ist das ein Problem für die Idee ‘Kometenschweif = Pferdeschweif?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                 choices= sample(list("Weil es keinen Fahrtwind gibt, in dem der Kometenschweif wehen könnte.", 
                                                                                      "Weil sich der Komet ohne Wind nicht bewegen kann.", 
                                                                                      "Weil sich der Komet nicht selbstständig bewegt.",
                                                                                      "Weil es im All extrem kalt ist und der heiße Komet verglüht.")),
                                                                 selected = "default",
                                                                 width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery6<- renderUI(fluidRow(column(12, h4(radioButtons("PW6", h4("6. Das von der Sonne ausgehende Licht reicht nicht aus, 
                                                          um den Schweif zu erklären, wird die Idee Kometenschweif = Pferdeschweif so denkbar?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                 choices= sample(list("Nein, weil der Kometenschweif selbst leuchtet.",
                                                                                      "Ja, weil es einen Sonnenwind gibt, der den Gasschweif zum Leuchten bringt.", 
                                                                                      "Ja, weil der Kometenschweif durch die Geschwindigkeit des Kometen leuchtet.", 
                                                                                      "Nein, weil der Kometenschweif durch Richtungswechsel des Kometen sichtbar wird.")),
                                                                 selected = "default",
                                                                 width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery7<- renderUI(fluidRow(column(12, h4(radioButtons("PW7", h4("7. Wie entsteht das Phänomen 'Sonnenwind'?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                 choices= sample(list("Durch Fahrtwind von der Bewegung der Sonne, der Sonnenwind genannt wird.", 
                                                                                      "Auf die gleiche Art und Weise wie auf der Erde.",
                                                                                      "Die Sonne gibt kleine Teilchen ab, die Sonnenwind genannt werden.", 
                                                                                      "Die Sonne gibt elektromagnetische Strahlung ab, die Sonnenwind genannt wird.")),
                                                                 selected = "default",
                                                                 width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery8<- renderUI(fluidRow(column(12, h4(radioButtons("PW8", h4("8. Was bedeutet es, wenn ein Kometenschweif langsam sichtbarer wird?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                 choices= sample(list("Dass der Komet bald implodiert.", 
                                                                                      "Dass er sich der Sonne langsam annähert.",
                                                                                      "Dass er sich langsam von der Sonne entfernt.", 
                                                                                      "Dass er langsam in der Hitze der Sonne verglüht.")),
                                                                 selected = "default",
                                                                 width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery9<- renderUI(fluidRow(column(12, h4(radioButtons("PW9", h4("9. Was bedeutet es, wenn ein Kometenschweif kaum sichtbar ist?", 
                                                                           style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                 choices= sample(list("Der Komet ist weit von der Sonne entfernt.",
                                                                                      "Der Komet ist der Sonne sehr nah.", 
                                                                                      "Der Komet hat seine Laufbahn verlassen.", 
                                                                                      "Der Komet hat aufgehört sich zu bewegen.")),
                                                                 selected = "default",
                                                                 width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery10<- renderUI(fluidRow(column(12, h4(radioButtons("PW10", h4("10. Was bedeutet es für Komet und Sonnenwind, dass der Schweif von der Sonne weggerichtet ist?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                  choices= sample(list("Der Sonnenwind wird schneller und nähert sich der Geschwindigkeit des Kometen an.", 
                                                                                       "Der ist Komet konstant schneller als der Sonnenwind.",
                                                                                       "Der Sonnenwind ist konstant schneller als der Komet.",
                                                                                       "Der Komet wird schneller und nähert sich der Geschwindigkeit des Sonnenwinds an.")),
                                                                  selected = "default",
                                                                  width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
  output$battery11<- renderUI(fluidRow(column(12, h4(radioButtons("PW11", h4("11. Was trifft für die Geschwindigkeit von Kometen und Sonnenwind zu?", style = "font-family: Times New Roman; font-weight: 100; line-height: 1.5;"),
                                                                  choices = sample(list("Kometen (Hale-Bopp, Encke, Halley) 44-69 km/s, Sonnenwind 200-900 km/s",
                                                                                        "Kometen (Hale-Bopp, Encke, Halley) 200-900 km/s, Sonnenwind 200-900 km/s",
                                                                                        "Kometen (Hale-Bopp, Encke, Halley) 200-900 km/s, Sonnenwind 44-69 km/s",
                                                                                        "Kometen (Hale-Bopp, Encke, Halley) 0 km/s, Sonnenwind 44-69 km/s")),
                                                                  selected = "default",
                                                                  width = "100%"), style = "font-family: Times New Roman; font-weight: 100;"))))
}



# Run the application 
shinyApp(ui = ui, server = server)
