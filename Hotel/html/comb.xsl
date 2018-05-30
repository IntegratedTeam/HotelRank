<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output  method="xml" omit-xml-declaration="yes"/>
<xsl:variable name="feizhu" select="document('feizhu.xml')"/>
<xsl:variable name="meituan" select="document('meituan.xml')"/>
<xsl:variable name="ctrip" select="document('ctrip.xml')"/>

<xsl:template match="/">
    <hotel_list>
        <xsl:for-each select="$feizhu/hotel">
            <hotel>
                <day><xsl:copy-of select="day" /> </day>
                <name><xsl:copy-of select="name" /> </name>
                <grade><xsl:copy-of select="grade" /> </grade>
                <grade_des><xsl:copy-of select="grade_des" /> </grade_des>
                <address><xsl:copy-of select="address" /> </address>
                <min_price><xsl:copy-of select="min_price" /> </min_price>

                <room>
                    <xsl:for-each select="$feizhu/hotel/room/room_item">
                        <room_item>
                            <type_name><xsl:copy-of select="type_name" /> </type_name>
                            <type_bed><xsl:copy-of select="type_bed" /> </type_bed>
                            <type_website><xsl:copy-of select="type_website" /> </type_website>

                            <goods>
                                <xsl:for-each select="$feizhu/hotel/room/room_item/type_price/seller">
                                    <good>
                                        <good_detail><xsl:copy-of select="order_detail" /> </good_detail>
                                        <cancel><xsl:copy-of select="cancel" /> </cancel>
                                        <good_price><xsl:copy-of select="seller_price" /> </good_price>
                                    </good>
                                </xsl:for-each>
                            </goods>

                        </room_item>
                    </xsl:for-each>
                </room>

                <comment_cnt><xsl:copy-of select="comment_cnt" /> </comment_cnt>
                <comments>
                    <xsl:for-each select="$feizhu/hotel/comment/comment_item">
                        <comment_star><xsl:copy-of select="comment_star" /> </comment_star>
                        <comment_content><xsl:copy-of select="comment_content" /> </comment_content>
                        <comment_time><xsl:copy-of select="comment_time" /> </comment_time>
                    </xsl:for-each>
                </comments>
            </hotel>
        </xsl:for-each>

        <xsl:for-each select="$meituan/hotel">
            <hotel>
                <day><xsl:copy-of select="day" /> </day>
                <name><xsl:copy-of select="name" /> </name>
                <grade><xsl:copy-of select="grade" /> </grade>
                <grade_des><xsl:copy-of select="grade_des" /> </grade_des>
                <address><xsl:copy-of select="address" /> </address>
                <min_price><xsl:copy-of select="min_price" /> </min_price>

                <room>
                    <xsl:for-each select="$meituan/hotel/room/room_item">
                        <room_item>
                            <type_name><xsl:copy-of select="type_name" /> </type_name>
                            <type_bed><xsl:copy-of select="type_bed" /> </type_bed>
                            <type_website><xsl:copy-of select="type_website" /> </type_website>

                            <goods>
                                <xsl:for-each select="$meituan/hotel/room/room_item/type_price/goods">
                                    <good>
                                        <good_detail><xsl:copy-of select="goods_name" /> </good_detail>
                                        <cancel><xsl:copy-of select="cancel" /> </cancel>
                                        <good_price><xsl:copy-of select="goods_price" /> </good_price>
                                    </good>
                                </xsl:for-each>
                            </goods>

                        </room_item>
                    </xsl:for-each>
                </room>

                <comment_cnt><xsl:copy-of select="comment_cnt" /> </comment_cnt>
                <comments>
                    <xsl:for-each select="$meituan/hotel/comment/comment_item">
                        <comment_star><xsl:copy-of select="comment_star" /> </comment_star>
                        <comment_content><xsl:copy-of select="comment_content" /> </comment_content>
                        <comment_time><xsl:copy-of select="comment_time" /> </comment_time>
                    </xsl:for-each>
                </comments>
            </hotel>
        </xsl:for-each>

        <xsl:for-each select="$ctrip/hotel">
            <hotel>
                <!--<day><xsl:copy-of select="day" /> </day>-->
                <name><xsl:copy-of select="hotel_name/chinese_name" /> </name>
                <grade><xsl:copy-of select="hotel_value" /> </grade>
                <grade_des><xsl:copy-of select="hotel_level" /> </grade_des>
                <address><xsl:copy-of select="hotel_address/detail_address" /> </address>
                <min_price><xsl:copy-of select="hotel_low_price" /> </min_price>

                <room>
                    <xsl:for-each select="$ctrip/hotel/hotel_room_list/hotel_room">
                        <room_item>
                            <type_name><xsl:copy-of select="room_type" /> </type_name>
                            <type_bed><xsl:copy-of select="room_bed" /> </type_bed>
                            <type_website><xsl:copy-of select="room_wifi" /> </type_website>
                            <goods>
                                <good>
                                    <good_detail><xsl:copy-of select="room_type_name" /> </good_detail>
                                    <cancel><xsl:copy-of select="room_policy" /> </cancel>
                                    <good_price><xsl:copy-of select="room_price" /> </good_price>
                                </good>
                            </goods>
                        </room_item>
                    </xsl:for-each>
                </room>

                <comment_cnt><xsl:copy-of select="hotel_judgement" /> </comment_cnt>
                <comments>
                    <xsl:for-each select="$ctrip/hotel/comment_list/comment">
                        <comment_star><xsl:copy-of select="comment_main/comment_score/total" /> </comment_star>
                        <comment_content><xsl:copy-of select="comment_detail/comment_word" /> </comment_content>
                        <comment_time><xsl:copy-of select="comment_main/comment_date" /> </comment_time>
                    </xsl:for-each>
                </comments>
            </hotel>
        </xsl:for-each>

    </hotel_list>

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
</xsl:template>

</xsl:stylesheet>