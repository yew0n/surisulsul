<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@ include file="/WEB-INF/views/_inc/header.jsp"%>

<link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/item_filtered.css?time=${currentTime}" />
<link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/best_items.css?time=${currentTime}" />
<link rel="stylesheet" type="text/css" href="${contextPath}/assets/css/bar_slider.css?time=${currentTime}">

	<div class="item_filtered">
		<form method="post" action="${pageContext.request.contextPath}/item_filtered.do" name="filtered_form" id="filtered_form">
			<div class="keyword_checkbox">
				<div class="check_boxes">
					<h2 class="checkbox_title">종류별</h2>
					<div class="checkbox_input">
						<input name="types" class="types" id="types1" type="checkbox" value="0" <c:if test="${fn:containsIgnoreCase(types, '0')}">checked</c:if>/>
						<label for="types1">전체 선택</label>
					</div>
					
					<div class="checkbox_input">
						<input name="types" class="types" id="types2" type="checkbox" value="탁주" <c:if test="${fn:containsIgnoreCase(types, '탁주')}">checked</c:if>/>
						<label for="types2">탁주</label>
					</div>
					
					<div class="checkbox_input">
						<input name="types" class="types" id="types3" type="checkbox" value="청주" <c:if test="${fn:containsIgnoreCase(types, '청주')}">checked</c:if>/>
						<label for="types3">청주/약주</label>
					</div>
					
					<div class="checkbox_input">
						<input name="types" class="types" id="types4" type="checkbox" value="과실주" <c:if test="${fn:containsIgnoreCase(types, '과실주')}">checked</c:if>/>
						<label for="types4">과실주</label>
					</div>
					
					<div class="checkbox_input">
						<input name="types" class="types" id="types5" type="checkbox" value="증류주" <c:if test="${fn:containsIgnoreCase(types, '증류주')}">checked</c:if>/>
						<label for="types5">증류주</label>
					</div>
					
					<div class="checkbox_input">
						<input name="types" class="types" id="types6" type="checkbox" value="기타" <c:if test="${fn:containsIgnoreCase(types, '기타')}">checked</c:if>/>
						<label for="types6">기타 주류</label>
					</div>
				</div>
			
				<div class="check_boxes">
					<h2 class="checkbox_title">지역별</h2>
					<div class="checkbox_input">
						<input name="areas" class="area" id="area1" type="checkbox" value="0" <c:if test="${fn:containsIgnoreCase(locs, '0')}">checked</c:if>/>
						<label for="area1">전체 선택</label>
					</div>
					
					<div class="checkbox_input">
						<input name="areas" class="area" id="area2" type="checkbox" value="서울" <c:if test="${fn:containsIgnoreCase(locs, '서울')}">checked</c:if>/>
						<label for="area2">서울</label>
					</div>
					
					<div class="checkbox_input">
						<input name="areas" class="area" id="area3" type="checkbox" value="경기" <c:if test="${fn:containsIgnoreCase(locs, '경기')}">checked</c:if>/>
						<label for="area3">경기도</label>
					</div>
					
					<div class="checkbox_input">
						<input name="areas" class="area" id="area4" type="checkbox" value="강원" <c:if test="${fn:containsIgnoreCase(locs, '강원')}">checked</c:if>/>
						<label for="area4">강원도</label>
					</div>
					
					<div class="checkbox_input">
						<input name="areas" class="area" id="area5" type="checkbox" value="충청" <c:if test="${fn:containsIgnoreCase(locs, '충청')}">checked</c:if>/>
						<label for="area5">충청도</label>
					</div>
					
					<div class="checkbox_input">
						<input name="areas" class="area" id="area6" type="checkbox" value="전라" <c:if test="${fn:containsIgnoreCase(locs, '전라')}">checked</c:if>/>
						<label for="area6">전라도</label>
					</div>
					
					<div class="checkbox_input">
						<input name="areas" class="area" id="area7" type="checkbox" value="경상" <c:if test="${fn:containsIgnoreCase(locs, '경상')}">checked</c:if>/>
						<label for="area7">경상도</label>
					</div>
					
					<div class="checkbox_input">
						<input name="areas" class="area" id="area8" type="checkbox" value="제주" <c:if test="${fn:containsIgnoreCase(locs, '제주')}">checked</c:if>/>
						<label for="area8">제주도</label>
					</div>
				</div>
				
				<div class="check_boxes">
					<h2 class="checkbox_title">향</h2>
					<div class="checkbox_input">
						<input name="incense" class="incense" id="incense1" type="checkbox" value="0" <c:if test="${fn:containsIgnoreCase(keys, '0')}">checked</c:if>/>
						<label for="incense1">전체 선택</label>
					</div>
					
					<div class="checkbox_input">
						<input name="incense" class="incense" id="incense2" type="checkbox" value="곡물" <c:if test="${fn:containsIgnoreCase(keys, '곡물')}">checked</c:if>/>
						<label for="incense2">곡물향</label>
					</div>
					
					<div class="checkbox_input">
						<input name="incense" class="incense" id="incense3" type="checkbox" value="과일" <c:if test="${fn:containsIgnoreCase(keys, '과일')}">checked</c:if>/>
						<label for="incense3">과일향</label>
					</div>
					
					<div class="checkbox_input">
						<input name="incense" class="incense" id="incense4" type="checkbox" value="꽃" <c:if test="${fn:containsIgnoreCase(keys, '꽃')}">checked</c:if>/>
						<label for="incense4">꽃향</label>
					</div>
					
					<div class="checkbox_input">
						<input name="incense" class="incense" id="incense5" type="checkbox" value="꿀" <c:if test="${fn:containsIgnoreCase(keys, '꿀')}">checked</c:if>/>
						<label for="incense5">꿀향</label>
					</div>
					
					<div class="checkbox_input">
						<input name="incense" class="incense" id="incense6" type="checkbox" value="누룩" <c:if test="${fn:containsIgnoreCase(keys, '누룩')}">checked</c:if>/>
						<label for="incense6">누룩향</label>
					</div>
					
					<div class="checkbox_input">
						<input name="incense" class="incense" id="incense7" type="checkbox" value="알콜" <c:if test="${fn:containsIgnoreCase(keys, '알콜')}">checked</c:if>/>
						<label for="incense7">알콜향</label>
					</div>
				</div>
				<div class="sliders check_boxes">
					<h2 class="checkbox_title">맛과 깊이</h2>
					<%-- <div class="slider_info">전체 낮음 중간 높음</div> --%>
					<div class="slider">
						<span class="slider_title">당도</span>
						<div class="bar_slider">
							<select id="bar_slider_sugar" name="sweet" autocomplete="off">
                        		<option value="1" <c:if test="${sweet == '1'}">selected</c:if>>낮음</option>
                        		<option value="2" <c:if test="${sweet == '2'}">selected</c:if>>중간</option>
                        		<option value="3" <c:if test="${sweet == '3'}">selected</c:if>>높음</option>
                        		<option value="0" <c:if test="${sweet == '0'}">selected</c:if>>전체</option>
                    		</select>
						</div>
					</div>
					
					<div class="slider">
						<span class="slider_title">산미</span>
						<div class="bar_slider">
							<select id="bar_slider_acidity" name="sour" autocomplete="off">
                        		<option value="1" <c:if test="${sour == '1'}">selected</c:if>>낮음</option>
                        		<option value="2" <c:if test="${sour == '2'}">selected</c:if>>중간</option>
                        		<option value="3" <c:if test="${sour == '3'}">selected</c:if>>높음</option>
                        		<option value="0" <c:if test="${sour == '0'}">selected</c:if>>전체</option>
                    		</select>
						</div>
					</div>
					
					<div class="slider">
						<span class="slider_title">도수</span>
						<div class="bar_slider">
							<select id="bar_slider_alcohol" name="degree" autocomplete="off">
                        		<option value="1" <c:if test="${degree == '1'}">selected</c:if>>낮음</option>
                        		<option value="2" <c:if test="${degree == '2'}">selected</c:if>>중간</option>
                        		<option value="3" <c:if test="${degree == '3'}">selected</c:if>>높음</option>
                        		<option value="0" <c:if test="${degree == '0'}">selected</c:if>>전체</option>
                    		</select>
						</div>
					</div>
				</div>
			</div>
		<!-- </form> -->
		
		<div class="search">
			<div class="keyword_area">
				<h4>검색 조건</h4>
				<ul class="result_list_type">
				</ul>
				<ul class="result_list_area">
				</ul>
				<ul class="result_list_incense">
				</ul>
			</div>
			<input type="text" name="title_search" id="title_search" placeholder="직접 입력해 주세요." value="${search}" />
			<div class=clear></div>
			<button type="submit" class="search_btn">검색</button>
		</div>
		</form>
		
		<div class="item_contents">
			<span class="title">내가 찾는 술</span>
			<ul class="item_list">
				<c:choose>
				 	<%-- 조건에 부합하는 상품이 없는 경우 --%>
				 	<c:when test="${output == null || fn:length(output) == 0}">
				 		<div class="select_none">
							<img src="${contextPath}/assets/img/mark_alert.png" />
							<h1>검색 결과를 찾을 수 없습니다.</h1>
						</div>
					</c:when>
					
					<%-- 조건에 부합하는 상품이 없는 경우 --%>
					<c:otherwise>
						<%-- 조회 결과에 따른 반복처리 --%>
				 		<c:forEach var="item" items="${output}" varStatus="status">
							<li class="item_info">
								
								<%-- 상세페이지로 이동하기 위한 URL --%>
								<c:url value="/item_details.do" var="viewUrl">
									<c:param name="prodid" value="${item.id}" />
								</c:url>
								
								<a href="${viewUrl}">
									<img class="item_img" src="${contextPath}/assets/img/items/${item.img}" /> <br/>
									<span class="item_title">${item.name}</span>
									<span class="item_price"><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</span> <br/>
		                    		<div class="clean"></div>
									<span class="item_rating">
										<c:set var="stars" value="${item.star}" />
										<c:choose>
										<c:when test="${stars != 0}">
											<c:forEach var="i" begin="1" end="${stars}" step="1">★</c:forEach>
			 								<c:forEach var="i" begin="1" end="${5-stars}" step="1">☆</c:forEach>
										</c:when>
										<c:otherwise>☆☆☆☆☆</c:otherwise>
										</c:choose>
									</span> <br/>
									<ul class="item_tag_list">
										<li class="item_tag item_type_tag">#${item.type}</li>
										<li class="item_tag item_area_tag">#${item.loc}</li>
										<li class="item_tag item_keyword_tag">#${item.key1}</li>
									</ul>
								</a>
							</li>
						</c:forEach>
					</c:otherwise>
				</c:choose>
			</ul>
			
			<div class="clean"></div>
		</div>
		
		<div class="pageNumber">
		<!-- 페이지 번호 구현 -->
		<%-- 이전 그룹에 대한 링크 --%>
		<c:choose>
			<%-- 이전 그룹으로 이동 가능하다면? --%>
			<c:when test="${pageData.prevPage > 0}">
				<%-- 이동할 URL 생성 --%>
				<c:url value="/item_filtered.do" var="prevPageUrl">
					<c:param name="page" value="${pageData.prevPage}" />
				</c:url>
				<a href="${prevPageUrl}">[이전]</a>
			</c:when>
			<c:otherwise>
				[이전]
			</c:otherwise>
		</c:choose>

		<%-- 페이지 번호(시작 페이지부터 끝 페이지까지 반복) --%>
		<c:forEach var="i" begin="${pageData.startPage}"
			end="${pageData.endPage}" varStatus="status">
			<%-- 이동할 URL 생성 --%>
			<c:url value="/item_filtered.do" var="pageUrl">
				<c:param name="page" value="${i}" />
			</c:url>
	
			<%-- 페이지 번호 출력 --%>
			<c:choose>
				<%-- 현재 머물고있는 페이지 번호를 출력할 경우 링크 적용 안함 --%>
				<c:when test="${pageData.nowPage == i}">
					<strong>[${i}]</strong>
				</c:when>
				<%-- 나머지 페이지의 경우 링크 적용함 --%>
				<c:otherwise>
					<a href="${pageUrl}">[${i}]</a>
				</c:otherwise>
			</c:choose>
		</c:forEach>

		<%-- 다음 그룹에 대한 링크 --%>
		<c:choose>
			<%-- 다음 그룹으로 이동 가능하다면? --%>
			<c:when test="${pageData.nextPage > 0}">
				<%-- 이동할 URL 생성 --%>
				<c:url value="/item_filtered.do" var="nextPageUrl">
					<c:param name="page" value="${pageData.nextPage}" />
				</c:url>
				<a href="${nextPageUrl}">[다음]</a>
			</c:when>
			<c:otherwise>
				[다음]
			</c:otherwise>
		</c:choose>
		</div>
		
	</div>

<script src="${contextPath}/assets/js/item_filtered.js?time=${currentTime}" type="text/javascript" charset="utf-8"></script>

<script src="http://code.jquery.com/jquery-3.5.1.min.js"></script>
<script src="${contextPath}/assets/js/jquery.barrating.min.js?time=${currentTime}" type="text/javascript" charset="utf-8"></script>
<script type="text/javascript">
    $(function() {
        function ratingEnable() {
            $('#bar_slider_sugar').barrating({
                theme: 'bars-pill',
                showValues: true,
                showSelectedRating: false,
                hoverState: true
            });
        }
        ratingEnable();
    });
    
    $(function() {
        function ratingEnable() {
            $('#bar_slider_acidity').barrating({
                theme: 'bars-pill',
                showValues: true,
                showSelectedRating: false,
                hoverState: true
            });
        }
        ratingEnable();
    });
    
    $(function() {
        function ratingEnable() {
            $('#bar_slider_alcohol').barrating({
                theme: 'bars-pill',
                showValues: true,
                showSelectedRating: false,
                hoverState: true
            });
        }
        ratingEnable();
    });
</script>

<%@ include file="/WEB-INF/views/_inc/footer.jsp"%>