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
      <h1 class="website-title">Ilmari's Webpage</h1>
      <table>
        <tr>
          <td>🏠</td>
          <td><a href="https://ilmarikoria.xyz">Home</a></td>
        </tr>
        <tr>
          <td>📜</td>
          <td><a href="https://ilmarikoria.xyz/posts.html">Posts</a></td>
        </tr>
        <tr>
          <td>📑</td>
          <td><a href="https://ilmarikoria.xyz/ilmari-koria-resume.pdf">Résumé</a></td>
        </tr>
        <tr>
          <td>🎤</td>
          <td><a href="https://freesound.org/people/ilmari_freesound/">Freesound</a></td>
        </tr>
        <tr>
          <td>👔</td>
          <td><a href="https://www.linkedin.com/in/ilmari-koria-3151a5291/">LinkedIn</a></td>
        </tr>
        <tr>
          <td>📺</td>
          <td><a href="https://www.youtube.com/@ilmarikoria">YouTube</a></td>
        </tr>
        <tr>
          <td>🗣️</td>
          <td><a href="https://ilmarikoria.xyz/static/ilmari-koria-name.mp3">How to Pronounce My Name</a></td>
        </tr>
        <tr>
          <td>💻</td>
          <td><a href="https://github.com/ilmari-koria">GitHub</a></td>
        </tr>
        <tr>
          <td>🇭🇰</td>
          <td><a href="https://www.meetup.com/london-cantonese-language-meetup/">Cantonese Language Meetup</a></td>
        </tr>
      </table>
    </div>
  </xsl:template>
</xsl:stylesheet>
