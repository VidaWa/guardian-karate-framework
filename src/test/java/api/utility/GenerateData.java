package api.utility;

//import java.util.Random;

public class GenerateData {
	
	// Generate random email
	public static String getEmail() {
		String prefix = "studnet_email";
		String provider = "@tekschool.us";
		
		int random = (int) (Math.random() * 10000);
		String email = prefix + random + provider;
		return email;
		
		}
	// Generate random phone numbers
	public static String getPhoneNumber() {
		String phoneNumber = "2";
		for(int i =0; i<9; i++) { // if it is 10 it means the number should be 10 digits if the phoneNumber string 
			// should be empty, but in this case sometimes the the first digit could be 0 which is not ideal 
			// it is 9 it means the number is 9 digits but here the string of phoneNumber should store a one digit 
			// number so together they are 10 digits if we give 2 to phoneNumber string it also means the 10-digits 
			// number will always starts with 2
			phoneNumber += (int) (Math.random() * 10); // 10 means the numbers in those 10 digits should include 0-9 
			//including 9 because if it was 9 then 9 wouldn't be included
		}
		return phoneNumber;
		
		}
	
	// Another way to generate 10-digits numbers with formatting
//		Random generator = new Random();
//	
//		// creates a random number
//		int part1 = generator.nextInt(1000);
//		int part2 = generator.nextInt(1000);
//		int part3 = generator.nextInt(10000);
//	
//		// outputs the number including dashes
//		System.out.println("A random 10-digit phone number:");
//		System.out.printf("%03d-%03d-%04d\n", part1, part2, part3);
	
//	Using printf gives you control over how the numbers are formatted. 
//	%d is a placeholder for each integer. 03 in %03d formats the number with a minimum of 3 digits, 
//	padding it with 0's as needed. See Format String Syntax for full details of how printf formatting works.
	
	// Generate random license plate number
	public static String getLicensePlateNumber() {
		// Generate three random uppercase letters
		int letter1 = 65 + (int)(Math.random() * (90 - 65)); // Generate a random number between 65 and 90
		int letter2 = 65 + (int)(Math.random() * (90 - 65)); // Generate a random number between 65 and 90
		int letter3 = 65 + (int)(Math.random() * (90 - 65)); // Generate a random number between 65 and 90	

		// Generate four random digits
		int number1 = (int)(Math.random() * 10);
		int number2 = (int)(Math.random() * 10);
		int number3 = (int)(Math.random() * 10);
		int number4 = (int)(Math.random() * 10);

		// Display number plate
		// The first double-quotes + rest is added because the rest is char and we want to store all these 
		// chars in a String variable called licensePlate so this way it first converts to string
		String licensePlate = "" + (char)(letter1) + ((char)(letter2)) +  
				((char)(letter3)) + "-" + number1 + number2 + number3 + number4;
		return licensePlate;
		
		}
		
	// Just to test the above methods are working 
//	public static void main(String[] args) {
//		GenerateData data = new GenerateData();
//		System.out.println(data.getLicensePlateNumber());
//		System.out.println(data.getEmail());
//		String number = getPhoneNumber();
//		System.out.println(number);
//		System.out.println(number.length());
//	}
}
