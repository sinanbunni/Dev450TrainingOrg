public class CourseManager {

	/**
	 *  This class contains methods used to manage 
	 *  records in the Course object
	 */
	 
    public static Set<Course__c> findDuplicates (List<Course__c> oldCourseList, List<Course__c> newCourseList) {
        
		/** TODO #1: Declare a variable whose type is a Set of Course__c sObjects named courseDuplicatesSet
		 *           and initialize it to a newly constructed Set of Course__c sObjects, passing in no parameters
		 */
		Set<Course__c> courseDuplicatesSet = new Set<Course__c>();
		
		/** TODO #2: Declare a variable whose type is a Set of Course__c sObjects named oldCourseSet
		 *           and initialize it to a newly constructed Set of Course__c sObjects, passing in
		 *           the oldCourseList (from the input parameter of the method) as a parameter.
		 */
        Set<Course__c> oldCourseSet = new Set<Course__c>(oldCourseList);
        
		
		/** TODO #3: Create a for loop with an iterator of type Course__c named newCourse that
		 *           iterates over the List newCourseList (from the input parameter of the method).
		 *           Within the for loop:
		 *           -- If the oldCourseSet variable contains the value in the newCourse variable:
		 *              -- Call the add method for the courseDuplicatesSet variable and pass in the
		 *                 value of the newCourse variable       
		 */
        for (Course__c course : newCourseList) {
            if (oldCourseSet.contains(course)) {
                courseDuplicatesSet.add(course);
            }
        }
        
		
		/** TODO #4: Return the courseDuplicatesSet variable
		 */
        
        return courseDuplicatesSet;
        
    } // end findDuplicates method
    
    
} // end CourseManager class