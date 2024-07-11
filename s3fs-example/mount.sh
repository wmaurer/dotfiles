#!/bin/sh

s3fs dma ./dma -o passwd_file=.cred,use_path_request_style,url=http://localhost:9000
s3fs dma-highres ./dma-highres -o passwd_file=.cred,use_path_request_style,url=http://localhost:9000

