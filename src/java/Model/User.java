/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author aisya
 */
public class User {

    private int userid;
    private Double cgpa;
    private int merit;
    private String gender;
    private String name;
    private String nric;
    private String mentorName;
    private String program;
    private int yearStudy;
    private String username;
    private String email;
    private String password;
    private String position;

    public User() {
    }
    
    public User(int userid, Double cgpa, int merit, String gender, String name, String nric, String mentorName, String program, int yearStudy, String username, String email, String password, String position) {
        this.userid = userid;
        this.cgpa = cgpa;
        this.merit = merit;
        this.gender = gender;
        this.name = name;
        this.nric = nric;
        this.mentorName = mentorName;
        this.program = program;
        this.yearStudy = yearStudy;
        this.username = username;
        this.email = email;
        this.password = password;
        this.position = position;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public Double getCgpa() {
        return cgpa;
    }

    public void setCgpa(Double cgpa) {
        this.cgpa = cgpa;
    }

    public int getMerit() {
        return merit;
    }

    public void setMerit(int merit) {
        this.merit = merit;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNric() {
        return nric;
    }

    public void setNric(String nric) {
        this.nric = nric;
    }

    public String getMentorName() {
        return mentorName;
    }

    public void setMentorName(String mentorName) {
        this.mentorName = mentorName;
    }

    public String getProgram() {
        return program;
    }

    public void setProgram(String program) {
        this.program = program;
    }

    public int getYearStudy() {
        return yearStudy;
    }

    public void setYearStudy(int yearStudy) {
        this.yearStudy = yearStudy;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
        
}
