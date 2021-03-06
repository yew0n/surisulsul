<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<c:set var="contextPath" value="<%=request.getContextPath()%>" />

<div class="item_info">
	<div>
		<h3 class="title">
			수리술술의 술 이야기 <span>내가 찾은 술은 어떤 술일까?</span>
		</h3>
		
		<div class="taste">
			<h4>맛과 향</h4>
			
			<div class="taste_chart">
				<canvas id="item_chart"></canvas>
			</div>
			
		</div>

		<div class="item_keyword_lists">
			<ul class="keyword_lists_ul">
				<li class="keyword_lists_li type_li">#${output.type}</li>
				<li class="keyword_lists_li area_li">#${output.loc}</li>
				<li class="keyword_lists_li incense1_li">#${output.key1}</li>
				<li class="keyword_lists_li incense2_li">#${output.key2}</li>
			</ul>
		</div>

		<div class="jn_result">
			<h4>주로 찾는 사람들</h4>
			<c:choose>
			<c:when test="${'무궁화' eq output.jn_result}">
				<img src="${contextPath}/assets/img/mypage/flower01.png" />
				<ul>
					<li>#국내파</li>
					<li>#육류파</li>
					<li>#깔끔한</li>
					<li>#높은도수</li>
				</ul>
			</c:when>
			<c:when test="${'수국' eq output.jn_result}">
				<img src="${contextPath}/assets/img/mypage/flower04.png" />
				<ul>
					<li>#해외파</li>
					<li>#가벼운</li>
					<li>#상큼한</li>
					<li>#낮은도수</li>
				</ul>
			</c:when>
			<c:when test="${'진달래' eq output.jn_result}">
				<img src="${contextPath}/assets/img/mypage/flower03.png" />
				<ul>
					<li>#국내파</li>
					<li>#가벼운</li>
					<li>#깔끔한</li>
					<li>#중간도수</li>
				</ul>
			</c:when>
			<c:otherwise>
				<img src="${contextPath}/assets/img/mypage/flower02.png" />
				<ul>
					<li>#해외파</li>
					<li>#육류파</li>
					<li>#달콤한</li>
					<li>#낮은도수</li>
				</ul>
			</c:otherwise>
			</c:choose>
			
			
		</div>
		<div class="clear"></div>

		<div class="item_info_suri">
			<h4>${output.name}에 대해...?</h4>
			<p>${output.des2}</p>
		</div>
		
		<div class="item_info_suri">
			<h4>${output.name}에 어울리는 음식</h4>
			<p>${output.food}</p>
		</div>

		<div class="suri_rules">
			<h4>판매 정책 안내 (모든 상품 공통, 교환/반품)</h4>
			<p>
				<b>수리술술에서 판매하는 주류 제품의 경우</b><br /> 발송과 동시에 재발송하기 어려운 상품으로 단순 변심,
				오주문, 주소불명, 수취인 부재 등 고객 사유로 인한 교환 및 반품이 불가합니다.<br /> 구매하시기 전 확인 후
				구매하시기 바랍니다.<br /> <br /> ※ 아래의 법률에 따라 구매 후 출고처리 전 주문 취소가 가능합니다.<br />
				<br /> <b>신용카드 가맹점 법률 제8조 (계약의 철회 및 항변)</b><br /> 가맹점은 할부거래에 관한
				법률, 방문판매 등에 관한 법률, 전자상거래 등에서의 소비자 보호에 관한 법률 등에 따라<br /> 계약에 관한 회원의
				철회가 인정되는 거래에 대해서는 관계 법령에서 정한 반에 따라 회원이 철회를 요청하는 경우 이를 수용하여야 한다.
			</p>
		</div>
		
	</div>
</div>

<script>
	/** 차트 구현 **/
	var ctx = document.getElementById('item_chart').getContext('2d');
	var itemChart = new Chart(ctx, {
		type : 'horizontalBar', //가로막대그래프
		data : {
			labels : [ "당도", "산미", "도수" ], // 각각의 bar에 표시할 x축 라벨
			datasets : [ {
				data : [ ${output.sweet} / 10, ${output.sour} / 10, ${output.degree} / 10 ], // 각 bar에 대한 y축 좌표 데이터
				backgroundColor : [// 각 bar의 배경 색상
							'rgba(142, 68, 173, 0.6)',
							'rgba(74, 68, 173, 0.6)',
							'rgba(177, 101, 159, 0.7)' 
							],
				borderColor : [// 각 bar의 테두리 색상
							'rgba(142, 68, 173, 1)',
							'rgba(74, 68, 173, 1)',
							'rgba(177, 101, 159, 1)'
							],
				borderWidth : 2	// 각 bar의 테두리 굵기
			} ]
		},
		options : {
			tooltips: {
				enabled: false
			},
			hover: {
				animationDuration: 0
			},
			animation: {
				duration: 1,
				onComplete: function () {
					var chartInstance = this.chart,
						ctx = chartInstance.ctx;
					ctx.font = Chart.helpers.fontString(Chart.defaults.global.defaultFontSize, Chart.defaults.global.defaultFontStyle, Chart.defaults.global.defaultFontFamily);
					ctx.fillStyle = 'black';
					ctx.textSize = '20';
					ctx.textAlign = 'center';
					ctx.textBaseline = 'middle';
	
					this.data.datasets.forEach(function (dataset, i) {
						var meta = chartInstance.controller.getDatasetMeta(i);
						meta.data.forEach(function (bar, index) {
							var data = dataset.data[index];							
							ctx.fillText(data * 10, bar._model.x + 10, bar._model.y);
						});
					});
				}
			},
			responsive : false,
			legend: {
				display: false
			},
			scales : {
				xAxes : [{
					ticks :{
						display: false,
						//autoSkip : false,
						beginAtZero: true,
						//stepSize: 10,
						min : 0,
						max : 6
					},
					gridLines: {
		                display:false
		            }
				}],
					yAxes : [{
						ticks :{
							autoSkip : false,
							fontColor : 'rgba(0, 0, 0, 1)',
							fontSize : 16
						},
						gridLines: {
			                display:false
			            }
					}]
				}
			}
		});
</script>