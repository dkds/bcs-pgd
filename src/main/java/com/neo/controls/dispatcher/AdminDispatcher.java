/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls.dispatcher;

import com.neo.beans.admin.Image;
import com.neo.beans.item.Item;
import com.neo.beans.user.User;
import com.neo.controls.AppPropertyManager;
import com.neo.controls.SecurityQuestionManager;
import com.neo.util.AppConst;
import com.neo.util.AppPropertyContainer;
import com.neo.util.AppUtil;
import java.util.ArrayList;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

/**
 *
 * @author neo
 */
public class AdminDispatcher extends Dispatcher {

    private static volatile AdminDispatcher adminDispatcher;

    public static AdminDispatcher getInstance(HttpServletRequest request, HttpServletResponse response) {
        if (adminDispatcher == null) {
            adminDispatcher = new AdminDispatcher();
        }
        adminDispatcher.setRequest(request);
        adminDispatcher.setResponse(response);
        return adminDispatcher;
    }

    private AdminDispatcher() {
    }

    @Override
    public void dispatchGet() {
    }

    @Override
    public void dispatchPost() {
        switch (getRequestType()) {
            case AppConst.Admin.REQUEST_TYPE_ITEM_VIEW_COUNTER:
                countItemView();
                break;
            case AppConst.Admin.REQUEST_TYPE_SEARCH_USERS:
                searchUsers();
                break;
            case AppConst.Admin.REQUEST_TYPE_SEARCH_ITEMS:
                searchItems();
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
            case AppConst.Admin.REQUEST_TYPE_APP_PROPERTIES:
                saveAppProperties();
                break;
            default:
                throw new AssertionError();
        }
    }

    private void countItemView() {
        String type = getParameter(AppConst.Admin.PARA_ITEM_VIEW);
        boolean enter = false;
        if (type != null && type.equals(AppConst.Admin.PARA_VAL_ITEM_VIEW_ENTER)) {
            enter = true;
        }
        if (enter) {
            AppUtil.setItemViewerCount(AppUtil.getItemViewerCount() + 1);
        } else {
            AppUtil.setItemViewerCount(AppUtil.getItemViewerCount() - 1);
        }
    }

    @SuppressWarnings("unchecked")
    private void searchUsers() {
        String searchText = getParameter(AppConst.Admin.PARA_SEARCH_TEXT);
        User[] users = getUserManager().getUsers(searchText);
        JSONArray userArray = new JSONArray();
        for (User user : users) {
            if (user != null) {
                JSONObject userObject = new JSONObject();
                userObject.put("uid", user.getUid());
                userObject.put("email", user.getEmail());
                userObject.put("regDate", user.getCreateTimeFormatted());
                userObject.put("type", user.getType());
                userObject.put("showData", !(user.isAdmin() || user.isGuest()));
                userArray.add(userObject);
            }
        }
        write(userArray.toJSONString());
    }

    private void updateUser() {
        User originalUser = getUserManager().get(getParameter(AppConst.Admin.PARA_USER_UID));
        User user = new User(originalUser);
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
        if (validateParameters(user, true, originalUser)) {
            if (getUserManager().save(user)) {
                redirect("user_profile.jsp?" + AppConst.User.PARA_UID + "=" + user.getUid());
            } else {
                redirect("user_add.jsp?edit=true&" + AppConst.User.PARA_UID + "=" + user.getUid());
            }
        } else {
            setSessionAttr(AppConst.User.SESSION_ATTR_USER_TEMP, user);
            redirect("user_add.jsp?edit=true&" + AppConst.User.PARA_UID + "=" + user.getUid());
        }
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

    private void updateSecurityQuestion() {
        clearResponseMessage();
        User user = getUserManager().get(getParameter(AppConst.Admin.PARA_USER_UID));
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
        redirect("user_change_security.jsp?" + AppConst.User.PARA_UID + "=" + user.getUid());
    }

    private void updatePassword() {
        clearResponseMessage();
        User user = getUserManager().get(getParameter(AppConst.Admin.PARA_USER_UID));
        String password = getParameter(AppConst.User.PARA_PASSWORD);
        String passwordNew = getParameter(AppConst.User.PARA_PASSWORD_NEW);
        String passwordConfirm = getParameter(AppConst.User.PARA_PASSWORD_CONFIRM);
        setResponseStatus(AppUtil.ResponseStatus.ERROR);
        if (user.getPassword().equals(password)) {
            if (passwordNew.equals(passwordConfirm)) {
                if (AppUtil.isPasswordValid(passwordNew)) {
                    user.setPassword(passwordNew);
                    if (getUserManager().save(user)) {
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
        redirect("user_change_security.jsp?" + AppConst.User.PARA_UID + "=" + user.getUid());
    }

    private void saveAppProperties() {
        AppPropertyContainer container = (AppPropertyContainer) getRequest().getServletContext().getAttribute(
                AppConst.Admin.CONTEXT_ATTR_APP_PROPERTIES);
        container.setProperty(AppConst.Admin.PARA_ABOUT_US_DESCRIPTION,
                              getParameter(AppConst.Admin.PARA_ABOUT_US_DESCRIPTION));
        container.setProperty(AppConst.Admin.PARA_ABOUT_US_ADDRESS,
                              getParameter(AppConst.Admin.PARA_ABOUT_US_ADDRESS));
        container.setProperty(AppConst.Admin.PARA_ABOUT_US_START_YEAR,
                              getParameter(AppConst.Admin.PARA_ABOUT_US_START_YEAR));
        container.setProperty(AppConst.Admin.PARA_ABOUT_US_EMPLOYEE_COUNT,
                              getParameter(AppConst.Admin.PARA_ABOUT_US_EMPLOYEE_COUNT));
        container.setProperty(AppConst.Admin.PARA_ABOUT_US_COMPANY_VISION,
                              getParameter(AppConst.Admin.PARA_ABOUT_US_COMPANY_VISION));
        container.setProperty(AppConst.Admin.PARA_COPYRIGHT_TEXT,
                              getParameter(AppConst.Admin.PARA_COPYRIGHT_TEXT));
        container.setProperty(AppConst.Admin.PARA_PRIVACY_POLICY,
                              getParameter(AppConst.Admin.PARA_PRIVACY_POLICY));
        container.setProperty(AppConst.Admin.PARA_TERMS_AND_CONDITIONS,
                              getParameter(AppConst.Admin.PARA_TERMS_AND_CONDITIONS));
        AppPropertyManager manager = AppPropertyManager.getInstance(getRequest());
        manager.save(container);
        saveImages();
        container.setImages(manager.getImages());
        getRequest().getServletContext().setAttribute(AppConst.Admin.CONTEXT_ATTR_APP_PROPERTIES, manager.getAppProperties());
        redirectToCurrentLocation();
    }

    private void saveImages() {
        ArrayList<Image> images = new ArrayList<>(8);
        int imgCount = 0;
        String[] ordinals = getParameters(AppConst.Admin.PARA_IMAGE_ORDINAL);
        String[] imgs = getParameters(AppConst.Item.PARA_IMAGE_NAME);
        if (ordinals != null && imgs != null) {
            for (String imageName : imgs) {
                System.out.println("Image : " + imageName);
                if (imageName != null && !imageName.trim().isEmpty()) {
                    images.add(new Image(imageName, Integer.parseInt(ordinals[imgCount])));
                    imgCount++;
                }
            }
            AppPropertyManager.getInstance(getRequest()).save(images.toArray(new Image[images.size()]));
        }
    }

    @SuppressWarnings("unchecked")
    private void searchItems() {
        String searchText = getParameter(AppConst.Admin.PARA_SEARCH_TEXT);
        Item[] items = getItemManager().getItems(searchText);
        JSONArray userArray = new JSONArray();
        for (Item item : items) {
            if (item != null) {
                JSONObject userObject = new JSONObject();
                userObject.put("uid", item.getUid());
                userObject.put("name", item.getName());
                userObject.put("regDate", item.getCreateTimeFormatted());
                userObject.put("price", item.getUnitpriceFormatted());
                userArray.add(userObject);
            }
        }
        write(userArray.toJSONString());
    }

}
