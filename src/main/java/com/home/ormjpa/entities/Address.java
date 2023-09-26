package com.home.ormjpa.entities;

import jakarta.persistence.Embeddable;

import java.io.Serializable;
@Embeddable
public class Address implements Serializable {
private String country;
private String city;
private String street;
private int zipCode;
public Address(){}
public Address(String country, String city, String street, int zipCode){
    this.city = city;
    this.country = country;
    this.street = street;
    this.zipCode = zipCode;
}
    public int getZipCode() {
        return zipCode;
    }

    public void setZipCode(int zipCode) {
        this.zipCode = zipCode;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }


}
