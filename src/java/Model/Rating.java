/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author aisy
 */
public class Rating {
    
    private int candidate_id;
    private int lecturer_id;
    private int intangible_id;
    private int score;

    public Rating() {
    }

    public Rating(int candidate_id, int lecturer_id, int intangible_id, int score) {
        this.candidate_id = candidate_id;
        this.lecturer_id = lecturer_id;
        this.intangible_id = intangible_id;
        this.score = score;
    }

    public int getCandidate_id() {
        return candidate_id;
    }

    public void setCandidate_id(int candidate_id) {
        this.candidate_id = candidate_id;
    }

    public int getLecturer_id() {
        return lecturer_id;
    }

    public void setLecturer_id(int lecturer_id) {
        this.lecturer_id = lecturer_id;
    }

    public int getIntangible_id() {
        return intangible_id;
    }

    public void setIntangible_id(int intangible_id) {
        this.intangible_id = intangible_id;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
