/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.item;

import com.neo.beans.Bean;
import com.neo.beans.user.User;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

/**
 *
 * @author neo
 */
public final class Item extends Bean<Item> {

    private int itemId;
    private String name;
    private Category categoryMain;
    private String summary;
    private String description;
    private String location;
    private ItemOption condition;
    private ItemOption deliveryOption;
    private ItemOption returnOption;
    private ItemOption guranteeOption;
    private String unitprice;
    private String quantity;
    private String uid;
    private User seller;
    private User buyer;
    private Image[] images;
    private final ArrayList<Property> properties = new ArrayList<>(7);
    private long uidCreatTime;
    private long createTime;
    private long introducedTime;
    private long lastSoldTime;
    private int availableQty;

    @Override
    public void clone(Item bean) {
        setItemId(bean.getItemId());
        setName(bean.getName());
        setCategoryMain(bean.getCategoryMain());
        setSummary(bean.getSummary());
        setDescription(bean.getDescription());
        setLocation(bean.getLocation());
        setCondition(bean.getCondition());
        setDeliveryOption(bean.getDeliveryOption());
        setReturnOption(bean.getReturnOption());
        setGuranteeOption(bean.getGuranteeOption());
        setUnitprice(bean.getUnitprice());
        setQuantity(bean.getQuantity());
        setUid(bean.getUid());
        setSeller(bean.getSeller());
        setBuyer(bean.getBuyer());
        setImages(bean.getImages());
        setProperties(bean.getProperties());
        setUidCreatTime(bean.getUidCreatTime());
        setCreateTime(bean.getCreateTime());
        setIntroducedTime(bean.getIntroducedTime());
        setAvailableQty(bean.getAvailableQty());
        setId(bean.getId());
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public User getSeller() {
        return seller;
    }

    public void setSeller(User seller) {
        this.seller = seller;
    }

    @Override
    public boolean equals(Object obj) {
        return (obj instanceof Item && obj.hashCode() == hashCode());
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

    public boolean isDescriptionSet() {
        return description != null && !description.trim().isEmpty();
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public float getUnitprice() {
        try {
            return Float.valueOf(unitprice);
        } catch (NullPointerException | NumberFormatException e) {
            System.out.println("Item.getUnitPrice() : " + e);
        }
        return -1;
    }

    public void setUnitprice(String unitprice) {
        this.unitprice = unitprice;
    }

    public void setUnitprice(float unitprice) {
        this.unitprice = String.valueOf(unitprice);
    }

    public String getUnitpriceFormatted() {
        return String.format("%,.2f", getUnitprice());
    }

    public int getQuantity() {
        try {
            return Integer.valueOf(quantity);
        } catch (NullPointerException | NumberFormatException e) {
            System.out.println("Item.getQuantity() : " + e);
        }
        return 0;
    }

    public void setQuantity(int quantity) {
        this.quantity = String.valueOf(quantity);
    }

    public void setQuantity(String quantity) {
        this.quantity = quantity;
    }

    public String getQuantityText() {
        return AppUtil.convertToText(quantity);
    }

    public String getQuantityFormatted() {
        return quantity;
    }

    public String getTotalFormatted() {
        return String.format("%,.2f", getQuantity() * getUnitprice());
    }

    public Property[] getProperties() {
        return properties.toArray(new Property[properties.size()]);
    }

    public void setProperties(Property[] properties) {
        this.properties.clear();
        if (properties != null) {
            this.properties.addAll(Arrays.asList(properties));
            AppUtil.clearNulls(this.properties);
            for (Property property : this.properties) {
                property.setItemId(getItemId());
            }
        }
    }

    public Property addProperty(String property, String value, boolean visible, boolean defaultProp) {
        Property p = new Property(property, value, visible, defaultProp);
        p.setItemId(getItemId());
        int index;
        if ((index = properties.indexOf(p)) != -1) {
            properties.get(index).clone(p);
        } else {
            properties.add(p);
        }
        return p;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public ItemOption getCondition() {
        return condition;
    }

    public void setCondition(ItemOption condition) {
        this.condition = condition;
    }

    public ItemOption getDeliveryOption() {
        return deliveryOption;
    }

    public void setDeliveryOption(ItemOption deliveryOption) {
        this.deliveryOption = deliveryOption;
    }

    public ItemOption getReturnOption() {
        return returnOption;
    }

    public void setReturnOption(ItemOption returnOption) {
        this.returnOption = returnOption;
    }

    public ItemOption getGuranteeOption() {
        return guranteeOption;
    }

    public void setGuranteeOption(ItemOption guranteeOption) {
        this.guranteeOption = guranteeOption;
    }

    public Category getCategorySub() {
        if (categoryMain == null) {
            return null;
        }
        return this.categoryMain.getSubCategory();
    }

    public Category getCategoryMain() {
        return categoryMain;
    }

    public void setCategoryMain(Category categoryMain) {
        this.categoryMain = categoryMain;
    }

    public void setItemCategory(int itemCategoryId, int mainCategoryId, String categoryMain, int subCategoryId,
                                String categorySub) {
        this.categoryMain = new Category(itemCategoryId, mainCategoryId, categoryMain, subCategoryId, categorySub);
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public void setItemId(int itemId) {
        this.itemId = itemId;
    }

    public int getItemId() {
        return itemId;
    }

    public void setUidCreatTime(long uidCreatTime) {
        this.uidCreatTime = uidCreatTime;
    }

    public long getUidCreatTime() {
        return uidCreatTime;
    }

    public void setCreateTime(long createTime) {
        this.createTime = createTime;
    }

    public long getCreateTime() {
        return createTime;
    }

    public String getCreateTimeFormatted() {
        return AppConst.Application.DEFAULT_DATE_FORMAT.format(new Date(createTime));
    }

    public long getUidAge() {
        return Calendar.getInstance().getTimeInMillis() - getUidCreatTime();
    }

    public Image getDefaultImage() {
        Image[] imgs = getImages();
        for (Image image : imgs) {
            if (image != null && image.isDefaultImage()) {
                return image;
            }
        }
        if (imgs.length > 0 && imgs[0] != null) {
            return imgs[0];
        }
        return new Image("", false);
    }

    public Image[] getNormalImages() {
        Image[] imgs = getImages();
        Image[] is = new Image[imgs.length - 1];
        Image defaultImage = getDefaultImage();
        int index = 0;
        for (Image img : imgs) {
            if (img != null && !img.equals(defaultImage)) {
                is[index] = img;
                index++;
            }
        }
        return is;
    }

    public Image[] getImages() {
        if (images == null) {
            return new Image[]{};
        }
        return Arrays.copyOf(images, images.length);
    }

    public void setImages(Image[] images) {
        if (images != null) {
            this.images = Arrays.copyOf(images, images.length);
        } else {
            this.images = null;
        }
    }

    public long getIntroducedTime() {
        return introducedTime;
    }

    public void setIntroducedTime(long introducedTime) {
        this.introducedTime = introducedTime;
    }

    public String getIntroducedTimeFormatted() {
        return AppConst.Application.DEFAULT_DATE_FORMAT.format(new Date(introducedTime));
    }

    public int getAvailableQty() {
        return availableQty;
    }

    public void setAvailableQty(int availableQty) {
        this.availableQty = availableQty;
    }

    public void generateUid() {
        setUid(AppUtil.generateUID(this));
        if (getUid() != null) {
            setUidCreatTime(Calendar.getInstance().getTimeInMillis());
        }
    }

    public boolean isNameSet() {
        return getName() != null && !getName().trim().isEmpty();
    }

    public long getLastSoldTime() {
        return lastSoldTime;
    }

    public void setLastSoldTime(long lastSoldTime) {
        this.lastSoldTime = lastSoldTime;
    }

    public String getLastSoldTimeFormatted() {
        return AppConst.Application.DEFAULT_DATE_FORMAT.format(new Date(lastSoldTime));
    }

    @Override
    public int hashCode() {
        int hash = 5;
        hash = 79 * hash + this.itemId;
        hash = 79 * hash + getId();
        return hash;
    }

    public User getBuyer() {
        return buyer;
    }

    public void setBuyer(User buyer) {
        this.buyer = buyer;
    }
}
