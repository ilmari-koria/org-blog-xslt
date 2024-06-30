<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org">
  
 <xsl:output method="xml" indent="yes" omit-xml-declaration="yes"/>
  
   <xsl:variable name="meta-description" select="//org:keyword[@key = 'DESCRIPTION']/@value"/>
   <xsl:variable name="footnote-number" select="//org:footnote-reference/@label"/>
   <xsl:variable name="bibliography" select="document('../tmp/xml/bibliography/bibliography.xml')"/>

    <xsl:template match="/">
        <html>
            <head>
                <meta charset="UTF-8"/>
                <meta name="description" content="{$meta-description}"/>
                <meta name="author" content="ilmarikoria@posteo.net"/>
                <meta name="viewport" content="initial-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
                <link rel="canonical" href="https://ilmarikoria.xyz"/>
                <link rel="stylesheet" href="style.css" type="text/css"/>
                <title>
                    <xsl:value-of select="//org:keyword[@key = 'TITLE']/@value"/>
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

                        <h2><xsl:value-of select="//org:keyword[@key = 'TITLE']/@value"/></h2>
                        <xsl:if test="//org:keyword[@key = 'DATE']">
                        <p>Posted: <xsl:value-of select="//org:keyword[@key = 'DATE']/@value"/></p>
                        </xsl:if>

                       <xsl:apply-templates select="*" />

                         <xsl:if test="//org:headline/@raw-value = 'References'">
                           <div id="references">
                             <h2>References</h2>
                             <xsl:for-each-group select="//org:link[contains(@raw-link, 'cite:')]" group-by="@raw-link">
                               <xsl:variable name="key" select="substring-after(@raw-link, 'cite:')"/>
                               <xsl:variable name="bib-entry" select="$bibliography//*:a[@name = $key]/ancestor::*:tr"/>
                               <xsl:apply-templates select="current-group()[1]"/>
                               <p class="bib-entry">
                                 <xsl:value-of select="$bib-entry//*:td[@class = 'bibtexitem']"/>
                               </p>
                             </xsl:for-each-group>
                           </div>
                         </xsl:if>

                    </div>
                    </div>
                <div id="postamble">
                    <ul>
                        <li>This page was last modified on <xsl:call-template name="generate-timestamp"/>.</li>
                        <li>Generated with: <ol> <li><a href="https://www.gnu.org/software/emacs/"
                            >GNU Emacs</a></li> <li><a href="https://orgmode.org/">org-mode</a> and
                            <a href="https://github.com/ndw/org-to-xml">org-to-xml</a></li> <li><a
                            href="https://www.saxonica.com/download/java.xml">SaxonJ-HE</a></li>
                            </ol> </li>
                        <li>Public Key: <a
                            href="https://ilmarikoria.xyz/static/ilmari-koria-public-key.asc">D8DA
                            85D0 4C6A BD1F 8DA4 2895 3E3B 85AB 3A8D FFD4</a></li>
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

    <xsl:template name="generate-timestamp">
        <xsl:value-of select="current-date()"/>
    </xsl:template>

     <xsl:template match="org:headline/org:title">
       <xsl:if test="not(ancestor::org:headline[org:tags='ignore'])">
       <xsl:element name="h{../@level}">
       <xsl:apply-templates/>
       </xsl:element>
       </xsl:if>
    </xsl:template>
  
  <xsl:template match="org:headline/org:section">
    <xsl:apply-templates/>
  </xsl:template>

 <xsl:template match="org:plain-list[@type='ordered']">
        <ol>
            <xsl:apply-templates select="org:item/org:paragraph"/>
        </ol>
    </xsl:template>

    <!-- Template to match paragraph elements within item elements -->
    <xsl:template match="org:item/org:paragraph">
        <li>
            <xsl:value-of select="."/>
        </li>
    </xsl:template>

  <xsl:template match="org:item">
    <li>
      <xsl:apply-templates/>
    </li>
  </xsl:template>

  <xsl:template match="org:paragraph">
    <p>
      <xsl:apply-templates select="*[not(self::org:caption)] | text()"/>
    </p>
  </xsl:template>

  <xsl:template match="org:bold">
    <b><xsl:apply-templates/></b>
  </xsl:template>

  <xsl:template match="org:italic">
    <i><xsl:apply-templates/></i>
  </xsl:template>

  <xsl:template match="org:code">
    <code>
      <xsl:apply-templates/>
    </code>
  </xsl:template>

  <xsl:template match="org:link[@type='http' or @type='https']">
    <a href="{@raw-link}">
      <xsl:choose>
        <xsl:when test="@format='bracket'">
          <xsl:apply-templates/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="@raw-link"/>
        </xsl:otherwise>
      </xsl:choose>
    </a>
  </xsl:template>

  <xsl:template match="org:src-block">
    <pre>
      <code>
        <xsl:apply-templates/>
      </code>
    </pre>
  </xsl:template>

  <xsl:template match="org:link[contains(@raw-link, 'cite:')]">
    <xsl:variable name="key" select="substring-after(@raw-link, 'cite:')"/>
    <xsl:variable name="bib-entry" select="$bibliography//*:a[@name = $key]/ancestor::*:tr"/>
    <xsl:variable name="number" select="$bib-entry//*:a[@name = $key]/text()"/>
    <a href="#{$key}">[<xsl:value-of select="$number"/>]</a>
  </xsl:template>

    <xsl:template match="org:footnote-reference">
        <a href="#footnote{@label}">
            <xsl:value-of select="@label"/>
        </a>
    </xsl:template>

    <xsl:template match="org:footnote-definition">
        <div class="footnote">
            <span>[<xsl:value-of select="@label"/>]</span>
            <p id="footnote{@label}">
                <xsl:apply-templates/>
            </p>
        </div>
    </xsl:template>

<xsl:template match="org:link[@path and (substring(@path, string-length(@path) - 3) = '.gif' or substring(@path, string-length(@path) - 3) = '.jpg' or substring(@path, string-length(@path) - 4) = '.jpeg' or substring(@path, string-length(@path) - 3) = '.png')]">
    <figure>
        <img src="{@path}" alt="{@raw-link}"/>
        <xsl:apply-templates select="preceding-sibling::org:caption[1]"/>
    </figure>
</xsl:template>

<xsl:template match="org:caption">
    <figcaption>
        <xsl:apply-templates/>
    </figcaption>
</xsl:template>


    <!-- this stuff I don't want anywhere -->
   <xsl:template match="nil|structure|item/structure"/>


  <!-- <xsl:template match="element()"> -->
  <!--   <xsl:message>Unhandled: <xsl:value-of select="local-name(.)"/></xsl:message> -->

  <!--   <xsl:variable name="error" as="node()*"> -->
  <!--     <xsl:text>&lt;</xsl:text> -->
  <!--     <xsl:value-of select="local-name(.)"/> -->
  <!--     <xsl:text>&gt;</xsl:text> -->
  <!--     <xsl:apply-templates/> -->
  <!--     <xsl:text>&lt;/</xsl:text> -->
  <!--     <xsl:value-of select="local-name(.)"/> -->
  <!--     <xsl:text>&gt;</xsl:text> -->
  <!--   </xsl:variable> -->

  <!--   <xsl:choose> -->
  <!--     <xsl:when test="ancestor::org:paragraph"> -->
  <!--       <span class="error"><xsl:sequence select="$error"/></span> -->
  <!--     </xsl:when> -->
  <!--     <xsl:otherwise> -->
  <!--       <div class="error"><xsl:sequence select="$error"/></div> -->
  <!--     </xsl:otherwise> -->
  <!--   </xsl:choose> -->
  <!-- </xsl:template> -->


    <!-- <xsl:template match="//org:headline[not(tags = 'ignore')]"> -->
    <!--     <xsl:choose> -->
    <!--         <xsl:when test="@level = 1"> -->
    <!--             <h3> -->
    <!--                 <xsl:value-of select="@raw-value"/> -->
    <!--             </h3> -->
    <!--         </xsl:when> -->
    <!--         <xsl:when test="@level = 2"> -->
    <!--             <h4> -->
    <!--                 <xsl:value-of select="@raw-value"/> -->
    <!--             </h4> -->
    <!--         </xsl:when> -->
    <!--         <xsl:when test="@level = 3"> -->
    <!--             <h5> -->
    <!--                 <xsl:value-of select="@raw-value"/> -->
    <!--             </h5> -->
    <!--         </xsl:when> -->
    <!--         <xsl:otherwise> -->
    <!--             <xsl:value-of select="@raw-value"/> -->
    <!--         </xsl:otherwise> -->
    <!--     </xsl:choose> -->
    <!--     <xsl:apply-templates select="org:section"/> -->
    <!-- </xsl:template> -->


    <!-- <xsl:template match="org:section"> -->
    <!--     <xsl:apply-templates select="org:paragraph | org:quote-block"/> -->
    <!-- </xsl:template> -->


    <!-- <xsl:template match="org:quote-block"> -->
    <!--     <blockquote> -->
    <!--         <xsl:apply-templates select="org:paragraph"/> -->
    <!--     </blockquote> -->
    <!-- </xsl:template> -->


    
    <!-- <xsl:template match="org:tags"/> -->


    
    <!-- <xsl:template match="org:headline[@raw-value = 'References']" priority="3"/> -->


    
    <!-- <xsl:template match="org:paragraph"> -->
    <!--     <p> -->
    <!--         <xsl:apply-templates/> -->
    <!--     </p> -->
    <!-- </xsl:template> -->



    
    <!-- <xsl:template match="org:italic"> -->
    <!--     <i> -->
    <!--         <xsl:apply-templates/> -->
    <!--     </i> -->
    <!-- </xsl:template> -->



    <!-- <xsl:template match="org:bold"> -->
    <!--     <b> -->
    <!--         <xsl:apply-templates/> -->
    <!--     </b> -->
    <!-- </xsl:template> -->

    <!-- <xsl:template match="org:link"> -->
    <!--     <a href="{@raw-link}"> -->
    <!--         <xsl:choose> -->
    <!--             <xsl:when test="@format = 'plain'"> -->
    <!--                 <xsl:value-of select="@raw-link"/> -->
    <!--             </xsl:when> -->
    <!--             <xsl:otherwise> -->
    <!--                 <xsl:apply-templates/> -->
    <!--             </xsl:otherwise> -->
    <!--         </xsl:choose> -->
    <!--     </a> -->
    <!-- </xsl:template> -->





    <!-- <xsl:template match="org:link[@type = 'file']"> -->
    <!--     <figure> -->
    <!--         <img src="{@raw-link}" alt="{@path}"/> -->
    <!--     </figure> -->
    <!-- </xsl:template> -->



    <!-- <xsl:template match="org:caption" mode="figcaption"> -->
    <!--     <figcaption> -->
    <!--         <xsl:apply-templates/> -->
    <!--     </figcaption> -->
    <!-- </xsl:template> -->


    <!-- <xsl:template match="node() | @*"> -->
    <!--     <xsl:copy> -->
    <!--         <xsl:apply-templates select="node() | @*"/> -->
    <!--     </xsl:copy> -->
    <!-- </xsl:template> -->


</xsl:stylesheet>
