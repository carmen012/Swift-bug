/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Services;

import Models.NewsInfo;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.ValidatorException;
import javax.servlet.http.Part;


@ManagedBean
@SessionScoped
public class NewsService {
    private final String folder = FacesContext.getCurrentInstance().getExternalContext().getRealPath("//resources//image//");
    Date date = new Date();
String modifiedDate= new SimpleDateFormat("yyyyMMddHHmmss").format(date);
    private final List<NewsInfo> filelist;
    
     public NewsService() {
      filelist = new ArrayList();
     }
      
 public void addFile(NewsInfo i){
          try (InputStream input = i.getImage().getInputStream()) {
   String filename = modifiedDate+"_"+Paths.get(i.getImage().getSubmittedFileName()).getFileName().toString(); 
         Files.copy(input, new File(folder,filename).toPath());
         System.out.println(folder+"\\"+filename);
          i.setId(filelist.size()+1);
           i.setFilename(filename);
           filelist.add(i);
          }
     catch (IOException e) {
         
 }
 }
 public void validateFile(FacesContext ctx,
                         UIComponent comp,
                         Object value) {
  List<FacesMessage> msgs = new ArrayList<>();
  Part file = (Part)value;
     if (file.getSize()<=0 || file.getContentType().isEmpty()) {
          msgs.add(new FacesMessage("Invaild file")); 
     }else{
  if (!"image/jpeg".equals(file.getContentType())) {
      if (!"image/png".equals(file.getContentType())) {
           if (!"image/gif".equals(file.getContentType())) {
               if (!"image/bmp".equals(file.getContentType())){
     msgs.add(new FacesMessage("not a image file")); 
               }     
           }
      }
  }
     }
  if (!msgs.isEmpty()) {
    throw new ValidatorException(msgs);
  }
  
  
}

    public String getFolder() {
        return folder;
    }
 
    
    public List<NewsInfo> getFilelist() {
        return filelist;
    }
   
    
      public int idno(){
       return (int) (Math.round(Math.random()*50));
       }
      
   public long insertlog(){
       return (long) (Math.round(Math.random()*500000));
       }
}
