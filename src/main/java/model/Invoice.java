package model;

import java.sql.Date;
import java.util.ArrayList;

public class Invoice {
    private int id;
    private Date dateIssued;
    private String status;
    private double totalAmount;
    private ArrayList<InvoiceItem> ii;
    private Customer c;
    private SaleStaff ss;
    private DeliveryStaff ds;
    public Invoice() {};
	public Invoice(int id, Date dateIssued, String status, double totalAmount, ArrayList<InvoiceItem> ii, Customer c,
			SaleStaff ss, DeliveryStaff ds) {
		super();
		this.id = id;
		this.dateIssued = dateIssued;
		this.status = status;
		this.totalAmount = totalAmount;
		this.ii = ii;
		this.c = c;
		this.ss = ss;
		this.ds = ds;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public Date getDateIssued() {
		return dateIssued;
	}
	public void setDateIssued(Date dateIssued) {
		this.dateIssued = dateIssued;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public double getTotalAmount() {
		return totalAmount;
	}
	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}
	public ArrayList<InvoiceItem> getIi() {
		return ii;
	}
	public void setIi(ArrayList<InvoiceItem> ii) {
		this.ii = ii;
	}
	public Customer getC() {
		return c;
	}
	public void setC(Customer c) {
		this.c = c;
	}
	public SaleStaff getSs() {
		return ss;
	}
	public void setSs(SaleStaff ss) {
		this.ss = ss;
	}
	public DeliveryStaff getDs() {
		return ds;
	}
	public void setDs(DeliveryStaff ds) {
		this.ds = ds;
	}
    
}