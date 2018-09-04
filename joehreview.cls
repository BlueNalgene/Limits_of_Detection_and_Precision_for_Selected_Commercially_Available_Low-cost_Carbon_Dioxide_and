%%
%% This is file modified version of `elsarticle.cls',
%% to be used for Taylor and Francis submission to UOEH journal
%%
%% The original source files were:
%%
%% elsarticle.cls
%% elsarticle.dtx  (with options: `class')
%% 
%% It may be distributed under the conditions of the LaTeX Project Public
%% License, either version 1.2 of this license or (at your option) any
%% later version.  The latest version of this license is in
%%    http://www.latex-project.org/lppl.txt
%% and version 1.2 or later is part of all distributions of LaTeX
%% version 1999/12/01 or later.
%% 
%%
 \def\RCSfile{joehreview}%
 \def\RCSversion{1.00}%
 \def\RCSdate{2018/09/02}%
 \def\@shortjnl{\relax}
 \def\@issn{000-0000}
 \def\@shortjid{joehreview}
\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{\@shortjid}[\RCSdate, \RCSversion]
\def\ABD{\AtBeginDocument}

% Sets the baseline skip to 2 (doublespaced)
\def\@blstr{2}
\newdimen\@bls
\@bls=\baselineskip


% For now, all I need to worry about is Times or Standard
\DeclareOption{times}{\IfFileExists{txfonts.sty}%
  {\AtEndOfClass{\RequirePackage{txfonts}%
  \gdef\ttdefault{cmtt}%
   \let\iint\relax
  \let\iiint\relax
  \let\iiiint\relax
  \let\idotsint\relax
  \let\openbox\relax}}{\RequirePackage{times}}}

% Declare our fancy article
\ExecuteOptions{letterpaper,12pt,oneside,onecolumn,number}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions
\LoadClass{article}

% We require these things at the very least for the class.
\RequirePackage{graphicx}
\RequirePackage[super,sort&compress]{natbib}
\RequirePackage{textcase} %required to automatically use uppercase for sections
\RequirePackage{setspace} %required to force singlespacing in abstract/keywords
\RequirePackage{endfloat} %joeh requires all floats be at the end of the doc
\pagenumbering{gobble} %no page numbers
\let\comma\@empty
\let\tnotesep\@empty
\def\title#1{\gdef\@title{#1}}
\let\@title\@empty

\def\elsLabel#1{\@bsphack\protected@write\@auxout{}%
         {\string\Newlabel{#1}{\@currentlabel}}\@esphack}
\def\Newlabel#1#2{\expandafter\xdef\csname X@#1\endcsname{#2}}

\def\elsRef#1{\@ifundefined{X@#1}{0}{\csname X@#1\endcsname}%
}

% This is the Abstract box
\newbox\absbox
\renewenvironment{abstract}{\global\setbox\absbox=\vbox\bgroup
  \singlespacing
  \hsize=\textwidth\def\baselinestretch{1}%
  \noindent\unskip\textbf{Abstract}
 \par\medskip\noindent\unskip\ignorespaces}
 {\egroup}

% This is the Keyword box
\newbox\keybox
\def\keyword{%
  \def\sep{\unskip, }%
 \def\MSC{\@ifnextchar[{\@MSC}{\@MSC[2000]}}
  \def\@MSC[##1]{\par\leavevmode\hbox {\it ##1~MSC:\space}}%
  \def\PACS{\par\leavevmode\hbox {\it PACS:\space}}%
  \def\JEL{\par\leavevmode\hbox {\it JEL:\space}}%
  \global\setbox\keybox=\vbox\bgroup\hsize=\textwidth
  \singlespacing
  \normalsize\normalfont\def\baselinestretch{1}
  \parskip\z@
  \noindent\textit{Keywords: }
  \raggedright                         % Keywords are not justified.
  \ignorespaces}
\def\endkeyword{\par \egroup}

% This defines what to do when we make our fancy title page.
% We also tell it to treat the standard "maketitle" this way.
\long\def\pprintMaketitle{\clearpage
  \def\baselinestretch{1}%
  \begin{center}%
 \thispagestyle{pprintTitle}%
   \def\baselinestretch{1}%
    \normalsize\@title\par\vskip12pt
    \ifvoid\keybox\else\unvbox\keybox\par\vskip12pt\fi
    \newpage
    \ifvoid\absbox\else\unvbox\absbox\par\vskip12pt\fi
    \end{center}%

  }

\def\maketitle{\pprintMaketitle}

\def\ps@pprintTitle{%
     \let\@oddhead\@empty
     \let\@evenhead\@empty
     \let\@evenfoot\@oddfoot}
 

% This defines some parts of the sections.
\def\@seccntDot{.}
\def\@seccntformat#1{\csname the#1\endcsname\@seccntDot\hskip 0.5em}

% We tell LaTeX to redefine the sections with our style
\renewcommand\section{\@startsection {section}{1}{\z@}%
           {18\p@ \@plus 6\p@ \@minus 3\p@}%
           {9\p@ \@plus 6\p@ \@minus 3\p@}%
           {\Large\bfseries\boldmath\MakeTextUppercase}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
           {12\p@ \@plus 6\p@ \@minus 3\p@}%
           {3\p@ \@plus 6\p@ \@minus 3\p@}%
           {\large\normalsize\bfseries\boldmath}}
\renewcommand\subsubsection{\@startsection{subsubsection}{3}{\z@}%
           {12\p@ \@plus 6\p@ \@minus 3\p@}%
           {\p@}%
           {\normalfont\large\itshape}}

% This treats our paragraphs to look right.
\def\paragraph{\secdef{\els@aparagraph}{\els@bparagraph}}
\def\els@aparagraph[#1]#2{\elsparagraph[#1]{#2.}}
\def\els@bparagraph#1{\elsparagraph*{#1.}}

% This is how our paragraphs will look within the sections
\newcommand\elsparagraph{\@startsection{paragraph}{4}{0\z@}%
           {10\p@ \@plus 6\p@ \@minus 3\p@}%
           {-6\p@}%
           {\normalfont\itshape}}
       
\let\baselinestretch=\@blstr

% We make the frontmatter environment, which is where we make the title.
\newenvironment{frontmatter}{}{\maketitle}

% We define a thing for custom captions
\long\def\@makecaption#1#2{%
  \vskip\abovecaptionskip\footnotesize
  \sbox\@tempboxa{#1: #2}%
  \ifdim \wd\@tempboxa >\hsize
    #1: #2\par
  \else
    \global \@minipagefalse
    \hb@xt@\hsize{\hfil\box\@tempboxa\hfil}%
  \fi
  \vskip\belowcaptionskip}

% We redefine the appendix with our specs.
\def\appendixname{Appendix }
\renewcommand\appendix{\par
  \setcounter{section}{0}%
  \setcounter{subsection}{0}%
  \setcounter{equation}{0}
  \gdef\thefigure{\@Alph\c@section.\arabic{figure}}%
  \gdef\thetable{\@Alph\c@section.\arabic{table}}%
  \gdef\thesection{\appendixname~\@Alph\c@section}%
  \@addtoreset{equation}{section}%
  \gdef\theequation{\@Alph\c@section.\arabic{equation}}%
  \addtocontents{toc}{\string\let\string\numberline\string\tmptocnumberline}{}{}
}



% This is old stuff from source package.  May not be necessary anymore, and I don't
% need it, but I'm leaving it here anyway.
%% Added for work with amsrefs.sty

\@ifpackageloaded{amsrefs}%
  {}
  {%\let\bibsection\relax%
  \AtBeginDocument{\def\cites@b#1#2,#3{%
    \begingroup[%
        \toks@{\InnerCite{#2}#1}%
        \ifx\@empty#3\@xp\@gobble\fi
        \cites@c#3%
}}}
%%
%% Added for avoiding clash with cleveref.sty

\@ifpackageloaded{cleveref}%
 {}
 {\def\tnotetext[#1]#2{\g@addto@macro\@tnotes{%
    \refstepcounter{tnote}%
    \immediate\write\@auxout{\string\Newlabel{#1}{\thetnote}}
    \def\thefootnote{\ifcase\c@tnote\or\ding{73}\or\ding{73}\ding{73}\fi}%
    \footnotetext{#2}}}
%%%
  \def\fntext[#1]#2{\g@addto@macro\@fnotes{%
    \refstepcounter{fnote}%
    \immediate\write\@auxout{\string\Newlabel{#1}{\thefnote}}
    \def\thefootnote{\thefnote}%
    \global\setcounter{footnote}{\thefnote}%
    \footnotetext{#2}}}
%%%
  \def\cortext[#1]#2{\g@addto@macro\@cornotes{%
    \refstepcounter{cnote}%
    \immediate\write\@auxout{\string\Newlabel{#1}{\thecnote}}
    \def\thefootnote{\ifcase\thecnote\or$\ast$\or
    $\ast\ast$\fi}%
    \footnotetext{#2}}}
}
\endinput
%%
%% End of file `joehreview.cls'.
