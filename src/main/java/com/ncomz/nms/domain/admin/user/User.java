package com.ncomz.nms.domain.admin.user;

import java.sql.Date;

import com.ncomz.nms.domain.admin.common.Paging;

public class User extends Paging {

	/** cre_dt 를 String 으로 받기 위해(HistView 에서만 사용) */
	String cre_dt_st;
	
   /** 기본 정보 */
   String emp_no;
   String usr_nm;
   String usr_grp_id;
   String search_usr_grp_id;
   String srt_no;
   String gend_cd;
   String addr;
   String tel_no;
   String expln;
   Date cre_dt;
   int career_period; 
   int rownum;
   
   int file_id;
   String phy_file_nm;
   String ori_file_nm;
   String file_uri;
   
   String cell_no;
   String fax_no;
   String email;
   String mari_yn;
   String spe_abil;
   String mil_cd;
   String mil_strt_dt;
   String mil_end_dt;
   
   /**  사내 정보 */
   String dept_cd;
   String team_cd;
   String rank_cd;
   String psit_cd;
   String step_cd;
   String com_cd;
   String com_strt_dt;
   String worp_cd;
   String grade;
   Date upd_dt;
   
   /** 사내 정보 문자열 */
   String dept_cd_st;
   String team_cd_st;
   String rank_cd_st;
   String psit_cd_st;
   String step_cd_st;
   String grade_st;
   
   /** 검색 조건 */
   String search_date_type;
   String month_period;
   String search_month;
   
   /** 학력 정보 */
   String edu_seq;
   String schl_nm;
   String edu_strt_dt;
   String edu_end_dt;
   String major;
   String edu_remark;
   
   /** 자격증 정보 */
   String cert_seq;
   String cert_nm;
   String get_dt;
   String cert_remark;
   
   /** 경력 정보 */
   String carr_seq;
   String carr_com_nm;
   String carr_strt_dt;
   String carr_end_dt;
   String carr_rank_nm;
   String work;

   /** 업무경험 정보 */
   String task_seq;
   String prjt_nm;
   String rltd_com;
   String dev_strt_dt;
   String dev_end_dt;
   String my_role;
   String used_mdel;
   String used_os;
   String used_lang;
   String used_dbms;
   String used_dc;
   
   /** 공통 정보 */
   String cre_id;
   String upd_id;

   /** 비밀번호(변경) */
   String pwd_asis;
   String pwd_tobe;
public String getCre_dt_st() {
	return cre_dt_st;
}
public void setCre_dt_st(String cre_dt_st) {
	this.cre_dt_st = cre_dt_st;
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
public String getSearch_usr_grp_id() {
	return search_usr_grp_id;
}
public void setSearch_usr_grp_id(String search_usr_grp_id) {
	this.search_usr_grp_id = search_usr_grp_id;
}
public String getSrt_no() {
	return srt_no;
}
public void setSrt_no(String srt_no) {
	this.srt_no = srt_no;
}
public String getGend_cd() {
	return gend_cd;
}
public void setGend_cd(String gend_cd) {
	this.gend_cd = gend_cd;
}
public String getAddr() {
	return addr;
}
public void setAddr(String addr) {
	this.addr = addr;
}
public String getTel_no() {
	return tel_no;
}
public void setTel_no(String tel_no) {
	this.tel_no = tel_no;
}
public String getExpln() {
	return expln;
}
public void setExpln(String expln) {
	this.expln = expln;
}
public Date getCre_dt() {
	return cre_dt;
}
public void setCre_dt(Date cre_dt) {
	this.cre_dt = cre_dt;
}
public int getCareer_period() {
	return career_period;
}
public void setCareer_period(int career_period) {
	this.career_period = career_period;
}
public int getRownum() {
	return rownum;
}
public void setRownum(int rownum) {
	this.rownum = rownum;
}
public int getFile_id() {
	return file_id;
}
public void setFile_id(int file_id) {
	this.file_id = file_id;
}
public String getPhy_file_nm() {
	return phy_file_nm;
}
public void setPhy_file_nm(String phy_file_nm) {
	this.phy_file_nm = phy_file_nm;
}
public String getOri_file_nm() {
	return ori_file_nm;
}
public void setOri_file_nm(String ori_file_nm) {
	this.ori_file_nm = ori_file_nm;
}
public String getFile_uri() {
	return file_uri;
}
public void setFile_uri(String file_uri) {
	this.file_uri = file_uri;
}
public String getCell_no() {
	return cell_no;
}
public void setCell_no(String cell_no) {
	this.cell_no = cell_no;
}
public String getFax_no() {
	return fax_no;
}
public void setFax_no(String fax_no) {
	this.fax_no = fax_no;
}
public String getEmail() {
	return email;
}
public void setEmail(String email) {
	this.email = email;
}
public String getMari_yn() {
	return mari_yn;
}
public void setMari_yn(String mari_yn) {
	this.mari_yn = mari_yn;
}
public String getSpe_abil() {
	return spe_abil;
}
public void setSpe_abil(String spe_abil) {
	this.spe_abil = spe_abil;
}
public String getMil_cd() {
	return mil_cd;
}
public void setMil_cd(String mil_cd) {
	this.mil_cd = mil_cd;
}
public String getMil_strt_dt() {
	return mil_strt_dt;
}
public void setMil_strt_dt(String mil_strt_dt) {
	this.mil_strt_dt = mil_strt_dt;
}
public String getMil_end_dt() {
	return mil_end_dt;
}
public void setMil_end_dt(String mil_end_dt) {
	this.mil_end_dt = mil_end_dt;
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
public String getRank_cd() {
	return rank_cd;
}
public void setRank_cd(String rank_cd) {
	this.rank_cd = rank_cd;
}
public String getPsit_cd() {
	return psit_cd;
}
public void setPsit_cd(String psit_cd) {
	this.psit_cd = psit_cd;
}
public String getStep_cd() {
	return step_cd;
}
public void setStep_cd(String step_cd) {
	this.step_cd = step_cd;
}
public String getCom_cd() {
	return com_cd;
}
public void setCom_cd(String com_cd) {
	this.com_cd = com_cd;
}
public String getCom_strt_dt() {
	return com_strt_dt;
}
public void setCom_strt_dt(String com_strt_dt) {
	this.com_strt_dt = com_strt_dt;
}
public String getWorp_cd() {
	return worp_cd;
}
public void setWorp_cd(String worp_cd) {
	this.worp_cd = worp_cd;
}
public String getGrade() {
	return grade;
}
public void setGrade(String grade) {
	this.grade = grade;
}
public Date getUpd_dt() {
	return upd_dt;
}
public void setUpd_dt(Date upd_dt) {
	this.upd_dt = upd_dt;
}
public String getDept_cd_st() {
	return dept_cd_st;
}
public void setDept_cd_st(String dept_cd_st) {
	this.dept_cd_st = dept_cd_st;
}
public String getTeam_cd_st() {
	return team_cd_st;
}
public void setTeam_cd_st(String team_cd_st) {
	this.team_cd_st = team_cd_st;
}
public String getRank_cd_st() {
	return rank_cd_st;
}
public void setRank_cd_st(String rank_cd_st) {
	this.rank_cd_st = rank_cd_st;
}
public String getPsit_cd_st() {
	return psit_cd_st;
}
public void setPsit_cd_st(String psit_cd_st) {
	this.psit_cd_st = psit_cd_st;
}
public String getStep_cd_st() {
	return step_cd_st;
}
public void setStep_cd_st(String step_cd_st) {
	this.step_cd_st = step_cd_st;
}
public String getGrade_st() {
	return grade_st;
}
public void setGrade_st(String grade_st) {
	this.grade_st = grade_st;
}
public String getSearch_date_type() {
	return search_date_type;
}
public void setSearch_date_type(String search_date_type) {
	this.search_date_type = search_date_type;
}
public String getMonth_period() {
	return month_period;
}
public void setMonth_period(String month_period) {
	this.month_period = month_period;
}
public String getSearch_month() {
	return search_month;
}
public void setSearch_month(String search_month) {
	this.search_month = search_month;
}
public String getEdu_seq() {
	return edu_seq;
}
public void setEdu_seq(String edu_seq) {
	this.edu_seq = edu_seq;
}
public String getSchl_nm() {
	return schl_nm;
}
public void setSchl_nm(String schl_nm) {
	this.schl_nm = schl_nm;
}
public String getEdu_strt_dt() {
	return edu_strt_dt;
}
public void setEdu_strt_dt(String edu_strt_dt) {
	this.edu_strt_dt = edu_strt_dt;
}
public String getEdu_end_dt() {
	return edu_end_dt;
}
public void setEdu_end_dt(String edu_end_dt) {
	this.edu_end_dt = edu_end_dt;
}
public String getMajor() {
	return major;
}
public void setMajor(String major) {
	this.major = major;
}
public String getEdu_remark() {
	return edu_remark;
}
public void setEdu_remark(String edu_remark) {
	this.edu_remark = edu_remark;
}
public String getCert_seq() {
	return cert_seq;
}
public void setCert_seq(String cert_seq) {
	this.cert_seq = cert_seq;
}
public String getCert_nm() {
	return cert_nm;
}
public void setCert_nm(String cert_nm) {
	this.cert_nm = cert_nm;
}
public String getGet_dt() {
	return get_dt;
}
public void setGet_dt(String get_dt) {
	this.get_dt = get_dt;
}
public String getCert_remark() {
	return cert_remark;
}
public void setCert_remark(String cert_remark) {
	this.cert_remark = cert_remark;
}
public String getCarr_seq() {
	return carr_seq;
}
public void setCarr_seq(String carr_seq) {
	this.carr_seq = carr_seq;
}
public String getCarr_com_nm() {
	return carr_com_nm;
}
public void setCarr_com_nm(String carr_com_nm) {
	this.carr_com_nm = carr_com_nm;
}
public String getCarr_strt_dt() {
	return carr_strt_dt;
}
public void setCarr_strt_dt(String carr_strt_dt) {
	this.carr_strt_dt = carr_strt_dt;
}
public String getCarr_end_dt() {
	return carr_end_dt;
}
public void setCarr_end_dt(String carr_end_dt) {
	this.carr_end_dt = carr_end_dt;
}
public String getCarr_rank_nm() {
	return carr_rank_nm;
}
public void setCarr_rank_nm(String carr_rank_nm) {
	this.carr_rank_nm = carr_rank_nm;
}
public String getWork() {
	return work;
}
public void setWork(String work) {
	this.work = work;
}
public String getTask_seq() {
	return task_seq;
}
public void setTask_seq(String task_seq) {
	this.task_seq = task_seq;
}
public String getPrjt_nm() {
	return prjt_nm;
}
public void setPrjt_nm(String prjt_nm) {
	this.prjt_nm = prjt_nm;
}
public String getRltd_com() {
	return rltd_com;
}
public void setRltd_com(String rltd_com) {
	this.rltd_com = rltd_com;
}
public String getDev_strt_dt() {
	return dev_strt_dt;
}
public void setDev_strt_dt(String dev_strt_dt) {
	this.dev_strt_dt = dev_strt_dt;
}
public String getDev_end_dt() {
	return dev_end_dt;
}
public void setDev_end_dt(String dev_end_dt) {
	this.dev_end_dt = dev_end_dt;
}
public String getMy_role() {
	return my_role;
}
public void setMy_role(String my_role) {
	this.my_role = my_role;
}
public String getUsed_mdel() {
	return used_mdel;
}
public void setUsed_mdel(String used_mdel) {
	this.used_mdel = used_mdel;
}
public String getUsed_os() {
	return used_os;
}
public void setUsed_os(String used_os) {
	this.used_os = used_os;
}
public String getUsed_lang() {
	return used_lang;
}
public void setUsed_lang(String used_lang) {
	this.used_lang = used_lang;
}
public String getUsed_dbms() {
	return used_dbms;
}
public void setUsed_dbms(String used_dbms) {
	this.used_dbms = used_dbms;
}
public String getUsed_dc() {
	return used_dc;
}
public void setUsed_dc(String used_dc) {
	this.used_dc = used_dc;
}
public String getCre_id() {
	return cre_id;
}
public void setCre_id(String cre_id) {
	this.cre_id = cre_id;
}
public String getUpd_id() {
	return upd_id;
}
public void setUpd_id(String upd_id) {
	this.upd_id = upd_id;
}
public String getPwd_asis() {
	return pwd_asis;
}
public void setPwd_asis(String pwd_asis) {
	this.pwd_asis = pwd_asis;
}
public String getPwd_tobe() {
	return pwd_tobe;
}
public void setPwd_tobe(String pwd_tobe) {
	this.pwd_tobe = pwd_tobe;
}
@Override
public String toString() {
	return "User [cre_dt_st=" + cre_dt_st + ", emp_no=" + emp_no + ", usr_nm=" + usr_nm + ", usr_grp_id=" + usr_grp_id
			+ ", search_usr_grp_id=" + search_usr_grp_id + ", srt_no=" + srt_no + ", gend_cd=" + gend_cd + ", addr="
			+ addr + ", tel_no=" + tel_no + ", expln=" + expln + ", cre_dt=" + cre_dt + ", career_period="
			+ career_period + ", rownum=" + rownum + ", file_id=" + file_id + ", phy_file_nm=" + phy_file_nm
			+ ", ori_file_nm=" + ori_file_nm + ", file_uri=" + file_uri + ", cell_no=" + cell_no + ", fax_no=" + fax_no
			+ ", email=" + email + ", mari_yn=" + mari_yn + ", spe_abil=" + spe_abil + ", mil_cd=" + mil_cd
			+ ", mil_strt_dt=" + mil_strt_dt + ", mil_end_dt=" + mil_end_dt + ", dept_cd=" + dept_cd + ", team_cd="
			+ team_cd + ", rank_cd=" + rank_cd + ", psit_cd=" + psit_cd + ", step_cd=" + step_cd + ", com_cd=" + com_cd
			+ ", com_strt_dt=" + com_strt_dt + ", worp_cd=" + worp_cd + ", grade=" + grade + ", upd_dt=" + upd_dt
			+ ", dept_cd_st=" + dept_cd_st + ", team_cd_st=" + team_cd_st + ", rank_cd_st=" + rank_cd_st
			+ ", psit_cd_st=" + psit_cd_st + ", step_cd_st=" + step_cd_st + ", grade_st=" + grade_st
			+ ", search_date_type=" + search_date_type + ", month_period=" + month_period + ", search_month="
			+ search_month + ", edu_seq=" + edu_seq + ", schl_nm=" + schl_nm + ", edu_strt_dt=" + edu_strt_dt
			+ ", edu_end_dt=" + edu_end_dt + ", major=" + major + ", edu_remark=" + edu_remark + ", cert_seq="
			+ cert_seq + ", cert_nm=" + cert_nm + ", get_dt=" + get_dt + ", cert_remark=" + cert_remark + ", carr_seq="
			+ carr_seq + ", carr_com_nm=" + carr_com_nm + ", carr_strt_dt=" + carr_strt_dt + ", carr_end_dt="
			+ carr_end_dt + ", carr_rank_nm=" + carr_rank_nm + ", work=" + work + ", task_seq=" + task_seq
			+ ", prjt_nm=" + prjt_nm + ", rltd_com=" + rltd_com + ", dev_strt_dt=" + dev_strt_dt + ", dev_end_dt="
			+ dev_end_dt + ", my_role=" + my_role + ", used_mdel=" + used_mdel + ", used_os=" + used_os + ", used_lang="
			+ used_lang + ", used_dbms=" + used_dbms + ", used_dc=" + used_dc + ", cre_id=" + cre_id + ", upd_id="
			+ upd_id + ", pwd_asis=" + pwd_asis + ", pwd_tobe=" + pwd_tobe + "]";
}
		
}