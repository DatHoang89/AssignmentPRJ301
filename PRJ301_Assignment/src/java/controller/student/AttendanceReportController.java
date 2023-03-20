/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller.student;

import controller.authentication.BaseRequiredAuthenticatedController;
import dal.CourseDBContext;
import dal.ReportAttendanceForStudentDBContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.ArrayList;
import model.Account;
import model.Attendance;
import model.Group;

/**
 *
 * @author LEGION
 */
public class AttendanceReportController extends BaseRequiredAuthenticatedController{
    protected void processRequest(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        Account a = (Account) request.getSession().getAttribute("account");
        CourseDBContext c = new CourseDBContext();
        Account account = (Account) request.getSession().getAttribute("account");
        ArrayList<Group> groupCourse = c.allCourseByStudentId(account.getStudentId());
        request.setAttribute("c", groupCourse);

        String raw_std = request.getParameter("sid");
        String raw_course = request.getParameter("cid");
        if (raw_std != null && raw_course != null) {
            ReportAttendanceForStudentDBContext r = new ReportAttendanceForStudentDBContext();
            ArrayList<Attendance> attendance = r.allAttendanceByStidCoid(Integer.parseInt(raw_std), Integer.parseInt(raw_course));
            request.setAttribute("cid", Integer.parseInt(raw_course));
            request.setAttribute("attendance", attendance);
        } else {
            ReportAttendanceForStudentDBContext r = new ReportAttendanceForStudentDBContext();
            ArrayList<Attendance> attendance = r.allAttendanceByStidCoid(account.getStudentId(), groupCourse.get(0).getCourse().getId());
            request.setAttribute("attendance", attendance);
        }
        request.getRequestDispatcher("view/att/student/attendancereport.jsp").forward(request, response);

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response, Account account) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response, Account account) throws ServletException, IOException {
        processRequest(request, response);
    }
}
