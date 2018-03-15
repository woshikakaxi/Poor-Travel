//
//  Define.h
//  Connotation
//
//  Created by LZXuan on 14-8-25.
//  Copyright (c) 2014年 LZXuan. All rights reserved.
//

#ifndef Connotation_Define_h
#define Connotation_Define_h


//注册
//获取验证码
//POST
//http://open.qyer.com/qyer/user/active_code

//注册
//POST
//http://open.qyer.com/qyer/user/signup
//请求体
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786503&lon=113.671476&mobile=86-18510421092&code=866688&email=&username=Bulldog&password=633257&account_s=ab0269f3ba430bdeed4888664bc1f48d&grant_type=password&account_type=2

//http://open.qyer.com/qyer/user/signup
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786503&lon=113.671476&mobile=86-18510421092&code=866688&email=&username=qiu90123&password=633257&account_s=5721753b29cc9fc8d521141db9e39434&grant_type=password&account_type=2

//GET
//http://open.qyer.com/qyer/notification/unread?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=5517284&app_installtime=1422450627633&lat=34.786503&lon=113.671476&oauth_token=413cccd02a0e9d2fa188ad354c512764
//GET
// http://open.qyer.com/qyer/dm/user_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=5517284&app_installtime=1422450627633&lat=34.786503&lon=113.671476&oauth_token=413cccd02a0e9d2fa188ad354c512764&im_user_id=AIM45F59EWCLJ4Z3SJ8GS5B&count=500&since=0
//http://open.qyer.com/qyer/user/profile?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=5517284&app_installtime=1422450627633&lat=34.786503&lon=113.671476&user_id=5517284&oauth_token=413cccd02a0e9d2fa188ad354c512764


//推荐
//http://open.qyer.com/qyer/recommands/index?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=5517284&app_installtime=1422450627633&lat=34.786447&lon=113.67144

//http://open.qyer.com/qyer/recommands/index?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786447&lon=113.67144
//#define Feature_Header_URL @"http://open.qyer.com/qyer/recommands/index?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_app_channel=360m"
#define Feature_Header_URL @"http://open.qyer.com/qyer/recommands/index?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786447&lon=113.67144"
//精华游记
//http://open.qyer.com/qyer/recommands/trip?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786468&lon=113.671449&type=index&page=2&count=5
#define Feature_Notes_URL @"http://open.qyer.com/qyer/recommands/trip?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786468&lon=113.671449&type=index&page=%ld&count=5"

//穷游锦囊 POST
//http://open.qyer.com/guide/guide/get_guide_all
//请求体
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786447&lon=113.67144

#define Guide_URL @"http://open.qyer.com/guide/guide/get_guide_all"
//穷游锦囊 图片GET 参数cover_updatetime
//http://static.qyer.com/upload/Guide_Info/28/38/51/260_390.jpg?1395288175


//折扣 POST
// http://open.qyer.com/lastminute/get_lastminute_list
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786447&lon=113.67144&max_id=0&product_type=0&continent_id=0&country_id=0&departure=&times=&is_show_pay=1
#define QYDiscount_URL @"http://open.qyer.com/lastminute/get_lastminute_list"
//获取所有折扣类型
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786481&lon=113.671492
#define GET_AllCategory_URL @"http://open.qyer.com/lastminute/get_all_categorys?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915"

//微锦囊详情
//http://open.qyer.com/qyer/footprint/mguide_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786447&lon=113.67144&oauth_token=&id=2483&page=1&count=10&source=MainFragmentActivity

#define Mguide_Detail_URL @"http://open.qyer.com/qyer/footprint/mguide_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786447&lon=113.67144&oauth_token=&id=%@&page=1&count=10&source=MainFragmentActivity"
//微锦囊详情推荐地点详情 POST
//http://open.qyer.com/qyer/footprint/poi_detail
//请求体client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786434&lon=113.671404&client_id=qyer_android&poi_id=106940&oauth_token=&screensize=800
#define Mguide_FootPrint_URL @"http://open.qyer.com/qyer/footprint/poi_detail"

//折扣详情
//http://m.qyer.com/z/deal/19146/source=app
#define Discount_Detail_URL @"http://m.qyer.com/z/deal/%@/source=app"

//个人详情
// http://open.qyer.com/qyer/user/profile?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=5517284&app_installtime=1422450627633&lat=34.786496&lon=113.671402&user_id=1806087&oauth_token=f4ac974c2f286c6c9391e71861987394
#define User_Detail_URL @"http://open.qyer.com/qyer/user/profile?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786447&lon=113.67144&user_id=%@&oauth_token="
//地图区域
//http://open.qyer.com/qyer/user/user_map_photo?user_id=4978160&width=1080&height=587&client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&country=13

#define Map_URL @"http://open.qyer.com/qyer/user/user_map_photo?user_id=%@&width=1080&height=587&client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&country=%@"

//目的地 POST
//http://open.qyer.com/place/common/get_all_country
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786515&lon=113.671502

#define Destion_URL @"http://open.qyer.com/place/common/get_all_country"
//目的地详情
//http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786493&lon=113.671495&country_id=215&oauth_token=
#define Destion_Detail_URL @"http://open.qyer.com/qyer/footprint/country_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786493&lon=113.671495&country_id=%@&oauth_token="

//国家地图
#define Country_Lat_URl　@"http://open.qyer.com/qyer/map/city_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=5517284&app_installtime=1422450627633&lat=34.786527&lon=113.671505&country_id=%@&oauth_token="

//查看全部城市 POST
//http://open.qyer.com/place/city/get_city_list
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786515&lon=113.671419&page=1&countryid=186

#define GET_CityList_URL @"http://open.qyer.com/place/city/get_city_list"

//查看更多折扣 POST
//http://open.qyer.com/lastminute/get_lastminute_list
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786395&lon=113.671399&max_id=0&product_type=0&continent_id=0&country_id=186&departure=&times=&is_show_pay=1

#define GET_DiscountList_URL @"http://open.qyer.com/lastminute/get_lastminute_list"
//城市详情
//http://open.qyer.com/qyer/footprint/city_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786515&lon=113.671419&city_id=20&oauth_token=
#define City_Detail_URL @"http://open.qyer.com/qyer/footprint/city_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786515&lon=113.671419&city_id=%@&oauth_token="



//BBS 社区  GET
//http://open.qyer.com/qyer/bbs/forum_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.78647&lon=113.67153

#define BBS_URL @"http://open.qyer.com/qyer/bbs/forum_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.78647&lon=113.67153"

//BBS   CellItem 详情forum_id 上个界面传值  type = new/all/digest
//http://open.qyer.com/qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786466&lon=113.671507&type=new&forum_id=3&count=10&delcache=1&page=1
#define BBS_ItemHeaderDetail_URL @"http://open.qyer.com/qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786466&lon=113.671507&type=all&forum_id=%@&count=10&delcache=1&page=1"
#define BBS_ItemDetail_URL @"http://open.qyer.com/qyer/bbs/forum_thread_list?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786466&lon=113.671507&type=%@&forum_id=%@&count=10&delcache=1&page=%d"



//登录接口
//http://open.qyer.com/qyer/user/login
#define Login_URL @"http://open.qyer.com/qyer/user/login"
//client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=&app_installtime=1422450627633&lat=34.786497&lon=113.671518&username=18510421092&password=633257&account_s=df920e2287329dc8825912a13b4a2c12&grant_type=password&account_type=1

//登录成功 获取用户信息
//http://open.qyer.com/qyer/user/profile?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=5517284&app_installtime=1422450627633&lat=34.786493&lon=113.671522&user_id=5517284&oauth_token=f4ac974c2f286c6c9391e71861987394
#define LoginSuccess_UserInfo_URL @"http://open.qyer.com/qyer/user/profile?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&track_user_id=%@&app_installtime=1422450627633&lat=34.786493&lon=113.671522&user_id=%@&oauth_token=%@"



//旅途中城市详情
//获取天气
//http://open.qyer.com/qyer/onroad/city_weather?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&app_installtime=1422450627633&lat=34.786466&lon=113.671432&city_id=67
//城市详情
//http://open.qyer.com/qyer/onroad/city_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&app_installtime=1422450627633&device_id=357474045959836&oauth_token=&lat=37.571628&lon=126.98607

#define Traveling_City_URL @"http://open.qyer.com/qyer/onroad/city_detail?client_id=qyer_android&client_secret=9fcaae8aefc4f9ac4915&v=1&track_user_id=&track_deviceid=357474045959836&track_app_version=6.0&track_app_channel=360m&track_device_info=GT-I9100G&track_os=Android4.1.2&app_installtime=1422450627633&device_id=357474045959836&oauth_token=&%@"
#endif

















