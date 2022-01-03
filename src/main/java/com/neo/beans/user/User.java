/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.user;

import com.neo.beans.Bean;
import com.neo.beans.item.Category;
import com.neo.beans.item.Container;
import com.neo.beans.item.Item;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import com.neo.util.CategorizedList;
import com.neo.util.CountedList;
import com.neo.util.SearchCriteria;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;

/**
 *
 * @author neo
 */
public final class User extends Bean<User> {

    private String nameFirst;
    private String nameSecond;
    private String nameLast;
    private String contactNo;
    private String addressLine1;
    private String addressLine2;
    private String addressLine3;
    private String addressCity;
    private String email;
    private String username;
    private String password;
    private String securityQuestion;
    private String securityAnswer;
    private String avatarName;
    private String uid;
    private long uidCreatTime;
    private String contactNoCode;
    private String emailCode;
    private String type;
    private String status;
    private CategorizedList<Message, MessageBox> messages = new CategorizedList<>();
    private CategorizedList<Item, Container> items = new CategorizedList<>();
    private long createTime;
    private SearchResult searchResult;

    public User() {
    }

    public User(User clone) {
        clone(clone);
    }

    public void addMessage(Message message, MessageBox box) {
        if (box == MessageBox.INBOX) {
            message.setUserTo(this);
        } else if (box == MessageBox.OUTBOX) {
            message.setUserFrom(this);
        }
        messages.add(message, box);
    }

    public void addMessages(Message[] messages, MessageBox messageBox) {
        for (Message message : messages) {
            if (message != null) {
                addMessage(message, messageBox);
            }
        }
    }

    public int getUnreadMessageCount() {
        Message[] ms = getMessages(MessageBox.INBOX);
        int count = 0;
        for (Message m : ms) {
            if (m.getTimeReceived() == 0) {
                count++;
            }
        }
        return count;
    }

    public void addItem(Container container, Item item) {
        items.add(item, container);
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public Item[] getItems(Container container) {
        ArrayList<Item> itms = items.get(container);
        return itms.toArray(new Item[itms.size()]);
    }

    public Message[] getMessages(MessageBox box) {
        ArrayList<Message> msgs = messages.get(box);
        return msgs.toArray(new Message[msgs.size()]);
    }

    public Message[] getMessages(String userTypeFrom, MessageBox box) {
        ArrayList<Message> msgs = new ArrayList<>(0);
        switch (userTypeFrom) {
            case AppConst.User.USER_TYPE_ADMINISTRATOR:
                for (Message message : messages.get(box)) {
                    if (message.getReferencedItem() == null) {
                        msgs.add(message);
                    }
                }
                break;
            case AppConst.User.USER_TYPE_SELLER:
                for (Message message : messages.get(box)) {
                    if (message.getReferencedItem() != null && message.getReferencedItem().getSeller().getId() != getId()) {
                        msgs.add(message);
                    }
                }
                break;
            case AppConst.User.USER_TYPE_BUYER:
                for (Message message : messages.get(box)) {
                    if (message.getReferencedItem() != null && message.getReferencedItem().getSeller().getId() == getId()) {
                        msgs.add(message);
                    }
                }
                break;
            default:
                throw new AssertionError();
        }
        return msgs.toArray(new Message[msgs.size()]);
    }

    public String getAddressLine1() {
        return addressLine1;
    }

    public void setAddressLine1(String addressLine1) {
        this.addressLine1 = addressLine1;
    }

    public String getAddressLine2() {
        return addressLine2;
    }

    public void setAddressLine2(String addressLine2) {
        this.addressLine2 = addressLine2;
    }

    public String getAddressLine3() {
        return addressLine3;
    }

    public void setAddressLine3(String addressLine3) {
        this.addressLine3 = addressLine3;
    }

    public String getAddressCity() {
        return addressCity;
    }

    public void setAddressCity(String addressCity) {
        this.addressCity = addressCity;
    }

    public String getAddress() {
        String address = "";
        if (getAddressLine1() != null && !getAddressLine1().trim().isEmpty()) {
            address += getAddressLine1() + ", ";
        }
        if (getAddressLine2() != null && !getAddressLine2().trim().isEmpty()) {
            address += getAddressLine2() + ", ";
        }
        if (getAddressLine3() != null && !getAddressLine3().trim().isEmpty()) {
            address += getAddressLine3() + ", ";
        }
        if (getAddressCity() != null && !getAddressCity().trim().isEmpty()) {
            address += getAddressCity();
        }
        address = address.trim();
        if (address.endsWith(",")) {
            address = address.substring(0, address.lastIndexOf(','));
        }
        return address;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNameFirst() {
        return nameFirst;
    }

    public void setNameFirst(String nameFirst) {
        this.nameFirst = nameFirst;
    }

    public String getNameSecond() {
        return nameSecond;
    }

    public void setNameSecond(String nameSecond) {
        this.nameSecond = nameSecond;
    }

    public String getNameLast() {
        return nameLast;
    }

    public void setNameLast(String nameLast) {
        this.nameLast = nameLast;
    }

    public String getName() {
        String name = "";
        if (getNameFirst() != null && !getNameFirst().trim().isEmpty()) {
            name += getNameFirst() + " ";
        }
        if (getNameSecond() != null && !getNameSecond().trim().isEmpty()) {
            name += getNameSecond() + " ";
        }
        if (getNameLast() != null && !getNameLast().trim().isEmpty()) {
            name += getNameLast() + " ";
        }
        return name.trim();
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
        if (uid != null) {
            setUidCreatTime(Calendar.getInstance().getTimeInMillis());
        }
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSecurityQuestion() {
        return securityQuestion;
    }

    public void setSecurityQuestion(String securityQuestion) {
        this.securityQuestion = securityQuestion;
    }

    public String getSecurityAnswer() {
        return securityAnswer;
    }

    public void setSecurityAnswer(String securityAnswer) {
        this.securityAnswer = securityAnswer;
    }

    public boolean isBuyer() {
        return getType().equals(AppConst.User.USER_TYPE_BUYER)
               || getType().equals(AppConst.User.USER_TYPE_BUYER_SELLER);
    }

    public boolean isSeller() {
        return getType().equals(AppConst.User.USER_TYPE_SELLER)
               || getType().equals(AppConst.User.USER_TYPE_BUYER_SELLER);
    }

    public boolean isGuest() {
        return getType().equals(AppConst.User.USER_TYPE_GUEST);
    }

    public boolean isAdmin() {
        return getType().equals(AppConst.User.USER_TYPE_ADMINISTRATOR);
    }

    public boolean isAccountant() {
        return getType().equals(AppConst.User.USER_TYPE_ACCOUNTANT);
    }

    public String getAvatarName() {
        return avatarName;
    }

    public void setAvatarName(String avatarName) {
        this.avatarName = avatarName;
    }

    public String getAvatarSrc() {
        if (isAvatarGenericMale()) {
            return AppConst.User.AVATAR_PATH_GENERIC_MALE;
        }
        if (isAvatarGenericFemale()) {
            return AppConst.User.AVATAR_PATH_GENERIC_FEMALE;
        }
        return AppConst.Image.REQUEST_IMAGE_USER + getAvatarName();
    }

    public String getAvatarBase64() {
        if (isAvatarGenericMale()) {
            return AppUtil.getBase64Image(AppConst.Image.PARA_VAL_TYPE_USER_IMAGE,
                                          AppConst.User.AVATAR_NAME_GENERIC_MALE);
        }
        if (isAvatarGenericFemale()) {
            return AppUtil.getBase64Image(AppConst.Image.PARA_VAL_TYPE_USER_IMAGE,
                                          AppConst.User.AVATAR_NAME_GENERIC_FEMALE);
        }
        return AppUtil.getBase64Image(AppConst.Image.PARA_VAL_TYPE_USER_IMAGE, getAvatarName());
    }

    public String getUserAvatarSrc() {
        if (getAvatarName() == null) {
            return AppConst.Image.REQUEST_IMAGE_USER + getAvatarName();
        }
        if (getAvatarName().equals(AppConst.User.PARA_AVATAR_MALE) || getAvatarName().equals(
                AppConst.User.PARA_AVATAR_FEMALE)) {
            return AppConst.User.AVATAR_PATH_SELECT_IMAGE;
        }
        return AppConst.Image.REQUEST_IMAGE_USER + getAvatarName();
    }

    public String getUserAvatarBase64() {
        if (getAvatarName() == null) {
            return AppUtil.getBase64Image(AppConst.Image.PARA_VAL_TYPE_USER_IMAGE, getAvatarName());
        }
        if (isAvatarGenericMale() || isAvatarGenericFemale()) {
            return AppUtil.getBase64Image(AppConst.Image.PARA_VAL_TYPE_USER_IMAGE,
                                          AppConst.User.AVATAR_NAME_SELECT_IMAGE);
        }
        return AppUtil.getBase64Image(AppConst.Image.PARA_VAL_TYPE_USER_IMAGE, getAvatarName());
    }

    public boolean isAvatarGenericMale() {
        return getAvatarName() != null && getAvatarName().equals(AppConst.User.PARA_AVATAR_MALE);
    }

    public boolean isAvatarGenericFemale() {
        return getAvatarName() != null && getAvatarName().equals(AppConst.User.PARA_AVATAR_FEMALE);
    }

    public boolean isAvatarUser() {
        return !isAvatarGenericMale() && !isAvatarGenericFemale();
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void addItems(Item[] items, Container container) {
        if (items != null && items.length > 0) {
            this.items.add(items, container);
        }
    }

    public float getTotalValue(Container container) {
        float total = 0;
        for (Item item : getItems(container)) {
            total += item.getQuantity();
        }
        return total;
    }

    public String getTotalValueFormatted(Container container) {
        float total = 0;
        for (Item item : getItems(container)) {
            total += (item.getUnitprice() * item.getQuantity());
        }
        return String.format("%,.2f", total);
    }

    public boolean hasItem(Container container, Item item) {
        for (Item itm : getItems(container)) {
            if (itm.getItemId() == item.getItemId()) {
                return true;
            }
        }
        return false;
    }

    public int getQtyOf(Container container, Item item) {
        for (Item itm : getItems(container)) {
            if (itm.getItemId() == item.getItemId()) {
                return itm.getQuantity();
            }
        }
        return 0;
    }

    public int getTotalQty(Container container) {
        int total = 0;
        for (Item item : getItems(container)) {
            total += item.getQuantity();
        }
        return total;
    }

    public String getTotalQtyText(Container container) {
        return AppUtil.convertToText(String.valueOf(getTotalQty(container)));
    }

    public int getItemCount(Container container) {
        return getItems(container).length;
    }

    public String getItemCountText(Container container) {
        return AppUtil.convertToText(String.valueOf(getItemCount(container)));
    }

    public void setContactNoCode(String contactNoCode) {
        this.contactNoCode = contactNoCode;
    }

    public String getContactNoCode() {
        return contactNoCode;
    }

    public String getEmailCode() {
        return emailCode;
    }

    public void setEmailCode(String emailCode) {
        this.emailCode = emailCode;
    }

    public long getUidCreatTime() {
        return uidCreatTime;
    }

    public void setUidCreatTime(long uidCreatTime) {
        this.uidCreatTime = uidCreatTime;
    }

    public long getUidAge() {
        return Calendar.getInstance().getTimeInMillis() - getUidCreatTime();
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

    public SearchResult getSearchResult(Item[] items, SearchCriteria criteria) {
        if (searchResult == null) {
            searchResult = new SearchResult();
        }
        searchResult.setItems(items);
        searchResult.setTotalCount((items[0] == null) ? 0 : items.length);
        searchResult.setCriteria(criteria);
        searchResult.setVisibleCategory(criteria.getCategory(), true);
        return searchResult;
    }

    public SearchResult getSearchResult() {
        if (searchResult == null) {
            searchResult = new SearchResult();
        }
        return searchResult;
    }

    public void setSearchResult(SearchResult searchResult) {
        this.searchResult = searchResult;
    }

    @Override
    public void clone(User bean) {
        setNameFirst(bean.getNameFirst());
        setNameSecond(bean.getNameSecond());
        setNameLast(bean.getNameLast());
        setContactNo(bean.getContactNo());
        setEmail(bean.getEmail());
        setUsername(bean.getUsername());
        setPassword(bean.getPassword());
        setAddressLine1(bean.getAddressLine1());
        setAddressLine2(bean.getAddressLine2());
        setAddressLine3(bean.getAddressLine3());
        setAddressCity(bean.getAddressCity());
        setUid(bean.getUid());
        setUidCreatTime(bean.getUidCreatTime());
        setContactNoCode(bean.getContactNoCode());
        setEmailCode(bean.getEmailCode());
        setAvatarName(bean.getAvatarName());
        setSecurityQuestion(bean.getSecurityQuestion());
        setSecurityAnswer(bean.getSecurityAnswer());
        setType(bean.getType());
        setStatus(bean.getStatus());
        setItems(bean.getItems());
        setMessages(bean.getMessages());
        setSearchResult(bean.getSearchResult());
        setId(bean.getId());
    }

    public CategorizedList<Message, MessageBox> getMessages() {
        return messages;
    }

    public void setMessages(CategorizedList<Message, MessageBox> messages) {
        this.messages = messages;
    }

    public CategorizedList<Item, Container> getItems() {
        return items;
    }

    public void setItems(CategorizedList<Item, Container> items) {
        this.items = items;
    }

    public Item getItem(Container container, String uid) {
        for (Item item : getItems(container)) {
            if (item != null && item.getUid() != null && item.getUid().equals(uid)) {
                return item;
            }
        }
        return null;
    }

    public class SearchResult implements Serializable {

        private Item[] items;
        private int totalCount;
        private int resultPosition;
        private SearchCriteria criteria;
        private final CountedList<Category> categories = new CountedList<>();
        private final HashMap<Integer, Item[]> map = new HashMap<>(5);
        private PageSelector[] pages;

        private SearchResult() {
        }

        public void setTotalCount(int totalCount) {
            this.totalCount = totalCount;
        }

        public int getTotalCount() {
            return totalCount;
        }

        public void setItems(Item[] items) {
            this.items = items;
        }

        public Item[] getItems() {
            return Arrays.copyOf(items, items.length);
        }

        public boolean isEmpty() {
            return items == null || (items.length == 1 && items[0] == null);
        }

        public void setCriteria(SearchCriteria criteria) {
            if (this.criteria == null) {
                generateCategoryList();
            } else if (!(this.criteria.equals(criteria))) {
                generateCategoryList();
            }
            this.criteria = criteria;
            generatePages();
            divideItems(items);
        }

        public SearchCriteria getCriteria() {
            return criteria;
        }

        public String getResultSummary() {
            String text;
            int resultPageNo = getResultPosition();
            int maxResults = AppConst.Item.MAX_SEARCH_RESULTS_PER_PAGE;
            int firstResult = (resultPageNo - 1) * maxResults;
            int total = getTotalCount();
            if (firstResult == 0) {
                if (maxResults >= total) {
                    if (total == 1) {
                        text = "showing the 1 item";
                    } else {
                        text = "showing all " + total + " items";
                    }
                } else {
                    text = "showing first " + maxResults + " of total " + total + " items";
                }
            } else {
                text = "showing " + firstResult + " - "
                       + Math.min((firstResult + maxResults), total) + " of total " + total + " items";
            }
            return text;
        }

        public ResultPage resetResults(int pageNo) {
            setResultPosition(pageNo);
            divideItems(items);
            generatePages();
            setVisibleCategory(null, false);
            return new ResultPage(map.get(pageNo));
        }

        public ResultPage getResults(int pageNo) {
            setResultPosition(pageNo);
            generatePages();
            return new ResultPage(map.get(pageNo));
        }

        public ResultPage getResultsByMainCategoryId(int mainCategoryId) {
            ArrayList<Item> list = new ArrayList<>(10);
            Category visibleCategory = null;
            for (Item item : items) {
                if (item.getCategoryMain().getCategoryId() == mainCategoryId) {
                    list.add(item);
                    visibleCategory = item.getCategoryMain();
                }
            }
            Item[] is = list.toArray(new Item[list.size()]);
            divideItems(is);
            generatePages();
            setVisibleCategory(visibleCategory, true);
            return new ResultPage(is);
        }

        public ResultPage getResultsByItemCategoryId(int itemCategoryId) {
            ArrayList<Item> list = new ArrayList<>(10);
            Category visibleCategory = null;
            for (Item item : items) {
                if (item.getCategoryMain().getId() == itemCategoryId) {
                    list.add(item);
                    visibleCategory = item.getCategoryMain();
                }
            }
            Item[] is = list.toArray(new Item[list.size()]);
            divideItems(is);
            generatePages();
            setVisibleCategory(visibleCategory, false);
            return new ResultPage(is);
        }

        public PageSelector[] getSelectors() {
            return pages;
        }

        public Category[] getDistinctCategories() {
            return categories.toArray(new Category[categories.size()]);
        }

        public void setVisibleCategory(Category category, boolean mainOnly) {
            for (Category cat : categories) {
                cat.setVisible(false);
                for (Category subCategory : cat.getSubCategories()) {
                    subCategory.setVisible(false);
                }
            }
            if (category != null) {
                if (criteria.getCategory() == null) {
                    if (mainOnly) {
                        for (Category cat : categories) {
                            if (category.getCategoryId() == cat.getCategoryId()) {
                                cat.setVisible(true);
                            }
                        }
                    } else {
                        for (Category cat : categories) {
                            for (Category subCategory : cat.getSubCategories()) {
                                if (category.getId() == subCategory.getId()) {
                                    cat.setVisible(true);
                                    subCategory.setVisible(true);
                                }
                            }
                        }
                    }
                } else {
                    if (criteria.getCategory().getId() == 0) {
                        for (Category cat : categories) {
                            if (category.getCategoryId() == cat.getCategoryId()) {
                                cat.setVisible(true);
                            }
                        }
                    } else {
                        for (Category cat : categories) {
                            for (Category subCategory : cat.getSubCategories()) {
                                if (category.getId() == subCategory.getId()) {
                                    cat.setVisible(true);
                                    subCategory.setVisible(true);
                                }
                            }
                        }
                    }
                }
            }
        }

        public int getResultPosition() {
            return resultPosition;
        }

        public void setResultPosition(int resultPosition) {
            this.resultPosition = resultPosition;
        }

        private void divideItems(Item[] items) {
            setTotalCount((items[0] == null) ? 0 : items.length);
            int total = getTotalCount();
            int maxResults = AppConst.Item.MAX_SEARCH_RESULTS_PER_PAGE;
            int count = (total / maxResults) + (total % maxResults == 0 ? 0 : 1);
            for (int i = 0; i < count; i++) {
                map.put(i + 1, Arrays.copyOfRange(items, (i * maxResults), ((i * maxResults) + maxResults)));
            }
        }

        private void generatePages() {
            int maxResults = AppConst.Item.MAX_SEARCH_RESULTS_PER_PAGE;
            int total = getTotalCount();
            int pageCount = (total / maxResults) + (total % maxResults == 0 ? 0 : 1);
            int activePageNo = getResultPosition();
            int selectorCount = Math.min(pageCount, AppConst.Item.MAX_VISIBLE_PAGE_SELECTORS);
            pages = new PageSelector[selectorCount];
            for (int i = 0; i < pages.length; i++) {
                int pageNo;
                if ((activePageNo - (selectorCount / 2)) > 0 && (activePageNo + (selectorCount / 2) + 1) < pageCount) {
                    pageNo = (activePageNo - (selectorCount / 2)) + i;
                } else if ((activePageNo + (selectorCount / 2) + 1) >= pageCount) {
                    pageNo = (pageCount - ((selectorCount - 1) - i));
                } else {
                    pageNo = i + 1;
                }
                String link = AppConst.Item.REQUEST_RESULTS_MOVE + pageNo;
                pages[i] = new PageSelector(pageNo,
                                            (pageNo == activePageNo),
                                            link);
            }
        }

        private void generateCategoryList() {
            categories.clear();
            for (Item item : items) {
                if (item != null) {
                    Category category = item.getCategoryMain();
                    if ((category = categories.contains(category)) != null) {
                        category.addSubCategory(item.getCategorySub());
                    } else {
                        category = item.getCategoryMain();
                        category.getSubCategory().countUp();
                    }
                    categories.add(category);
                }
            }
        }

        public class ResultPage implements Serializable {

            private final Item[] items;

            public ResultPage(Item[] items) {
                this.items = items;
            }

            public Item[] getItems() {
                return items;
            }

            public Item[] getCulumn1Items() {
                int col1Length = 0;
                if (items != null && !(items.length == 1 && items[0] == null)) {
                    col1Length = (items.length / 2) + (items.length % 2 == 0 ? 0 : 1);
                }
                Item[] col1Items = new Item[col1Length];
                int index = 0;
                col1Length *= 2;
                col1Length--;
                for (int i = 0; i <= col1Length; i++) {
                    if (items != null && i % 2 == 0 && items[i] != null) {
                        col1Items[index] = items[i];
                        index++;
                    }
                }
                System.out.println("Column 1 : " + col1Items.length);
                return col1Items;
            }

            public Item[] getCulumn2Items() {
                int col2Length = 0;
                if (items != null && !(items.length == 1 && items[0] == null)) {
                    col2Length = (items.length / 2);
                }
                Item[] col2Items = new Item[col2Length];
                int index = 0;
                col2Length *= 2;
                for (int i = 1; i <= col2Length; i++) {
                    if (items != null && i % 2 == 1 && items[i] != null) {
                        col2Items[index] = items[i];
                        index++;
                    }
                }
                System.out.println("Column 2 : " + col2Items.length);
                return col2Items;
            }
        }

        public class PageSelector implements Serializable {

            private final int pageNo;
            private final boolean active;
            private final String link;

            public PageSelector(int pageNo, boolean active, String link) {
                this.pageNo = pageNo;
                this.active = active;
                this.link = link;
            }

            public String getLink() {
                if (isActive()) {
                    return "#";
                }
                return link;
            }

            public int getPageNo() {
                return pageNo;
            }

            public boolean isActive() {
                return active;
            }
        }
    }
}
