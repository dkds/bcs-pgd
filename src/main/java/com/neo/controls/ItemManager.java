/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.BeanController;
import com.neo.beans.acc.Transaction;
import com.neo.beans.item.Image;
import com.neo.beans.item.Property;
import com.neo.beans.user.User.SearchResult;
import com.neo.database.entities.Commission;
import com.neo.database.entities.Container;
import com.neo.database.entities.ContainerItem;
import com.neo.database.entities.ContainerType;
import com.neo.database.entities.Item;
import com.neo.database.entities.ItemCondition;
import com.neo.database.entities.ItemDeliveryOption;
import com.neo.database.entities.ItemGuaranteeOption;
import com.neo.database.entities.ItemImage;
import com.neo.database.entities.ItemProperty;
import com.neo.database.entities.ItemReturnOption;
import com.neo.database.entities.ItemSearchProps;
import com.neo.database.entities.Message;
import com.neo.database.entities.Sale;
import com.neo.database.entities.User;
import com.neo.util.AdminStatistics;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import com.neo.util.SearchCriteria;
import com.neo.util.TransactionContainer;
import java.io.Serializable;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author neo
 */
public final class ItemManager extends BeanController<com.neo.beans.item.Item> {

    public static ItemManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        ItemManager itemManager = (ItemManager) session.getAttribute(AppConst.Application.SESSION_ATTR_ITEM_MANAGER);
        if (itemManager == null) {
            itemManager = new ItemManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_ITEM_MANAGER, itemManager);
        }
        itemManager.setRequest(request);
        return itemManager;
    }

    public static void createNewInstance(HttpSession session) {
        ItemManager itemManager = (ItemManager) session.getAttribute(AppConst.Application.SESSION_ATTR_ITEM_MANAGER);
        if (itemManager == null) {
            itemManager = new ItemManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_ITEM_MANAGER, itemManager);
        }
    }

    private Container container;

    private ItemManager(HttpSession session) {
        super(ContainerItem.class, com.neo.beans.item.Item.class, session);
    }

    @Override
    public Serializable getDatabaseBean(com.neo.beans.item.Item userBean) {
        if (userBean == null) {
            return null;
        }
        boolean newContainerItem = false;
        ContainerItem containerItem;
        Item item = (Item) get(Item.class, userBean.getItemId());
        if (container != null) {
            containerItem = getContainerItem(container, userBean.getItemId());
            if (container.getContainerType().getName().equals(com.neo.beans.item.Container.DRAFT.toString())) {
                if (item == null) {
                    item = new Item();
                }
                if (containerItem == null) {
                    containerItem = new ContainerItem(container, item);
                    newContainerItem = true;
                }
                if (containerItem.getQuantity() == null) {
                    containerItem.setQuantity(0);
                }
                containerItem.setQuantity(userBean.getQuantity());
                containerItem.setUnitPrice(BigDecimal.valueOf(userBean.getUnitprice()));
            } else if (container.getContainerType().getName().equals(com.neo.beans.item.Container.STOCK.toString())) {
                if (item == null) {
                    item = new Item();
                }
                if (containerItem == null) {
                    User user = container.getUser();
                    ContainerType containerType = getContainerType(com.neo.beans.item.Container.DRAFT.toString());
                    container = getContainer(user, containerType);
                    containerItem = getContainerItem(container, userBean.getItemId());
                    if (containerItem == null) {
                        containerItem = new ContainerItem(container, item);
                        newContainerItem = true;
                    }
                    containerType = getContainerType(com.neo.beans.item.Container.STOCK.toString());
                    container = getContainer(user, containerType);
                    containerItem.setContainer(container);
                }
                if (containerItem.getQuantity() == null) {
                    containerItem.setQuantity(0);
                }
                containerItem.setQuantity(userBean.getQuantity());
                containerItem.setUnitPrice(BigDecimal.valueOf(userBean.getUnitprice()));
            } else if (container.getContainerType().getName().equals(com.neo.beans.item.Container.CART.toString())) {
                if (containerItem == null || !containerItem.getContainer().getContainerType().getName().equals(
                        container.getContainerType().getName())) {
                    containerItem = new ContainerItem(container, item);
                    newContainerItem = true;
                }
                if (containerItem.getQuantity() == null) {
                    containerItem.setQuantity(0);
                }
                containerItem.setQuantity(containerItem.getQuantity() + userBean.getQuantity());
                containerItem.setUnitPrice(BigDecimal.valueOf(userBean.getUnitprice()));
            } else if (container.getContainerType().getName().equals(com.neo.beans.item.Container.WISHLIST.toString())) {
                if (containerItem == null || !containerItem.getContainer().getContainerType().getName().equals(
                        container.getContainerType().getName())) {
                    containerItem = new ContainerItem(container, item);
                    newContainerItem = true;
                }
                if (containerItem.getQuantity() == null) {
                    containerItem.setQuantity(0);
                }
                containerItem.setQuantity(containerItem.getQuantity() + userBean.getQuantity());
                containerItem.setUnitPrice(BigDecimal.valueOf(userBean.getUnitprice()));
            } else if (container.getContainerType().getName().equals(com.neo.beans.item.Container.BOUGHT.toString())) {
                containerItem = new ContainerItem(container, item);
                newContainerItem = true;
                containerItem.setQuantity(userBean.getQuantity());
                containerItem.setUnitPrice(BigDecimal.valueOf(userBean.getUnitprice()));
            } else if (container.getContainerType().getName().equals(com.neo.beans.item.Container.SOLD.toString())) {
                containerItem = new ContainerItem(container, item);
                newContainerItem = true;
                containerItem.setQuantity(userBean.getQuantity());
                containerItem.setUnitPrice(BigDecimal.valueOf(userBean.getUnitprice()));
            }
        } else {
            containerItem = (ContainerItem) get(userBean.getId());
        }
        if (container == null || (container.getContainerType().getName().equals(
                                  com.neo.beans.item.Container.DRAFT.toString())
                                  || container.getContainerType().getName().equals(
                                  com.neo.beans.item.Container.STOCK.toString()))) {
            item.setPrice(BigDecimal.valueOf(userBean.getUnitprice()));
            item.setName(userBean.getName());
            item.setSummary(userBean.getSummary());
            item.setDescription(userBean.getDescription());
            item.setItemCondition(
                    (ItemCondition) ItemOptionsManager.getInstance(getRequest()).getItemOption(
                            userBean.getCondition()));
            item.setItemDeliveryOption(
                    (ItemDeliveryOption) ItemOptionsManager.getInstance(getRequest()).getItemOption(
                            userBean.getDeliveryOption()));
            item.setItemGuaranteeOption(
                    (ItemGuaranteeOption) ItemOptionsManager.getInstance(getRequest()).getItemOption(
                            userBean.getGuranteeOption()));
            item.setItemReturnOption(
                    (ItemReturnOption) ItemOptionsManager.getInstance(getRequest()).getItemOption(
                            userBean.getReturnOption()));
            item.setItemCategory(ItemCategoryManager.getInstance(getRequest()).getItemCategory(
                    userBean.getCategoryMain().getId()));
            item.setCity(LocationManager.getInstance(getRequest()).getItemCity(userBean.getLocation()));
            item.setUid(userBean.getUid());
            item.setUidCreateTime(userBean.getUidCreatTime());
            save(item);
        }
        if (newContainerItem) {
            containerItem.setCreateTime(Calendar.getInstance().getTimeInMillis());
        }
        return containerItem;
    }

    @Override
    public com.neo.beans.item.Item getUserBean(Serializable databaseBean) {
        ContainerItem containerItem = (ContainerItem) databaseBean;
        if (containerItem == null) {
            return null;
        }
        Item item = containerItem.getItem();
        com.neo.beans.item.Item itm = new com.neo.beans.item.Item();
        itm.setId(containerItem.getContainerItemId());
        itm.setItemId(item.getItemId());
        itm.setName(item.getName());
        itm.setSummary(item.getSummary());
        itm.setDescription(item.getDescription());
        itm.setQuantity(containerItem.getQuantity());
        itm.setUnitprice(item.getPrice().floatValue());
        itm.setCondition(ItemOptionsManager.getInstance(getRequest()).getUserBean(item.getItemCondition()));
        itm.setDeliveryOption(ItemOptionsManager.getInstance(getRequest()).getUserBean(
                item.getItemDeliveryOption()));
        itm.setGuranteeOption(ItemOptionsManager.getInstance(getRequest()).getUserBean(
                item.getItemGuaranteeOption()));
        itm.setReturnOption(ItemOptionsManager.getInstance(getRequest()).getUserBean(
                item.getItemReturnOption()));
        itm.setItemCategory(item.getItemCategory().getItemCategoryId(),
                            item.getItemCategory().getCategoryByMainCategory().getCategoryId(),
                            item.getItemCategory().getCategoryByMainCategory().getName(),
                            item.getItemCategory().getCategoryBySubCategory().getCategoryId(),
                            item.getItemCategory().getCategoryBySubCategory().getName());
        itm.setLocation(item.getCity().getName());
        itm.setCreateTime(containerItem.getCreateTime() == null ? 0 : containerItem.getCreateTime());
        itm.setUidCreatTime(item.getUidCreateTime() == null ? 0 : item.getUidCreateTime());
        itm.setUid(item.getUid());
        com.neo.beans.user.User seller = getUser(com.neo.beans.item.Container.STOCK, item);
        if (seller != null) {
            itm.setSeller(seller);
            itm.setIntroducedTime(getCreatedTime(item, com.neo.beans.item.Container.STOCK, seller.getId()));
            itm.setLastSoldTime(getCreatedTime(item, com.neo.beans.item.Container.SOLD, seller.getId()));
        }
        itm.setAvailableQty(getQuantity(item, com.neo.beans.item.Container.STOCK));
        itm.setProperties(ItemPropertyManager.getInstance(getRequest()).get(itm));
        itm.setImages(ImageManager.getInstance(getRequest()).getItemImages(itm));
        if (itm.getUid() == null || itm.getUidAge() > AppConst.Item.MAX_UID_AGE) {
            itm.generateUid();
            save(itm);
        }
        return itm;
    }

    public SearchResult get(SearchCriteria criteria) {
        Criteria criteriaContainerItem = createCriteria(ContainerItem.class);
        criteriaContainerItem
                .createCriteria("container")
                .add(Restrictions.eq("containerType",
                                     get(ContainerType.class,
                                         Restrictions.eq("name", AppConst.Item.CONTAINER_TYPE_STOCK))[0]));
        Criteria criteriaItem = criteriaContainerItem.createCriteria("item");
        if (criteria.isSearchTextSet()) {
            if (criteria.isSearchOnlyName()) {
                criteriaItem.add(Restrictions.like("name", criteria.getSearchText(), MatchMode.ANYWHERE));
            } else {
                criteriaItem.add(Restrictions.or(
                        Restrictions.like("name", criteria.getSearchText(), MatchMode.ANYWHERE),
                        Restrictions.like("summary", criteria.getSearchText(), MatchMode.ANYWHERE),
                        Restrictions.like("description", criteria.getSearchText(), MatchMode.ANYWHERE)));
            }
        }
        if (criteria.isCategoriesSet()) {
            if (criteria.getCategory().getId() == 0) {
                criteriaItem
                        .createAlias("itemCategory", "itemCategory")
                        .createAlias("itemCategory.categoryByMainCategory", "mainCategory").add(
                                Restrictions.eq("mainCategory.categoryId", criteria.getCategory().getCategoryId()));
            } else {
                criteriaItem.add(Restrictions.eq("itemCategory",
                                                 ItemCategoryManager.getInstance(getRequest())
                                                 .getItemCategory(criteria.getCategory().getId())));
            }
        }
        if (criteria.isPriceSet()) {
            criteriaItem.add(Restrictions.between("price",
                                                  BigDecimal.valueOf(criteria.getMinPrice()),
                                                  BigDecimal.valueOf(criteria.getMaxPrice())));
        }
        if (criteria.isColorsSet() || criteria.isMaterialsSet() || criteria.isStylesSet()) {
            criteriaItem.createAlias("itemProperties", "itemProperty");
            criteriaItem.createAlias("itemProperty.property", "property");
        }
        ArrayList<Criterion> restrictions;
        if (criteria.isColorsSet()) {
            restrictions = new ArrayList<>(criteria.getColors().length);
            for (String color : criteria.getColors()) {
                restrictions.add(Restrictions.and(Restrictions.like("property.name", "color", MatchMode.ANYWHERE),
                                                  Restrictions.like("itemProperty.value", color, MatchMode.ANYWHERE)));
            }
            criteriaItem.add(Restrictions.or(restrictions.toArray(new Criterion[restrictions.size()])));
            restrictions.clear();
        }
        if (criteria.isMaterialsSet()) {
            restrictions = new ArrayList<>(criteria.getMaterials().length);
            for (String material : criteria.getMaterials()) {
                restrictions.add(
                        Restrictions.and(Restrictions.like("property.name", "material", MatchMode.ANYWHERE),
                                         Restrictions.like("itemProperty.value", material, MatchMode.ANYWHERE)));
            }
            criteriaItem.add(Restrictions.or(restrictions.toArray(new Criterion[restrictions.size()])));
            restrictions.clear();
        }
        if (criteria.isStylesSet()) {
            restrictions = new ArrayList<>(criteria.getStyles().length);
            for (String style : criteria.getStyles()) {
                restrictions.add(Restrictions.and(Restrictions.like("property.name", "style", MatchMode.ANYWHERE),
                                                  Restrictions.like("itemProperty.value", style, MatchMode.ANYWHERE)));
            }
            criteriaItem.add(Restrictions.or(restrictions.toArray(new Criterion[restrictions.size()])));
            restrictions.clear();
        }
        if (criteria.isOrdersSet()) {
            for (SearchCriteria.Order order : criteria.getOrders()) {
                switch (order) {
                    case NAME_ASC:
                        criteriaItem.addOrder(Order.asc("name"));
                        break;
                    case NAME_DESC:
                        criteriaItem.addOrder(Order.desc("name"));
                        break;
                    case PRICE_ASC:
                        criteriaContainerItem.addOrder(Order.asc("price"));
                        break;
                    case PRICE_DESC:
                        criteriaContainerItem.addOrder(Order.desc("price"));
                        break;
                    case AGE_ASC:
                        criteriaContainerItem.addOrder(Order.asc("createTime"));
                        break;
                    case AGE_DESC:
                        criteriaContainerItem.addOrder(Order.desc("createTime"));
                        break;
                }
            }
        }
        criteriaContainerItem.setMaxResults(AppConst.Item.MAX_HIBERNATE_RESULTS_COUNT);
        return criteria.getCurrentUser().getSearchResult(get(criteriaContainerItem), criteria);
    }

    public com.neo.beans.item.Item get(com.neo.beans.user.User seller, String name) {
        Criteria criteriaContainerItem = createCriteria(ContainerItem.class);
        criteriaContainerItem.createCriteria("item").add(Restrictions.eq("name", name));
        criteriaContainerItem.createCriteria("container")
                .createAlias("user", "user")
                .createAlias("containerType", "containerType")
                .add(Restrictions.eq("containerType.name", AppConst.Item.CONTAINER_TYPE_STOCK))
                .add(Restrictions.eq("user.userId", seller.getId()));
        return get(criteriaContainerItem)[0];
    }

    public com.neo.beans.item.Item get(String uid) {
        Criteria criteriaContainerItem = createCriteria(ContainerItem.class);
        criteriaContainerItem.createCriteria("container")
                .createAlias("containerType", "containerType")
                .add(Restrictions.or(Restrictions.eq("containerType.name", com.neo.beans.item.Container.DRAFT.toString()),
                                     Restrictions.eq("containerType.name", com.neo.beans.item.Container.STOCK.toString())));
        criteriaContainerItem.createAlias("item", "item").add(Restrictions.eq("item.uid", uid));
        return get(criteriaContainerItem)[0];
    }

    public com.neo.beans.item.Item[] get(com.neo.beans.user.User user, com.neo.beans.item.Container container) {
        Criteria criteriaContainerItem = createCriteria(ContainerItem.class);
        criteriaContainerItem.createCriteria("container")
                .createAlias("containerType", "containerType")
                .createAlias("user", "user")
                .add(Restrictions.eq("user.userId", user.getId()))
                .add(Restrictions.eq("containerType.name", container.toString()));
        criteriaContainerItem.addOrder(Order.desc("createTime"));
        if (container == com.neo.beans.item.Container.SOLD) {
            Serializable[] ses = get(ContainerItem.class, criteriaContainerItem);
            com.neo.beans.item.Item[] items = new com.neo.beans.item.Item[ses.length];
            for (int i = 0; i < ses.length; i++) {
                if (ses[i] != null) {
                    ContainerItem containerItem = (ContainerItem) ses[i];
                    com.neo.beans.item.Item item = getUserBean(containerItem);
                    item.setBuyer(getBuyer(containerItem));
                    items[i] = item;
                }
            }
            return items;
        }
        return get(criteriaContainerItem);
    }

    public boolean save(com.neo.beans.user.User userToAdd,
                        com.neo.beans.item.Container itemContainer,
                        com.neo.beans.item.Item item) {
        User user = (User) UserManager.getInstance(getRequest()).get(userToAdd.getId());
        ContainerType containerType = getContainerType(itemContainer.toString());
        container = getContainer(user, containerType);
        int boughtQty = item.getQuantity();
        addToContainer(container, userToAdd, item);
        if (itemContainer.equals(com.neo.beans.item.Container.BOUGHT)) {
            System.out.println("Bought qty ::: " + boughtQty);
            containerType = getContainerType(com.neo.beans.item.Container.SOLD.toString());
            User seller = (User) UserManager.getInstance(getRequest()).get(item.getSeller().getId());
            container = getContainer(seller, containerType);
            item.setQuantity(boughtQty);
            addToContainer(container, item.getSeller(), item);
            System.out.println("After adding to SOLD qty ::: " + item.getQuantity());
            containerType = getContainerType(com.neo.beans.item.Container.STOCK.toString());
            container = getContainer(seller, containerType);
            item.setQuantity(item.getAvailableQty() - boughtQty);
            addToContainer(container, item.getSeller(), item);
            System.out.println("After adding to STOCK qty ::: " + item.getQuantity());
        }
        return true;
    }

    public String[] getSuggestKeys(String term) {
        Criteria searchPropsCriteria = createCriteria(ItemSearchProps.class);
        searchPropsCriteria.add(Restrictions.or(Restrictions.like("name", term, MatchMode.ANYWHERE),
                                                Restrictions.like("summary", term, MatchMode.ANYWHERE)));
        @SuppressWarnings("unchecked")
        List<ItemSearchProps> list = searchPropsCriteria.list();
        HashSet<String> strings = new HashSet<>(20);
        for (ItemSearchProps searchProps : list) {
            strings.addAll(Arrays.asList(AppUtil.divideWords(searchProps.getName(), searchProps.getSummary())));
        }
        HashSet<String> suggestions = new HashSet<>(5);
        for (String string : strings) {
            if (string.startsWith(term.toLowerCase())) {
                suggestions.add(string);
            }
        }
        String[] test = AppUtil.<String>toArray(String.class, suggestions);
        return test;
    }

    public void delete(com.neo.beans.user.User user, com.neo.beans.item.Container container, com.neo.beans.item.Item item) {
        try {
            if (item != null) {
                Container cont = getContainer((User) UserManager.getInstance(getRequest()).get(user.getId()),
                                              getContainerType(container.toString()));
                ContainerItem containerItem = getContainerItem(cont, item.getItemId());
                switch (container) {
                    case DRAFT:
                    case STOCK:
                        Item itm = containerItem.getItem();
                        ItemDeliveryOption itemDeliveryOption = itm.getItemDeliveryOption();
                        ItemGuaranteeOption itemGuaranteeOption = itm.getItemGuaranteeOption();
                        ItemReturnOption itemReturnOption = itm.getItemReturnOption();
                        Set<ItemProperty> itemProperties = containerItem.getItem().getItemProperties();
                        Set<ItemImage> itemImages = containerItem.getItem().getItemImages();
                        Set<Message> messages = containerItem.getMessages();
                        delete((Serializable[]) messages.toArray(new Message[messages.size()]));
                        delete(containerItem);
                        addToDelete((Serializable[]) itemProperties.toArray(new ItemProperty[itemProperties.size()]));
                        addToDelete((Serializable[]) itemImages.toArray(new ItemImage[itemImages.size()]));
                        delete();
                        delete(itm);
                        delete(itemDeliveryOption, itemGuaranteeOption, itemReturnOption);
                        break;
                    case CART:
                    case BOUGHT:
                    case SOLD:
                    case WISHLIST:
                        delete(containerItem);
                        break;
                    default:
                        throw new AssertionError();
                }
            }
        } catch (Exception e) {
            throw e;
        }
    }

    @SuppressWarnings("unchecked")
    public TransactionContainer getTransactions(long timeFrom, long timeTo) {
        Criteria saleCriteria = createCriteria(Sale.class);
        if (timeFrom != 0 && timeTo != 0) {
            saleCriteria.add(Restrictions.between("sale_time", timeFrom, timeTo));
        } else if (timeTo != 0) {
            saleCriteria.add(Restrictions.lt("sale_time", timeTo));
        } else if (timeFrom != 0) {
            saleCriteria.add(Restrictions.gt("sale_time", timeFrom));
        }
        Serializable[] ses = get(Sale.class, saleCriteria);
        TransactionContainer tc = new TransactionContainer();
        int count = 0;
        for (Serializable se : ses) {
            if (se != null) {
                Sale sale = (Sale) se;
                com.neo.beans.user.User buyer = UserManager.getInstance(getRequest()).get(sale.getBuyer().getUid());
                com.neo.beans.item.Item item = get(sale.getItem().getUid());
                count++;
                item.setQuantity(sale.getQuantity());
                item.setUnitprice(sale.getUnitPrice().floatValue());
                Transaction transaction = new Transaction(buyer, item, sale.getSoldTime(), sale.getCommission().floatValue(), count);
                tc.addTransaction(transaction);
            }
        }
        return tc;
    }

    public com.neo.beans.acc.Commission[] getCommissions() {
        Serializable[] ses = get(Commission.class, createCriteria(Commission.class));
        com.neo.beans.acc.Commission[] cs = new com.neo.beans.acc.Commission[ses.length];
        for (int i = 0; i < ses.length; i++) {
            Commission com = (Commission) ses[i];
            if (com != null) {
                com.neo.beans.acc.Commission c = new com.neo.beans.acc.Commission();
                c.setLowerLimit(com.getPriceLimitFrom().floatValue());
                c.setUpperLimit(com.getPriceLimitTo().floatValue());
                c.setPersentage(com.getPersentage().floatValue());
                cs[i] = c;
            }
        }
        return cs;
    }

    public void getStatistics(AdminStatistics.Item item, AdminStatistics.Accounts accounts) {
        int itemCountReg = 0;
        int itemCountStock = 0;
        int itemCountCart = 0;
        int saleCount = 0;
        float totalValueStock = 0;
        float totalValueSales = 0;
        float totalIncomeCommissions = 0;
        float totalIncomePromos = 0;
        Criteria itemCriteria = createCriteria(ContainerItem.class);
        itemCriteria.createAlias("container", "container").createAlias("container.containerType", "containerType")
                .add(Restrictions.eq("containerType.name", com.neo.beans.item.Container.STOCK.toString()));
        Serializable[] ses = get(ContainerItem.class, itemCriteria);
        for (Serializable se : ses) {
            if (se != null) {
                ContainerItem containerItem = (ContainerItem) se;
                itemCountReg++;
                itemCountStock += (containerItem.getQuantity());
                totalValueStock += (containerItem.getQuantity() * containerItem.getUnitPrice().floatValue());
            }
        }
        itemCriteria = createCriteria(ContainerItem.class);
        itemCriteria.createAlias("container", "container").createAlias("container.containerType", "containerType")
                .add(Restrictions.eq("containerType.name", com.neo.beans.item.Container.CART.toString()));
        ses = get(ContainerItem.class, itemCriteria);
        for (Serializable se : ses) {
            if (se != null) {
                ContainerItem containerItem = (ContainerItem) se;
                itemCountCart += (containerItem.getQuantity());
            }
        }
        Criteria saleCriteria = createCriteria(Sale.class);
        ses = get(Sale.class, saleCriteria);
        for (Serializable se : ses) {
            if (se != null) {
                Sale sale = (Sale) se;
                saleCount += (sale.getQuantity());
                totalValueSales += (sale.getQuantity() * sale.getUnitPrice().floatValue());
                totalIncomeCommissions += ((sale.getUnitPrice().floatValue() * (sale.getCommission().floatValue() / 100)) * sale.getQuantity());
            }
        }
        item.setItemCountRegistered(String.format("%,d", itemCountReg));
        item.setItemCountStock(String.format("%,d", itemCountStock));
        item.setItemCountCart(String.format("%,d", itemCountCart));
        item.setItemCountCurrent(String.format("%,d", AppUtil.getItemViewerCount()));
        item.setItemCountSold(String.format("%,d", saleCount));
        accounts.setTotalSalesValue(String.format("%,.2f", totalValueSales));
        accounts.setTotalStockValue(String.format("%,.2f", totalValueStock));
        accounts.setIncomeCommissions(String.format("%,.2f", totalIncomeCommissions));
        accounts.setIncomePromotions(String.format("%,.2f", totalIncomePromos));
        accounts.setTotalIncome(String.format("%,.2f", totalIncomeCommissions + totalIncomePromos));
    }

    public com.neo.beans.item.Item[] getItems(String searchText) {
        Criteria criteria = createCriteria(ContainerItem.class);
        criteria.createAlias("container", "container").createAlias("container.containerType", "containerType")
                .add(Restrictions.eq("containerType.name", com.neo.beans.item.Container.STOCK.toString()));
        if (searchText != null && !searchText.trim().isEmpty()) {
            criteria.createAlias("item", "item").add(Restrictions.or(
                    Restrictions.like("item.name", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("item.summary", searchText, MatchMode.ANYWHERE)));
        }
        return get(criteria);
    }

    com.neo.beans.user.User getBuyer(ContainerItem containerItem) {
        System.out.println("##### Getting buyer : " + containerItem.getContainerItemId());
        for (ContainerItem ci : containerItem.getItem().getContainerItems()) {
            System.out.println("Checking " + ci);
            if (ci.getContainer().getContainerType().getName().equals(com.neo.beans.item.Container.BOUGHT.toString())) {
                System.out.println("Buyer found");
                return (UserManager.getInstance(getRequest()).getBuyer(ci.getContainer().getUser()));
            }
        }
        System.out.println("!!!!!!!!! No buyer");
        return null;
    }

    private ContainerType getContainerType(String type) {
        ContainerType containerType = (ContainerType) get(ContainerType.class,
                                                          Restrictions.eq("name", type))[0];
        if (containerType == null) {
            containerType = new ContainerType();
            containerType.setName(type);
            save(containerType);
        }
        return containerType;
    }

    private com.neo.beans.user.User getUser(com.neo.beans.item.Container container, Item item) {
        Criteria containerItemCriteria = createCriteria(ContainerItem.class);
        containerItemCriteria.createAlias("item", "item").add(Restrictions.eq("item.itemId", item.getItemId()));
        Serializable[] ses = get(ContainerItem.class, containerItemCriteria);
        com.neo.beans.user.User user = null;
        System.out.println("####### Getting item user for " + container.toString());
        boolean draftOrStock = (container == com.neo.beans.item.Container.DRAFT || container == com.neo.beans.item.Container.STOCK);
        for (Serializable se : ses) {
            ContainerItem containerItem = (ContainerItem) se;
            System.out.println("Checking containeritem " + containerItem.getContainerItemId());
            if (draftOrStock) {
                if (containerItem.getContainer().getContainerType().getName().equals(com.neo.beans.item.Container.DRAFT.toString())
                    || containerItem.getContainer().getContainerType().getName().equals(com.neo.beans.item.Container.STOCK.toString())) {
                    System.out.println("Found containeritem " + containerItem.getContainerItemId());
                    user = UserManager.getInstance(getRequest()).getSeller(containerItem.getContainer().getUser());
                    break;
                }
            } else {
                if (containerItem.getContainer().getContainerType().getName().equals(container.toString())) {
                    System.out.println("Found containeritem " + containerItem.getContainerItemId());
                    user = UserManager.getInstance(getRequest()).getSeller(containerItem.getContainer().getUser());
                    break;
                }
            }
        }
        System.out.println("####### User :  " + user);
        return user;
    }

    private Container getContainer(User user, ContainerType containerType) {
        Criteria containerCriteria = createCriteria(Container.class);
        containerCriteria.createAlias("containerType", "containerType").createAlias("user", "user")
                .add(Restrictions.eq("user.userId", user.getUserId()))
                .add(Restrictions.eq("containerType.name", containerType.getName()));
        Container cont = (Container) get(Container.class, containerCriteria)[0];
        if (cont == null) {
            cont = new Container(containerType, user);
            save(cont);
        }
        return cont;
    }

    private void addToContainer(Container container, com.neo.beans.user.User userToAdd, com.neo.beans.item.Item item) {
        boolean edit = userToAdd.equals(item.getSeller())
                       && container.getContainerType().getName().equals(com.neo.beans.item.Container.STOCK.toString())
                       && item.getId() != 0;
        ContainerItem containerItem;
        Property[] properties = item.getProperties();
        Image[] images = item.getImages();
        if (saveBean(item).isSuccess()) {
            containerItem = (ContainerItem) get(item.getId());
            if (container.getContainerType().getName().equals(com.neo.beans.item.Container.STOCK.toString())) {
                item.setProperties(properties);
                ItemPropertyManager.getInstance(getRequest()).saveItemProperties(item.getId(), properties);
                item.setImages(images);
                ImageManager.getInstance(getRequest()).saveItemImages(item.getId(), images);
                userToAdd.addItem(com.neo.beans.item.Container.STOCK, item);
            } else if (container.getContainerType().getName().equals(com.neo.beans.item.Container.DRAFT.toString())) {
                item.setProperties(properties);
                ItemPropertyManager.getInstance(getRequest()).saveItemProperties(item.getId(), properties);
                item.setImages(images);
                ImageManager.getInstance(getRequest()).saveItemImages(item.getId(), images);
                userToAdd.addItem(com.neo.beans.item.Container.DRAFT, item);
            }
            if (edit) {
                containerItem.setQuantity(0);
                containerItem.getItem().setPrice(BigDecimal.ZERO);
                containerItem.setQuantity(containerItem.getQuantity() + item.getQuantity());
                containerItem.getItem().setPrice(BigDecimal.valueOf(item.getUnitprice()));
                save(containerItem.getItem());
            }
            calculateTotals(container, containerItem);
            save(containerItem);
            save(container);
        }
    }

    private void calculateTotals(Container container, ContainerItem containerItem) {
        if (containerItem.getQuantity() == null) {
            containerItem.setQuantity(0);
        }
        if (containerItem.getItem().getPrice() == null) {
            containerItem.getItem().setPrice(BigDecimal.ZERO);
        }
        if (container.getTotalQty() == null) {
            container.setTotalQty(0);
        }
        if (container.getTotalAmount() == null) {
            container.setTotalAmount(BigDecimal.ZERO);
        }
        Serializable[] containerItems = get(ContainerItem.class, Restrictions.eq("container", container));
        int quantity = 0;
        float value = 0;
        for (Serializable item : containerItems) {
            if (item != null) {
                quantity += ((ContainerItem) item).getQuantity();
                value += ((ContainerItem) item).getItem().getPrice().floatValue();
            }
        }
        container.setTotalAmount(BigDecimal.valueOf(value));
        container.setTotalQty(quantity);
    }

    private int getQuantity(Item item, com.neo.beans.item.Container container) {
        Criteria criteria = createCriteria(ContainerItem.class)
                .add(Restrictions.eq("item", item))
                .createAlias("container", "container")
                .createAlias("container.containerType", "type")
                .add(Restrictions.eq("type.name", container.toString()));
        ContainerItem i = (ContainerItem) get(ContainerItem.class, criteria)[0];
        if (i == null || i.getQuantity() == null) {
            return 0;
        }
        return i.getQuantity();
    }

    private long getCreatedTime(Item item, com.neo.beans.item.Container container, int userId) {
        Criteria criteria = createCriteria(ContainerItem.class)
                .add(Restrictions.eq("item", item))
                .createAlias("container", "container")
                .createAlias("container.containerType", "type")
                .createAlias("container.user", "user")
                .add(Restrictions.eq("user.userId", userId))
                .add(Restrictions.eq("type.name", container.toString()));
        ContainerItem i = (ContainerItem) get(ContainerItem.class, criteria)[0];
        if (i == null || i.getCreateTime() == null) {
            return 0;
        }
        return i.getCreateTime();
    }

    private ContainerItem getContainerItem(Container container, int itemId) {
        Criteria criteriaContainerItem = createCriteria(ContainerItem.class);
        criteriaContainerItem.add(Restrictions.eq("container", container));
        criteriaContainerItem.createAlias("item", "item").add(Restrictions.eq("item.itemId", itemId));
        return (ContainerItem) get(ContainerItem.class, criteriaContainerItem)[0];
    }
}
