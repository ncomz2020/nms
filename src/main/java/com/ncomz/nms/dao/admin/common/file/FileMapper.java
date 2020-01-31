package com.ncomz.nms.dao.admin.common.file;

import org.springframework.stereotype.Component;

import com.ncomz.nms.domain.admin.common.FileInfo;

@Component
public interface FileMapper {

	int insertFile(FileInfo fileInfo);

	int updateFile(FileInfo fileInfo);
	
	int selectFileId();

	
}