Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E9CCA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 22:37:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 461EF10EA3C;
	Sat,  3 Oct 2026 22:37:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="VSQoI0v5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WojLFuHk";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFAC210EA3C
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 22:37:36 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 693KpFdo1082833
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 22:37:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=eAem2X14ObZm+rpDIaIE6FmNboclOYWffVU
 ntFzEfDk=; b=VSQoI0v5PDAVLttORLLqTpRNTnPcQWYNuFGM1/N3YLSOdVqLpbv
 DvpbQKXz0upZ1wpfmqClEuTEdqXwUOJ3G9keydaKuipG5CrAaUeoleqYBenKyYSM
 zC7NqlszxCJVC56gyjnX+/QioY27S+rUn27rBhSpPFYsPaco+n08LpGiJdrREhpP
 BvADdiZ/Blms/H3l+8Y6c1LrbA+SQ+AlGSf9TJqlHpb0g5gFEdOeEHK+S17C6wLK
 FZQaljNQYbuRcWN/U2iYALL/+ADy19ktHVGthv57fYgP25OhET6d6UVxzU+IFYbG
 E41UMpLiIzrU/TgL86oiu17YsqBOPjY9B1A==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2t06sy8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 22:37:35 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3823dcc1647so499537a91.3
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 15:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791067054; x=1791671854;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=eAem2X14ObZm+rpDIaIE6FmNboclOYWffVUntFzEfDk=;
 b=WojLFuHkZ4qj4LO7/KO1wnq0WzmUbKEifozpCZT8inzk2KFlktgSk2ZNPaq2344gEj
 oIEWcoT+9EbrDozTKRrYrCPpEq8vqROyyoRZEaRyzBjg44WaAAmm49G8I1s9JykD9g9f
 Y+uIykFbZvu2jTpiUq+iglstFBbg/rK9KcMXYne9rOgr24G5iJXafyQt04HGkpohLEVb
 sqSqzLGspiYlyXAWKP9b7W1bujsc7zhuTI+w/YqoKb9UPckbaZXUA8yVoCKFdKEE51YL
 DpmnqDTsbSz35i0ZM0f3+6/sPSmqN0U7lRZDIjN0MjCB/uFA0fjw8FDioiJJFELFSVnG
 6/6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791067054; x=1791671854;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eAem2X14ObZm+rpDIaIE6FmNboclOYWffVUntFzEfDk=;
 b=aUQwxL3+8zoAMZuFsoAkgR3RgsyDStMgq7nYOKPOxbGm9hmGrgQlPO/8aXa5894BqH
 6OcrjtOjKu2Kf6L4n5uo2ktooSw+66VmlLTGdLjWsKA42JFuZ3i3xDeLRqRVB9Vo8/t4
 jwCmuHUaF5pD91KzoZps5mpdhlmh5tIju8CGIbNzXJYPj0T/3Re4bT5gn14mYPq7TX95
 IThS9DVne2okTlvl0ihBwcOn38QH4+buEtOnq/lb6OZ83zkMy1tgYsjxgnHPgwu/hxoh
 0uMbVLYMNHI0m1i2FWpcJvI0IfEYT3pF3cmiL4xMZiq1lA/GgmT81vwgRlUT3bIUi/mZ
 /f0Q==
X-Gm-Message-State: AFq9FYKuHTRt+ZDX7f4Z9A43NiCnYvuX+Sbb2GGf3ISuMA1Y8yzC5KC2
 hh3qLmg7cE7w/WxALhDoKrZ14OsKSrp4Cg/IrtirJaeEmjzONbLBP9w2aTL2JDAm24dBFGtDDPw
 hVLBWUkH4Just9SOVgiQwgn5+YnPbXWTaAj9swwffxPsMmJdIuNevrokw2LvHVNr6mOZAVE7NeL
 OZ98Y=
X-Gm-Gg: AYBFou1strwchZrNuIXo+uqaYC34b7DEj3Kl3pfYU8ZVKEUkWu0ETvNzaoT4kGU03t8
 R7Xj2gMhM5KhMqsNV2wTfuaaBsHF/XTVkIQXBPGFaL8Mkt/WVeKyAMd4KD9t7+mWLq9uOsCM0ly
 HHSrp53IRH9MwyFrZh3sNy8KdkFE29xBuqSFykxn2Jy8utQyiwv5jTpLN8UDH5BWuoAwneWf1Hy
 ReH9pmmyvtgaq9nAcu3sZMeyflUcwG7H4kiCuX8pd5FJ6Z6RHwi0m8Z5bsmOpuNWqkoNMGV3Kat
 xZ4UcMx/CjJOs1EkN42MlywcVV8R2Kv8GdF9AqA7nOZQr4Na15hl/uyeI2DIm9Q+td9PQ3sgMg+
 ItGqVt4hd/+5w3FN2rKwXBcW5GQ59hSnmeoM0n5Cce2+P5XM=
X-Received: by 2002:a17:90a:6097:b0:3a6:f1d2:57f8 with SMTP id
 98e67ed59e1d1-3a6f1d269b3mr2445192a91.2.1791067054220; 
 Sat, 03 Oct 2026 15:37:34 -0700 (PDT)
X-Received: by 2002:a17:90a:6097:b0:3a6:f1d2:57f8 with SMTP id
 98e67ed59e1d1-3a6f1d269b3mr2445174a91.2.1791067053583; 
 Sat, 03 Oct 2026 15:37:33 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a78e4664ebsm4499215a91.7.2026.10.03.15.37.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 03 Oct 2026 15:37:33 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm: Sync registers from mesa
Date: Sat,  3 Oct 2026 15:37:22 -0700
Message-ID: <20261003223723.400020-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cf5HPXDM c=1 sm=1 tr=0 ts=6ac183af cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=e5mUnYsNAAAA:8
 a=EUspDBNiAAAA:8 a=0vnX1LisTAiW6trkSK4A:9 a=uKXjsCUrEbL0IQVhDsJ9:22
 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: ceqbVHDrQkJz_bH4-_bvBXKtS3uC6BZk
X-Proofpoint-GUID: ceqbVHDrQkJz_bH4-_bvBXKtS3uC6BZk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDA5MCBTYWx0ZWRfX8794UE/E4FaI
 LM448Gi98nt/08bim7XTmibUiWGmSSWBsxi4hJrIx9iGmupE1+65TLxxaiDD3NMnJ22FkE5+xMg
 1TalMBgcuB7gp6wX0atQVLOnAygJVCTlDPbnruoZcqN+KVv6I4nNplcRAZjwfE9o1s5R7O3KJOj
 xBaC23qIjg7mthh81wOKiAcIBvd7Bwv9gBOb5RGvqw+wyIu7lM5Q4/X/cNTuqQCmZpZcz+51MhA
 nRnz5wh3T8w4fmy7UD08tHezVsL/1BEm1Dn/vaA/KXIKFvCBhG6u9XgcOCETT4gierU1gxqtSp/
 R0/BCXvq9UkeXCWfIBSYUgNf/bRpJg/HdL1VcTw8zUMld8pIxLQRYT9pBcyGkgT2mdeLOEutefS
 6XH8ptouyZ6b0kI/PCuAW64133HBgcOS360SdEwUKC+Z+1vChK7doCNbl1j7etw2+VSWT7qvs8n
 cjLQC4MtA0FQm78YrTg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDA5MCBTYWx0ZWRfXz96+7+piV08Q
 6eg/vTu/vY9nmP8aGPcyKDwWj8/0n6mej3iyzC628q1cbkliD2sHAyQjskYr4kEcZYH77CWalCE
 NJS06NjQtL3xEkx2+g+J9XHN6q9l3hY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-03_04,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030090
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

Sync changes from mesa commit 81fae85847d2 ("freedreno/registers: Sync
xml changes back from kernel").

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         |  2 +-
 drivers/gpu/drm/msm/registers/adreno/a2xx.xml | 25 +++---
 drivers/gpu/drm/msm/registers/adreno/a5xx.xml | 17 ++++
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 81 +++++++++++++------
 .../drm/msm/registers/adreno/adreno_pm4.xml   | 41 ++++++----
 5 files changed, 116 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 081e79ea4652..c8381ac238ce 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -225,7 +225,7 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 	OUT_PKT7(ring, CP_REG_TO_MEM, 3);
 	OUT_RING(ring, CP_REG_TO_MEM_0_REG(counter) |
 		CP_REG_TO_MEM_0_CNT(2) |
-		CP_REG_TO_MEM_0_64B);
+		CP_REG_TO_MEM_0_IS_64B);
 	OUT_RING(ring, lower_32_bits(iova));
 	OUT_RING(ring, upper_32_bits(iova));
 }
diff --git a/drivers/gpu/drm/msm/registers/adreno/a2xx.xml b/drivers/gpu/drm/msm/registers/adreno/a2xx.xml
index 22caddaa0db9..66a9ad75131c 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a2xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a2xx.xml
@@ -1228,10 +1228,15 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x0c86" name="PA_SU_FACE_DATA">
 		<bitfield name="BASE_ADDR" low="5" high="31" type="uint"/>
 	</reg32>
+	<reg32 offset="0x0d03" name="SQ_RESOURCE_MANAGMENT">
+		<bitfield name="VTX_THREAD_BUF_ENTRIES" low="0" high="7" type="uint"/>
+		<bitfield name="PIX_THREAD_BUF_ENTRIES" low="8" high="15" type="uint"/>
+		<bitfield name="EXPORT_BUF_ENTRIES" low="16" high="24" type="uint"/>
+	</reg32>
 	<reg32 offset="0x0d00" name="SQ_GPR_MANAGEMENT">
 		<bitfield name="REG_DYNAMIC" pos="0" type="boolean"/>
-		<bitfield name="REG_SIZE_PIX" low="4" high="11" type="uint"/>
-		<bitfield name="REG_SIZE_VTX" low="12" high="19" type="uint"/>
+		<bitfield name="REG_SIZE_PIX" low="4" high="10" type="uint"/>
+		<bitfield name="REG_SIZE_VTX" low="12" high="18" type="uint"/>
 	</reg32>
 	<reg32 offset="0x0d01" name="SQ_FLOW_CONTROL"/>
 	<reg32 offset="0x0d02" name="SQ_INST_STORE_MANAGMENT">
@@ -1527,12 +1532,12 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	</reg32>
 	<reg32 offset="0x2293" name="PA_SC_VIZ_QUERY">
 		<bitfield name="VIZ_QUERY_ENA" pos="0" type="boolean"/>
-		<bitfield name="VIZ_QUERY_ID" low="1" high="6" type="uint"/>
-		<bitfield name="KILL_PIX_POST_EARLY_Z" pos="8" type="boolean"/>
+		<bitfield name="VIZ_QUERY_ID" low="1" high="5" type="uint"/>
+		<bitfield name="KILL_PIX_POST_EARLY_Z" pos="7" type="boolean"/>
 	</reg32>
 	<reg32 offset="0x2294" name="VGT_ENHANCE"/>
 	<reg32 offset="0x2300" name="PA_SC_LINE_CNTL">
-		<bitfield name="BRES_CNTL" low="0" high="15" type="uint"/>
+		<bitfield name="BRES_CNTL" low="0" high="7" type="uint"/>
 		<bitfield name="USE_BRES_CNTL" pos="8" type="boolean"/>
 		<bitfield name="EXPAND_LINE_WIDTH" pos="9" type="boolean"/>
 		<bitfield name="LAST_PIXEL" pos="10" type="boolean"/>
@@ -1544,7 +1549,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x2302" name="PA_SU_VTX_CNTL">
 		<bitfield name="PIX_CENTER" pos="0" type="a2xx_pa_pixcenter"/>
 		<bitfield name="ROUND_MODE" low="1" high="2" type="a2xx_pa_roundmode"/>
-		<bitfield name="QUANT_MODE" low="7" high="9" type="a2xx_pa_quantmode"/>
+		<bitfield name="QUANT_MODE" low="3" high="5" type="a2xx_pa_quantmode"/>
 	</reg32>
 	<reg32 offset="0x2303" name="PA_CL_GB_VERT_CLIP_ADJ" type="float"/>
 	<reg32 offset="0x2304" name="PA_CL_GB_VERT_DISC_ADJ" type="float"/>
@@ -1796,10 +1801,10 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 		<value name="SQ_TEX_NUM_FORMAT_INT" value="1"/>
 	</enum>
 	<enum name="sq_tex_type">
-		<value name="SQ_TEX_TYPE_0" value="0"/>
-		<value name="SQ_TEX_TYPE_1" value="1"/>
-		<value name="SQ_TEX_TYPE_2" value="2"/>
-		<value name="SQ_TEX_TYPE_3" value="3"/>
+		<value name="SQ_TEX_TYPE_INVALID_TEXTURE" value="0"/>
+		<value name="SQ_TEX_TYPE_INVALID_BUFFER" value="1"/>
+		<value name="SQ_TEX_TYPE_VALID_TEXTURE" value="2"/>
+		<value name="SQ_TEX_TYPE_VALID_BUFFER" value="3"/>
 	</enum>
 	<reg32 offset="0" name="0">
 		<bitfield name="TYPE" low="0" high="1" type="sq_tex_type"/>
diff --git a/drivers/gpu/drm/msm/registers/adreno/a5xx.xml b/drivers/gpu/drm/msm/registers/adreno/a5xx.xml
index 4af76b3750f7..e928ad4e518c 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a5xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a5xx.xml
@@ -1804,6 +1804,9 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 
 
 	<reg32 offset="0xe000" name="GRAS_CL_CNTL">
+		<bitfield name="ZNEAR_CLIP_DISABLE" pos="1" type="boolean"/>
+		<bitfield name="ZFAR_CLIP_DISABLE" pos="2" type="boolean"/>
+		<bitfield name="Z_CLAMP_ENABLE" pos="5" type="boolean"/>
 		<bitfield name="ZERO_GB_SCALE_Z" pos="6" type="boolean"/>
 	</reg32>
 	<bitset name="a5xx_gras_xs_cl_cntl" inline="yes">
@@ -1832,6 +1835,13 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0xe013" name="GRAS_CL_VPORT_YSCALE_0" type="float"/>
 	<reg32 offset="0xe014" name="GRAS_CL_VPORT_ZOFFSET_0" type="float"/>
 	<reg32 offset="0xe015" name="GRAS_CL_VPORT_ZSCALE_0" type="float"/>
+	<doc>
+		The range GRAS_CL_CNTL.Z_CLAMP_ENABLE clamps to.  Near and far, not
+		sorted as the a6xx equivalents are: a reversed depth range is written
+		reversed.
+	</doc>
+	<reg32 offset="0xe070" name="GRAS_CL_VIEWPORT_ZCLAMP_NEAR_0" type="float"/>
+	<reg32 offset="0xe071" name="GRAS_CL_VIEWPORT_ZCLAMP_FAR_0" type="float"/>
 	<reg32 offset="0xe090" name="GRAS_SU_CNTL">
 		<bitfield name="CULL_FRONT" pos="0" type="boolean"/>
 		<bitfield name="CULL_BACK" pos="1" type="boolean"/>
@@ -1976,6 +1986,7 @@ bit 7 for RECTLIST (clear) when z32s8 (used for clear of depth32?  not set
 	<reg32 offset="0xe146" name="RB_FS_OUTPUT_CNTL">
 		<!-- bit0 set except for binning pass.. -->
 		<bitfield name="MRT" low="0" high="3" type="uint"/>
+		<bitfield name="DUAL_COLOR_IN_ENABLE" pos="4" type="boolean"/>
 		<bitfield name="FRAG_WRITES_Z" pos="5" type="boolean"/>
 	</reg32>
 	<reg32 offset="0xe147" name="RB_RENDER_COMPONENTS">
@@ -2058,6 +2069,7 @@ bit 7 for RECTLIST (clear) when z32s8 (used for clear of depth32?  not set
 		<!-- per-mrt enable bit -->
 		<bitfield name="ENABLE_BLEND" low="0" high="7"/>
 		<bitfield name="INDEPENDENT_BLEND" pos="8" type="boolean"/>
+		<bitfield name="DUAL_COLOR_IN_ENABLE" pos="9" type="boolean"/>
 		<bitfield name="ALPHA_TO_COVERAGE" pos="10" type="boolean"/>
 		<!-- a guess? -->
 		<bitfield name="SAMPLE_MASK" low="16" high="31"/>
@@ -2070,6 +2082,7 @@ bit 7 for RECTLIST (clear) when z32s8 (used for clear of depth32?  not set
 		<bitfield name="Z_TEST_ENABLE" pos="0" type="boolean"/>
 		<bitfield name="Z_WRITE_ENABLE" pos="1" type="boolean"/>
 		<bitfield name="ZFUNC" low="2" high="4" type="adreno_compare_func"/>
+		<bitfield name="Z_CLAMP_ENABLE" pos="5" type="boolean"/>
 		<doc>Z_READ_ENABLE bit is set for zfunc other than GL_ALWAYS or GL_NEVER</doc>
 		<bitfield name="Z_READ_ENABLE" pos="6" type="boolean"/>
 	</reg32>
@@ -2114,6 +2127,8 @@ bit 7 for RECTLIST (clear) when z32s8 (used for clear of depth32?  not set
 	<reg32 offset="0xe1d1" name="RB_SAMPLE_COUNT_CONTROL">
 		<bitfield name="COPY" pos="1" type="boolean"/>
 	</reg32>
+	<reg32 offset="0xe200" name="RB_VIEWPORT_ZCLAMP_NEAR" type="float"/>
+	<reg32 offset="0xe201" name="RB_VIEWPORT_ZCLAMP_FAR" type="float"/>
 
 	<doc>
 		Blits:
@@ -2523,10 +2538,12 @@ bit 7 for RECTLIST (clear) when z32s8 (used for clear of depth32?  not set
 		<!-- per-mrt enable bit -->
 		<bitfield name="ENABLE_BLEND" low="0" high="7"/>
 		<bitfield name="UNK8" pos="8" type="boolean"/>
+		<bitfield name="DUAL_COLOR_IN_ENABLE" pos="9" type="boolean"/>
 		<bitfield name="ALPHA_TO_COVERAGE" pos="10" type="boolean"/>
 	</reg32>
 	<reg32 offset="0xe5ca" name="SP_FS_OUTPUT_CNTL">
 		<bitfield name="MRT" low="0" high="3" type="uint"/>
+		<bitfield name="DUAL_COLOR_IN_ENABLE" pos="4" type="boolean"/>
 		<bitfield name="DEPTH_REGID" low="5" high="12" type="a3xx_regid"/>
 		<bitfield name="SAMPLEMASK_REGID" low="13" high="20" type="a3xx_regid"/>
 	</reg32>
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index e6e56969a9b8..cf2fb20203b7 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -1388,7 +1388,7 @@ by a particular renderpass/blit.
 		<reg32 offset="0x0" name="REG"/>
 	</array>
 
-	<array offset="0x0c58" name="VSC_PIPE_DATA_PRIM_SIZE" stride="1" length="32" variants="A6XX" usage="cmd">
+	<array offset="0x0c58" name="VSC_PIPE_DATA_PRIM_SIZE" stride="1" length="32" usage="cmd">
 		<doc>
 			Has the size of data written to corresponding VSC_PRIM_STRM
 			buffer.
@@ -1396,7 +1396,7 @@ by a particular renderpass/blit.
 		<reg32 offset="0x0" name="REG"/>
 	</array>
 
-	<array offset="0x0c78" name="VSC_PIPE_DATA_DRAW_SIZE" stride="1" length="32" variants="A6XX" usage="cmd">
+	<array offset="0x0c78" name="VSC_PIPE_DATA_DRAW_SIZE" stride="1" length="32" usage="cmd">
 		<doc>
 			Has the size of data written to corresponding VSC pipe, ie.
 			same thing that is written out to VSC_SIZE_BASE
@@ -1461,8 +1461,10 @@ by a particular renderpass/blit.
 		<bitfield name="IJ_LINEAR_CENTROID" pos="4" type="boolean"/>
 		<bitfield name="IJ_LINEAR_SAMPLE" pos="5" type="boolean"/>
 		<bitfield name="COORD_MASK" low="6" high="9" type="hex"/>
-		<bitfield name="UNK10" pos="10" type="boolean" variants="A7XX-"/>
-		<bitfield name="UNK11" pos="11" type="boolean" variants="A7XX-"/>
+		<!-- A740+ field, Must match RB_PS_INPUT_CNTL -->
+		<bitfield name="FACENESS" pos="10" type="boolean" variants="A7XX-"/>
+		<!-- A740+ field, Must match RB_PS_INPUT_CNTL -->
+		<bitfield name="CENTERRHW" pos="11" type="boolean" variants="A7XX-"/>
 	</bitset>
 
 	<reg32 offset="0x8005" name="GRAS_CL_INTERP_CNTL" type="a6xx_gras_cl_interp_cntl" variants="A6XX-A7XX" usage="draw"/>
@@ -2170,12 +2172,12 @@ by a particular renderpass/blit.
 		<bitfield name="SCISSOR" pos="16" type="boolean"/>
 		<bitfield name="UNK17" low="17" high="18"/>
 		<!-- required when blitting D24S8/D24X8 -->
-		<bitfield name="D24S8" pos="19" type="boolean"/>
+		<bitfield name="IS_SRC_YUV" pos="19" type="boolean"/>
 		<!-- some sort of channel mask, disabled channels are set to zero ? -->
 		<bitfield name="MASK" low="20" high="23"/>
 		<bitfield name="IFMT" low="24" high="26" type="a6xx_2d_ifmt"/>
-		<bitfield name="UNK27" pos="27" type="boolean"/>
-		<bitfield name="UNK28" pos="28" type="boolean"/>
+		<bitfield name="FULL_RANGE_YUV" pos="27" type="boolean"/>
+		<bitfield name="LINEAR_YUV" pos="28" type="boolean"/>
 		<bitfield name="RASTER_MODE" pos="29" type="a6xx_raster_mode"/>
 		<bitfield name="COPY" pos="30" type="boolean" variants="A7XX-"/>
 	</bitset>
@@ -2561,10 +2563,8 @@ by a particular renderpass/blit.
 		<reg32 offset="0" name="REG" type="float"/>
 	</array>
 
-	<!-- 0x88c2-0x88cf invalid-->
 	<reg32 offset="0x88d0" name="RB_RESOLVE_CNTL_0" usage="resolve">
-		<bitfield name="UNK0" low="0" high="12"/>
-		<bitfield name="UNK16" low="16" high="26"/>
+		<bitfield name="YUV_PLANE_ID" low="0" high="1"/>
 	</reg32>
 	<reg32 offset="0x88d1" name="RB_RESOLVE_CNTL_1" type="a6xx_reg_xy" usage="resolve"/>
 	<reg32 offset="0x88d2" name="RB_RESOLVE_CNTL_2" type="a6xx_reg_xy" usage="resolve"/>
@@ -2761,7 +2761,22 @@ by a particular renderpass/blit.
 	<reg32 offset="0x8a30" name="RB_UNKNOWN_8A30" variants="A6XX" usage="draw"/>
 
 	<reg32 offset="0x8c00" name="RB_A2D_BLT_CNTL" type="a6xx_a2d_blt_cntl" usage="blit"/>
-	<reg32 offset="0x8c01" name="RB_A2D_PIXEL_CNTL" low="0" high="31" usage="blit"/>
+
+	<enum name="a6xx_a2d_pixel_op">
+		<value value="0" name="PIXEL_OP_DISABLED"/>
+		<value value="1" name="PIXEL_OP_BLENDING"/>
+		<value value="3" name="PIXEL_OP_ROP"/>
+	</enum>
+
+	<reg32 offset="0x8c01" name="RB_A2D_PIXEL_CNTL" low="0" high="31" usage="blit">
+		<bitfield name="PIXEL_OP" low="0" high="1" type="a6xx_a2d_pixel_op"/>
+		<bitfield name="COLOR_SRC_FACTOR" low="6" high="10" type="adreno_rb_blend_factor"/>
+		<bitfield name="COLOR_BLEND_OP" low="11" high="13" type="a3xx_rb_blend_opcode"/>
+		<bitfield name="COLOR_DST_FACTOR" low="14" high="18" type="adreno_rb_blend_factor"/>
+		<bitfield name="ALPHA_SRC_FACTOR" low="19" high="23" type="adreno_rb_blend_factor"/>
+		<bitfield name="ALPHA_BLEND_OP" low="24" high="26" type="a3xx_rb_blend_opcode"/>
+		<bitfield name="ALPHA_DST_FACTOR" low="27" high="31" type="adreno_rb_blend_factor"/>
+	</reg32>
 
 	<bitset name="a6xx_a2d_src_texture_info" inline="yes">
 		<bitfield name="COLOR_FORMAT" low="0" high="7" type="a6xx_format"/>
@@ -2814,7 +2829,7 @@ by a particular renderpass/blit.
 	<reg32 offset="0x8c2e" name="RB_A2D_CLEAR_COLOR_DW2" usage="blit"/>
 	<reg32 offset="0x8c2f" name="RB_A2D_CLEAR_COLOR_DW3" usage="blit"/>
 
-	<reg32 offset="0x8c34" name="RB_A2D_UNKNOWN_8C34" variants="A7XX-" usage="blit"/>
+	<reg32 offset="0x8c34" name="RB_A2D_DEST_BUFFER_ARRAY_PITCH" variants="A7XX-" usage="blit"/>
 
 	<!-- 0x8c35-0x8dff invalid -->
 
@@ -2959,17 +2974,10 @@ by a particular renderpass/blit.
 		<bitfield name="DISCARD" pos="2" type="boolean"/>
 	</bitset>
 
-	<reg32 offset="0x9980" name="VPC_RAST_STREAM_CNTL" type="a6xx_vpc_rast_stream_cntl" variants="A6XX" usage="draw"/>
-	<reg32 offset="0x9107" name="VPC_RAST_STREAM_CNTL" type="a6xx_vpc_rast_stream_cntl" variants="A7XX" usage="draw"/>
+	<reg32 offset="0x9107" name="VPC_RAST_STREAM_CNTL" type="a6xx_vpc_rast_stream_cntl" variants="A6XX-A7XX" usage="draw"/>
 	<reg32 offset="0x930d" name="VPC_RAST_STREAM_CNTL" type="a6xx_vpc_rast_stream_cntl" variants="A8XX-" usage="draw"/>
 	<reg32 offset="0x9317" name="VPC_RAST_STREAM_CNTL_V2" type="a6xx_vpc_rast_stream_cntl" variants="A7XX" usage="draw"/>
 
-	<reg32 offset="0x9107" name="VPC_UNKNOWN_9107" variants="A6XX" usage="draw">
-		<!-- this mirrors VPC_RAST_STREAM_CNTL::DISCARD, although it seems it's unused -->
-		<bitfield name="RASTER_DISCARD" pos="0" type="boolean"/>
-		<bitfield name="UNK2" pos="2" type="boolean"/>
-	</reg32>
-
 	<reg32 offset="0x9108" name="VPC_RAST_CNTL" type="a6xx_rast_cntl" variants="A6XX-A7XX" usage="draw"/>
 	<reg32 offset="0x930e" name="VPC_RAST_CNTL" type="a6xx_rast_cntl" variants="A8XX-" usage="draw"/>
 	<bitset name="a6xx_pc_cntl" inline="yes">
@@ -3288,7 +3296,29 @@ by a particular renderpass/blit.
 	<reg32 offset="0x9803" name="PC_RESTART_INDEX" low="0" high="31" type="uint" variants="A6XX-A7XX" usage="draw"/>
 	<reg32 offset="0x9b15" name="PC_RESTART_INDEX" low="0" high="31" type="uint" variants="A8XX-" usage="draw"/>
 
-	<reg32 offset="0x9804" name="PC_MODE_CNTL" low="0" high="7" variants="A6XX-A7XX" usage="draw"/>
+	<reg32 offset="0x9804" name="PC_MODE_CNTL" low="0" high="7" variants="A6XX-A7XX" usage="draw">
+		<!-- 
+			The higher this is set, the faster primitive processing performance
+			ends up being. It is likely the amount of entries to process/fetch.
+		-->
+		<bitfield name="COUNT1" low="0" high="4" type="uint"/>
+		<!--
+			Setting this slows down primitive processing substantially, but it
+			was noted to fix some vertex corruption issues in the past. Likely
+			serves as a workaround to serialize the primitive pipeline?
+		-->
+		<bitfield name="UNK5" pos="5" type="boolean"/>
+		<!-- Never set by the blob, removed in A7XX. Unclear impact. -->
+		<bitfield name="UNK6" pos="6" type="boolean" variants="A6XX"/>
+		<!-- Never set by the blob. Unclear impact. -->
+		<bitfield name="UNK7" pos="7" type="boolean"/>
+		<!--
+			Same as COUNT1 but one bit larger, this replaces COUNT1 mid-A7XX but
+			the proprietary driver tends to set it to the same or larger value
+			(by using the extra bit) as COUNT1.
+		-->
+		<bitfield name="COUNT2" low="8" high="13" type="uint" variants="A7XX-"/>
+	</reg32>
 	<reg32 offset="0x9b00" name="PC_MODE_CNTL" low="0" high="14" variants="A8XX" usage="draw"/>
 
 	<reg32 offset="0x9805" name="PC_POWER_CNTL" low="0" high="2" variants="A6XX" usage="draw"/>
@@ -3367,6 +3397,8 @@ by a particular renderpass/blit.
 	<reg32 offset="0x9886" name="PC_TF_BUFFER_SIZE" variants="A7XX" usage="cmd"/>
 	<reg32 offset="0x9815" name="PC_TF_BUFFER_SIZE" variants="A8XX-" usage="cmd"/>
 
+	<reg32 offset="0x9980" name="PC_RAST_STREAM_CNTL" type="a6xx_vpc_rast_stream_cntl" variants="A6XX" usage="draw"/>
+
 	<!-- 0x9982-0x9aff invalid -->
 
 	<reg32 offset="0x9b00" name="PC_CNTL" type="a6xx_pc_cntl" variants="A6XX-A7XX" usage="draw"/>
@@ -3466,7 +3498,7 @@ by a particular renderpass/blit.
 	<reg64 offset="0x9e12" name="PC_PVIS_STREAM_BIN_BASE" type="waddress" align="32" variants="A6XX-A7XX"/>
 	<reg64 offset="0x9e14" name="PC_DVIS_STREAM_BIN_BASE" type="waddress" align="32" variants="A6XX-A7XX"/>
 
-	<reg32 offset="0x9e0a" name="PC_AUTO_VERTEX_STRIDE"/>
+	<reg32 offset="0x9e0a" name="PC_AUTO_VERTEX_STRIDE" low="0" high="9" type="uint"/>
 	<reg32 offset="0x9e0d" name="PC_VIS_STREAM_CNTL" type="a6xx_pc_vis_stream_cntl" variants="A8XX-"/>
 	<reg64 offset="0x9e0e" name="PC_PVIS_STREAM_BIN_BASE" type="waddress" align="32" variants="A8XX-"/>
 	<reg64 offset="0x9e10" name="PC_DVIS_STREAM_BIN_BASE" type="waddress" align="32" variants="A8XX-"/>
@@ -4077,8 +4109,8 @@ by a particular renderpass/blit.
 		<bitfield name="THREADSIZE" pos="20" type="a6xx_threadsize"/>
 		<!-- seems to make SP use less concurrent threads when possible? -->
 		<bitfield name="UNK21" pos="21" type="boolean"/>
-		<!-- has a small impact on performance, not clear what it does -->
-		<bitfield name="UNK22" pos="22" type="boolean"/>
+		<!-- Enables round-robin mode, which guarantees fair scheduling -->
+		<bitfield name="COMPUTERRMODEEN" pos="22" type="boolean"/>
 		<bitfield name="EARLYPREAMBLE" pos="23" type="boolean"/>
 		<bitfield name="MERGEDREGS" pos="31" type="boolean"/>
 	</reg32>
@@ -4342,6 +4374,7 @@ by a particular renderpass/blit.
 		</doc>
 		<bitfield name="EOLM_ENABLE" pos="1" type="boolean"/>
 	</reg32>
+	<reg32 offset="0xaf81" name="SP_LPAC_CHICKEN_BITS" variants="A7XX" usage="init"/>
 	<reg32 offset="0xae04" name="SP_NC_MODE_CNTL_2" usage="init">
 		<bitfield name="F16_NO_INF" pos="3" type="boolean"/>
 	</reg32>
diff --git a/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml b/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
index f185b541aa70..2723da19cf5b 100644
--- a/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/adreno_pm4.xml
@@ -646,10 +646,10 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<value name="CP_NON_CONTEXT_REG_BUNCH" value="0x5d" variants="A7XX-"/>
 	<doc>
 		Write to a scratch memory that is read by CP_REG_TEST with
-		SOURCE_SCRATCH_MEM set. It's not the same scratch as scratch registers.
+		SOURCE_OC_MEM set. It's not the same scratch as scratch registers.
 		However it uses the same memory space.
 	</doc>
-	<value name="CP_MEM_TO_SCRATCH_MEM" value="0x49" variants="A7XX-"/>
+	<value name="CP_MEM_TO_OC_MEM" value="0x49" variants="A7XX-"/>
 
 	<doc>
 		Executes an array of fixed-size command buffers where each
@@ -1039,6 +1039,11 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 </domain>
 
 <domain name="CP_DRAW_AUTO" width="32">
+	<doc>
+		Draws (counter - NUM_VERTICES_OFFSET / 4) / STRIDE vertices, counter
+		read from NUM_VERTICES_BASE.  a7xx divides the counter by four too,
+		earlier gens use it as-is.
+	</doc>
 	<reg32 offset="0" name="0" type="vgt_draw_initiator_a4xx"/>
 	<reg32 offset="1" name="1">
 		<bitfield name="NUM_INSTANCES" low="0" high="31" type="uint"/>
@@ -1048,7 +1053,8 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 		<bitfield name="NUM_VERTICES_OFFSET" low="0" high="31" type="uint"/>
 	</reg32>
 	<reg32 offset="5" name="5">
-		<bitfield name="STRIDE" low="0" high="31" type="uint"/>
+		<!-- the CP masks the stride to 11 bits before forwarding it -->
+		<bitfield name="STRIDE" low="0" high="10" type="uint"/>
 	</reg32>
 </domain>
 
@@ -1255,6 +1261,11 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 			$dst = (($dst &amp; $src0) rot $rotate) | $src1
 
 		Here "rot" means rotate left.
+		If SRCn_IS_REG, the corresponding src is a register offset,
+		otherwise it is an immediate.
+
+		If DST_SCRATCH is set then the value modified is a scratch
+		ram address, instead of a register.
 	</doc>
 	<reg32 offset="0" name="0">
 		<bitfield name="DST_REG" low="0" high="17" type="hex"/>
@@ -1286,7 +1297,7 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 			Treat things as 64B, allowing for a 64B atomic read of
 			registers.
 		-->
-		<bitfield name="64B" pos="30" type="boolean"/>
+		<bitfield name="IS_64B" pos="30" type="boolean"/>
 		<bitfield name="ACCUMULATE" pos="31" type="boolean"/>
 	</reg32>
 	<stripe varset="chip" variants="A2XX-A4XX">
@@ -1307,7 +1318,7 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 		<bitfield name="REG" low="0" high="17" type="hex"/>
 		<!-- number of registers/dwords copied is max(CNT, 1). -->
 		<bitfield name="CNT" low="18" high="29" type="uint"/>
-		<bitfield name="64B" pos="30" type="boolean"/>
+		<bitfield name="IS_64B" pos="30" type="boolean"/>
 		<bitfield name="ACCUMULATE" pos="31" type="boolean"/>
 	</reg32>
 	<reg64 offset="1" name="DEST" type="waddress"/>
@@ -1327,7 +1338,7 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 		<bitfield name="REG" low="0" high="17" type="hex"/>
 		<!-- number of registers/dwords copied is max(CNT, 1). -->
 		<bitfield name="CNT" low="18" high="29" type="uint"/>
-		<bitfield name="64B" pos="30" type="boolean"/>
+		<bitfield name="IS_64B" pos="30" type="boolean"/>
 		<bitfield name="ACCUMULATE" pos="31" type="boolean"/>
 	</reg32>
 	<reg64 offset="1" name="DEST" type="waddress"/>
@@ -1337,12 +1348,13 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 <domain name="CP_MEM_TO_REG" width="32">
 	<reg32 offset="0" name="0">
 		<bitfield name="REG" low="0" high="17" type="hex"/>
+		<!-- if set, all writes are to the same reg -->
+		<bitfield name="ONE_REG_WR" pos="18" type="boolean"/>
 		<!-- number of registers/dwords copied is max(CNT, 1). -->
 		<bitfield name="CNT" low="19" high="29" type="uint"/>
 		<!-- shift each DWORD left by 2 while copying -->
 		<bitfield name="SHIFT_BY_2" pos="30" type="boolean"/>
-		<!-- does the same thing as CP_MEM_TO_MEM::UNK31 -->
-		<bitfield name="UNK31" pos="31" type="boolean"/>
+		<bitfield name="WAIT_CACHE_FLUSH" pos="31" type="boolean"/>
 	</reg32>
 	<stripe varset="chip" variants="A2XX-A4XX">
 		<reg32 offset="1" name="SRC" type="address"/>
@@ -1366,8 +1378,7 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 		<bitfield name="DOUBLE" pos="29" type="boolean"/>
 		<!-- execute CP_WAIT_FOR_MEM_WRITES beforehand -->
 		<bitfield name="WAIT_FOR_MEM_WRITES" pos="30" type="boolean"/>
-		<!-- some other kind of wait -->
-		<bitfield name="UNK31" pos="31" type="boolean"/>
+		<bitfield name="WAIT_CACHE_FLUSH" pos="31" type="boolean"/>
 	</reg32>
 	<reg64 offset="1" name="DST" type="waddress"/>
 	<reg64 offset="3" name="SRC_A" type="address"/>
@@ -1954,13 +1965,13 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 	<enum name="source_type">
 		<value value="0" name="SOURCE_REG"/>
 		<!-- Don't confuse with scratch registers, this is a separate memory
-			 written into by CP_MEM_TO_SCRATCH_MEM. -->
-		<value value="1" name="SOURCE_SCRATCH_MEM" varset="chip" variants="A7XX-"/>
+			 written into by CP_MEM_TO_OC_MEM. -->
+		<value value="1" name="SOURCE_OC_MEM" varset="chip" variants="A7XX-"/>
 	</enum>
 	<reg32 offset="0" name="0">
 		<!-- the register to test -->
 		<bitfield name="REG" low="0" high="17" varset="source_type" variants="SOURCE_REG"/>
-		<bitfield name="SCRATCH_MEM_OFFSET" low="0" high="17" varset="source_type" variants="SOURCE_SCRATCH_MEM"/>
+		<bitfield name="OC_MEM_OFFSET" low="0" high="17" varset="source_type" variants="SOURCE_OC_MEM"/>
 		<bitfield name="SOURCE" pos="18" type="source_type" addvariant="yes"/>
 		<!-- the bit to test -->
 		<bitfield name="BIT" low="20" high="24" type="uint"/>
@@ -2277,10 +2288,10 @@ opcode: CP_LOAD_STATE4 (30) (4 dwords)
 	</reg32>
 </domain>
 
-<domain name="CP_MEM_TO_SCRATCH_MEM" width="32">
+<domain name="CP_MEM_TO_OC_MEM" width="32">
 	<doc>
 		Best guess is that it is a faster way to fetch all the VSC_CHANNEL_VISIBILITY registers
-		and keep them in a local scratch memory instead of fetching every time
+		and keep them in a local on-chip memory instead of fetching every time
 		when skipping IBs.
 	</doc>
 	<reg32 offset="0" name="0">
-- 
2.55.0

