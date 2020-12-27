<%@ page pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jstl/fmt_rt" prefix="f"%>
<aside class="main-sidebar">
	<!-- sidebar: style can be found in sidebar.less -->
	<section class="sidebar">
		<!-- Sidebar user panel -->
		<div class="user-panel">
			<div class="pull-left image">
				<img src="/assets/admin/dist/img/user1-128x128.jpg"
					class="img-circle" alt="User Image">
			</div>
			<div class="pull-left info">
				<p>Admin Dashboard</p>
				<a href="#"><i class="fa fa-circle text-success"></i> Online</a>
			</div>
		</div>

		<!-- /.search form -->
		<!-- sidebar menu: : style can be found in sidebar.less -->
		<ul class="sidebar-menu" data-widget="tree">
			<li class="header">MAIN NAVIGATION</li>
			<li><a href="/admin/product/index"><i class="fa fa-book"></i> <span>Sản phẩm</span></a></li>
			<li><a href="/admin/category/index"><i class="fa fa-list"></i></i> <span>Danh mục sản phẩm</span></a></li>
			<li><a href="/admin/customer/index"><i class="fa fa-users"></i> <span>Khách hàng</span></a></li>
			<li><a href="/admin/order/index"><i class="fa fa-shopping-cart"></i> <span>Đơn hàng</span></a></li>
			<li><a href="/admin/order_detail/index"><i class="fa fa-info"></i></i> <span>Đơn hàng chi tiết</span></a></li>
			<li><a href="/admin/user/index"><i class="fa fa-user"></i> <span>Quản lý tài khoản</span></a></li>
		</ul>
	</section>
	<!-- /.sidebar -->
</aside>