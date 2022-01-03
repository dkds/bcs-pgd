/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls.dispatcher;

import com.neo.beans.item.Category;
import com.neo.beans.item.Container;
import com.neo.beans.item.Image;
import com.neo.beans.item.Item;
import com.neo.beans.item.ItemOption;
import com.neo.beans.item.OptionType;
import com.neo.beans.item.Property;
import com.neo.beans.user.User;
import com.neo.beans.user.User.SearchResult;
import com.neo.controls.ItemManager;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import com.neo.util.SearchCriteria;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Enumeration;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author neo
 */
// TODO review items
public final class ItemDispatcher extends Dispatcher {

    private static volatile ItemDispatcher itemDispatcher;

    public static ItemDispatcher getInstance(HttpServletRequest request, HttpServletResponse response) {
        if (itemDispatcher == null) {
            itemDispatcher = new ItemDispatcher();
        }
        itemDispatcher.setRequest(request);
        itemDispatcher.setResponse(response);
        return itemDispatcher;
    }

    private ItemDispatcher() {
    }

    @Override
    public void dispatchGet() {
        switch (getRequestType()) {
            case AppConst.Item.REQUEST_TYPE_ITEM_LIST:
                listItems();
                break;
            case AppConst.Item.REQUEST_TYPE_SUGGEST_ITEMS:
                suggestItems();
                break;
            default:
                redirectToCurrentLocation();
                break;
        }
    }

    @Override
    public void dispatchPost() {
        switch (getRequestType()) {
            case AppConst.Item.REQUEST_TYPE_ITEM_NEW:
                addNewItem();
                break;
            case AppConst.Item.REQUEST_TYPE_ITEM_UPDATE:
                updateItem();
                break;
            case AppConst.Item.REQUEST_TYPE_ITEM_DRAFT:
                saveDraftItem();
                break;
            case AppConst.Item.REQUEST_TYPE_REMOVE_DRAFT:
                removeDraftItem();
                break;
            case AppConst.Item.REQUEST_TYPE_ADD_TO_CART:
                addItemToCart();
                break;
            case AppConst.Item.REQUEST_TYPE_REMOVE_FROM_CART:
                updateItemFromCart();
                break;
            case AppConst.Item.REQUEST_TYPE_BUY_CART:
                buyCart();
                break;
            default:
                redirectToCurrentLocation();
                break;
        }
    }

    private void addItemToCart() {
        Item item = getItemManager().get(getParameter(AppConst.Item.PARA_UID));
        int quantity = Integer.valueOf(getParameter(AppConst.Item.PARA_QUANTITY));
        item.setQuantity(quantity);
        reloadCurrentUser();
        User user = getCurrentUser();
        getItemManager().save(user, Container.CART, item);
        reloadCurrentUser();
        redirect("product_view.jsp?" + AppConst.Item.PARA_UID + "=" + item.getUid());
    }

    private synchronized void addNewItem() {
        Item item = (Item) getSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_TEMP);
        if (item == null) {
            item = (Item) getSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_DRAFT);
            if (item == null) {
                item = new Item();
            } else {
                removeSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_DRAFT);
            }
        }
        item.setName(AppUtil.trim(getParameter(AppConst.Item.PARA_NAME)));
        item.setSeller(getCurrentUser());
        item.setLocation(getParameter(AppConst.Item.PARA_LOCATION));
        item.setSummary(AppUtil.trim(getParameter(AppConst.Item.PARA_SUMMARY)));
        item.setDescription(getParameter(AppConst.Item.PARA_DESCRIPTION));
        item.setUnitprice(getParameter(AppConst.Item.PARA_UNITPRICE));
        item.setQuantity(getParameter(AppConst.Item.PARA_QUANTITY));
        setCondition(item);
        setDeliveryOption(item);
        setGuaranteeOption(item);
        setReturnOption(item);
        Category category = new Category();
        category.setId(Integer.valueOf(getParameter(AppConst.Item.PARA_CATEGORY)));
        category.setSubCategory(category);
        item.setCategoryMain(category);
        addProperties(item);
        addImages(item);
        if (validateParameters(item, false, null)) {
            if (getItemManager().save(getCurrentUser(), Container.STOCK, item)) {
                reloadCurrentUser();
                removeSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_TEMP);
                redirect("user_profile.jsp");
            } else {
                reloadCurrentUser();
                redirectToCurrentLocation();
            }
        } else {
            setSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_TEMP, item);
            redirect("product_add.jsp");
        }
    }

    private void addImages(Item item) {
        ArrayList<Image> images = new ArrayList<>(8);
        int imgCount = 0;
        int defaultImg = 0;
        String[] defaults = getParameters(AppConst.Item.PARA_IMAGE_DEFAULT);
        String[] imgs = getParameters(AppConst.Item.PARA_IMAGE_NAME);
        if (defaults != null && imgs != null) {
            for (String defaultStatus : defaults) {
                defaultImg++;
                if (defaultStatus != null && defaultStatus.trim().equalsIgnoreCase("on")) {
                    break;
                }
            }
            for (String imageName : imgs) {
                System.out.println("Image : " + imageName);
                if (imageName != null && !imageName.trim().isEmpty()) {
                    imgCount++;
                    images.add(new Image(imageName, (imgCount == defaultImg)));
                }
            }
            item.setImages(images.toArray(new Image[images.size()]));
        }
    }

    private void addProperties(Item item) {
        Property[] defaultProperties = AppUtil.<Property>getConsts(getRequest(), AppUtil.ConstType.ITEM_DEFAULT_PROPERTY);
        System.out.println("Properties : " + defaultProperties.length);
        for (Property property : defaultProperties) {
            String prop_value = getParameter(property.getPid());
            System.out.println("Pid : " + property.getPid() + " - " + prop_value);
            String prop_visible = getParameter("visible_" + property.getPid());
            boolean visible = false;
            if (prop_value != null && !prop_value.trim().isEmpty() && (prop_visible != null && prop_visible.trim().equalsIgnoreCase("on"))) {
                visible = true;
            }
            item.addProperty(property.getProperty(),
                             prop_value,
                             visible,
                             true);
        }
        for (Property property : item.getProperties()) {
            System.out.println("In Item Default Properties - " + property.getProperty() + " : " + property.getValue());
        }
        Enumeration<String> names = getRequest().getParameterNames();
        int customPropId;
        String name;
        while (names.hasMoreElements()) {
            name = names.nextElement();
            if (name.startsWith(AppConst.Item.PARA_CUSTOM_PROPERTY_NAME_PREFIX)) {
                customPropId = Integer.valueOf(name.substring(
                        AppConst.Item.PARA_CUSTOM_PROPERTY_NAME_PREFIX.length(), name.length()));
                boolean visible = false;
                String prop_value = getParameter(AppConst.Item.PARA_CUSTOM_PROPERTY_VALUE_PREFIX + customPropId);
                String prop_visible = getParameter(AppConst.Item.PARA_CUSTOM_PROPERTY_VISIBLE_PREFIX + customPropId);
                if (prop_value != null && !prop_value.trim().isEmpty() && (prop_visible != null && prop_visible.trim().equalsIgnoreCase("on"))) {
                    visible = true;
                }
                item.addProperty(getParameter(AppConst.Item.PARA_CUSTOM_PROPERTY_NAME_PREFIX + customPropId),
                                 getParameter(AppConst.Item.PARA_CUSTOM_PROPERTY_VALUE_PREFIX + customPropId),
                                 visible,
                                 false);
            }
        }
        for (Property property : item.getProperties()) {
            System.out.println("In Item Properties - " + property.getProperty() + " : " + property.getValue());
        }
    }

    private boolean validateParameters(Item checkedItem, boolean edit, Item originalItem) {
        clearResponseMessage();
        if (edit) {
            if (!AppUtil.isItemNameValid(checkedItem)) {
                addResponseMessage(AppConst.Item.PARA_NAME, "Invalid item name", null);
            } else if (!originalItem.getName().equals(checkedItem.getName())
                       && !AppUtil.isItemAlreadyAvailable(getRequest(), checkedItem)) {
                addResponseMessage(AppConst.Item.PARA_NAME, "Item already available",
                                   "Another item with the same name is available in your stock");
            }
            if (checkedItem.getCategoryMain().getId() == 0) {
                addResponseMessage(AppConst.Item.PARA_CATEGORY, "Invalid category", null);
            }
            if (checkedItem.getCondition().getOptionId() == null) {
                addResponseMessage(AppConst.Item.PARA_CONDITION, "Invalid condition", null);
            }
            if (checkedItem.getUnitprice() == 0) {
                addResponseMessage(AppConst.Item.PARA_UNITPRICE, "Invalid unitprice", null);
            }
            if (checkedItem.getQuantity() == 0) {
                addResponseMessage(AppConst.Item.PARA_QUANTITY, "Invalid quantity", null);
            }
            if (checkedItem.getLocation() == null || checkedItem.getLocation().equals(
                    AppConst.Item.PARA_VAL_CITY_DEFAULT)) {
                addResponseMessage(AppConst.Item.PARA_LOCATION, "Invalid location", null);
            }
            System.out.println(
                    "Delivery : " + checkedItem.getDeliveryOption().getOptionId() + " - " + checkedItem.getDeliveryOption().getName());
            System.out.println(
                    "Gurantee : " + checkedItem.getGuranteeOption().getOptionId() + " - " + checkedItem.getGuranteeOption().getName());
            System.out.println("Return : " + checkedItem.getReturnOption().getOptionId() + " - " + checkedItem.getReturnOption().getName());
            if (checkedItem.getDeliveryOption().getOptionId() == null
                || checkedItem.getDeliveryOption().getOptionIdInt() == 0) {
                addResponseMessage(AppConst.Item.PARA_DELIVERY_OPTION, "Invalid delivery option", null);
            }
            if (checkedItem.getGuranteeOption().getOptionId() == null
                || checkedItem.getGuranteeOption().getOptionIdInt() == 0) {
                addResponseMessage(AppConst.Item.PARA_GUARANTEE_OPTION, "Invalid guarentee option", null);
            }
            if (checkedItem.getReturnOption().getOptionId() == null
                || checkedItem.getReturnOption().getOptionIdInt() == 0) {
                addResponseMessage(AppConst.Item.PARA_RETURN_OPTION, "Invalid return option", null);
            }
        } else {
            if (!AppUtil.isItemNameValid(checkedItem)) {
                addResponseMessage(AppConst.Item.PARA_NAME, "Invalid item name", null);
            } else if (!AppUtil.isItemAlreadyAvailable(getRequest(), checkedItem)) {
                addResponseMessage(AppConst.Item.PARA_NAME, "Item already available",
                                   "An item with the same name is available in your stock");
            }
            if (checkedItem.getCategoryMain().getId() == 0) {
                addResponseMessage(AppConst.Item.PARA_CATEGORY, "Invalid category", null);
            }
            if (checkedItem.getCondition().getOptionId() == null) {
                addResponseMessage(AppConst.Item.PARA_CONDITION, "Invalid condition", null);
            }
            if (checkedItem.getUnitprice() == 0) {
                addResponseMessage(AppConst.Item.PARA_UNITPRICE, "Invalid unitprice", null);
            }
            if (checkedItem.getQuantity() == 0) {
                addResponseMessage(AppConst.Item.PARA_QUANTITY, "Invalid quantity", null);
            }
            if (checkedItem.getLocation() == null || checkedItem.getLocation().equals(
                    AppConst.Item.PARA_VAL_CITY_DEFAULT)) {
                addResponseMessage(AppConst.Item.PARA_LOCATION, "Invalid location", null);
            }
            if (checkedItem.getDeliveryOption().getOptionId() == null
                || checkedItem.getDeliveryOption().getOptionIdInt() == 0) {
                addResponseMessage(AppConst.Item.PARA_DELIVERY_OPTION, "Invalid delivery option", null);
            }
            if (checkedItem.getGuranteeOption().getOptionId() == null
                || checkedItem.getGuranteeOption().getOptionIdInt() == 0) {
                addResponseMessage(AppConst.Item.PARA_GUARANTEE_OPTION, "Invalid guarentee option", null);
            }
            if (checkedItem.getReturnOption().getOptionId() == null
                || checkedItem.getReturnOption().getOptionIdInt() == 0) {
                addResponseMessage(AppConst.Item.PARA_RETURN_OPTION, "Invalid return option", null);
            }
        }
        if (!getResponseMessage().isEmpty()) {
            setResponseStatus(AppUtil.ResponseStatus.ERROR);
            return false;
        }
        return true;
    }

    private synchronized void saveDraftItem() {
        try {
            System.out.println("----- Saving draft ------");
            Item item = (Item) getSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_DRAFT);
            if (item == null) {
                item = new Item();
                System.out.println("New Item");
            } else {
                System.out.println("Item found in session Item#" + item.getId());
            }
            item.setName(AppUtil.trim(getParameter(AppConst.Item.PARA_NAME)));
            item.setSeller(getCurrentUser());
            if (getParameter(AppConst.Item.PARA_LOCATION) == null
                || getParameter(AppConst.Item.PARA_LOCATION).equals(AppConst.Item.PARA_VAL_CITY_DEFAULT)) {
                item.setLocation("Colombo");
            } else {
                item.setLocation(getParameter(AppConst.Item.PARA_LOCATION));
            }
            item.setSummary(AppUtil.trim(getParameter(AppConst.Item.PARA_SUMMARY)));
            item.setDescription(getParameter(AppConst.Item.PARA_DESCRIPTION));
            item.setUnitprice(getParameter(AppConst.Item.PARA_UNITPRICE));
            item.setQuantity(getParameter(AppConst.Item.PARA_QUANTITY));
            setCondition(item);
            setDeliveryOption(item);
            setGuaranteeOption(item);
            setReturnOption(item);
            Category category = new Category();
            category.setId(Integer.valueOf(getParameter(AppConst.Item.PARA_CATEGORY)));
            item.setCategoryMain(category);
            addProperties(item);
            getItemManager().save(getCurrentUser(), Container.DRAFT, item);
            setSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_DRAFT, item);
            write(AppConst.Item.STATUS_DRAFT_SAVE_SUCCESS);
        } catch (NumberFormatException e) {
            e.printStackTrace();
            write(AppConst.Item.STATUS_DRAFT_SAVE_ERROR);
        }
    }

    private void listItems() {
        String searchText = getParameter(AppConst.Item.PARA_SEARCH_TEXT);
        String searchCategoryMain = getParameter(AppConst.Item.PARA_SEARCH_MAIN_CATEGORY_ID);
        String searchCategoryId = getParameter(AppConst.Item.PARA_SEARCH_ITEM_CATEGORY_ID);
        String searchPriceRange = getParameter(AppConst.Item.PARA_SEARCH_PRICE_RANGE);
        String[] searchMaterials = getParameters(AppConst.Item.PARA_SEARCH_MATERIALS);
        String[] searchStyles = getParameters(AppConst.Item.PARA_SEARCH_STYLES);
        String[] searchColors = getParameters(AppConst.Item.PARA_SEARCH_COLORS);
//        String[] searchOrders = getParameters(AppConst.Item.PARA_SEARCH_ORDERS);
        System.out.println("SEARCH : " + searchText);
        System.out.println("SEARCH : " + searchPriceRange);
        System.out.println("SEARCH : " + Arrays.toString(searchMaterials));
        SearchCriteria.Builder criteriaBuilder = new SearchCriteria.Builder(getCurrentUser());
        if (isSearchParameterSet(searchText)) {
            criteriaBuilder.setSearchText(searchText);
        }
        try {
            if (isSearchParameterSet(searchCategoryId)) {
                Category category = new Category();
                category.setId(Integer.valueOf(searchCategoryId));
                criteriaBuilder.setCategory(category);
            } else if (isSearchParameterSet(searchCategoryMain)) {
                criteriaBuilder.setCategory(new Category(Integer.valueOf(searchCategoryMain)));
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        try {
            if (isSearchParameterSet(searchPriceRange)) {
                criteriaBuilder.setPriceRange(searchPriceRange);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
        if (searchMaterials != null) {
            for (String searchMaterial : searchMaterials) {
                if (isSearchParameterSet(searchMaterial) && !searchMaterial.equalsIgnoreCase(
                        AppConst.Item.PARA_VAL_SEARCH_PROPERTY_DEFAULT)) {
                    criteriaBuilder.addMaterial(searchMaterial);
                }
            }
        }
        if (searchColors != null) {
            for (String searchColor : searchColors) {
                if (isSearchParameterSet(searchColor) && !searchColor.equalsIgnoreCase(AppConst.Item.PARA_VAL_SEARCH_PROPERTY_DEFAULT)) {
                    criteriaBuilder.addColor(searchColor);
                }
            }
        }
        if (searchStyles != null) {
            for (String searchStyle : searchStyles) {
                if (isSearchParameterSet(searchStyle) && !searchStyle.equalsIgnoreCase(AppConst.Item.PARA_VAL_SEARCH_PROPERTY_DEFAULT)) {
                    criteriaBuilder.addStyle(searchStyle);
                }
            }
        }
        // TODO order the search result
        SearchResult searchResult = getItemManager().get(criteriaBuilder.build());
        setSessionAttr(AppConst.Item.SESSION_ATTR_SEARCH_RESULT, searchResult);
        redirect("product_search.jsp");
    }

    private boolean isSearchParameterSet(String string) {
        return string != null && !string.trim().isEmpty();
    }

    private void setCondition(Item item) {
        ItemOption itemOption = item.getCondition();
        if (itemOption == null) {
            itemOption = new ItemOption(OptionType.CONDITION);
        }
        itemOption.setOptionId(0);
        if (getParameter(AppConst.Item.PARA_CONDITION) != null
            && !getParameter(AppConst.Item.PARA_CONDITION).equals(AppConst.Item.PARA_VAL_ITEM_OPTION_DEFAULT)) {
            itemOption.setOptionId(getParameter(AppConst.Item.PARA_CONDITION));
        } else {
            itemOption.setName(AppConst.Item.PARA_VAL_ITEM_OPTION_UNSELECTED);
        }
        item.setCondition(itemOption);
    }

    private void setDeliveryOption(Item item) {
        ItemOption itemOption = item.getDeliveryOption();
        if (itemOption == null) {
            itemOption = new ItemOption(OptionType.DELIVERY);
        }
        itemOption.setOptionId(0);
        System.out.println("Setting Delivery : " + getParameter(AppConst.Item.PARA_DELIVERY_OPTION));
        if (getParameter(AppConst.Item.PARA_DELIVERY_OPTION) != null
            && !getParameter(AppConst.Item.PARA_DELIVERY_OPTION).equals(AppConst.Item.PARA_VAL_ITEM_OPTION_DEFAULT)) {
            itemOption.setOptionId(getParameter(AppConst.Item.PARA_DELIVERY_OPTION));
        } else {
            itemOption.setName(AppConst.Item.PARA_VAL_ITEM_OPTION_UNSELECTED);
        }
        itemOption.setDescription(AppUtil.trim(getParameter(AppConst.Item.PARA_DELIVERY_DESCRIPTION)));
        item.setDeliveryOption(itemOption);
    }

    private void setGuaranteeOption(Item item) {
        ItemOption itemOption = item.getGuranteeOption();
        if (itemOption == null) {
            itemOption = new ItemOption(OptionType.GUARANTEE);
        }
        itemOption.setOptionId(0);
        if (getParameter(AppConst.Item.PARA_GUARANTEE_OPTION) != null
            && !getParameter(AppConst.Item.PARA_GUARANTEE_OPTION).equals(AppConst.Item.PARA_VAL_ITEM_OPTION_DEFAULT)) {
            itemOption.setOptionId(getParameter(AppConst.Item.PARA_GUARANTEE_OPTION));
        } else {
            itemOption.setName(AppConst.Item.PARA_VAL_ITEM_OPTION_UNSELECTED);
        }
        itemOption.setDescription(AppUtil.trim(getParameter(AppConst.Item.PARA_GUARANTEE_DESCRIPTION)));
        itemOption.setTimeLimit(getParameter(AppConst.Item.PARA_GUARANTEE_TIME_LIMIT));
        item.setGuranteeOption(itemOption);
    }

    private void setReturnOption(Item item) {
        ItemOption itemOption = item.getReturnOption();
        if (itemOption == null) {
            itemOption = new ItemOption(OptionType.RETURN);
        }
        itemOption.setOptionId(0);
        if (getParameter(AppConst.Item.PARA_RETURN_OPTION) != null
            && !getParameter(AppConst.Item.PARA_RETURN_OPTION).equals(AppConst.Item.PARA_VAL_ITEM_OPTION_DEFAULT)) {
            itemOption.setOptionId(getParameter(AppConst.Item.PARA_RETURN_OPTION));
        } else {
            itemOption.setName(AppConst.Item.PARA_VAL_ITEM_OPTION_UNSELECTED);
        }
        itemOption.setDescription(AppUtil.trim(getParameter(AppConst.Item.PARA_RETURN_DESCRIPTION)));
        itemOption.setTimeLimit(getParameter(AppConst.Item.PARA_RETURN_TIME_LIMIT));
        item.setReturnOption(itemOption);
    }

    private void updateItem() {
        Item originalItem = (Item) getSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_UPDATE);
        Item item = new Item();
        item.clone(originalItem);
        item.setName(AppUtil.trim(getParameter(AppConst.Item.PARA_NAME)));
        item.setSeller(getCurrentUser());
        item.setLocation(getParameter(AppConst.Item.PARA_LOCATION));
        item.setSummary(AppUtil.trim(getParameter(AppConst.Item.PARA_SUMMARY)));
        item.setDescription(getParameter(AppConst.Item.PARA_DESCRIPTION));
        item.setUnitprice(getParameter(AppConst.Item.PARA_UNITPRICE));
        item.setQuantity(getParameter(AppConst.Item.PARA_QUANTITY));
        setCondition(item);
        setDeliveryOption(item);
        setGuaranteeOption(item);
        setReturnOption(item);
        Category category = new Category();
        category.setId(Integer.valueOf(getParameter(AppConst.Item.PARA_CATEGORY)));
        item.setCategoryMain(category);
        addProperties(item);
        addImages(item);
        if (validateParameters(item, true, originalItem)) {
            originalItem.clone(item);
            if (getItemManager().save(getCurrentUser(), Container.STOCK, originalItem)) {
                reloadCurrentUser();
                removeSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_TEMP);
                removeSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_UPDATE);
                redirect("user_profile.jsp");
            } else {
                reloadCurrentUser();
                redirectToCurrentLocation();
            }
        } else {
            setSessionAttr(AppConst.Item.SESSION_ATTR_ITEM_TEMP, item);
            redirect("product_add.jsp?uid=" + originalItem.getUid() + "&edit=true");
        }
    }

    @SuppressWarnings("unchecked")
    private void suggestItems() {
        String[] keys = getItemManager().getSuggestKeys(getParameter(AppConst.Item.PARA_SUGGEST_TERM));
        JSONArray jSONArray = new JSONArray();
        jSONArray.addAll(Arrays.asList(keys));
        System.out.println(jSONArray.toJSONString());
        write(jSONArray.toJSONString());
    }

    @SuppressWarnings("unchecked")
    private void removeDraftItem() {
        try {
            getItemManager().delete(getCurrentUser(), Container.DRAFT,
                                    getCurrentUser().getItem(Container.DRAFT, getParameter(AppConst.Item.PARA_UID)));
            reloadCurrentUser();
            Item[] draftItems = getCurrentUser().getItems(Container.DRAFT);
            JSONArray draftList = new JSONArray();
            int draftCount = 1;
            for (Item draftItem : draftItems) {
                String draftName;
                if (draftItem.isNameSet()) {
                    draftName = draftItem.getName();
                } else {
                    draftName = "[Draft " + draftCount + "]";
                }
                JSONObject itemObject = new JSONObject();
                itemObject.put("uid", draftItem.getUid());
                itemObject.put("draftName", draftName);
                itemObject.put("createTime", draftItem.getCreateTimeFormatted());
                draftList.add(itemObject);
                draftCount++;
            }
            write(draftList.toJSONString());
        } catch (Exception e) {
            write(AppConst.Item.STATUS_DRAFT_REMOVE_ERROR);
            e.printStackTrace();
        }
    }

    @SuppressWarnings({"unchecked", "BroadCatchBlock", "TooBroadCatch"})
    private void updateItemFromCart() {
        try {
            int qty = Integer.parseInt(getParameter(AppConst.Item.PARA_QUANTITY));
            String uid = getParameter(AppConst.Item.PARA_UID);
            User user = getCurrentUser();
            Item item = user.getItem(Container.CART, uid);
            reloadCurrentUser();
            user = getCurrentUser();
            System.out.println("Updating cart ::::: " + uid + " - " + qty);
            if (qty == 0) {
                getItemManager().delete(user, Container.CART, item);
            } else {
                qty -= item.getQuantity();
                item.setQuantity(qty);
                getItemManager().save(user, Container.CART, item);
            }
            JSONObject cartData = new JSONObject();
            cartData.put("itemCountText", user.getItemCountText(Container.CART));
            cartData.put("itemCount", user.getItemCount(Container.CART));
            cartData.put("totalQtyText", user.getTotalQtyText(Container.CART));
            cartData.put("totalQty", user.getTotalQty(Container.CART));
            cartData.put("totalValue", user.getTotalValueFormatted(Container.CART));
            cartData.put("availableQty", item.getAvailableQty());
            cartData.put("unitprice", item.getUnitpriceFormatted());
            cartData.put("qty", item.getQuantity());
            cartData.put("itemTotal", String.format("%,.2f", (item.getUnitprice() * item.getQuantity())));
            write(cartData.toJSONString());
            reloadCurrentUser();
        } catch (Exception e) {
            write(AppConst.Item.STATUS_DRAFT_REMOVE_ERROR);
            e.printStackTrace();
        }
    }

    private void buyCart() {
        ItemManager itemManager = getItemManager();
        User buyer = getCurrentUser();
        Item[] items = buyer.getItems(Container.CART);
        for (Item item : items) {
            itemManager.save(buyer, Container.BOUGHT, item);
            itemManager.delete(buyer, Container.CART, item);
            getMessageManager().notifySeller(buyer, item);
        }
        getUserManager().save(buyer);
        redirect("product_search.jsp");
    }
}
