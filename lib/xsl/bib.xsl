<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org"
                version="2.0">

  <xsl:output method="xml"
              encoding="UTF-8"
              indent="yes"/>

  <xsl:variable name="bibliography"
                select="document('../../xml/bib.xml')" />
  
  <xsl:template name="bib">
    <xsl:if test="//org:link[contains(@raw-link, 'cite:')] != ''">
      <div id="references">
        <h2>References</h2>
        <table>
          <xsl:for-each-group select="//org:link[contains(@raw-link, 'cite:')]"
                              group-by="@raw-link">
            <xsl:variable name="key"
                          select="substring-after(@raw-link, 'cite:')" />
            <xsl:variable name="bib-entry"
                          select="$bibliography/bib/entry[@key = $key]" />
            <xsl:variable name="number"
                          select="$bib-entry/ref-num" />
            <tr>
              <td>
                <p id="{$key}">[<a href="#{$key}"><xsl:value-of select="$number" /></a>] </p>
              </td>
              <td>
                <xsl:if test="$bib-entry/author">
                  <xsl:value-of select="$bib-entry/author"/> (<xsl:value-of select="$bib-entry/year"/>).
                </xsl:if>
                <xsl:if test="$bib-entry/title">
                  <xsl:value-of select="$bib-entry/title"/> 
                </xsl:if>
                <xsl:if test="$bib-entry/booktitle">
                  <xsl:value-of select="$bib-entry/booktitle"/> 
                </xsl:if>
                <xsl:if test="$bib-entry/publisher">
                  <xsl:value-of select="$bib-entry/publisher"/>, 
                </xsl:if>
                <xsl:if test="$bib-entry/pages">
                  pp. <xsl:value-of select="$bib-entry/pages"/> 
                </xsl:if>
                <xsl:if test="$bib-entry/url">
                  <xsl:text> Available at: </xsl:text>
                  <a href="{ $bib-entry/url }">
                    <xsl:value-of select="$bib-entry/url"/>
                  </a>
                </xsl:if>
                <xsl:if test="$bib-entry/doi">
                  <xsl:text> DOI: </xsl:text>
                  <a href="https://doi.org/{ $bib-entry/doi }">
                    <xsl:value-of select="$bib-entry/doi"/>
                  </a>
                </xsl:if>
              </td>
            </tr>
          </xsl:for-each-group>
        </table>
      </div>
    </xsl:if>
  </xsl:template>
</xsl:stylesheet>
