<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:b="http://ilmarikoria.xyz/atom.xml"
                exclude-result-prefixes="bf">

  <xsl:output method="xml" indent="yes"/>

  <xsl:variable name="directory-path" select="'file:///home/username/xmlfiles/'"/>
  
  <xsl:template match="/">
    <b:blog-feed>
      <xsl:for-each select="collection(concat($directory-path, '?select=*.xml;recurse=no'))">
        <xsl:copy-of select="/*"/>
      </xsl:for-each>
    </b:blog-feed>
  </xsl:template>

</xsl:stylesheet>
