package com.ncomz.nms.dao.login;

import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.common.SessionUser;
import com.ncomz.nms.domain.authorization.User;

@Component
public interface LoginMapper {

	/**
	 * 세션 유저 조회.
	 *
	 * @param usrId 사용자ID
	 * @param password 비밀번호
	 * @return SessionUser
	 */
	SessionUser login(@Param("usrId")String usrId, @Param("pswd")String pswd);

	/**
	 * 새로운 계정 생성
	 * 
	 * @param user
	 * @return
	 */
	boolean insertNewMember(User user);

	
	/**
	 * 유저 존재 유무 확인
	 * 
	 * @param textId
	 * @return
	 */
	int countPresenceId(String textId);

}
