@isTest
public class TestWebToLead {
    
    // negative test single
    @isTest
    public static void test01() {
        
        System.assertEquals(false, WebToLeadController.createLead('', '', '', '', '', ''));
        System.debug('(Success): Failed test01-01');
        System.assertEquals(false, WebToLeadController.createLead('Yeet', 'The', 'Dragon@gmail.com', 'HI', '', ''));
        System.debug('(Success): Failed test01-02');
        System.assertEquals(false, WebToLeadController.createLead('Yeet', 'The', 'Dragon@gmail.com', '', 'HI', ''));
        System.debug('(Success): Failed test01-03');
    }
    
    // positive test single
    @isTest
    public static void test02() {
        System.assertEquals(true, WebToLeadController.createLead('Yeet', 'The', 'Dragon@gmail.com', 'Baltimore', 'MD', 'Revature'));
        System.assertEquals(true, WebToLeadController.createLead('Yeet', 'The', 'Dragon@gmail.com', '', '', 'Revature'));
    }
    
    // no bulk tests -- they don't make any sense here
}