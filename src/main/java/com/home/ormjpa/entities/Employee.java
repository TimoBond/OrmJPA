package com.home.ormjpa.entities;

import jakarta.persistence.*;

import java.io.Serializable;
import java.util.*;

@Entity
@SecondaryTables({@SecondaryTable(name = "staff_advanced")})
@Table(name = "staff")
public class Employee implements Serializable {
    @EmbeddedId
    private StaffID staffID;
    private String name;
    private String surname;
    @Embedded
    private Address address;
    @ElementCollection
    @MapKeyColumn(name = "name")
    @CollectionTable(name = "hobbies")
    private Map<String, Hobby> hobbies = new HashMap<>();
    @CollectionTable(name = "documents")
    @ElementCollection
    private Set<Document> documents = new HashSet<>();
    @ElementCollection
    @CollectionTable(name = "phones")
    private List<String> phones = new ArrayList<>();
    @Lob
    @Basic(fetch = FetchType.LAZY) // ленивая загрузка этого поля в базу даных
    private byte[] photo;
    @Lob
    @Column(name = "video", table = "staff_advanced")
    private byte[] video;
    @Transient
    private String file;
    @Transient
    private String image64 = "iam65";
    @Transient
    private String photoFile;
    @Temporal(TemporalType.DATE)
    private Date date;

    public Employee() {
    }

    public Employee(StaffID staffID, String name, String surname, Address address, Map<String, Hobby> hobbies, Set<Document> documents, List<String> phones,
                    byte[] photo, byte[] video, Date date) {
        this.staffID = staffID;
        this.name = name;
        this.surname = surname;
        this.address = address;
        this.phones = phones;
        this.photo = photo;
        this.video = video;
        this.date = date;
        this.documents = documents;
        this.hobbies = hobbies;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSurname() {
        return surname;
    }

    public void setSurname(String surname) {
        this.surname = surname;
    }

    public void setPhoto(byte[] photo) {
        this.photo = photo;
    }

    public byte[] getPhoto() {
        return photo;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public byte[] getVideo() {
        return video;
    }

    public void setVideo(byte[] video) {
        this.video = video;
    }

    public List<String> getPhones() {
        return phones;
    }

    public void setPhones(List<String> phones) {
        this.phones = phones;
    }

    public void setPhone(String phone) {
        if (!phones.contains(phone)) {
            phones.add(phone);
        }
    }

    public StaffID getStaffID() {
        return staffID;
    }

    public void setStaffID(StaffID staffID) {
        this.staffID = staffID;
    }

    public Map<String, Hobby> getHobbies() {
        return hobbies;
    }

    public void setHobbies(Map<String, Hobby> hobbies) {
        this.hobbies = hobbies;
    }


    public void setHobby(Hobby hobby) {
        System.out.println("v hobby ");
        if (hobby != null && hobby.getTitle() != null && hobby.getExperience() != 0) {
            hobbies.put(hobby.getTitle(), hobby);

            for (Map.Entry<String, Hobby> hobbyHM : hobbies.entrySet()) {
                System.out.println(hobbyHM.getKey() + " " + hobbyHM.getValue().getTitle() + " " + hobbyHM.getValue().getExperience());
            }
        }
    }

    public void setDeleteHobbies(String key){
        StringTokenizer stringTokenizer = new StringTokenizer(key,"[], ");
        while (stringTokenizer.hasMoreTokens()){
            hobbies.remove(stringTokenizer.nextToken());
        }
    }

    public Set<Document> getDocuments() {
        return documents;
    }

    public void setDocument(Document document) {
        if (document != null && document.getTitle() != null && document.getNumber() != 0 && !document.getTitle().equals("")) {
            documents.add(document.clone());
        }
    }

    public void setDeleteDoc(String numbers) {
        StringTokenizer stringTokenizer = new StringTokenizer(numbers, "[], ");
        System.out.println("delete doc");
        while (stringTokenizer.hasMoreTokens()) {
            int a = Integer.parseInt(stringTokenizer.nextToken());
            documents.removeIf(document -> document.getNumber() == a);

        }
    }
    public void setUpdateDoc(Document document){

    }

    public void setDocuments(Set<Document> documents) {
        this.documents = documents;
    }

    public String getImage64() {
        return image64;
    }

    public void setImage64(String image64) {
        this.image64 = image64;
    }

    public String getPhotoFile() {
        return photoFile;
    }

    public void setPhotoFile(String photoFile) {
        this.photoFile = photoFile;
    }

    public String getFile() {
        return file;
    }

    public void setFile(String file) {
        this.file = file;
    }

    @Override
    public int hashCode() {
        int a = 7;
        a = 7 * a + staffID.hashCode();
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
        if (!(obj instanceof Employee)) {
            return false;
        }
        Employee employee = (Employee) obj;
        return employee.staffID.equals(this.staffID);
    }
}
