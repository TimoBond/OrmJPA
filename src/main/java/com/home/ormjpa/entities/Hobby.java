package com.home.ormjpa.entities;

import jakarta.persistence.Embeddable;
import jakarta.persistence.Embedded;

import java.io.Serializable;
@Embeddable
public class Hobby implements Serializable {
    private String title;
    private int experience;

    public Hobby(){};
    public Hobby(String title, int experience){
        this.experience = experience;
        this.title = title;
    };

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getExperience() {
        return experience;
    }

    public void setExperience(int experience) {
        this.experience = experience;
    }



    @Override
    public int hashCode() {
        int a = 7;
        a = 7 * a + title.hashCode();
        a = 7 * a + experience;
        return a;
    }

    @Override
    public boolean equals(Object obj) {
        if(obj == null){
            return false;
        }if(obj == this){
            return true;
        }if(!(obj instanceof Hobby)){
            return false;
        }
        Hobby h = (Hobby) obj;
        return (h.experience == this.experience && h.title.equals(this.title));
    }
}
