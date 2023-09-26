package com.home.ormjpa;

import com.home.ormjpa.commands.*;
import com.home.ormjpa.entities.StaffID;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "FrontController", value = "/FrontController")
public class FrontController extends HttpServlet {
    private EntityManagerFactory entityManagerFactory;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("do get?");
        process(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("do post?");
        process(req, resp);
    }

    public void init() {
        System.out.println("init work?");
        entityManagerFactory = Persistence.createEntityManagerFactory("embeddedPU");
        getServletContext().setAttribute("Factory", entityManagerFactory);
        System.out.println(entityManagerFactory + " factory");
    }

    @Override
    public void destroy() {
        entityManagerFactory.close();
    }

    public void process(HttpServletRequest request, HttpServletResponse response) {
        System.out.println("zashlo v process?");
        try {
            String command = request.getParameter("command");
            if (command != null && command.equals("getAllStaff")) {
                System.out.println("command?");
                String page = new AllStaffCommand().execute(request);
                request.getRequestDispatcher(page).forward(request, response);
            }
            if (command != null && command.equals("create_employee")) {
                String page = new SaveStaffCommand().execute(request);
                request.getRequestDispatcher(page).forward(request, response);
            }
            if(command != null && command.equals("delete")){
                System.out.println(" v delete");
                String page = new CommandDeleteEmployee().execute(request);
                request.getRequestDispatcher(page).forward(request, response);
            }if(command != null && command.equals("details")){
                String page =new DetailsCommand().execute(request);
                request.getRequestDispatcher(page).forward(request, response);
            }if(command != null && command.equals("updateEmployee")){
                String page = new UpdateEmployeeCommand().execute(request);
                request.getRequestDispatcher(page).forward(request,response);
            }
        } catch (ServletException | IOException ioException) {
            ioException.printStackTrace();
        }
    }
}
