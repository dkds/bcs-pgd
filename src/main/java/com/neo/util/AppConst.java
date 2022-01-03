/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import java.text.SimpleDateFormat;
import java.util.HashMap;

/**
 *
 * @author neo
 */
public final class AppConst {

    private AppConst() {
    }

    public static final class Admin {

        public static final String REQUEST_TYPE_ITEM_VIEW_COUNTER = "item_view_counter";
        public static final String REQUEST_TYPE_SEARCH_USERS = "user_search";
        public static final String REQUEST_TYPE_SEARCH_ITEMS = "item_search";
        public static final String REQUEST_TYPE_APP_PROPERTIES = "app_properties";
        public static final String PARA_ITEM_VIEW = "item_view";
        public static final String PARA_SEARCH_TEXT = "search_text";
        public static final String PARA_USER_UID = "admin_uid";
        public static final String PARA_ABOUT_US_DESCRIPTION = "about_us_description";
        public static final String PARA_ABOUT_US_ADDRESS = "about_us_address";
        public static final String PARA_ABOUT_US_START_YEAR = "about_us_start_year";
        public static final String PARA_ABOUT_US_EMPLOYEE_COUNT = "about_us_emplyee_count";
        public static final String PARA_ABOUT_US_COMPANY_VISION = "about_us_vision";
        public static final String PARA_COPYRIGHT_TEXT = "copyright_text";
        public static final String PARA_PRIVACY_POLICY = "privacy_policy";
        public static final String PARA_TERMS_AND_CONDITIONS = "terms_and_conditions";
        public static final String PARA_IMAGE_NAME = "image_name";
        public static final String PARA_IMAGE_ORDINAL = "image_ordinal";
        public static final String PARA_VAL_ITEM_VIEW_ENTER = "enter";
        public static final String PARA_VAL_ITEM_VIEW_LEAVE = "leave";
        public static final String CONTEXT_ATTR_APP_PROPERTIES = "app_properties";
    }

    public static final class Message {

        public static final String SUBJECT_ITEM_SOLD = "Your items are sold";
        public static final String STATUS_NO_NEW_MESSAGES = "no_new_messages";
        public static final String REQUEST_TYPE_CHECK_NEW_MESSAGES = "check_new_messages";
        public static final String REQUEST_TYPE_DELETE_MESSAGES = "delete_messages";
        public static final String PARA_MESSAGE_IDS = "message_ids";
    }

    public static final class Item {

        public static final String PARA_SEARCH_TEXT = "search_text";
        public static final String PARA_SEARCH_MAIN_CATEGORY_ID = "search_category_main";
        public static final String PARA_SEARCH_ITEM_CATEGORY_ID = "search_category_id";
        public static final String PARA_SEARCH_PRICE_RANGE = "search_price_max";
        public static final String PARA_SEARCH_MATERIALS = "search_materials";
        public static final String PARA_SEARCH_COLORS = "search_colors";
        public static final String PARA_SEARCH_STYLES = "search_styles";
        public static final String PARA_SEARCH_ORDERS = "search_orders";
        public static final String PARA_SEARCH_RESULT_PAGE_NO = "search_result_page";
        public static final String PARA_SUGGEST_TERM = "term";
        public static final String PARA_NAME = "name";
        public static final String PARA_CATEGORY = "category";
        public static final String PARA_CONDITION = "condition";
        public static final String PARA_SUMMARY = "summary";
        public static final String PARA_DESCRIPTION = "description";
        public static final String PARA_IMAGES = "image";
        public static final String PARA_IMAGE_NAME = "image_name";
        public static final String PARA_IMAGE_DEFAULT = "image_default";
        public static final String PARA_UNITPRICE = "unitprice";
        public static final String PARA_QUANTITY = "quantity";
        public static final String PARA_LOCATION = "location";
        public static final String PARA_DELIVERY_OPTION = "delivery_option";
        public static final String PARA_DELIVERY_DESCRIPTION = "delivery_description";
        public static final String PARA_RETURN_OPTION = "return_option";
        public static final String PARA_RETURN_DESCRIPTION = "return_description";
        public static final String PARA_RETURN_TIME_LIMIT = "return_time_limit";
        public static final String PARA_GUARANTEE_OPTION = "gurantee_option";
        public static final String PARA_GUARANTEE_DESCRIPTION = "gurantee_description";
        public static final String PARA_GUARANTEE_TIME_LIMIT = "gurantee_time_limit";
        public static final String PARA_UID = "uid";
        public static final String REQUEST_TYPE_ITEM_NEW = "item_new";
        public static final String REQUEST_TYPE_ITEM_DRAFT = "item_draft";
        public static final String REQUEST_TYPE_ITEM_UPDATE = "item_update";
        public static final String REQUEST_TYPE_REMOVE_DRAFT = "remove_draft";
        public static final String REQUEST_TYPE_SUGGEST_ITEMS = "suggest_items";
        public static final String REQUEST_TYPE_ITEM_LIST = "item_list";
        public static final String REQUEST_TYPE_ITEM_LIST_MOVE = "item_list_move";
        public static final String REQUEST_TYPE_ADD_TO_CART = "add_to_cart";
        public static final String REQUEST_TYPE_REMOVE_FROM_CART = "remove_from_cart";
        public static final String REQUEST_TYPE_BUY_CART = "buy_cart";
        public static final String REQUEST_SUGGESIONS = "SerItmMng?" + Application.PARA_REQUEST_TYPE + "=" + REQUEST_TYPE_SUGGEST_ITEMS + "&";
        public static final String REQUEST_ITEM_LIST = "SerItmMng?" + Application.PARA_REQUEST_TYPE + "=" + REQUEST_TYPE_ITEM_LIST;
        public static final String REQUEST_ITEM_LIST_BY_CATEGORY_MAIN = "SerItmMng?" + Application.PARA_REQUEST_TYPE + "=" + REQUEST_TYPE_ITEM_LIST + "&" + PARA_SEARCH_MAIN_CATEGORY_ID + "=";
        public static final String REQUEST_ITEM_LIST_BY_CATEGORY_SUB = "SerItmMng?" + Application.PARA_REQUEST_TYPE + "=" + REQUEST_TYPE_ITEM_LIST + "&" + PARA_SEARCH_ITEM_CATEGORY_ID + "=";
        public static final String REQUEST_RESULTS = "product_search.jsp?" + Application.PARA_REQUEST_TYPE + "=" + REQUEST_TYPE_ITEM_LIST;
        public static final String REQUEST_RESULTS_MOVE = "product_search.jsp?" + Application.PARA_REQUEST_TYPE + "=" + Item.REQUEST_TYPE_ITEM_LIST_MOVE + "&" + Item.PARA_SEARCH_RESULT_PAGE_NO + "=";
        public static final String REQUEST_RESULTS_BY_CATEGORY_MAIN = "product_search.jsp?" + Application.PARA_REQUEST_TYPE + "=" + REQUEST_TYPE_ITEM_LIST + "&" + PARA_SEARCH_MAIN_CATEGORY_ID + "=";
        public static final String REQUEST_RESULTS_BY_CATEGORY_SUB = "product_search.jsp?" + Application.PARA_REQUEST_TYPE + "=" + REQUEST_TYPE_ITEM_LIST + "&" + PARA_SEARCH_ITEM_CATEGORY_ID + "=";
        public static final String PARA_VAL_CITY_DEFAULT = "- Select city -";
        public static final String PARA_VAL_ITEM_OPTION_DEFAULT = "- Select option -";
        public static final String PARA_VAL_ITEM_OPTION_UNSELECTED = "Unselected";
        public static final String PARA_VAL_SEARCH_PROPERTY_DEFAULT = "All";
        public static final String CONTAINER_TYPE_DRAFT = "Draft";
        public static final String CONTAINER_TYPE_STOCK = "Stock";
        public static final String CONTAINER_TYPE_CART = "Cart";
        public static final String CONTAINER_TYPE_WISHLIST = "Wishlist";
        public static final String CONTAINER_TYPE_BOUGHT = "Bought";
        public static final String CONTAINER_TYPE_SOLD = "Sold";
        public static final String PARA_CUSTOM_PROPERTY_NAME_PREFIX = "custom_property_";
        public static final String PARA_CUSTOM_PROPERTY_VALUE_PREFIX = "custom_value_";
        public static final String PARA_CUSTOM_PROPERTY_VISIBLE_PREFIX = "custom_visible_";
        public static final String SESSION_ATTR_ITEM_TEMP = "item_temp";
        public static final String SESSION_ATTR_ITEM_DRAFT = "item_draft";
        public static final String SESSION_ATTR_ITEM_UPDATE = "item_update";
        public static final String SESSION_ATTR_SEARCH_RESULT = "search_result";
        public static final String STATUS_DRAFT_SAVE_SUCCESS = "draft_save_success";
        public static final String STATUS_DRAFT_SAVE_ERROR = "draft_save_error";
        public static final String STATUS_DRAFT_REMOVE_ERROR = "draft_remove_error";
        public static final String STATUS_CART_ITEM_REMOVE_ERROR = "cart_item_remove_error";
        public static final long MAX_UID_AGE = 1000 * 60 * 60 * 24 * 3; // 3 days 1000 * 60 * 60 * 24 * 3
        public static final int MAX_SEARCH_RESULTS_PER_PAGE = 10;
        public static final int MAX_VISIBLE_PAGE_SELECTORS = 5;
        public static final int MAX_HIBERNATE_RESULTS_COUNT = 50;

        private Item() {
        }
    }

    public static final class Application {

        public static final String REAL_PATH = "C:/Users/ddissnayake/projects/java/bcs-pgd";
        public static final String BRANDING_LOGO = "images/ui/svg/logo.svg";
        public static final String SESSION_ATTR_RESPONSE_MESSAGE = "response_message";
        public static final String SESSION_ATTR_CATEGORY_LIST = "category_list";
        public static final String SESSION_ATTR_MESSAGE_MANAGER = "message_manager";
        public static final String SESSION_ATTR_USER_MANAGER = "user_manager";
        public static final String SESSION_ATTR_SECURITY_Q_MANAGER = "security_q_manager";
        public static final String SESSION_ATTR_ITEM_MANAGER = "item_manager";
        public static final String SESSION_ATTR_ITEM_CATEGORY_MANAGER = "item_category_manager";
        public static final String SESSION_ATTR_ITEM_OPTIONS_MANAGER = "item_options_manager";
        public static final String SESSION_ATTR_ITEM_PROPERTY_MANAGER = "item_property_manager";
        public static final String SESSION_ATTR_DATA_UTIL = "data_util";
        public static final String CONTEXT_ATTR_APP_PROPERTY_MANAGER = "app_property_manager";
        public static final String CONTEXT_ATTR_LOCATION_MANAGER = "location_manager";
        public static final String CONTEXT_ATTR_IMAGE_MANAGER = "image_manager";
        public static final String CONTEXT_ATTR_DATA_UTIL = "data_util";
        public static final String REQUEST_ATTR_HIB_SESSION = "hibernate_session";
        public static final String PARA_CURRENT_LOCATION = "current_location";
        public static final String PARA_REQUEST_TYPE = "type";
        public static final long CLEANER_INTERVAL = 1000 * 60 * 15;//15 mins
        public static final long CLEANER_DATABASE_ROUNDS = 5;//every 5 rounds
        public static final SimpleDateFormat DEFAULT_DATE_FORMAT = new SimpleDateFormat("yyyy-MM-dd hh:mm aa");

        private Application() {
        }
    };

    public static final class User {

        public static final String AVATAR_NAME_GENERIC_FEMALE = "generic-female";
        public static final String AVATAR_NAME_GENERIC_MALE = "generic-male";
        public static final String AVATAR_NAME_SELECT_IMAGE = "select-image";
        public static final String AVATAR_PATH_GENERIC_FEMALE = "images/user/svg/" + AVATAR_NAME_GENERIC_FEMALE + ".svg";
        public static final String AVATAR_PATH_GENERIC_MALE = "images/user/svg/" + AVATAR_NAME_GENERIC_MALE + ".svg";
        public static final String AVATAR_PATH_SELECT_IMAGE = "images/user/svg/" + AVATAR_NAME_SELECT_IMAGE + ".svg";
        public static final String COOKIE_NAME = "UID";
        public static final String PARA_ADDRESS_CITY = "address_city";
        public static final String PARA_ADDRESS_LINE_1 = "address_line_1";
        public static final String PARA_ADDRESS_LINE_2 = "address_line_2";
        public static final String PARA_ADDRESS_LINE_3 = "address_line_3";
        public static final String PARA_ANSWER = "answer";
        public static final String PARA_AVATAR = "avatar";
        public static final String PARA_AVATAR_FEMALE = "avatar_female";
        public static final String PARA_AVATAR_MALE = "avatar_male";
        public static final String PARA_AVATAR_USER = "avatar_user";
        public static final String PARA_AVATAR_USER_NAME = "avatar_user_name";
        public static final String PARA_AVATAR_USER_PATH = "avatar_user_path";
        public static final String PARA_CONTACT_NO = "contactno";
        public static final String PARA_EMAIL = "email";
        public static final String PARA_NAME_FIRST = "name_first";
        public static final String PARA_NAME_LAST = "name_last";
        public static final String PARA_NAME_SECOND = "name_second";
        public static final String PARA_PASSWORD = "password";
        public static final String PARA_PASSWORD_CONFIRM = "password_confirm";
        public static final String PARA_PASSWORD_NEW = "password_new";
        public static final String PARA_EMAIL_CODE = "email_code";
        public static final String PARA_CONTACT_NO_CODE = "contact_no_code";
        public static final String PARA_UID = "uid";
        public static final String PARA_QUESTION = "question";
        public static final String PARA_REMEMBER = "remember";
        public static final String PARA_USERNAME = "username";
        public static final String PARA_USER_TYPE = "user_type";
        public static final String PARA_USER_TYPE_BUYER = "buyer";
        public static final String PARA_USER_TYPE_SELLER = "seller";
        public static final String PARA_MESSAGE_TO_USER_UID = "to_user_uid";
        public static final String PARA_MESSAGE_ITEM_UID = "reference_item_uid";
        public static final String PARA_MESSAGE_SUBJECT = "message_subject";
        public static final String PARA_MESSAGE_TEXT = "message_text";
        public static final String PARA_MESSAGE_ID = "message_id";
        public static final String PARA_VAL_CITY_DEFAULT = "- Select city -";
        public static final String PARA_VAL_SECURITY_QUESTION_DEFAULT = "- Select a question -";
        public static final String PARA_VAL_UPDATE_SECURITY_QUESTION_DEFAULT = "- Unchanged -";
        public static final String REQUEST_TYPE_SIGN_IN = "sign_in";
        public static final String REQUEST_TYPE_SIGN_OUT = "sign_out";
        public static final String REQUEST_TYPE_SIGN_UP = "sign_up";
        public static final String REQUEST_TYPE_SIGN_UP_CHECK_EMAIL = "check_email";
        public static final String REQUEST_TYPE_SIGN_UP_CHECK_PASSWORD_NEW = "check_password_new";
        public static final String REQUEST_TYPE_SIGN_UP_CHECK_USERNAME = "check_username";
        public static final String REQUEST_TYPE_UPDATE_SECURITY_PASSWORD = "update_password";
        public static final String REQUEST_TYPE_UPDATE_SECURITY_QUESTION = "update_security_question";
        public static final String REQUEST_TYPE_UPDATE_SECURITY_USER = "update_security_user";
        public static final String REQUEST_TYPE_UPDATE_USER = "update_user";
        public static final String REQUEST_TYPE_ACTIVATE_USER_EMAIL = "activate_email";
        public static final String REQUEST_TYPE_ACTIVATE_USER_CONTACT_NO = "activate_contact_no";
        public static final String REQUEST_TYPE_MESSAGE_NEW = "message_new";
        public static final String REQUEST_TYPE_MESSAGE_SET_READ = "message_read";
        public static final String AJAX_CHECK_PASSWORD_NEW = Application.PARA_REQUEST_TYPE + ":\"" + REQUEST_TYPE_SIGN_UP_CHECK_PASSWORD_NEW + "\"," + PARA_PASSWORD_NEW;
        public static final String AJAX_CHECK_USERNAME = Application.PARA_REQUEST_TYPE + ":\"" + REQUEST_TYPE_SIGN_UP_CHECK_USERNAME + "\"," + PARA_USERNAME;
        public static final String AJAX_CHECK_EMAIL = Application.PARA_REQUEST_TYPE + ":\"" + REQUEST_TYPE_SIGN_UP_CHECK_EMAIL + "\"," + PARA_EMAIL;
        public static final String SESSION_ATTR_USER = "user";
        public static final String SESSION_ATTR_USER_TEMP = "user_temp";
        public static final String STATUS_SIGN_IN_ERROR = "invalid";
        public static final String STATUS_SIGN_UP_CHECK_EMAIL_VALID = "email_valid";
        public static final String STATUS_SIGN_UP_CHECK_PASSWORD_NEW_VALID = "password_new_valid";
        public static final String STATUS_SIGN_UP_CHECK_USERNAME_VALID = "username_valid";
        public static final String STATUS_MESSAGE_SAVE_SUCCESS = "message_save_success";
        public static final String USER_STATUS_ACTIVE = "Active";
        public static final String USER_STATUS_DELETED = "Deleted";
        public static final String USER_STATUS_INACTIVE = "Inactive";
        public static final String USER_STATUS_SUSPENDED = "Suspended";
        public static final String USER_TYPE_ACCOUNTANT = "Accountant";
        public static final String USER_TYPE_ADMINISTRATOR = "Administrator";
        public static final String USER_TYPE_BUYER = "Buyer";
        public static final String USER_TYPE_BUYER_SELLER = "Buyer-Seller";
        public static final String USER_TYPE_GUEST = "Guest";
        public static final String USER_TYPE_SELLER = "Seller";
        public static final long MAX_UID_AGE = 1000 * 60 * 60 * 24 * 3;// 3 days
        public static final int MAX_COOKIE_AGE = 60 * 60 * 24 * 30 * 3;// 3 months

        private User() {
        }
    }

    public static final class Image {

        public static final String CONTENT_TYPE_JPEG = "image/jpeg";
        public static final String CONTENT_TYPE_SVG = "image/svg+xml";
        public static final String DIR_ITEM_IMAGE = "/images/items/uploads/";
        public static final String DIR_USER_IMAGE = "/images/user/uploads/";
        public static final String DIR_ADMIN_IMAGE = "/images/ui/uploads/";
        public static final String NO_IMAGE = "images/ui/svg/no-image.svg";
        public static final String PARA_IMAGE_NAME = "image";
        public static final String PARA_IMAGE_TYPE = "type";
        public static final String PARA_VAL_TYPE_ITEM_IMAGE = "item_image";
        public static final String PARA_VAL_TYPE_USER_IMAGE = "user_image";
        public static final String PARA_VAL_TYPE_ADMIN_IMAGE = "admin_image";
        public static final String REQUEST_IMAGE_ITEM = "SerImgMng?" + PARA_IMAGE_TYPE + "=" + PARA_VAL_TYPE_ITEM_IMAGE + "&" + PARA_IMAGE_NAME + "=";
        public static final String REQUEST_IMAGE_USER = "SerImgMng?" + PARA_IMAGE_TYPE + "=" + PARA_VAL_TYPE_USER_IMAGE + "&" + PARA_IMAGE_NAME + "=";
        public static final String REQUEST_TYPE_IMG_UPLOAD_ITEM = "item_image_upload";
        public static final String REQUEST_TYPE_IMG_UPLOAD_USER = "user_image_upload";
        public static final String REQUEST_TYPE_IMG_UPLOAD_ADMIN = "admin_image_upload";
        static final int IMG_CACHE_SIZE = 20;
        static final long IMG_CACHE_TIMEOUT = 1000 * 60 * 60 * 24; // 1 day
        static final HashMap<String, ImageManager.ImgCache> IMG_CACHE = new HashMap<>(IMG_CACHE_SIZE);

        private Image() {
        }
    }

    static final class Sec {

        static final String PATH = "sec.ser";

        private Sec() {
        }
    }

}