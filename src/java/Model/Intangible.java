/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author aisy
 */
public class Intangible {
    
    private int intangibleid;
    private String intangibleName;

    public Intangible() {
    }

    public Intangible(int intangibleid, String intangibleName) {
        this.intangibleid = intangibleid;
        this.intangibleName = intangibleName;
    }

    public int getIntangibleid() {
        return intangibleid;
    }

    public void setIntangibleid(int intangibleid) {
        this.intangibleid = intangibleid;
    }

    public String getIntangibleName() {
        return intangibleName;
    }

    public void setIntangibleName(String intangibleName) {
        this.intangibleName = intangibleName;
    }
}
