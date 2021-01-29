<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%-- JSTL로 변수 생성 --%>
<%-- 1) 캐시를 방지하기 위해 자주 수정되는 css,js 파일에 설정하는 용도 --%>
<c:set var="currentTime" value="<%=System.currentTimeMillis()%>" />
<%-- 2) 프로젝트이름 기반의 절대경로값 --%>
<c:set var="contextPath" value="<%=request.getContextPath()%>" />
<!doctype html>
<html>

<head>
<meta charset="UTF-8" />
<title>surisulsul</title>
<!-- 크로스 브라우징 호환성 시작 -->
<link rel="stylesheet" type="text/css"
   href="${contextPath}/assets/css/reset.css" />
<!-- 크로스 브라우징 호환성 끝 -->
<!-- 모바일 아이콘 지원 -->
    <link rel="shortcut icon" href="${contextPath}/assets/img/favicon.png" />
    <link rel="icon" href="${contextPath}/assets/img/favicon.png" />
<!-- CSS 파일 참조 처리 -->
<link rel="stylesheet" type="text/css"
   href="${contextPath}/assets/css/common.css?time=${currentTime}" />
<link rel="stylesheet" type="text/css"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" />
<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="https://kit.fontawesome.com/a076d05399.js"></script>
</head>
</head>

<body link="none" vlink="none" alink="none">
   <div class="header">
      <h1>
         <a href="${contextPath}"><img
            src="${contextPath}/assets/img/logo.png" alt="로고" /></a>
      </h1>
      <input type="checkbox" id="check"> 
      <label for="check">
         <i class="fas fa-bars" id="btn"></i> 
         <i class="fas fa-times" id="cancel"></i>
      </label>
      <div class="sidebar">
         <h1>
            <img src="${contextPath}/assets/img/logo.png" alt="사이드바 로고" />
         </h1>
         <ul>
            <li><a href="${contextPath}/items/best_items.jsp">인기 많은 술</a></li>
            <li><a href="${contextPath}/items/item_filtered.jsp">내가 찾는 술</a></li>
            <li class="drink_type"><a href="${contextPath}">우리 술 종류</a></li>
            	<div class="drink_inner">
		            <li><a href="${contextPath}/extra/takju.jsp">탁주</a></li>
					<li><a href="${contextPath}/extra/fruit_drink.jsp">과실주</a></li>
					<li><a href="${contextPath}/extra/cheongju.jsp">약주/청주</a></li>
					<li><a href="${contextPath}/extra/spirits.jsp">증류주</a></li>
					<li><a href="${contextPath}/extra/liquerurs.jsp">기타주류</a></li>
            	</div>
            <li><a href="${contextPath}/extra/juneung.jsp">주(酒)능</a></li>
            <br />
            <br />
            <br />
            <li><a href="${contextPath}/cscenter/cscenter_notice.jsp">알립니다</a></li>
            <li><a href="${contextPath}/cscenter/cscenter_faq.jsp">자주 묻는 질문</a></li>
         </ul>
      </div>
      <section></section>
      <c:choose>
         <c:when test="true">
            <%-- 로그인이 됐을 경우의 메뉴 --%>
            <div class="login_ok_menu">
               <ul class="login_menu">
                  <a href="${contextPath}/account/login.jsp"><li>로그인</li></a>
                  <a href="${contextPath}/account/join.jsp"><li>회원가입</li></a>
                  <a href="${contextPath}/order/basket.jsp"><li>장바구니</li></a>
               </ul>
            </div>
         </c:when>
         <c:otherwise>
            <div class="login_no_menu">
               <ul class="login_menu">
                  <a href="${contextPath}"><li>로그아웃</li></a>
                  <a href="${contextPath}/mypage/mypage.jsp"><li>나의 수리술술</li></a>
                  <a href="${contextPath}/order/basket.jsp"><li>장바구니</li></a>
               </ul>
            </div>
         </c:otherwise>
      </c:choose>

   </div>

   <script src="${contextPath}/assets/js/sidebar.js?time=${currentTime}"
      type="text/javascript" charset="utf-8"></script>