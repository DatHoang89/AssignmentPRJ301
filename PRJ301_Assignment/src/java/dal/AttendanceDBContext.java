/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Attendance;
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
public class AttendanceDBContext extends DBContext<Attendance> {

    public ArrayList<Attendance> getAttendancesBySession(int sessionid) {
        String sql = "SELECT s.sid,s.sname,s.gender,\n"
                + "a.aid,\n"
                + "ISNULL(a.status,0) as [status],\n"
                + "ISNULL(a.description,'') as [description]\n"
                + "FROM Student s LEFT JOIN [Student_Group] sg ON s.sid = sg.sid\n"
                + "						LEFT JOIN [Group] g ON g.gid = sg.gid\n"
                + "						LEFT JOIN [Session] ses ON ses.gid = g.gid\n"
                + "						LEFT JOIN [Attendance] a ON ses.sessionid = a.sessionid AND s.sid = a.sid\n"
                + "						WHERE ses.sessionid = ?";
        ArrayList<Attendance> atts = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {

            stm = connection.prepareStatement(sql);
            stm.setInt(1, sessionid);
            rs = stm.executeQuery();
            while (rs.next()) {
                Attendance a = new Attendance();
                a.setId(rs.getInt("aid"));
                a.setStatus(rs.getBoolean("status"));
                a.setDescription(rs.getString("description"));
                Student s = new Student();
                s.setStdid(rs.getInt("sid"));
                s.setStdname(rs.getString("sname"));
                a.setStudent(s);
                atts.add(a);
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
        return atts;

    }

    public void update(ArrayList<Attendance> atts, int sessionid) {
        try {
            connection.setAutoCommit(false);
            String sql_update_session = "UPDATE [Session]\n"
                    + "   SET [status] = 1\n"
                    + " WHERE [gid] = ?";
            PreparedStatement stm_update_session = connection.prepareStatement(sql_update_session);
            stm_update_session.setInt(1, sessionid);
            stm_update_session.executeUpdate();
            for (Attendance a : atts) {
                if (a.getId() == 0) {
                    //INSERT
                    String sql_insert_att = "INSERT INTO [Attendance]\n"
                            + "           ([sid]\n"
                            + "           ,[sessionid]\n"
                            + "           ,[status]\n"
                            + "           ,[description])\n"
                            + "     VALUES\n"
                            + "           (?\n"
                            + "           ,?\n"
                            + "           ,?\n"
                            + "           ,?)";
                    PreparedStatement stm_insert_att = connection.prepareStatement(sql_insert_att);
                    stm_insert_att.setInt(1, a.getStudent().getStdid());
                    stm_insert_att.setInt(2, a.getSession().getId());
                    stm_insert_att.setBoolean(3, a.isStatus());
                    stm_insert_att.setString(4, a.getDescription());
                    stm_insert_att.executeUpdate();
                } else {
                    //UPDATE
                    String sql_update_att = "UPDATE [Attendance]\n"
                            + "   SET \n"
                            + "	   [status] = ?\n"
                            + "      ,[description] = ?\n"
                            + " WHERE [aid] = ?";
                    PreparedStatement stm_update_att = connection.prepareStatement(sql_update_att);
                    stm_update_att.setBoolean(1, a.isStatus());
                    stm_update_att.setString(2, a.getDescription());
                    stm_update_att.setInt(3, a.getId());
                    stm_update_att.executeUpdate();
                }
            }

            connection.commit();
        } catch (SQLException ex) {
            try {
                connection.rollback();
            } catch (SQLException ex1) {
                Logger.getLogger(AttendanceDBContext.class.getName()).log(Level.SEVERE, null, ex1);
            }
            Logger.getLogger(dal.StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                connection.setAutoCommit(true);
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(dal.StudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }   
    
    public ArrayList<Attendance> allAttendanceByStidCoid(int studentId, int courseId) {
        ArrayList<Attendance> attendance = new ArrayList<>();
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            String sql = "SELECT ses.Date,ses.SessionId,ses.tid,t.description,g.gid,g.Gname,c.Cname,c.cid,\n"
                    + "                    r.rid,r.rname,a.Status,a.description,l.lid,l.lname\n"
                    + "                    FROM Student s LEFT JOIN [Student_Group] sg ON s.sid = sg.sid\n"
                    + "                    LEFT JOIN [Group] g ON g.gid = sg.gid left join Course c \n"
                    + "                    on c.cid = g.cid LEFT JOIN [Session] ses ON ses.gid = g.gid\n"
                    + "                    LEFT JOIN [Attendance] a ON ses.sessionid = a.SessionID AND s.sid = a.sid \n"
                    + "                    left join Room r on r.rid = ses.rid left join Lecturer l on ses.lid = l.lid\n"
                    + "                    left join TimeSlot t on t.tid = ses.tid\n"
                    + "                    where s.sid = ? and c.cid = ?";
            stm = connection.prepareStatement(sql);
            stm.setInt(1, studentId);
            stm.setInt(2, courseId);
            rs = stm.executeQuery();
            while (rs.next()) {
                Attendance a = new Attendance();
                a.setStatus(rs.getBoolean("status"));
                a.setDescription(rs.getString("description"));

                Session s = new Session();
                s.setDate(rs.getDate("Date"));
                s.setId(rs.getInt("SessionID"));

                TimeSlot t = new TimeSlot();
                t.setId(rs.getInt("tid"));
                t.setDescription(rs.getString("description"));
                s.setSlot(t);

                Group g = new Group();
                g.setId(rs.getInt("gid"));
                g.setName("gname");

                Lecturer l = new Lecturer();
                l.setId(rs.getInt("lid"));
                l.setName(rs.getString("lname"));

                s.setLecturer(l);
                Course c = new Course();
                c.setId(rs.getInt("cid"));
                c.setName(rs.getString("cname"));
                g.setSubject(c);
                s.setGroup(g);

                Room r = new Room();
                r.setId(rs.getInt("rid"));
                r.setName(rs.getString("rname"));
                s.setRoom(r);

                a.setSession(s);
                attendance.add(a);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ReportAttendanceForStudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
        } finally {
            try {
                rs.close();
            } catch (SQLException ex) {
                Logger.getLogger(ReportAttendanceForStudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }

            try {
                stm.close();
            } catch (SQLException ex) {
                Logger.getLogger(ReportAttendanceForStudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
            try {
                connection.close();
            } catch (SQLException ex) {
                Logger.getLogger(ReportAttendanceForStudentDBContext.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
        return attendance;
    }
    
    @Override
    public ArrayList<Attendance> all() {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }
}
