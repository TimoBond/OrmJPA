package com.home.ormjpa;

import com.home.ormjpa.entities.Employee;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.apache.commons.io.IOUtils;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.OpenOption;
import java.nio.file.Path;
import java.nio.file.StandardOpenOption;
import java.util.Base64;

@WebServlet(name = "UploadController", value = "/UploadController")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1, // 1 MB
        maxFileSize = 1024 * 1024 * 10,      // 10 MB
        maxRequestSize = 1024 * 1024 * 100   // 100 MB
)
public class UploadController extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String fileName = "";
        String type = "upPhoto";
        for (Part part : request.getParts()) {
            if (part.getSubmittedFileName() != null && !"".equals(part.getSubmittedFileName())) {

                fileName = part.getSubmittedFileName();
                System.out.println(part.getSize() + " size");
                fileName = request.getParameter("photoFile");

                if (request.getParameter("upload_photo").equals("upload document photo")) {

                    System.out.println("upload_photo" + request.getParameter("docNumberPh"));
                    type = request.getParameter("upload_doc_photo");
                    fileName = request.getParameter("docNumberPh") + ".jpg";
                }
                System.out.println(fileName + "filename");
                String pas = request.getServletContext().getRealPath("") + File.separator + "images" + File.separator + fileName;
                part.write(pas);
                break;
            }
        }
        request.getRequestDispatcher("employeeDetails.jsp?fileName=" + fileName + "&typePhoto=" + type).forward(request, response);
//       String command = request.getParameter("commands");
//        if(command.equals("photo")) {
//            Part part = request.getPart("photo");
//            byte[] photo = IOUtils.toByteArray(part.getInputStream());
//            HttpSession httpSession = request.getSession();
//            Employee employee = (Employee) httpSession.getAttribute("employee");
//            employee.setPhoto(photo);
//            System.out.println("getPhoto " + employee.getPhoto());
//            employee.setImage64(Base64.getEncoder().encodeToString(photo)); // Сохранение картинок в ввиде стринга для удобного отображения на веб странице в теге image
//            System.out.println("Base64 " + Base64.getEncoder().encodeToString(photo));
//            System.out.println("getImage64" + employee.getImage64());
//            request.getRequestDispatcher("createEmployee.jsp").forward(request, response);
//        }if(command.equals("video")){
//           Part part = request.getPart("video");
//           byte[] video = IOUtils.toByteArray(part.getInputStream());
//           HttpSession httpSession = request.getSession();
//           Employee employee = (Employee) httpSession.getAttribute("employee");
//           employee.setVideo(video);
//           String path = "C:\\videoJpa\\vvv.mp4";
//            OpenOption[] openOptions = {StandardOpenOption.CREATE, StandardOpenOption.WRITE};
//            Files.write(Path.of(path),video,openOptions);
//            request.getRequestDispatcher("createEmployee.jsp").forward(request, response);
//        }
    }
}
