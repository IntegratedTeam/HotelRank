<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"
              doctype-system="about:legacy-compat"
              encoding="UTF-8"
              indent="yes" />
<xsl:variable name="file2" select="document('file2.xml')"/>
<xsl:variable name="file3" select="document('file3.xml')"/>

<xsl:template match="/">
    <html>
      <head>
        <title>People</title>
        <link rel="stylesheet" href="people.css" />
      </head>
      <body>
        <table class="people">
          <thead>
            <tr>
              <th>Name</th>
              <th>Age</th>
              <th>Money</th>
              <th>Sex</th>
            </tr>
          </thead>
          <tbody>
              <xsl:for-each select="/staffs/staff">
              <xsl:variable name="CurrentOrder"><xsl:value-of select = "attribute::order" /></xsl:variable>
                  <tr>
                    <td><xsl:copy-of select="name" /></td>
                    <td><xsl:copy-of select="age" /></td>
                    <td><xsl:copy-of select="$file2/staffs/staff[@order=$CurrentOrder]/Money" /></td>
                    <td><xsl:copy-of select="$file3/staffs/staff[@order=$CurrentOrder]/Sex" /></td>
                 </tr>
        </xsl:for-each>
          </tbody>
        </table>
      </body>
    </html>
</xsl:template>

</xsl:stylesheet>

<!--<?xml version="1.0" encoding="UTF-8"?>-->

<!--<xsl:stylesheet version="1.0"-->
                <!--xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->

<!--<xsl:output method="html"-->
              <!--doctype-system="about:legacy-compat"-->
              <!--encoding="UTF-8"-->
              <!--indent="yes" />-->
<!--<xsl:variable name="file2" select="document('file2.xml')"/>-->

<!--<xsl:template match="/">-->
    <!--<html>-->
      <!--<head>-->
        <!--<title>People</title>-->
        <!--<link rel="stylesheet" href="people.css" />-->
      <!--</head>-->
      <!--<body>-->
        <!--<table class="people">-->
          <!--<thead>-->
            <!--<tr>-->
              <!--<th>Name</th>-->
              <!--<th>Age</th>-->
              <!--<th>Money</th>-->
            <!--</tr>-->
          <!--</thead>-->
          <!--<tbody>-->
              <!--<xsl:for-each select="/staffs/staff">-->
              <!--<xsl:variable name="CurrentOrder"><xsl:value-of select = "attribute::order" /></xsl:variable>-->
                  <!--<tr>-->
                    <!--<td><xsl:copy-of select="name" /></td>-->
                    <!--<td><xsl:copy-of select="age" /></td>-->
                    <!--<td><xsl:copy-of select="$file2/staffs/staff[@order=$CurrentOrder]/Money" /></td>-->
                 <!--</tr>-->
        <!--</xsl:for-each>-->
          <!--</tbody>-->
        <!--</table>-->
      <!--</body>-->
    <!--</html>-->
<!--</xsl:template>-->

<!--</xsl:stylesheet>-->


<!--<?xml version="1.0" encoding="utf-8" ?>-->
<!--<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">-->

<!--<xsl:output  method="xml" omit-xml-declaration="yes"/>-->
<!--<xsl:variable name="file2" select="document('file2.xml')"/>-->

<!--<xsl:template match="/">-->
    <!--<staffs>-->
        <!--<xsl:for-each select="/staffs/staff">-->
        <!--<xsl:variable name="CurrentOrder"><xsl:value-of select = "attribute::order" /></xsl:variable>-->
        	<!--<staff>-->
        		<!--<xsl:attribute name="order"><xsl:value-of select="@order" /></xsl:attribute>-->
        		<!--<xsl:copy-of select="name" />-->
        		<!--<xsl:copy-of select="age" />-->
        		<!--<xsl:copy-of select="$file2/staffs/staff[@order=$CurrentOrder]/Money" />-->
        	<!--</staff>-->
        <!--</xsl:for-each>-->
    <!--</staffs>-->
<!--</xsl:template>-->

<!--</xsl:stylesheet>-->