/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls.dispatcher;

import com.neo.beans.item.Item;
import com.neo.beans.user.Message;
import com.neo.beans.user.User;
import com.neo.controls.MessageManager;
import com.neo.controls.SecurityQuestionManager;
import com.neo.util.AppConst;
import com.neo.util.AppUtil;
import java.util.HashSet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

/**
 *
 * @author neo
 */
// TODO methods to recover user accounts
public final class UserDispatcher extends Dispatcher {

    private static volatile UserDispatcher userDispatcher;

    public static UserDispatcher getInstance(HttpServletRequest request, HttpServletResponse response) {
        if (userDispatcher == null) {
            userDispatcher = new UserDispatcher();
        }
        userDispatcher.setRequest(request);
        userDispatcher.setResponse(response);
        return userDispatcher;
    }

    private UserDispatcher() {
    }

    @Override
    public void dispatchGet() {
    }

    @Override
    public void dispatchPost() {
        switch (getRequestType()) {
            case AppConst.User.REQUEST_TYPE_SIGN_IN:
                signIn();
                break;
            case AppConst.User.REQUEST_TYPE_SIGN_OUT:
                signOut();
                break;
            case AppConst.User.REQUEST_TYPE_SIGN_UP:
                signUp();
                break;
            case AppConst.User.REQUEST_TYPE_SIGN_UP_CHECK_EMAIL:
                checkEmail();
                break;
            case AppConst.User.REQUEST_TYPE_SIGN_UP_CHECK_USERNAME:
                checkUsername();
                break;
            case AppConst.User.REQUEST_TYPE_SIGN_UP_CHECK_PASSWORD_NEW:
                checkPasswordNew();
                break;
            case AppConst.User.REQUEST_TYPE_UPDATE_USER:
                updateUser();
                break;
            case AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION:
                updateSecurityQuestion();
                break;
            case AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD:
                updatePassword();
                break;
            case AppConst.User.REQUEST_TYPE_ACTIVATE_USER_EMAIL:
                activateUserEmail();
                break;
            case AppConst.User.REQUEST_TYPE_ACTIVATE_USER_CONTACT_NO:
                activateUserContactNo();
                break;
            case AppConst.User.REQUEST_TYPE_MESSAGE_NEW:
                saveMessage();
                break;
            case AppConst.User.REQUEST_TYPE_MESSAGE_SET_READ:
                setMessageRead();
                break;
            case AppConst.Message.REQUEST_TYPE_CHECK_NEW_MESSAGES:
                checkNewMessages();
                break;
            case AppConst.Message.REQUEST_TYPE_DELETE_MESSAGES:
                deleteMessages();
                break;
            default:
                redirectToCurrentLocation();
                break;
        }
    }

    private void checkEmail() {
        String email = getParameter(AppConst.User.PARA_EMAIL);
        if (AppUtil.isEmailValid(email)) {
            User user = getCurrentUser();
            if (user != null && user.getEmail() != null && user.getEmail().equalsIgnoreCase(email.trim())) {
                write(AppConst.User.STATUS_SIGN_UP_CHECK_EMAIL_VALID);
                return;
            }
            if (getUserManager().isEmailUsed(email)) {
                write("Email is already used");
            } else {
                write(AppConst.User.STATUS_SIGN_UP_CHECK_EMAIL_VALID);
            }
        } else {
            write("Email is in invalid format");
        }
    }

    private void checkPasswordNew() {
        String passwordNew = getParameter(AppConst.User.PARA_PASSWORD_NEW);
        if (AppUtil.isPasswordValid(passwordNew)) {
            User user = getCurrentUser();
            if (user != null && user.getPassword() != null && user.getPassword().equals(passwordNew.trim())) {
                write("Provide a new password");
                return;
            }
            write(AppConst.User.STATUS_SIGN_UP_CHECK_PASSWORD_NEW_VALID);
        } else {
            write("Provide a password with min 5 chars and max 15 chars");
        }
    }

    private void checkUsername() {
        String username = getParameter(AppConst.User.PARA_USERNAME);
        if (AppUtil.isUsernameValid(username)) {
            User user = getCurrentUser();
            if (user != null && user.getUsername() != null && user.getUsername().equalsIgnoreCase(username.trim())) {
                write(AppConst.User.STATUS_SIGN_UP_CHECK_USERNAME_VALID);
                return;
            }
            if (getUserManager().isUsernameUsed(username)) {
                write("Username is already used by another user");
            } else {
                write(AppConst.User.STATUS_SIGN_UP_CHECK_USERNAME_VALID);
            }
        } else {
            write("Username should be atleast 5 characters long");
        }
    }

    private void signIn() {
        clearResponseMessage();
        String username = getParameter(AppConst.User.PARA_USERNAME);
        String password = getParameter(AppConst.User.PARA_PASSWORD);
        String remember = getParameter(AppConst.User.PARA_REMEMBER);
        User user = getUserManager().get(username, password);
        if (user == null) {
            addResponseMessage(AppConst.User.STATUS_SIGN_IN_ERROR, "Invalid username or password !",
                               "Invalid username / email or password. Recheck your credentials and retry.");
            setResponseStatus(AppUtil.ResponseStatus.ERROR);
            redirect("user_signin.jsp");
        } else {
            System.out.println("User : " + user.getId());
            if (remember != null && remember.equalsIgnoreCase("on")) {
                if (user.getUid() == null || user.getUidAge() > AppConst.User.MAX_UID_AGE) {
                    user.setUid(AppUtil.generateUID(user));
                    getUserManager().save(user);
                }
                Cookie cookie = new Cookie(AppConst.User.COOKIE_NAME, user.getUid());
                cookie.setMaxAge(AppConst.User.MAX_COOKIE_AGE);
                getResponse().addCookie(cookie);
            }
            setCurrentUser(user);
            System.out.println("Current location : " + getCurrentLocation());
            if (getCurrentLocation().contains("user_add.jsp")
                || getCurrentLocation().contains("user_signin.jsp")) {
                redirect("user_profile.jsp");
            } else {
                redirectToCurrentLocation();
            }
        }
    }

    private void signOut() {
        User user = getCurrentUser();
        if (user != null) {
            user.setUid(null);
            getUserManager().save(user);
            Cookie cookie = AppUtil.getCookie(getRequest().getCookies(), AppConst.User.COOKIE_NAME);
            if (cookie != null) {
                cookie.setMaxAge(0);
                getResponse().addCookie(cookie);
            }
            getRequest().getSession().removeAttribute(AppConst.User.SESSION_ATTR_USER);
            getRequest().getSession().invalidate();
        }
        redirectToCurrentLocation();
    }

    private void signUp() {
        User user = new User(getCurrentUser());
        user.setEmail(getParameter(AppConst.User.PARA_EMAIL));
        user.setUsername(getParameter(AppConst.User.PARA_USERNAME));
        user.setPassword(getParameter(AppConst.User.PARA_PASSWORD_NEW));
        user.setNameFirst(getParameter(AppConst.User.PARA_NAME_FIRST));
        user.setNameSecond(getParameter(AppConst.User.PARA_NAME_SECOND));
        user.setNameLast(getParameter(AppConst.User.PARA_NAME_LAST));
        user.setContactNo(getParameter(AppConst.User.PARA_CONTACT_NO));
        user.setAvatarName(getAvatarName());
        user.setAddressLine1(getParameter(AppConst.User.PARA_ADDRESS_LINE_1));
        user.setAddressLine2(getParameter(AppConst.User.PARA_ADDRESS_LINE_2));
        user.setAddressLine3(getParameter(AppConst.User.PARA_ADDRESS_LINE_3));
        user.setAddressCity(getParameter(AppConst.User.PARA_ADDRESS_CITY));
        user.setSecurityQuestion(getParameter(AppConst.User.PARA_QUESTION));
        user.setSecurityAnswer(getParameter(AppConst.User.PARA_ANSWER));
        user.setType(getUserType(getParameter(AppConst.User.PARA_USER_TYPE_BUYER), getParameter(
                                 AppConst.User.PARA_USER_TYPE_SELLER)));
        user.setStatus(AppConst.User.USER_STATUS_INACTIVE);
        if (validateParameters(user, false, null)) {
            if (getUserManager().save(user)) {
                System.out.println("User saved !");
                sendCodes(user);
                System.out.println("Saving users codes");
                setCurrentUser(user);
            }
            if (getCurrentLocation() != null) {
                redirectToCurrentLocation();
            } else {
                redirect("user_profile.jsp");
            }
        } else {
            setSessionAttr(AppConst.User.SESSION_ATTR_USER_TEMP, user);
            redirect("user_add.jsp");
        }
    }

    private void updateUser() {
        User user = new User(getCurrentUser());
        user.setEmail(getParameter(AppConst.User.PARA_EMAIL));
        user.setUsername(getParameter(AppConst.User.PARA_USERNAME));
        user.setNameFirst(getParameter(AppConst.User.PARA_NAME_FIRST));
        user.setNameSecond(getParameter(AppConst.User.PARA_NAME_SECOND));
        user.setNameLast(getParameter(AppConst.User.PARA_NAME_LAST));
        user.setContactNo(getParameter(AppConst.User.PARA_CONTACT_NO));
        user.setAvatarName(getAvatarName());
        user.setAddressLine1(getParameter(AppConst.User.PARA_ADDRESS_LINE_1));
        user.setAddressLine2(getParameter(AppConst.User.PARA_ADDRESS_LINE_2));
        user.setAddressLine3(getParameter(AppConst.User.PARA_ADDRESS_LINE_3));
        user.setAddressCity(getParameter(AppConst.User.PARA_ADDRESS_CITY));
        user.setType(getUserType(getParameter(AppConst.User.PARA_USER_TYPE_BUYER),
                                 getParameter(AppConst.User.PARA_USER_TYPE_SELLER)));
        if (validateParameters(user, true, getCurrentUser())) {
            if (getUserManager().save(user)) {
                setCurrentUser(user);
                redirect("user_profile.jsp");
            } else {
                redirect("user_add.jsp?edit=true");
            }
        } else {
            setSessionAttr(AppConst.User.SESSION_ATTR_USER_TEMP, user);
            redirect("user_add.jsp?edit=true");
        }
    }

    private void updatePassword() {
        clearResponseMessage();
        User user = getCurrentUser();
        String password = getParameter(AppConst.User.PARA_PASSWORD);
        String passwordNew = getParameter(AppConst.User.PARA_PASSWORD_NEW);
        String passwordConfirm = getParameter(AppConst.User.PARA_PASSWORD_CONFIRM);
        setResponseStatus(AppUtil.ResponseStatus.ERROR);
        if (user.getPassword().equals(password)) {
            if (passwordNew.equals(passwordConfirm)) {
                if (AppUtil.isPasswordValid(passwordNew)) {
                    user.setPassword(passwordNew);
                    if (getUserManager().save(user)) {
                        setCurrentUser(user);
                        setResponseStatus(AppUtil.ResponseStatus.SUCCESS);
                        addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD,
                                           "Password changed successfully!", null);
                    } else {
                        addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD,
                                           "Error changing password!",
                                           null);
                    }
                } else {
                    addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD, "Invalid password format!",
                                       "Provide a password with min 5 chars and max 15 chars");
                }
            } else {
                addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_PASSWORD, "Mismatching password!", null);
            }
        } else {
            addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_USER, "Invalid password!", null);
        }
        redirect("user_change_security.jsp");
    }

    private void updateSecurityQuestion() {
        clearResponseMessage();
        User user = getCurrentUser();
        String password = getParameter(AppConst.User.PARA_PASSWORD);
        String question = getParameter(AppConst.User.PARA_QUESTION);
        String answer = getParameter(AppConst.User.PARA_ANSWER);
        setResponseStatus(AppUtil.ResponseStatus.ERROR);
        if (user.getPassword().equals(password)) {
            if (!question.equals(AppConst.User.PARA_VAL_UPDATE_SECURITY_QUESTION_DEFAULT)) {
                if (!(answer == null || answer.equalsIgnoreCase("null") || answer.trim().isEmpty())) {
                    user.setSecurityQuestion(question);
                    user.setSecurityAnswer(answer);
                    if (getUserManager().save(user)) {
                        setCurrentUser(user);
                        setResponseStatus(AppUtil.ResponseStatus.SUCCESS);
                        addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION,
                                           "Security question changed successfully!", null);
                    } else {
                        addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION,
                                           "Error changing password!",
                                           null);
                    }
                } else {
                    addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION, "Invalid answer!", null);
                }
            } else {
                addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_QUESTION, "Invalid question!", null);
            }
        } else {
            addResponseMessage(AppConst.User.REQUEST_TYPE_UPDATE_SECURITY_USER, "Invalid password!", null);
        }
        redirect("user_change_security.jsp");
    }

    private String getAvatarName() {
        if (getParameter(AppConst.User.PARA_AVATAR) != null
            && getParameter(AppConst.User.PARA_AVATAR).equals(AppConst.User.PARA_AVATAR_USER)) {
            return getParameter(AppConst.User.PARA_AVATAR_USER_NAME);
        }
        return getParameter(AppConst.User.PARA_AVATAR);
    }

    private String getUserType(String buyer, String seller) {
        if (buyer != null && buyer.equalsIgnoreCase("on")
            && seller != null && seller.equalsIgnoreCase("on")) {
            return AppConst.User.USER_TYPE_BUYER_SELLER;
        } else if (buyer != null && buyer.equalsIgnoreCase("on")) {
            return AppConst.User.USER_TYPE_BUYER;
        } else if (seller != null && seller.equalsIgnoreCase("on")) {
            return AppConst.User.USER_TYPE_SELLER;
        } else {
            return null;
        }
    }

    private boolean validateParameters(User checkedUser, boolean edit, User currentUser) {
        clearResponseMessage();
        if (edit) {
            if (!AppUtil.isEmailValid(checkedUser.getEmail())) {
                addResponseMessage(AppConst.User.PARA_EMAIL, "Invalid email address", null);
            } else if (!checkedUser.getEmail().equals(currentUser.getEmail())
                       && getUserManager().isEmailUsed(checkedUser.getEmail())) {
                addResponseMessage(AppConst.User.PARA_EMAIL, "Email address is used",
                                   "This email is already used by another user");
            }
            if (!AppUtil.isUsernameValid(checkedUser.getUsername())) {
                addResponseMessage(AppConst.User.PARA_USERNAME, "Invalid username",
                                   "Username should be atleast 5 characters long and unused by other users");
            } else if (!checkedUser.getUsername().equals(currentUser.getUsername())
                       && getUserManager().isUsernameUsed(checkedUser.getUsername())) {
                addResponseMessage(AppConst.User.PARA_USERNAME, "Username is used",
                                   "This username is already used by another user");
            }
            if (checkedUser.getType() == null) {
                addResponseMessage(AppConst.User.PARA_USER_TYPE, "Invalid type", "Select atleast one of the user types");
            }
        } else {
            if (!AppUtil.isEmailValid(checkedUser.getEmail())) {
                addResponseMessage(AppConst.User.PARA_EMAIL, "Invalid email address", null);
            } else if (getUserManager().isEmailUsed(checkedUser.getEmail())) {
                addResponseMessage(AppConst.User.PARA_EMAIL, "Email address is used",
                                   "This email is already used by another user");
            }
            if (!AppUtil.isUsernameValid(checkedUser.getUsername())) {
                addResponseMessage(AppConst.User.PARA_USERNAME, "Invalid username",
                                   "Username should be atleast 5 characters long and unused by other users");
            } else if (getUserManager().isUsernameUsed(checkedUser.getUsername())) {
                addResponseMessage(AppConst.User.PARA_USERNAME, "Username is used",
                                   "This username is already used by another user");
            }
            String passwordNew = getParameter(AppConst.User.PARA_PASSWORD_NEW);
            String passwordConfirm = getParameter(AppConst.User.PARA_PASSWORD_CONFIRM);
            if (!AppUtil.isPasswordValid(passwordNew)) {
                addResponseMessage(AppConst.User.PARA_PASSWORD_NEW, "Invalid password",
                                   "Password should be atleast 5 characters long");
            } else if (passwordConfirm == null || passwordConfirm.trim().isEmpty() || !passwordNew.equals(
                    passwordConfirm)) {
                addResponseMessage(AppConst.User.PARA_PASSWORD_CONFIRM, "Passwords do not match", null);
            }
            if (checkedUser.getType() == null) {
                addResponseMessage(AppConst.User.PARA_USER_TYPE, "Invalid type", "Select atleast one of the user types");
            }
            if (checkedUser.getSecurityQuestion() == null
                || checkedUser.getSecurityQuestion().trim().isEmpty()
                || checkedUser.getSecurityQuestion().equalsIgnoreCase(AppConst.User.PARA_VAL_SECURITY_QUESTION_DEFAULT)
                || SecurityQuestionManager.getInstance(getRequest()).getSecurityQuestion(
                            checkedUser.getSecurityQuestion()) == null) {
                System.out.println("Invalid Q found");
                addResponseMessage(AppConst.User.PARA_QUESTION, "Invalid security question",
                                   "Select a security question from the list");
            } else if (checkedUser.getSecurityAnswer() == null
                       || checkedUser.getSecurityAnswer().trim().isEmpty()) {
                addResponseMessage(AppConst.User.PARA_ANSWER, "Invalid security answer",
                                   "Enter a memorable answer for the above question");
            }
        }
        if (!getResponseMessage().isEmpty()) {
            System.out.println("Error Response Message");
            setResponseStatus(AppUtil.ResponseStatus.ERROR);
            return false;
        }
        return true;
    }

    private void sendCodes(User user) {
        String code;
        if (user.getContactNoCode() == null) {
            code = AppUtil.generateCode();
            AppUtil.sendMessage(user.getContactNo(), code);
            user.setContactNoCode(code);
        }
        if (user.getEmailCode() == null) {
            code = AppUtil.generateCode();
            if (user.getUid() == null || user.getUidAge() > AppConst.User.MAX_UID_AGE) {
                user.setUid(AppUtil.generateUID(user));
            }
            AppUtil.sendEmail(user.getEmail(), user.getUid());
            user.setEmailCode(code);
        }
        getUserManager().save(user);
    }

    private void activateUserContactNo() {
        User user = getCurrentUser();
        if (user != null && user.getContactNoCode().equals(getParameter(AppConst.User.PARA_CONTACT_NO_CODE))) {
            user.setContactNoCode(null);
            if (user.getEmailCode() == null) {
                user.setStatus(AppConst.User.USER_STATUS_ACTIVE);
            }
            getUserManager().save(user);
        }
        redirectToCurrentLocation();
    }

    private void activateUserEmail() {
        User user = getUserManager().get(getParameter(AppConst.User.PARA_UID));
        if (user != null && user.getEmailCode().equals(getParameter(AppConst.User.PARA_EMAIL_CODE))) {
            user.setEmailCode(null);
            if (user.getContactNoCode() == null) {
                user.setStatus(AppConst.User.USER_STATUS_ACTIVE);
            }
            getUserManager().save(user);
        }
    }

    private void clearUsers() {
        getUserManager().clearUsers();
        System.gc();
        write("All database entries cleared !, Do redeploy...");
    }

    private void saveMessage() {
        String userToUid = getParameter(AppConst.User.PARA_MESSAGE_TO_USER_UID);
        String itemUid = getParameter(AppConst.User.PARA_MESSAGE_ITEM_UID);
        String subject = getParameter(AppConst.User.PARA_MESSAGE_SUBJECT);
        String text = getParameter(AppConst.User.PARA_MESSAGE_TEXT);
        User userFrom = getCurrentUser();
        MessageManager manager = getMessageManager();
        if (userToUid == null || itemUid == null) {
            User[] admins = getUserManager().getAdmins();
            for (User admin : admins) {
                Message message = new Message();
                message.setUserFrom(userFrom);
                message.setUserTo(admin);
                message.setText(text);
                manager.save(message);
            }
        } else {
            Item item = getItemManager().get(itemUid);
            User userTo = getUserManager().get(userToUid);
            AppUtil.ConstType type = AppUtil.ConstType.MESSAGE_SUBJECT_BUYERS;
            if (item.getSeller().getId() == userFrom.getId()) {
                type = AppUtil.ConstType.MESSAGE_SUBJECT_SELLERS;
            }
            Message message = new Message();
            message.setUserFrom(getCurrentUser());
            message.setUserTo(userTo);
            message.setText(text);
            message.setSubject(manager.getSubject(subject, type));
            message.setReferencedItem(item);
            manager.save(message);
        }
        redirectToCurrentLocation();
    }

    private void setMessageRead() {
        String msgId = getParameter(AppConst.User.PARA_MESSAGE_ID);
        System.out.println("Setting message as read : " + msgId);
        getMessageManager().setAsRead(Integer.parseInt(msgId));
        reloadCurrentUser();
        write(AppConst.User.STATUS_MESSAGE_SAVE_SUCCESS);
    }

    @SuppressWarnings("unchecked")
    private void checkNewMessages() {
        System.out.println("Cheking messages : " + getRequest().getLocalName() + " (" + getRequest().getLocalName() + ")");
        Message[] messages = getMessageManager().getNewMessages(getCurrentUser());
        if (messages == null || messages.length == 0 || (messages.length == 1 && messages[0] == null)) {
            write(AppConst.Message.STATUS_NO_NEW_MESSAGES);
            System.out.println("No new messages");
            return;
        }
        JSONArray messageArray = new JSONArray();
        for (Message message : messages) {
            JSONObject msg = new JSONObject();
            msg.put("subject", message.getSubject().getName());
            msg.put("text", message.getText());
            messageArray.add(msg);
        }
        write(messageArray.toJSONString());
        System.out.println("New Messages : " + messageArray.toJSONString());
        reloadCurrentUser();
    }

    @SuppressWarnings("unchecked")
    private void deleteMessages() {
        try {
            JSONArray msgIds = (JSONArray) new JSONParser().parse(getParameter(AppConst.Message.PARA_MESSAGE_IDS));
            HashSet<String> ids = new HashSet<>(msgIds.size());
            ids.addAll(msgIds);
            for (String id : ids) {
                getMessageManager().delete(Integer.parseInt(id));
            }
            reloadCurrentUser();
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }
}
