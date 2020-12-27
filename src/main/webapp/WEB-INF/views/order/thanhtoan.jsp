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
							class="home"><a title="Đến trang chủ" href="index.html"
							itemprop="url"><span itemprop="title">Trang chủ</span></a></li>
						<li class="icon-li"><strong></strong></li>
					</ul>
				</div>
				<script type="text/javascript">
					$(".link-site-more").hover(function() {
						$(this).find(".s-c-n").show();
					}, function() {
						$(this).find(".s-c-n").hide();
					});

					var getIPAddress = function() {
						$.getJSON("https://jsonip.com?callback=?", function(data) {
							alert("Your IP address is :- " + data.ip);
						});
					}


					$("#vnpay").on('change', function() {
						var ip;
						$.getJSON("https://jsonip.com?callback=?", function(data) {
							ip = data.ip;
						});
						$.ajax({
								type: 'POST',
								url: 'http://apibe.vveco.vn/api/pay/vnpay/createpay',
								dataType: 'json',
								async: false,
								data: {
									orderType: "billpayment",
									amount: tongTien,
									orderInfo: item.Id,
									bankCode: '',
									language: '',
									ipAddress: ip
								},
								success: function(line_item) {

										window.location.href= line_item.data.data;

								},
								error: function(XMLHttpRequest, txtStatus) {
									Haravan.onError(XMLHttpRequest, txtStatus);
								}
							});

					})
				</script>
				<script src="app/services/orderServices.js"></script>
				<script src="app/controllers/orderController.js"></script>
				<script src="/assets/user/100004/js/orderServices.js"></script>
				<script src="/assets/user/100004/js/orderController.js"></script>
				<div class="payment-content">
					<h1 class="title">
						<span></span>
					</h1>
					<div class="steps clearfix">
						<ul class="clearfix">
							<li class="cart active col-md-2 col-xs-12 col-sm-4 col-md-offset-3 col-sm-offset-0 col-xs-offset-0">
								<span><i class="glyphicon glyphicon-shopping-cart"></i></span>
								<span>Giỏ hàng của tôi</span>
								<span class="step-number"><a>1</a></span>
							</li>
							<li class="payment active col-md-2 col-xs-12 col-sm-4">
								<span><i class="glyphicon glyphicon-usd"></i></span>
								<span>Thanh toán</span>
								<span class="step-number"><a>2</a></span>
							</li>
							<li class="finish col-md-2 col-xs-12 col-sm-4">
								<span><i class="glyphicon glyphicon-ok"></i></span>
								<span>Hoàn tất</span>
								<span class="step-number"><a>3</a></span>
							</li>
						</ul>
					</div>
					<form:form class="payment-block clearfix" modelAttribute="donHang"
						action="/dathang/thanhtoan" id="checkout-container">
						<!--div class="col-md-4 col-sm-12 col-xs-12 payment-step step2">
							<h4>1. Địa chỉ và giao hàng</h4>
							<div class="step-preview clearfix">
								<h2 class="title">Thông tin giao hàng</h2>
								<div class="checkbox">
									<label>
										<input type="checkbox" />
										<span>Giao hàng địa chỉ khác</span>
									</label>
								</div>
								<h2 class="title">Vận chuyển</h2>
								<div class="form-group ">
									<select class="form-control">
										<option>Giao Hàng Tiết Kiệm</option>
										<option>Viettel Post</option>
										<option>Giao Hàng Nhanh</option>
									</select>
								</div>
							</div>
						</div-->
						<!--div class="col-md-4 col-sm-12 col-xs-12 payment-step step3">
							<h4>Thanh toán</h4>
							<div class="step-preview clearfix">
								<h2 class="title">Phương thức thanh toán</h2>
								<div class="radio">
									<label>
										<input type="radio" value="{{item.Id}}" name="optionsRadios" />
										<img src="/assets/user/100004/images/paypal_logo.jpg" alt="Paypal-Logo" width="50px" height="50px"/>
										<span>Paypal</span>
									</label>
									<label style="margin-left:5px">
										<input type="radio" value="{{item.Id}}" name="optionsRadios" />
										<img src="/assets/user/100004/images/vnpay_logo.jpg" alt="VnPayl-Logo" width="50px" height="50px"/>
										<span>Vnpay</span>
									</label>
									<label style="margin-left:5px">
									 	<input type="radio" value="{{item.Id}}" name="optionsRadios" />
										<img src="/assets/user/100004/images/momo_logo.png" alt="Momo-Logo" width="50px" height="50px"/>
										<span>Momo</span>
									</label>
								</div>
							</div>
						</div-->
						<div class="col-md-4"></div>
						<div class="col-md-4 col-sm-12 col-xs-12 payment-step step1">
							<h4>Thông tin đơn hàng</h4>
							<div class="step-preview">
								<div class="form-group">
									<label>Tài khoản</label>
									<form:input path="khachHang.maKhachHang" class="form-control"
										type="text" />
								</div>
								
								<div class="form-group">
									<label>Địa chỉ giao hàng</label>
									<form:input path="diaChi" type="text" class="form-control" />
								</div>

								<div class="form-group">
									<label>Người nhận</label>
									<form:input path="" type="text" class="form-control" />
								</div>

								<div class="form-group">
									<label>Điện thoại người nhận</label>
									<form:input path="" type="text" class="form-control" />
								</div>

								<div class="form-group">
									<label>Tổng tiền</label>
									<form:input path="tongTien" type="text" class="form-control" />
								</div>
								<div class="form-group">
									<label>Ghi chú </label>
									<form:textarea path="ghiChu" rows="3" class="form-control" />
								</div>

								<div class="form-group">
									<form:button  type="submit" class="btn btn-primary">
										Tiếp tục
									</form:button>
								</div>
								<img id="vnpay" src="/assets/user/100004/images/vnpay_logo.jpg" alt="VnPayl-Logo" width="50px" height="50px">
									Vnpay
								</img>
							</div>
						</div>
						<div class="col-md-4"></div>
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
