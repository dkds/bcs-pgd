/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls.dispatcher;

import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;

/**
 * @author neo
 */
public final class ImageDispatcher extends Dispatcher {

    private static volatile ImageDispatcher imageDispatcher;

    public static ImageDispatcher getInstance(HttpServletRequest request, HttpServletResponse response) {
        if (imageDispatcher == null) {
            imageDispatcher = new ImageDispatcher();
        }
        imageDispatcher.setRequest(request);
        imageDispatcher.setResponse(response);
        return imageDispatcher;
    }

    private ImageDispatcher() {
    }

    @Override
    public void dispatchGet() {
        provideImage();
    }

    @Override
    public void dispatchPost() {
        uploadImage();
    }

    private void provideImage() {
        try {
            HttpServletResponse response = getResponse();
            String image = getParameter(AppConst.Image.PARA_IMAGE_NAME);
            String type = getParameter(AppConst.Image.PARA_IMAGE_TYPE);
            String path = null;
            switch (type) {
                case AppConst.Image.PARA_VAL_TYPE_USER_IMAGE:
                    path = (AppConst.Image.DIR_USER_IMAGE + image + ".jpg");
//                    path = getRealPath(AppConst.Image.DIR_USER_IMAGE + image);
                    break;
                case AppConst.Image.PARA_VAL_TYPE_ITEM_IMAGE:
                    path = (AppConst.Image.DIR_ITEM_IMAGE + image + ".jpg");
//                    path = getRealPath(AppConst.Image.DIR_ITEM_IMAGE + image);
                    break;
            }
            System.out.println("Providing : " + path);
            System.out.println("Root Path:  " + new File("/").getAbsolutePath());
            if (image != null) {
                File file = new File(path);
                ServletOutputStream out = response.getOutputStream();
                if (file.exists() && file.isFile()) {
                    response.setContentType(AppConst.Image.CONTENT_TYPE_JPEG);
                    BufferedImage bi = ImageIO.read(file);
                    if (bi != null) {
                        ImageIO.write(bi, "jpg", out);
                        System.out.println("Image written successfully");
                    }
                } else {
                    file = new File(getRealPath("/" + AppConst.Image.NO_IMAGE));
                    System.out.println("NO_IMAGE_IMAGE_FOUND :" + file.exists());
                    response.setContentType(AppConst.Image.CONTENT_TYPE_SVG);
                    BufferedImage bi = ImageIO.read(file);
                    if (bi != null) {
                        ImageIO.write(bi, "svg", out);
                        System.out.println("No image in : " + path);
                    }
                }
            }
        } catch (IOException e) {
            System.out.println("Image Provider Error : " + e);
            e.printStackTrace();
        }
    }

    private void uploadImage() {
        try {
            if (ServletFileUpload.isMultipartContent(getRequest())) {
                boolean user = false;
                boolean item = false;
                for (FileItem fileItem : new ServletFileUpload(new DiskFileItemFactory()).parseRequest(getRequest())) {
                    if (fileItem.getFieldName().equals(AppConst.Application.PARA_REQUEST_TYPE)
                            && fileItem.getString().equals(AppConst.Image.REQUEST_TYPE_IMG_UPLOAD_USER)) {
                        user = true;
                    } else if (fileItem.getFieldName().equals(AppConst.Application.PARA_REQUEST_TYPE)
                            && fileItem.getString().equals(AppConst.Image.REQUEST_TYPE_IMG_UPLOAD_ITEM)) {
                        item = true;
                    } else if (fileItem.getFieldName().equals(AppConst.User.PARA_AVATAR_USER_PATH)) {
                        if (user) {
                            write(uploadUserImage(fileItem));
                            return;
                        }
                    }
                }
            } else if (getRequestType() != null && getRequestType().equals(AppConst.Image.REQUEST_TYPE_IMG_UPLOAD_ITEM)) {
                System.out.println("############## Upload request received");
                write(uploadItemImages());
            } else if (getRequestType() != null && getRequestType().equals(AppConst.Image.REQUEST_TYPE_IMG_UPLOAD_ADMIN)) {
                System.out.println("############## Upload request received");
                write(uploadAdminImages());
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private String uploadUserImage(FileItem fileItem) throws Exception {
        String name = System.currentTimeMillis() + "_" + AppUtil.getRandomNumbers(10);
        String path = (AppConst.Application.REAL_PATH + AppConst.Image.DIR_USER_IMAGE + name + ".jpg");
//        String path = getRealPath("/" + AppConst.Image.DIR_USER_IMAGE + name + ".jpg");
        System.out.println(path);
        File file = new File(path);
        file.getParentFile().mkdirs();
        fileItem.write(file);
        return name;
    }

    @SuppressWarnings("unchecked")
    private String uploadItemImages() throws Exception {
        HashMap<String, String> names = new HashMap<>(8);
        JSONArray images = (JSONArray) new JSONParser().parse(getParameter(AppConst.Item.PARA_IMAGES));
        for (Object obj : images) {
            JSONObject image = (JSONObject) obj;
            String name = System.currentTimeMillis() + "_" + AppUtil.getRandomNumbers(10);
            String path = (AppConst.Application.REAL_PATH + AppConst.Image.DIR_ITEM_IMAGE + name + ".jpg");
//            String path = getRealPath("/" + AppConst.Image.DIR_ITEM_IMAGE + name + ".jpg");
            byte[] data = AppUtil.getBytesOfBase64((String) image.get("imageData"));
            File file = new File(path);
            file.getParentFile().mkdirs();
            try (OutputStream stream = new FileOutputStream(file)) {
                stream.write(data);
            }
            names.put((String) image.get("imageId"), name);
        }
        JSONArray array = new JSONArray();
        for (String id : names.keySet()) {
            JSONObject obj = new JSONObject();
            obj.put("imageId", id);
            obj.put("imageName", names.get(id));
            array.add(obj);
        }
        return array.toJSONString();
    }

    @SuppressWarnings("unchecked")
    private String uploadAdminImages() throws Exception {
        HashMap<String, String> names = new HashMap<>(8);
        JSONArray images = (JSONArray) new JSONParser().parse(getParameter(AppConst.Item.PARA_IMAGES));
        for (Object obj : images) {
            JSONObject image = (JSONObject) obj;
            String name = System.currentTimeMillis() + "_" + AppUtil.getRandomNumbers(10);
            String path = (AppConst.Application.REAL_PATH + AppConst.Image.DIR_ADMIN_IMAGE + name + ".jpg");
//            String path = getRealPath("/" + AppConst.Image.DIR_ITEM_IMAGE + name + ".jpg");
            byte[] data = AppUtil.getBytesOfBase64((String) image.get("imageData"));
            File file = new File(path);
            file.getParentFile().mkdirs();
            try (OutputStream stream = new FileOutputStream(file)) {
                stream.write(data);
            }
            names.put((String) image.get("imageId"), name);
        }
        JSONArray array = new JSONArray();
        for (String id : names.keySet()) {
            JSONObject obj = new JSONObject();
            obj.put("imageId", id);
            obj.put("imageName", names.get(id));
            array.add(obj);
        }
        return array.toJSONString();
    }
}