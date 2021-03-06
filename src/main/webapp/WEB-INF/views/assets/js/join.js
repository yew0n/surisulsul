

function inputEmail() {
    document.join_form.emailChk.value = "";
}


/** 약관 전체 동의 */
$('.all-terms').click(function() {
    $('.term').prop('checked', this.checked);
    $('.all-terms').prop('checked', this.checked);
});

/* 체크박스 개별적으로 선택 시 모두 체크인지 확인해서 .check_all에도 자동 선택처리 되도록 */
$('.term').click(function() {
    if ($("#info-term").is(":checked") && $("#site-term").is(":checked")) {
        $('#terms').attr("checked", true);
    } else {
        $('#terms').attr("checked", false);
    }
});


$(function() {
    /** 플러그인의 기본 설정 옵션 추가 */
    jQuery.validator.setDefaults({
        onkeyup: false, // 키보드입력시 검사 안함
        onclick: false, // <input>태그 클릭시 검사 안함
        onfocusout: false, // 포커스가 빠져나올 때 검사 안함
        showErrors: function(errorMap, errorList) { // 에러 발생시 호출되는 함수 재정의
            // 에러가 있을 때만..
            if (this.numberOfInvalids()) {
                // 0번째 에러 메시지에 대한 javascript 기본 alert 함수 사용
                //alert(errorList[0].message);
                // 0번째 에러 발생 항목에 포커스 지정
                //$(errorList[0].element).focus();

                swal({
                    title: "에러",
                    text: errorList[0].message,
                    type: "error"
                }).then(function(result) {
                    // 창이 닫히는 애니메이션의 시간이 있으므로,
                    // 0.1초의 딜레이 적용 후 포커스 이동
                    setTimeout(function() {
                        $(errorList[0].element).val('');
                        $(errorList[0].element).focus();
                    }, 100);
                });
            }
        }
    });

    /** 유효성 검사 추가 함수 */
    $.validator.addMethod("kor", function(value, element) {
        return this.optional(element) || /^[ㄱ-ㅎ가-힣]*$/i.test(value);
    });

    $.validator.addMethod("phone", function(value, element) {
        return this.optional(element) ||
            /^01(?:0|1|[6-9])(?:\d{3}|\d{4})\d{4}$/i.test(value) ||
            /^\d{2,3}\d{3,4}\d{4}$/i.test(value);
    });

    /** 유효성 검사 추가 함수 (이메일 중복확인)
    $.validator.addMethod("emailDupl", function(value, element) {
        return this.optional(element) || /^[ㄱ-ㅎ가-힣]*$/i.test(value);
    });
    */

    /** form태그에 부여한 id속성에 대한 유효성 검사 함수 호출 */
    $("#update_form").validate({
        /** 입력검사 규칙 */
        rules: {
            // [비밀번호] 필수 + 글자수 길이 제한
            user_pw: { required: true, minlength: 4, maxlength: 20 },
            // [비밀번호 확인] 필수 + 특정 항목과 일치 (id로 연결)
            user_pw_re: { required: true, equalTo: "#user_pw" },
            // [연락처] 필수
            tel: { required: true, phone: true },
            // [우편번호 및 주소] 필수
            postcode: { required: true },
            // [기타 주소] 필수
            detailAddress: { required: true }
        },
        /** 규칙이 맞지 않을 경우의 메시지 */
        messages: {
            user_pw: {
                required: "비밀번호를 입력하세요.",
                minlength: "비밀번호는 4글자 이상 입력하셔야 합니다.",
                maxlength: "비밀번호는 최대 20자까지 가능합니다."
            },
            user_pw_re: {
                required: "비밀번호 확인값을 입력하세요.",
                equalTo: "비밀번호 확인이 잘못되었습니다."
            },
            tel: {
                required: "연락처를 입력하세요.",
                phone: "연락처 형식이 잘못되었습니다."
            },
            postcode: {
                required: "우편번호 찾기를 통해 주소를 입력하세요."
            },
            detailAddress: {
                required: "배송을 위한 상세 주소를 입력하세요."
            }
        }
    }); // end validate()
    
    $("#find_pw_form").validate({
        /** 입력검사 규칙 */
        rules: {
            // [이름] 필수
            user_name: { required: true, kor: true },
            // [연락처] 필수
            tel: { required: true, phone: true },
            // [이메일] 필수 + 이메일 형식 일치 필요
            email: { required: true, email: true }
        },
        /** 규칙이 맞지 않을 경우의 메시지 */
        messages: {
             email: {
                required: "이메일을 입력하세요.",
                email: "이메일 형식이 잘못되었습니다."
            },
            tel: {
                required: "연락처를 입력하세요.",
                phone: "연락처 형식이 잘못되었습니다."
            },
            user_name: {
                required: "이름을 입력하세요.",
                kor: "이름은 한글만 입력 가능합니다."
            }
        }
    }); // end validate()

	$.validator.setDefaults({ ignore: '' });
    /** form태그에 부여한 id속성에 대한 유효성 검사 함수 호출 */
    $("#join_form").validate({
        /** 입력검사 규칙 */
        rules: {
            // [이메일] 필수 + 이메일 형식 일치 필요
            email: { required: true, email: true },
            // [이메일 중복확인] 필수 + email-chk 값 필요 (emailDupl:false가 필요)
            emailChk: { required: true, equalTo:"#chk-email" },
            // [비밀번호] 필수 + 글자수 길이 제한
            user_pw: { required: true, minlength: 4, maxlength: 20 },
            // [비밀번호 확인] 필수 + 특정 항목과 일치 (id로 연결)
            user_pw_re: { required: true, equalTo: "#user_pw" },
            // [이름] 필수
            user_name: { required: true, kor: true },
            // [연락처] 필수
            tel: { required: true, phone: true },
            // [생년월일] 필수 + 날짜 형식 일치 필요
            birthdate: { required: true, date: true },
            // [우편번호 및 주소] 필수
            postcode: { required: true },
            // [기타 주소] 필수
            detailAddress: { required: true },
            // [이용약관] 전부 동의 필수
            terms: { required: true, minlength: 3 }
        },
        /** 규칙이 맞지 않을 경우의 메시지 */
        messages: {
            email: {
                required: "이메일을 입력하세요.",
                email: "이메일 형식이 잘못되었습니다."
            },
            emailChk:{
            	required: "이메일 중복검사를 실행해주세요.",
            	equalTo: "이메일 중복검사를 실행해주세요."
            },
            user_pw: {
                required: "비밀번호를 입력하세요.",
                minlength: "비밀번호는 4글자 이상 입력하셔야 합니다.",
                maxlength: "비밀번호는 최대 20자까지 가능합니다."
            },
            user_pw_re: {
                required: "비밀번호 확인값을 입력하세요.",
                equalTo: "비밀번호 확인이 잘못되었습니다."
            },
            user_name: {
                required: "이름을 입력하세요.",
                kor: "이름은 한글만 입력 가능합니다."
            },
            tel: {
                required: "연락처를 입력하세요.",
                phone: "연락처 형식이 잘못되었습니다."
            },
            birthdate: {
                required: "생년월일을 입력하세요.",
                date: "생년월일의 형식이 잘못되었습니다."
            },
            postcode: {
                required: "우편번호 찾기를 통해 주소를 입력하세요."
            },
            detailAddress: {
                required: "배송을 위한 상세 주소를 입력하세요."
            },
            terms: {
                required: "이용 약관에 모두 동의해 주세요.",
                minlength: "이용 약관에 모두 동의해 주세요."
            }
        }
    }); // end validate()


});