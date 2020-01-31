package com.ncomz.nms.dao.admin.user;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.user.User;

@Component
public interface UserMapper {
   
	
   //직원 리스트
   List<User> getUserList(User user);
   int getUserListCount(User user);
   int deleteUser(String emp_no);
   
   //직원 정보 조회
   List<User> getUserInfo(User user);  //기본,사내정본
   List<User> getUserEdu(User user);   //학력사항
   List<User> getUserCert(User user);  //자격사항
   List<User> getUserCarr(User user);  //경력사항
   List<User> getUserTask(User user);  //주요업무 경험사항
   
   String getUserPassword(User user);
   
   int chkUserEmpNo(String emp_no);
   int chkComEmpNo(String emp_no);
   int chkEduEmpNo(String emp_no);
   int chkCertEmpNo(String emp_no);
   int chkCareerEmpNo(String emp_no);
   int chkTsakEmpNo(String emp_no);
   
   
   //update
   void updateUseYnAction(User user);
   void updateUserInfo(User user);
   void updateComInfo(User user);
   void updateUserPassword(User user);
   
   //insert
   String newEmpNo();
   void insertUserInfo(User user);
   void insertComInfo(User user);
   void insertEduInfo(User user);
   void insertCertInfo(User user);
   void insertCareerInfo(User user);
   void insertTaskInfo(User user);
   void deleteEduInfo(String emp_no);
   void deleteCertInfo(String emp_no);  
   void deleteCareerInfo(String emp_no);
   void deleteTaskInfo(String emp_no);
   
   //엑셀 다운로드
   List<User> getUserListExcel(User user);
}