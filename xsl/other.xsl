<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org">

  <xsl:output method="xml" indent="yes" omit-xml-declaration="yes" />

  <xsl:variable name="meta-description"
                select="//org:keyword[@key='DESCRIPTION']/@value" />
  <xsl:variable name="footnote-number"
                select="//org:footnote-reference/@label" />
  <xsl:variable name="bibliography"
                select="document('../tmp/xml/bibliography.xml')" />

  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8" />
        <meta name="description" content="{$meta-description}" />
        <meta name="author"      content="ilmarikoria@posteo.net" />
        <meta name="viewport"    content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <link rel="canonical"  href="https://ilmarikoria.xyz" />
        <link rel="stylesheet" href="style.css" type="text/css" />
        <title>
          <xsl:value-of select="//org:keyword[@key='TITLE']/@value" />
        </title>
      </head>
      <body>
        <div id="container">
        <div id="preamble">
          <h1>Ilmari's Webpage</h1>
          <ul>
            <li>
              <a href="https://ilmarikoria.xyz">Home</a>
            </li>
            <li>
              <a href="https://ilmarikoria.xyz/posts.html">Posts</a>
            </li>
            <li>
              <a href="https://ilmarikoria.xyz/ilmari-koria-resume.pdf">Résumé</a>
            </li>
            <li>
              <a href="https://freesound.org/people/ilmari_freesound/">Freesound</a>
            </li>
          </ul>
        </div>
        <div id="content">
        <h2>
          <xsl:value-of select="//org:keyword[@key='TITLE']/@value" />
        </h2>
        <p>Posted: 
        <xsl:value-of select="//org:keyword[@key='DATE']/@value" /></p>
        <xsl:apply-templates select="//org:headline" />

         <div id="footnotes">
            <h3>Footnotes</h3>
            <xsl:apply-templates select="//org:footnote-definition" />
          </div>
                
        	<div id="references">
                <h3>References</h3>
        	  <xsl:for-each-group select="//org:citation-reference"
        	                      group-by="@key">
        	  <xsl:apply-templates select="current-group()[1]" />
        	  </xsl:for-each-group>
        	</div>

        </div>
        </div>
        <div id="postamble">
        <ul>
          <li>This page was last modified on 
          <xsl:call-template name="generate-timestamp" />.</li>
          <li>Generated with: 
          	<ol>
          	  <li><a href="https://www.gnu.org/software/emacs/">GNU Emacs</a></li>
          	  <li><a href="https://orgmode.org/">org-mode</a> and <a href="https://github.com/ndw/org-to-xml">org-to-xml</a></li>
          	  <li><a href="https://www.saxonica.com/download/java.xml">SaxonJ-HE</a></li>
          	</ol>
          </li>
          <li>Public Key: <a href="https://ilmarikoria.xyz/static/ilmari-koria-public-key.asc">D8DA 85D0 4C6A BD1F 8DA4 2895 3E3B 85AB 3A8D FFD4</a></li>
          <li>
            <a href="https://creativecommons.org/licenses/by-nc/4.0/">License</a>
          </li>
          <li>
            <a href="#top">Top</a>
          </li>
        </ul>
        </div>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="//org:headline[not(org:tags = 'ignore')]">
    <xsl:choose>
      <xsl:when test="@level = 1">
        <h3>
          <xsl:value-of select="@raw-value" />
        </h3>
      </xsl:when>
      <xsl:when test="@level = 2">
        <h4>
          <xsl:value-of select="@raw-value" />
        </h4>
      </xsl:when>
      <xsl:when test="@level = 3">
        <h5>
          <xsl:value-of select="@raw-value" />
        </h5>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="@raw-value" />
      </xsl:otherwise>
    </xsl:choose>
    <xsl:apply-templates select="org:section" />
  </xsl:template>

  <xsl:template match="org:section">
    <xsl:apply-templates select="org:paragraph | org:quote-block" />
  </xsl:template>

  <xsl:template match="org:quote-block">
    <blockquote>
      <xsl:apply-templates select="org:paragraph"/>
    </blockquote>
  </xsl:template>

  <xsl:template match="org:tags" />

  <xsl:template match="org:headline[@raw-value='References']" priority="3" />

  <xsl:template match="org:paragraph">
    <p>
      <xsl:apply-templates select="node()" />
    </p>
  </xsl:template>

  <xsl:template match="org:italic">
    <i>
      <xsl:apply-templates select="node()" />
    </i>
  </xsl:template>

  <xsl:template match="org:bold">
    <b>
      <xsl:apply-templates select="node()" />
    </b>
  </xsl:template>

  <xsl:template match="org:citation">
    <xsl:for-each select="org:citation-reference">
      <xsl:variable name="key"
                    select="@key" />
      <xsl:variable name="bib-entry"
                    select="$bibliography//*:a[@name = $key]/ancestor::*:tr" />
      <xsl:variable name="number"
                    select="$bib-entry//*:a[@name = $key]" />
      <a href="#{$key}">[<xsl:value-of select="$number" />]</a>
    </xsl:for-each>
  </xsl:template>

  <xsl:template match="org:citation-reference">
    <xsl:variable name="key" select="@key" />
    <xsl:variable name="bib-entry"
                  select="$bibliography//*:a[@name = $key]/ancestor::*:tr" />
    <xsl:variable name="number"
                  select="$bib-entry//*:a[@name = $key]" />
    <ul>
      <li>
        <span id="{$key}">[<xsl:value-of select="$number" />]</span>
        <xsl:value-of select="$bib-entry//*:td[@class = 'bibtexitem']" />
      </li>
    </ul>
  </xsl:template>

  <xsl:template match="org:link">
    <a href="{@raw-link}">
      <xsl:choose>
        <xsl:when test="@format = 'plain'">
          <xsl:value-of select="@raw-link" />
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates />
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>

  <xsl:template match="org:link[@type='file']">
    <figure>
      <img src="{@raw-link}" alt="{@path}"></img>
    </figure>
  </xsl:template>

  <xsl:template match="org:caption" mode="figcaption">
    <figcaption>
      <xsl:apply-templates select="node()" />
    </figcaption>
  </xsl:template>

  <xsl:template match="org:footnote-reference">
    <a href="#footnote{@label}">
      <xsl:value-of select="@label" />
    </a>
  </xsl:template>

  <xsl:template match="org:footnote-definition">
    <div class="footnote">
      <span>[<xsl:value-of select="@label" />]</span>
      <p id="footnote{@label}">
        <xsl:apply-templates />
      </p>
    </div>
  </xsl:template>

  <xsl:template name="generate-timestamp">
    <xsl:value-of select="current-date()" />
  </xsl:template>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*" />
    </xsl:copy>
  </xsl:template>

</xsl:stylesheet>