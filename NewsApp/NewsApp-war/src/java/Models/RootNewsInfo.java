
package Models;

import java.io.Serializable;
import javax.faces.bean.ManagedBean;


@ManagedBean
public class RootNewsInfo implements Serializable{
    private final String id;
    private final String title;
    private final String context;
    private final String pic;

    public RootNewsInfo(String id, String title, String context, String pic) {
        this.id = id;
        this.title = title;
        this.context = context;
        this.pic = pic;
    }


    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getContext() {
        return context;
    }

    public String getPic() {
        return pic;
    }
    
    
    
}
