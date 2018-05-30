<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method ="xml" version ="1.0" encoding ="gb2312" indent="yes"/>
  <xsl:variable name ="temp" select ="document('link2.xml')//info"/>
  <xsl:template match="/">
    <xsl:call-template name ="stu"/>
  </xsl:template>

  <xsl:template name ="stu">
    <root>
      <xsl:for-each select="//stu">
        <xsl:variable name ="id" select ="sid"/>
        <stu>
          <xsl:copy-of  select ="./*"/>
          <xsl:copy-of select="$temp[sid=$id]/sexamid"/>
        </stu>
      </xsl:for-each>
    </root>
  </xsl:template>
</xsl:stylesheet>