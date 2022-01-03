/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.BeanController;
import com.neo.beans.item.ItemOption;
import com.neo.beans.item.OptionGroup;
import com.neo.beans.item.OptionType;
import com.neo.database.entities.DeliveryOption;
import com.neo.database.entities.GuaranteeOption;
import com.neo.database.entities.ItemCondition;
import com.neo.database.entities.ItemDeliveryOption;
import com.neo.database.entities.ItemGuaranteeOption;
import com.neo.database.entities.ItemReturnOption;
import com.neo.database.entities.ReturnOption;
import com.neo.util.AppConst;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Iterator;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author neo
 */
public class ItemOptionsManager extends BeanController<ItemOption> {

    public static ItemOptionsManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ItemOptionsManager itemOptionsManager = (ItemOptionsManager) session.getAttribute(
                AppConst.Application.SESSION_ATTR_ITEM_OPTIONS_MANAGER);
        if (itemOptionsManager == null) {
            itemOptionsManager = new ItemOptionsManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_ITEM_OPTIONS_MANAGER, itemOptionsManager);
        }
        itemOptionsManager.setRequest(request);
        return itemOptionsManager;
    }

    private ItemOptionsManager(HttpSession session) {
        super(session);
    }

    public OptionGroup[] get(OptionType optionType) {
        switch (optionType) {
            case CONDITION:
                setDatabaseBeanClass(ItemCondition.class);
                break;
            case DELIVERY:
                setDatabaseBeanClass(DeliveryOption.class);
                break;
            case GUARANTEE:
                setDatabaseBeanClass(GuaranteeOption.class);
                break;
            case RETURN:
                setDatabaseBeanClass(ReturnOption.class);
                break;
            default:
                throw new AssertionError();
        }
        setUserBeanClass(ItemOption.class);
        ArrayList<OptionGroup> itemOptionGroups = new ArrayList<>(5);
        for (ItemOption option : get()) {
            if (option != null && option.getName() != null) {
                OptionGroup group;
                if (option.getName().contains("-")) {
                    String groupName = option.getName().split("-")[0].trim();
                    group = getOptionGroup(itemOptionGroups, groupName);
                } else {
                    group = getOptionGroup(itemOptionGroups, "Other");
                }
                group.addOption(option);
            }
        }
        for (Iterator<OptionGroup> it = itemOptionGroups.iterator(); it.hasNext();) {
            OptionGroup itemOptionGroup = it.next();
            if (itemOptionGroup.getOptions().length == 0
                || (itemOptionGroup.getOptions().length == 1 && itemOptionGroup.getOptions()[0] == null)) {
                it.remove();
            }
        }
        return itemOptionGroups.toArray(new OptionGroup[itemOptionGroups.size()]);
    }

    public Serializable getItemOption(ItemOption option) {
        Serializable ser = getDatabaseBean(option);
        return ser;
    }

    public ItemOption getOption(Serializable entity) {
        return getUserBean(entity);
    }

    @Override
    protected ItemOption getUserBean(Serializable databaseBean) {
        if (databaseBean == null) {
            return null;
        }
        ItemOption userBean;
        if (databaseBean instanceof ItemCondition) {
            userBean = new ItemOption(OptionType.CONDITION);
            userBean.setOptionId(((ItemCondition) databaseBean).getItemConditionId());
            userBean.setName(((ItemCondition) databaseBean).getName());
            userBean.setId(((ItemCondition) databaseBean).getItemConditionId());
        } else if (databaseBean instanceof ItemDeliveryOption) {
            userBean = new ItemOption(OptionType.DELIVERY);
            userBean.setOptionId(((ItemDeliveryOption) databaseBean).getDeliveryOption().getDeliveryOptionId());
            userBean.setName(((ItemDeliveryOption) databaseBean).getDeliveryOption().getName());
            userBean.setDescription(((ItemDeliveryOption) databaseBean).getDescription());
            userBean.setId(((ItemDeliveryOption) databaseBean).getItemDeliveryOptionId());
        } else if (databaseBean instanceof DeliveryOption) {
            userBean = new ItemOption(OptionType.DELIVERY);
            userBean.setOptionId(((DeliveryOption) databaseBean).getDeliveryOptionId());
            userBean.setName(((DeliveryOption) databaseBean).getName());
        } else if (databaseBean instanceof ItemGuaranteeOption) {
            userBean = new ItemOption(OptionType.GUARANTEE);
            userBean.setOptionId(((ItemGuaranteeOption) databaseBean).getGuaranteeOption().getGuaranteeOptionId());
            userBean.setName(((ItemGuaranteeOption) databaseBean).getGuaranteeOption().getName());
            userBean.setDescription(((ItemGuaranteeOption) databaseBean).getDescription());
            userBean.setTimeLimit(((ItemGuaranteeOption) databaseBean).getTimeLimit());
            userBean.setId(((ItemGuaranteeOption) databaseBean).getItemGuaranteeOptionId());
        } else if (databaseBean instanceof GuaranteeOption) {
            userBean = new ItemOption(OptionType.GUARANTEE);
            userBean.setOptionId(((GuaranteeOption) databaseBean).getGuaranteeOptionId());
            userBean.setName(((GuaranteeOption) databaseBean).getName());
        } else if (databaseBean instanceof ItemReturnOption) {
            userBean = new ItemOption(OptionType.RETURN);
            userBean.setOptionId(((ItemReturnOption) databaseBean).getReturnOption().getReturnOptionId());
            userBean.setName(((ItemReturnOption) databaseBean).getReturnOption().getName());
            userBean.setDescription(((ItemReturnOption) databaseBean).getDescription());
            userBean.setTimeLimit(((ItemReturnOption) databaseBean).getTimeLimit());
            userBean.setId(((ItemReturnOption) databaseBean).getItemReturnOptionId());
        } else if (databaseBean instanceof ReturnOption) {
            userBean = new ItemOption(OptionType.RETURN);
            userBean.setOptionId(((ReturnOption) databaseBean).getReturnOptionId());
            userBean.setName(((ReturnOption) databaseBean).getName());
        } else {
            userBean = null;
        }
        return userBean;
    }

    @Override
    protected Serializable getDatabaseBean(ItemOption userBean) {
        if (userBean == null) {
            return null;
        }
        Serializable databaseBean = getItemOption(userBean.getOptionType(),
                                                  userBean.getId(),
                                                  userBean.getName());
        switch (userBean.getOptionType()) {
            case CONDITION:
                databaseBean = getItemOption(OptionType.CONDITION,
                                             userBean.getOptionIdInt(),
                                             userBean.getName());
                break;
            case DELIVERY:
                if (databaseBean == null) {
                    databaseBean = new ItemDeliveryOption();
                }
                ((ItemDeliveryOption) databaseBean).setDeliveryOption(
                        (DeliveryOption) getOption(OptionType.DELIVERY,
                                                   userBean.getOptionId(),
                                                   userBean.getName()));
                ((ItemDeliveryOption) databaseBean).setDescription(userBean.getDescription());
                save(databaseBean);
                break;
            case GUARANTEE:
                if (databaseBean == null) {
                    databaseBean = new ItemGuaranteeOption();
                }
                ((ItemGuaranteeOption) databaseBean).setGuaranteeOption(
                        (GuaranteeOption) getOption(OptionType.GUARANTEE,
                                                    userBean.getOptionId(),
                                                    userBean.getName()));
                ((ItemGuaranteeOption) databaseBean).setDescription(userBean.getDescription());
                ((ItemGuaranteeOption) databaseBean).setTimeLimit(userBean.getTimeLimit());
                save(databaseBean);
                break;
            case RETURN:
                if (databaseBean == null) {
                    databaseBean = new ItemReturnOption();
                }
                ((ItemReturnOption) databaseBean).setReturnOption((ReturnOption) getOption(OptionType.RETURN,
                                                                                           userBean.getOptionId(),
                                                                                           userBean.getName()));
                ((ItemReturnOption) databaseBean).setDescription(userBean.getDescription());
                ((ItemReturnOption) databaseBean).setTimeLimit(userBean.getTimeLimit());
                save(databaseBean);
                break;
            default:
                databaseBean = null;
        }

        return databaseBean;
    }

    private Serializable getItemOption(OptionType optionType, int id, String property) {
        Class<? extends Serializable> databaseBeanClass;
        switch (optionType) {
            case CONDITION:
                databaseBeanClass = (ItemCondition.class);
                break;
            case DELIVERY:
                databaseBeanClass = (ItemDeliveryOption.class);
                break;
            case GUARANTEE:
                databaseBeanClass = (ItemGuaranteeOption.class);
                break;
            case RETURN:
                databaseBeanClass = (ItemReturnOption.class);
                break;
            default:
                throw new AssertionError();
        }
        return get(databaseBeanClass, id);
    }

    private Object getOption(OptionType type, String id, String name) {
        Class<? extends Serializable> databaseBeanClass;
        switch (type) {
            case CONDITION:
                databaseBeanClass = (ItemCondition.class);
                break;
            case DELIVERY:
                databaseBeanClass = (DeliveryOption.class);
                break;
            case GUARANTEE:
                databaseBeanClass = (GuaranteeOption.class);
                break;
            case RETURN:
                databaseBeanClass = (ReturnOption.class);
                break;
            default:
                throw new AssertionError();
        }
        if (id == null || id.trim().isEmpty() || id.trim().equals("0")) {
            return get(databaseBeanClass, Restrictions.eq("name", name))[0];
        }
        return get(databaseBeanClass, Integer.valueOf(id));
    }

    private OptionGroup getOptionGroup(ArrayList<OptionGroup> itemOptionGroups, String groupName) {
        for (OptionGroup optionGroup : itemOptionGroups) {
            if (optionGroup.getName().equals(groupName)) {
                return optionGroup;
            }
        }
        itemOptionGroups.add(new OptionGroup(groupName));
        return itemOptionGroups.get(itemOptionGroups.size() - 1);
    }

}