/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.BeanController;
import com.neo.beans.user.MessageBox;
import com.neo.database.entities.Container;
import com.neo.database.entities.ContainerItem;
import com.neo.database.entities.Item;
import com.neo.database.entities.ItemDeliveryOption;
import com.neo.database.entities.ItemGuaranteeOption;
import com.neo.database.entities.ItemImage;
import com.neo.database.entities.ItemProperty;
import com.neo.database.entities.ItemReturnOption;
import com.neo.database.entities.User;
import com.neo.database.entities.UserConst;
import com.neo.database.entities.UserImage;
import com.neo.database.entities.UserSecurityQuestion;
import com.neo.database.entities.UserStatus;
import com.neo.database.entities.UserType;
import com.neo.util.AdminStatistics;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import java.io.Serializable;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author neo
 */
public final class UserManager extends BeanController<com.neo.beans.user.User> {

    public static UserManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        UserManager userManager = (UserManager) session.getAttribute(AppConst.Application.SESSION_ATTR_USER_MANAGER);
        if (userManager == null) {
            userManager = new UserManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_USER_MANAGER, userManager);
        }
        userManager.setRequest(request);
        return userManager;
    }

    public static void createNewInstance(HttpSession session) {
        UserManager userManager = (UserManager) session.getAttribute(AppConst.Application.SESSION_ATTR_USER_MANAGER);
        if (userManager == null) {
            userManager = new UserManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_USER_MANAGER, userManager);
        }
    }

    private boolean seller;
    private boolean messageUser;
    private boolean buyer;

    private UserManager(HttpSession session) {
        super(User.class, com.neo.beans.user.User.class, session);
    }

    public com.neo.beans.user.User get(String username, String password) {
        return get(Restrictions.or(Restrictions.eq("email", username), Restrictions.eq(
                                   "username", username)),
                   Restrictions.eq("password", password))[0];
    }

    public com.neo.beans.user.User get(String uid) {
        return get(Restrictions.eq("uid", uid))[0];
    }

    @Override
    public Serializable getDatabaseBean(com.neo.beans.user.User userBean) {
        if (userBean == null) {
            return null;
        }
        User u = (User) get(userBean.getId());
        boolean newUser = false;
        if (u == null) {
            u = new User();
            newUser = true;
        }
        u.setFirstName(userBean.getNameFirst());
        u.setSecondName(userBean.getNameSecond());
        u.setLastName(userBean.getNameLast());
        u.setContactno(userBean.getContactNo());
        u.setEmail(userBean.getEmail());
        u.setUsername(userBean.getUsername());
        u.setPassword(userBean.getPassword());
        if (userBean.getUid() == null) {
            u.setUid(AppUtil.generateUID(userBean));
            u.setUidCreateTime(Calendar.getInstance().getTimeInMillis());
        } else {
            u.setUid(userBean.getUid());
            u.setUidCreateTime(userBean.getUidCreatTime());
        }
        u.setCreateTime((newUser || userBean.getCreateTime() == 0
                         ? Calendar.getInstance().getTimeInMillis() : userBean.getCreateTime()));
        u.setContactnoCode(userBean.getContactNoCode());
        u.setEmailCode(userBean.getEmailCode());
        u.setAddressLine1(userBean.getAddressLine1());
        u.setAddressLine2(userBean.getAddressLine2());
        u.setAddressLine3(userBean.getAddressLine3());
        u.setCity(LocationManager.getInstance(getRequest()).getUserCity(userBean));
        u.setUserImage(ImageManager.getInstance(getRequest()).getUserImage(userBean));
        u.setUserSecurityQuestion(SecurityQuestionManager.getInstance(getRequest()).getUserSecurityQuestion(userBean));
        u.setUserType(getUserType(userBean.getType()));
        u.setUserStatus(getUserStatus(userBean.getStatus()));
        return u;
    }

    @Override
    public com.neo.beans.user.User getUserBean(Serializable databaseBean) {
        User user = (User) databaseBean;
        if (user == null) {
            return null;
        }
        com.neo.beans.user.User u = new com.neo.beans.user.User();
        u.setId(user.getUserId());
        u.setNameFirst(user.getFirstName());
        u.setNameSecond(user.getSecondName());
        u.setNameLast(user.getLastName());
        u.setContactNo(user.getContactno());
        u.setEmail(user.getEmail());
        u.setUsername(user.getUsername());
        u.setPassword(user.getPassword());
        u.setAddressLine1(user.getAddressLine1());
        u.setAddressLine2(user.getAddressLine2());
        u.setAddressLine3(user.getAddressLine3());
        u.setAddressCity(user.getCity() != null ? user.getCity().getName() : "");
        u.setUid(user.getUid());
        u.setUidCreatTime(user.getUidCreateTime() == null ? 0 : user.getUidCreateTime());
        u.setCreateTime(user.getCreateTime() == null ? 0 : user.getCreateTime());
        u.setContactNoCode(user.getContactnoCode());
        u.setEmailCode(user.getEmailCode());
        u.setAvatarName(user.getUserImage().getName());
        if (user.getUserSecurityQuestion() != null) {
            u.setSecurityQuestion(user.getUserSecurityQuestion().getSecurityQuestion().getQuestion());
            u.setSecurityAnswer(user.getUserSecurityQuestion().getAnswer());
        }
        if (!seller && !messageUser && !buyer) {
            u.addItems(ItemManager.getInstance(getRequest()).get(u, com.neo.beans.item.Container.STOCK),
                       com.neo.beans.item.Container.STOCK);
            u.addItems(ItemManager.getInstance(getRequest()).get(u, com.neo.beans.item.Container.DRAFT),
                       com.neo.beans.item.Container.DRAFT);
            u.addItems(ItemManager.getInstance(getRequest()).get(u, com.neo.beans.item.Container.CART),
                       com.neo.beans.item.Container.CART);
            u.addItems(ItemManager.getInstance(getRequest()).get(u, com.neo.beans.item.Container.WISHLIST),
                       com.neo.beans.item.Container.WISHLIST);
            u.addItems(ItemManager.getInstance(getRequest()).get(u, com.neo.beans.item.Container.BOUGHT),
                       com.neo.beans.item.Container.BOUGHT);
            u.addItems(ItemManager.getInstance(getRequest()).get(u, com.neo.beans.item.Container.SOLD),
                       com.neo.beans.item.Container.SOLD);
            u.addMessages(MessageManager.getInstance(getRequest()).get(u, MessageBox.INBOX), MessageBox.INBOX);
            u.addMessages(MessageManager.getInstance(getRequest()).get(u, MessageBox.OUTBOX), MessageBox.OUTBOX);
        }
        u.setType(getUserType(user.getUserType()));
        u.setStatus(getUserStatus(user.getUserStatus()));
        return u;
    }

    public boolean isEmailUsed(String email) {
        return get(UserConst.class, Restrictions.eq("email", email))[0] != null;
    }

    public boolean isUsernameUsed(String username) {
        return get(UserConst.class, Restrictions.eq("username", username))[0] != null;
    }

    public com.neo.beans.user.User createGuest() {
        com.neo.beans.user.User user = new com.neo.beans.user.User();
        user.setStatus(AppConst.User.USER_STATUS_INACTIVE);
        user.setType(AppConst.User.USER_TYPE_GUEST);
        save(user);
        return user;
    }

    public void clearOldGuests() {
        Criteria userCriteria = createCriteria(User.class)
                .add(Restrictions.lt("createTime",
                                     (Calendar.getInstance().getTimeInMillis() - AppConst.User.MAX_COOKIE_AGE)))
                .createAlias("userType", "type")
                .add(Restrictions.eq("type.name", AppConst.User.USER_TYPE_GUEST));
        Serializable[] users = get(User.class, userCriteria);
        for (Serializable se : users) {
            if (se != null) {
                User user = (User) se;
                Criteria itemCriteria = createCriteria(ContainerItem.class)
                        .createAlias("container", "container")
                        .add(Restrictions.eq("container.user", user));
                Serializable[] containerItems = get(ContainerItem.class, itemCriteria);
                for (Serializable containerItem : containerItems) {
                    if (containerItem != null) {
                        addToDelete(containerItem);
                    }
                }
                Serializable[] containers = get(Container.class, Restrictions.eq("container.user", user));
                for (Serializable container : containers) {
                    if (container != null) {
                        addToDelete(container);
                    }
                }
                addToDelete(user);
            }
        }
        delete();
    }

    public void clearUsers() {
        Serializable[] containerItems = get(ContainerItem.class);
        Serializable[] itemProps = get(ItemProperty.class);
        Serializable[] itemImages = get(ItemImage.class);
        Serializable[] items = get(Item.class);
        Serializable[] itemDeliveryOps = get(ItemDeliveryOption.class);
        Serializable[] itemGuarenteeOps = get(ItemGuaranteeOption.class);
        Serializable[] itemReturnOps = get(ItemReturnOption.class);
        Serializable[] containers = get(Container.class);
        Serializable[] users = get(User.class);
        Serializable[] userSecQs = get(UserSecurityQuestion.class);
        Serializable[] userImages = get(UserImage.class);
        delete(containerItems);
        addToDelete(itemProps);
        addToDelete(itemImages);
        delete(items);
        addToDelete(itemDeliveryOps);
        addToDelete(itemGuarenteeOps);
        addToDelete(itemReturnOps);
        delete(containers);
        delete(users);
        addToDelete(userSecQs);
        addToDelete(userImages);
        delete();
    }

    public void reloadUser(com.neo.beans.user.User user) {
        user.clone(getUserBean(get(user.getId())));
    }

    public com.neo.beans.user.User[] getAdmins() {
        Criteria userCriteria = createCriteria(User.class);
        userCriteria.createAlias("userType", "userType").add(Restrictions.eq("userType.name", AppConst.User.USER_TYPE_ADMINISTRATOR));
        return get(userCriteria);
    }

    public void getStatistics(AdminStatistics.User user) {
        int userCountReg;
        int userCountSellers;
        int userCountBuyers;
        int userCountGuests;
        Criteria userCriteria = createCriteria(User.class);
        userCriteria.createAlias("userType", "userType").add(Restrictions.ne("userType.name", AppConst.User.USER_TYPE_GUEST));
        userCountReg = (int) count(userCriteria);
        userCriteria = createCriteria(User.class);
        userCriteria.createAlias("userType", "userType").add(Restrictions.or(
                Restrictions.eq("userType.name", AppConst.User.USER_TYPE_SELLER),
                Restrictions.eq("userType.name", AppConst.User.USER_TYPE_BUYER_SELLER)));
        userCountSellers = (int) count(userCriteria);
        userCriteria = createCriteria(User.class);
        userCriteria.createAlias("userType", "userType").add(Restrictions.or(
                Restrictions.eq("userType.name", AppConst.User.USER_TYPE_BUYER),
                Restrictions.eq("userType.name", AppConst.User.USER_TYPE_BUYER_SELLER)));
        userCountBuyers = (int) count(userCriteria);
        userCriteria = createCriteria(User.class);
        userCriteria.createAlias("userType", "userType").add(Restrictions.eq("userType.name", AppConst.User.USER_TYPE_GUEST));
        userCountGuests = (int) count(userCriteria);
        user.setUserCountRegistered(String.format("%,d", userCountReg));
        user.setUserCountSellers(String.format("%,d", userCountSellers));
        user.setUserCountBuyers(String.format("%,d", userCountBuyers));
        user.setUserCountGuests(String.format("%,d", userCountGuests));
        user.setUserCountCurrent(String.format("%,d", AppUtil.getVisitorCount()));
    }

    public com.neo.beans.user.User[] getUsers(String searchText) {
        Criteria criteria = createCriteria(User.class);
        if (searchText != null && !searchText.trim().isEmpty()) {
            criteria.createAlias("city", "city").createAlias("userType", "userType").add(Restrictions.or(
                    Restrictions.like("username", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("firstName", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("secondName", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("lastName", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("addressLine1", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("addressLine2", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("addressLine3", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("city.name", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("email", searchText, MatchMode.ANYWHERE),
                    Restrictions.like("userType.name", searchText, MatchMode.ANYWHERE)
            ));
        }
        return get(criteria);
    }

    com.neo.beans.user.User getSeller(User user) {
        seller = true;
        com.neo.beans.user.User userBean = getUserBean(user);
        seller = false;
        return userBean;
    }

    com.neo.beans.user.User getBuyer(User user) {
        buyer = true;
        com.neo.beans.user.User userBean = getUserBean(user);
        buyer = false;
        return userBean;
    }

    com.neo.beans.user.User getMessageUser(User user) {
        messageUser = true;
        com.neo.beans.user.User userBean = getUserBean(user);
        messageUser = false;
        return userBean;
    }

    private String getUserType(UserType userType) {
        if (userType == null) {
            return null;
        }
        return userType.getName();
    }

    private UserType getUserType(String type) {
        UserType userType = (UserType) get(UserType.class, Restrictions.eq("name", type))[0];
        if (userType == null) {
            userType = new UserType();
            userType.setName(type);
            save(userType);
        }
        return userType;
    }

    private String getUserStatus(UserStatus userStatus) {
        if (userStatus == null) {
            return null;
        }
        return userStatus.getName();
    }

    private UserStatus getUserStatus(String status) {
        UserStatus userStatus = (UserStatus) get(UserStatus.class, Restrictions.eq("name", status))[0];
        if (userStatus == null) {
            userStatus = new UserStatus();
            userStatus.setName(status);
            save(status);
        }
        return userStatus;
    }
}
