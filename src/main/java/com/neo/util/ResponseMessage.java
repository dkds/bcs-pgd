/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.util;

import java.io.Serializable;
import java.util.ArrayList;

/**
 *
 * @author neo
 */
public class ResponseMessage implements Serializable {

    private final ArrayList<Message> messages = new ArrayList<>(5);
    private AppUtil.ResponseStatus status = AppUtil.ResponseStatus.DEFAULT;

    public ResponseMessage add(String name, String message) {
        messages.add(new Message(name, message));
        return this;
    }

    public ResponseMessage add(String name, String message, String description) {
        messages.add(new Message(name, message, description));
        return this;
    }

    public boolean isEmpty() {
        return messages.isEmpty();
    }

    public boolean isEmpty(String name) {
        for (Message message : messages) {
            if (message.getName().equals(name)) {
                return false;
            }
        }
        return true;
    }

    public Message getMessage(String name) {
        for (Message message : messages) {
            if (message.getName().equals(name)) {
                return message;
            }
        }
        return new Message();
    }

    public AppUtil.ResponseStatus getStatus() {
        return status;
    }

    public void setStatus(AppUtil.ResponseStatus status) {
        this.status = status;
    }

    public class Message implements Serializable {

        private String name = "";
        private String text = "";
        private String description = "";

        public Message() {
        }

        public Message(String name, String message) {
            this.name = name;
            this.text = message;
        }

        public Message(String name, String message, String description) {
            this.name = name;
            if (message != null) {
                this.text = message;
            }
            if (description != null) {
                this.description = description;
            }
        }

        public String getDescription() {
            return description;
        }

        public String getName() {
            return name;
        }

        public String getText() {
            return text;
        }

    }
}
