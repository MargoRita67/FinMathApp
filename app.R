library(shiny)
library(shinydashboard)

# --- Интерфейс (UI) ---
ui <- dashboardPage(
  dashboardHeader(title = "Аналитический хаб"),
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("Математические задачи", tabName = "math", icon = icon("calculator")),
      menuItem("Анализ данных / Статистика", tabName = "stats", icon = icon("chart-line")),
      menuItem("Финансовые задачи", tabName = "finance", icon = icon("coins"))
    )
  ),
  dashboardBody(
    tabItems(
      # Блок 1: Математика
      tabItem(tabName = "math",
              h2("Математические задачи"),
              p("Здесь можно добавить подблоки для решения уравнений или матричных вычислений."),
              box(title = "Пример подблока", "Здесь будет калькулятор или ввод данных.")
      ),
      
      # Блок 2: Статистика
      tabItem(tabName = "stats",
              h2("Анализ данных и статистика"),
              p("Загрузка данных и визуализация (например, гистограммы или регрессии).")
      ),
      
      # Блок 3: Финансы
      tabItem(tabName = "finance",
              h2("Финансовые задачи"),
              p("Например, расчет сложного процента, оценка рисков или портфеля."),
              box(title = "Параметры расчета", "Введите сумму и ставку...")
      )
    )
  )
)

# --- Серверная логика (пока пустая) ---
server <- function(input, output) { }

shinyApp(ui, server)