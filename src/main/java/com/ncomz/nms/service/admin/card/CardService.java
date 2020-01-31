package com.ncomz.nms.service.admin.card;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ncomz.nms.dao.admin.card.CardMapper;
import com.ncomz.nms.domain.admin.card.Card;
import com.ncomz.nms.utility.HolidayUtil;
import com.ncomz.nms.utility.StringUtil;

@Service
public class CardService {
   
   private Logger logger = Logger.getLogger(this.getClass());
   
   @Autowired
   private CardMapper cardMapper;
   
   public List<Card> getCardList(Card card){
	   List<Card> cardUserList = cardMapper.getCardUserList(card);
	   String strYyyyMm = card.getSearch_cplt_ym().toString();
	   String strSessionId = card.getSession_id().toString();
	   
	  for (int i = 0; i < cardUserList.size(); i++) {
		  
		   Card searchCard = cardUserList.get(i);
		   searchCard.setSearch_cplt_ym(strYyyyMm);
		   searchCard.setSession_id(strSessionId);
		   
		   // 조회 년월 기준 2개월 전 타임카드 체크
		   try {
			   searchCard.setChk_number("2"); //날짜 계산을 위한 변수 데이터 입력
			   Map<String, String>  yn2 = cardMapper.getYnMap(searchCard);
			   cardUserList.get(i).setTwo_month(yn2.get("CPLT_YN")); // 등록 완료 플래그 
			   cardUserList.get(i).setTwo_Ym(yn2.get("CARD_YM"));
			   cardUserList.get(i).setCard_ym(yn2.get("CARD_YM"));
			   cardUserList.get(i).setChk_two_data("N"); // 상세 데이터 존재 여부 체크 풀래그
			   
				if ("N".equals(yn2.get("CPLT_YN").toString())) { 
				   List<Card> strChkdata = cardMapper.chkDtlWorkHrData(cardUserList.get(i));
					   
				   for (int j = 0; j < strChkdata.size(); j++) {
					   String chkYn = "N";
					   if (!StringUtil.isEmpty(strChkdata.get(j).getWork_hr().toString())) {
						   String strWkHr = strChkdata.get(j).getWork_hr().toString().replace(",", "");
						   String strDnYn = strChkdata.get(j).getDinn_yn().toString().replace(",", "");
						   
						   if(strWkHr.length() > 0 || strDnYn.length() > 0) {
							   chkYn = "Y";
							   cardUserList.get(i).setChk_two_data(chkYn);
						   }
					   }
					   if (chkYn == "Y") break;
				   }
				}else {
					cardUserList.get(i).setChk_two_data("Y");
				}
			
			// 등록 완료 플래그의 값이  NULL일 경우 
			} catch (NullPointerException e) {
				
				//입사일과 현재 계산된 년월을 비교하여 타임카드가 유효한지 채크
				Map<String, String> comStrtDtYn = cardMapper.chkcardMastInfo(searchCard);
				
				//
				if("Y".equals(comStrtDtYn.get("STRT_DT_YN"))) {
				   cardMapper.insertNullCardInfo(searchCard);
				   Map<String, String>  yn2 = cardMapper.getYnMap(searchCard);
				   cardUserList.get(i).setTwo_month(yn2.get("CPLT_YN"));
				   cardUserList.get(i).setTwo_Ym(yn2.get("CARD_YM"));
				   cardUserList.get(i).setChk_two_data("N");
				}
			}

		   // 조회 년월 기준 1개월 전 타임카드 체크
		   try {
			   searchCard.setChk_number("1");
			   Map<String, String>  yn1 = cardMapper.getYnMap(searchCard);
			   cardUserList.get(i).setOne_month(yn1.get("CPLT_YN"));
			   cardUserList.get(i).setOne_Ym(yn1.get("CARD_YM"));
			   cardUserList.get(i).setCard_ym(yn1.get("CARD_YM"));
			   cardUserList.get(i).setChk_one_data("N");
			   
				if ("N".equals(yn1.get("CPLT_YN").toString())) {
				   List<Card> strChkdata = cardMapper.chkDtlWorkHrData(cardUserList.get(i));
					   
				   for (int j = 0; j < strChkdata.size(); j++) {
					   String chkYn = "N";
					   if (!StringUtil.isEmpty(strChkdata.get(j).getWork_hr().toString())) {
						   String strWkHr = strChkdata.get(j).getWork_hr().toString().replace(",", "");
						   String strDnYn = strChkdata.get(j).getDinn_yn().toString().replace(",", "");
						   
						   if(strWkHr.length() > 0 || strDnYn.length() > 0) {
							   chkYn = "Y";
							   cardUserList.get(i).setChk_one_data(chkYn);
						   }
					   }
					   if (chkYn == "Y") break;
				   }
				}else {
					cardUserList.get(i).setChk_one_data("Y");
				}
				
			} catch (NullPointerException e) {
				
				Map<String, String> comStrtDtYn = cardMapper.chkcardMastInfo(searchCard);
				
				if("Y".equals(comStrtDtYn.get("STRT_DT_YN"))) {
				   cardMapper.insertNullCardInfo(searchCard);
				   Map<String, String>  yn1 = cardMapper.getYnMap(searchCard);
				   cardUserList.get(i).setOne_month(yn1.get("CPLT_YN"));
				   cardUserList.get(i).setOne_Ym(yn1.get("CARD_YM"));
				   cardUserList.get(i).setChk_one_data("N");
				}
			}

		   // 조회 년월  타임카드 체크
		   try {
			   searchCard.setChk_number("0");
			   Map<String, String>  yn = cardMapper.getYnMap(searchCard);
			   cardUserList.get(i).setCur_month(yn.get("CPLT_YN"));
			   cardUserList.get(i).setCur_Ym(yn.get("CARD_YM"));
			   cardUserList.get(i).setCard_ym(yn.get("CARD_YM"));
			   cardUserList.get(i).setChk_cur_data("N");
			   
				if ("N".equals(yn.get("CPLT_YN").toString())) {
				   List<Card> strChkdata = cardMapper.chkDtlWorkHrData(cardUserList.get(i));
					   
				   for (int j = 0; j < strChkdata.size(); j++) {
					   String chkYn = "N";
					   if (!StringUtil.isEmpty(strChkdata.get(j).getWork_hr().toString())) {
						   String strWkHr = strChkdata.get(j).getWork_hr().toString().replace(",", "");
						   String strDnYn = strChkdata.get(j).getDinn_yn().toString().replace(",", "");
						   
						   if(strWkHr.length() > 0 || strDnYn.length() > 0) {
							   chkYn = "Y";
							   cardUserList.get(i).setChk_cur_data(chkYn);
						   }
					   }
					   if (chkYn == "Y") break;
				   }
				}else {
					cardUserList.get(i).setChk_cur_data("Y");
				}
				
			} catch (NullPointerException e) {
				
				Map<String, String> comStrtDtYn = cardMapper.chkcardMastInfo(searchCard);
				
				if("Y".equals(comStrtDtYn.get("STRT_DT_YN"))) {
				   cardMapper.insertNullCardInfo(searchCard);
				   Map<String, String>  yn = cardMapper.getYnMap(searchCard);
				   cardUserList.get(i).setCur_month(yn.get("CPLT_YN"));
				   cardUserList.get(i).setCur_Ym(yn.get("CARD_YM"));
				   cardUserList.get(i).setChk_cur_data("N");
				}
			}
		} 
		   
      return cardUserList;
   }

   public Map<String, String> getCardYmList(Card card){
	   Map<String, String>  cardYmList  = cardMapper.getYyyymmMap(card);
      return cardYmList;
   }

   
public List<Card> getCarDtlInfo(Card card) {
	
	List<Card> chkCardDtlInfoList = cardMapper.chkProjectList(card);
	
	for(int i = 0; i < chkCardDtlInfoList.size(); i++) {
		card.setPjt_no(chkCardDtlInfoList.get(i).getPjt_no().toString());
		
		try {
			Map<String, String> chkCardInfo = cardMapper.chkCardInfo(card);
			String strPjtNo = chkCardInfo.get("PJT_NO").toString();
		} catch (NullPointerException e) {
			cardMapper.insertNullCardDtlInfo(card);
		}
	}
	
	
	List<Card> carDtlInfolist = cardMapper.getCarDtlInfoList(card);
	
	for(int i = 0; i < carDtlInfolist.size(); i++ ) {
		String[] arrWorkHr = carDtlInfolist.get(i).getWork_hr().split(",");
		String[] arrDinnYn = carDtlInfolist.get(i).getDinn_yn().split(",");
		carDtlInfolist.get(i).setArr_work_hr(arrWorkHr);
		carDtlInfolist.get(i).setArr_dinn_yn(arrDinnYn);
	}
	
	return carDtlInfolist;
}

public List<List<Card>> getCarDtlInfoList(Card card) {
	List<List<Card>> resultList = new ArrayList<List<Card>>();
	List<Card> cardUserList = cardMapper.getUserList(card);
	
	for (int i = 0; i < cardUserList.size(); i++) {
		String strUsrNm = cardUserList.get(i).getUsr_nm().toString();
		
		card.setEmp_no(cardUserList.get(i).getEmp_no().toString());
		List<Card> chkCardDtlInfoList = cardMapper.chkProjectList(card);
		
		if(chkCardDtlInfoList.size() > 0) {
			for(int j = 0; j < chkCardDtlInfoList.size(); j++) {
				card.setPjt_no(chkCardDtlInfoList.get(j).getPjt_no().toString());
				
				try {
					Map<String, String> chkCardInfo = cardMapper.chkCardInfo(card);
					String strPjtNo = chkCardInfo.get("PJT_NO").toString();
				} catch (NullPointerException e) {
					cardMapper.insertNullCardDtlInfo(card);
				}
			}
			
			List<Card> carDtlInfolist = cardMapper.getCarDtlInfoList(card);
			
			try {
				for(int j = 0; j < carDtlInfolist.size(); j++ ) {
					String[] arrWorkHr = carDtlInfolist.get(j).getWork_hr().split(",");
					String[] arrDinnYn = carDtlInfolist.get(j).getDinn_yn().split(",");
					carDtlInfolist.get(j).setArr_work_hr(arrWorkHr);
					carDtlInfolist.get(j).setArr_dinn_yn(arrDinnYn);
				}
			} catch (Exception e) {
			}
			if(carDtlInfolist.size() > 0) {
				resultList.add(carDtlInfolist);
			}
		}
	}
	
	return resultList;
}

public String getLastDay(Card card) {
	return cardMapper.getLastDay(card);
}

public int getCardListCount(Card card) {
	return cardMapper.getCardListCount(card);
} 

public List<Card> getHoliDayList(Card card) {
	card.setLast_day(cardMapper.getLastDay(card));
	List<Card> resultList = cardMapper.getDateList(card);
	int friDaycount = 0;
	for (int i = 0; i < resultList.size(); i++) {
		String strDate = resultList.get(i).getSltd_date().toString();
		
		if(HolidayUtil.isHoliday(strDate) == true) {
			resultList.get(i).setHldy_yn("Y");
		}else {
			resultList.get(i).setHldy_yn("N");
		}
		
		if(HolidayUtil.getDayOfWeek(strDate) == 6) {
			friDaycount++;
			if(friDaycount == 2 || friDaycount == 4) {
				resultList.get(i).setnDay_yn("Y");
			}else {
				resultList.get(i).setnDay_yn("N");
			}
		}else {
			resultList.get(i).setnDay_yn("N");
		}
	}
	return resultList;
}


public String updateAction(Card cd) {
	String strClptFlag = cd.getCplt_flag().toString();
	String strSessionId = cd.getSession_id().toString();
	Card cardInfo = new Card();
	cardInfo.setEmp_no(cd.getEmp_no().toString());
	cardInfo.setCard_ym(cd.getCard_ym().toString());
	cardInfo.setSession_id(strSessionId);
	try {
		for( Card card : cd.getCards() ) {
			card.setSession_id(strSessionId);
			if(!StringUtil.isEmpty(card.getEmp_no())) {
				cardMapper.updateCardDtlInfo(card);
			}
		}
		
		if( "complete".equals(strClptFlag)) {
			cardInfo.setCplt_yn("Y");
			cardMapper.updateFlag(cardInfo);
		}
		if ("cancel".equals(strClptFlag)) {
			cardInfo.setCplt_yn("N");
			cardMapper.updateFlag(cardInfo);
		}
	} catch (Exception e) {
		return "FAIL";
	}
	return "SUCCESS";
}

public String chkCpltinfo(Card card) {
	
	return cardMapper.chkCpltinfo(card);
}


}
