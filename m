Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1729710AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:16:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B7B610EBE7;
	Fri, 27 Mar 2026 00:16:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="clUJcUTL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Xfc7SJRa";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C54510EBE7
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:16:08 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62R0F2QR3898175
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:16:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lVL5O2LZPIVIF6OfH5Vaje2elHwGIQmYJFJtw0KLdVs=; b=clUJcUTLTopvimJY
 Xbuqk1f0yrXUvhwAwNjBilwmUVju4lgaZpx044P6oAgEHZGlSKJjJQeyo/rZBBX0
 W92nCsGgS9YPMlgD18ezRg+rn+0pKA1svpwT1RXdwjeWa1ryCamUWm75ApwbVdKK
 9yy2CLcx5eceQmD0VErNgp9NdLe81xwqW2mr2/HueuC7jhnABhM7OyrWkEluWUXu
 c73XKE/t8CFuiod3U0VyNV/sBmJ/SZK9+KVKu7G6V3gvU6zcb9qFNwf+nsiqPDS2
 47EyEaW2EaCMzxbCPUPbfpZC2QJNkFnPC0Jn5iYU+TfAst37wrMq0onSm9VyuWCm
 wsgaeg==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d50kgb8d3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:16:07 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-354c44bf176so1993479a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570566; x=1775175366;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lVL5O2LZPIVIF6OfH5Vaje2elHwGIQmYJFJtw0KLdVs=;
 b=Xfc7SJRarWT77RWVeluDU28vBkcqUnnpsdloql1HTG3FtZLQ61TwsY4HscdfSW5c0Z
 ZMcF9bKwcnGefL+SZG2iPTo+ro/W22CfL4BFTBwiEp2y5+GsBfv+pGJM4Gg/hJAZPcyK
 xMGNPi/ycs/+VwqQshWugrxTuq4N3LxuD3huIjHz9KLeSwH2fcVwzE9Ur0cQ5mivZJ/3
 GXohOxIHPsECUrKLi3/56hvaD69KJa3L6SinNz4K9diFbs7z+GBLS9Vd8OY03468llf+
 IzfyNfzTg9puVIPztVYjBl5/F2ex6xn7oX2Vgnmnm/lQi1dR6ecKWbnY7LMHWQEuv3BJ
 Fn3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570566; x=1775175366;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lVL5O2LZPIVIF6OfH5Vaje2elHwGIQmYJFJtw0KLdVs=;
 b=IdeYAmWt09V7A2lJExVFd4wXIyL49gPDjwV+m7URBP+SAUFVUGXFWeiaJ+2LsQDVJ2
 LomFMYFkwWrH4pnk7/JJaXmCIzBGpwvRYDOfZBVendD7AFAQkGeGMkz58qgvKoSVnMdb
 i2+JP6wYCp3lt/DfSvSaX5wJcb5J14igSVg64LQ4d71RYR19eb/OiTu8nhIvIGdA7cU8
 BKrbriDaPuoyDrqBeDXWER8um3rhTw8nl7+ugyVSu/yXflDka2q+kKRK2bSIqsUFbQv8
 MtKS0XVT6uh4CceugX9QZcANFmU/UV0t13e9a0jddVd9gvrEcA4oRzir5xG9zkU6+Ocv
 8SuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkIh/c3sM9vKKdXEQg7yM0fpjBab1aaCAOUb9CU37iYOU/4WBW5CwF/SObOfbnHZ1+sG3L39q2z6E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyuKWJHjVNX+SBr/OkcVPpb8zF9ggCHWhbw573wbaAYrvQPm/r8
 VibMGYaeIWgFXSlou/gHsr14Bm7cMWCJkzP1St5WUJivNPq0zMV1Z+Oy+ErucBzNyfEOuX49Jhc
 ZCqP4add5aOoP/mff1L1OzxxRpnn717wMbsii1YEt8vAjq3WSJ1ZGziB+4QyoavUWqLJhmSM=
X-Gm-Gg: ATEYQzwrAjRvUCT/n50+N0CzoOFKXC7bkCTVd3tav+bLRIlRdWAX/qItdQdn/j1gWw6
 goDeqj3sXiepumsU6ZHZEg22phcMacgA2NgRDA6ToBRpm1yyEBdo/Qir1UBCLE6XcFvibXkl9SE
 dgzEYCuKZzTKGH0ZUzSgDHfSNNA0Ky+wDx6Lh4AUYaMHaAvGCnWvUfG+m0DkG9b6x6eP3XGTm6T
 uR4BaUZZKC22CB2NNew261n7CGPWwlgFRJHX5xvWZy/7rexe7kIdiLClDHYiJr5ujgFsTggQ8WE
 TpXC11oxBY5BjFtco3y7hdMF8f4RVPS4YVfq+EBiQInLrNy2TFq2Ve5qfuLbufipXRHU6AMRdjP
 xKTpZOmG44HoU7aKCURNqWUEXclOAjJiOkhl2s4iHAue2pQ==
X-Received: by 2002:a17:90b:4e88:b0:35b:a7be:ae47 with SMTP id
 98e67ed59e1d1-35c30056d6dmr521787a91.21.1774570566133; 
 Thu, 26 Mar 2026 17:16:06 -0700 (PDT)
X-Received: by 2002:a17:90b:4e88:b0:35b:a7be:ae47 with SMTP id
 98e67ed59e1d1-35c30056d6dmr521763a91.21.1774570565662; 
 Thu, 26 Mar 2026 17:16:05 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.16.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:16:05 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:44:05 +0530
Subject: [PATCH v2 16/17] drm/msm/a6xx: Enable Preemption on X2-85
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-16-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=3858;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=xUiKo1yj6GLcQVb+vkBst3BMjf309OP8s++yQjsuSJc=;
 b=VGy3ovjLVxccFdwgAKShQlB70TPJ3faffqhe/O4EVAuzQXrS+/wdXj5Qom5AcgEa5rUPWaX38
 +4BX/07VUtdDlDBAYFKTGFAhrn9s7RX25l8fbllD2NK/DW0Dmzbxmz2
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=SMZPlevH c=1 sm=1 tr=0 ts=69c5cc47 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=PN0yGgm3WGXANvjD27MA:9 a=QEXdDO2ut3YA:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfXzUyZ4E8ev1Cf
 KRTpza92M0zDXpnIZaiZAM8K0YMAN1oqxlS71rq3kGdi3c5sId9BFYW9vG+NfLbF5RwZMfmOTHJ
 EsnzaeWIYB0YnITVLmnB4iLMHmM8fe7q+WZ85q9KkKgOJ52CcdcQ4wHuq/JiWQNLZqHTyY+X/eS
 jUlAwGyns0o9nVcEaT6dB5368s0wfsv+F4LglZQdiTjMS9VyIaBQhODSb9Lh9M7NLbhi0pr5G7u
 UtZsmXudB7NX/LPX3cRbEl2jgeCpdPA65YyViqYfwSfEsKjzEVIYV/qL9d7gmhYsYjcU4WzV70R
 x6UBTDtBG9qhxTwfTf+T8kpfQhRvo82WhWBSZVYiBrRqYjOcJLxaNFct94nLHIDAEfpB/w4WkNL
 Jgj9bEhfZRtsdwP8vf5Wagh7/6wHT3nqLRUA8I0syfTzNIZ8+5Jbtx+cTXkQevebBLzakzeYO96
 LeEwNxD1pN9wYE66mjw==
X-Proofpoint-GUID: g6-FuyNZVPv8aFsHjnZFlUdVuOGehRmn
X-Proofpoint-ORIG-GUID: g6-FuyNZVPv8aFsHjnZFlUdVuOGehRmn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 spamscore=0 clxscore=1015 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603270000
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

Add the save-restore register lists and set the necessary quirk flags
in the catalog to enable the Preemption feature on Adreno X2-85 GPU.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 21f5a685196b..550ff3a9b82e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1761,6 +1761,44 @@ static const u32 x285_protect_regs[] = {
 
 DECLARE_ADRENO_PROTECT(x285_protect, 15);
 
+static const struct adreno_reglist_pipe x285_dyn_pwrup_reglist_regs[] = {
+	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_2, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_3, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_4, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0, BIT(PIPE_BR)},
+	{ REG_A8XX_RB_CCU_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_RBP_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_CP_HW_FAULT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_INTERRUPT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC)},
+	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE, 0, BIT(PIPE_BR) },
+};
+DECLARE_ADRENO_REGLIST_PIPE_LIST(x285_dyn_pwrup_reglist);
+
 static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
 	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -2082,11 +2120,15 @@ static const struct adreno_info a8xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_PREEMPTION |
 			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &x285_protect,
 			.nonctxt_reglist = x285_nonctxt_regs,
+			.pwrup_reglist = &a840_pwrup_reglist,
+			.dyn_pwrup_reglist = &x285_dyn_pwrup_reglist,
+			.ifpc_reglist = &a840_ifpc_reglist,
 			.gbif_cx = a840_gbif,
 			.max_slices = 4,
 			.gmu_chipid = 0x8010100,

-- 
2.51.0

