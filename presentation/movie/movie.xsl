<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"
              doctype-system="about:legacy-compat"
              encoding="UTF-8"
              indent="yes" />

<xsl:template match="/">
    <html>
      <head>
        <title>List of Movies.</title>
        <link rel="stylesheet" href="movies.css" />
      </head>
      <body>
        <table class="movies">
          <thead>
            <tr>
              <th>Title</th>
              <th>Year</th>
              <th>Rank</th>
            </tr>
          </thead>
          <tbody>
            <xsl:for-each select="movies/movie">
            <xsl:sort select="rank"/>
            <tr>
              <td><xsl:value-of select="title"/></td>
              <td><xsl:value-of select="year"/></td>
              <td><xsl:value-of select="rank"/></td>
            </tr>
            </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
</xsl:template>

</xsl:stylesheet>