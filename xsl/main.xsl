<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:org="https://nwalsh.com/ns/org-to-xml"
exclude-result-prefixes="org">
  <xsl:output method="xml" indent="yes"
  omit-xml-declaration="yes" />
  <xsl:variable name="meta-description"
  select="//org:keyword[@key = 'DESCRIPTION']/@value" />
  <xsl:variable name="footnote-number"
  select="//org:footnote-reference/@label" />
  <xsl:variable name="bibliography"
  select="document('../tmp/xml/bibliography/bibliography.xml')" />
  <xsl:template match="/">
    <html>
      <head>
        <meta charset="UTF-8" />
        <meta name="description" content="{$meta-description}" />
        <meta name="author" content="ilmarikoria@posteo.net" />
        <meta name="viewport"
        content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no" />
        <link rel="canonical" href="https://ilmarikoria.xyz" />
        <link rel="stylesheet" href="style.css" type="text/css" />
        <title>
          <xsl:value-of select="//org:keyword[@key = 'TITLE']/@value" />
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
                <a href="https://ilmarikoria.xyz/posts.html">
                Posts</a>
              </li>
              <li>
                <a href="https://ilmarikoria.xyz/ilmari-koria-resume.pdf">
                Résumé</a>
              </li>
              <li>
                <a href="https://freesound.org/people/ilmari_freesound/">
                Freesound</a>
              </li>
              <li>
                <a href="https://www.linkedin.com/in/ilmari-koria-3151a5291/">
                LinkedIn</a>
              </li>
              <li>
                <a href="https://www.youtube.com/@ilmarikoria">
                YouTube</a>
              </li>
            </ul>
          </div>
          <div id="content">
            <h1>
              <xsl:value-of select="//org:keyword[@key = 'TITLE']/@value" />
            </h1>
            <xsl:if test="//org:keyword[@key = 'DATE']">
              <p>Posted: 
              <xsl:value-of select="//org:keyword[@key = 'DATE']/@value" /></p>
            </xsl:if>
            <xsl:apply-templates select="*" />
            <xsl:if test="//org:link[contains(@raw-link, 'cite:')] != ''">
              <div id="references">
                <h2>References</h2>
                <table>
                  <xsl:for-each-group select="//org:link[contains(@raw-link, 'cite:')]"
                  group-by="@raw-link">
                    <xsl:variable name="key"
                    select="substring-after(@raw-link, 'cite:')" />
                    <xsl:variable name="bib-entry"
                    select="$bibliography//*:a[@name = $key]/ancestor::*:tr" />
                    <xsl:variable name="number"
                    select="$bib-entry//*:a[@name = $key]/text()" />
                    <tr>
                      <td>
                        <a href="#{$key}">[<xsl:value-of select="$number" />]</a>
                      </td>
                      <td>
                        <xsl:value-of select="$bib-entry//*:td[@class = 'bibtexitem']" />
                      </td>
                    </tr>
                  </xsl:for-each-group>
                </table>
              </div>
            </xsl:if>
            <xsl:if test="//org:footnote-definition != ''">
              <div class="footnotes">
                <h2>Footnotes</h2>
                <table>
                  <xsl:for-each-group select="//org:footnote-definition"
                  group-by="org:paragraph">
                    <xsl:for-each select="current-group()">
                      <xsl:variable name="footnote-label"
                      select="@label" />
                      <tr>
                        <td id="footnote{$footnote-label}">[<a href="#footnote{$footnote-label}"><xsl:value-of select="$footnote-label" /></a>]</td>
                        <td>
                          <xsl:value-of select="normalize-space(org:paragraph)" />
                        </td>
                      </tr>
                    </xsl:for-each>
                  </xsl:for-each-group>
                </table>
              </div>
            </xsl:if>
          </div>
        </div>
        <div id="postamble">
          <ul>
            <li>This page was last modified on <xsl:call-template name="generate-timestamp" />.</li>
            <li>Generated with: 
                  <ol>
                    <li><a href="https://www.gnu.org/software/emacs/">GNU Emacs</a>
                      <ul>
                        <li><a href="https://orgmode.org/">org-mode</a> and <a href="https://github.com/ndw/org-to-xml">org-to-xml</a></li>
                      </ul>
                    </li>
                    <li><a href="https://www.saxonica.com/download/java.xml">SaxonJ-HE</a></li>
                  </ol>
            </li>
            <li><a href="https://github.com/ilmari-koria">GitHub</a></li>
            <li>Public Key: <a href="https://ilmarikoria.xyz/static/ilmari-koria-public-key.asc">D8DA 85D0 4C6A BD1F 8DA4 2895 3E3B 85AB 3A8D FFD4</a></li>
            <li><a href="https://creativecommons.org/licenses/by-nc/4.0/">License</a></li>
            <li><a href="#top">Top</a></li>
          </ul>
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="generate-timestamp">
    <xsl:value-of select="current-date()" />
  </xsl:template>
  <xsl:template match="org:headline/org:title">
    <xsl:if test="not(ancestor::org:headline[org:tags='ignore'])">
      <xsl:element name="h{../@level}">
        <xsl:apply-templates />
      </xsl:element>
    </xsl:if>
  </xsl:template>
  <xsl:template match="org:headline/org:section">
    <xsl:apply-templates />
  </xsl:template>
  <xsl:template match="org:plain-list[@type='ordered']">
    <ol>
      <xsl:apply-templates select="org:item/org:paragraph" />
    </ol>
  </xsl:template>
  <xsl:template match="org:item/org:paragraph">
    <li>
      <xsl:value-of select="." />
    </li>
  </xsl:template>
  <xsl:template match="org:item">
    <li>
      <xsl:apply-templates />
    </li>
  </xsl:template>
  <xsl:template match="org:paragraph">
    <p>
      <xsl:apply-templates select="*[not(self::org:caption)] | text()" />
    </p>
  </xsl:template>
  <xsl:template match="org:bold">
    <b>
      <xsl:apply-templates />
    </b>
  </xsl:template>
  <xsl:template match="org:italic">
    <i>
      <xsl:apply-templates />
    </i>
  </xsl:template>
  <xsl:template match="org:code">
    <code>
      <xsl:apply-templates />
    </code>
  </xsl:template>
  <xsl:template match="org:link[@type='http' or @type='https']">
    <a href="{@raw-link}">
      <xsl:choose>
        <xsl:when test="@format='bracket'">
          <xsl:apply-templates />
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@raw-link" />
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>
  <xsl:template match="org:src-block">
    <pre>
<code>
<xsl:apply-templates />
</code>
</pre>
  </xsl:template>
  <xsl:template match="org:link[contains(@raw-link, 'cite:')]">
    <xsl:variable name="key"
    select="substring-after(@raw-link, 'cite:')" />
    <xsl:variable name="bib-entry"
    select="$bibliography//*:a[@name = $key]/ancestor::*:tr" />
    <xsl:variable name="number"
    select="$bib-entry//*:a[@name = $key]/text()" />
    <a href="#{$key}">[<xsl:value-of select="$number" />]</a>
  </xsl:template>
  <xsl:template match="org:footnote-reference">
    <sup><a href="#footnote{@label}">
      <xsl:value-of select="@label" />
    </a></sup>
  </xsl:template>
  <xsl:template match="org:link[@path and (substring(@path, string-length(@path) - 3) = '.gif' or substring(@path, string-length(@path) - 3) = '.jpg' or substring(@path, string-length(@path) - 4) = '.jpeg' or substring(@path, string-length(@path) - 3) = '.png')]">
    <figure>
      <img src="{@path}" alt="{@raw-link}" />
      <xsl:apply-templates select="preceding-sibling::org:caption[1]" />
    </figure>
  </xsl:template>
  <xsl:template match="org:caption">
    <figcaption>
      <xsl:apply-templates />
    </figcaption>
  </xsl:template>
  <xsl:template match="org:verse-block">
    <blockquote>
      <xsl:apply-templates />
    </blockquote>
  </xsl:template>
  <xsl:template match="org:quote-block">
    <blockquote>
      <xsl:apply-templates />
    </blockquote>
  </xsl:template>
  <xsl:template match="org:export-block[@type='HTML']">
    <xsl:variable name="html-code-block"
    select="normalize-space(@value)" />
    <xsl:value-of select="$html-code-block"
    disable-output-escaping="yes" />
  </xsl:template>
  <xsl:template match="org:link[@type='mailto']">
    <xsl:variable name="mailto-link" select="@path"/>
    <a href="mailto:{normalize-space($mailto-link)}"><xsl:value-of select="."/></a>
  </xsl:template>
  <xsl:template match="org:nil|org:structure|org:item/org:structure|org:tags|org:footnote-definition/org:paragraph" />
</xsl:stylesheet>


