/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author aisy
 */
public class AwardNominee {
    
    private int awardid;
    private int nomineeid;
    private double score;

    public AwardNominee() {
    }

    public AwardNominee(int awardid, int nomineeid, double score) {
        this.awardid = awardid;
        this.nomineeid = nomineeid;
        this.score = score;
    }

    public int getAwardid() {
        return awardid;
    }

    public void setAwardid(int awardid) {
        this.awardid = awardid;
    }

    public int getNomineeid() {
        return nomineeid;
    }

    public void setNomineeid(int nomineeid) {
        this.nomineeid = nomineeid;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }
    
}
