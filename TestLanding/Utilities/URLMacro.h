//
//  URLMacro.h
//  YiMaMa
//
//  Created by LWF on 16/1/4.
//  Copyright (c) 2016年 YiMaMa. All rights reserved.
//

#ifndef YiMaMa_URLMacro_h
#define YiMaMa_URLMacro_h

//服务器地址
#define SERVER_ADDRESS @"http://app.yimama.com.cn"
//#define SERVER_ADDRESS @"http://localhost:3000"

#define Res_ADDRESS @"http://res.yimama.com.cn/media"

#define IMAGE_URL(imgPath) ([imgPath hasPrefix:@"http"]) ? (imgPath) : ([NSString stringWithFormat:@"%@/%@", Res_ADDRESS, imgPath])
#define ResURL(_url) [NSString stringWithFormat:@"%@/%@", Res_ADDRESS,_url]

//支付相关
#define WECHATPAYURL [NSString stringWithFormat:@"%@/api/wxpay/createPrepayOrder", SERVER_ADDRESS]

#define WECHATPAYPOSTURL [NSString stringWithFormat:@"%@/api/wxpay/createPrepayOrder", SERVER_ADDRESS]
//爱心币余额查询接口
#define LM_USER_AMOUNT_URL [NSString stringWithFormat:@"%@/api/lm/getUserLmAmount", SERVER_ADDRESS]

#define LM_LOVE_MONEY_PAY_URL [NSString stringWithFormat:@"%@/api/lovemoneyPay/createPayOrder", SERVER_ADDRESS]
//1.2 payOrder接口(爱心币去支付订单)
#define LM_LOVE_MONEY_PAY_PAYORDER_URL [NSString stringWithFormat:@"%@/api/lovemoneyPay/payOrder", SERVER_ADDRESS]

#define LM_ALIPAY_CreatePaymentOrder_URL [NSString stringWithFormat:@"%@/api/alipay/createPaymentOrder", SERVER_ADDRESS]


/**
 *  登陆注册模块
 */
//登陆
#define LOGIN_URL  [NSString stringWithFormat:@"%@/api/login", SERVER_ADDRESS]
//登出
#define LOGOUT_URL  [NSString stringWithFormat:@"%@/api/logout", SERVER_ADDRESS]
//心跳
#define HEART_BEAT_URL  [NSString stringWithFormat:@"%@/api/heartbeat", SERVER_ADDRESS]
//获取手机验证码 注册 (现在不用)
//#define FETCH_CHECK_CODE_URL  [NSString stringWithFormat:@"%@/api/regCheckCode", SERVER_ADDRESS]

//获取手机验证码  fastCheckCode
#define FETCH_FAST_CHECK_CODE_URL  [NSString stringWithFormat:@"%@/api/fastCheckCode", SERVER_ADDRESS]


//快速登录
#define FAST_LOGIN_URL  [NSString stringWithFormat:@"%@/api/fastLogin", SERVER_ADDRESS]
//设置用户角色
#define SET_CUSTOMROLE_URL  [NSString stringWithFormat:@"%@/api/regRole", SERVER_ADDRESS]
//文件上传
#define FILE_UPLOAD_URL  [NSString stringWithFormat:@"%@/im/post_upload", SERVER_ADDRESS]


/**
 *  分销
 */
//添加用户和分销商
#define ADD_CUSTOMRELATION_URL  [NSString stringWithFormat:@"%@/api/drp/addGoodUserRelation", SERVER_ADDRESS]
//去分销
#define ADD_MERCHANT_URL  [NSString stringWithFormat:@"%@/api/drp/addMerchant", SERVER_ADDRESS]


/**
 *  地址
 */
//查询所有省份
#define FETCH_PROVICES_URL  [NSString stringWithFormat:@"%@/api/adr/pro", SERVER_ADDRESS]
//获取省下城市
#define FETCH_CITIES_URL  [NSString stringWithFormat:@"%@/api/adr/cities", SERVER_ADDRESS]
//获取城市下区域
#define FETCH_DISTRICT_URL  [NSString stringWithFormat:@"%@/api/adr/areas", SERVER_ADDRESS]
//添加用户地址信息
#define ADD_USER_ADDRESS_URL  [NSString stringWithFormat:@"%@/api/adr/addUserAddress", SERVER_ADDRESS]
//修改用户地址信息
#define MODIFY_USER_ADDRESS_URL  [NSString stringWithFormat:@"%@/api/adr/updateUserAddress", SERVER_ADDRESS]
//删除用户地址信息
#define DELETE_USER_ADDRESS_URL  [NSString stringWithFormat:@"%@/api/adr/deleteUserAddress", SERVER_ADDRESS]
//查询用户地址信息列表
#define SEARCH_USER_ADDRESS_URL  [NSString stringWithFormat:@"%@/api/adr/userAddressList", SERVER_ADDRESS]
//设置默认地址
#define SET_DEFAULT_ADDRESS_URL  [NSString stringWithFormat:@"%@/api/adr/defaultUserAddress", SERVER_ADDRESS]



/**
 *  社区
 */
//个人空间用户详情
#define FETCH_CUSTOM_INFO_URL  [NSString stringWithFormat:@"%@/api/follow/getUserInfo", SERVER_ADDRESS]
//获取用户关注列表信息
#define FETCH_CUSTOM_FOLLOWLIST_INFO_URL  [NSString stringWithFormat:@"%@/api/follow/listFollows", SERVER_ADDRESS]
//获取用户的粉丝列表接口
#define FETCH_CUSTOM_FANSLIST_INFO_URL  [NSString stringWithFormat:@"%@/api/follow/listFensi", SERVER_ADDRESS]
//关注/取消关注
#define FOLLOW_OR_CANCEL_URL  [NSString stringWithFormat:@"%@/api/follow/addFollow", SERVER_ADDRESS]
//赞取消赞
#define RAISE_OR_CANCEL_RAISE_URL  [NSString stringWithFormat:@"%@/api/follow/raise", SERVER_ADDRESS]
//获取某条信息的赞的用户列表
#define FETCH_RAISE_CUSTOMLIST_URL  [NSString stringWithFormat:@"%@/api/follow/raiselist", SERVER_ADDRESS]
//发帖
#define POST_TOPIC_URL  [NSString stringWithFormat:@"%@/api/topic/addTopic", SERVER_ADDRESS]
//获取该用户发布的未删除话题列表
#define FETCH_TOPICLIST_URL  [NSString stringWithFormat:@"%@/api/topic/getusertopiclist", SERVER_ADDRESS]
//根据不同宿主类型获取帖子列表
#define FETCH_DIFFERENT_CUSTOM_TOPICLIST_URL  [NSString stringWithFormat:@"%@/api/topic/gethosttopiclist", SERVER_ADDRESS]
//主题帖修改接口
#define MODIFY_TOPIC_URL  [NSString stringWithFormat:@"%@/api/topic/modify", SERVER_ADDRESS]
//点击主题查看详细帖子信息
#define INSPECT_TOPIC_DETAIL_URL  [NSString stringWithFormat:@"%@/api/topic/get", SERVER_ADDRESS]
//帖子删除图片
#define DELETE_TOPIC_IMAGE_URL  [NSString stringWithFormat:@"%@/api/media/removeImg", SERVER_ADDRESS]
//用户评论信息
#define ANSWER_INFO_URL  [NSString stringWithFormat:@"%@/api/comments/add", SERVER_ADDRESS]
//获取用户评论集合
#define FETCH_COMMENT_URL  [NSString stringWithFormat:@"%@/api/comments/list", SERVER_ADDRESS]
//删除评论接口
#define DELETE_COMMENT_URL  [NSString stringWithFormat:@"%@/api/comments/remove", SERVER_ADDRESS]
//创建群组
#define SET_UP_GROUP_URL  [NSString stringWithFormat:@"%@/api/group/create", SERVER_ADDRESS]
//群组明细接口
#define GROUP_DETAIL_URL  [NSString stringWithFormat:@"%@/api/group/get", SERVER_ADDRESS]
//获取当前登录用户加入以及创建的群组列表信息
#define FETCH_CUSTOM_AND_GROUP_DETAIL_URL  [NSString stringWithFormat:@"%@/api/group/mygrouplist", SERVER_ADDRESS]
//获取平台所有的群组列表信息
#define FETCH_GROUPS_INFO_URL  [NSString stringWithFormat:@"%@/api/group/allgrouplist", SERVER_ADDRESS]
//获取附近群组接口
#define FETCH_AROUND_GROUPS_URL  [NSString stringWithFormat:@"%@/api/group/neargrouplist", SERVER_ADDRESS]
//用户加入群组
#define JOIN_GROUP_URL  [NSString stringWithFormat:@"%@/api/group/userApply", SERVER_ADDRESS]
//用户退出群组
#define LEAVE_GROUP_URL  [NSString stringWithFormat:@"%@/api/group/user_unfollow_group", SERVER_ADDRESS]
//获取版块列表
#define FETCH_PLACE_LIST_URL  [NSString stringWithFormat:@"%@/api/forum/list", SERVER_ADDRESS]
//获取版块详细信息
#define FETCH_PLACE_DETAIL_URL  [NSString stringWithFormat:@"%@/api/forum/get", SERVER_ADDRESS]
//收藏
#define COLLECT_URL  [NSString stringWithFormat:@"%@/api/fav/addorcancelfav", SERVER_ADDRESS]
//获取登录用户收藏列表
#define FETCH_COLLECT_LIST_URL  [NSString stringWithFormat:@"%@/api/fav/list", SERVER_ADDRESS]


/**
 *  妈妈
 */
//取得妈妈列表信息
#define FETCH_MOTHER_LIST_INFO_URL  [NSString stringWithFormat:@"%@/api/mama/getMamaList", SERVER_ADDRESS]
//获取指定的妈妈信息
#define FETCH_MOTHER_INFO_URL  [NSString stringWithFormat:@"%@/api/mama/getMamaInfo", SERVER_ADDRESS]
//修改妈妈信息
#define MODIFY_MOTHER_INFO_URL  [NSString stringWithFormat:@"%@/api/mama/modifyMamaInfo", SERVER_ADDRESS]
//修改妈妈头像
#define MODIFY_MOTHER_HEAD_IMAGE_URL  [NSString stringWithFormat:@"%@/api/mama/modifyMamaHeaderImg", SERVER_ADDRESS]
//获取宝宝列表
#define FETCH_BABY_LIST_URL  [NSString stringWithFormat:@"%@/api/mama/getBabyList", SERVER_ADDRESS]
//获取宝宝信息
#define FETCH_BABY_INFO_URL  [NSString stringWithFormat:@"%@/api/mama/getBabyInfo", SERVER_ADDRESS]
//新增宝宝信息
#define ADD_BABY_INFO_URL  [NSString stringWithFormat:@"%@/api/mama/addBabyInfo", SERVER_ADDRESS]
//修改宝宝信息
#define MODIFY_BABY_INFO_URL  [NSString stringWithFormat:@"%@/api/mama/modifyBabyInfo", SERVER_ADDRESS]
//修改宝宝头像
#define MODIFY_BABY_HEAD_IMAGE_URL  [NSString stringWithFormat:@"%@/api/mama/modifyBabyHeaderImg", SERVER_ADDRESS]
//删除宝宝信息
#define DELETE_BABY_INFO_URL  [NSString stringWithFormat:@"%@/api/mama/removeBabyInfo", SERVER_ADDRESS]
//我的作品 (进行中)
#define MY_WORKS_DOING_URL  [NSString stringWithFormat:@"%@/api/mama/listMyWorksInProgress", SERVER_ADDRESS]
//我的作品 (未完成)
#define MY_WORKS_UNFINISH_URL  [NSString stringWithFormat:@"%@/api/mama/listMyWorksUnfinished", SERVER_ADDRESS]
//我的作品 (已完成)
#define SET_UP_GROUP_ED_URL  [NSString stringWithFormat:@"%@/api/mama/listMyWorksFinished", SERVER_ADDRESS]


/**
 *  众筹订单
 */
//众筹生成
#define ZC_GENERATE_URL  [NSString stringWithFormat:@"%@/api/cf/saveCf", SERVER_ADDRESS]
//系统素材分页展示
#define SOURCE_SHOW_URL  [NSString stringWithFormat:@"%@/api/mt/list", SERVER_ADDRESS]
//设计师级别读取
#define RED_DESIGNER_LEVEL_URL  [NSString stringWithFormat:@"%@/api/designer/level", SERVER_ADDRESS]
//设计师信息分页读取
#define RED_DESIGNER_INFO_URL  [NSString stringWithFormat:@"%@/api/designer/list", SERVER_ADDRESS]
//众筹按条件搜索
#define ZC_CONDITION_SEARCH_URL  [NSString stringWithFormat:@"%@/api/cf/list", SERVER_ADDRESS]
//众筹基本信息查询
#define ZC_BASIC_INFO_SEARCH_URL  [NSString stringWithFormat:@"%@/api/cf/get", SERVER_ADDRESS]
//购物车列表
#define SHOPPINGCAR_LIST_URL  [NSString stringWithFormat:@"%@/api/basket/search", SERVER_ADDRESS]
//购物车新增
#define ADD_SHOPPINGCAR_URL  [NSString stringWithFormat:@"%@/api/basket/add", SERVER_ADDRESS]
//购物车修改
#define MODIFY_SHOPPINGCAR_URL  [NSString stringWithFormat:@"%@/api/basket/edit", SERVER_ADDRESS]
//购物车删除
#define DELETE_SHOPPINGCAR_URL  [NSString stringWithFormat:@"%@/api/basket/remove", SERVER_ADDRESS]
//清除购物车
#define CLEAR_SHOPPINGCAR_URL  [NSString stringWithFormat:@"%@/api/basket/clean", SERVER_ADDRESS]
//订单生成
#define ORDER_GENERATE_URL  [NSString stringWithFormat:@"%@/api/cforder/add", SERVER_ADDRESS]
//用户订单列表
#define ORDER_LIST_URL  [NSString stringWithFormat:@"%@/api/cforder/list", SERVER_ADDRESS]
//订单详情查询
#define ORDER_DETAIL_SEARCH_URL  [NSString stringWithFormat:@"%@/api/cforder/getOrderMsg", SERVER_ADDRESS]
//确认收货接口
#define CONFORM_RECEIVE_GOODS_URL  [NSString stringWithFormat:@"%@/api/cforder/confirmRecipient", SERVER_ADDRESS]
//众筹修改接口
#define ZC_MODIFY_URL  [NSString stringWithFormat:@"%@/api/cf/modifyCf", SERVER_ADDRESS]
//设计师新增作品
#define DESIGEER_ADD_WORKS_URL  [NSString stringWithFormat:@"%@/api/designer/addworks", SERVER_ADDRESS]
//设计师作品提交审核
#define DESIGNER_WORKS_SUBMIT_CHECK_URL  [NSString stringWithFormat:@"%@/api/designer/approve", SERVER_ADDRESS]
//获取设计师作品详情
#define FETCH_DESIGNER_WORKS_DETAIL_URL  [NSString stringWithFormat:@"%@/api/designer/getDetail", SERVER_ADDRESS]
//获取设计师作品申请记录
#define FETCH_DESIGNER_WORKS_APPLY_INFO_URL  [NSString stringWithFormat:@"%@/api/designer/getWorkHistorys", SERVER_ADDRESS]
//获取设计师未提交或申请未通过的作品
#define FETCH_DESIGNER_UNSUBMIT_OR_FAIL_APPLY_URL  [NSString stringWithFormat:@"%@/api/designer/listDesignerWorksUnfinished", SERVER_ADDRESS]
//获取设计师已提交申请中作品接口
#define FETCH_DESIGNER_SUBMIT_WORKS_URL  [NSString stringWithFormat:@"%@/api/designer/listDesignerWorksInProgress", SERVER_ADDRESS]
//获取设计师已提交并申请通过作品
#define FETCH_DESIGNER_SUBMIT_AND_SUCCESS_APPLY_WORKS_URL  [NSString stringWithFormat:@"%@/api/designer/listDesignerWorksFinished", SERVER_ADDRESS]
//获取设计师已经审核通过的素材
#define FETCH_DESIGNER_SUCCESS_CHECK_WORKS_URL  [NSString stringWithFormat:@"%@/api/designer/queryMaterialByDesigner", SERVER_ADDRESS]
//指定用户的众筹列表
#define FETCH_CUSTOM_ZC_LIST_URL  [NSString stringWithFormat:@"%@/api/cf/listReferInvolvedCf", SERVER_ADDRESS]

//获取全部的素材
#define FETCH_DESIGNER_ALL_SUCCESS_CHECK_WORKS_URL  [NSString stringWithFormat:@"%@/api/designer/queryMaterial", SERVER_ADDRESS]
//10.31购物车众筹数量获取接口
#define FETCH_CF_BasketTotalAmount [NSString stringWithFormat:@"%@/api/basket/getBasketTotalAmount", SERVER_ADDRESS]

//10.34众筹尺码接口
#define FETCH_CF_GetCfSize [NSString stringWithFormat:@"%@/api/cf/getCfSize", SERVER_ADDRESS]

//我的订单

/**
 *  爱心币相关
 */
#define FETCH_CHECK_MISC_CODE_URL  [NSString stringWithFormat:@"%@/api/checkMiscCode", SERVER_ADDRESS]

//4.1设置支付密码
#define PASSWORD_SET_PAY_PASSWORD_URL  [NSString stringWithFormat:@"%@/api/password/setPayPwd", SERVER_ADDRESS]


/**
 *  其他
 */
//即时通讯客服设计师获取
#define FETCH_CUSTOMER_SERVICE_URL  [NSString stringWithFormat:@"%@/api/user/getSysCustomer", SERVER_ADDRESS]
//申请提现
#define APPLY_CASH_URL  [NSString stringWithFormat:@"%@/api/cashout/apply_cashout", SERVER_ADDRESS]
//查询用户提现记录
#define SEARCH_CUSTOM_APPLY_CASH_INFO_URL  [NSString stringWithFormat:@"%@/api/cashout/apply_cashout_record", SERVER_ADDRESS]
//查询用户银行信息列表
#define SEARCH_CUSTOM_BANK_INFO_URL  [NSString stringWithFormat:@"%@/api/cashout/userBankList", SERVER_ADDRESS]
//查询系统银行信息列表
#define SEARCH_SYSTEM_BANK_INFO_URL  [NSString stringWithFormat:@"%@/api/cashout/baseBankList", SERVER_ADDRESS]
//添加用户的银行信息
#define ADD_CUSTOM_BANK_INFO_URL  [NSString stringWithFormat:@"%@/api/cashout/addUserBank", SERVER_ADDRESS]
//来图定制提交接口
#define PICTURE_CUSTOM_COMMIT_URL  [NSString stringWithFormat:@"%@/api/piccustom/save", SERVER_ADDRESS]
//获取广告内容
#define FETCH_AD_URL  [NSString stringWithFormat:@"%@/api/adv/getAdv", SERVER_ADDRESS]
//获取基础数据
#define FETCH_BASIC_DATA_URL  [NSString stringWithFormat:@"%@/api/dict/list", SERVER_ADDRESS]

#endif
