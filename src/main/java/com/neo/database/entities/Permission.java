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
 * Permission generated by hbm2java
 */
@Entity
@Table(name = "permission", catalog = "project_ecommerce"
)
public class Permission implements java.io.Serializable {

    private Integer permissionId;
    private String name;
    private Set<UserPermission> userPermissions = new HashSet<UserPermission>(0);

    public Permission() {
    }

    public Permission(String name, Set<UserPermission> userPermissions) {
        this.name = name;
        this.userPermissions = userPermissions;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "permission_id", unique = true, nullable = false)
    public Integer getPermissionId() {
        return this.permissionId;
    }

    public void setPermissionId(Integer permissionId) {
        this.permissionId = permissionId;
    }

    @Column(name = "name", length = 45)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "permission")
    public Set<UserPermission> getUserPermissions() {
        return this.userPermissions;
    }

    public void setUserPermissions(Set<UserPermission> userPermissions) {
        this.userPermissions = userPermissions;
    }

}