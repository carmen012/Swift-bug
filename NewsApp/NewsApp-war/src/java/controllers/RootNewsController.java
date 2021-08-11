
package controllers;

import Services.RootNewsService;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;

@ManagedBean
public class RootNewsController {

    @ManagedProperty(value="#{rootNewsService}")
    private RootNewsService rs;

    public RootNewsService getRs() {
        return rs;
    }

    public void setRs(RootNewsService rs) {
        this.rs = rs;
    }
   
    public String main(){
        return "main";
    }
    
    
}
