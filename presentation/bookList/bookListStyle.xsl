<?xml version="1.0" encoding="UTF-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/">
    <html>
      <head>
        <title>图书列表</title>
        <style>
          <![CDATA[
            body,td,th{
              font-size:10pt;
              font-family:宋体;
            }

            table{
              border:solid red 1px;
              margin-left:30px;
              margin-right:30px;
              background-color:#ffffc0;
              cellPadding:4;
            }
          ]]>
        </style>
      </head>
      <body>
        <table>
          <caption align="top" style="font-weight:bold; text-align:left">图书列表</caption>
          <tr style="color:#8b0000" align="left">
            <th width="5%">编号</th>
            <th width="10%">类别</th>
            <th width="25%">书名</th>
            <th width="20%">作者</th>
            <th width="25%">出版社</th>
            <th width="10%">出版日期</th>
            <th width="5%">定价</th>
          </tr>
          <xsl:for-each select="bookList/category/book">
            <xsl:sort select="pubInfo/price" order="descending"/>
            <tr>
              <xsl:attribute name="style">
                color:
                <xsl:if test="../@type[.='计算机']">blue</xsl:if>
              </xsl:attribute>
              <xsl:attribute name="title">
                <xsl:value-of select="title"/>
                <xsl:choose>
                  <xsl:when test="../@type[.='计算机']">
        类别:计算机类图书
                  </xsl:when>
                  <xsl:otherwise>
        类别:小说类图书
                  </xsl:otherwise>
                </xsl:choose>
        作者：<xsl:value-of select="author"></xsl:value-of>
                <!--<br/>-->
        出版社：<xsl:value-of select="pubInfo/publisher"/>
                <!--<br/>-->
        出版日期：<xsl:value-of select="pubInfo/pubDate"/>
                <!--<br/>-->
        定价：<xsl:value-of select="pubInfo/price"/>元
              </xsl:attribute>
              <td>
                <xsl:value-of select="@id"/>
              </td>
              <td>
                <xsl:value-of select="../@type"/>
              </td>
              <td>
                <xsl:value-of select="title"/>
              </td>
              <td>
                <xsl:value-of select="author"/>
              </td>
              <td>
                <xsl:value-of select="pubInfo/publisher"/>
              </td>
              <td>
                <xsl:value-of select="pubInfo/pubDate"/>
              </td>
              <td>
                <xsl:value-of select="pubInfo/price"/>
              </td>
            </tr>
          </xsl:for-each>
        </table>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>