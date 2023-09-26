package com.home.ormjpa.commands;

import com.home.ormjpa.entities.Document;
import com.home.ormjpa.entities.Employee;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.List;

public class UpdateEmployeeCommand implements Command {
    @Override
    public String execute(HttpServletRequest request) {
        EntityManagerFactory entityManagerFactory = (EntityManagerFactory) request.getServletContext().getAttribute("Factory");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        HttpSession httpSession = request.getSession();
        Employee employee = (Employee) httpSession.getAttribute("employee");
        try {
            employee.setPhoto(Files.readAllBytes(Path.of(request.getServletContext().getRealPath("")
                    + File.separator + "images" + File.separator + employee.getPhotoFile())));
            for (Document document : employee.getDocuments()){
                document.setPicture(Files.readAllBytes(Path.of(request.getServletContext().getRealPath("")+File.separator+"images"+File.separator+document.getNumber()+".jpg")));
            }
        } catch (IOException ioException) {
            ioException.printStackTrace();
        }

        EntityTransaction entityTransaction = entityManager.getTransaction();
        entityTransaction.begin();
        entityManager.merge(employee);
        entityTransaction.commit();
        TypedQuery<Employee> employees = entityManager.createQuery("select s from Employee s", Employee.class);
        List<Employee> employees1 = employees.getResultList();
        request.setAttribute("staff", employees1);
        httpSession.getAttribute(null);
        entityManager.close();
        return "allStaff.jsp";
    }
}
