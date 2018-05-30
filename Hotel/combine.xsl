<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"
              doctype-system="about:legacy-compat"
              encoding="UTF-8"
              indent="yes" />
<xsl:variable name="meituan" select="document('meituan.xml')"/>
<xsl:variable name="ctrip" select="document('ctrip.xml')"/>

<!--<xsl:template match="/">-->
    <!--<html>-->
      <!--<head>-->
        <!--<title>Hotel Comment</title>-->
        <!--<link rel="stylesheet" href="hotel.css" />-->
      <!--</head>-->
      <!--<body>-->
        <!--<table class="hotel">-->
          <!--<thead>-->
            <!--<tr>-->
              <!--<th>Name</th>-->
              <!--<th>Age</th>-->
              <!--<th>Money</th>-->
              <!--<th>Sex</th>-->
            <!--</tr>-->
          <!--</thead>-->
          <!--<tbody>-->
              <!--<xsl:for-each select="/staffs/staff">-->
              <!--<xsl:variable name="CurrentOrder"><xsl:value-of select = "attribute::order" /></xsl:variable>-->
                  <!--<tr>-->
                    <!--<td><xsl:copy-of select="name" /></td>-->
                    <!--<td><xsl:copy-of select="age" /></td>-->
                    <!--<td><xsl:copy-of select="$file2/staffs/staff[@order=$CurrentOrder]/Money" /></td>-->
                    <!--<td><xsl:copy-of select="$file3/staffs/staff[@order=$CurrentOrder]/Sex" /></td>-->
                 <!--</tr>-->
        <!--</xsl:for-each>-->
          <!--</tbody>-->
        <!--</table>-->
      <!--</body>-->
    <!--</html>-->
<!--</xsl:template>-->

</xsl:stylesheet>