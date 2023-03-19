/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.authentication;

import dal.AccountDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import model.Account;

/**
 *
 * @author LEGION
 */
public class LoginController extends HttpServlet {
   
    

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        request.getRequestDispatcher("view/authentication/login.jsp").forward(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        AccountDBContext db = new AccountDBContext();
        Account acc = db.get(username, password);
        if(acc == null)
        {
            response.getWriter().println("login failed!");
        }
        else
        {
            request.getSession().setAttribute("account", acc);
            request.getSession().setAttribute("username", username);
            request.getSession().setAttribute("password", password);
            response.getWriter().println("login successful!");
        }
        if(acc.getRole() == 0){
            response.sendRedirect("/PRJ301_Assignment/Home");
//            request.getRequestDispatcher("view/student/timetable.jsp").forward(request, response);
//            response.sendRedirect("view/student/timetable.jsp");
        }else{
            response.sendRedirect("/PRJ301_Assignment/HomeTeacher");
//            request.getRequestDispatcher("view/lecturer/attendance.jsp").forward(request, response);
//            response.sendRedirect("view/lecturer/attendance.jsp");
        }
        
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
