<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                exclude-result-prefixes="xs"
                version="2.0">

    <xsl:strip-space elements="*"/>

    <xsl:output method="text"
                encoding="UTF-8"
                indent="no"
                omit-xml-declaration="yes"/>

     <xsl:template match="/">
       <xsl:text>
            \hsize=6.5in
            \vsize=9in
            \font\bigbf=cmbx12
            \font\medbf=cmbx10
            \font\norm=cmr10
       </xsl:text>

       <!-- name --> 
       <xsl:text>\noindent{\bigbf </xsl:text>
       <xsl:value-of select="resume/header/name"/>
       <xsl:text>} \par </xsl:text>
       
       <!-- address -->
       <xsl:value-of select="resume/header/address"/>
       <xsl:text> \hfill </xsl:text>
       <xsl:value-of select="resume/header/email"/>
       <xsl:text> \par </xsl:text>
       
       <xsl:text>\vskip 20pt</xsl:text>
       
       <xsl:text>
         \vfill\eject
         \bye
       </xsl:text>
     </xsl:template>

</xsl:stylesheet>
