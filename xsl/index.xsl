<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

  <xsl:variable name="posts"
                select="document('../tmp/xml/concat/posts-concat.xml')" />

  <xsl:include href="header.xsl" />
  <xsl:include href="footer.xsl" />
  <xsl:include href="preamble.xsl" />

  <xsl:template match="/">
    <html>
      <xsl:call-template name="header">
        <xsl:with-param name="title" select="'About'" />
      </xsl:call-template>
      <body>
        <div id="container">
          <xsl:call-template name="preamble" />
          <div id="content">
            <div id="container-index">
              <div id="about">
                <h1>About</h1>
                <p>Hello! My name is Ilmari. This (work in progress)
                blog is simply for me to share assorted reflections on
                software, sound and zen.</p>
                <p>Some of my interests include:
                <ul>
                  <li>cycling</li>
                  <li>field recording/phonography</li>
                  <li>tinkering with free and open-source software</li>
                  <li>language learning, and</li>
                  <li>Zazen.</li>
                </ul>
                </p>
                <p>On the work side of things, I am a content markup
                technologies professional, currently functioning as a
                (XML) Content Analyst at Bloomsbury Publishing in
                London.</p>
                <p>Feel free to contact me via
                <a href="mailto:ilmarikoria@posteo.net">ilmarikoria@posteo.net</a> (Please find my public key below.)</p>
              </div>
              <div id="profile-pic">
                <figure>
                  <img src="static/profile-pic.jpg" alt="Selfie with mid-30s caucasian man."/>
                  <figcaption>
                    Me in 2024.   
                  </figcaption>
                </figure>
              </div>
            </div>
            <h2>Recent Posts</h2>
            <table>
              <xsl:for-each-group select="$posts/*:root/*:document/*:keyword[@key='TITLE']" group-by=".">
                <xsl:for-each select="current-group()">
                  <xsl:sort select="../*:keyword[@key='DATE']/@value" order="descending" data-type="text" />
                  <xsl:if test="position() &lt;= 3">
                    <xsl:variable name="title" select="@value" />
                    <xsl:variable name="date" select="../*:keyword[@key='DATE']/@value" />
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
        </div>
        <xsl:call-template name="footer" />
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
