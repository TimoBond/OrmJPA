package com.home.ormjpa.entities;

import jakarta.persistence.*;

import java.io.Serializable;

@Embeddable
public class Document implements Serializable, Cloneable {
    private String title;
    @Column(name = "number_document")
    private int number;


    @Basic(fetch = FetchType.EAGER)
    private byte[] picture;
    @Transient
    private String pictureName;

    public Document() {
    }

    public Document(String title, int number, byte[] picture) {
        this.number = number;
        this.picture = picture;
        this.title = title;
    }

    public Document(String title, int number) {
        this.number = number;
        this.title = title;
    }

    public String getPictureName() {
        return pictureName;
    }

    public void setPictureName(String pictureName) {
        System.out.println("v pictureName " + pictureName);
        this.pictureName = pictureName;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        System.out.println("title " + title);
        this.title = title;
    }

    public int getNumber() {
        return number;
    }

    public void setNumber(int number) {
        System.out.println("number" + number);
        this.number = number;

            pictureName = number+".jpg";
            System.out.println("numb pictureName =" + pictureName);

    }

    public void setUpNumber(int number) {

    }

    public byte[] getPicture() {
        return picture;
    }

    public void setUpdate(Document document) {
        this.number = document.number;
        this.title = document.title;
        this.picture = document.picture;
    }

    public void setPicture(byte[] picture) {
        this.picture = picture;
    }

    @Override
    public Document clone() {
        return new Document(title, number);
    }

    @Override
    public int hashCode() {
        int a = 7;
        a = 7 * a + number;
        a = 7 * a + title.hashCode();
        return a;
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null) {
            return false;
        }
        if (obj == this) {
            return true;
        }
        if (!(obj instanceof Document)) {
            return false;
        }
        Document d = (Document) obj;
        return d.number == this.number && d.title.equals(this.title);
    }
}
