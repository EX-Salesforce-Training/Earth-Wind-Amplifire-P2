public class RandomMessageController {
	
    private static String skillAPI = 'https://www.dnd5eapi.co/api/skills/';
    
    @AuraEnabled
    public static String getRandomMessage() {
        Http http = new Http();
        
        HttpRequest getIndexRequest = new HttpRequest();
        getIndexRequest.setEndpoint(skillAPI);
        getIndexRequest.setMethod('GET');
        HttpResponse getIndexResponse = http.send(getIndexRequest);
        
        String getIndexData = getIndexResponse.getBody();
        Map<String, Object> deserializedGetIndexData = (Map<String, Object>) JSON.deserializeUntyped(getIndexData);
        Integer count = (Integer) deserializedGetIndexData.get('count');
        List<Object> skillList = (List<Object>) deserializedGetIndexData.get('results');
        Integer i = (Integer) Math.floor(Math.random() * count);
        
        String index = (String) ((Map<String, Object>) skillList[i]).get('index');
        
        HttpRequest getDescRequest = new HttpRequest();
        getDescRequest.setEndpoint(skillAPI + index);
        getDescRequest.setMethod('GET');
        HttpResponse getDescResponse = http.send(getDescRequest);
        Map<String, Object> getDescData = (Map<String, Object>) JSON.deserializeUntyped(getDescResponse.getBody());
        String description = (String) ((List<Object>)getDescData.get('desc'))[0];

        return description;
    }
}