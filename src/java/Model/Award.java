/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author ariffnorhadi
 */
public class Award {

    private int award_id;
    private String award_name;
    private String year_criteria;
    private String program_criteria;
    private String gender_criteria;
    private int event_id;
    private int created_by;
    private int last_updated_by;

    public Award() {
    }

    public int getAward_id() {
        return award_id;
    }

    public void setAward_id(int award_id) {
        this.award_id = award_id;
    }

    public String getAward_name() {
        return award_name;
    }

    public void setAward_name(String award_name) {
        this.award_name = award_name;
    }

    public String getYear_criteria() {
        return year_criteria;
    }

    public void setYear_criteria(String year_criteria) {
        this.year_criteria = year_criteria;
    }

    public String getProgram_criteria() {
        return program_criteria;
    }

    public void setProgram_criteria(String program_criteria) {
        this.program_criteria = program_criteria;
    }

    public String getGender_criteria() {
        return gender_criteria;
    }

    public void setGender_criteria(String gender_criteria) {
        this.gender_criteria = gender_criteria;
    }

    public int getEvent_id() {
        return event_id;
    }

    public void setEvent_id(int event_id) {
        this.event_id = event_id;
    }

    public int getCreated_by() {
        return created_by;
    }

    public void setCreated_by(int created_by) {
        this.created_by = created_by;
    }

    public int getLast_updated_by() {
        return last_updated_by;
    }

    public void setLast_updated_by(int last_updated_by) {
        this.last_updated_by = last_updated_by;
    }

}
