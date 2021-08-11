/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Service;

import javax.ejb.Local;

/**
 *
 * @author Carman
 */
@Local
public interface UserServiceBeanLocal {

    public boolean logintest(String username, String password);
   

   
}
