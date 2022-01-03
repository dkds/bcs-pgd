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
 * ReturnOption generated by hbm2java
 */
@Entity
@Table(name = "return_option", catalog = "project_ecommerce"
)
public class ReturnOption implements java.io.Serializable {

    private Integer returnOptionId;
    private String name;
    private Set<ItemReturnOption> itemReturnOptions = new HashSet<ItemReturnOption>(0);

    public ReturnOption() {
    }

    public ReturnOption(String name, Set<ItemReturnOption> itemReturnOptions) {
        this.name = name;
        this.itemReturnOptions = itemReturnOptions;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "return_option_id", unique = true, nullable = false)
    public Integer getReturnOptionId() {
        return this.returnOptionId;
    }

    public void setReturnOptionId(Integer returnOptionId) {
        this.returnOptionId = returnOptionId;
    }

    @Column(name = "name", length = 100)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "returnOption")
    public Set<ItemReturnOption> getItemReturnOptions() {
        return this.itemReturnOptions;
    }

    public void setItemReturnOptions(Set<ItemReturnOption> itemReturnOptions) {
        this.itemReturnOptions = itemReturnOptions;
    }

}
