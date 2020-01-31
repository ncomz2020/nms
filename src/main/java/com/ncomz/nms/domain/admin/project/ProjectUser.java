package com.ncomz.nms.domain.admin.project;

import java.sql.Date;

public class ProjectUser {
	int seq;
	String pjt_no;
	String emp_no;
	String usr_nm;
	String rank_cd;
	String strt_dt;
	String end_dt;
	String work_dt;
	String work_ect;
	String cre_id;
	Date cre_dt;
	String upd_id;
	Date upd_dt;
	
	String param_emp_no;
	String param_team_cd;
	String insertMM;
	String mem_strtdt;
	String mem_enddt;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getPjt_no() {
		return pjt_no;
	}
	public void setPjt_no(String pjt_no) {
		this.pjt_no = pjt_no;
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
	public String getRank_cd() {
		return rank_cd;
	}
	public void setRank_cd(String rank_cd) {
		this.rank_cd = rank_cd;
	}
	public String getStrt_dt() {
		return strt_dt;
	}
	public void setStrt_dt(String strt_dt) {
		this.strt_dt = strt_dt;
	}
	public String getEnd_dt() {
		return end_dt;
	}
	public void setEnd_dt(String end_dt) {
		this.end_dt = end_dt;
	}
	public String getWork_dt() {
		return work_dt;
	}
	public void setWork_dt(String work_dt) {
		this.work_dt = work_dt;
	}
	public String getWork_ect() {
		return work_ect;
	}
	public void setWork_ect(String work_ect) {
		this.work_ect = work_ect;
	}
	public String getCre_id() {
		return cre_id;
	}
	public void setCre_id(String cre_id) {
		this.cre_id = cre_id;
	}
	public Date getCre_dt() {
		return cre_dt;
	}
	public void setCre_dt(Date cre_dt) {
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
	public String getParam_emp_no() {
		return param_emp_no;
	}
	public void setParam_emp_no(String param_emp_no) {
		this.param_emp_no = param_emp_no;
	}
	public String getParam_team_cd() {
		return param_team_cd;
	}
	public void setParam_team_cd(String param_team_cd) {
		this.param_team_cd = param_team_cd;
	}
	public String getInsertMM() {
		return insertMM;
	}
	public void setInsertMM(String insertMM) {
		this.insertMM = insertMM;
	}
	public String getMem_strtdt() {
		return mem_strtdt;
	}
	public void setMem_strtdt(String mem_strtdt) {
		this.mem_strtdt = mem_strtdt;
	}
	public String getMem_enddt() {
		return mem_enddt;
	}
	public void setMem_enddt(String mem_enddt) {
		this.mem_enddt = mem_enddt;
	}
	@Override
	public String toString() {
		return "ProjectUser [seq=" + seq + ", pjt_no=" + pjt_no + ", emp_no=" + emp_no + ", usr_nm=" + usr_nm
				+ ", rank_cd=" + rank_cd + ", strt_dt=" + strt_dt + ", end_dt=" + end_dt + ", work_dt=" + work_dt
				+ ", work_ect=" + work_ect + ", cre_id=" + cre_id + ", cre_dt=" + cre_dt + ", upd_id=" + upd_id
				+ ", upd_dt=" + upd_dt + ", param_emp_no=" + param_emp_no + ", param_team_cd=" + param_team_cd
				+ ", insertMM=" + insertMM + ", mem_strtdt=" + mem_strtdt + ", mem_enddt=" + mem_enddt + "]";
	}
	
	
	
}
