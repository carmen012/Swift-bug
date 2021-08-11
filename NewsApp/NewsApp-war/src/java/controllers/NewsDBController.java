/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;


import entities.News;
import javax.enterprise.context.SessionScoped;
import java.io.Serializable;
import java.util.List;
import javax.ejb.EJB;
import javax.inject.Named;
import models.NewsFacade;

@SessionScoped
@Named
public class NewsDBController implements Serializable {

    
    @EJB
    private NewsFacade newsFacade;
    private News news= new News();

    public News getNews() {
        return news;
    }

    public void setNews(News news) {
        this.news = news;
    }
    
    
    public NewsDBController() {
    }
    
    public List<News> findAll(){
        return this.newsFacade.findAll();
    }
    
    public String insert(){
        this.newsFacade.create(news);
        this.news=new News();
        return "databank";
    }
    
       public String update(News news){
      this.news=news;
          return "update";
    }
    
       public String update(){
             this.newsFacade.edit(news);
             return "databank";
       }
       
    public String delete(News news){
        this.newsFacade.remove(news);
        return "databank";
    }
    

      }
    
    

