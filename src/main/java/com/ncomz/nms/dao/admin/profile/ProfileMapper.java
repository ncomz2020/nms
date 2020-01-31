package com.ncomz.nms.dao.admin.profile;

import java.util.List;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.user.User;

@Component
public interface ProfileMapper {
   
   // 직원 프로필 이력
   List<User> getProfileHistoryList(User user);
   int getProfileHistoryListCount(User user);
   
   // 직원 프로필 이력 가져오기 
   List<User> getProfileUserHist(User user);
   List<User> getProfileEduHist(User user);
   List<User> getProfileCertHist(User user);
   List<User> getProfileCarrHist(User user);
   List<User> getProfileTaskHist(User user);
   
   // 직원 프로필
   List<User> getProfileList(User user);
   int getProfileListCount(User user);
   
   // 직원 프로필 가져오기 (입력폼, 수정폼)
   List<User> getProfileUser(String emp_no);
   List<User> getProfileEdu(String emp_no);
   List<User> getProfileCert(String emp_no);
   List<User> getProfileCarr(String emp_no);
   List<User> getProfileTask(String emp_no);
   
   // 직원 정보 삽입 (프로필 히스토리에 추가)
   void insertProfileUserHist(User user);
   void insertProfileComHist(User user);
   void insertProfileEduHist(User user);
   void insertProfileCertHist(User user);
   void insertProfileCarrHist(User user);
   void insertProfileTaskHist(User user);
   
   // 직원 정보 삽입 전 delete 
   void deleteProfileEdu(String emp_no);
   void deleteProfileCert(String emp_no);
   void deleteProfileCarr(String emp_no);
   void deleteProfileTask(String emp_no);
   
   // 직원 정보 수정
   void updateProfileUser(User user);
   void updateProfileCom(User user);
   void insertProfileEdu(User user);
   void insertProfileCert(User user);
   void insertProfileCarr(User user);
   void insertProfileTask(User user);
   
   // 목록에서 직원 감추기
   void hideUser(String emp_no);
   
   //엑셀 다운로드
   List<User> getProfileListExcel(User user);
   List<User> getProfileHistListExcel(User user);
   
}