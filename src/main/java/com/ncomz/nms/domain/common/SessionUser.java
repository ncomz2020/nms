package com.ncomz.nms.domain.common;

import java.io.Serializable;

import com.thoughtworks.xstream.annotations.XStreamAlias;

@XStreamAlias("sessionUser")
public class SessionUser implements Serializable{
	
	/** Serializable serialVersionUID.  */
	private static final long serialVersionUID = 3682840049882805288L;

	/** 사용자 ID. */
	private String usr_id;
	
	/** 사번. */
	private String emp_no;

	/** 사용자 이름. */
	private String usr_nm;

	/** 사용자 그룹 ID. */
	private String usr_grp_id;

	/** 사용자 그룹명. */
	private String usr_grp_nm;

	/** 사용자 그룹 래벨. */
	private String usr_grp_lv;

	/** IP대역. */
	private String ip_band;

	/** Login Gateway IP. */
	private String login_gw_ip;

	/** 최종 로그인 일자. */
	private String lst_login_dt;

	/** 최종 로그인 시간. */
	private String lst_login_tm;

	/** 부서명 */
	private String dept_cd;
	
	/** 팀명 */
	private String team_cd;
	
	/** 직책 */
	private String psit_cd;
	
	/** 직급 */
	private String rank_cd;
	
	public String getUsr_id() {
		return usr_id;
	}

	public void setUsr_id(String usr_id) {
		this.usr_id = usr_id;
	}
	
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

	public String getUsr_grp_id() {
		return usr_grp_id;
	}

	public void setUsr_grp_id(String usr_grp_id) {
		this.usr_grp_id = usr_grp_id;
	}

	public String getUsr_grp_nm() {
		return usr_grp_nm;
	}

	public void setUsr_grp_nm(String usr_grp_nm) {
		this.usr_grp_nm = usr_grp_nm;
	}

	public String getUsr_grp_lv() {
		return usr_grp_lv;
	}

	public void setUsr_grp_lv(String usr_grp_lv) {
		this.usr_grp_lv = usr_grp_lv;
	}

	public String getIp_band() {
		return ip_band;
	}

	public void setIp_band(String ip_band) {
		this.ip_band = ip_band;
	}

	public String getLogin_gw_ip() {
		return login_gw_ip;
	}

	public void setLogin_gw_ip(String login_gw_ip) {
		this.login_gw_ip = login_gw_ip;
	}

	public String getLst_login_dt() {
		return lst_login_dt;
	}

	public void setLst_login_dt(String lst_login_dt) {
		this.lst_login_dt = lst_login_dt;
	}

	public String getLst_login_tm() {
		return lst_login_tm;
	}

	public void setLst_login_tm(String lst_login_tm) {
		this.lst_login_tm = lst_login_tm;
	}


	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getDept_cd() {
		return dept_cd;
	}

	public void setDept_cd(String dept_cd) {
		this.dept_cd = dept_cd;
	}

	public String getTeam_cd() {
		return team_cd;
	}

	public void setTeam_cd(String team_cd) {
		this.team_cd = team_cd;
	}

	public String getPsit_cd() {
		return psit_cd;
	}

	public void setPsit_cd(String psit_cd) {
		this.psit_cd = psit_cd;
	}

	public String getRank_cd() {
		return rank_cd;
	}

	public void setRank_cd(String rank_cd) {
		this.rank_cd = rank_cd;
	}
	
	
	@Override
	public String toString() {
		return "SessionUser [usr_id=" + usr_id +", emp_no=" + emp_no + ", usr_nm=" + usr_nm + ", usr_grp_id=" + usr_grp_id + ", usr_grp_nm=" + usr_grp_nm
				+ ", usr_grp_lv=" + usr_grp_lv + ", ip_band=" + ip_band + ", login_gw_ip=" + login_gw_ip + ", lst_login_dt="
				+ lst_login_dt + ", lst_login_tm=" + lst_login_tm + ", dept_cd=" + dept_cd + ", team_cd=" + team_cd + ", psit_cd=" + psit_cd + ", rank_cd=" + rank_cd + "]";
	}
}
