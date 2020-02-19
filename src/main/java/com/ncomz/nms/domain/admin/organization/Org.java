package com.ncomz.nms.domain.admin.organization;


public class Org  {

   String dept_cd;
   String team_cd;
   String dtl_cd_desc;
   String team;
   String usr_nm;
   String rank_nm;
   String cell_no;
   String grp_cd_desc;
   String emp_no;
   String psrt;
   String dept;
   String dtl_cd;
   int t_count;
   int d_count; 
   
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
	public String getDtl_cd_desc() {
		return dtl_cd_desc;
	}
	public void setDtl_cd_desc(String dtl_cd_desc) {
		this.dtl_cd_desc = dtl_cd_desc;
	}
	public String getTeam() {
		return team;
	}
	public void setTeam(String team) {
		this.team = team;
	}
	public String getUsr_nm() {
		return usr_nm;
	}
	public void setUsr_nm(String usr_nm) {
		this.usr_nm = usr_nm;
	}
	public String getRank_nm() {
		return rank_nm;
	}
	public void setRank_nm(String rank_nm) {
		this.rank_nm = rank_nm;
	}
	public String getCell_no() {
		return cell_no;
	}
	public void setCell_no(String cell_no) {
		this.cell_no = cell_no;
	}
	public String getGrp_cd_desc() {
		return grp_cd_desc;
	}
	public void setGrp_cd_desc(String grp_cd_desc) {
		this.grp_cd_desc = grp_cd_desc;
	}
	public String getEmp_no() {
		return emp_no;
	}
	public void setEmp_no(String emp_no) {
		this.emp_no = emp_no;
	}
	public String getPsrt() {
		return psrt;
	}
	public void setPsrt(String psrt) {
		this.psrt = psrt;
	}
	public String getDept() {
		return dept;
	}
	public void setDept(String dept) {
		this.dept = dept;
	}
	public String getDtl_cd() {
		return dtl_cd;
	}
	public void setDtl_cd(String dtl_cd) {
		this.dtl_cd = dtl_cd;
	}
	public int getT_count() {
		return t_count;
	}
	public void setT_count(int t_count) {
		this.t_count = t_count;
	}
	public int getD_count() {
		return d_count;
	}
	public void setD_count(int d_count) {
		this.d_count = d_count;
	}
	
	@Override
	public String toString() {
		return "Org [dept_cd=" + dept_cd + ", team_cd=" + team_cd + ", dtl_cd_desc=" + dtl_cd_desc + ", team=" + team
				+ ", usr_nm=" + usr_nm + ", rank_nm=" + rank_nm + ", cell_no=" + cell_no + ", grp_cd_desc=" + grp_cd_desc
				+ ", emp_no=" + emp_no + ", psrt=" + psrt + ", dept=" + dept + ", dtl_cd=" + dtl_cd + ", t_count="
				+ t_count + ", d_count=" + d_count + "]";
	}
    
}