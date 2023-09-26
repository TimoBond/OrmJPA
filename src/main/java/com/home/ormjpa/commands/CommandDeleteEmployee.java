package com.home.ormjpa.commands;

import com.home.ormjpa.entities.Employee;
import com.home.ormjpa.entities.StaffID;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.EntityTransaction;
import jakarta.servlet.http.HttpServletRequest;

public class CommandDeleteEmployee implements Command {
    @Override
    public String execute(HttpServletRequest request) {
        EntityManagerFactory entityManagerFactory = (EntityManagerFactory) request.getServletContext().getAttribute("Factory");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        Employee employee = new Employee();
        String number = request.getParameter("number");
        String dept = request.getParameter("dept");
        System.out.println("number " + number + " dept " + dept);
        employee.setStaffID(new StaffID(Integer.parseInt(number),dept));
        EntityTransaction entityTransaction = entityManager.getTransaction();
        entityTransaction.begin();
        entityManager.remove(entityManager.merge(employee));
        entityTransaction.commit();
        entityManager.close();
        return "allStaff.jsp";
    }
}
