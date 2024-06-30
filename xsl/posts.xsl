<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:org="https://nwalsh.com/ns/org-to-xml"
exclude-result-prefixes="org">
  <xsl:output method="xml" indent="yes"
  omit-xml-declaration="yes" />
  <xsl:variable name="meta-description"
  select="//org:keyword[@key = 'DESCRIPTION']/@value" />
  <xsl:variable name="posts"
  select="document('../tmp/xml/concat/posts-concat.xml')" />
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
            </ul>
          </div>
          <div id="content">
            <h2>Posts</h2>
            <table>
              <xsl:for-each-group select="$posts/*:root/*:document/*:keyword[@key='TITLE']"
              group-by=".">
                <xsl:for-each select="current-group()">
                  <xsl:variable name="title" select="@value" />
                  <xsl:variable name="date"
                  select="../*:keyword[@key='DATE']/@value" />
                  <tr>
                    <td>
                      <xsl:value-of select="$date" />
                    </td>
                    <td>
                      <a href="https://ilmarikoria.xyz/{$date}-blog.html">
                        <xsl:value-of select="$title" />
                      </a>
                    </td>
                  </tr>
                </xsl:for-each>
              </xsl:for-each-group>
            </table>
          </div>
        </div>
        <div id="postamble">
          <ul>
            <li>This page was last modified on 
            <xsl:call-template name="generate-timestamp" />.</li>
            <li>Generated with: 
            <ol>
              <li>
                <a href="https://www.gnu.org/software/emacs/">GNU
                Emacs</a>
              </li>
              <li>
              <a href="https://orgmode.org/">org-mode</a>and 
              <a href="https://github.com/ndw/org-to-xml">
              org-to-xml</a></li>
              <li>
                <a href="https://www.saxonica.com/download/java.xml">
                SaxonJ-HE</a>
              </li>
            </ol></li>
            <li>Public Key: 
            <a href="https://ilmarikoria.xyz/static/ilmari-koria-public-key.asc">
            D8DA 85D0 4C6A BD1F 8DA4 2895 3E3B 85AB 3A8D
            FFD4</a></li>
            <li>
              <a href="https://creativecommons.org/licenses/by-nc/4.0/">
              License</a>
            </li>
            <li>
              <a href="#top">Top</a>
            </li>
          </ul>
        </div>
      </body>
    </html>
  </xsl:template>
  <xsl:template name="generate-timestamp">
    <xsl:value-of select="current-date()" />
  </xsl:template>
</xsl:stylesheet>
