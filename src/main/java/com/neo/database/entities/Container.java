package com.neo.database.entities;
// Generated May 9, 2015 3:13:15 PM by Hibernate Tools 4.3.1

import java.math.BigDecimal;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Container generated by hbm2java
 */
@Entity
@Table(name = "container", catalog = "project_ecommerce"
)
public class Container implements java.io.Serializable {

    private Integer containerId;
    private ContainerType containerType;
    private User user;
    private Integer totalQty;
    private BigDecimal totalAmount;
    private Set<ContainerItem> containerItems = new HashSet<ContainerItem>(0);

    public Container() {
    }

    public Container(ContainerType containerType, User user) {
        this.containerType = containerType;
        this.user = user;
    }

    public Container(ContainerType containerType, User user, Integer totalQty, BigDecimal totalAmount, Set<ContainerItem> containerItems) {
        this.containerType = containerType;
        this.user = user;
        this.totalQty = totalQty;
        this.totalAmount = totalAmount;
        this.containerItems = containerItems;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "container_id", unique = true, nullable = false)
    public Integer getContainerId() {
        return this.containerId;
    }

    public void setContainerId(Integer containerId) {
        this.containerId = containerId;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "container_type_id", nullable = false)
    public ContainerType getContainerType() {
        return this.containerType;
    }

    public void setContainerType(ContainerType containerType) {
        this.containerType = containerType;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id", nullable = false)
    public User getUser() {
        return this.user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Column(name = "total_qty")
    public Integer getTotalQty() {
        return this.totalQty;
    }

    public void setTotalQty(Integer totalQty) {
        this.totalQty = totalQty;
    }

    @Column(name = "total_amount", precision = 10)
    public BigDecimal getTotalAmount() {
        return this.totalAmount;
    }

    public void setTotalAmount(BigDecimal totalAmount) {
        this.totalAmount = totalAmount;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "container")
    public Set<ContainerItem> getContainerItems() {
        return this.containerItems;
    }

    public void setContainerItems(Set<ContainerItem> containerItems) {
        this.containerItems = containerItems;
    }

}