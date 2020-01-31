package com.ncomz.nms.domain.admin.card;

import java.util.Arrays;
import java.util.List;

import com.ncomz.nms.domain.admin.common.Paging;

public class Card extends Paging {
  
	String emp_no;
	String usr_nm;
	String dept_cd;
	String dept_nm;
	String team_cd;
	String team_nm;
	String card_ym;
	String cplt_yn;
	
	String pjt_no;
	String pjt_nm;
	String pjt_type_cd;
	String pjt_type_nm;
	String work_hr;
	String dinn_yn;
	String[] arr_work_hr;
	String[] arr_dinn_yn;
	
	String cur_month;
	String one_month;
	String two_month;
	String cur_Ym;
	String one_Ym;
	String two_Ym;
	String chk_two_data;
	String chk_one_data;
	String chk_cur_data;
	String search_cplt_ym;
	String hldy_work_yn;
	String last_day;
	String hldy_yn;
	String nDay_yn;
	String sltd_date;
	String sltd_dd;
	String cplt_flag;
	String chk_number;
	String psit_cd;
	String session_id;
	int rownum;
	List<Card> cards;
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getUsr_nm() {
		return usr_nm;
	}
	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getDept_nm() {
		return dept_nm;
	}
	public void setDept_nm(String dept_nm) {
		this.dept_nm = dept_nm;
	}
	public String getTeam_cd() {
		return team_cd;
	}
	public void setTeam_cd(String team_cd) {
		this.team_cd = team_cd;
	}
	public String getTeam_nm() {
		return team_nm;
	}
	public void setTeam_nm(String team_nm) {
		this.team_nm = team_nm;
	}
	public String getCard_ym() {
		return card_ym;
	}
	public void setCard_ym(String card_ym) {
		this.card_ym = card_ym;
	}
	public String getCplt_yn() {
		return cplt_yn;
	}
	public void setCplt_yn(String cplt_yn) {
		this.cplt_yn = cplt_yn;
	}
	public String getPjt_no() {
		return pjt_no;
	}
	public void setPjt_no(String pjt_no) {
		this.pjt_no = pjt_no;
	}
	public String getPjt_nm() {
		return pjt_nm;
	}
	public void setPjt_nm(String pjt_nm) {
		this.pjt_nm = pjt_nm;
	}
	public String getPjt_type_cd() {
		return pjt_type_cd;
	}
	public void setPjt_type_cd(String pjt_type_cd) {
		this.pjt_type_cd = pjt_type_cd;
	}
	public String getPjt_type_nm() {
		return pjt_type_nm;
	}
	public void setPjt_type_nm(String pjt_type_nm) {
		this.pjt_type_nm = pjt_type_nm;
	}
	public String getWork_hr() {
		return work_hr;
	}
	public void setWork_hr(String work_hr) {
		this.work_hr = work_hr;
	}
	public String getDinn_yn() {
		return dinn_yn;
	}
	public void setDinn_yn(String dinn_yn) {
		this.dinn_yn = dinn_yn;
	}
	public String[] getArr_work_hr() {
		return arr_work_hr;
	}
	public void setArr_work_hr(String[] arr_work_hr) {
		this.arr_work_hr = arr_work_hr;
	}
	public String[] getArr_dinn_yn() {
		return arr_dinn_yn;
	}
	public void setArr_dinn_yn(String[] arr_dinn_yn) {
		this.arr_dinn_yn = arr_dinn_yn;
	}
	public String getCur_month() {
		return cur_month;
	}
	public void setCur_month(String cur_month) {
		this.cur_month = cur_month;
	}
	public String getOne_month() {
		return one_month;
	}
	public void setOne_month(String one_month) {
		this.one_month = one_month;
	}
	public String getTwo_month() {
		return two_month;
	}
	public void setTwo_month(String two_month) {
		this.two_month = two_month;
	}
	public String getCur_Ym() {
		return cur_Ym;
	}
	public void setCur_Ym(String cur_Ym) {
		this.cur_Ym = cur_Ym;
	}
	public String getOne_Ym() {
		return one_Ym;
	}
	public void setOne_Ym(String one_Ym) {
		this.one_Ym = one_Ym;
	}
	public String getTwo_Ym() {
		return two_Ym;
	}
	public void setTwo_Ym(String two_Ym) {
		this.two_Ym = two_Ym;
	}
	public String getChk_two_data() {
		return chk_two_data;
	}
	public void setChk_two_data(String chk_two_data) {
		this.chk_two_data = chk_two_data;
	}
	public String getChk_one_data() {
		return chk_one_data;
	}
	public void setChk_one_data(String chk_one_data) {
		this.chk_one_data = chk_one_data;
	}
	public String getChk_cur_data() {
		return chk_cur_data;
	}
	public void setChk_cur_data(String chk_cur_data) {
		this.chk_cur_data = chk_cur_data;
	}
	public String getSearch_cplt_ym() {
		return search_cplt_ym;
	}
	public void setSearch_cplt_ym(String search_cplt_ym) {
		this.search_cplt_ym = search_cplt_ym;
	}
	public String getHldy_work_yn() {
		return hldy_work_yn;
	}
	public void setHldy_work_yn(String hldy_work_yn) {
		this.hldy_work_yn = hldy_work_yn;
	}
	public String getLast_day() {
		return last_day;
	}
	public void setLast_day(String last_day) {
		this.last_day = last_day;
	}
	public String getHldy_yn() {
		return hldy_yn;
	}
	public void setHldy_yn(String hldy_yn) {
		this.hldy_yn = hldy_yn;
	}
	public String getnDay_yn() {
		return nDay_yn;
	}
	public void setnDay_yn(String nDay_yn) {
		this.nDay_yn = nDay_yn;
	}
	public String getSltd_date() {
		return sltd_date;
	}
	public void setSltd_date(String sltd_date) {
		this.sltd_date = sltd_date;
	}
	public String getSltd_dd() {
		return sltd_dd;
	}
	public void setSltd_dd(String sltd_dd) {
		this.sltd_dd = sltd_dd;
	}
	public String getCplt_flag() {
		return cplt_flag;
	}
	public void setCplt_flag(String cplt_flag) {
		this.cplt_flag = cplt_flag;
	}
	public String getChk_number() {
		return chk_number;
	}
	public void setChk_number(String chk_number) {
		this.chk_number = chk_number;
	}
	public String getPsit_cd() {
		return psit_cd;
	}
	public void setPsit_cd(String psit_cd) {
		this.psit_cd = psit_cd;
	}
	public String getSession_id() {
		return session_id;
	}
	public void setSession_id(String session_id) {
		this.session_id = session_id;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public List<Card> getCards() {
		return cards;
	}
	public void setCards(List<Card> cards) {
		this.cards = cards;
	}
	@Override
	public String toString() {
		return "Card [emp_no=" + emp_no + ", usr_nm=" + usr_nm + ", dept_cd=" + dept_cd + ", dept_nm=" + dept_nm
				+ ", team_cd=" + team_cd + ", team_nm=" + team_nm + ", card_ym=" + card_ym + ", cplt_yn=" + cplt_yn
				+ ", pjt_no=" + pjt_no + ", pjt_nm=" + pjt_nm + ", pjt_type_cd=" + pjt_type_cd + ", pjt_type_nm="
				+ pjt_type_nm + ", work_hr=" + work_hr + ", dinn_yn=" + dinn_yn + ", arr_work_hr="
				+ Arrays.toString(arr_work_hr) + ", arr_dinn_yn=" + Arrays.toString(arr_dinn_yn) + ", cur_month="
				+ cur_month + ", one_month=" + one_month + ", two_month=" + two_month + ", cur_Ym=" + cur_Ym
				+ ", one_Ym=" + one_Ym + ", two_Ym=" + two_Ym + ", chk_two_data=" + chk_two_data + ", chk_one_data="
				+ chk_one_data + ", chk_cur_data=" + chk_cur_data + ", search_cplt_ym=" + search_cplt_ym
				+ ", hldy_work_yn=" + hldy_work_yn + ", last_day=" + last_day + ", hldy_yn=" + hldy_yn + ", nDay_yn="
				+ nDay_yn + ", sltd_date=" + sltd_date + ", sltd_dd=" + sltd_dd + ", cplt_flag=" + cplt_flag
				+ ", chk_number=" + chk_number + ", psit_cd=" + psit_cd + ", session_id=" + session_id + ", rownum="
				+ rownum + ", cards=" + cards + "]";
	}
		
	
}