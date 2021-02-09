package study.spring.surisulsul.controllers;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;
import study.spring.surisulsul.helper.RegexHelper;
import study.spring.surisulsul.helper.WebHelper;
import study.spring.surisulsul.model.Member;
import study.spring.surisulsul.model.Product;
import study.spring.surisulsul.service.MemberService;
import study.spring.surisulsul.service.ProductService;

@Controller
@Slf4j
public class MypageController {
	/** WebHelper 주입 */
	@Autowired
	WebHelper webHelper;

	/** RegexHelper 주입 */
	@Autowired
	RegexHelper regexHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	MemberService memberService;
	
	@Autowired
	ProductService productService;

	/** 프로젝트 이름에 해당하는 ContextPath 변수 주입 */
	@Value("#{servletContext.contextPath}")
	String contextPath;

	/** 회원 정보 확인 */
	@RequestMapping(value = "/mypage/mypage.do", method = RequestMethod.GET)
	public ModelAndView mypage(Locale locale, Model model, HttpServletRequest request) {
		// 세션값 받아오기
		HttpSession session = request.getSession();
		Member loginSession = (Member) session.getAttribute("loginInfo");
		Member output = null;
		
		boolean jn_result = false;
		List<Product> jn_output = null;

		// 로그인 세션이 없을 경우 = 로그인되어있지 않을 경우 alert 발생
		if (loginSession == null) {
			String redirectUrl = "../account/login.do";
			return webHelper.redirect(redirectUrl, "로그인이 필요한 페이지입니다.");

		} else { // 로그인 세션이 있는 경우 = 로그인된 사용자가 있다는 뜻
			Member member = new Member();
			member.setId(loginSession.getId());

			try {
				output = memberService.getMemberItem(member);
			} catch (Exception e) {
				return webHelper.redirect(null, e.getLocalizedMessage());
			}

			if (loginSession.getJn_result() == null) {// 로그인 O / 주능결과 X
				jn_result = false;
			} else {// 로그인 O / 주능결과 O
				jn_result = true;

				Product input = new Product();
				input.setJn_result(loginSession.getJn_result());

				jn_output = new ArrayList<Product>();
				/** 주능 결과에 해당하는 술 가져오기 */

				// Mapper안에 해당하는 주능 결과를 가져오는 SQL문 작성
				// public List<Product> selectJn_result(Product input);
				// ProducServiceImpl > selectJn_result() > mapper에 있는 select구문 실행

				// output = productService.selectJn_result(input);
			}
		}

		List<Product> best_output = new ArrayList<Product>();
		try {
			// Mapper안에 SQL문 작성 따로 해야될 0,4
			// Impl에 어떤 메서드로 들어가는지 확인해서 아래 구문 수정
			best_output = productService.jn_ProductList(null);
		} catch (Exception e) {
			e.printStackTrace();
		}

		/** View 처리 */
		model.addAttribute("output", output);
		model.addAttribute("jn_output", jn_output);
		model.addAttribute("jn_result", jn_result);
		model.addAttribute("best_output", best_output);
		
		return new ModelAndView("mypage/mypage");
	}

	/** 주능 결과 확인 */
	@RequestMapping(value = "/mypage/my_recommend.do", method = RequestMethod.GET)
	public String my_recommend(Model model) {
		System.out.println("mypage/my_recommend 메서드 정상적으로 들어옴.");
		return "mypage/my_recommend";
	}

	/** 상품 상세페이지 이동 --> ItemController */

	/** 위시리스트 확인 */
	@RequestMapping(value = "/mypage/wishlist.do", method = RequestMethod.GET)
	public String wishlist(Model model) {
		return "mypage/wishlist";
	}

	/** 내가 주문한 내역 확인 --> OrderController */

	/** 내가 작성한 리뷰/문의 확인 */
	@RequestMapping(value = "/mypage/my_opinion.do", method = RequestMethod.GET)
	public String my_opinion(Model model) {
		return "mypage/my_opinion";
	}

}