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
      \hsize 17cm
      \vsize 26.7cm
      \hoffset -1cm
      \voffset -1cm
      \footline={}
      \font\bigsmallcaps=cmcsc20
      \font\smallcaps=cmcsc12

      \def\sectiontitle#1{%
      \vskip 50pt
      \noindent\centerline{\smallcaps #1}%
      \vskip 5pt
      \hrule
      \par
      \vskip 10pt
      }

      \def\bulleteditem#1{%
      \noindent
      \hangindent=20pt
      \hangafter=1
      $\bullet$ \hskip 10pt #1\par
      }
    </xsl:text>

    <!-- name --> 
    <xsl:text>
      \noindent\centerline{
      \bigsmallcaps
    </xsl:text>
    <xsl:value-of select="resume/header/name"/>
    <xsl:text>
      }\par\vskip 5pt
    </xsl:text>

    <!-- top links -->    
    <xsl:text>
      \noindent\centerline{
    </xsl:text>
    <xsl:text>Resume: </xsl:text><xsl:value-of select="format-date(current-date(), '[D01] [MNn] [Y0001]')"/>
    <xsl:text> --- \tt </xsl:text><xsl:value-of select="resume/header/email"/>
    <xsl:text> \rm --- </xsl:text><xsl:value-of select="resume/header/address"/>
    <xsl:text>
      }\par
    </xsl:text>
    
    <!-- about  -->
    <xsl:text>
      \sectiontitle{About}
    </xsl:text>
    <xsl:value-of select="resume/about" />
    <xsl:text>
      \par
    </xsl:text>

    <!-- experience -->
    <xsl:text>
      \sectiontitle{Experience}
    </xsl:text>

    <xsl:for-each select="resume/experience/experience-entry">
      <xsl:text>\noindent\bf </xsl:text>
      <xsl:value-of select="company"/><xsl:text>\rm, </xsl:text>
      <xsl:value-of select="department"/><xsl:text>, </xsl:text>
      <xsl:value-of select="address"/><xsl:text>\par
    </xsl:text>
    
    <xsl:text>\noindent\it </xsl:text>
    <xsl:value-of select="role"/>
    <xsl:text>, \rm </xsl:text>
    <xsl:value-of select="time-start"/><xsl:text> -- </xsl:text>
    <xsl:value-of select="time-end"/><xsl:text> \par\vskip 5pt
    <!-- space between lines -->
  </xsl:text>
  <xsl:for-each select=".//achievement">
    <xsl:text>\bulleteditem{</xsl:text>
    <xsl:value-of select="."/>
    <xsl:text>}
    <!-- add space -->
    </xsl:text>
  </xsl:for-each>
  <!-- add space -->
    </xsl:for-each>

    <xsl:text>
      \sectiontitle{Education}
    </xsl:text>
    <xsl:for-each select="resume/education/education-entry">
      <xsl:text>\noindent\bf </xsl:text>
      <xsl:value-of select="institute"/><xsl:text>\rm, </xsl:text>
      <xsl:value-of select="result"/><xsl:text>, </xsl:text>
      <xsl:value-of select="address"/><xsl:text>\par\vskip 2.5pt
    </xsl:text>
    </xsl:for-each>
    
    <xsl:text>
      \sectiontitle{Training Courses}
    </xsl:text>
    <xsl:for-each select="resume/training/training-entry">
      <xsl:text>\noindent\it </xsl:text>
      <xsl:value-of select="name"/><xsl:text>\rm, </xsl:text>
      <xsl:value-of select="institute"/><xsl:text>, </xsl:text>
      <xsl:value-of select="training-hours"/><xsl:text> hrs., </xsl:text>
      <xsl:value-of select="date"/>
      <xsl:text>\par\vskip 2.5pt
      </xsl:text>
    </xsl:for-each>

    <xsl:text>
      \sectiontitle{Skills \&amp; Languages}
    </xsl:text>
    <xsl:for-each select="resume/skill-list/skill-entry">
      <xsl:text>\noindent </xsl:text>
      <xsl:value-of select="."/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>.\par\vskip 5pt
    <!-- space -->
    </xsl:text>

    <xsl:for-each select="resume/language-list/language-entry">
      <xsl:text>\noindent </xsl:text>
      <xsl:value-of select="language"/>
      <xsl:text>: </xsl:text>
      <xsl:value-of select="level"/>
      <xsl:if test="position() != last()">
        <xsl:text>, </xsl:text>
      </xsl:if>
    </xsl:for-each>
    <xsl:text>.\par\vskip 5pt
    <!-- space -->
    </xsl:text>

    <xsl:text>\footline{\noindent\centerline{</xsl:text>
    <xsl:text>\tt{}</xsl:text>
    <xsl:value-of select="resume/header/link[1]"/>
    <xsl:text>\rm{} --- \tt{}</xsl:text>
    <xsl:value-of select="resume/header/link[2]"/>
    <xsl:text>\rm{} --- References available on request.</xsl:text>
    <xsl:text>}}</xsl:text>
    
    <xsl:text>
      \vfill\eject
      \bye
    </xsl:text>
  </xsl:template>

</xsl:stylesheet>

