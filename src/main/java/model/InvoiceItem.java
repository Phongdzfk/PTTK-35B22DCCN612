package model;

public class InvoiceItem {
    private int id;
    private int quantity;
    private double unitPrice;
    private double totalPrice;
    private Item i;

    // Constructors
    public InvoiceItem() {}

    public InvoiceItem(int id, int quantity, double unitPrice, double totalPrice, Item i) {
        this.id = id;
        this.quantity = quantity;
        this.unitPrice = unitPrice;
        this.totalPrice = quantity * unitPrice;
        this.i = i;
        
    }

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public double getTotalPrice() {
		return totalPrice;
	}

	public void setTotalPrice(double totalPrice) {
		this.totalPrice = totalPrice;
	}

	public Item getI() {
		return i;
	}

	public void setI(Item i) {
		this.i = i;
	}

}
