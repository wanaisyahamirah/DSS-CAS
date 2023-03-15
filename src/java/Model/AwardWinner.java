/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author aisy
 */
public class AwardWinner {
    
    private int awarddid;
    private int candidateid;

    public AwardWinner() {
    }

    public AwardWinner(int awarddid, int candidateid) {
        this.awarddid = awarddid;
        this.candidateid = candidateid;
    }

    public int getAwarddid() {
        return awarddid;
    }

    public void setAwarddid(int awarddid) {
        this.awarddid = awarddid;
    }

    public int getCandidateid() {
        return candidateid;
    }

    public void setCandidateid(int candidateid) {
        this.candidateid = candidateid;
    }
}
