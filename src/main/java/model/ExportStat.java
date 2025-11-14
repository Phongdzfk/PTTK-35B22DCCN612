package model;

public class ExportStat extends Item{
    private int totalQuantity;
    private double totalRevenue;
	public ExportStat() {
		super();
	}
	public ExportStat(int id, String name, String description, int stockQuantity, double unitPrice, int totalQuantity, double totalRevenue) {
		super(id, name, description, stockQuantity, unitPrice);
		this.totalQuantity = totalQuantity;
		this.totalRevenue = totalRevenue;
	}
	public int getTotalQuantity() {
		return totalQuantity;
	}
	public void setTotalQuantity(int totalQuantity) {
		this.totalQuantity = totalQuantity;
	}
	public double getTotalRevenue() {
		return totalRevenue;
	}
	public void setTotalRevenue(double totalRevenue) {
		this.totalRevenue = totalRevenue;
	}

}