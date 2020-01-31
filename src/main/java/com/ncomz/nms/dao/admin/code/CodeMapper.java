package com.ncomz.nms.dao.admin.code;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.code.Code;
import org.apache.ibatis.annotations.Param;

@Component
public interface CodeMapper {
   
   List<Code> getCodeList();
   List<Code> createComboBox(Code code);

   List<Code> createComboBox2(String grpCd); 
   List<Code> createComboBox3(String strDeptCd);
   List<Code> createComboBox4(Map<String, String> paramMap);
   
   Code getCode(Code code);
   List<Code> getGroupCodeList(@Param("grp_cd")String grp_cd);
   int checkDuplicate(Code code);

   int insertCode(Code code);
   
   int updateCodeInfo(Code code);

   int updateOldDisplayOrders(Code old);
   int updateNewDisplayOrders(Code old);
   int updateCodePosition(Code code);
   
   int getChildrenCount(Code code);
   int deleteCodeInfo(Code code);
   int updateCodeUseYn(Code code);
}



