Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90F2606A32A
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=VrO9xm18;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gC7sQw2X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5223112125;
	Thu, 19 Nov 2026 08:25:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22E511120EB
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:52 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AJ6wJqd1535014
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XmnV20EgYdZ6WHZOYmnC4o5067U+QHuhBOnh8ncnbKE=; b=VrO9xm18ONRb/NpU
 ylhuJwFJC18TsRYVQI8/SQj6MbM3eK+dw0JQw5HXlP9I3ifGujNNcoZeInhtGm3a
 /Qpg904QrZOZWGHr/amauHr7iz48KN12fEe3KC76iD+AsLI5VSgfzRdGb2mO9zoE
 f/JKGGaPzc54fF/An2cB94r+hpl8UBMcOYoT7ef7sEg95GennkG6eFYRpYyzS8pC
 IuqzOLjUM5ZPe96APeEYyxdkweg15iEdki/y6qmzIxK74S9p5NFkEhklztfebUK0
 LVI3o8VhriDGVo5KK1n4yaMDfCLwzkLen7mFH0eo9vomH9TAy28IFW26XsfUr/J6
 wT/87g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j1dpcc5h3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:24:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so384381785a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 00:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795076690; x=1795681490;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XmnV20EgYdZ6WHZOYmnC4o5067U+QHuhBOnh8ncnbKE=;
 b=gC7sQw2XQLJei5Ha20/4T5VpnrcJd2whljiEBVYLqvsW0nPXFG5EzmYzA422S/+0Dp
 CT8fcYcLjkbuTSbM33duxoZxPEBxNy7QqwMdd7hOEIi4VGf5vqfvf90dR+HphWzUlkQO
 ccq1TAWTCBUPyOZyDB6bBZZxf7EXv8+sfcoZA/HeJT8+lwVcLk6jhw187yRHSzHJxURr
 AtiYVGYZ6nRtg2M+CFHRwkdCbjGmcqU/Ukbxo3bFNtId70kcL7QXnS51qwQFSyHnYmwX
 RPrEiogr8bf2sSrefu6DsrK5EnwxrEtoabSOlmjCsn5LG5QjRi4tacwaBO01d3hvC8bI
 yHew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795076690; x=1795681490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XmnV20EgYdZ6WHZOYmnC4o5067U+QHuhBOnh8ncnbKE=;
 b=K2uw4rvqcuJ4vXbGsJES7Zai+kJHXiFCCbLIb7simIERp/Y6+l4ekBTeZ1f+d67w/k
 vxxjgkc9Y3y10m7Vx7sIaaidymZjRs67uWUqu6eVFo5Xs/DEZf2v2A2hM8/C9TYrh148
 2mRqLxceevX3RCnBFSW/sop31t6EGnMHloUN6K1099hRAPhaKYEx7vIdLpbUp0daQRN0
 aQW9CIrOXjROLOX/lgOKndtu2Vgl8YJ9ASo41yi7PKkPERLp4yuMe1/GAsUDmRm08U+z
 Aff9dOoRhkJZ/Q0OZsiocpzbrwYhKjsKc369Hqti3S3j2FC5A2LfHqREwP7a+xIvYYJ+
 7aRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGCLm2dzgeap1J1Be4RhkLK7FdrBCySek4lVF2vFIMhWoFoy+pKj3byGplN1p4QmDamtaV4JMH3NzE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/vaFn2tzI5160HYZiVjZ7cfFHbZigwWLQhohYuIUbM7xJ0CtNf
 C8E1cljUOZPXsA7RWTK+bcjlb9m0B09hohWpph9m2eo7eTl++EPBp9uCn0G9z9neFjjUd+TjNK9
 nHiY7Mzl2IBmFF1NN0whD25K0Pny9lJAWKsY58vWdCBTq9QCi2JTo/ZoxOIf90ZTdE0qDEfQ=
X-Gm-Gg: AYBFou2DHe2tK5FwJYprk7CRL7BM7gwckb5NQ6/o8jZNsDV60ajatU83OO9+u5gZObx
 tc0TFhFivIRUr5ZD1TgbL6qtiYeyW6kjAk63pJoHN9McobMFMXLkEhDX2rAMh/SNe3P3rvba8ui
 2sFCWNxkGAJRiD8YLfnDx2dg/tTL9dToUYMuL5xNEnQv9/ONjeg+w/mfI3lYaaqUAU6JfeDAcET
 x4BgP22w0Arwz/NPti9m+eKY7vUcni4fJKEXBSc4PepYaFMgF9Uks7gHGr1cNALkv866dXSJIyh
 bQ4oO9xqHjsxSi3r1OHuXiWE9oOncWjU2+ezE4oy+MsPDk00WQyNn72e4yhyBDUL8Iwp94zlknb
 x05RUk0YCoWzv81QXa4GtcDHWsvuOHK1P8YbIKPdE1bNNljjlgLsIGroC43lbrkz4dMbxs1JUX9
 ZpDP8ERvcH3kGsydPH6Nz+3UNmmYDDgylh0ReW
X-Received: by 2002:a05:620a:198f:b0:949:5cb8:6be5 with SMTP id
 af79cd13be357-94999635325mr1037947285a.76.1795076690442; 
 Thu, 19 Nov 2026 00:24:50 -0800 (PST)
X-Received: by 2002:a05:620a:198f:b0:949:5cb8:6be5 with SMTP id
 af79cd13be357-94999635325mr1037943585a.76.1795076689957; 
 Thu, 19 Nov 2026 00:24:49 -0800 (PST)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b721861sm388465185a.11.2026.11.19.00.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 00:24:49 -0800 (PST)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Thu, 19 Nov 2026 16:24:06 +0800
Subject: [PATCH v9 04/29] drm/msm/dp: no need to update tu calculation for mst
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261119-msm-dp-mst-v9-4-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
In-Reply-To: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795076662; l=1017;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=TSeJBOLP1a7Z+WiBEdBGkjRZywx54RLAhctKfShmiQk=;
 b=TOfUhEt15F6oXulgckSfuYLjMgPa7VHHyJlfGqx/ohK3le0yLRWLeDePU9ls1G8NEqZi3FHuB
 11hVZOqIp9qDdhyK6ka0eo90NIkcG634zNnw0Bro+M66ys+2g/sMgwU
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Authority-Analysis: v=2.4 cv=YJ0KWhGx c=1 sm=1 tr=0 ts=6afeb253 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8 a=Hn_uEZNTG89lqFF_qI8A:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfX0BbNl80VIngI
 bnVusfIJu6ONi0f33LWPO8TtRzTUpB0idaD14CAkb+aLLwO8y3mFAIFeiB94mLuKecyqmmpaK1j
 MXNKqkZTURx24jNkdpL5Xl2rlrvDSYTrRO7Z4cDfnnGQ9XaiGennwOWrkWNiItKc1SSK5yMe//p
 xdYFX70aBh6hGIZCVwokd1e4k1WwDWgjEvkigH9oAeSQzrSAj9XzR/oPnIZAciZJUhslLYHB87h
 V+5sHni9RngU8cZH10f4KUZOOaVV6RbuVgXfyUbpQQIo+k+qAXIuLZpU8d2BfZP1mEg8OZZ0J3B
 7w1myDf9W9qjLmBXPT3YOJWY2UcxOO8hur16o7Cwv7rM/T34khB4kMUCqFLExJZEaebR4olm7Qk
 GTniOqp+5tW54IopI0Z4dC6BUnbGnTntm402s+tvnKE25gFOjM8I74Dp4p5NPI65DAongL5aeW4
 M6se50FfYA6iAMQZ9Sw==
X-Proofpoint-ORIG-GUID: 89fPtXa7Zx7wfGfoAHrxX6iurMpwXtEp
X-Proofpoint-GUID: 89fPtXa7Zx7wfGfoAHrxX6iurMpwXtEp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE5MDAzMyBTYWx0ZWRfXyfEWfE1QUuNi
 Y+voL9IRpm9tGhdykOwp3z+iBp/7faPCtdsD7YUeL/MfzZ9WLHjiqgkSuo4lmC3GAgry92BNKkm
 fYKKG73hPQ59EasyEXnpgYvsaDAjzkU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-19_02,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 adultscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611190033
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Abhinav Kumar <quic_abhinavk@quicinc.com>

DP stream is transmitted in transfer units only for SST
case, there is no need to calculate and program TU parameters
for MST case. Skip the TU programming for MST cases.

Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_ctrl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp_ctrl.c
index 41c653652695..f3f97a800a73 100644
--- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
+++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
@@ -2712,7 +2712,8 @@ int msm_dp_ctrl_on_stream(struct msm_dp_ctrl *msm_dp_ctrl, struct msm_dp_panel *
 
 	msm_dp_panel_clear_dsc_dto(panel);
 
-	msm_dp_ctrl_setup_tr_unit(ctrl, panel);
+	if (!ctrl->mst_mode)
+		msm_dp_ctrl_setup_tr_unit(ctrl, panel);
 
 	msm_dp_write_link(ctrl, REG_DP_STATE_CTRL, DP_STATE_CTRL_SEND_VIDEO);
 

-- 
2.43.0

