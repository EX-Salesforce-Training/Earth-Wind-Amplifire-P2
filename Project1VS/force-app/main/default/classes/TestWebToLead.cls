/*
Author: Zackary Frazier
Last Modified Project: Project 2
Created Project: Project 2 
Desc:
  unit tests for the web-to-lead controller
*/

@isTest
public class TestWebToLead {
    
    // negative test single
    @isTest
    public static void test01() {
        
        System.assertEquals(false, WebToLeadController.createLead('', '', '', '', '', ''));
        System.assertEquals(false, WebToLeadController.createLead('Yeet', 'The', 'Dragon@gmail.com', 'HI', '', ''));
        System.assertEquals(false, WebToLeadController.createLead('Yeet', 'The', 'Dragon@gmail.com', '', 'HI', ''));
    }
    
    // positive test single
    @isTest
    public static void test02() {
        System.assertEquals(true, WebToLeadController.createLead('Yeet', 'The', 'Dragon@gmail.com', 'Baltimore', 'MD', 'Revature'));
        System.assertEquals(true, WebToLeadController.createLead('Yeet', 'The', 'Dragon@gmail.com', '', '', 'Revature'));
    }
    
    // no bulk tests -- they don't make any sense here
}