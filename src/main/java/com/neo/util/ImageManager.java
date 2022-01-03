/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import org.apache.commons.io.FileUtils;

import java.io.File;
import java.io.IOException;
import java.util.Calendar;
import java.util.Iterator;

/**
 * @author neo
 */
class ImageManager {

    String getImage(String imageType, String imageName) {
        String path = null;
        String image = getCachedImage(imageType + imageName);
        if (image != null) {
            System.out.println("Found image in cache " + imageName);
            return image;
        }
        image = "data:image/jpeg;base64,";
        switch (imageType) {
            case AppConst.Image.PARA_VAL_TYPE_USER_IMAGE:
                if (imageName != null
                        && (imageName.equals(AppConst.User.AVATAR_NAME_GENERIC_FEMALE)
                        || imageName.equals(AppConst.User.AVATAR_NAME_GENERIC_MALE)
                        || imageName.equals(AppConst.User.AVATAR_NAME_SELECT_IMAGE))) {
                    path = AppUtil.getRealPath("/images/user/svg/" + imageName + ".svg");
                    image = "data:image/svg+xml;base64,";
                    System.out.println("User image: " + path);
                } else {
                    path = AppUtil.getRealPath(AppConst.Image.DIR_USER_IMAGE + imageName + ".jpg");
                    System.out.println("Custom user image: " + path);
                }
//                    path = getRealPath(AppConst.Image.DIR_USER_IMAGE + image);
                break;
            case AppConst.Image.PARA_VAL_TYPE_ITEM_IMAGE:
                path = AppUtil.getRealPath(AppConst.Image.DIR_ITEM_IMAGE + imageName + ".jpg");
                System.out.println("Item image: " + path);
//                    path = getRealPath(AppConst.Image.DIR_ITEM_IMAGE + image);
                break;
            case AppConst.Image.PARA_VAL_TYPE_ADMIN_IMAGE:
                path = AppUtil.getRealPath(AppConst.Image.DIR_ADMIN_IMAGE + imageName + ".jpg");
                System.out.println("Admin image: " + path);
//                    path = getRealPath(AppConst.Image.DIR_ADMIN_IMAGE + image);
                break;
        }
        System.out.println("Providing Base64 : " + path);
//        System.out.println("Root Path:  " + AppUtil.getRealPath(path));
        try {
            File file;
            if (imageName != null) {
                file = new File(path);
                if (!file.exists() || !file.isFile()) {
                    file = new File(AppUtil.getRealPath("/" + AppConst.Image.NO_IMAGE));
                    image = "data:image/svg+xml;base64,";
                    System.out.println("no image in : " + path);
                }
            } else {
                file = new File(AppUtil.getRealPath("/" + AppConst.Image.NO_IMAGE));
                image = "data:image/svg+xml;base64,";
                System.out.println("no image in : " + path);
            }
            image += AppUtil.getBase64OfBytes(FileUtils.readFileToByteArray(file));
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        cacheImage(imageType + imageName, image);
        System.out.println("Caching image " + imageName);
        return image;
    }

    private String getCachedImage(String key) {
        if (AppConst.Image.IMG_CACHE.containsKey(key)) {
            return AppConst.Image.IMG_CACHE.get(key).getImage();
        }
        return null;
    }

    private void cacheImage(String key, String image) {
        if ((key != null && !key.trim().isEmpty()) && (image != null && !image.trim().isEmpty())) {
            if (AppConst.Image.IMG_CACHE.size() >= AppConst.Image.IMG_CACHE_SIZE) {
                clearLeastAccessedCache();
            }
            clearOldCache();
            AppConst.Image.IMG_CACHE.put(key, new ImgCache(image));
        }
    }

    private void clearLeastAccessedCache() {
        int minAccessCount = Integer.MAX_VALUE;
        String minAccessedCache = null;
        for (String key : AppConst.Image.IMG_CACHE.keySet()) {
            ImgCache cache = AppConst.Image.IMG_CACHE.get(key);
            if (cache.getAccessCount() < minAccessCount) {
                minAccessCount = cache.getAccessCount();
                minAccessedCache = key;
            }
        }
        if (minAccessedCache != null) {
            AppConst.Image.IMG_CACHE.remove(minAccessedCache);
        }
    }

    private void clearOldCache() {
        long currentTime = Calendar.getInstance().getTimeInMillis();
        for (Iterator<String> it = AppConst.Image.IMG_CACHE.keySet().iterator(); it.hasNext(); ) {
            String key = it.next();
            ImgCache cache = AppConst.Image.IMG_CACHE.get(key);
            if (currentTime - cache.getLastAccessedTime() > AppConst.Image.IMG_CACHE_TIMEOUT) {
                it.remove();
            }
        }
    }

    class ImgCache {

        private final String image;
        private int accessCount;
        private long lastAccessedTime;

        ImgCache(String image) {
            this.image = image;
        }

        long getLastAccessedTime() {
            return lastAccessedTime;
        }

        String getImage() {
            accessCount++;
            lastAccessedTime = Calendar.getInstance().getTimeInMillis();
            return image;
        }

        int getAccessCount() {
            return accessCount;
        }
    }

}