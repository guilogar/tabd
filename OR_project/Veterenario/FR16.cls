\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{FR16}[2019/01/21 ver. 0.0]
\LoadClass[14pt, a4paper]{article}
%RUN WITH XeLaTeX

%--Packages--
\RequirePackage[spanish]{babel}
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{latexsym}
\RequirePackage{amsmath}
\RequirePackage{graphicx}
\RequirePackage{xcolor}
\RequirePackage{setspace}
\RequirePackage{geometry}
\RequirePackage{marginnote}
\RequirePackage{caption}
\RequirePackage{siunitx}
\RequirePackage{eurosym}
\RequirePackage{colortbl}
\RequirePackage{array}
\RequirePackage{sectsty}
\RequirePackage[nottoc]{tocbibind}
\RequirePackage{float}
\RequirePackage{wrapfig}
\RequirePackage{vmargin}
    \setpapersize{A4}
    \setmarginsrb{20mm}{20mm}{20mm}{20mm}%left top right bottom
                 {8mm}{6mm}{10mm}{10mm}%headheight headsep footheight footskip

\definecolor{Blu}{RGB}{8,144,213}
\definecolor{Azzurro}{RGB}{57,186,238}
%\definecolor{Sapienza}{RGB}{111,10,25}
\definecolor{gold}{RGB}{199,153,0}
\RequirePackage{hyperref}
\hypersetup{colorlinks=true,linkcolor=black,allbordercolors=white}
\RequirePackage{enumitem} 
\renewcommand\labelitemi{\textbullet} 
\RequirePackage{pdflscape}
\RequirePackage{pgfplots}
\usetikzlibrary{shapes}
\RequirePackage{pgfplots}
\usetikzlibrary{intersections,positioning,calc}
\RequirePackage{tkz-euclide,tkz-fct}
    \usetkzobj{all}
\usetikzlibrary{angles,quotes}
\RequirePackage{lmodern}
\RequirePackage{titlesec}
\RequirePackage{tikz}
\usetikzlibrary{shapes}
\usetikzlibrary{arrows,positioning}
\RequirePackage{amsmath,bm}

\RequirePackage{xunicode}

\usepackage{listings}
%paragraph

\onehalfspacing


%--Title
\renewcommand{\maketitle}{
\thispagestyle{empty}
\begin{figure}
\vspace{-1cm}
\centering
\includegraphics[width=0.4\textwidth]{Logo_UCA.png}\\[1cm]
\end{figure}

\begin{center}
{\sc\centering\onehalfspacing\fontsize{4mm}{6mm}\selectfont Universidad de Cádiz \\Escuela Superior de Ingeniería\\Ingeniería de Informatica\\[1cm]}
\end{center}
\begin{center}
\Large\bfseries\sc Tecnologías Avanzadas de Bases de Datos\\[0.5cm] \bfseries\Huge\sc Práctica Final de Bases de Datos O/R\\
\end{center}


\vspace{2.5cm}
\begin{minipage}{0.4\textwidth}
\begin{flushleft} \large
\emph{Autores:}\\
{Guillermo López García \\}
{\\Viktoriia Kotovets \\}% Your name
\end{flushleft}
\end{minipage}
~
\begin{minipage}{0.4\textwidth}
\begin{flushright} \large
\emph{Profesora:} \\
{Mercedes Ruiz Carreira \\}
\end{flushright}
\end{minipage}\\
\vspace{1.5cm}
\begin{center}
\vfill
{\sc Curso academico 2019-2020}
\end{center}
}



%--Intestazione section--
\titleformat{\section}[display]
  {\normalfont\bfseries\color{Blu}}
  {\filleft
    \begin{tikzpicture}
    \node[
      outer sep=0pt,
      text width=1.5cm,
      minimum height=0cm,
      fill=white,
      font=\color{Blu}\fontsize{40}{0}\selectfont,
      align=center
      ] (num) {\thesection};
    \node[
      rotate=90,
      anchor=south,
      font=\color{Blu}\fontsize{40}{0}\selectfont
      ] at ([xshift=-5pt]num.west) {\Huge\textsc{}};  
    \end{tikzpicture}%
  }
  {10pt}
  {\titlerule\vskip4pt\Huge\sc\sffamily}

%--Intestazione subsection--
\newcommand*\numb[1]{%
\begin{tikzpicture}[baseline=-0.7ex]
\node[
  outer sep=0pt,
      text width=0.6cm,
      minimum height=0.6cm,
      fill=Blu,
      font=\color{white}\fontsize{12}{20}\selectfont,
      align=center
      ] (num) {\thesubsection};
\end{tikzpicture}%
}
\titleformat{\subsection}
  {\normalfont\color{Blu}\large\sc\sffamily}{\numb{\thesubsection}}{0.8em}{}

%--Intestazione subsubsection--
\newcommand*\stocaz[1]{%
\begin{tikzpicture}[baseline=-0.7ex]
\node[
  outer sep=0pt,
      text width=0.8cm,
      minimum height=0.5cm,
      fill=Blu,
      font=\color{white}\fontsize{10}{20}\selectfont,
      align=center
      ] (num) {\thesubsubsection};
\end{tikzpicture}%
}
\titleformat{\subsubsection}
  {\normalfont\color{Blu}\bfseries\sc\sffamily}{\stocaz{\thesubsubsection}}{0.8em}{}