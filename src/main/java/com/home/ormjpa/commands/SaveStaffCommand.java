package com.home.ormjpa.commands;

import com.home.ormjpa.entities.Document;
import com.home.ormjpa.entities.Employee;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class SaveStaffCommand implements Command {
    @Override
    public String execute(HttpServletRequest request) {
        EntityManagerFactory entityManagerFactory = (EntityManagerFactory) request.getServletContext().getAttribute("Factory");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        HttpSession httpSession = request.getSession();
        Employee employee = (Employee) httpSession.getAttribute("employee");
        try {
            if(employee.getPhotoFile() != null) {
                employee.setPhoto(Files.readAllBytes(Path.of(request.getServletContext().getRealPath("") + File.separator + "images" + File.separator + employee.getPhotoFile())));
            }
//            for (Document document: employee.getDocuments()){
//                System.out.println("document number =" + document.getNumber());
//                System.out.println("document picture name =" + document.getPictureName());
//            }
            for (Document document: employee.getDocuments()) {

                document.setPicture(Files.readAllBytes(Path.of(request.getServletContext().getRealPath("")+ File.separator + "images" + File.separator+document.getNumber()+".jpg")));
                System.out.println(document.getPicture().length + " length");
            }

        } catch (IOException ioException) {
            ioException.printStackTrace();
        }

        EntityTransaction entityTransaction = entityManager.getTransaction();
        entityTransaction.begin();
        entityManager.persist(employee);
        entityTransaction.commit();
        entityManager.close();
        return "ollStaff.jsp";
    }
}
