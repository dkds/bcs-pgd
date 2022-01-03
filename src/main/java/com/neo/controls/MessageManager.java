/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.BeanController;
import com.neo.beans.item.Item;
import com.neo.beans.user.MessageBox;
import com.neo.beans.user.Subject;
import com.neo.database.entities.ContainerItem;
import com.neo.database.entities.Message;
import com.neo.database.entities.MessageSubject;
import com.neo.database.entities.User;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import java.io.Serializable;
import java.util.Calendar;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.Criteria;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author neo
 */
public final class MessageManager extends BeanController<com.neo.beans.user.Message> {

    public static MessageManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        MessageManager itemCategoryManager = (MessageManager) session.getAttribute(
                AppConst.Application.SESSION_ATTR_MESSAGE_MANAGER);
        if (itemCategoryManager == null) {
            itemCategoryManager = new MessageManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_MESSAGE_MANAGER, itemCategoryManager);
        }
        itemCategoryManager.setRequest(request);
        return itemCategoryManager;
    }

    private MessageManager(HttpSession session) {
        super(Message.class, com.neo.beans.user.Message.class, session);
    }

    public void delete(int msgId) {
        delete(get(msgId));
    }

    @Override
    public Serializable getDatabaseBean(com.neo.beans.user.Message userBean) {
        if (userBean == null) {
            return null;
        }
        Message message = (Message) get(userBean.getId());
        if (message == null) {
            message = new Message();
            message.setUserByUserFrom((User) UserManager.getInstance(getRequest()).get(userBean.getUserFrom().getId()));
            message.setUserByUserTo((User) UserManager.getInstance(getRequest()).get(userBean.getUserTo().getId()));
            message.setText(userBean.getText());
            if (userBean.getReferencedItem() != null) {
                message.setContainerItem((ContainerItem) get(ContainerItem.class, userBean.getReferencedItem().getId()));
            }
            message.setMessageSubject(getMessageSubject(userBean));
            message.setSentTime(Calendar.getInstance().getTimeInMillis());
            message.setReceivedTime(userBean.getTimeReceived());
        }
        return message;
    }

    @Override
    public com.neo.beans.user.Message getUserBean(Serializable databaseBean) {
        Message message = (Message) databaseBean;
        if (message == null) {
            return null;
        }
        com.neo.beans.user.Message msg = new com.neo.beans.user.Message();
        msg.setText(message.getText());
        msg.setSubject(getSubject(message.getMessageSubject()));
        msg.setUserFrom(UserManager.getInstance(getRequest()).getMessageUser(message.getUserByUserFrom()));
        msg.setUserTo(UserManager.getInstance(getRequest()).getMessageUser(message.getUserByUserTo()));
        if (message.getContainerItem() != null) {
            msg.setReferencedItem(ItemManager.getInstance(getRequest()).get(message.getContainerItem().getItem().getUid()));
            msg.getReferencedItem().setBuyer(ItemManager.getInstance(getRequest()).getBuyer(message.getContainerItem()));
        }
        msg.setTimeReceived(message.getReceivedTime() == null ? 0 : message.getReceivedTime());
        msg.setTimeSent(message.getSentTime() == null ? 0 : message.getSentTime());
        msg.setId(message.getMessageId());
        return msg;
    }

    public void delete(com.neo.beans.user.Message message) {
        delete(getDatabaseBean(message));
    }

    public com.neo.beans.user.Message[] get(com.neo.beans.user.User user, MessageBox messageBox) {
        Criteria messageCriteria = createCriteria(Message.class);
        switch (messageBox) {
            case INBOX:
                messageCriteria.createAlias("userByUserTo", "user");
                break;
            case OUTBOX:
                messageCriteria.createAlias("userByUserFrom", "user");
                break;
            default:
                throw new AssertionError();
        }
        messageCriteria.add(Restrictions.eq("user.userId", user.getId()));
        return get(messageCriteria);
    }

    public Subject[] getSubjects(AppUtil.ConstType constType) {
        String type;
        switch (constType) {
            case MESSAGE_SUBJECT_BUYERS:
                type = Subject.SubjectType.BUYER.toString();
                break;
            case MESSAGE_SUBJECT_SELLERS:
                type = Subject.SubjectType.SELLER.toString();
                break;
            case MESSAGE_SUBJECT_ADMIN:
                type = Subject.SubjectType.ADMIN.toString();
                break;
            default:
                throw new AssertionError();
        }
        Serializable[] ses = get(MessageSubject.class, Restrictions.eq("type", type));
        Subject[] subjects = new Subject[ses.length];
        for (int i = 0; i < ses.length; i++) {
            MessageSubject messageSubject = (MessageSubject) ses[i];
            if (messageSubject != null) {
                Subject subject = getSubject(messageSubject);
                subjects[i] = subject;
            }
        }
        return subjects;
    }

    public Subject getSubject(String subject, AppUtil.ConstType type) {
        for (Subject sub : getSubjects(type)) {
            if (String.valueOf(sub.hashCode()).equals(subject)) {
                return sub;
            }
        }
        return null;
    }

    public void setAsRead(int msgId) {
        Message message = (Message) get(msgId);
        message.setReceivedTime(Calendar.getInstance().getTimeInMillis());
        save(message);
    }

    public void notifySeller(com.neo.beans.user.User buyer, Item item) {
        com.neo.beans.user.Message message = new com.neo.beans.user.Message();
        message.setSubject(new Subject(AppConst.Message.SUBJECT_ITEM_SOLD, Subject.SubjectType.ADMIN));
        message.setText(getSoldNotfyText(buyer, item));
        message.setUserTo(item.getSeller());
        message.setUserFrom(UserManager.getInstance(getRequest()).getAdmins()[0]);
        save(message);
    }

    public com.neo.beans.user.Message[] getNewMessages(com.neo.beans.user.User user) {
        long lastMessageTime = 0;
        for (com.neo.beans.user.Message message : user.getMessages(MessageBox.INBOX)) {
            if (message.getTimeSent() > lastMessageTime) {
                lastMessageTime = message.getTimeSent();
            }
        }
        Criteria criteria = createCriteria(Message.class);
        criteria.createAlias("userByUserTo", "user")
                .add(Restrictions.eq("user.userId", user.getId()))
                .add(Restrictions.gt("sentTime", lastMessageTime));
        return get(criteria);
    }

    private MessageSubject getMessageSubject(com.neo.beans.user.Message message) {
        String type;
        String sub;
        if (message.getSubject() == null) {
            sub = "None";
            type = Subject.SubjectType.TO_ADMIN.toString();
        } else {
            sub = message.getSubject().getName();
            if (message.getReferencedItem() != null && message.getReferencedItem().getSeller().getId() == message.getUserFrom().getId()) {
                type = Subject.SubjectType.SELLER.toString();
            } else if (message.getReferencedItem() != null && message.getReferencedItem().getSeller().getId() == message.getUserTo().getId()) {
                type = Subject.SubjectType.BUYER.toString();
            } else {
                type = Subject.SubjectType.ADMIN.toString();
            }
        }
        MessageSubject subject = (MessageSubject) get(MessageSubject.class, Restrictions.eq("type", type),
                                                      Restrictions.eq("name", sub))[0];
        if (subject == null) {
            subject = new MessageSubject();
            subject.setName(sub);
            subject.setType(type);
            save(subject);
        }
        return subject;
    }

    private Subject getSubject(MessageSubject messageSubject) {
        Subject.SubjectType type = Subject.SubjectType.ADMIN;
        if (messageSubject.getType().equals(Subject.SubjectType.ADMIN.toString())) {
            type = Subject.SubjectType.ADMIN;
        } else if (messageSubject.getType().equals(Subject.SubjectType.BUYER.toString())) {
            type = Subject.SubjectType.BUYER;
        } else if (messageSubject.getType().equals(Subject.SubjectType.SELLER.toString())) {
            type = Subject.SubjectType.SELLER;
        }
        return new Subject(messageSubject.getName(), type);
    }

    private String getSoldNotfyText(com.neo.beans.user.User buyer, Item item) {
        String text = "Item : " + item.getName() + "\n"
                      + "Buyer : " + buyer.getUsername() + "\n"
                      + "Quantity : " + item.getQuantity() + "\n"
                      + "Delivery address : " + buyer.getName() + ", " + buyer.getAddress();
        return text;
    }
}