package utils;

import org.json.JSONObject;
import java.util.HashMap;
import java.util.Map;

public class JsonUtils {

    public Map<String, Map<String, String>> parseSpecsManually(Object specsJson) {
        String jsonStr;
        if (specsJson instanceof JSONObject) {
            jsonStr = ((JSONObject) specsJson).toString();
        } else if (specsJson instanceof String) {
            jsonStr = (String) specsJson;
        } else {
            throw new IllegalArgumentException("Specs must be either JSONObject or String");
        }
        Map<String, Map<String, String>> specsMap = new HashMap<>();
        
        // Remove outer braces and split into sections
        String cleanedJson = jsonStr.trim().replaceAll("^\\{|\\}$", "");
        String[] sections = cleanedJson.split(",\\s*(?=\"\\w+\":\\{)");
        
        for (String section : sections) {
            if (section.contains(":")) {
                String[] parts = section.split(":", 2);
                String category = parts[0].replaceAll("\"", "").trim();
                String content = parts[1].trim().replaceAll("^\\{|\\}$", "");
                
                Map<String, String> categorySpecs = new HashMap<>();
                String[] fields = content.split(",\\s*(?=\"\\w+\":)");
                
                for (String field : fields) {
                    String[] keyValue = field.split(":", 2);
                    if (keyValue.length == 2) {
                        String key = keyValue[0].replaceAll("\"", "").trim();
                        String value = keyValue[1].replaceAll("\"", "").trim();
                        categorySpecs.put(key, value);
                    }
                }
                
                specsMap.put(category, categorySpecs);
            }
        }
        
        return specsMap;
    }
}