/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.servlets;

import com.neo.controls.dispatcher.ImageDispatcher;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author neo
 */
@WebServlet(name = "SerImgMng", urlPatterns = {"/SerImgMng"})
public class SerImgMng extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        ImageDispatcher.getInstance(request, response).dispatchGet();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        ImageDispatcher.getInstance(request, response).dispatchPost();
    }
}
