package com.ncomz.nms.domain.admin.dashboard;

public class ProjectCnt {
	private String cur_yymm;//조회된 월
	private int total_cnt;  // 총 건수
	private int nc_cnt; 	// 미계약 건수
	private int yc_cnt; 	// 계약 건수
	private int yci_cnt;	// 계약되고 진행된 건수
	private int ycc_cnt;	// 계약되고 종료된 건수
		
	
	public String getCur_yymm() {
		return cur_yymm;
	}

	public void setCur_yymm(String cur_yymm) {
		this.cur_yymm = cur_yymm;
	}

	public int getTotal_cnt() {
		return total_cnt;
	}

	public void setTotal_cnt(int total_cnt) {
		this.total_cnt = total_cnt;
	}

	public int getNc_cnt() {
		return nc_cnt;
	}

	public void setNc_cnt(int nc_cnt) {
		this.nc_cnt = nc_cnt;
	}

	public int getYc_cnt() {
		return yc_cnt;
	}

	public void setYc_cnt(int yc_cnt) {
		this.yc_cnt = yc_cnt;
	}

	public int getYci_cnt() {
		return yci_cnt;
	}

	public void setYci_cnt(int yci_cnt) {
		this.yci_cnt = yci_cnt;
	}

	public int getYcc_cnt() {
		return ycc_cnt;
	}

	public void setYcc_cnt(int ycc_cnt) {
		this.ycc_cnt = ycc_cnt;
	}

	@Override
	public String toString() {
		return "ProjectCnt [cur_yymm=" + cur_yymm + ", total_cnt=" + total_cnt + ", nc_cnt=" + nc_cnt + ", yc_cnt=" + yc_cnt + ", yci_cnt=" + yci_cnt + ", ycc_cnt=" + ycc_cnt + "]";
	}
	
	
}
