/**
 * Created by Leonid Bartenev
 */

public class AuraHelper {
    
    public static Object throwException(Exception e){
        throw new AuraHandledException(e.getMessage() + '\n' + e.getStackTraceString());
    }

}