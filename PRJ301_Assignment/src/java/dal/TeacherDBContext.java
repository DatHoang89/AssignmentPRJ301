/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Course;
import model.Group;
import model.Lecturer;
import model.Room;
import model.Session;
import model.Student;
import model.TimeSlot;

/**
 *
 * @author LEGION
 */
public class TeacherDBContext extends DBContext {

    public Lecturer getTeacherById(int teacherId) {
        try {
            String sql = "select * from Lecturer where lid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, teacherId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturer stu = new Lecturer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getBoolean(3),
                        rs.getDate(4)
                );
                return stu;
            }

        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Lecturer getTeacherByAid(int aId) {
        try {
            String sql = "select * from Lecturer where accountid = ?";
            PreparedStatement stm = connection.prepareStatement(sql);
            stm.setInt(1, aId);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                Lecturer stu = new Lecturer(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getBoolean(3),
                        rs.getDate(4)
                );
                return stu;
            }

        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    public Lecturer getTimeTable(int lid, Date from, Date to) {
        Lecturer lecturer = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT distinct l.lid,l.lname,ses.sessionid,ses.date\n"
                    + "	,g.gid,g.gname,c.cid,c.cname,r.rid,r.rname,t.tid,t.description		\n"
                    + "FROM Student s INNER JOIN [Student_Group]  sg ON s.sid = sg.sid\n"
                    + "						INNER JOIN [Group] g ON g.gid = sg.gid\n"
                    + "						INNER JOIN [Course] c ON g.cid = c.cid\n"
                    + "						INNER JOIN [Session] ses ON g.gid = ses.gid\n"
                    + "						INNER JOIN [TimeSlot] t ON t.tid = ses.tid\n"
                    + "						INNER JOIN [Room] r ON r.rid = ses.rid\n"
                    + "						INNER JOIN [Lecturer] l ON l.lid = ses.lid\n"
                    + "WHERE l.lid = ? AND ses.date >= ? AND ses.date <= ? ORDER BY g.gid";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, lid);
            stm.setDate(2, from);
            stm.setDate(3, to);
            rs = stm.executeQuery();
            while (rs.next()) {
                if (lecturer == null) {
                    lecturer = new Lecturer();
                    lecturer.setId(rs.getInt("lid"));
                    lecturer.setName(rs.getString("lname"));
                }

                Session ses = new Session();
                ses.setId(rs.getInt("sessionid"));
                ses.setDate(rs.getDate("date"));

                Group group = new Group();
                group.setId(rs.getInt("gid"));
                group.setName("gname");
                ses.setGroup(group);

                Room r = new Room();
                r.setId(rs.getInt("rid"));
                r.setName(rs.getString("rname"));
                ses.setRoom(r);

                Course c = new Course();
                c.setId(rs.getInt("cid"));
                c.setName(rs.getString("cname"));
                group.setCourse(c);

                TimeSlot t = new TimeSlot();
                t.setId(rs.getInt("tid"));
                t.setDescription(rs.getString("description"));
                ses.setSlot(t);

                group.getSessions().add(ses);
                lecturer.getGroups().add(group);

            }
        } catch (SQLException ex) {
            Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
                stm.close();
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return lecturer;
    }

    @Override
    public ArrayList all() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
