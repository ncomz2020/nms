package com.ncomz.nms.dao.admin.card;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.card.Card;

@Component
public interface CardMapper {

	List<Card> getCardUserList(Card card);
   
	Map<String, String>  getYnMap(Card card);

	Map<String, String> getYyyymmMap(Card card);

	List<Card> getCarDtlInfoList(Card card);

	String getLastDay(Card card);
	List<Card> getDateList(Card card);
	
	List<Card> chkProjectList(Card card);

	int getCardListCount(Card card);

	Map<String, String> chkCardInfo(Card card);

	void insertNullCardInfo(Card card);
	void insertNullCardDtlInfo(Card card);

	void updateCardDtlInfo(Card card);

	void updateFlag(Card card);

	Map<String, String> chkcardInfo(Card searchCard);

	Map<String, String> chkcardMastInfo(Card searchCard);

	List<Card> getUserList(Card card);

	List<Card> chkDtlWorkHrData(Card card);

	String chkCpltinfo(Card card);



}