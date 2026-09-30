Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAEECA5FC7
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 15:26:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8344610E1EF;
	Wed, 30 Sep 2026 15:26:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="JGiX/Y7n";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X4WY32uE";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7B810E05E
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:26:54 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68UDxqxg3668540
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=Dcex1xAebPX4V0UA2DmDO6IM9OBE2nimJwk
 C2WwGyEM=; b=JGiX/Y7nw2ZjqIJRgzSr0GNYoSezaWXAwU69BVP7X/wC04Akdi3
 dCTSW/79Ka/Rtef5PRuaZq6TKJfuNTpGuPMBL8nlXchQrAJJPvilc9EQgAPIQggy
 wfmY1VexiAOZDnQVsj9e9hDz667wo8dQj9udK2ioorZwrkqxOlEI72DHvke95tMh
 6jAPl6rggSzPmnmdD0BzJ+5nrfkdmvdg0/tpGuLA/ufFMqIbRm3F8Q/MKirdUMmU
 nrahXan0w6lTLkDISLADJwtmQSkjHRVV9jsdiQdvcaiGGS/463vAUzYFugv4NMNK
 9tP7OXfllCzkdMNWFZa3cj/LRevXUqPwsUg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0rj2ujx0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 15:26:53 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-530f49fc5ffso163508831cf.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 08:26:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790782013; x=1791386813;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dcex1xAebPX4V0UA2DmDO6IM9OBE2nimJwkC2WwGyEM=;
 b=X4WY32uEzJobrmwPlo594I/yKY4lWd6i93ghL668wLmMu1Ww0WmqxxlJm+QSbWLyV+
 qb4rBJcZCPQEPOXkQmxCm8DTZEaINv+6fU+mkbQ2EbnOJZ97S3ZRSqclN4eASek8GC0P
 lttGergSaQSo4BIAG6kFD2v+43d1mxDestMUFHaaZQtheuB92ePAuVyXw4HXNlPPyjqX
 adVbQrDHP0R9Rwxs8HjSsAiGq5SfoGrvzS2ox86ZvNKIjQYnUUaC9EqO3zn2X5sYoYFv
 Shdy77sEw3dhNMpn3394m7XtaMMiCqUEAKhNaex4Na2708UgEj5OClY9NSrSsr7itNEL
 mXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790782013; x=1791386813;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Dcex1xAebPX4V0UA2DmDO6IM9OBE2nimJwkC2WwGyEM=;
 b=2E/wPgRk56Vb+vwdFWGO8hiGmEYVUGexBe2kNiSUoEmEAJfVgeNwKgyiVQvWDkw6yd
 NB3g9qCP0OXEf0SkT/tbMgwt4+zlmY4eDL1cQFRhG/lD2PxE7IYlRL8WTLN/wMQHCiau
 vRAH0EIOsZggGpms82es284OsPwmhbiiJltwgRPpHHHUd55Ovs+HyEMT7XFTe0T3ARci
 6kHKjb9gIeePjs+ReaeGptbQ90kMwzi5yM1NqrEkfXEkgF5tu/73M2lhXn9YLxGPMd39
 AzV5V0w0rQjL2MNQjAE/IfWhiXimDCh5yUPPxIOYaHdpmhXDG+9l/GoMHRV6R9j4GqKt
 6Jsw==
X-Gm-Message-State: AFuF++m+qPFmfGNcUhnN2SysBJZ81xQX4PEOxwxG7I0bnAsmTQnTwlfb
 Maa8OS3WS8XmK2IS/l69fQwG1AZjfoMXTHma31iJlgH/HP3bFwxYHixGHKe8S6nO2cPIIVan7hR
 fvS75u6GxZ3aZLRpk/SLkNOOIIkQMc2lXivd5dvLzetndfcGxaZi322GPUW2kVBefNhA7S03tJ9
 vkQbw=
X-Gm-Gg: AYBFou2JDhcoqcO7xcGgtvA53YcTN+6TDdfa61Yyx0ZElTvToN+FwZK7N60ujIXgh7s
 51jfauL+Chsp8T2pfHDOEzC6MR+J530lQnAm9NEK1a7I6E47XFN7MccjyR79q+7fpBaxzcp5Qgb
 kBfknHOm/ozWqEO03dol/sMTW9ssdNXmTn3QO4EUUITfFtCY9JbqzDN9/MAOHZPsPzE+K8L1tum
 fssVTwr9dsMyg3XwJ2TM7vneIWYb3zboO1esy3pOg+sOTzNxsR8XApJp7a3wLmMg645ton2VfSR
 CDGQAuyZA9qUSYa28OXVQO4i2o25wRRGj4T7PjdSG+WWNcYux+yBsGYh5kl1UIZNwLXPRUR7rnd
 FMqhKkCgBtSCTVJ7tcQshWo0fPdJhd6FI50ed6GJDEU0p6bRnwOitW9QwFywKN8SOyuQTnlrog2
 yVkjxN2g==
X-Received: by 2002:ac8:5946:0:b0:532:8ed7:534 with SMTP id
 d75a77b69052e-53374d402f4mr32587191cf.37.1790782012826; 
 Wed, 30 Sep 2026 08:26:52 -0700 (PDT)
X-Received: by 2002:ac8:5946:0:b0:532:8ed7:534 with SMTP id
 d75a77b69052e-53374d402f4mr32586621cf.37.1790782012128; 
 Wed, 30 Sep 2026 08:26:52 -0700 (PDT)
Received: from localhost
 (ipagstaticip-a5183818-34e1-b901-fa5c-deea35ceefd1.sdsl.bell.ca.
 [142.127.77.64]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-533824e35d3sm1719971cf.22.2026.09.30.08.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:26:51 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Connor Abbott <cwabbott0@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Yuanjie Yang <yuanjie.yang@oss.qualcomm.com>,
 Luca Weiss <luca.weiss@fairphone.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/dpu: Fix GAMMA LUT for sm8750 related DPUs
Date: Wed, 30 Sep 2026 08:26:43 -0700
Message-ID: <20260930152645.22194-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: ovIkEPyIRAeaBXPEyAH9YYIgdO1Zltv1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTMwMDA2MSBTYWx0ZWRfX1y4Lnsw7yCFt
 rUSkZWu7WSW3QmPuk0fMb5H0JUPEO5GdMawARlqShSbfliBP8GbgGHsIIAEbNTypz19YOIWYRSD
 E2S2CGpRWuJnPUmMQkIxMcT8fHiu9dy+6BNVOS/bOqEGNrxyxRqME/+6q5blBJfzWopiaWfjURY
 aPEqQwi7ivam9TUJeJ30laRZg4p30OdJKOr5P87pOuWNB8Wo1miF3GgXlH8Pi57SFbyZKQ92QYZ
 ZlEnPQXIGihREVGuTTz9b4IQx8J+0fzZYp6/Ye6i2hJZgcpNA9I3X1PUUm5P8Vzht01iIvE5uuJ
 l/cowJUF/BOMKf3mAmAZvjvziZq/U6f0z5DFREKfCCp9azILHLlhVl9mr4/1tJLn/ueqV86rDTO
 TgTz045ClO2BtxsYIl/oeOCDqi/2VlNDSYT/+lRyrWC3DHFTbGM+4d3LdO/uvpg+Fo7uLVbX/uH
 GFEoF09SyMATWyHK8gw==
X-Proofpoint-GUID: ovIkEPyIRAeaBXPEyAH9YYIgdO1Zltv1
X-Authority-Analysis: v=2.4 cv=Ypya1IYX c=1 sm=1 tr=0 ts=6abd2a3d cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=8VafS78ZeU61HtrzG+bZhw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=ILNf-aDmxzXD4JfHqJcA:9 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTMwMDA2MSBTYWx0ZWRfX8sKTtYTu3ZHT
 kWBPx6MrqeU0UHRG1lFlPE87GddsBdCsMMSk9l45kfCGmIoPXSwl/w9DaPZiv4LVO4OlPCvJFC4
 Kq63uNXziG27qbA2TUdz1vc51HOoge4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-30_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 impostorscore=0 spamscore=0 bulkscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609300061
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add missing GC block.  Fixes GAMMA LUT on glymur/knp/etc.

Reported-by: Connor Abbott <cwabbott0@gmail.com>
Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
index 9a993cdfab85..107150a8553f 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
@@ -428,6 +428,8 @@ static const struct dpu_dspp_sub_blks sdm845_dspp_sblk = {
 static const struct dpu_dspp_sub_blks sm8750_dspp_sblk = {
 	.pcc = {.name = "pcc", .base = 0x1700,
 		.len = 0x90, .version = 0x60000},
+	.gc = {.name = "gc", .base = 0x17c0,
+		.len = 0x40, .version = 0x10008},
 };
 
 /*************************************************************
-- 
2.55.0

