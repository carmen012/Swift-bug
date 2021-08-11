/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Models;

import java.io.Serializable;

import javax.faces.bean.ManagedBean;
import javax.servlet.http.Part;


@ManagedBean
public class NewsInfo implements Serializable{
    private int id;
    private String title;
    private String content;
    private String filename;
    private Part image;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    
    public void setContent(String content) {
        this.content = content;
    }

    public String getFilename() {
        return filename;
    }

    public void setFilename(String filename) {
        this.filename = filename;
    }
    
         public Part getImage() {
        return image;
    }

    public void setImage(Part image) {
        this.image = image;
    }


    public NewsInfo() {
    }
    
   
}
