/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.user;

import com.neo.beans.Bean;

/**
 *
 * @author neo
 */
public final class SecurityQuestion extends Bean<SecurityQuestion> {

    private String question;
    private String answer;

    public SecurityQuestion() {
    }

    public SecurityQuestion(String question, String answer) {
        this.question = question;
        this.answer = answer;
    }

    public String getQuestion() {
        return question;
    }

    public void setQuestion(String question) {
        this.question = question;
    }

    public String getAnswer() {
        return answer;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    @Override
    public void clone(SecurityQuestion bean) {
        setQuestion(bean.getQuestion());
        setAnswer(bean.getAnswer());
        setId(bean.getId());
    }
}
