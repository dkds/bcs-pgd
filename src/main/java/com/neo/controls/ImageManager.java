/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.item.Image;
import com.neo.database.controls.Connector;
import com.neo.database.entities.*;
import com.neo.util.AppConst;
import org.hibernate.criterion.Restrictions;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;

/**
 * @author neo
 */
final class ImageManager extends Connector {

    public static ImageManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ServletContext context = request.getServletContext();
        ImageManager imageManager = (ImageManager) context.getAttribute(AppConst.Application.SESSION_ATTR_ITEM_MANAGER);
        if (imageManager == null) {
            imageManager = new ImageManager(session);
            context.setAttribute(AppConst.Application.SESSION_ATTR_USER_MANAGER, imageManager);
        }
        imageManager.setRequest(request);
        return imageManager;
    }

    private ImageManager(HttpSession session) {
        super(session);
    }

    public UserImage getUserImage(com.neo.beans.user.User user) {
        UserImage userImage = null;
        if (user.getId() != 0) {
            userImage = ((User) get(User.class, user.getId())).getUserImage();
        }
        if (userImage == null) {
            userImage = new UserImage();
        }
        userImage.setName(user.getAvatarName());
        save(userImage);
        return userImage;
    }

    public Image[] getItemImages(com.neo.beans.item.Item item) {
        if (item.getId() == 0) {
            return null;
        }
        Item itm = ((ContainerItem) get(ContainerItem.class, item.getId())).getItem();
        ItemImage[] itemImages = getItemImages(itm);
        Image[] images = new Image[itemImages.length];
        for (int i = 0; i < itemImages.length; i++) {
            ItemImage image = itemImages[i];
            if (image != null) {
                images[i] = new Image(image.getItemImageId(), image.getName(), image.getDefaultPic());
            }
        }
        return images;
    }

    public void saveItemImages(int id, Image[] images) {
        System.out.println("saveItemImage: " + Arrays.toString(images));
        if (id == 0 || images == null || (images.length == 1 && images[0] == null)) {
            return;
        }
        Item itm = ((ContainerItem) get(ContainerItem.class, id)).getItem();
        for (Image img : images) {
            ItemImage image = getItemImage(itm, img.getName());
            image.setDefaultPic(img.isDefaultImage());
            save(image);
        }
        clearUnusedImages(itm, images);
    }

    private ItemImage getItemImage(Item item, String name) {
        if (item.getItemId() == 0) {
            return null;
        }
        ItemImage itemImage = (ItemImage) get(ItemImage.class, Restrictions.eq("item", item),
                Restrictions.eq("name", name))[0];
        if (itemImage == null) {
            itemImage = new ItemImage(item, name, null, Boolean.FALSE);
            save(itemImage);
        }
        return itemImage;
    }

    private ItemImage[] getItemImages(Item item) {
        if (item.getItemId() == 0) {
            return null;
        }
        Serializable[] ses = get(ItemImage.class, Restrictions.eq("item", item));
        ItemImage[] itemImages = new ItemImage[ses.length];
        for (int i = 0; i < ses.length; i++) {
            itemImages[i] = (ItemImage) ses[i];
        }
        return itemImages;
    }

    private void clearUnusedImages(Item item, Image[] currentImages) {
        ArrayList<ItemImage> images = new ArrayList<>(8);
        ItemImage[] itemImages = getItemImages(item);
        for (ItemImage itemImage : itemImages) {
            boolean used = false;
            for (Image currentImage : currentImages) {
                if (itemImage.getName().equals(currentImage.getName())) {
                    used = true;
                    break;
                }
            }
            if (!used) {
                images.add(itemImage);
            }
        }
        for (ItemImage image : images) {
            if (image != null) {
                addToDelete(image);
            }
        }
        delete();
    }
}