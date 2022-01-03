/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.controls;

import com.neo.beans.user.User;
import com.neo.database.controls.Connector;
import com.neo.database.entities.City;
import com.neo.util.AppConst;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Restrictions;

/**
 *
 * @author neo
 */
public final class LocationManager extends Connector {

    public static LocationManager getInstance(HttpServletRequest request) {
        ServletContext context = request.getServletContext();
        LocationManager locationManager = (LocationManager) context.getAttribute(
                AppConst.Application.CONTEXT_ATTR_LOCATION_MANAGER);
        if (locationManager == null) {
            locationManager = new LocationManager(context);
            context.setAttribute(AppConst.Application.CONTEXT_ATTR_LOCATION_MANAGER, locationManager);
        }
        locationManager.setRequest(request);
        return locationManager;
    }

    private LocationManager(ServletContext context) {
        super(context);
    }

    public City getUserCity(User user) {
        City city = null;
        if (user.getAddressCity() == null || !user.getAddressCity().equals(AppConst.User.PARA_VAL_CITY_DEFAULT)) {
            city = get(user.getAddressCity());
        }
        return city;
    }

    public City get(String name) {
        return (City) get(City.class, Restrictions.eq("name", name))[0];
    }

    public String[] get() {
        @SuppressWarnings("unchecked")
        City[] array = (City[]) get(City.class, (Criterion[]) null);
        String[] cities = new String[array.length];
        for (int i = 0; i < array.length; i++) {
            cities[i] = array[i].getName();
        }
        return cities;
    }

    public City getItemCity(String location) {
        City city = null;
        if (location == null || !location.equals(AppConst.Item.PARA_VAL_CITY_DEFAULT)) {
            city = get(location);
        }
        return city;
    }

}
