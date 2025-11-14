package model;

public class Customer extends User {
    private String membershipNumber;

    // Constructors
    public Customer() {
        super();
    }

    public Customer(String membershipNumber, int id, String username, String password,
                    String fullname, String phonenumber, String emailaddress, String address) {
        super(id, username, password, fullname, phonenumber, emailaddress, address);
        this.membershipNumber = membershipNumber;
    }

    public String getMembershipNumber() {
        return membershipNumber;
    }

    public void setMembershipNumber(String membershipNumber) {
        this.membershipNumber = membershipNumber;
    }
}
