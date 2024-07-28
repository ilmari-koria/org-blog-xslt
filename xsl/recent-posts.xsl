<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org"
                version="1.0">

  <xsl:variable name="posts"
                select="document('../tmp/xml/concat/posts-concat.xml')" />

  <xsl:template match="/">
    <html>
          <div id="recent-posts">
            <h2>Recent Posts</h2>
            <table>
              <xsl:for-each-group select="$posts/*:root/*:document/*:keyword[@key='TITLE']"
                                  group-by=".">
                <xsl:for-each select="current-group()">
                  <xsl:sort select="../*:keyword[@key='DATE']/@value"
                            order="descending"
                            data-type="text" />
                  <xsl:if test="position() &lt;= 3">
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
                  </xsl:if>
                </xsl:for-each>
              </xsl:for-each-group>
            </table>
          </div>
    </html>
  </xsl:template>


</xsl:stylesheet>
