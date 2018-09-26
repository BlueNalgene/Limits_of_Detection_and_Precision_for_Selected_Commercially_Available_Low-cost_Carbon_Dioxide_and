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
\RequirePackage[round,super,sort&compress]{natbib}
\RequirePackage{textcase} %required to automatically use uppercase for sections
\RequirePackage{setspace} %required to force singlespacing in abstract/keywords
\RequirePackage[nomarkers]{endfloat} %joeh requires all floats be at the end of the doc
\pagenumbering{gobble} %no page numbers
\let\comma\@empty
\let\tnotesep\@empty
\def\title#1{\gdef\@title{#1}}
\def\altauthor#1{\gdef\\@altauthor{#1}}
\let\@title\@empty

%%%%%%
\def\elsLabel#1{\@bsphack\protected@write\@auxout{}%
         {\string\Newlabel{#1}{\@currentlabel}}\@esphack}
\def\Newlabel#1#2{\expandafter\xdef\csname X@#1\endcsname{#2}}

\def\elsRef#1{\@ifundefined{X@#1}{0}{\csname X@#1\endcsname}%
}

\def\tnotemark[#1]{\textsuperscript{\@for\@@tmark:=#1\do{%
			\edef\tnotenum{\@ifundefined{X@\@@tmark}{1}{\elsRef{\@@tmark}}}%
			\ifcase\tnotenum\or\ding{73}\or,\ding{73}\ding{73}\fi}}%
}
\let\@tnotemark\@empty

\let\@tnotes\@empty
\RequirePackage{pifont}
\newcounter{tnote}
\def\tnotetext[#1]#2{\g@addto@macro\@tnotes{%
		\refstepcounter{tnote}\elsLabel{#1}%
		\def\thefootnote{\ifcase\c@tnote\or\ding{73}\or\ding{73}\ding{73}\fi}%
		\footnotetext{#2}}}

\let\@nonumnotes\@empty
\def\nonumnote#1{\g@addto@macro\@nonumnotes{%
		\let\thefootnote\relax\footnotetext{#1}}}

\newcounter{fnote}
\def\fnmark[#1]{\let\comma\@empty
	\def\@fnmark{\@for\@@fnmark:=#1\do{%
			\edef\fnotenum{\@ifundefined{X@\@@fnmark}{1}{\elsRef{\@@fnmark}}}%
			\unskip\comma\fnotenum\let\comma,}}%
}

\let\@fnotes\@empty\let\@fnmark\@empty
\def\fntext[#1]#2{\g@addto@macro\@fnotes{%
		\refstepcounter{fnote}\elsLabel{#1}%
		\def\thefootnote{\thefnote}%
		\global\setcounter{footnote}{\thefnote}%
		\footnotetext{#2}}}

\def\cormark[#1]{\edef\cnotenum{\elsRef{#1}}%
	\unskip\textsuperscript{\sep\ifcase\cnotenum\or
		$\ast$\or$\ast\ast$\fi\hspace{-1pt}}\let\sep=,}

\let\@cormark\@empty
\let\@cornotes\@empty
\newcounter{cnote}
\def\cortext[#1]#2{\g@addto@macro\@cornotes{%
		\refstepcounter{cnote}\elsLabel{#1}%
		\def\thefootnote{\ifcase\thecnote\or$\ast$\or
			$\ast\ast$\fi}%
		\footnotetext{#2}}}

\let\@corref\@empty
\def\corref#1{\edef\cnotenum{\elsRef{#1}}%
	\edef\@corref{\ifcase\cnotenum\or
		$\ast$\or$\ast\ast$\fi\hskip-1pt}}

\def\fnref#1{\fnmark[#1]}
\def\tnoteref#1{\tnotemark[#1]}

\def\resetTitleCounters{\c@cnote=0
	\c@fnote=0 \c@tnote=0 \c@footnote=0}

\let\eadsep\@empty
\let\@elseads\@empty
\let\@elsuads\@empty
\let\@cormark\@empty
\def\hashchar{\expandafter\@gobble\string\~}
\def\underscorechar{\expandafter\@gobble\string\_}
\def\lbracechar{\expandafter\@gobble\string\{}
\def\rbracechar{\expandafter\@gobble\string\}}

\def\ead{\@ifnextchar[{\@uad}{\@ead}}
\gdef\@ead#1{\bgroup\def\_{\string\underscorechar\space}%
	\def\{{\string\lbracechar\space}%
	\def~{\hashchar\space}%
	\def\}{\string\rbracechar\space}%
	\edef\tmp{\the\@eadauthor}
	\immediate\write\@auxout{\string\emailauthor
		{#1}{\expandafter\strip@prefix\meaning\tmp}}%
	\egroup
}
\newcounter{ead}
\gdef\emailauthor#1#2{\stepcounter{ead}%
	\g@addto@macro\@elseads{\raggedright%
		\let\corref\@gobble
		\eadsep\texttt{#1} (#2)\def\eadsep{\unskip,\space}}%
}
\gdef\@uad[#1]#2{\bgroup
	\def~{\string\hashchar\space}%
	\def\_{\string\underscorechar\space}%
	\edef\tmp{\the\@eadauthor}
	\immediate\write\@auxout{\string\urlauthor
		{#2}{\expandafter\strip@prefix\meaning\tmp}}%
	\egroup
}
\def\urlauthor#1#2{\g@addto@macro\@elsuads{\let\corref\@gobble%
		\raggedright\eadsep\texttt{#1}\space(#2)%
		\def\eadsep{\unskip,\space}}%
}

\def\elsauthors{}
\def\pprinttitle{}
\let\authorsep\@empty
\let\sep\@empty
\newcounter{author}
\def\author{\@ifnextchar[{\@@author}{\@author}}

\newtoks\@eadauthor
\def\@@author[#1]#2{\g@addto@macro\elsauthors{%
		\def\baselinestretch{1}%
		\authorsep#2\unskip\textsuperscript{%#1%
			\@for\@@affmark:=#1\do{%
				\edef\affnum{\@ifundefined{X@\@@affmark}{1}{\elsRef{\@@affmark}}}%
				\unskip\sep\affnum\let\sep=,}%
			\ifx\@fnmark\@empty\else\unskip\sep\@fnmark\let\sep=,\fi
			\ifx\@corref\@empty\else\unskip\sep\@corref\let\sep=,\fi
		}%
		\def\authorsep{\unskip,\space}%
		\global\let\sep\@empty\global\let\@corref\@empty
		\global\let\@fnmark\@empty}%
	\@eadauthor={#2}
}

\def\@author#1{\g@addto@macro\elsauthors{\normalsize%
		\def\baselinestretch{1}%
		\upshape\authorsep#1\unskip\textsuperscript{%
			\ifx\@fnmark\@empty\else\unskip\sep\@fnmark\let\sep=,\fi
			\ifx\@corref\@empty\else\unskip\sep\@corref\let\sep=,\fi
		}%
		\def\authorsep{\unskip,\space}%
		\global\let\@fnmark\@empty
		\global\let\@corref\@empty
		\global\let\sep\@empty}%
	\@eadauthor={#1}
}

\def\elsaddress{}
\def\addsep{\par\vskip6pt}
\def\address{\@ifnextchar[{\@@address}{\@address}}

\def\@alph#1{%
	\ifcase#1\or a\or b\or c\or d\or e\or f\or g\or h\or i\or j\or k\or
	l\or m\or n\or o\or p\or q\or r\or s\or t\or u\or v\or w\or x\or
	y\or z%
	\or aa\or ab\or ac\or ad\or ae\or af\or ag\or ah\or ai\or aj\or
	ak\or al\or am\or an\or ao\or ap\or aq\or ar\or as\or at\or au\or
	av\or aw\or ax\or ay\or az%
	\or ba\or bb\or bc\or bd\or be\or bf\or bg\or bh\or bi\or bj\or
	bk\or bl\or bm\or bn\or bo\or bp\or bq\or br\or bs\or bt\or bu\or
	bv\or bw\or bx\or by\or bz%
	\or ca\or cb\or cc\or cd\or ce\or cf\or cg\or ch\or ci\or cj\or
	ck\or cl\or cm\or cn\or co\or cp\or cq\or cr\or cs\or ct\or cu\or
	cv\or cw\or cx\or cy\or cz%
	\or da\or db\or dc\or dd\or de\or df\or dg\or dh\or di\or dj\or
	dk\or dl\or dm\or dn\or do\or dp\or dq\or dr\or ds\or dt\or du\or
	dv\or dw\or dx\or dy\or dz%
	\or ea\or eb\or ec\or ed\or ee\or ef\or eg\or eh\or ei\or ej\or
	ek\or el\or em\or en\or eo\or ep\or eq\or er\or es\or et\or eu\or
	ev\or ew\or ex\or ey\or ez%
	\or fa\or fb\or fc\or fd\or fe\or ff\or fg\or fh\or fi\or fj\or
	fk\or fl\or fm\or fn\or fo\or fp\or fq\or fr\or fs\or ft\or fu\or
	fv\or fw\or fx\or fy\or fz%
	\or ga\or gb\or gc\or gd\or ge\or gf\or gg\or gh\or gi\or gj\or
	gk\or gl\or gm\or gn\or go\or gp\or gq\or gr\or gs\or gt\or gu\or
	gv\or gw\or gx\or gy\or gz%
	\else\@ctrerr\fi}

\newcounter{affn}
\renewcommand\theaffn{\alph{affn}}

\long\def\@@address[#1]#2{\g@addto@macro\elsaddress{%
		\def\baselinestretch{1}%
		\refstepcounter{affn}
		\xdef\@currentlabel{\theaffn}
		\elsLabel{#1}%
		\textsuperscript{\theaffn}#2\par}}

\long\def\@address#1{\g@addto@macro\elsauthors{%
		\def\baselinestretch{1}%
		\addsep\footnotesize\itshape#1\def\addsep{\par\vskip6pt}%
		\def\authorsep{\par\vskip8pt}}}
	
	%%%%%




% This is the Abstract box
\newbox\absbox
\renewenvironment{abstract}{\global\setbox\absbox=\vbox\bgroup
  \hsize=\textwidth\def\baselinestretch{1}%
  \noindent\unskip{\LARGE\bfseries\boldmath\MakeTextUppercase{Abstract}}
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
    \LARGE\@title\par\vskip12pt
    \normalsize\elsauthors\par\vskip10pt
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
           {\LARGE\bfseries\boldmath\MakeTextUppercase}}
\renewcommand\subsection{\@startsection{subsection}{2}{\z@}%
           {12\p@ \@plus 6\p@ \@minus 3\p@}%
           {3\p@ \@plus 6\p@ \@minus 3\p@}%
           {\Large\normalsize\bfseries\boldmath}}
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
    #1. #2\par
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

%\@ifpackageloaded{amsrefs}%
%  {}
%  {%\let\bibsection\relax%
%  \AtBeginDocument{\def\cites@b#1#2,#3{%
%    \begingroup[%
%        \toks@{\InnerCite{#2}#1}%
%        \ifx\@empty#3\@xp\@gobble\fi
%        \cites@c#3%
%}}}
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
