/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.BeanController;
import com.neo.database.entities.SecurityQuestion;
import com.neo.database.entities.User;
import com.neo.database.entities.UserSecurityQuestion;
import com.neo.util.AppConst;
import java.io.Serializable;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author neo
 */
public final class SecurityQuestionManager extends BeanController<com.neo.beans.user.SecurityQuestion> {

    public static SecurityQuestionManager getInstance(HttpServletRequest request) {
        HttpSession session = request.getSession();
        SecurityQuestionManager securityQuestionManager = (SecurityQuestionManager) session.getAttribute(
                AppConst.Application.SESSION_ATTR_SECURITY_Q_MANAGER);
        if (securityQuestionManager == null) {
            securityQuestionManager = new SecurityQuestionManager(session);
            session.setAttribute(AppConst.Application.SESSION_ATTR_SECURITY_Q_MANAGER, securityQuestionManager);
        }
        securityQuestionManager.setRequest(request);
        return securityQuestionManager;
    }

    private SecurityQuestionManager(HttpSession session) {
        super(SecurityQuestion.class, com.neo.beans.user.SecurityQuestion.class, session);
    }

    @Override
    public Serializable getDatabaseBean(com.neo.beans.user.SecurityQuestion userBean) {
        if (userBean == null) {
            return null;
        }
        SecurityQuestion question = getSecurityQuestion(userBean.getQuestion());
        if (question == null) {
            question = new SecurityQuestion();
            question.setQuestion(userBean.getQuestion());
        }
        return question;
    }

    public SecurityQuestion getSecurityQuestion(String question) {
        return (SecurityQuestion) get(SecurityQuestion.class, Restrictions.eq(
                                      "question", question))[0];
    }

    public UserSecurityQuestion getUserSecurityQuestion(com.neo.beans.user.User user) {
        if (user.getSecurityQuestion() != null) {
            UserSecurityQuestion usq = null;
            User u = (User) get(User.class, user.getId());
            if (u != null) {
                usq = u.getUserSecurityQuestion();
            }
            if (usq == null) {
                usq = new UserSecurityQuestion();
                usq.setSecurityQuestion(getSecurityQuestion(user.getSecurityQuestion()));
                usq.setAnswer(user.getSecurityAnswer());
                save(usq);
            }
            return usq;
        }
        return null;
    }

    @Override
    public com.neo.beans.user.SecurityQuestion getUserBean(Serializable databaseBean) {
        SecurityQuestion securityQuestion = (SecurityQuestion) databaseBean;
        if (securityQuestion == null) {
            return null;
        }
        com.neo.beans.user.SecurityQuestion sq = new com.neo.beans.user.SecurityQuestion(securityQuestion.getQuestion(),
                                                                                         null);
        sq.setId(securityQuestion.getSecurityQuestionId());
        return sq;
    }

}
