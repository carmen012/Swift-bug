package Service;

import javax.ejb.LocalBean;
import javax.ejb.Singleton;


@Singleton
@LocalBean
public class UserServiceBean implements UserServiceBeanLocal{

    @Override
    public boolean logintest(String username, String password) {
    return "admin".equals(username) && "admin".equals(password);
    }

}