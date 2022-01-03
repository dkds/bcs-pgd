/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import com.neo.beans.item.Category;
import com.neo.beans.item.Item;
import com.neo.beans.item.OptionType;
import com.neo.beans.user.User;
import com.neo.controls.*;
import org.apache.commons.validator.routines.EmailValidator;

import javax.crypto.*;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.bind.DatatypeConverter;
import java.io.*;
import java.lang.reflect.Array;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.*;

/**
 * @author neo
 */
public final class AppUtil {

    private static SecretKey key;
    private static volatile Thread cleaner;
    private static volatile boolean runCleaner;
    private static final NumberConverter NUMBER_CONVERTER = new NumberConverter();
    private static final ImageManager IMAGE_MANAGER = new ImageManager();
    private static int visitorCount;
    private static int itemViewerCount;

    public static String decrypt(byte[] text) throws NoSuchAlgorithmException, NoSuchPaddingException,
            InvalidKeyException, IllegalBlockSizeException, BadPaddingException {

        Cipher AesCipher = Cipher.getInstance("AES");
        byte[] cipherText = text;

        AesCipher.init(Cipher.DECRYPT_MODE, key);
        byte[] bytePlainText = AesCipher.doFinal(cipherText);
        return new String(bytePlainText);
    }

    public static byte[] encrypt(String text) throws NoSuchAlgorithmException, NoSuchPaddingException,
            InvalidKeyException, IllegalBlockSizeException, BadPaddingException {
        if (key == null) {
            key = getKey();
            if (key == null) {
                KeyGenerator KeyGen = KeyGenerator.getInstance("AES");
                KeyGen.init(128);
                key = KeyGen.generateKey();
                saveKey(key);
            }
        }

        Cipher AesCipher = Cipher.getInstance("AES");

        byte[] byteText = text.getBytes();

        AesCipher.init(Cipher.ENCRYPT_MODE, key);
        byte[] byteCipherText = AesCipher.doFinal(byteText);
        return (byteCipherText);
    }

    public static User createUser(HttpServletRequest request, HttpServletResponse response) {
        Cookie cookie = AppUtil.getCookie(request.getCookies(), AppConst.User.COOKIE_NAME);
        User user = null;
        if (cookie != null) {
            user = UserManager.getInstance(request).get(cookie.getValue());
        }
        if (user == null) {
            user = UserManager.getInstance(request).createGuest();
            if (user.getUid() == null || user.getUidAge() > AppConst.User.MAX_UID_AGE) {
                user.setUid(AppUtil.generateUID(user));
                UserManager.getInstance(request).save(user);
            }
            cookie = new Cookie(AppConst.User.COOKIE_NAME, user.getUid());
            cookie.setMaxAge(AppConst.User.MAX_COOKIE_AGE);
            response.addCookie(cookie);
        }
        request.getSession().setAttribute(AppConst.User.SESSION_ATTR_USER, user);
        return user;
    }

    public static TransactionContainer getTransactions(HttpServletRequest request, long timeFrom, long timeTo) {
        return ItemManager.getInstance(request).getTransactions(timeFrom, timeTo);
    }

    public static String generateUID(Object obj) {
        String tot = "" + System.currentTimeMillis() + "" + Math.abs(obj.hashCode());
        if (tot.length() < 25) {
            tot += AppUtil.getRandomNumbers(25 - tot.length());
        }
        return tot;
    }

    public static String trim(String string) {
        if (string == null) {
            return null;
        }
        String str = string.trim();
        while (str.contains("  ")) {
            str = str.replace("  ", " ");
        }
        return str;
    }

    public static Item viewItem(HttpServletRequest request, String uid) {
        if (uid == null) {
            return null;
        }
        Item item = ItemManager.getInstance(request).get(uid);
        return item;
    }

    public static User viewUser(HttpServletRequest request, String uid) {
        if (uid == null) {
            return null;
        }
        User user = UserManager.getInstance(request).get(uid);
        return user;
    }

    public static Cookie getCookie(Cookie[] cookies, String name) {
        if (cookies == null) {
            return null;
        }
        for (Cookie cookie : cookies) {
            if (cookie.getName().equals(name)) {
                return cookie;
            }
        }
        return null;
    }

    public static String getRandomNumbers(int length) {
        StringBuilder sb = new StringBuilder(length);
        Random random = new Random();
        while (sb.length() <= length) {
            int i = random.nextInt();
            if (i > 0) {
                sb.append(i);
            }
        }
        return sb.substring(0, length);
    }

    public static String getRandomString(int length) {
        StringBuilder sb = new StringBuilder(length);
        Random random = new Random(60);
        while (sb.length() != length) {
            byte b = (byte) random.nextInt();
            while (b < 32 || b > 126) {
                b = (byte) random.nextInt();
            }
            sb.append((char) b);
        }
        return sb.toString();
    }

    public static boolean isEmailValid(String email) {
        return !(email == null
                || email.trim().isEmpty()
                || email.trim().equalsIgnoreCase("null")
                || email.trim().length() < 5
                || !AppUtil.isEmailFormatValid(email));
    }

    public static boolean isPasswordValid(String password) {
        return !(password == null
                || password.trim().isEmpty()
                || password.trim().length() < 5
                || password.trim().length() > 15);
    }

    public static boolean isUsernameValid(String username) {
        return !(username == null
                || username.trim().isEmpty()
                || username.trim().equalsIgnoreCase("null")
                || username.trim().length() < 5);
    }

    @SuppressWarnings("unchecked")
    public static <T> T[] toArray(Class<T> type, Collection<T> items) {
        return items.toArray((T[]) Array.newInstance(type, items.size()));
    }

    @SuppressWarnings("unchecked")
    public static <T> T[] getConsts(HttpServletRequest request, ConstType constType) {
        switch (constType) {
            case USER_SECURITY_QUESTION:
                return (T[]) SecurityQuestionManager.getInstance(request).get();
            case CITY:
                return (T[]) LocationManager.getInstance(request).get();
            case ITEM_CATEGORY:
                return (T[]) ItemCategoryManager.getInstance(request).get();
            case ITEM_CONDITION:
                return (T[]) ItemOptionsManager.getInstance(request).get(OptionType.CONDITION);
            case ITEM_DELIVERY_OPTION:
                return (T[]) ItemOptionsManager.getInstance(request).get(OptionType.DELIVERY);
            case ITEM_GUARANTEE_OPTION:
                return (T[]) ItemOptionsManager.getInstance(request).get(OptionType.GUARANTEE);
            case ITEM_RETURN_OPTION:
                return (T[]) ItemOptionsManager.getInstance(request).get(OptionType.RETURN);
            case ITEM_DEFAULT_PROPERTY:
                return (T[]) ItemPropertyManager.getInstance(request).getDefaultProperties();
            case MATERIALS:
                return (T[]) ItemPropertyManager.getInstance(request).getPropertyValues(ConstType.MATERIALS);
            case COLORS:
                return (T[]) ItemPropertyManager.getInstance(request).getPropertyValues(ConstType.COLORS);
            case STYLES:
                return (T[]) ItemPropertyManager.getInstance(request).getPropertyValues(ConstType.STYLES);
            case MESSAGE_SUBJECT_BUYERS:
                return (T[]) MessageManager.getInstance(request).getSubjects(ConstType.MESSAGE_SUBJECT_BUYERS);
            case MESSAGE_SUBJECT_SELLERS:
                return (T[]) MessageManager.getInstance(request).getSubjects(ConstType.MESSAGE_SUBJECT_SELLERS);
            case MESSAGE_SUBJECT_ADMIN:
                return (T[]) MessageManager.getInstance(request).getSubjects(ConstType.MESSAGE_SUBJECT_ADMIN);
            case COMMISIONS:
                return (T[]) ItemManager.getInstance(request).getCommissions();
            default:
                return null;
        }
    }

    public static Category[] getCategoriesForMenu(HttpServletRequest request) {
        HttpSession session = request.getSession();
        Category[] categories = (Category[]) session.getAttribute(AppConst.Application.SESSION_ATTR_CATEGORY_LIST);
        if (categories == null) {
            categories = AppUtil.<Category>getConsts(request, ConstType.ITEM_CATEGORY);
            session.setAttribute(AppConst.Application.SESSION_ATTR_CATEGORY_LIST, categories);
        }
        return categories;
    }

    public static void loadItems(HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute(AppConst.User.SESSION_ATTR_USER);
        session.setAttribute(AppConst.Item.SESSION_ATTR_SEARCH_RESULT,
                ItemManager.getInstance(request).get(new SearchCriteria.Builder(user).build()));
    }

    public static boolean isItemNameValid(Item item) {
        return item.getName() != null
                && !item.getName().trim().isEmpty();
    }

    public static boolean isItemAlreadyAvailable(HttpServletRequest request, Item item) {
        return ItemManager.getInstance(request).get(item.getSeller(), item.getName()) == null;
    }

    public static void clearNulls(ArrayList<? extends Object> list) {
        for (Iterator<? extends Object> iterator = list.iterator(); iterator.hasNext(); ) {
            Object next = iterator.next();
            if (next == null) {
                iterator.remove();
            }
        }
    }

    public static String convertToText(String number) {
        return NUMBER_CONVERTER.convertValue(number);
    }

    public static String generateCode() {
        return getRandomNumbers(6);
    }

    public static void sendMessage(String contactNo, String string) {
        // TODO send SMS
    }

    public static void sendEmail(String email, String string) {
        // TODO send email
    }

    public static void startCleaner() {
        runCleaner = true;
        if (cleaner == null) {
            cleaner = new Thread() {

                @Override
                @SuppressWarnings("SleepWhileInLoop")
                public void run() {
                    System.out.println("Cleaner starting ...");
                    int databaseCleanIntervalCounter = 0;
                    while (runCleaner) {
                        try {
                            if (!runCleaner) {
                                break;
                            }
                            Thread.sleep(AppConst.Application.CLEANER_INTERVAL);
                        } catch (InterruptedException e) {
                            System.out.println("Interrupting cleaner...");
                            runCleaner = false;
                            break;
                        }
                        System.out.println("Cleaning ...");
                        System.gc();
                        databaseCleanIntervalCounter++;
                        if (databaseCleanIntervalCounter == AppConst.Application.CLEANER_DATABASE_ROUNDS) {
                            databaseCleanIntervalCounter = 0;
                        }
                    }
                    runCleaner = false;
                    cleaner = null;
                    System.gc();
                    System.out.println("Cleaner stopping ...");
                }
            };
            cleaner.setName("cleaner");
            cleaner.start();
        }
    }

    public static void stopCleaner() {
        runCleaner = false;
        if (cleaner.isAlive()) {
            cleaner.interrupt();
        }
    }

    public static void clearUsers(HttpServletRequest request) {
        UserManager.getInstance(request).clearUsers();
    }

    public static String getBase64Image(String imageType, String imageName) {
        return IMAGE_MANAGER.getImage(imageType, imageName);
    }

    public static String getBase64OfBytes(byte[] bytes) {
        String string = DatatypeConverter.printBase64Binary(bytes);
        return string;
    }

    public static byte[] getBytesOfBase64(String base64String) {
        String string = base64String;
        if (string.startsWith("data:")) {
            string = string.substring(string.indexOf(',') + 1, string.length());
        }
        return DatatypeConverter.parseBase64Binary(string);
    }

    public static String[] divideWords(String... strings) {
        HashSet<String> list = new HashSet<>(10);
        for (String string : strings) {
            if (string != null && !string.trim().isEmpty()) {
                if (string.contains(" ")) {
                    for (String str : string.split(" ")) {
                        if (str != null && !str.trim().isEmpty() && !list.contains(str.trim().toLowerCase())) {
                            list.add(str.toLowerCase().replaceAll("[^a-z]", ""));
                        }
                    }
                } else if (!list.contains(string.trim().toLowerCase())) {
                    list.add(string.toLowerCase().replaceAll("[^a-z]", ""));
                }
            }
        }
        return list.toArray(new String[list.size()]);
    }

    public static int getVisitorCount() {
        return visitorCount;
    }

    public static void setVisitorCount(int aVisitorCount) {
        visitorCount = aVisitorCount;
    }

    public static int getItemViewerCount() {
        return itemViewerCount;
    }

    public static void setItemViewerCount(int aItemViewerCount) {
        itemViewerCount = aItemViewerCount;
    }

    public static AdminStatistics getStatictics(HttpServletRequest request) {
        AdminStatistics statistics = new AdminStatistics();
        UserManager.getInstance(request).getStatistics(statistics.getUser());
        ItemManager.getInstance(request).getStatistics(statistics.getItem(), statistics.getAccounts());
        return statistics;
    }

    public static AppPropertyContainer getAppProperties(HttpServletRequest request) {
        AppPropertyContainer appProperties = (AppPropertyContainer) request.getServletContext()
                .getAttribute(AppConst.Admin.CONTEXT_ATTR_APP_PROPERTIES);
        if (appProperties == null) {
            appProperties = AppPropertyManager.getInstance(request).getAppProperties();
            request.getServletContext().setAttribute(AppConst.Admin.CONTEXT_ATTR_APP_PROPERTIES, appProperties);
        }
        return appProperties;
    }

    static String getRealPath(String path) {
        return AppConst.Application.REAL_PATH + path;
//        return servletContext.getRealPath(path);
    }

    private static SecretKey getKey() {
        try (FileInputStream fIn = new FileInputStream(AppConst.Sec.PATH)) {
            ObjectInputStream oIn = new ObjectInputStream(fIn);
            return (SecretKey) oIn.readObject();
        } catch (IOException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    private static boolean isEmailFormatValid(String email) {
        return EmailValidator.getInstance(false).isValid(email);
    }

    private static void saveKey(SecretKey key) {
        try (FileOutputStream fOut = new FileOutputStream(AppConst.Sec.PATH)) {
            ObjectOutputStream oOut = new ObjectOutputStream(fOut);
            oOut.writeObject(key);
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }

    private AppUtil() {
    }

    public enum ResponseStatus {

        DEFAULT, ERROR, SUCCESS;
    }

    public enum ConstType {

        USER_SECURITY_QUESTION, CITY, ITEM_CATEGORY,
        ITEM_CONDITION, ITEM_RETURN_OPTION, ITEM_GUARANTEE_OPTION, ITEM_DELIVERY_OPTION, ITEM_DEFAULT_PROPERTY,
        MATERIALS, STYLES, COLORS,
        MESSAGE_SUBJECT_ADMIN, MESSAGE_SUBJECT_SELLERS, MESSAGE_SUBJECT_BUYERS,
        COMMISIONS,
        APP_PROPERTIES;
    }
}