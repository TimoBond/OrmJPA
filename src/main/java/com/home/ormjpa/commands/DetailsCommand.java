package com.home.ormjpa.commands;

import com.home.ormjpa.entities.Employee;
import com.home.ormjpa.entities.StaffID;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.OpenOption;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.Base64;

public class DetailsCommand implements Command{
    @Override
    public String execute(HttpServletRequest request) {
        EntityManagerFactory entityManagerFactory = (EntityManagerFactory) request.getServletContext().getAttribute("Factory");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        System.out.println("zashlo v DetaILS");
        String number = request.getParameter("number");
        String dept = request.getParameter("dept");
        StaffID staffID = new StaffID(Integer.parseInt(number),dept);
       Employee employee1 =  entityManager.find( Employee.class, staffID);
       employee1.setPhotoFile(employee1.getStaffID().getNumber()+employee1.getStaffID().getDept()+".jpg");
        OpenOption[] openOptions = {StandardOpenOption.CREATE, StandardOpenOption.WRITE};
        try {
            Files.write(Path.of(request.getServletContext().getRealPath("") + File.separator + "images" + File.separator+employee1.getPhotoFile()),
                    employee1.getPhoto(),
                    openOptions);
        }catch (IOException ioException){
            ioException.printStackTrace();
        }
        System.out.println(employee1.getPhotoFile());

//       employee1.getDocuments().stream().forEach(document -> System.out.println(document.getNumber()));
      HttpSession httpSession = request.getSession(true);
      httpSession.setAttribute("employee",employee1);
      return "employeeDetails.jsp";
    }
}
