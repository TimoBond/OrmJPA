package com.home.ormjpa.entities;

import jakarta.persistence.Embeddable;

import java.io.Serializable;
@Embeddable
public class StaffID implements Serializable {
private Integer number;
private String dept;
public StaffID(){}
    public StaffID(Integer number, String dept){
    this.number = number;
    this.dept = dept;
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == null){
            return false;
        }if(obj == this){
            return true;
        }if(!(obj instanceof StaffID) ){
            return false;
        }
        StaffID o = (StaffID) obj;
        return (o.number.equals(this.number) && o.dept.equals(this.dept));
    }

    @Override
    public int hashCode() {
        int a = 7;
        a = 7 * a + number.hashCode();
        a = 7 * a + dept.hashCode();
        return a;

    }
}
