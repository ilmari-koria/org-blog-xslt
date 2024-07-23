<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

  <xsl:variable name="footnote-number"
               select="//org:footnote-reference/@label" />

  <xsl:variable name="bibliography"
               select="document('../tmp/xml/bibliography/bibliography.xml')" />

  <xsl:include href="head.xsl" />
  <xsl:include href="footer.xsl" />

  <xsl:template match="/">
    <html>
      <xsl:call-template name="header-boilerplate" />
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
                        <a href="#{$key}">
                          <!-- TODO check xsl:text whitespace issue --> 
                          <xsl:text>[</xsl:text>
                          <xsl:value-of select="$number" />
                          <xsl:text>]</xsl:text>
                        </a>
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
                        <td id="footnote{$footnote-label}">
                          <xsl:text>[</xsl:text>
                          <a href="#footnote{$footnote-label}">
                            <xsl:value-of select="$footnote-label" />
                          </a>
                          <xsl:text>]</xsl:text>
                        </td>
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
        <xsl:call-template name="footer-boilerplate" />
      </body>
    </html>
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
    <sup>
      <a href="#footnote{@label}">
        <xsl:value-of select="@label" />
      </a>
    </sup>
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
    <blockquote class="verse-block">
      <xsl:analyze-string select="."
                          regex="([^\r\n]+)">
        <xsl:matching-substring>
          <xsl:value-of select="."/>
          <br/>
        </xsl:matching-substring>
      </xsl:analyze-string>
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
    <xsl:variable name="mailto-link"
                  select="@path" />
    <a href="mailto:{normalize-space($mailto-link)}">
      <xsl:value-of select="." />
    </a>
  </xsl:template>

  <xsl:template match="org:nil|org:structure|org:item/org:structure|org:tags|org:footnote-definition/org:paragraph" />

</xsl:stylesheet>
