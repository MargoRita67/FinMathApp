# ============================================================
#  🌸 Bunny Analytics Hub 🐰  —  сиреневая версия (30 задач)
# ============================================================
library(shiny)
library(shinydashboard)
library(ggplot2)
library(DT)

# ============================================================
#  ИНТЕРФЕЙС
# ============================================================
ui <- dashboardPage(
  dashboardHeader(title = "🌸 Bunny Analytics Hub 🌸"),
  
  dashboardSidebar(
    sidebarMenu(
      id = "tabs",
      menuItem("🧮 Математика", tabName = "math",    icon = icon("calculator")),
      menuItem("📊 Статистика", tabName = "stats",   icon = icon("chart-line")),
      menuItem("💰 Финансы",    tabName = "finance", icon = icon("coins")),
      menuItem("🐇 О зайчике",  tabName = "about",   icon = icon("heart"))
    )
  ),
  
  dashboardBody(
    tags$head(
      tags$style(HTML("
        @import url('https://fonts.googleapis.com/css2?family=Nunito:wght@400;700&display=swap');

        body, .content-wrapper, .right-side {
          background: linear-gradient(135deg, #F6F0FF 0%, #EDE4F7 100%);
          font-family: 'Nunito', 'Segoe UI', sans-serif;
          overflow-x: hidden;
        }
        .main-header .logo {
          background: linear-gradient(90deg, #B39DDB, #C8A2E0) !important;
          color: #FFFFFF !important; font-weight: 700; letter-spacing: 1px;
        }
        .main-header .navbar { background-color: #C8A2E0 !important; }
        .main-sidebar       { background-color: #D7BFEF !important; }

        .sidebar-menu > li > a {
          color: #3D1E5C !important;
          font-size: 16px;
          font-weight: 700;
          transition: all 0.3s;
        }
        .sidebar-menu > li > a > .fa { color: #7E57C2 !important; }
        .sidebar-menu > li > a:hover {
          background-color: #C8A2E0 !important;
          color: #FFFFFF !important;
        }
        .sidebar-menu > li > a:hover > .fa { color: #FFFFFF !important; }
        .sidebar-menu > li.active > a {
          background: linear-gradient(90deg, #9B6BC7, #B39DDB) !important;
          color: #FFFFFF !important;
          box-shadow: inset 3px 0 0 #4A2E6B;
        }
        .sidebar-menu > li.active > a > .fa { color: #FFFFFF !important; }

        .box {
          border-top: 3px solid #9B6BC7 !important;
          border-radius: 16px; background-color: #FFFFFF;
          box-shadow: 0 6px 18px rgba(155,107,199,0.25);
          transition: transform 0.3s, box-shadow 0.3s;
        }
        .box:hover {
          transform: translateY(-3px);
          box-shadow: 0 10px 24px rgba(155,107,199,0.4);
        }
        .btn {
          background: linear-gradient(90deg, #9B6BC7, #B39DDB);
          color: white; border-radius: 12px; border: none;
          font-weight: 700; padding: 8px 18px; transition: all 0.3s;
        }
        .btn:hover {
          background: linear-gradient(90deg, #7E57C2, #9B6BC7);
          color: white; transform: scale(1.05);
          box-shadow: 0 4px 12px rgba(126,87,194,0.5);
        }
        .small-box { border-radius: 14px; box-shadow: 0 4px 12px rgba(155,107,199,0.3); }
        h2 { color: #4A2E6B; font-weight: 700; }

        .nav-pills > li > a {
          border-radius: 10px !important;
          color: #3D1E5C !important;
          font-weight: 700 !important;
          margin-bottom: 4px;
          transition: all 0.3s;
        }
        .nav-pills > li > a:hover {
          background-color: #C8A2E0 !important;
          color: #FFFFFF !important;
        }
        .nav-pills > li.active > a {
          background: linear-gradient(90deg, #9B6BC7, #B39DDB) !important;
          color: #FFFFFF !important;
        }

        .bunny-left, .bunny-right {
          position: fixed; bottom: 15px; font-size: 50px;
          opacity: 0.75; pointer-events: none;
        }
        .bunny-left  { left: 20px;  animation: float 3s ease-in-out infinite; }
        .bunny-right { right: 20px; animation: float 3s ease-in-out infinite; animation-delay: 1.5s; }

        .ribbon-left, .ribbon-right {
          position: fixed; top: 100px; font-size: 30px;
          opacity: 0.8; pointer-events: none; animation: sway 4s ease-in-out infinite;
        }
        .ribbon-left  { left: 215px; }
        .ribbon-right { right: 25px; animation-delay: 2s; }

        .flower1, .flower2, .flower3, .flower4 {
          position: fixed; font-size: 24px; opacity: 0.75;
          pointer-events: none; animation: sway 5s ease-in-out infinite;
        }
        .flower1 { top: 15%;  left: 240px; }
        .flower2 { top: 40%;  right: 40px; animation-delay: 1s; }
        .flower3 { bottom: 20%; left: 235px; animation-delay: 2s; }
        .flower4 { bottom: 35%; right: 55px; animation-delay: 3s; }

        .star {
          position: fixed; pointer-events: none;
          font-size: 22px; opacity: 0.6; animation: floatUp linear infinite;
        }
        .star.s1 { left: 30%;  bottom: -40px; animation-duration: 14s; animation-delay: 0s; }
        .star.s2 { left: 55%;  bottom: -40px; animation-duration: 18s; animation-delay: 3s; }
        .star.s3 { left: 75%;  bottom: -40px; animation-duration: 16s; animation-delay: 6s; }
        .star.s4 { left: 15%;  bottom: -40px; animation-duration: 20s; animation-delay: 9s; }
        .star.s5 { left: 88%;  bottom: -40px; animation-duration: 15s; animation-delay: 12s; }

        .carrot {
          position: fixed; top: -60px; pointer-events: none;
          font-size: 26px; opacity: 0.85; animation: fall linear infinite;
        }
        .carrot.c1 { left: 8%;  animation-duration: 12s; animation-delay: 0s; }
        .carrot.c2 { left: 40%; animation-duration: 16s; animation-delay: 4s; }
        .carrot.c3 { left: 62%; animation-duration: 14s; animation-delay: 8s; }
        .carrot.c4 { left: 82%; animation-duration: 18s; animation-delay: 2s; }

        @keyframes float {
          0%,100% { transform: translateY(0); }
          50%     { transform: translateY(-12px); }
        }
        @keyframes sway {
          0%,100% { transform: rotate(-8deg); }
          50%     { transform: rotate(8deg); }
        }
        @keyframes floatUp {
          0%   { transform: translateY(0) rotate(0deg); opacity: 0; }
          10%  { opacity: 0.8; }
          90%  { opacity: 0.8; }
          100% { transform: translateY(-110vh) rotate(360deg); opacity: 0; }
        }
        @keyframes fall {
          0%   { transform: translateY(0) rotate(0deg); opacity: 0; }
          10%  { opacity: 0.9; }
          90%  { opacity: 0.9; }
          100% { transform: translateY(110vh) rotate(360deg); opacity: 0; }
        }

        .btn::before { content: '🎀 '; }
      "))
    ),
    
    tags$div(class = "bunny-left",   "🐰"),
    tags$div(class = "bunny-right",  "🐇"),
    tags$div(class = "ribbon-left",  "🎀"),
    tags$div(class = "ribbon-right", "🎀"),
    tags$div(class = "flower1", "🌸"),
    tags$div(class = "flower2", "🌷"),
    tags$div(class = "flower3", "💐"),
    tags$div(class = "flower4", "🌸"),
    tags$div(class = "star s1", "✨"),
    tags$div(class = "star s2", "⭐"),
    tags$div(class = "star s3", "✨"),
    tags$div(class = "star s4", "💫"),
    tags$div(class = "star s5", "✨"),
    tags$div(class = "carrot c1", "🥕"),
    tags$div(class = "carrot c2", "🥕"),
    tags$div(class = "carrot c3", "🥕"),
    tags$div(class = "carrot c4", "🥕"),
    
    tabItems(
      
      # ======================================================
      #  МАТЕМАТИКА (10 задач)
      # ======================================================
      tabItem(tabName = "math",
              h2("🧮 Математические задачи"),
              p("Выберите задачу слева — зайка посчитает 🐇"),
              fluidRow(
                column(4,
                       box(title = "📋 Задачи", width = 12, status = "primary",
                           tabsetPanel(id = "math_task", type = "pills",
                                       tabPanel("1. Калькулятор",           value = "m1"),
                                       tabPanel("2. Квадратное уравнение",  value = "m2"),
                                       tabPanel("3. Факториал",             value = "m3"),
                                       tabPanel("4. Числа Фибоначчи",       value = "m4"),
                                       tabPanel("5. НОД и НОК",             value = "m5"),
                                       tabPanel("6. Простые числа",         value = "m6"),
                                       tabPanel("7. Средние",               value = "m7"),
                                       tabPanel("8. Тригонометрия",         value = "m8"),
                                       tabPanel("9. Логарифмы",             value = "m9"),
                                       tabPanel("10. Простое число?",       value = "m10")
                           )
                       )
                ),
                column(8,
                       conditionalPanel("input.math_task == 'm1'",
                                        box(title = "🧮 Калькулятор", width = 12, status = "info",
                                            numericInput("calc_a", "Число A:", 10),
                                            numericInput("calc_b", "Число B:", 5),
                                            selectInput("calc_op", "Операция:",
                                                        c("Сложение"="add","Вычитание"="sub","Умножение"="mul",
                                                          "Деление"="div","Степень"="pow")),
                                            actionButton("calc_btn", "Посчитать 🐇"),
                                            hr(), h3(textOutput("calc_out"))
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm2'",
                                        box(title = "📐 Квадратное уравнение ax² + bx + c = 0", width = 12, status = "info",
                                            numericInput("qa", "a:", 1),
                                            numericInput("qb", "b:", -3),
                                            numericInput("qc", "c:", 2),
                                            actionButton("quad_btn", "Решить 📐"),
                                            hr(), verbatimTextOutput("quad_out")
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm3'",
                                        box(title = "❗ Факториал", width = 12, status = "info",
                                            numericInput("fact_n", "n (0–170):", 5, min = 0, max = 170),
                                            actionButton("fact_btn", "Вычислить"),
                                            hr(), h3(textOutput("fact_out"))
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm4'",
                                        box(title = "🌀 Числа Фибоначчи", width = 12, status = "info",
                                            numericInput("fib_n", "Сколько чисел:", 10, min = 1, max = 100),
                                            actionButton("fib_btn", "Показать"),
                                            hr(), verbatimTextOutput("fib_out")
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm5'",
                                        box(title = "🔎 НОД и НОК", width = 12, status = "info",
                                            numericInput("gcd_a", "Первое:", 24, min = 1),
                                            numericInput("gcd_b", "Второе:", 36, min = 1),
                                            actionButton("gcd_btn", "Найти"),
                                            hr(), h4(textOutput("gcd_out")), h4(textOutput("lcm_out"))
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm6'",
                                        box(title = "🔢 Простые числа до N", width = 12, status = "info",
                                            numericInput("prime_n", "Верхняя граница:", 50, min = 2, max = 100000),
                                            actionButton("prime_btn", "Найти простые"),
                                            hr(), verbatimTextOutput("prime_out")
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm7'",
                                        box(title = "⚖️ Среднее арифметическое и геометрическое", width = 12, status = "info",
                                            textInput("avg_data", "Числа через запятую:", "2, 4, 8, 16, 32"),
                                            actionButton("avg_btn", "Посчитать"),
                                            hr(),
                                            h4(textOutput("avg_arith")),
                                            h4(textOutput("avg_geom"))
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm8'",
                                        box(title = "📐 Тригонометрия", width = 12, status = "info",
                                            numericInput("trig_angle", "Угол (градусы):", 30),
                                            actionButton("trig_btn", "Посчитать"),
                                            hr(),
                                            h4(textOutput("trig_sin")),
                                            h4(textOutput("trig_cos")),
                                            h4(textOutput("trig_tan"))
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm9'",
                                        box(title = "📊 Логарифмы", width = 12, status = "info",
                                            numericInput("log_x", "Число x (> 0):", 100, min = 0.0001),
                                            numericInput("log_base", "Основание (по умолчанию e):", 10, min = 0.0001),
                                            actionButton("log_btn", "Посчитать"),
                                            hr(),
                                            h4(textOutput("log_ln")),
                                            h4(textOutput("log_10")),
                                            h4(textOutput("log_custom"))
                                        )
                       ),
                       conditionalPanel("input.math_task == 'm10'",
                                        box(title = "🔍 Проверка: простое ли число?", width = 12, status = "info",
                                            numericInput("isprime_n", "Число:", 17, min = 1),
                                            actionButton("isprime_btn", "Проверить"),
                                            hr(), h3(textOutput("isprime_out"))
                                        )
                       )
                )
              )
      ),
      
      # ======================================================
      #  СТАТИСТИКА (10 задач)
      # ======================================================
      tabItem(tabName = "stats",
              h2("📊 Анализ данных и статистика"),
              fluidRow(
                column(4,
                       box(title = "📋 Задачи", width = 12, status = "primary",
                           tabsetPanel(id = "stats_task", type = "pills",
                                       tabPanel("1. Описательные",        value = "s1"),
                                       tabPanel("2. Корреляция",          value = "s2"),
                                       tabPanel("3. Нормальное распр.",   value = "s3"),
                                       tabPanel("4. t-тест",              value = "s4"),
                                       tabPanel("5. Частоты",             value = "s5"),
                                       tabPanel("6. Мода",                value = "s6"),
                                       tabPanel("7. Квартили",            value = "s7"),
                                       tabPanel("8. Генератор чисел",     value = "s8"),
                                       tabPanel("9. Дисперсия и CV",      value = "s9"),
                                       tabPanel("10. Гистограмма+",       value = "s10")
                           )
                       )
                ),
                column(8,
                       conditionalPanel("input.stats_task == 's1'",
                                        box(title = "📈 Описательные статистики", width = 12, status = "info",
                                            textInput("desc_data", "Числа через запятую:", "5, 8, 12, 15, 20, 22, 30"),
                                            actionButton("desc_btn", "Анализировать"),
                                            hr(),
                                            fluidRow(
                                              valueBoxOutput("d_mean",   width = 6),
                                              valueBoxOutput("d_median", width = 6)
                                            ),
                                            fluidRow(
                                              valueBoxOutput("d_sd",     width = 6),
                                              valueBoxOutput("d_range",  width = 6)
                                            ),
                                            plotOutput("desc_hist")
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's2'",
                                        box(title = "🔗 Корреляция", width = 12, status = "info",
                                            textInput("cor_x", "Ряд X:", "1, 2, 3, 4, 5"),
                                            textInput("cor_y", "Ряд Y:", "2, 4, 5, 4, 5"),
                                            actionButton("cor_btn", "Посчитать"),
                                            hr(),
                                            h3(textOutput("cor_out")),
                                            plotOutput("cor_plot")
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's3'",
                                        box(title = "🔔 Нормальное распределение", width = 12, status = "info",
                                            numericInput("norm_mean", "Среднее (μ):", 0),
                                            numericInput("norm_sd",   "Ст. отклонение (σ):", 1, min = 0.1),
                                            numericInput("norm_n",    "Кол-во точек:", 1000, min = 10),
                                            actionButton("norm_btn", "Построить"),
                                            hr(), plotOutput("norm_plot")
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's4'",
                                        box(title = "⚖️ t-тест Уэлча", width = 12, status = "info",
                                            textInput("tt_a", "Группа A:", "10, 12, 11, 13, 14, 12"),
                                            textInput("tt_b", "Группа B:", "15, 16, 14, 17, 15, 16"),
                                            actionButton("tt_btn", "Сравнить"),
                                            hr(), verbatimTextOutput("tt_out")
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's5'",
                                        box(title = "📊 Частоты категорий", width = 12, status = "info",
                                            textInput("freq_data", "Категории через запятую:",
                                                      "яблоко, груша, яблоко, банан, груша, яблоко"),
                                            actionButton("freq_btn", "Построить"),
                                            hr(), plotOutput("freq_plot")
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's6'",
                                        box(title = "🎯 Мода", width = 12, status = "info",
                                            textInput("mode_data", "Числа через запятую:", "1, 2, 2, 3, 4, 4, 4, 5"),
                                            actionButton("mode_btn", "Найти моду"),
                                            hr(), h3(textOutput("mode_out"))
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's7'",
                                        box(title = "📦 Квартили и boxplot", width = 12, status = "info",
                                            textInput("quart_data", "Числа через запятую:",
                                                      "3, 5, 7, 8, 10, 12, 15, 18, 22, 25, 30"),
                                            actionButton("quart_btn", "Показать квартили"),
                                            hr(),
                                            verbatimTextOutput("quart_out"),
                                            plotOutput("quart_plot")
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's8'",
                                        box(title = "🎲 Генератор случайных чисел", width = 12, status = "info",
                                            numericInput("gen_n",   "Сколько чисел:", 100, min = 1),
                                            numericInput("gen_min", "Минимум:", 0),
                                            numericInput("gen_max", "Максимум:", 100),
                                            actionButton("gen_btn", "Сгенерировать"),
                                            hr(), plotOutput("gen_plot")
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's9'",
                                        box(title = "📐 Дисперсия и коэффициент вариации", width = 12, status = "info",
                                            textInput("var_data", "Числа через запятую:", "10, 12, 14, 16, 18, 20"),
                                            actionButton("var_btn", "Посчитать"),
                                            hr(),
                                            h4(textOutput("var_var")),
                                            h4(textOutput("var_sd")),
                                            h4(textOutput("var_cv"))
                                        )
                       ),
                       conditionalPanel("input.stats_task == 's10'",
                                        box(title = "📊 Гистограмма с настройкой", width = 12, status = "info",
                                            textInput("hist2_data", "Числа через запятую:",
                                                      "3, 5, 5, 7, 8, 8, 8, 10, 12, 12, 15, 18, 22, 25, 30"),
                                            numericInput("hist2_bins", "Кол-во корзин:", 8, min = 2, max = 50),
                                            actionButton("hist2_btn", "Построить"),
                                            hr(), plotOutput("hist2_plot")
                                        )
                       )
                )
              )
      ),
      
      # ======================================================
      #  ФИНАНСЫ (10 задач)
      # ======================================================
      tabItem(tabName = "finance",
              h2("💰 Финансовые задачи"),
              fluidRow(
                column(4,
                       box(title = "📋 Задачи", width = 12, status = "primary",
                           tabsetPanel(id = "fin_task", type = "pills",
                                       tabPanel("1. Сложный %",              value = "f1"),
                                       tabPanel("2. Простой %",              value = "f2"),
                                       tabPanel("3. Ипотека",                value = "f3"),
                                       tabPanel("4. Инфляция",               value = "f4"),
                                       tabPanel("5. Конвертер",              value = "f5"),
                                       tabPanel("6. Дисконт",                value = "f6"),
                                       tabPanel("7. ROI",                    value = "f7"),
                                       tabPanel("8. Аннуитет",               value = "f8"),
                                       tabPanel("9. Вклад с пополнениями",   value = "f9"),
                                       tabPanel("10. Окупаемость",           value = "f10")
                           )
                       )
                ),
                column(8,
                       conditionalPanel("input.fin_task == 'f1'",
                                        box(title = "💸 Сложный процент", width = 12, status = "info",
                                            numericInput("ci_p", "Сумма вклада (₽):", 100000, min = 0),
                                            numericInput("ci_r", "Ставка (% годовых):", 8, min = 0, step = 0.1),
                                            numericInput("ci_t", "Срок (лет):", 5, min = 1),
                                            selectInput("ci_n", "Начисление:",
                                                        c("Раз в год"=1, "Ежеквартально"=4, "Ежемесячно"=12, "Ежедневно"=365)),
                                            actionButton("ci_btn", "Рассчитать"),
                                            hr(),
                                            h3(textOutput("ci_out")),
                                            plotOutput("ci_plot")
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f2'",
                                        box(title = "🪙 Простой процент", width = 12, status = "info",
                                            numericInput("si_p", "Сумма (₽):", 50000, min = 0),
                                            numericInput("si_r", "Ставка (% годовых):", 10, min = 0),
                                            numericInput("si_t", "Срок (лет):", 3, min = 1),
                                            actionButton("si_btn", "Посчитать"),
                                            hr(), h3(textOutput("si_out"))
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f3'",
                                        box(title = "🏠 Ипотека (аннуитет)", width = 12, status = "info",
                                            numericInput("mor_sum",   "Сумма кредита (₽):", 3000000, min = 0),
                                            numericInput("mor_rate",  "Ставка (% годовых):", 12, min = 0, step = 0.1),
                                            numericInput("mor_years", "Срок (лет):", 20, min = 1),
                                            actionButton("mor_btn", "Рассчитать"),
                                            hr(),
                                            h4(textOutput("mor_pay")),
                                            h4(textOutput("mor_over"))
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f4'",
                                        box(title = "📉 Инфляция", width = 12, status = "info",
                                            numericInput("inf_sum",   "Текущая сумма (₽):", 10000, min = 0),
                                            numericInput("inf_rate",  "Инфляция (% годовых):", 6, min = 0, step = 0.1),
                                            numericInput("inf_years", "Через сколько лет:", 5, min = 1),
                                            actionButton("inf_btn", "Посчитать"),
                                            hr(), h3(textOutput("inf_out"))
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f5'",
                                        box(title = "💱 Конвертер валют", width = 12, status = "info",
                                            p("Курсы условные."),
                                            numericInput("cur_amount", "Сумма:", 100, min = 0),
                                            selectInput("cur_from", "Из:", c("RUB", "USD", "EUR", "CNY")),
                                            selectInput("cur_to",   "В:",  c("USD", "EUR", "CNY", "RUB")),
                                            actionButton("cur_btn", "Конвертировать"),
                                            hr(), h3(textOutput("cur_out"))
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f6'",
                                        box(title = "📉 Дисконтирование", width = 12, status = "info",
                                            p("Какую сумму вложить сегодня, чтобы получить заданную через N лет."),
                                            numericInput("disc_fv",    "Будущая сумма (₽):", 100000, min = 0),
                                            numericInput("disc_rate",  "Ставка дисконт. (% годовых):", 10, min = 0, step = 0.1),
                                            numericInput("disc_years", "Через сколько лет:", 5, min = 1),
                                            actionButton("disc_btn", "Рассчитать"),
                                            hr(), h3(textOutput("disc_out"))
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f7'",
                                        box(title = "📈 ROI — рентабельность инвестиций", width = 12, status = "info",
                                            numericInput("roi_cost", "Вложено (₽):", 100000, min = 0),
                                            numericInput("roi_gain", "Получено (₽):", 130000, min = 0),
                                            actionButton("roi_btn", "Рассчитать"),
                                            hr(),
                                            h3(textOutput("roi_out")),
                                            h4(textOutput("roi_percent"))
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f8'",
                                        box(title = "💳 Сколько можно взять под платёж", width = 12, status = "info",
                                            numericInput("ann_pay",   "Ежемесячный платёж (₽):", 30000, min = 0),
                                            numericInput("ann_rate",  "Ставка (% годовых):", 12, min = 0, step = 0.1),
                                            numericInput("ann_years", "Срок (лет):", 20, min = 1),
                                            actionButton("ann_btn", "Рассчитать"),
                                            hr(), h3(textOutput("ann_out"))
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f9'",
                                        box(title = "💵 Вклад с регулярными пополнениями", width = 12, status = "info",
                                            p("Начальная сумма + ежемесячные взносы под сложный процент."),
                                            numericInput("reg_p",    "Начальная сумма (₽):", 50000, min = 0),
                                            numericInput("reg_add",  "Ежемесячное пополнение (₽):", 5000, min = 0),
                                            numericInput("reg_rate", "Ставка (% годовых):", 8, min = 0, step = 0.1),
                                            numericInput("reg_years","Срок (лет):", 5, min = 1),
                                            actionButton("reg_btn", "Рассчитать"),
                                            hr(),
                                            h3(textOutput("reg_out")),
                                            plotOutput("reg_plot")
                                        )
                       ),
                       conditionalPanel("input.fin_task == 'f10'",
                                        box(title = "⏳ Точка окупаемости инвестиций", width = 12, status = "info",
                                            p("Сколько времени нужно, чтобы вложение окупилось ежемесячным доходом."),
                                            numericInput("pay_cost",  "Сумма вложения (₽):", 500000, min = 0),
                                            numericInput("pay_month", "Ежемесячный доход (₽):", 15000, min = 1),
                                            actionButton("pay_btn", "Рассчитать"),
                                            hr(), h3(textOutput("pay_out"))
                                        )
                       )
                )
              )
      ),
      
      # ======================================================
      #  О ЗАЙЧИКЕ
      # ======================================================
      tabItem(tabName = "about",
              h2("🐇 О проекте"),
              box(width = 12, status = "primary",
                  h3("🌸 Bunny Analytics Hub 🌸"),
                  p("Учебный проект на R Shiny в сиреневых тонах."),
                  p("Три раздела по 10 задач:"),
                  tags$ul(
                    tags$li("🧮 Математика: калькулятор, квадратное ур., факториал, Фибоначчи, НОД/НОК, простые числа, средние, тригонометрия, логарифмы, проверка на простоту"),
                    tags$li("📊 Статистика: описательные, корреляция, нормальное распр., t-тест, частоты, мода, квартили, генератор, дисперсия, гистограмма+"),
                    tags$li("💰 Финансы: сложный %, простой %, ипотека, инфляция, конвертер, дисконт, ROI, аннуитет, вклад с пополнениями, окупаемость")
                  ),
                  hr(),
                  p(style = "text-align:center; font-size: 18px; color: #7E57C2;",
                    "Сделано с 💜 и зайками 🐰")
              )
      )
    )
  )
)

# ============================================================
#  СЕРВЕР
# ============================================================
server <- function(input, output, session) {
  
  # ================= МАТЕМАТИКА =================
  observeEvent(input$calc_btn, {
    a <- input$calc_a; b <- input$calc_b
    res <- if (input$calc_op == "div" && b == 0) "Деление на ноль!" else
      switch(input$calc_op, "add"=a+b, "sub"=a-b, "mul"=a*b, "div"=a/b, "pow"=a^b)
    output$calc_out <- renderText(paste("Ответ:", res))
  })
  
  observeEvent(input$quad_btn, {
    a <- input$qa; b <- input$qb; c <- input$qc
    if (a == 0) { output$quad_out <- renderText("Это не квадратное уравнение (a = 0)."); return() }
    D <- b^2 - 4*a*c
    txt <- if (D > 0) {
      x1 <- (-b + sqrt(D)) / (2*a); x2 <- (-b - sqrt(D)) / (2*a)
      paste0("D = ", D, "\nx1 = ", round(x1, 4), "\nx2 = ", round(x2, 4))
    } else if (D == 0) {
      paste0("D = 0\nx = ", round(-b/(2*a), 4))
    } else {
      paste0("D = ", D, " < 0 — действительных корней нет.")
    }
    output$quad_out <- renderText(txt)
  })
  
  observeEvent(input$fact_btn, {
    n <- round(input$fact_n)
    output$fact_out <- renderText(paste0(n, "! = ", format(factorial(n), big.mark = " ")))
  })
  
  observeEvent(input$fib_btn, {
    n <- round(input$fib_n)
    fib <- numeric(n)
    if (n >= 1) fib[1] <- 0
    if (n >= 2) fib[2] <- 1
    if (n > 2) {
      for (i in 3:n) fib[i] <- fib[i-1] + fib[i-2]
    }
    output$fib_out <- renderText(paste(fib, collapse = ", "))
  })
  
  observeEvent(input$gcd_btn, {
    a <- round(input$gcd_a); b <- round(input$gcd_b)
    gcd_val <- function(x, y) { while (y != 0) { t <- y; y <- x %% y; x <- t }; x }
    g <- gcd_val(a, b)
    output$gcd_out <- renderText(paste("НОД:", g))
    output$lcm_out <- renderText(paste("НОК:", a * b / g))
  })
  
  observeEvent(input$prime_btn, {
    n <- round(input$prime_n)
    if (n < 2) { output$prime_out <- renderText("Нужно число >= 2."); return() }
    sieve <- rep(TRUE, n)
    sieve[1] <- FALSE
    for (i in 2:floor(sqrt(n))) {
      if (sieve[i]) sieve[seq(i*i, n, i)] <- FALSE
    }
    primes <- which(sieve)
    output$prime_out <- renderText(paste(primes, collapse = ", "))
  })
  
  observeEvent(input$avg_btn, {
    nums <- suppressWarnings(as.numeric(trimws(strsplit(input$avg_data, ",")[[1]])))
    nums <- nums[!is.na(nums)]
    if (length(nums) == 0) { output$avg_arith <- renderText("Нет чисел."); return() }
    output$avg_arith <- renderText(paste("Арифметическое:", round(mean(nums), 4)))
    if (any(nums <= 0)) {
      output$avg_geom <- renderText("Геометрическое не определено (есть отрицательные или нули).")
    } else {
      output$avg_geom <- renderText(paste("Геометрическое:", round(exp(mean(log(nums))), 4)))
    }
  })
  
  observeEvent(input$trig_btn, {
    rad <- input$trig_angle * pi / 180
    output$trig_sin <- renderText(paste("sin =", round(sin(rad), 4)))
    output$trig_cos <- renderText(paste("cos =", round(cos(rad), 4)))
    output$trig_tan <- renderText(paste("tan =", round(tan(rad), 4)))
  })
  
  observeEvent(input$log_btn, {
    x <- input$log_x; b <- input$log_base
    output$log_ln     <- renderText(paste("ln(x)     =", round(log(x), 6)))
    output$log_10     <- renderText(paste("log10(x)  =", round(log10(x), 6)))
    output$log_custom <- renderText(paste0("log_", b, "(x) = ", round(log(x, base = b), 6)))
  })
  
  observeEvent(input$isprime_btn, {
    n <- round(input$isprime_n)
    if (n < 2) {
      output$isprime_out <- renderText(paste(n, "— не простое (меньше 2)."))
    } else {
      is_prime <- (n == 2) || all(n %% 2:floor(sqrt(n)) != 0)
      output$isprime_out <- renderText(paste0(n, if (is_prime) " — простое ✅" else " — составное ❌"))
    }
  })
  
  # ================= СТАТИСТИКА =================
  parse_nums <- function(txt) {
    nums <- suppressWarnings(as.numeric(trimws(strsplit(txt, ",")[[1]])))
    nums[!is.na(nums)]
  }
  
  observeEvent(input$desc_btn, {
    nums <- parse_nums(input$desc_data)
    output$d_mean   <- renderValueBox(valueBox(round(mean(nums), 2),   "Среднее",  icon = icon("chart-bar"),   color = "purple"))
    output$d_median <- renderValueBox(valueBox(round(median(nums), 2), "Медиана",  icon = icon("chart-line"),  color = "purple"))
    output$d_sd     <- renderValueBox(valueBox(round(sd(nums), 2),     "Ст. откл.",icon = icon("arrows-alt-v"),color = "purple"))
    output$d_range  <- renderValueBox(valueBox(max(nums) - min(nums),   "Размах",   icon = icon("ruler"),       color = "purple"))
    
    output$desc_hist <- renderPlot({
      ggplot(data.frame(x = nums), aes(x)) +
        geom_histogram(fill = "#B39DDB", color = "white", bins = 10) +
        theme_minimal(base_size = 14) +
        labs(title = "🐰 Распределение", x = "Значение", y = "Частота")
    })
  })
  
  observeEvent(input$cor_btn, {
    x <- parse_nums(input$cor_x); y <- parse_nums(input$cor_y)
    if (length(x) != length(y) || length(x) < 2) {
      output$cor_out <- renderText("Ряды должны быть одинаковой длины (минимум 2)."); return()
    }
    r <- cor(x, y)
    output$cor_out <- renderText(paste("Коэффициент корреляции r =", round(r, 3)))
    output$cor_plot <- renderPlot({
      ggplot(data.frame(x, y), aes(x, y)) +
        geom_point(color = "#9B6BC7", size = 3) +
        geom_smooth(method = "lm", color = "#7E57C2", se = FALSE) +
        theme_minimal(base_size = 14) +
        labs(title = "🐇 Зависимость")
    })
  })
  
  observeEvent(input$norm_btn, {
    output$norm_plot <- renderPlot({
      set.seed(1)
      x <- rnorm(input$norm_n, input$norm_mean, input$norm_sd)
      ggplot(data.frame(x), aes(x)) +
        geom_density(fill = "#C8A2E0", color = "#7E57C2", alpha = 0.7) +
        theme_minimal(base_size = 14) +
        labs(title = "🔔 Нормальное распределение", x = "Значение", y = "Плотность")
    })
  })
  
  observeEvent(input$tt_btn, {
    a <- parse_nums(input$tt_a); b <- parse_nums(input$tt_b)
    if (length(a) < 2 || length(b) < 2) {
      output$tt_out <- renderText("В каждой группе нужно минимум 2 числа."); return()
    }
    test <- t.test(a, b)
    output$tt_out <- renderText({
      paste0("Среднее A = ", round(mean(a), 2),
             "\nСреднее B = ", round(mean(b), 2),
             "\np-value   = ", round(test$p.value, 4),
             "\n", ifelse(test$p.value < 0.05,
                          "-> Различия значимы", "-> Различий не обнаружено"))
    })
  })
  
  observeEvent(input$freq_btn, {
    cats <- trimws(strsplit(input$freq_data, ",")[[1]])
    cats <- cats[cats != ""]
    df <- as.data.frame(table(cats))
    output$freq_plot <- renderPlot({
      ggplot(df, aes(x = cats, y = Freq, fill = cats)) +
        geom_col(show.legend = FALSE) +
        scale_fill_manual(values = c("#B39DDB","#C8A2E0","#9B6BC7",
                                     "#7E57C2","#D7BFEF","#EDE4F7")) +
        theme_minimal(base_size = 14) +
        labs(title = "🐰 Частоты категорий", x = NULL, y = "Кол-во")
    })
  })
  
  observeEvent(input$mode_btn, {
    nums <- parse_nums(input$mode_data)
    if (length(nums) == 0) { output$mode_out <- renderText("Нет чисел."); return() }
    tab <- table(nums)
    m <- as.numeric(names(tab)[tab == max(tab)])
    output$mode_out <- renderText(paste("Мода:", paste(m, collapse = ", ")))
  })
  
  observeEvent(input$quart_btn, {
    nums <- parse_nums(input$quart_data)
    if (length(nums) < 4) { output$quart_out <- renderText("Нужно минимум 4 числа."); return() }
    q <- quantile(nums, probs = c(0, 0.25, 0.5, 0.75, 1))
    output$quart_out <- renderText(paste0(
      "Min: ", q[1], "\nQ1:  ", q[2], "\nМедиана: ", q[3],
      "\nQ3:  ", q[4], "\nMax: ", q[5]))
    output$quart_plot <- renderPlot({
      ggplot(data.frame(x = nums), aes(x = 1, y = x)) +
        geom_boxplot(fill = "#C8A2E0", color = "#7E57C2", width = 0.4) +
        theme_minimal(base_size = 14) +
        labs(title = "📦 Ящик с усами", x = NULL, y = "Значение") +
        theme(axis.text.x = element_blank())
    })
  })
  
  observeEvent(input$gen_btn, {
    output$gen_plot <- renderPlot({
      set.seed(as.numeric(Sys.time()))
      x <- runif(input$gen_n, input$gen_min, input$gen_max)
      ggplot(data.frame(x), aes(x)) +
        geom_histogram(fill = "#B39DDB", color = "white", bins = 20) +
        theme_minimal(base_size = 14) +
        labs(title = "🎲 Случайные числа", x = "Значение", y = "Частота")
    })
  })
  
  observeEvent(input$var_btn, {
    nums <- parse_nums(input$var_data)
    if (length(nums) < 2) {
      output$var_var <- renderText("Нужно минимум 2 числа."); return()
    }
    v <- var(nums); s <- sd(nums); cv <- s / mean(nums) * 100
    output$var_var <- renderText(paste("Дисперсия:", round(v, 4)))
    output$var_sd  <- renderText(paste("Ст. отклонение:", round(s, 4)))
    output$var_cv  <- renderText(paste("Коэф. вариации:", round(cv, 2), "%"))
  })
  
  observeEvent(input$hist2_btn, {
    nums <- parse_nums(input$hist2_data)
    if (length(nums) == 0) return()
    output$hist2_plot <- renderPlot({
      ggplot(data.frame(x = nums), aes(x)) +
        geom_histogram(fill = "#9B6BC7", color = "white",
                       bins = round(input$hist2_bins)) +
        theme_minimal(base_size = 14) +
        labs(title = "📊 Гистограмма", x = "Значение", y = "Частота")
    })
  })
  
  # ================= ФИНАНСЫ =================
  observeEvent(input$ci_btn, {
    P <- input$ci_p; r <- input$ci_r/100; t <- input$ci_t; n <- as.numeric(input$ci_n)
    A <- P * (1 + r/n)^(n*t)
    output$ci_out <- renderText(paste0(
      "Итого: ", format(round(A, 2), big.mark = " "), " ₽\n",
      "Доход: ", format(round(A - P, 2), big.mark = " "), " ₽"))
    output$ci_plot <- renderPlot({
      yrs <- 0:t
      amt <- P * (1 + r/n)^(n*yrs)
      ggplot(data.frame(yrs, amt), aes(yrs, amt)) +
        geom_line(color = "#9B6BC7", linewidth = 1.5) +
        geom_point(color = "#7E57C2", size = 3) +
        theme_minimal(base_size = 14) +
        labs(title = "🐇 Рост вклада", x = "Год", y = "Сумма (₽)")
    })
  })
  
  observeEvent(input$si_btn, {
    P <- input$si_p; r <- input$si_r/100; t <- input$si_t
    A <- P * (1 + r*t)
    output$si_out <- renderText(paste0(
      "Итого: ", format(round(A, 2), big.mark = " "), " ₽\n",
      "Проценты: ", format(round(A - P, 2), big.mark = " "), " ₽"))
  })
  
  observeEvent(input$mor_btn, {
    S <- input$mor_sum; r <- input$mor_rate/100/12; n <- input$mor_years*12
    pay <- S * r * (1 + r)^n / ((1 + r)^n - 1)
    total <- pay * n
    output$mor_pay  <- renderText(paste0("Ежемесячный платёж: ",
                                         format(round(pay, 2), big.mark = " "), " ₽"))
    output$mor_over <- renderText(paste0("Переплата: ",
                                         format(round(total - S, 2), big.mark = " "), " ₽"))
  })
  
  observeEvent(input$inf_btn, {
    S <- input$inf_sum; r <- input$inf_rate/100; t <- input$inf_years
    future <- S / (1 + r)^t
    output$inf_out <- renderText(paste0(
      "Через ", t, " лет ", format(round(S, 0), big.mark = " "), " ₽ будут стоить как ",
      format(round(future, 2), big.mark = " "), " ₽ сегодня."))
  })
  
  observeEvent(input$cur_btn, {
    rates <- c(RUB = 1, USD = 0.011, EUR = 0.010, CNY = 0.079)
    amount <- input$cur_amount
    res <- amount / rates[[input$cur_from]] * rates[[input$cur_to]]
    output$cur_out <- renderText(paste0(round(res, 2), " ", input$cur_to))
  })
  
  observeEvent(input$disc_btn, {
    FV <- input$disc_fv; r <- input$disc_rate/100; t <- input$disc_years
    PV <- FV / (1 + r)^t
    output$disc_out <- renderText(paste0("Приведённая стоимость: ",
                                         format(round(PV, 2), big.mark = " "), " ₽"))
  })
  
  observeEvent(input$roi_btn, {
    cost <- input$roi_cost; gain <- input$roi_gain
    roi <- (gain - cost) / cost
    output$roi_out     <- renderText(paste0("Прибыль: ",
                                            format(round(gain - cost, 2), big.mark = " "), " ₽"))
    output$roi_percent <- renderText(paste0("ROI = ", round(roi * 100, 2), " %"))
  })
  
  observeEvent(input$ann_btn, {
    pay <- input$ann_pay; r <- input$ann_rate/100/12; n <- input$ann_years*12
    S <- pay * ((1 + r)^n - 1) / (r * (1 + r)^n)
    output$ann_out <- renderText(paste0("Можно взять: ",
                                        format(round(S, 2), big.mark = " "), " ₽"))
  })
  
  observeEvent(input$reg_btn, {
    P <- input$reg_p; add <- input$reg_add
    r <- input$reg_rate / 100 / 12
    n <- input$reg_years * 12
    balance <- numeric(n + 1)
    balance[1] <- P
    for (i in 1:n) {
      balance[i + 1] <- balance[i] * (1 + r) + add
    }
    final <- balance[n + 1]
    output$reg_out <- renderText(paste0(
      "Итого через ", input$reg_years, " лет: ",
      format(round(final, 2), big.mark = " "), " ₽\n",
      "Внесено всего: ",
      format(round(P + add * n, 2), big.mark = " "), " ₽\n",
      "Доход от процентов: ",
      format(round(final - (P + add * n), 2), big.mark = " "), " ₽"))
    output$reg_plot <- renderPlot({
      df <- data.frame(month = 0:n, amount = balance)
      ggplot(df, aes(month, amount)) +
        geom_line(color = "#9B6BC7", linewidth = 1.5) +
        theme_minimal(base_size = 14) +
        labs(title = "🐇 Рост вклада с пополнениями",
             x = "Месяц", y = "Сумма (₽)")
    })
  })
  
  observeEvent(input$pay_btn, {
    cost <- input$pay_cost; month <- input$pay_month
    months <- cost / month
    years  <- months / 12
    output$pay_out <- renderText(paste0(
      "Окупится за ", round(months, 1), " мес. (",
      round(years, 2), " лет)."))
  })
}

shinyApp(ui, server)