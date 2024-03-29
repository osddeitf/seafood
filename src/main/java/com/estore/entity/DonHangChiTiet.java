package com.estore.entity;

import java.io.Serializable;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * DonHangChiTiet generated by hbm2java
 */
@Entity
@Table(name = "DonHangChiTiet")
public class DonHangChiTiet implements Serializable {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	Integer maDhct;
	Double giaBan;
	Integer soLuong;
	Double tongTien;
	Double khuyenMai;

	@ManyToOne
	@JoinColumn(name = "maDonHang")
	DonHang donHang;

	@ManyToOne
	@JoinColumn(name = "maSanPham")
	SanPham sanPham;

	public Double getKhuyenMai() {
		return khuyenMai;
	}

	public void setKhuyenMai(Double khuyenMai) {
		this.khuyenMai = khuyenMai;
	}

	public Integer getMaDhct() {
		return maDhct;
	}

	public void setMaDhct(Integer maDhct) {
		this.maDhct = maDhct;
	}

	public Double getGiaBan() {
		return giaBan;
	}

	public void setGiaBan(Double giaBan) {
		this.giaBan = giaBan;
	}

	public Integer getSoLuong() {
		return soLuong;
	}

	public void setSoLuong(Integer soLuong) {
		this.soLuong = soLuong;
	}

	public Double getTongTien() {
		return tongTien;
	}

	public void setTongTien(Double tongTien) {
		this.tongTien = tongTien;
	}

	public DonHang getDonHang() {
		return donHang;
	}

	public void setDonHang(DonHang donHang) {
		this.donHang = donHang;
	}

	public SanPham getSanPham() {
		return sanPham;
	}

	public void setSanPham(SanPham sanPham) {
		this.sanPham = sanPham;
	}

}
