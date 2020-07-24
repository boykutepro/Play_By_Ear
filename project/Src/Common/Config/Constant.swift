//
//  Constant.swift
//  
//
//  Created by SUUSOFT on 5/18/17.
//  Copyright © 2018 SUUSOFT. All rights reserved.
//

import UIKit


//MARK: - Constant String
    let APP_NAME                                = ""
    let PRIVACY_POLICY                          = ""
    let TERMS_OF_SERVICE                        = ""
    let GOOGLE_CLIENT_KEY                =           "28584679882-e6kb2l9qhgk6h16ma6hvv825p2ta4h7m.apps.googleusercontent.com"
    let URL_TERM                         = "http://suusoft-demo.com/projects/elearning-martin/backend/web/index.php/setting/term"
    let URL_ABOUT                         = "http://suusoft-demo.com/projects/elearning-martin/backend/web/index.php/setting/about"


//MARK: - API
struct API {
    //TODO: Base URL

   static let baseURL                         = "http://suusoft-demo.com/projects/music-matteo/backend/web/index.php/"
    static let login                          = "api/user/login"
    static let updateProfile                  = "api/user/update-profile"
    static let register                       = "api/user/dang-ky"
    static let profile                        = "api/user/update-profile"
    static let changePassword                 = "api/user/change-password"
    static let forgetPassword                 = "api/user/forget-password"
    static let cateogry                       = "api/category/list"
    static let lesson                         = "api/elearning/list-lesson"
    static let lessonCategory                 = "api/elearning/list-lesson-by-category"
    static let registerDevice                 = "api/device/index"
    static let searchlesson                   = "api/elearning/search-lesson"
   
    
    static let lessonSub                      = "api/elearning/list-sub-lesson"
    static let listQuestion                   = "api/elearning/list-question"
  
    static let listCategory                   = "/api/category/list"
    static let settings                       = "api/utility/setting"
}


//MARK: - TableView & Collection View
struct CellID {
    //TODO: Collection View
    static let collectionCommon                 = "CommonCollectionCell"
    static let collectionPhotoDetails           = "PhotoDetailsCollectionCell"
    
    
    //TODO: Table View
    static let tableLeftMenu                    = "LeftMenuTableCell"
}

struct CellName {
    //TODO: Collection View
    static let collectionCommon                 = "CommonCollectionViewCell"
    static let collectionPhotoDetails           = "PhotoDetailsCollectionViewCell"
    
    //TODO: Table View
    static let tableLeftMenu                    = "LeftMenuTableViewCell"
}



//MARK: - Segue Identifier
struct SegueID {
    static let splashShowBegin                  = "SplashShowBegin"
    static let beginShowTour                    = "BeginShowTour"
    static let tourShowNavigation               = "TourShowNavigation"
    static let loginShowForgot                  = "LoginShowForgot"
    static let loginShowSignUp                  = "LoginShowSignUp"
    static let loginShowSubscription            = "LoginShowSubscription"
    static let profileShowChangePassword        = "ProfileShowChangePassword"
    static let profileShowSubscription          = "ProfileShowSubscription"
    static let homeShowAlbum                    = "HomeShowAlbum"
}


//MARK: - Storyboard Identifier
struct Identifier {
    static let naviVC                           = "Navigation Controller"
    static let slideMenuVC                      = "SlideMenuViewController"
    static let leftMenuVC                       = "LeftMenuViewController2"
    static let profileVC                        = "ProfileViewController"
    static let homeVC                           = "HomeViewController"
    static let favouriteVC                      = "FavouriteViewController"
    static let aboutVC                          = "AboutViewController"
    static let subscriptionVC                   = "SubscriptionViewController"
    static let menuItemVC                       = "MenuItemTableViewCell2"
    static let viewController                   = "ViewController"
    static let feedbackController               = "FeedbackViewController"
    static let moreAppVC                        = "MoreAppViewController"
    static let settingsVC                       = "SettingsViewController"
    static let helpVC                           = "HelpViewController"
}


//MARK: - UserDefaults Key
struct UserDefaultsKey {
    static let currentUser                      = "CurrentUser"
}


//MARK: Check Current Device
struct CurrentDevice {
    static let isIpadBig = UIScreen.main.bounds.width == 1024
    static let isIpad = UIScreen.main.bounds.width == 768
    static let isIphone7Plus = UIScreen.main.bounds.width == 414
    static let isIphone7 = UIScreen.main.bounds.width == 375
}


//MARK: - Value Category Collection View
struct CategoryCollection {
    static var spacingItems: CGFloat = 8        // Spacing Between Items
    static var numberSpacing: CGFloat = 3       // Number Spacing in one Row
    static var numberItemInRow: CGFloat = 2     // Number Item in one Row
}

struct LanguageCode {
    static let VN = "vi"
    static let EN = "en"
}

struct NotificationID {
    static let CHANGE_LANGUAGE = "CHANGE_LANGUAGE"
    static let CHANGE_THEME    = "CHANGE_THEME"
    static let CHANGE_TO_QUEUE    = "CHANGE_TO_QUEUE"
}

struct Constant {
    static let Success = "Success"
    static let Error    = "Error"
    static let Ok    = "OK"
    static let Notification_1 = "Tao_Moi_Giao_Dich"
    static let Message = "Thông báo"
}

struct Response {
    static let Success = "SUCCESS"
    static let Error    = "ERROR"
    static let Ok    = "OK"
}

struct Action {
    static let Birthday = "birthday"
    static let Gift    = "gift"
    static let Login    = "active"
    static let ORDER_PAID    = "order-paid"
    static let ORDER_NEW    = "order-new"
    static let COMMENT    = "comment"
    static let FRIEND_FOLLOW    = "friend-follow"
    static let CHITIEU_CREATE    = "chitieu-create"
}

struct APIKey {
    //Common
    static let total_page = "total_page"
    static let iOSDevice = 2
    static let token = "token"
    static let loginToken = "login_token"
    static let debug = "debug"
    static let username = "username"
    static let password = "password"
    static let success = "success"
    static let status = "status"
    static let message = "message"
    static let code = "code"
    static let status_code = "status_code"
    static let data = "data"
    static let name = "name"
    static let email = "email"
    static let fullName = "full_name"
    static let avatar = "avatar"
    static let gender = "gender"
    static let phone = "phone"
    static let address = "address"
    static let imei = "ime"
    static let gcm_id = "gcm_id"
    static let type = "type"
    static let login_type = "login_type"
    static let user_id = "user_id"
    static let user_email = "user_email"
    static let qb_user_id = "qb_id"
    static let description = "description"
    static let dob = "dob"
    static let image = "image"
    static let file = "file"
    static let attachment = "attachment"
    static let is_active = "is_active"
    static let is_secured = "is_secured"
    static let id = "id"
    static let deal = "deal"
    static let deal_online_rate = "deal_online_rate"
    static let premium_deal_online_rate = "premium_deal_online_rate"
    static let driver_online_rate = "driver_online_rate"
    static let exchange_rate = "exchange_rate"
    static let passenger = "passenger"
    static let driver = "driver"
    static let seller = "seller"
    static let seller_qb_id = "seller_qb_id"
    static let buyer = "buyer"
    static let buyer_id = "buyer_id"
    static let buyer_name = "buyer_name"
    static let current_password = "current_password"
    static let new_password = "new_password"
    static let vehicle_data = "vehicle_data"
    static let pro_data = "pro_data"
    static let driver_data = "driver_data"
    static let basic = "basic"
    static let pro = "pro"
    static let user = "user"
    static let trip = "trip"
    static let about = "about"
    static let faq = "faq"
    static let help = "help"
    static let term = "term"
    static let searching_deal_distance = "searching_deal_distance"
    static let searching_driver_distance = "searching_driver_distance"
    static let term_and_condition = "term_and_condition"
    
    //Accout pro keys
    static let business_description = "business_description"
    static let business_name = "business_name"
    static let business_email = "business_email"
    static let business_address = "business_address"
    static let business_website = "business_website"
    static let business_phone = "business_phone"
    static let driver_experience = "driver_experience"
    static let driver_license = "driver_license"
    static let fare = "fare"
    static let is_delivery = "is_delivery"
    static let permit = "permit"
    static let insurance = "insurance"
    static let yearly_km = "yearly_km"
    static let yearly_insurance = "yearly_insurance"
    static let yearly_maintenance = "yearly_maintenance"
    static let yearly_tax = "yearly_tax"
    static let yearly_gara = "yearly_gara"
    static let yearly_unexpected = "yearly_unexpected"
    static let year_intend = "year_intend"
    static let price_4_new_tyres = "price_4_new_tyres"
    static let average_consumption = "average_consumption"
    static let online_duration = "online_duration"
    static let online_started = "online_started"
    
    static let fuel_unit_price = "fuel_unit_price"
    static let fuel_type = "fuel_type"
    static let sold_value = "sold_value"
    static let bought_value     = "bought_value"
    static let plate = "plate"
    static let brand = "brand"
    static let model = "model"
    static let color_ = "color"
    static let year = "year"
    static let balance = "balance"
    
    //Deal keys
    static let deal_id = "deal_id"
    static let deal_name = "deal_name"
    static let action = "action"
    static let category_id = "category_id"
    static let marked_price = "user_id"
    static let discount_rate = "discount_rate"
    static let discount_value = "discount_value"
    static let discount_price = "discount_price"
    static let discount = "discount"
    static let latitude = "lat"
    static let longitude = "long"
    static let is_premium = "is_premium"
    static let duration = "duration"
    static let keyword = "keyword"
    static let search_type = "search_type"
    static let is_online = "is_online"
    static let page = "page"
    static let number_per_page = "number_per_page"
    static let price = "price"
    static let distance = "distance"
    static let create = "create"
    static let update = "update"
    static let delete = "delete"
    static let is_renew = "is_renew"
    static let created_user = "created_user"
    static let sort_type = "sort_type"
    static let sort_by = "sort_by"
    static let discount_type = "discount_type"
    
    //Reviews
    static let author_id = "author_id"
    static let author_name = "author_name"
    static let author_avatar = "author_avatar"
    static let destination_id = "destination_id"
    static let destination_role = "destination_role"
    static let author_role = "author_role"
    static let object_id = "object_id"
    static let object_type = "object_type"
    static let content = "content"
    static let rate = "rate"
    static let rate_count = "rate_count"
    static let total_rate = "total_rate_count"
    static let avg_rate = "avg_rate"
    static let like_status = "like_status"
    static let like_count = "like_count"
    static let is_favourite = "is_favourite"
    
    //Transactions
    static let amount = "amount"
    static let time = "time"
    static let note = "note"
    static let payment_method = "payment_method"
    static let payment_status = "payment_status"
    static let destination_email = "destination_email"
    static let revenue = "revenue"
    static let currency = "currency"
    static let transaction_id = "transaction_id"
    static let external_transaction_id = "external_transaction_id"
    static let expense = "expense"
    static let month = "month"
    
    //Transport
    static let estimate_fare = "estimate_fare"
    static let estimate_duration = "estimate_duration"
    static let estimate_distance = "estimate_distance"
    static let start_lat = "start_lat"
    static let start_long = "start_long"
    static let end_lat = "end_lat"
    static let end_long = "end_long"
    static let passenger_id = "passenger_id"
    static let driver_id = "driver_id"
    static let trip_id = "trip_id"
    static let seat_count = "seat_count"
    static let actual_fare = "actual_fare"
    static let start_location = "start_location"
    static let end_location = "end_location"
    static let mode = "mode"
    static let driver_name = "driver_name"
    static let driver_phone = "driver_phone"
    static let driver_type = "driver_type"
    static let driver_is_delivery = "driver_is_delivery"
    
    //Setting
    static let notify = "notify"
    static let notify_favourite = "notify_favourite"
    static let notify_food = "notify_food"
    static let notify_labor = "notify_labor"
    static let notify_nearby = "notify_nearby"
    static let notify_shopping = "notify_shopping"
    static let notify_transport = "notify_transport"
    static let notify_travel = "notify_travel"
    static let notify_news = "notify_news"
    static let notify_other = "notify_nearby"
    static let notification_type = "notificationType"
    
    //Friend
    static let friend_id = "friend_id"
    
    //reservation
    static let reservation_id = "reservation_id"
    
    static let QUICKBLOX_MESSAGE = "quickbloxMessage"
    static let QUICKBLOX_CALLING = "quickbloxCalling"
    static let RECENT_CHAT_OBJECT = "recentChatObj"
    static let paymentMethodPush = "paymentMethod"
}
