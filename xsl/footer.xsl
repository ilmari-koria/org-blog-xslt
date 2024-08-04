<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org"
                version="1.0">

  <xsl:template name="footer">
    <div id="postamble">
      <ul>
        <li>This page was last modified on <xsl:call-template name="generate-timestamp" />.</li>
        <li>Generated with: 
        <ol>
          <li>
            <a href="https://www.gnu.org/software/emacs/">GNU Emacs</a>
            <ul>
              <li>
                <a href="https://orgmode.org/">org-mode</a> and 
                <a href="https://github.com/ndw/org-to-xml">org-to-xml</a>
              </li>
            </ul>
          </li>
          <li>
            <a href="https://www.saxonica.com/download/java.xml">SaxonJ-HE</a>
          </li>
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
  </xsl:template>

  <xsl:template name="generate-timestamp">
    <xsl:value-of select="format-dateTime(current-dateTime(), '[Y0001]-[M01]-[D01] [H01]:[m01]:[s01]')"/>
  </xsl:template>

</xsl:stylesheet>
