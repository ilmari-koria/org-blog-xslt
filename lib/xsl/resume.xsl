<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:r="http://ilmarikoria.xyz/ilmari-koria-resume.pdf"
                exclude-result-prefixes="xs r"
                version="3.0">

  <xsl:strip-space elements="*"/>

  <xsl:output method="text"
              encoding="UTF-8"
              indent="no"
              omit-xml-declaration="yes"/>
  <xsl:template match="/">
    <!-- header --> 
    <xsl:text>
      \input{../../lib/tex/resume-header.tex}
      \begin{document}
      \pagestyle{fancy}
    </xsl:text>
    <!-- name top --> 
    <xsl:text>\section*{</xsl:text>
    	<xsl:value-of select="resume/header/name"/>
    <xsl:text>}</xsl:text>
    <!-- top meta -->    
        <xsl:text>Résumé: Generated </xsl:text><xsl:value-of select="format-date(current-date(), '[D01] [MNn] [Y0001]')"/>
        <xsl:text> --- </xsl:text>
        <xsl:text>\href{mailto:</xsl:text>
        	<xsl:value-of select="resume/header/email/@mailto"/>
        	<xsl:text>}</xsl:text>
        	<xsl:text>{</xsl:text>
        	<xsl:value-of select="resume/header/email"/>
        <xsl:text>}</xsl:text>
        <xsl:text> --- </xsl:text>
        <xsl:value-of select="resume/header/address"/>
        <xsl:text> --- </xsl:text>
        <xsl:text>\chtex{華文姓名：}</xsl:text>
        <xsl:text>\ruby{\chtex{</xsl:text>
        	<xsl:value-of select="/resume/header/name-zh/family"/>
        	<xsl:text>}}{</xsl:text>
        	<xsl:value-of select="/resume/header/name-zh-pinyin/family"/>
        <xsl:text>}</xsl:text>
        <xsl:text>\ruby{\chtex{</xsl:text>
        	<xsl:value-of select="/resume/header/name-zh/given-first"/>
        	<xsl:text>}}{</xsl:text>
        	<xsl:value-of select="/resume/header/name-zh-pinyin/given-first"/>
        <xsl:text>}</xsl:text>
        <xsl:text>\ruby{\chtex{</xsl:text>
        	<xsl:value-of select="/resume/header/name-zh/given-second"/>
        	<xsl:text>}}{</xsl:text>
        	<xsl:value-of select="/resume/header/name-zh-pinyin/given-second"/>
        <xsl:text>}</xsl:text>
        <xsl:text> --- </xsl:text>
        <xsl:text> \href{</xsl:text>
        	<xsl:value-of select="resume/header/website/@href"/>
        	<xsl:text>}</xsl:text>
        	<xsl:text>{</xsl:text>
        	<xsl:value-of select="resume/header/website"/>
        <xsl:text>}</xsl:text>
        <xsl:text> --- </xsl:text>
        <xsl:text>\href{</xsl:text>
        	<xsl:value-of select="resume/header/github/@href"/>
        	<xsl:text>}</xsl:text>
        	<xsl:text>{</xsl:text>
        	<xsl:value-of select="resume/header/github"/>
        <xsl:text>}</xsl:text>
        <xsl:text> --- </xsl:text>
        <xsl:text>Public key: \href{</xsl:text>
        	<xsl:value-of select="resume/header/public-key/@href"/>
        	<xsl:text>}</xsl:text>
        	<xsl:text>{\texttt{</xsl:text>
        	<xsl:value-of select="resume/header/public-key"/>
        <xsl:text>}}</xsl:text>
        <xsl:text> --- </xsl:text>
        <xsl:text>References: </xsl:text>
         	<xsl:value-of select="resume/header/references"/>
        <xsl:text> --- </xsl:text>
        <xsl:text>\href{</xsl:text>
        	<xsl:value-of select="resume/header/name-audio/@href"/>
        	<xsl:text>}</xsl:text>
        	<xsl:text>{</xsl:text>
        	<xsl:value-of select="resume/header/name-audio"/>
        <xsl:text>}</xsl:text>
    <!-- about  -->
    <xsl:text>
    	\subsection*{About}
    </xsl:text>
    <xsl:value-of select="resume/about" />
    <!-- experience -->
    <xsl:text>
      \subsection*{Experience}
    </xsl:text>
    <xsl:for-each select="resume/experience/experience-entry">
      <xsl:text>
        \subsubsection*{
      </xsl:text>
      <xsl:text>\textbf{</xsl:text>
      	<xsl:value-of select="company"/>
        <xsl:text>}</xsl:text>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="department"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="address"/>
      <xsl:text>}</xsl:text>
      <xsl:text>\begin{itemize}</xsl:text>
      	<xsl:text>\item\emph{</xsl:text>
      	<xsl:value-of select="role"/>
      		<xsl:text>}, </xsl:text>
        	<xsl:value-of select="time-start"/>
       		<xsl:text> -- </xsl:text>
        	<xsl:value-of select="time-end"/>
                <xsl:text>\begin{itemize}</xsl:text>               
                	<xsl:for-each select="role-achievements/achievement">
                	  <xsl:text>\item </xsl:text>
                	  <xsl:value-of select="."/>
                	  <xsl:text> </xsl:text>
                	</xsl:for-each>
                <xsl:text>\end{itemize}</xsl:text>
      <xsl:text>\end{itemize}</xsl:text>
    </xsl:for-each>
    <xsl:text>
      \subsection*{Education}
    </xsl:text>
    <xsl:text>\begin{itemize}</xsl:text>
        <xsl:for-each select="resume/education/education-entry">
              <xsl:text>\item </xsl:text>
                  <xsl:text>\textbf{</xsl:text>
                      <xsl:value-of select="institute"/>
                  <xsl:text>}, </xsl:text>
                  <xsl:value-of select="result"/>
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="address"/>
        </xsl:for-each>
    <xsl:text>\end{itemize}</xsl:text>
    <xsl:text>
      \subsection*{Technical Training}
    </xsl:text>
    <xsl:text>\begin{itemize}</xsl:text>
        <xsl:for-each select="resume/training/training-entry">
              <xsl:text>\item </xsl:text>
                  <xsl:text>\textit{</xsl:text>
                      <xsl:value-of select="name"/>
                  <xsl:text>}, </xsl:text>
                  <xsl:value-of select="institute"/>
                  <xsl:text>, </xsl:text>
                  <xsl:value-of select="training-hours"/>
                  <xsl:text> hrs., </xsl:text>
                  <xsl:value-of select="date"/>
        </xsl:for-each>
    <xsl:text>\end{itemize}</xsl:text>
    <xsl:text>
      \subsection*{Technical Tools and Language Skills }
    </xsl:text>
    <xsl:for-each select="resume/skill-list/skill-entry">
      <xsl:value-of select="."/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text> --- </xsl:text>
    <xsl:for-each select="resume/language-list/language-entry">
      <xsl:value-of select="language"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="level"/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>.</xsl:text>
  <xsl:text>\end{document}</xsl:text>
</xsl:template>
</xsl:stylesheet>
