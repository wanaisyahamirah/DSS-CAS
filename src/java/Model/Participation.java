/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import javax.servlet.http.Part;

/**
 *
 * @author aisy
 */
public class Participation {
    
    private int participationid;
    private int userid;
    private String programName;
    private String participationLevel;
    private Part evidence;
    private String programDate;
    private String position;

    public Participation() {
    }

    public Participation(int participationid, int userid, String programName, String participationLevel, Part evidence, String programDate) {
        this.participationid = participationid;
        this.userid = userid;
        this.programName = programName;
        this.participationLevel = participationLevel;
        this.evidence = evidence;
        this.programDate = programDate;
    }

    public int getParticipationid() {
        return participationid;
    }

    public void setParticipationid(int participationid) {
        this.participationid = participationid;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public String getProgramName() {
        return programName;
    }

    public void setProgramName(String programName) {
        this.programName = programName;
    }

    public String getParticipationLevel() {
        return participationLevel;
    }

    public void setParticipationLevel(String participationLevel) {
        this.participationLevel = participationLevel;
    }

    public Part getEvidence() {
        return evidence;
    }

    public void setEvidence(Part evidence) {
        this.evidence = evidence;
    }

    public String getProgramDate() {
        return programDate;
    }

    public void setProgramDate(String programDate) {
        this.programDate = programDate;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
    
    
    
    
}
