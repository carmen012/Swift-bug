/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import Models.UserInfo;
import Service.UserServiceBeanLocal;
import Services.NewsService;
import javax.ejb.EJB;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;


@SessionScoped
@ManagedBean
public class UserController {
 @ManagedProperty(value="#{userInfo}")
    private UserInfo ui;  
    private NewsService ns;
 
 @EJB
 private UserServiceBeanLocal ejb;

    public void setUi(UserInfo ui) {
        this.ui = ui;
    }

 
 public String login(){
     if (ejb.logintest(ui.getUsername(), ui.getPassword())) {
         FacesContext context = FacesContext.getCurrentInstance();
context.getExternalContext().getSessionMap().put("username", ui.getUsername());
             return "main";   
     }else {
         FacesMessage fm = new FacesMessage ("both of username & password are admin");
         FacesContext.getCurrentInstance().addMessage("msg", fm);
         return null;
     }
 }

     public String logout(){
         FacesContext.getCurrentInstance().getExternalContext().invalidateSession(); 
          return"main";   
       
 }
    
    
    
}
