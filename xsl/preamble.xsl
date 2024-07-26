<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:org="https://nwalsh.com/ns/org-to-xml"
                exclude-result-prefixes="org"
                version="1.0">

  <xsl:output method="xml"
              indent="yes"
              omit-xml-declaration="yes" />

 <xsl:template name="preamble">
   <div id="preamble">
     <h1>Ilmari's Webpage</h1>
     <ul>
       <li>
         🏠 <a href="https://ilmarikoria.xyz">Home</a>
       </li>
       <li>
         📜 <a href="https://ilmarikoria.xyz/posts.html">Posts</a>
       </li>
       <li>
         📑 <a href="https://ilmarikoria.xyz/ilmari-koria-resume.pdf">Résumé</a>
       </li>
       <li>
         🎤 <a href="https://freesound.org/people/ilmari_freesound/">Freesound</a>
       </li>
       <li>
         👔 <a href="https://www.linkedin.com/in/ilmari-koria-3151a5291/">LinkedIn</a>
       </li>
       <li>
         📺 <a href="https://www.youtube.com/@ilmarikoria">YouTube</a>
       </li>
       <li>
         🗣️ <a href="https://ilmarikoria.xyz/static/ilmari-koria-name.mp3">How to Pronounce My Name</a>
       </li>
       <li>
         💻 <a href="https://github.com/ilmari-koria">GitHub</a>
       </li>
       <li>
         🇭🇰 <a href="https://www.meetup.com/london-cantonese-language-meetup/">Cantonese Language Meetup</a>
       </li>
     </ul>
   </div>
</xsl:template>
</xsl:stylesheet>
