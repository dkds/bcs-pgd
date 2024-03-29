package com.neo.database.entities;
// Generated May 9, 2015 3:13:15 PM by Hibernate Tools 4.3.1

import java.math.BigDecimal;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import static javax.persistence.GenerationType.IDENTITY;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * Commission generated by hbm2java
 */
@Entity
@Table(name = "commission", catalog = "project_ecommerce"
)
public class Commission implements java.io.Serializable {

    private Integer commissionId;
    private BigDecimal priceLimitFrom;
    private BigDecimal priceLimitTo;
    private BigDecimal persentage;

    public Commission() {
    }

    public Commission(BigDecimal priceLimitFrom, BigDecimal priceLimitTo, BigDecimal persentage) {
        this.priceLimitFrom = priceLimitFrom;
        this.priceLimitTo = priceLimitTo;
        this.persentage = persentage;
    }

    @Id
    @GeneratedValue(strategy = IDENTITY)

    @Column(name = "commission_id", unique = true, nullable = false)
    public Integer getCommissionId() {
        return this.commissionId;
    }

    public void setCommissionId(Integer commissionId) {
        this.commissionId = commissionId;
    }

    @Column(name = "price_limit_from", precision = 10)
    public BigDecimal getPriceLimitFrom() {
        return this.priceLimitFrom;
    }

    public void setPriceLimitFrom(BigDecimal priceLimitFrom) {
        this.priceLimitFrom = priceLimitFrom;
    }

    @Column(name = "price_limit_to", precision = 10)
    public BigDecimal getPriceLimitTo() {
        return this.priceLimitTo;
    }

    public void setPriceLimitTo(BigDecimal priceLimitTo) {
        this.priceLimitTo = priceLimitTo;
    }

    @Column(name = "persentage", precision = 4)
    public BigDecimal getPersentage() {
        return this.persentage;
    }

    public void setPersentage(BigDecimal persentage) {
        this.persentage = persentage;
    }

}
