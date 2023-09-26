package com.home.ormjpa.commands;

import com.home.ormjpa.entities.Employee;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.TypedQuery;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

import java.util.List;

public class AllStaffCommand implements Command {
    @Override
    public String execute(HttpServletRequest request) {
      HttpSession httpSession = request.getSession();
      httpSession.removeAttribute("employee");

        EntityManagerFactory entityManagerFactory = (EntityManagerFactory) request.getServletContext().getAttribute("Factory");
        EntityManager entityManager = entityManagerFactory.createEntityManager();
        TypedQuery<Employee> query = entityManager.createQuery("select s from Employee s", Employee.class);
        List<Employee> staff = query.getResultList();
        request.setAttribute("staff", staff);
        return "allStaff.jsp";
    }
}
