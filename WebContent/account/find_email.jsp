<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="UTF-8" />
    <title>Hello JSP</title>
</head>

<body>
    <h3>이메일 찾기</h3>
    <span>
        <p>가입 시 입력한 이메일을 잊으셨나요?<br />
            수리술술에 가입한 이름과 핸드폰 번호를 정확히 입력해 주세요.</p>
    </span>
    <!-- 이메일을 찾는 데 필요한 정보를 입력하는 폼 : 데이터 조회(where) 조건 -->
    <!-- 형식 검사 할 것인지? -->
    <form class="form-horizontal" name="join_form" id="join_form">
        <div class="form-group">
            <label for='user_name' class="col-md-2">이름 <span class='identify'>*</span></label>
            <div class="col-md-10">
                <input type="text" name="user_name" id="user_name" class="form-control" placeholder="이름을 입력하세요." />
            </div>
        </div>
        <div class="form-group">
            <label for='tel' class="col-md-2">전화번호 <span class='identify'>*</span></label>
            <div class="col-md-10">
                <input type="tel" name="tel" id="tel" class="form-control" placeholder="휴대폰 번호를 - 없이 입력하세요." />
            </div>
        </div>
        <div class="form-group">
            <div class="text-center">
                <button type="submit">이메일 확인</button>
            </div>
        </div>
    </form>
    <div class="print_email">
        <p>회원님이 수리술술에 가입한 이메일은 user***@****.com 입니다.</p>
        <!-- 조회하기 전일 시 해당 블록에 아무런 텍스트도 뜨지 않게 할 것 -->
        <!-- 해당하는 정보가 없어 조회에 실패할 경우 사이트에 등록된 이메일이 없습니다. 라는 문구로 변경해서 나오게 할 것 -->
    </div>
</body>

</html>