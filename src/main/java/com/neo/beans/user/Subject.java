/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.neo.beans.user;

import java.io.Serializable;
import java.util.Objects;

/**
 *
 * @author neo
 */
public class Subject implements Serializable {

    private String name;
    private SubjectType subjectType;

    public Subject() {
    }

    public Subject(String name, SubjectType subjectType) {
        this.name = name;
        this.subjectType = subjectType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public SubjectType getSubjectType() {
        return subjectType;
    }

    public void setSubjectType(SubjectType subjectType) {
        this.subjectType = subjectType;
    }

    @Override
    public boolean equals(Object obj) {
        return obj instanceof Subject && obj.hashCode() == hashCode();
    }

    @Override
    public int hashCode() {
        int hash = 3;
        hash = 79 * hash + Objects.hashCode(this.name);
        hash = 79 * hash + Objects.hashCode(this.subjectType);
        return hash;
    }

    public enum SubjectType {

        ADMIN, BUYER, SELLER, TO_ADMIN;

        @Override
        public String toString() {
            return name().toLowerCase();
        }

    }
}
