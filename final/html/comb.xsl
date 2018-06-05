<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes" />
<xsl:variable name="qne" select="document('qunaer.xml')"/>
<xsl:variable name="meituan" select="document('meituan.xml')"/>
<xsl:variable name="ctrip" select="document('ctrip.xml')"/>

<xsl:template match="/">
    <html>
      <head>
        <title>酒店评论信息汇总</title>
        <link rel="stylesheet" href="hotel.css" />
      </head>
      <body>
          <xsl:for-each select="$qne/hotel">
              <h4>来自：去哪儿</h4>
              <table class="hotel">
                  <thead>
                      <tr>
                          <th>日期</th>
                          <th>酒店名称</th>
                          <th>酒店评分</th>
                          <th>酒店描述</th>
                          <th>酒店地址</th>
                          <th>酒店最低价</th>
                          <th>酒店简介</th>
                          <th>评论条数</th>
                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td><xsl:copy-of select="extract_date" /></td>
                          <td><xsl:copy-of select="hotel_name" /></td>
                          <td><xsl:copy-of select="score" /></td>
                          <td><xsl:copy-of select="first_review" /></td>
                          <td><xsl:copy-of select="location" /></td>
                          <td><xsl:copy-of select="min_price" /></td>
                          <td><xsl:copy-of select="desc" /></td>
                          <td><xsl:copy-of select="comment_num" /></td>
                      </tr>
                  </tbody>
              </table>

              <xsl:for-each select="$qne/hotel/room/type">
                  <table class="hotel">
                  <thead>
                      <tr>
                          <th>房型</th>
                          <th>床型</th>
                          <th>网络情况</th>

                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td><xsl:copy-of select="type_name" /> </td>
                          <td><xsl:copy-of select="type_bed" /> </td>
                          <td><xsl:copy-of select="type_website" /> </td>
                      </tr>
                  </tbody>
              </table>

                      <table class="hotel">
                          <thead>
                              <tr>
                                  <th>详情</th>
                                  <th>早餐</th>
                                  <th>取消</th>
                                  <th>价格</th>
                              </tr>
                          </thead>
                          <tbody>
                              <xsl:for-each select="$qne/hotel/room/type/sale/seller">
                              <tr>
                                  <td><xsl:copy-of select="good_name" /></td>
                                  <td><xsl:copy-of select="breakfast" /></td>
                                  <td><xsl:copy-of select="policy" /></td>
                                  <td><xsl:copy-of select="good_price" /> </td>
                              </tr>
                               </xsl:for-each>
                          </tbody>
                      </table>


              </xsl:for-each>

                  <table class="hotel">
                          <thead>
                              <tr>
                                  <th>得分</th>
                                  <th>评论主题</th>
                                  <th>评论内容</th>
                                  <th>日期</th>
                              </tr>
                          </thead>
                          <tbody>
                              <xsl:for-each select="$qne/hotel/comment/review">
                              <tr>
                                  <td><xsl:copy-of select="star" /></td>
                                  <td><xsl:copy-of select="live_way" /></td>
                                  <td><xsl:copy-of select="content" /></td>
                                  <td><xsl:copy-of select="live_month" /> </td>
                              </tr>
                              </xsl:for-each>
                          </tbody>
                      </table>
              <hr/>
              <br/>
          </xsl:for-each>

          <xsl:for-each select="$meituan/hotel">
              <h4>来自：美团</h4>
              <table class="hotel">
                  <thead>
                      <tr>
                          <th>日期</th>
                          <th>酒店名称</th>
                          <th>酒店评分</th>
                          <th>酒店描述</th>
                          <th>酒店地址</th>
                          <th>酒店最低价</th>
                          <th>酒店简介</th>
                          <th>评论条数</th>
                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td><xsl:copy-of select="day" /></td>
                          <td><xsl:copy-of select="name" /></td>
                          <td><xsl:copy-of select="grade" /></td>
                          <td><xsl:copy-of select="grade_des" /></td>
                          <td><xsl:copy-of select="address" /></td>
                          <td><xsl:copy-of select="min_price" /></td>
                          <td><xsl:copy-of select="introduction" /></td>
                          <td><xsl:copy-of select="comment_cnt" /></td>
                      </tr>
                  </tbody>
              </table>

              <xsl:for-each select="$meituan/hotel/room/room_item">
                  <table class="hotel">
                  <thead>
                      <tr>
                          <th>房型</th>
                          <th>床型</th>
                          <th>网络情况</th>
                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td><xsl:copy-of select="type_name" /> </td>
                          <td><xsl:copy-of select="type_bed" /> </td>
                          <td><xsl:copy-of select="type_website" /> </td>
                      </tr>
                  </tbody>
              </table>

                      <table class="hotel">
                          <thead>
                              <tr>
                                  <th>详情</th>
                                  <th>早餐</th>
                                  <th>取消</th>
                                  <th>价格</th>
                              </tr>
                          </thead>
                          <tbody>
                              <xsl:for-each select="$meituan/hotel/room/room_item/type_price/goods">
                              <tr>
                                  <td><xsl:copy-of select="goods_name" /></td>
                                  <td><xsl:copy-of select="goods_breakfast" /></td>
                                  <td><xsl:copy-of select="cancel" /></td>
                                  <td><xsl:copy-of select="goods_price" /> </td>
                              </tr>
                              </xsl:for-each>
                          </tbody>
                      </table>

              </xsl:for-each>

                  <table class="hotel">
                          <thead>
                              <tr>
                                  <th>得分</th>
                                  <th>评论主题</th>
                                  <th>评论内容</th>
                                  <th>日期</th>
                              </tr>
                          </thead>
                          <tbody>
                              <xsl:for-each select="$meituan/hotel/comment/comment_item">
                              <tr>
                                  <td><xsl:copy-of select="comment_star" /></td>
                                  <td><xsl:copy-of select="comment_tag" /></td>
                                  <td><xsl:copy-of select="comment_content" /></td>
                                  <td><xsl:copy-of select="comment_time" /> </td>
                              </tr>
                              </xsl:for-each>
                          </tbody>
                      </table>

              <hr/>
              <br/>
          </xsl:for-each>

          <xsl:for-each select="$ctrip/hotel">
              <h4>来自：携程</h4>
              <table class="hotel">
                  <thead>
                      <tr>
                          <th>酒店名称</th>
                          <th>酒店评分</th>
                          <th>酒店描述</th>
                          <th>酒店地址</th>
                          <th>酒店最低价</th>
                          <th>酒店简介</th>
                          <th>评论条数</th>
                      </tr>
                  </thead>
                  <tbody>
                      <tr>
                          <td><xsl:copy-of select="hotel_name/chinese_name" /></td>
                          <td><xsl:copy-of select="hotel_value" /></td>
                          <td><xsl:copy-of select="hotel_level" /></td>
                          <td><xsl:copy-of select="hotel_address/detail_address" /></td>
                          <td><xsl:copy-of select="hotel_low_price" /></td>
                          <td><xsl:copy-of select="hotel_intro" /></td>
                          <td><xsl:copy-of select="hotel_judgement" /></td>
                      </tr>
                  </tbody>
              </table>

                  <table class="hotel">
                  <thead>
                      <tr>
                          <th>房型</th>
                          <th>床型</th>
                          <th>网络情况</th>
                          <th>详情</th>
                          <th>早餐</th>
                          <th>取消</th>
                          <th>价格</th>
                      </tr>
                  </thead>
                  <tbody>
                       <xsl:for-each select="$ctrip/hotel/hotel_room_list/hotel_room">
                      <tr>
                          <td><xsl:copy-of select="room_type" /> </td>
                          <td><xsl:copy-of select="room_bed" /> </td>
                          <td><xsl:copy-of select="room_wifi" /> </td>
                          <td><xsl:copy-of select="room_type_name" /> </td>
                          <td><xsl:copy-of select="room_breakfast" /> </td>
                          <td><xsl:copy-of select="room_policy" /> </td>
                          <td><xsl:copy-of select="room_price" /> </td>
                      </tr>
                      </xsl:for-each>
                  </tbody>
              </table>

                  <table class="hotel">
                  <thead>
                      <tr>
                          <th>得分</th>
                          <th>评论主题</th>
                          <th>评论内容</th>
                          <th>日期</th>
                      </tr>
                  </thead>
                  <tbody>
                      <xsl:for-each select="$ctrip/hotel/comment_list/comment">
                      <tr>
                          <td><xsl:copy-of select="comment_main/comment_score/total" /> </td>
                          <td><xsl:copy-of select="comment_main/comment_aim" /> </td>
                          <td><xsl:copy-of select="comment_detail/comment_word" /> </td>
                          <td><xsl:copy-of select="comment_main/comment_date" /> </td>
                      </tr>
                      </xsl:for-each>
                  </tbody>
              </table>


              <hr/>
              <br/>
          </xsl:for-each>
      </body>
    </html>

</xsl:template>

</xsl:stylesheet>