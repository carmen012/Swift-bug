/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Models.RootNewsInfo;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;

@ManagedBean

public class RootNewsService {
    private RootNewsInfo rni;
    private final List <RootNewsInfo>rnl;

    public RootNewsInfo getRni() {
        return rni;
    }

    public void setRni(RootNewsInfo rni) {
        this.rni = rni;
    }

    public List<RootNewsInfo> getRnl() {
        return rnl;
    }

    
    public RootNewsService() {
    rnl = new ArrayList<>();
     rnl.add(new RootNewsInfo("Z0001",
            "JUSTIN TIMBERLAKE",
            "The Supplies singer performs for thousands at Madison Square Garden, including lucky fans who got the ultimate stage-side experience through the Verizon Up rewards program.",
            "Z0001.jpg"));
      rnl.add(new RootNewsInfo("Z0002",
            "INCUBUS",
              "Brandon Boyd and the band perform their biggest hits at KROQ 106.7's Halloween Costume Ball at the Fonda Theatre. ",
            "Z0002.jpg"));
         rnl.add(new RootNewsInfo("Z0003",
            "BRUNO MARS",
               "While visiting Austin, Texas, the music superstar performs at the F1 United States Grand Prix at Circuit of The Americas.",
            "Z0003.jpg")); }


   
    
    
}
