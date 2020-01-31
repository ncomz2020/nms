package com.ncomz.nms.controller.admin.card;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ncomz.nms.domain.Consts;
import com.ncomz.nms.domain.admin.card.Card;
import com.ncomz.nms.domain.common.SessionUser;
import com.ncomz.nms.service.admin.card.CardService;
import com.ncomz.nms.service.admin.code.CodeService;


@Controller
@RequestMapping(value = "/admin/card")
public class CardControllor {
	
	private static final Logger logger = LoggerFactory.getLogger(CardControllor.class);
	private String thisUrl = "admin/card";
	
	@Autowired
	private CardService cardService;

	@Autowired
	private CodeService codeService;
	
	@RequestMapping(value = "cardList")
	public String list(Model model, HttpServletRequest request){
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		Map<String, String> paramMap = new HashMap<String, String>();
		String strEmpNo = sessionUser.getEmp_no();
		String strDeptCd = sessionUser.getDept_cd();
		String strTeamCd = sessionUser.getTeam_cd();
		String strUserGrpId = sessionUser.getUsr_grp_id();
		
		paramMap.put("dept_cd", strDeptCd);
		paramMap.put("team_cd", strTeamCd);
		
		//부서장  팀장 권한 분기 처리를 위한 정보 입력

		if("1".equals(strUserGrpId)) {
			model.addAttribute("getDeptList", codeService.createComboBox2("100"));
		}else if("2".equals(strUserGrpId)) {
			model.addAttribute("getDeptList", codeService.createComboBox3(strDeptCd));
		}else if("3".equals(strUserGrpId) || "4".equals(strUserGrpId)) {
			model.addAttribute("getDeptList", codeService.createComboBox4(paramMap));
		}
		
		model.addAttribute("USER_GRP_ID", strUserGrpId);
		
		return thisUrl + "/cardList";
	}
	
	@RequestMapping(value = "cardAllList")
	public String cardAllList(Card card, Model model, HttpServletRequest request){
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		card.setSession_id(sessionUser.getEmp_no());
		
		model.addAttribute("CardYm", card.getCard_ym().toString());
		model.addAttribute("Cards", cardService.getCarDtlInfoList(card));
		model.addAttribute("lastDay", cardService.getLastDay(card));
		model.addAttribute("holiDayList", cardService.getHoliDayList(card));
		
		return thisUrl + "/cardAllList";
	}
	
	

	@RequestMapping(value = "cardListAction", method = RequestMethod.POST)
	public String listAction(Model model, Card card, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		String strUserGrpId = sessionUser.getUsr_grp_id();
		card.setSession_id(sessionUser.getEmp_no());
		
		if("4".equals(strUserGrpId)) {
			card.setEmp_no(sessionUser.getEmp_no());
		}
		
		
		int count = cardService.getCardListCount(card);
		
		model.addAttribute("count", count); 
		model.addAttribute("pagingObject", card);
		model.addAttribute("cardUserList", cardService.getCardList(card));
		model.addAttribute("cardYmList", cardService.getCardYmList(card));
		
		return thisUrl + "/cardListAction";
	}
	
	@RequestMapping(value = "cmbAction", method = RequestMethod.POST)
	public String cmbAction(Model model, Card card, HttpServletRequest request) {
		String grpCd = card.getDept_cd();
		
		model.addAttribute("data", codeService.createComboBox2(grpCd));

		return thisUrl + "/cardList";
	}
	
	@RequestMapping(value = "cardPopup", method = RequestMethod.POST)
	public String customerPopup(Card card, Model model, HttpServletRequest request) throws Exception {
		
		//세션값 끌어오기
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		card.setSession_id(sessionUser.getEmp_no());

		String strParam = card.getEmp_no().toString();
		String[] arrPram = strParam.split(",");
		String strEmpNo = arrPram[0];
		String strCardYm = arrPram[1];
		card.setEmp_no(strEmpNo);
		card.setCard_ym(strCardYm);
		
		model.addAttribute("CardYm", strCardYm);
		model.addAttribute("CpltYn", cardService.chkCpltinfo(card));
		model.addAttribute("Card", cardService.getCarDtlInfo(card));
		model.addAttribute("lastDay", cardService.getLastDay(card));
		model.addAttribute("holiDayList", cardService.getHoliDayList(card));

		model.addAttribute("request", request);
		return thisUrl + "/cardPopup"; 
	}
	
	@RequestMapping(value = "updateAction", method = RequestMethod.POST)
	public String updateAction(Model model, @RequestBody Card card, HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		SessionUser sessionUser = (SessionUser) session.getAttribute(Consts.SessionAttr.USER);
		card.setSession_id(sessionUser.getEmp_no());
		
		cardService.updateAction(card);

		return thisUrl + "/cardPopup";
	}
}
