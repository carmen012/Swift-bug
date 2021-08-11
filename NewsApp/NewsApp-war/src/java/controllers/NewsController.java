package controllers;

import Models.NewsInfo;
import Services.NewsService;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;

@ManagedBean
public class NewsController {

    @ManagedProperty(value = "#{newsInfo}")
    private NewsInfo a;

    public void setA(NewsInfo a) {
        this.a = a;
    }

    public void setSs(NewsService ss) {
        this.ss = ss;
    }
    @ManagedProperty(value = "#{newsService}")
    private NewsService ss;

    public String addFileSubmit() {
        ss.addFile(a);
               System.out.println(a.getFilename());
             return "main";
    }
    


}
