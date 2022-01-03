/*
 * To change this license subject, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.user;

import com.neo.beans.Bean;
import com.neo.beans.item.Item;
import com.neo.util.AppConst;
import java.util.Date;

/**
 *
 * @author neo
 */
public final class Message extends Bean<Message> {

    private User userFrom;
    private User userTo;
    private Subject subject;
    private String text;
    private Item referencedItem;
    private long timeSent;
    private long timeReceived;
    private MessageBox messageBox;

    public Message() {
    }

    public Message(String text) {
        this.text = text;
    }

    public Item getReferencedItem() {
        return referencedItem;
    }

    public void setReferencedItem(Item referencedItem) {
        this.referencedItem = referencedItem;
    }

    public long getTimeSent() {
        return timeSent;
    }

    public void setTimeSent(long timeSent) {
        this.timeSent = timeSent;
    }

    public String getTimeSentFormatted() {
        return AppConst.Application.DEFAULT_DATE_FORMAT.format(new Date(timeSent));
    }

    public String getTimeReceivedFormatted() {
        return AppConst.Application.DEFAULT_DATE_FORMAT.format(new Date(timeReceived));
    }

    public User getUserFrom() {
        return userFrom;
    }

    public void setUserFrom(User userFrom) {
        this.userFrom = userFrom;
    }

    public User getUserTo() {
        return userTo;
    }

    public void setUserTo(User userTo) {
        this.userTo = userTo;
    }

    public Subject getSubject() {
        return subject;
    }

    public void setSubject(Subject subject) {
        this.subject = subject;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    @Override
    public void clone(Message bean) {
        setSubject(bean.getSubject());
        setText(bean.getText());
        setReferencedItem(bean.getReferencedItem());
        setTimeSent(bean.getTimeSent());
        setTimeReceived(bean.getTimeReceived());
        setUserFrom(bean.getUserFrom());
        setUserTo(bean.getUserTo());
        setMessageBox(bean.getMessageBox());
        setId(bean.getId());
    }

    public long getTimeReceived() {
        return timeReceived;
    }

    public void setTimeReceived(long timeReceived) {
        this.timeReceived = timeReceived;
    }

    public MessageBox getMessageBox() {
        return messageBox;
    }

    public void setMessageBox(MessageBox messageBox) {
        this.messageBox = messageBox;
    }

    public boolean isUnread() {
        return getTimeReceived() == 0;
    }

}
