package com.neo.database.entities;
// Generated May 9, 2015 3:13:15 PM by Hibernate Tools 4.3.1

import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * UserType generated by hbm2java
 */
@Entity
@Table(name = "user_type", catalog = "project_ecommerce"
)
public class UserType implements java.io.Serializable {

    private Integer userTypeId;
    private String name;
    private Set<User> users = new HashSet<User>(0);
    private Set<UserPermission> userPermissions = new HashSet<UserPermission>(0);

    public UserType() {
    }

    public UserType(String name, Set<User> users, Set<UserPermission> userPermissions) {
        this.name = name;
        this.users = users;
        this.userPermissions = userPermissions;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "user_type_id", unique = true, nullable = false)
    public Integer getUserTypeId() {
        return this.userTypeId;
    }

    public void setUserTypeId(Integer userTypeId) {
        this.userTypeId = userTypeId;
    }

    @Column(name = "name", length = 45)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "userType")
    public Set<User> getUsers() {
        return this.users;
    }

    public void setUsers(Set<User> users) {
        this.users = users;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "userType")
    public Set<UserPermission> getUserPermissions() {
        return this.userPermissions;
    }

    public void setUserPermissions(Set<UserPermission> userPermissions) {
        this.userPermissions = userPermissions;
    }

}
