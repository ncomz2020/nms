package com.ncomz.nms.domain.admin.dashboard;

public class TeamCnt {

	private int team_capa;
	private String team_nm;
	private String team_nm_en;
	private int total_capa;
   
	public int getTeam_capa() {
		return team_capa;
	}
	public void setTeam_capa(int team_capa) {
		this.team_capa = team_capa;
	}
	public String getTeam_nm() {
		return team_nm;
	}
	public void setTeam_nm(String team_nm) {
		this.team_nm = team_nm;
	}
	public String getTeam_nm_en() {
		return team_nm_en;
	}
	public void setTeam_nm_en(String team_nm_en) {
		this.team_nm_en = team_nm_en;
	}
	public int getTotal_capa() {
		return total_capa;
	}
	public void setTotal_capa(int total_capa) {
		this.total_capa = total_capa;
	}

	@Override
	public String toString() {
		return "TeamCnt [team_capa=" + team_capa + ", team_nm=" + team_nm + ", team_nm_en=" + team_nm_en
				+ ", total_capa=" + total_capa + "]";
	}
	
}