/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.BeanController;
import com.neo.database.entities.Category;
import com.neo.database.entities.ItemCategory;
import com.neo.util.AppConst;
import java.io.Serializable;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.hibernate.transform.Transformers;

/**
 *
 * @author neo
 */
public class ItemCategoryManager extends BeanController<com.neo.beans.item.Category> {

    public static ItemCategoryManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ItemCategoryManager itemCategoryManager = (ItemCategoryManager) session.getAttribute(
                AppConst.Application.SESSION_ATTR_ITEM_CATEGORY_MANAGER);
        if (itemCategoryManager == null) {
            itemCategoryManager = new ItemCategoryManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_ITEM_CATEGORY_MANAGER, itemCategoryManager);
        }
        itemCategoryManager.setRequest(request);
        return itemCategoryManager;
    }

    private ItemCategoryManager(HttpSession session) {
        super(ItemCategory.class, com.neo.beans.item.Category.class, session);
    }

    public ItemCategory getItemCategory(int id) {
        ItemCategory category = (ItemCategory) get(ItemCategory.class, id);
        return category;
    }

    public ItemCategory getItemCategory(String categoryMain, String categorySub) {
        Category catMain = getCategory(categoryMain);
        if (catMain == null) {
            catMain = new Category();
            catMain.setName(categoryMain);
            save(catMain);
        }
        Category catSub = getCategory(categoryMain);
        if (catSub == null) {
            catSub = new Category();
            catSub.setName(categorySub);
            save(catSub);
        }
        ItemCategory category = (ItemCategory) get(ItemCategory.class,
                                                   Restrictions.eq("categoryByMainCategory", catMain), Restrictions.eq(
                                                           "categoryBySubCategory", catSub))[0];
        if (category == null) {
            category = new ItemCategory(catMain, catSub);
            save(category);
        }
        return category;
    }

    public com.neo.beans.item.Category[] get() {
        ItemCategory[] ics = (ItemCategory[]) get(ItemCategory.class,
                                                  createCriteria(ItemCategory.class)
                                                  .addOrder(Order.asc("itemCategoryId"))
                                                  .setProjection(Projections.distinct(
                                                                  Projections.projectionList()
                                                                  .add(Projections.property("categoryByMainCategory"),
                                                                       "categoryByMainCategory")))
                                                  .setResultTransformer(Transformers.aliasToBean(ItemCategory.class)));
        com.neo.beans.item.Category[] categories = new com.neo.beans.item.Category[ics.length];
        for (int i = 0; i < ics.length; i++) {
            if (ics[i] != null) {
                categories[i] = new com.neo.beans.item.Category(ics[i].getCategoryByMainCategory().getCategoryId(),
                                                                ics[i].getCategoryByMainCategory().getName(),
                                                                getSubCategories(ics[i].getCategoryByMainCategory()));
                categories[i].setId(ics[i].getItemCategoryId() == null ? 0 : ics[i].getItemCategoryId());
            }
        }
        return categories;
    }

    @Override
    protected com.neo.beans.item.Category getUserBean(Serializable databaseBean) {
        if (databaseBean == null) {
            return null;
        }
        ItemCategory category = (ItemCategory) databaseBean;
        com.neo.beans.item.Category c = new com.neo.beans.item.Category(category.getCategoryByMainCategory().getName(),
                                                                        category.getCategoryBySubCategory().getName());
        c.setId(category.getItemCategoryId());
        return c;
    }

    @Override
    protected Serializable getDatabaseBean(com.neo.beans.item.Category userBean) {
        if (userBean == null) {
            return null;
        }
        ItemCategory itemCategory = getItemCategory(userBean.getId());
        if (itemCategory == null) {
            itemCategory = getItemCategory(userBean.getName(), userBean.getSubCategory().getName());
            userBean.setId(itemCategory.getItemCategoryId());
        }
        return itemCategory;
    }

    private Category getCategory(String category) {
        return (Category) get(Category.class, Restrictions.eq("name", category))[0];
    }

    private com.neo.beans.item.Category[] getSubCategories(Category mainCategory) {
        Criteria criteria = createCriteria(ItemCategory.class);
        criteria.add(Restrictions.eq("categoryByMainCategory", mainCategory));
        criteria.addOrder(Order.asc("categoryBySubCategory"));
        ItemCategory[] subCategories = (ItemCategory[]) get(ItemCategory.class, criteria);
        com.neo.beans.item.Category[] categories = new com.neo.beans.item.Category[subCategories.length];
        for (int i = 0; i < subCategories.length; i++) {
            if (subCategories[i] != null) {
                categories[i] = new com.neo.beans.item.Category(subCategories[i].getItemCategoryId(),
                                                                subCategories[i].getCategoryBySubCategory().getCategoryId(),
                                                                subCategories[i].getCategoryBySubCategory().getName());
                categories[i].setId(subCategories[i].getItemCategoryId());
            }
        }
        return categories;
    }

}
