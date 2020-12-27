package com.estore.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.Normalizer.Form;
import java.text.SimpleDateFormat;
import java.util.*;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.estore.bean.MailInfo;
import com.estore.dao.DonHangChiTietDao;
import com.estore.dao.DonHangDao;
import com.estore.dao.KhachHangDao;
import com.estore.entity.DonHang;
import com.estore.entity.DonHangChiTiet;
import com.estore.entity.KhachHang;
import com.estore.entity.SanPham;
import com.estore.service.CartService;
import com.estore.service.MailService;
import com.estore.service.VnpayService;
import com.estore.utils.Utils;

@Controller
public class ShoppingCartController {

	@Autowired
	HttpSession session;

	@Autowired
	CartService cart;

	@Autowired
	DonHangDao dao;

	@Autowired
	KhachHangDao khdao;

	@Autowired
	DonHangChiTietDao ddao;

	@Autowired
	MailService mailler;

	@Autowired
	VnpayService vnpayService;

	@ResponseBody
	@RequestMapping("/giohang/capnhap/{id}/{qty}")
	public Object[] update(@PathVariable("id") Integer id, @PathVariable("qty") Integer qty) {
		cart.update(id, qty);
		Object[] info = { cart.getCount(), cart.getAmount() };
		return info;
	}

	@ResponseBody
	@RequestMapping("/giohang/them/{idsp}")
	public Object[] add(@PathVariable("idsp") Integer idsp) {
		cart.add(idsp);
		Object[] info = { cart.getCount(), cart.getAmount() };

		return info;
	}

	@RequestMapping("/home/giohang")
	public String giohang() {
		return "home/giohang";
	}

	@ResponseBody
	@RequestMapping("/giodang/xoagiohang")
	public void xoagiohang() {
		cart.clear();
	}

	@ResponseBody
	@RequestMapping("/giodang/xoagiohangtheoSP/{id}")
	public Object[] remove(@PathVariable("id") Integer id) {
		cart.remove(id);
		Object[] info = { cart.getCount(), cart.getAmount() };

		return info;
	}

	@GetMapping("/dathang/thanhtoan")
	public String showForm(@ModelAttribute("donHang") DonHang donHang) {
		KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");

		donHang.setKhachHang(khachHang);
		donHang.setTongTien(cart.getAmount());
		return "order/thanhtoan";
	}

	@PostMapping("/dathang/thanhtoan")
	public String purchase(HttpServletRequest req, @ModelAttribute("donHang") DonHang donHang) throws MessagingException, IOException {
		Collection<SanPham> list = cart.getItems();
		List<DonHangChiTiet> details = new ArrayList<>();
		for (SanPham sanPham : list) {
			DonHangChiTiet detail = new DonHangChiTiet();
			detail.setDonHang(donHang);
			detail.setSanPham(sanPham);
			detail.setGiaBan(sanPham.getGiaGoc());
			detail.setSoLuong(sanPham.getSoLuong());
			detail.setKhuyenMai(sanPham.getKhuyenMai());
			detail.setTongTien(sanPham.getSoLuong() * sanPham.getGiaGoc() *(1-sanPham.getKhuyenMai()));
			details.add(detail);
		}

		Date date = new Date();
		donHang.setNgayDatHang(new SimpleDateFormat("yyyy-MM-dd hh:mm:ss").format(date));
		donHang.setTongTien(cart.getAmount());
		donHang.setTrangThai("Đang xử lý");

		dao.create(donHang, details);

		// Mail notification
		// KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
		// String from = khachHang.getEmail();
		// String to = "vutrananh98hn@gmail.com";
		// String subject = "Thông tin đặt hàng";
		// String body = "Khách hàng " + khachHang.getHoTen() + "đã đặt hàng";
		// MailInfo mail = new MailInfo(from, to, subject, body);
		// mailler.send(mail);
		// cart.clear();

		String ip = Utils.getIpAddress(req);
		return "redirect:" + vnpayService.getPaymentURL(donHang.getMaDonHang().toString(), ip, donHang.getTongTien().intValue());
	}

	/** Vnpay IPN */
	@GetMapping("/vnpay/ipn")
	@ResponseBody
	public Map<String, String> vnpayIPN(HttpServletRequest request) throws IOException {
		Map<String, String> response = new HashMap<>();

		if (vnpayService.verifyRequest(request)) {

			Integer id = Integer.parseInt(request.getParameter("vnp_TxnRef"));
			DonHang donHang = dao.findById(id);
			//Kiem tra chu ky OK
			/* Kiem tra trang thai don hang trong DB: checkOrderStatus, 
			- Neu trang thai don hang OK, tien hanh cap nhat vao DB, tra lai cho VNPAY RspCode=00
			- Neu trang thai don hang (da cap nhat roi) => khong cap nhat vao DB, tra lai cho VNPAY RspCode=02
			*/
			boolean checkOrderStatus = donHang.getThongTinThanhToan() == null;

			if (checkOrderStatus) {
				if ("00".equals(request.getParameter("vnp_ResponseCode"))) {
					//Xu ly thanh toan thanh cong
					donHang.setTrangThai("Thành công");
					donHang.setThongTinThanhToan(
						"VNPAY " +
						request.getParameter("vnp_CardType") +
						" " + 
						request.getParameter("vnp_TransactionNo") +
						" - " +
						request.getParameter("vnp_BankCode") +
						" " +
						request.getParameter("vnp_BankTranNo")
					);
				} else {
					//Xu ly thanh toan khong thanh cong
					donHang.setTrangThai("Thất bại");
				}
				
				dao.update(donHang);
				response.put("RspCode", "00");
				response.put("Message", "Confirm Success");
			} else {
				//Don hang nay da duoc cap nhat roi, Merchant khong cap nhat nua (Duplicate callback)
				response.put("RspCode", "02");
				response.put("Message", "Order already confirmed");
			}
			
		} else {
			response.put("RspCode", "97");
			response.put("Message", "Invalid Checksum");
		}
		return response;
	}

	@GetMapping("/dathang/danhsach")
	public String list(Model model) {
		KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
		List<DonHang> donhangs = dao.findByUser(khachHang);
		model.addAttribute("donhangs", donhangs);
		return "order/list";
	}

	@GetMapping("/dathang/chitiet/{maDonHang}")
	public String detail(Model model, @PathVariable("maDonHang") Integer maDonHang) {
		DonHang donHang = dao.findById(maDonHang);
		List<DonHangChiTiet> details = ddao.findByOder(donHang);
		model.addAttribute("donHang", donHang);
		model.addAttribute("details", details);

		return "order/chitiet";
	}

	@GetMapping("/dathang/sanphamdamua")
	public String items(Model model) {
		KhachHang khachHang = (KhachHang) session.getAttribute("khachHang");
		List<SanPham> list = dao.findItemsByUser(khachHang);
		model.addAttribute("list", list);
		return "product/list";
	}

}
