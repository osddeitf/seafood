<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<div class="main">
	<div class="container">
		<div class="row">
			<div class="col-md-12">

				<div class="breadcrumb clearfix">
					<ul>
						<li itemtype="http://shema.org/Breadcrumb" itemscope=""
							class="home"><a title="Đến trang chủ" href="/home/index"
							itemprop="url"><span itemprop="title">Trang chủ</span></a></li>
						<li class="icon-li"><strong>Thông tin đơn hàng</strong></li>
					</ul>
				</div>
				<script type="text/javascript">
					$(".link-site-more").hover(function() {
						$(this).find(".s-c-n").show();
					}, function() {
						$(this).find(".s-c-n").hide();
					});
				</script>
				<script src="app/services/orderServices.js"></script>
				<script src="app/controllers/orderController.js"></script>
				<script src="/assets/user/100004/js/orderServices.js"></script>
				<script src="/assets/user/100004/js/orderController.js"></script>
				<div class="payment-content">
					<form:form class="payment-block clearfix" modelAttribute="donHang"
						action="/dathang/thanhtoan" id="checkout-container">
						<div class="col-md-6 col-sm-12 col-xs-12 payment-step step2">
							<h4>Chi tiết đơn hàng #${donHang.maDonHang}</h4>
							
							<div class="step-preview">
								<div class="form-group">
									<label>Tài khoản</label>
									<form:input path="khachHang.maKhachHang" class="form-control"
										readonly="true" />
								</div>

								<div class="form-group">
									<label>Ngày đặt hàng</label>
									<form:input path="ngayDatHang" readonly="true"
										class="form-control" />
								</div>

								<div class="form-group">
									<label>Địa chỉ giao hàng</label>
									<form:input path="diaChi" readonly="true" class="form-control" />
								</div>

								<div class="form-group">
									<label>Người nhận</label>
									<form:input path="nguoiNhan" readonly="true" class="form-control" />
								</div>

								<div class="form-group">
									<label>Điện thoại người nhận</label>
									<form:input path="dienThoai" readonly="true" class="form-control" />
								</div>

								<div class="form-group">
									<label>Tổng tiền</label>
									<form:input path="tongTien" readonly="true"
										class="form-control" pattern="#,###" />
								</div>

								<div class="form-group">
									<label>Trạng thái đơn hàng</label>
									<form:input path="trangThai" readonly="true"
										class="form-control" pattern="#,###" />
								</div>

								<div class="form-group">
									<label>Thông tin thanh toán</label>
									<form:input path="thongTinThanhToan" readonly="true"
										class="form-control" />
								</div>
							</div>

							<div class="step-preview">
								<table class="table product-list">
									<thead>
										<tr>
											<th>Mã sản phẩm</th>
											<th>Giá sản phẩm</th>
											<th>Khuyến mãi</th>
											<th>Số lượng</th>
											<th>Số tiền</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="d" items="${details}">
											<tr>
												<td>${d.sanPham.maSanPham }</td>
												<td>${d.giaBan }</td>
												<td>${d.khuyenMai }</td>
												<td>${d.soLuong }</td>
												<td>${d.soLuong * d.giaBan*(1-d.khuyenMai) }</td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</form:form>
				</div>

			</div>
		</div>
	</div>
</div>

<script type="text/javascript">
	$(document).ready(function() {
		$(".menu-quick-select ul").hide();
		$(".menu-quick-select").hover(function() {
			$(".menu-quick-select ul").show();
		}, function() {
			$(".menu-quick-select ul").hide();
		});
	});
</script>
