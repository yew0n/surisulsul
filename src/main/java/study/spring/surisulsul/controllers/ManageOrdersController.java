package study.spring.surisulsul.controllers;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import study.spring.surisulsul.helper.PageData;
import study.spring.surisulsul.helper.WebHelper;
import study.spring.surisulsul.model.Order;
import study.spring.surisulsul.service.ManageOrdersService;
import study.spring.surisulsul.service.OrderService;

@Controller
public class ManageOrdersController {
	/** WebHelper 주입 */
	@Autowired
	WebHelper webHelper;

	/** Service 패턴 구현체 주입 */
	@Autowired
	ManageOrdersService manageService;
	@Autowired
	OrderService orderService;

	/** 프로젝트 이름에 해당하는 ContextPath 변수 주입 */
	@Value("#{servletContext.contextPath}")
	String contextPath;
	

	/** 관리자 - manage_orders 페이지 처리 */
	@RequestMapping(value = "/manage_orders.do", method = {RequestMethod.GET, RequestMethod.POST})
	public ModelAndView manage_orders(Model model,
			@RequestParam(value = "order_status", required = false) String order_status,
			@RequestParam(value = "pay_method", required = false) String pay_method,
			@RequestParam(value = "from_date", required = false) String from_date,
			@RequestParam(value = "to_date", required = false) String to_date)throws Exception {
		
		Order input = new Order();
		List<Order> output = new ArrayList<Order>();
		
		//받아온 파라미터를 가지고 impl메서드에 넘겨줄 input객체 내용 부여
		if(order_status!=null && order_status!="all") {
			if(order_status.equals("order_cmpl")) {
				input.setPay_result("N");
				input.setSend_result("N");
			}else if(order_status.equals("pay_cmpl")) {
				input.setPay_result("Y");
				input.setSend_result("N");
			}else if(order_status.equals("send_cmpl")) {
				input.setPay_result("Y");
				input.setSend_result("Y");
			}
		}
		
		if(pay_method!=null && pay_method!="all") {
			if(pay_method.equals("cash")) {
				input.setPayment("cash");
			}else if(pay_method.equals("card")) {
				input.setPayment("card");
			}
		}
		
		if(from_date!=null) {
			if(to_date==null) {
				return webHelper.redirect(null, "조회하시고자 하는 주문일자를 정확히 입력해주세요.");
			}else {
				input.setFrom_date(from_date);
				input.setTo_date(to_date);
			}
		}

		//input에 담은 데이터를 가지고 테이블 조회 수행
		try {
			// 데이터 조회하기
			output = manageService.getOrderList(input);
			
			for(int i=0; i<output.size(); i++) {
				//누적주문건수 부여
				int tmp = manageService.getMemOrderCount(output.get(i));
				output.get(i).setOrder_cnt(tmp);
				//해당 주문의 상품건수 부여
				tmp = manageService.getSubCount(output.get(i));
				output.get(i).setSub_cnt(tmp);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		// 상태유지를 위한 form 태그 내용 전달
		model.addAttribute("order_status", order_status);
		model.addAttribute("pay_method", pay_method);
		model.addAttribute("from_date", from_date);
		model.addAttribute("to_date", to_date);
		// 데이터베이스 조회 이후 관련 내용 view에 전송
		model.addAttribute("output", output);
		return new ModelAndView("manage/manage_orders");
	}
	
	/** 관리자 - manage_order_details 페이지 처리 */
	@RequestMapping(value = "/manage_order_details.do", method = RequestMethod.GET)
	public ModelAndView order_details(Model model,
			@RequestParam(value="o_id", required = true) int o_id) throws Exception {
		
		Order input = new Order();
		input.setO_id(o_id);
		
		//orders 테이블의 주문 상세 정보를 받아올 객체 
		Order order_details = new Order();
		//orders_sub 테이블의 상세 상품내역을 받아올 List
		List<Order> order_sub = new ArrayList<Order>();
		
		//input에 담은 데이터를 가지고 테이블 조회 수행
		try {
			// 데이터 조회하기
			order_details = manageService.getOrderDetails(input);
			order_sub = orderService.getOrderSubList(input);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//view 전달
		model.addAttribute("order_details", order_details);
		model.addAttribute("order_sub", order_sub);
		return new ModelAndView("manage/manage_order_details");
	}
	
	/** 관리자 - manage_order_details 상태 변경 UPDATE 처리 */
	@RequestMapping(value = "/update_single.do", method = RequestMethod.GET)
	public ModelAndView updateSingleOrder(Model model,
			@RequestParam(value="o_id", required = true) int o_id,
			@RequestParam(value="pay", required = true) String pay_result,
			@RequestParam(value="send", required = true) String send_result) throws Exception {
		
		System.out.println("파라미터 값 잘 받아오는지 체크 >>>>>>>>>>>>>>> pay_result : "+pay_result+", send_result : "+send_result);
		
		Order input = new Order();
		input.setO_id(o_id);
		
		if(pay_result.equals("N") && send_result.equals("N")) {
			// 입금 대기 >>>>>>> 입금 완료 처리 (updatePayResult)
			manageService.updatePayResult(input);
		}else if(pay_result.equals("Y") && send_result.equals("N")) {
			// 입금 완료 >>>>>>> 배송 완료 처리 (updateSendResult)
			manageService.updateSendResult(input);
		}else{
			//pay_result 와 send_result모두 "Y"인 경우 -> 이미 배송완료 상태이므로 UPDATE 필요X
			return webHelper.redirect(null, "해당 주문은 이미 배송완료 되었습니다.");			
		}
		
		return webHelper.redirect(contextPath+"/manage_order_details.do?o_id="+o_id, "주문상태가 정상적으로 갱신되었습니다.");
	}
	
	/** 관리자 - uncmpl_orders 페이지 처리 */
	@RequestMapping(value = "/uncmpl_orders.do", method = RequestMethod.GET)
	public ModelAndView uncmpl_orders(Model model) throws Exception {
		
		//결과 받아올 객체
		List<Order> output = new ArrayList<Order>();
		
		//input에 담은 데이터를 가지고 테이블 조회 수행
		try {
			// 데이터 조회하기
			output = manageService.getUncmplOrderList(null);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//view 전달
		model.addAttribute("output", output);
		return new ModelAndView("manage/uncmpl_orders");
	}
	
	/** 관리자 - uncmpl_orders -> 입금상태를 입금완료로 UPDATE 처리 */
	@RequestMapping(value = "/manage/update_pay.do", method = RequestMethod.POST)
	public ModelAndView update_pay(Model model,
			@RequestParam(value = "uncmplItem", required=false) List<String> chkItems) {
		// 파라미터 유효성 검사
		if(chkItems.size()<=0) {
			webHelper.redirect(null, "입금완료 처리할 항목을 선택해주세요.");
		}
		
		for(int i=0; i<chkItems.size(); i++) {
			Order input = new Order();
			input.setO_id(Integer.parseInt(chkItems.get(i)));
			try {
				manageService.updatePayResult(input);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
		return webHelper.redirect(contextPath+"/uncmpl_orders.do", "주문상태가 입금완료로 정상 갱신되었습니다.");
	}
	
	
	/** 관리자 - uncmpl_orders -> 배송 상태를 배송완료로 UPDATE 처리 */
	@RequestMapping(value = "/manage/update_send.do", method = RequestMethod.POST)
	public ModelAndView update_send(Model model, 
			@RequestParam(value = "uncmplItem", required=false) List<String> chkItems) {
		// 파라미터 유효성 검사
		if(chkItems.size()<=0) {
			webHelper.redirect(null, "배송완료 처리할 항목을 선택해주세요.");
		}
		
		//해당 chkItems의 pay_result가 N인 품목이 하나라도 있으면
		// -> 입금 대기 중 품목은 배송상태 변경이 불가능합니다. webHelper.redirect
		for(int i=0; i<chkItems.size(); i++) {
			Order input = new Order();
			input.setO_id(Integer.parseInt(chkItems.get(i)));
			Order output = new Order();
			try {
				output = manageService.getOrderDetails(input);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			if(output.getPay_result().equals("N")) { //해당 chkItems의 pay_result가 N일 경우
				return webHelper.redirect(null, "입금 대기 중 품목은 배송상태 변경이 불가능합니다.");
			}
		}
		
		//pay_result가 모두 "Y"인 것이 확인되면 (이미 위의 반복문 수행)
		for(int i=0; i<chkItems.size(); i++) {
			Order input = new Order();
			input.setO_id(Integer.parseInt(chkItems.get(i)));
			try {
				manageService.updateSendResult(input);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		return webHelper.redirect(contextPath+"/uncmpl_orders.do", "주문상태가 배송완료로 정상 갱신되었습니다.");
	}
	
	/** 관리자 - manage_sales 페이지 처리 */
	@RequestMapping(value = "/manage_sales.do", method = RequestMethod.GET)
	public ModelAndView manage_sales(Model model) throws Exception {

		return new ModelAndView("manage/manage_sales");
	}


}
