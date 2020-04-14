package com.ncomz.nms.domain.admin.project;

import java.sql.Date;

import com.ncomz.nms.domain.admin.common.Paging;

public class Project extends Paging {
	
	// 4/14 수정
	String pjt_no;
	String pjt_name; 
	String pjt_type_cd;
	String check_yn;
	String check_yn_en;
	String cust_nm;
	String pm_nm;
	String dept_cd;
	String dept_cd_en;
	String team_cd;
	String cont_yn;
	String use_yn;
	String etc_yn;
	String etc_yn_en;
	Date strt_dt;
	Date end_dt;
	String cre_id;
	String cre_dt;
	String upd_id;
	Date upd_dt;
	String user_nm;
	int rownum;
	
	String search_check_yn;
	String pjt_strtdt;
	String pjt_enddt;
	String search_use_yn;
	String search_etc_yn;
	String search_pjt;
	String search_text;
	String param_dept_cd;
	String param_team_cd;
	String pre_pjt_no;
	
	public String getPjt_no() {
		return pjt_no;
	}
	public void setPjt_no(String pjt_no) {
		this.pjt_no = pjt_no;
	}
	public String getPjt_name() {
		return pjt_name;
	}
	public void setPjt_name(String pjt_name) {
		this.pjt_name = pjt_name;
	}
	public String getPjt_type_cd() {
		return pjt_type_cd;
	}
	public void setPjt_type_cd(String pjt_type_cd) {
		this.pjt_type_cd = pjt_type_cd;
	}
	public String getCheck_yn() {
		return check_yn;
	}
	public void setCheck_yn(String check_yn) {
		this.check_yn = check_yn;
	}
	public String getCheck_yn_en() {
		return check_yn_en;
	}
	public void setCheck_yn_en(String check_yn_en) {
		this.check_yn_en = check_yn_en;
	}
	public String getCust_nm() {
		return cust_nm;
	}
	public void setCust_nm(String cust_nm) {
		this.cust_nm = cust_nm;
	}
	public String getPm_nm() {
		return pm_nm;
	}
	public void setPm_nm(String pm_nm) {
		this.pm_nm = pm_nm;
	}
	public String getDept_cd() {
		return dept_cd;
	}
	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}
	public String getDept_cd_en() {
		return dept_cd_en;
	}
	public void setDept_cd_en(String dept_cd_en) {
		this.dept_cd_en = dept_cd_en;
	}
	public String getTeam_cd() {
		return team_cd;
	}
	public void setTeam_cd(String team_cd) {
		this.team_cd = team_cd;
	}
	public String getCont_yn() {
		return cont_yn;
	}
	public void setCont_yn(String cont_yn) {
		this.cont_yn = cont_yn;
	}
	public String getUse_yn() {
		return use_yn;
	}
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}
	public String getEtc_yn() {
		return etc_yn;
	}
	public void setEtc_yn(String etc_yn) {
		this.etc_yn = etc_yn;
	}
	public String getEtc_yn_en() {
		return etc_yn_en;
	}
	public void setEtc_yn_en(String etc_yn_en) {
		this.etc_yn_en = etc_yn_en;
	}
	public Date getStrt_dt() {
		return strt_dt;
	}
	public void setStrt_dt(Date strt_dt) {
		this.strt_dt = strt_dt;
	}
	public Date getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(Date end_dt) {
		this.end_dt = end_dt;
	}
	public String getCre_id() {
		return cre_id;
	}
	public void setCre_id(String cre_id) {
		this.cre_id = cre_id;
	}
	public String getCre_dt() {
		return cre_dt;
	}
	public void setCre_dt(String cre_dt) {
		this.cre_dt = cre_dt;
	}
	public String getUpd_id() {
		return upd_id;
	}
	public void setUpd_id(String upd_id) {
		this.upd_id = upd_id;
	}
	public Date getUpd_dt() {
		return upd_dt;
	}
	public void setUpd_dt(Date upd_dt) {
		this.upd_dt = upd_dt;
	}
	public String getUser_nm() {
		return user_nm;
	}
	public void setUser_nm(String user_nm) {
		this.user_nm = user_nm;
	}
	public int getRownum() {
		return rownum;
	}
	public void setRownum(int rownum) {
		this.rownum = rownum;
	}
	public String getSearch_check_yn() {
		return search_check_yn;
	}
	public void setSearch_check_yn(String search_check_yn) {
		this.search_check_yn = search_check_yn;
	}
	public String getPjt_strtdt() {
		return pjt_strtdt;
	}
	public void setPjt_strtdt(String pjt_strtdt) {
		this.pjt_strtdt = pjt_strtdt;
	}
	public String getPjt_enddt() {
		return pjt_enddt;
	}
	public void setPjt_enddt(String pjt_enddt) {
		this.pjt_enddt = pjt_enddt;
	}
	public String getSearch_use_yn() {
		return search_use_yn;
	}
	public void setSearch_use_yn(String search_use_yn) {
		this.search_use_yn = search_use_yn;
	}
	public String getSearch_etc_yn() {
		return search_etc_yn;
	}
	public void setSearch_etc_yn(String search_etc_yn) {
		this.search_etc_yn = search_etc_yn;
	}
	public String getSearch_pjt() {
		return search_pjt;
	}
	public void setSearch_pjt(String search_pjt) {
		this.search_pjt = search_pjt;
	}
	public String getSearch_text() {
		return search_text;
	}
	public void setSearch_text(String search_text) {
		this.search_text = search_text;
	}
	public String getParam_dept_cd() {
		return param_dept_cd;
	}
	public void setParam_dept_cd(String param_dept_cd) {
		this.param_dept_cd = param_dept_cd;
	}
	public String getParam_team_cd() {
		return param_team_cd;
	}
	public void setParam_team_cd(String param_team_cd) {
		this.param_team_cd = param_team_cd;
	}
	public String getPre_pjt_no() {
		return pre_pjt_no;
	}
	public void setPre_pjt_no(String pre_pjt_no) {
		this.pre_pjt_no = pre_pjt_no;
	}

	@Override
	public String toString() {
		return "Project [pjt_no=" + pjt_no + ", pjt_name=" + pjt_name + ", pjt_type_cd=" + pjt_type_cd + ", check_yn="
				+ check_yn + ", check_yn_en=" + check_yn_en + ", cust_nm=" + cust_nm + ", pm_nm=" + pm_nm + ", dept_cd="
				+ dept_cd + ", team_cd=" + team_cd + ", cont_yn=" + cont_yn + ", use_yn=" + use_yn + ", etc_yn="
				+ etc_yn + ", etc_yn_en=" + etc_yn_en + ", strt_dt=" + strt_dt + ", end_dt=" + end_dt + ", cre_id="
				+ cre_id + ", cre_dt=" + cre_dt + ", upd_id=" + upd_id + ", upd_dt=" + upd_dt + ", user_nm=" + user_nm
				+ ", rownum=" + rownum + ", search_check_yn=" + search_check_yn + ", pjt_strtdt=" + pjt_strtdt
				+ ", pjt_enddt=" + pjt_enddt + ", search_use_yn=" + search_use_yn + ", search_etc_yn=" + search_etc_yn
				+ ", search_pjt=" + search_pjt + ", search_text=" + search_text + ", param_dept_cd=" + param_dept_cd
				+ ", param_team_cd=" + param_team_cd + ", pre_pjt_no=" + pre_pjt_no + "]";
	}
	
}
