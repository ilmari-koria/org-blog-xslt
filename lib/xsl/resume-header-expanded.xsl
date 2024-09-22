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

  <xsl:template name="resume-header-expanded">
        <xsl:text>\begin{greynote}</xsl:text>
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
    <xsl:text>\end{greynote}</xsl:text>
</xsl:template>
</xsl:stylesheet>
