package model;

public class User {
   private int user_id; 
   private String email;
   private String password;
   private String name;
   private String phone;
   private int age;
   private int gender;

   public User() {
	   super();
   }
   public User(String email, String phone, String password, String name, int age, int gender) {
	      super();
	      this.email = email;
	      this.phone = phone;
	      this.password = password;
	      this.name = name;
	      this.age = age;
	      this.gender = gender;
	   }
   public User(int user_id, String email, String phone, String password, String name, int age, int gender) {
      this(email, phone, password, name, age, gender);
      this.user_id = user_id;
   }

   public int getUser_id() {
      return user_id; 
   }

   public void setUser_id(int user_id) {
      this.user_id = user_id;
   }

   public int getGender() {
      return gender;
   }

   public void setGender(int gender) {
      this.gender = gender;
   }

   public String getPassword() {
      return password;
   }

   public void setPassword(String password) {
      this.password = password;
   }

   public String getName() {
      return name;
   }

   public void setName(String name) {
      this.name = name;
   }
   
   public void setPhone(String phone) {
	      this.phone = phone;
	   }

   public String getPhone() {
	    return phone;
   }
   
   public String getEmail() {
	      return email;
   }

   public void setEmail(String email) {
      this.email = email;
   }

   public int getAge() {
      return age;
   }

   public void setAge(int age) {
      this.age = age;
   }

   public boolean matchPassword(String password) {
      if (password == null) {
         return false;
      }
      return this.password.equals(password);
   }

   public boolean isSameUser(int userId) {
      if (this.user_id == userId)
         return true;
      return false;
   }

   @Override
   public String toString() {
      return "User [userId=" + user_id + ", password=" + password + ", name=" + name + ", phone=" + phone + ", email=" + email
            + ", age=" + age +  "]";
   }

}