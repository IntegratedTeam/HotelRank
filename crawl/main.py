import time
from selenium import webdriver
import os
from bs4 import BeautifulSoup
import bs4
import pymysql

MYSQL_HOST = 'rm-bp172z8x1m3m16m0pto.mysql.rds.aliyuncs.com'
MYSQL_PORT = 3306
MYSQL_DBNAME = 'qu'
MYSQL_USER = 'pingshen'
MYSQL_PASSWD = 'lu106'


chromedriver = "/usr/local/bin/chromedriver"

os.environ["webdriver.chrome.driver"] = chromedriver

driver = webdriver.Chrome(chromedriver)

driver.get('http://hotel.qunar.com/city/nanjing/#fromDate=2018-06-09&cityurl=nanjing&from=qunarHotel&toDate=2018-06-10')

time.sleep(2)

driver.find_element_by_xpath('//input[@id="filter_10_uf_19"]').click()  # 只看有房click
time.sleep(2)

page = 1
nameList = []
priceList = []
commentNumberList = []
scoreList = []
areaList = []

link_base = 'http://hotel.qunar.com'
data_link = []

while page <= 41:
    times = 1
    for i in range(times + 1):
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight*5/6);")
        time.sleep(2)

    time.sleep(1)
    page = page + 1
    driver.find_element_by_class_name('next').click()  # selenium的xpath用法，找到包含“下一页”的a标签去点击
    time.sleep(2)  # 睡2秒让网页加载完再去读它的html代码

while page <= 50:
    times = 1
    for i in range(times + 1):
        driver.execute_script("window.scrollTo(0, document.body.scrollHeight*5/6);")
        time.sleep(2)

    pageSource = driver.page_source
    html_content = BeautifulSoup(pageSource, 'lxml')
    hotels = html_content.findAll('div', {'class': 'b_result_box'})

    print(len(hotels))

    for single_hotel in hotels:
        data_link.append(link_base + single_hotel["data-link"])

    print(data_link)
    print(len(data_link))

    # name_list = html_content.findAll('a', {'class': 'e_title'})
    # price_list = html_content.findAll('p', {'class': 'item_price'})
    # commentNum_list = html_content.findAll('p', {'class': 'user_comment'})
    # score_list = html_content.findAll('p', {'class': 'score'})
    # address_list = html_content.findAll('span', {'class': 'area_contair'})
    # print('page', page)
    #
    # for k in name_list:
    #     nameList.append(k['title'])
    # for k in price_list:
    #     price = k.find("a").text
    #     price = price[:-1]
    #     price = price[1:]
    #     priceList.append(price)
    # for k in commentNum_list:
    #     commentNum = k.find("a").text
    #     commentNum = commentNum[:-5]
    #     commentNumberList.append(commentNum)
    # for k in score_list:
    #     score = k.find("a").text
    #     score = score[:-3]
    #     scoreList.append(score)
    # for k in address_list:
    #     str_all = ''
    #     address_a = ''
    #     em_str = ''
    #     if isinstance(k.find("a"), bs4.element.Tag):
    #         str_all += k.find("a").text
    #
    #     if isinstance(k, str):
    #         continue
    #
    #     list_array = k.find_all("em")
    #     for em_item in list_array:
    #         str_all += em_item.text
    #     print(str_all)
    #     areaList.append(str_all)

    time.sleep(1)
    page = page + 1
    driver.find_element_by_class_name('next').click()  # selenium的xpath用法，找到包含“下一页”的a标签去点击
    time.sleep(2)  # 睡2秒让网页加载完再去读它的html代码

connect = pymysql.connect(
    host=MYSQL_HOST,
    port=MYSQL_PORT,
    db=MYSQL_DBNAME,
    user=MYSQL_USER,
    passwd=MYSQL_PASSWD,
    charset='utf8',
    use_unicode=True)

for j in range(len(data_link)):
    driver.get(data_link[j])
    time.sleep(2)

    pageSource = driver.page_source
    html_content = BeautifulSoup(pageSource, 'lxml')

    if None == html_content.find('div', {'id': 'detail_pageHeader'}):
        continue
    hotel_name = html_content.find('div', {'id': 'detail_pageHeader'}).h2.span.string

    print(hotel_name)
    print(j)

    panels = html_content.find('div', {'class': 'b-dtsearch'})

    room_table = panels.findAll('table', {'class': 'tbl-room-quote'})

    print("Single: ",len(room_table))
    print(len(data_link))

    for room in room_table:
        facility_info = []
        seller_name = []
        good_name = []
        breakfast = []
        policy = []
        good_price = []

        rtype = room.find('div', {'class': 'rtype'})
        if None==room.find('div', {'class': 'rtype'}):
            continue
        type_name = rtype.h2.a['title']

        facility_info.append(type_name)

        if None!=room.find('p', {'class': 'facily-list'}):
            facility_list = room.find('p', {'class': 'facily-list'})
            wifi = facility_list.findAll('i', {'class': 'icon-facily icon-wifi'})
            if len(wifi) == 1:
                facility_info.append("WIFI已覆盖")
            else:
                facility_info.append("WIFI未覆盖")
        else:
            facility_info.append("WIFI未覆盖")

        room_area = room.find('p', {'class': 'room-area'})
        if None != room_area:
            cites = room_area.findAll('cite')
            for cite in cites:
                if cite.string != None:
                    facility_info.append(cite.string)

            bed_type = room_area.find('span', {'class': 'js-bd-hover'})
            if None != bed_type:
                if len(bed_type) > 0:
                    if None != bed_type.string:
                        facility_info.append(bed_type.string)
        else:
            facility_info.append("")
            facility_info.append("")
            facility_info.append("")

        print(facility_info)

        room_type_default = room.findAll('div', {'class': 'room-type-default'})

        for s_room_type in room_type_default:
            lowestPrice = s_room_type.table.tbody.find('tr')

            seller = lowestPrice.find('td', {'class': 'e1'})
            if None== seller.div:
                seller_name.append("新客专享")
            else:
                seller_name.append(seller.div.img['alt'])

            product = lowestPrice.find('div', {'class': 'js-product'})
            if None == product:
                product = lowestPrice.find('span', {'class': 'js-product'})
                if None == product:
                    good_name.append("")
                else:
                    good_name.append(product.text)
            else:
                good_name.append(product.string)

            breakfast.append(lowestPrice.find('td', {'class': 'e4'}).p.string)

            cancel = lowestPrice.find('div', {'class': 'js-cancel'})
            if None == cancel:
                cancel = lowestPrice.find('p', {'class': 'js-cancel'})
            if None ==cancel :
                policy.append("")
            elif None==cancel.em:
                policy.append("")
            else:
                policy.append(cancel.em.string)

            sprice = lowestPrice.find('span', {'class': 'sprice'})
            good_price.append(sprice.text)

        print(seller_name)
        print(good_name)
        print(breakfast)
        print(policy)
        print(good_price)
        print("============================================")
        # #通过cursor执行增删查改
        cursor = connect.cursor()
        time_date = '2018-06-02'
        for index in range(len(seller_name)):
            type_area=""
            type_floor=""
            type_bathroom=""
            type_window=""
            type_bed=""

            if len(facility_info)>=3:
                if facility_info[2].startswith('面'):
                    type_area = facility_info[2]
                else:
                    type_area = facility_info[2]
            else:
                type_area = ""

            if len(facility_info)>=4:
                if facility_info[3].startswith('位'):
                    type_floor = facility_info[3]
                else:
                    type_floor = ""
            else:
                type_floor = ""

            if len(facility_info)>=4:
                if facility_info[len(facility_info) - 3].endswith("卫浴"):
                    type_bathroom = facility_info[len(facility_info) - 3]
                elif facility_info[len(facility_info) - 2].endswith("卫浴"):
                    type_bathroom = facility_info[len(facility_info) - 2]
                elif facility_info[len(facility_info) - 1].endswith("卫浴"):
                    type_bathroom = facility_info[len(facility_info) - 1]
            else:
                type_bathroom = ""

            if len(facility_info)>=4:
                if facility_info[len(facility_info) - 3].endswith("窗"):
                    type_window = facility_info[len(facility_info) - 3]
                elif facility_info[len(facility_info) - 2].endswith("窗"):
                    type_window = facility_info[len(facility_info) - 2]
                elif facility_info[len(facility_info) - 1].endswith("窗"):
                    type_window = facility_info[len(facility_info) - 1]
            else:
                type_window = ""

            if len(facility_info)>=3:
                if facility_info[len(facility_info) - 2].endswith("窗"):
                    type_bed = facility_info[len(facility_info) - 1]
            else:
                type_bed = ""

            try:
                cursor.execute(
                    "insert into hotel_goods(hotel_name, type_name, type_website, type_area, type_floor, type_bathroom, type_window,type_bed, seller_name, good_name, breakfast, policy, good_price, extract_date) value (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                     (
                         hotel_name,
                         facility_info[0],
                         facility_info[1],
                         type_area,
                         type_floor,
                         type_bathroom,
                         type_window,
                         type_bed,
                         seller_name[index],
                         good_name[index],
                         breakfast[index],
                         policy[index],
                         int(good_price[index][1:]),
                         time_date
                    ))

                # 提交sql语句
                connect.commit()
            except Exception as error:
                # 出现错误时打印错误日志
                print(error)

    panelGroup = html_content.find('div', {'id': 'groupRoomContainer'})
    room_table = panelGroup.findAll('table', {'class': 'tbl-room-quote'})

    print("Group: ", len(room_table))
    print(len(data_link))

    for room in room_table:
        facility_info = []
        seller_name = []
        good_name = []
        breakfast = []
        policy = []
        good_price = []

        rtype = room.find('div', {'class': 'rtype'})
        type_name = rtype.h2.a['title']

        facility_info.append(type_name)

        if None!=room.find('p', {'class': 'facily-list'}):
            facility_list = room.find('p', {'class': 'facily-list'})
            wifi = facility_list.findAll('i', {'class': 'icon-facily icon-wifi'})
            if len(wifi) == 1:
                facility_info.append("WIFI已覆盖")
            else:
                facility_info.append("WIFI未覆盖")
        else:
            facility_info.append("WIFI未覆盖")


        room_area = room.find('p', {'class': 'room-area'})
        if None != room_area:
            cites = room_area.findAll('cite')
            for cite in cites:
                if cite.string != None:
                    facility_info.append(cite.string)

            bed_type = room_area.find('span', {'class': 'js-bd-hover'})
            if None != bed_type:
                if len(bed_type) > 0:
                    if None != bed_type.string:
                        facility_info.append(bed_type.string)
        else:
            facility_info.append("")
            facility_info.append("")
            facility_info.append("")
        # facility_list = room.find('p', {'class': 'facily-list'})
        # wifi = facility_list.findAll('i', {'class': 'icon-facily icon-wifi'})
        # if len(wifi) == 1:
        #     facility_info.append("WIFI已覆盖")
        # else:
        #     facility_info.append("WIFI未覆盖")
        #
        # room_area = room.find('p', {'class': 'room-area'})
        # cites = room_area.findAll('cite')
        # for cite in cites:
        #     if cite.string != None:
        #         facility_info.append(cite.string)
        #
        # bed_type = room_area.find('span', {'class': 'js-bd-hover'})
        # if None != bed_type:
        #     if len(bed_type) > 0:
        #         if None != bed_type.string:
        #             facility_info.append(bed_type.string)

        print(facility_info)

        room_type_default = room.findAll('div', {'class': 'room-type-default'})

        for s_room_type in room_type_default:
            lowestPrice = s_room_type.table.tbody.find('tr')

            seller = lowestPrice.find('td', {'class': 'e1'})
            if None == seller.div:
                seller_name.append("新客专享")
            else:
                seller_name.append(seller.div.img['alt'])

            good_name.append(facility_info[0])

            breakfast.append(lowestPrice.find('td', {'class': 'e4'}).p.string)

            cancel = lowestPrice.find('div', {'class': 'js-cancel'})
            if None == cancel:
                cancel = lowestPrice.find('p', {'class': 'js-cancel'})
            if None ==cancel :
                policy.append("")
            elif None==cancel.em:
                policy.append("")
            else:
                policy.append(cancel.em.string)

            sprice = lowestPrice.find('span', {'class': 'sprice'})
            good_price.append(sprice.text)

        print(seller_name)
        print(good_name)
        print(breakfast)
        print(policy)
        print(good_price)
        print("============================================")
        # #通过cursor执行增删查改
        cursor = connect.cursor()
        time_date = '2018-06-02'
        for index in range(len(seller_name)):
            type_area = ""
            type_floor = ""
            type_bathroom = ""
            type_window = ""
            type_bed = ""

            if len(facility_info)>=3:
                if facility_info[2].startswith('面'):
                    type_area = facility_info[2]
                else:
                    type_area = facility_info[2]
            else:
                type_area = ""

            if len(facility_info)>=4:
                if facility_info[3].startswith('位'):
                    type_floor = facility_info[3]
                else:
                    type_floor = ""
            else:
                type_floor = ""

            if len(facility_info)>=4:
                if facility_info[len(facility_info) - 3].endswith("卫浴"):
                    type_bathroom = facility_info[len(facility_info) - 3]
                elif facility_info[len(facility_info) - 2].endswith("卫浴"):
                    type_bathroom = facility_info[len(facility_info) - 2]
                elif facility_info[len(facility_info) - 1].endswith("卫浴"):
                    type_bathroom = facility_info[len(facility_info) - 1]
            else:
                type_bathroom = ""

            if len(facility_info)>=4:
                if facility_info[len(facility_info) - 3].endswith("窗"):
                    type_window = facility_info[len(facility_info) - 3]
                elif facility_info[len(facility_info) - 2].endswith("窗"):
                    type_window = facility_info[len(facility_info) - 2]
                elif facility_info[len(facility_info) - 1].endswith("窗"):
                    type_window = facility_info[len(facility_info) - 1]
            else:
                type_window = ""

            if len(facility_info)>=3:
                if facility_info[len(facility_info) - 2].endswith("窗"):
                    type_bed = facility_info[len(facility_info) - 1]
            else:
                type_bed = ""

            try:
                cursor.execute(
                    "insert into hotel_goods(hotel_name, type_name, type_website, type_area, type_floor, type_bathroom, type_window,type_bed, seller_name, good_name, breakfast, policy, good_price, extract_date) value (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)",
                    (
                        hotel_name,
                        facility_info[0],
                        facility_info[1],
                        type_area,
                        type_floor,
                        type_bathroom,
                        type_window,
                        type_bed,
                        seller_name[index],
                        good_name[index],
                        breakfast[index],
                        policy[index],
                        int(good_price[index][1:]),
                        time_date
                    ))

                # 提交sql语句
                connect.commit()
            except Exception as error:
                # 出现错误时打印错误日志
                print(error)


    # 爬取评论
    # feed_user = []
    # feed_title = []
    # feed_star = []
    # feed_detail = []
    # feed_time = []
    #
    # comments = html_content.findAll('div', {'class': 'js-feed'})
    # for comment in comments:
    #     username = comment.find('div', {'class': 'l_user'}).find('div', {'class': 'usernickname'}).a['title']
    #     title = comment.find('div', {'class': 'l_feed'}).find('div', {'class': 'title'}).h5.a['title']
    #     star = comment.find('div', {'class': 'l_feed'}).find('div', {'class': 'grade'}).div.div.div['style']
    #     detail = comment.find('div', {'class': 'l_feed'}).find('div', {'class': 'comment'}).div.p.string
    #     f_time = comment.find('div', {'class': 'l_feed'}).findAll('li', {'class': 'item'})[1].text
    #
    #     feed_user.append(username)
    #     feed_title.append(title)
    #
    #     if star == 'width:100%;':
    #         feed_star.append(5)
    #     elif star == 'width:80%;':
    #         feed_star.append(4)
    #     elif star == 'width:60%;':
    #         feed_star.append(3)
    #     elif star == 'width:40%;':
    #         feed_star.append(2)
    #     elif star == 'width:20%':
    #         feed_star.append(1)
    #     else:
    #         feed_star.append(5)
    #
    #     feed_detail.append(detail)
    #     feed_time.append(f_time)
    #
    # print(feed_user)
    # print(feed_title)
    # print(feed_star)
    # print(feed_detail)
    # print(feed_time)
    # print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

    # MYSQL_HOST = 'localhost'
    # MYSQL_PORT = 3306
    # MYSQL_DBNAME = 'hotel'
    # MYSQL_USER = 'root'
    # MYSQL_PASSWD = ''
    # # 连接数据库
    # connect = pymysql.connect(
    #     host=MYSQL_HOST,
    #     port=MYSQL_PORT,
    #     db=MYSQL_DBNAME,
    #     user=MYSQL_USER,
    #     passwd=MYSQL_PASSWD,
    #     charset='utf8',
    #     use_unicode=True)
    #
    # # 通过cursor执行增删查改
    # cursor = connect.cursor();
    # time_cursor = '2018-06-02'
    # for index in range(len(nameList)):
    #     print(index, nameList[index], priceList[index], scoreList[index], commentNumberList[index], areaList[index])
    #     try:
    #         # 插入数据
    #         cursor.execute(
    #             "insert into basic(extractTime, `name`, minPrice, score ,commentNum, area) value (%s, %s, %s, %s, %s, %s)",
    #             (
    #                 time_cursor,
    #                 nameList[index],
    #                 priceList[index],
    #                 scoreList[index],
    #                 commentNumberList[index],
    #                 areaList[index],
    #             ))
    #
    #         # 提交sql语句
    #         connect.commit()
    #
    #     except Exception as error:
    #         # 出现错误时打印错误日志
    #         print(error)

    # cnt=1
    # # 爬取评论
    # feed_user = []
    # feed_title = []
    # feed_star = []
    # feed_detail=[]
    # feed_time = []
    # while cnt <= 2:
    #     time.sleep(2)
    #
    #     comments = html_content.findAll('div', {'class': 'js-feed'})
    #     for comment in comments:
    #         username = comment.find('div', {'class': 'l_user'}).find('div', {'class': 'usernickname'}).a['title']
    #         title = comment.find('div', {'class': 'l_feed'}).find('div', {'class': 'title'}).h5.a['title']
    #         star = comment.find('div', {'class': 'l_feed'}).find('div', {'class': 'grade'}).div.div.div['style']
    #         detail = comment.find('div', {'class': 'l_feed'}).find('div', {'class': 'comment'}).div.p.string
    #         f_time = comment.find('div', {'class': 'l_feed'}).findAll('li', {'class': 'item'})[1].text
    #
    #         feed_user.append(username)
    #         feed_title.append(title)
    #
    #         if star == 'width:100%;':
    #             feed_star.append(5)
    #         elif star == 'width:80%;':
    #             feed_star.append(4)
    #         elif star == 'width:60%;':
    #             feed_star.append(3)
    #         elif star == 'width:40%;':
    #             feed_star.append(2)
    #         elif star == 'width:20%':
    #             feed_star.append(1)
    #         else:
    #             feed_star.append(5)
    #
    #         feed_detail.append(detail)
    #         feed_time.append(f_time)
    #
    #     time.sleep(1)
    #     cnt = cnt + 1
    #     html_content.find('li', {'class': 'item next'}).click()  # selenium的xpath用法，找到包含“下一页”的a标签去点击
    #     time.sleep(2)  # 睡2秒让网页加载完再去读它的html代码
    #
    # print(feed_user)
    # print(feed_title)
    # print(feed_star)
    # print(feed_detail)
    # print(feed_time)
    # print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")



