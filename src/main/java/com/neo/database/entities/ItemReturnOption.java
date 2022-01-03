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
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * ItemReturnOption generated by hbm2java
 */
@Entity
@Table(name = "item_return_option", catalog = "project_ecommerce"
)
public class ItemReturnOption implements java.io.Serializable {

    private Integer itemReturnOptionId;
    private ReturnOption returnOption;
    private String description;
    private String timeLimit;
    private Set<Item> items = new HashSet<Item>(0);

    public ItemReturnOption() {
    }

    public ItemReturnOption(ReturnOption returnOption) {
        this.returnOption = returnOption;
    }

    public ItemReturnOption(ReturnOption returnOption, String description, String timeLimit, Set<Item> items) {
        this.returnOption = returnOption;
        this.description = description;
        this.timeLimit = timeLimit;
        this.items = items;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "item_return_option_id", unique = true, nullable = false)
    public Integer getItemReturnOptionId() {
        return this.itemReturnOptionId;
    }

    public void setItemReturnOptionId(Integer itemReturnOptionId) {
        this.itemReturnOptionId = itemReturnOptionId;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "return_option_id", nullable = false)
    public ReturnOption getReturnOption() {
        return this.returnOption;
    }

    public void setReturnOption(ReturnOption returnOption) {
        this.returnOption = returnOption;
    }

    @Column(name = "description")
    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "time_limit", length = 45)
    public String getTimeLimit() {
        return this.timeLimit;
    }

    public void setTimeLimit(String timeLimit) {
        this.timeLimit = timeLimit;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "itemReturnOption")
    public Set<Item> getItems() {
        return this.items;
    }

    public void setItems(Set<Item> items) {
        this.items = items;
    }

}
