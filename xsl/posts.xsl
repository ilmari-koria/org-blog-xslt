<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

  <xsl:variable name="posts"
                select="document('../tmp/xml/concat/posts-concat.xml')" />

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
                <a href="https://ilmarikoria.xyz/posts.html">Posts</a>
              </li>
              <li>
                <a href="https://ilmarikoria.xyz/ilmari-koria-resume.pdf">Résumé</a>
              </li>
              <li>
                <a href="https://freesound.org/people/ilmari_freesound/">Freesound</a>
              </li>
              <li>
                <a href="https://www.linkedin.com/in/ilmari-koria-3151a5291/">LinkedIn</a>
              </li>
              <li>
                <a href="https://www.youtube.com/@ilmarikoria">YouTube</a>
              </li>
            </ul>
          </div>
          <div id="content">
            <h2>Posts</h2>
            <table>
              <xsl:for-each-group select="$posts/*:root/*:document/*:keyword[@key='TITLE']"
                                  group-by=".">
                <xsl:for-each select="current-group()">
                  <xsl:sort select="../*:keyword[@key='DATE']/@value"
                            order="descending"
                            data-type="text" />
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
        <xsl:call-template name="footer-boilerplate" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
