Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6158CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 15:41:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA3F910E796;
	Sat, 10 Oct 2026 15:41:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="FgaA27j3";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Vkbpiqdt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27D2110E14E
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:41:37 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69AFOsJN969425
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:41:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lHYrzeSQljh
 SXcWIfXDm+2yArtTaNKlLE8yfNxhVQTc=; b=FgaA27j3gnyuIesmZgEXYpCbiEF
 0TcVR4OS4lc60vtPsJlIKA3mNSy0iVnewCO+4Sgi//H5Kk+lp8basBC+JuqopDDf
 7y5Yyba8pfPW/kDQDMceNUzNTzCHjKpw0thtgthp7WXM9s3oYUXV5gNpZrOkFDwG
 EqyiyzwYi4thepbfpsZe1xHaU8LoIpHuQKVn5uI7tgr95DwUbWrPHuqWjxAuwiB4
 FKUHCVPySOSrFvUYvW+frVEgKPBg21JSb0VZH8ymK0RHkceYhfMvh+nIy0QZvTna
 ipI43B7Hjc0+2rVX7CuAdKiwmn+rrC8xXhW012VfiV7sMVMTRNVhERjtFwA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h7dk219rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 15:41:36 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2d001671a54so9979835ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 08:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791646896; x=1792251696;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHYrzeSQljhSXcWIfXDm+2yArtTaNKlLE8yfNxhVQTc=;
 b=VkbpiqdtEJ4B1pZSsbd/pc6Hrd575yJJb7h1GKss1RM3ysUpzUdIXg/wHgDKEMrjkU
 yPlNhcohXAIJQO2CVzzwmfpDFbzgiJOYvgMXZdH/GtcA2xX9VyXu2/3TqKFuw3TMrwGP
 jqq6BvveTz7C6fs0RgfTkNXJuUwcuPFv2bFuQO0Py/jkAMN71fpKHH6gXwHmhoku+BaP
 UD1O8GrWO8Sn5jkHueC4WBR3AYpFC2AWf4ydyMTWf7nsS5lkPLCJguAnNH/fSUOwKA2n
 jWiq8yYYeONGoZJMclaIncSC2LVjSXKhfyYlxs+Z77nn+n42BEd+BM3AOXjhPUDRXK35
 xrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791646896; x=1792251696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lHYrzeSQljhSXcWIfXDm+2yArtTaNKlLE8yfNxhVQTc=;
 b=WhGYCZbI8qfHVNbcwivgOYxJkn1AuPc5mhGTRrPHi4mztSdGYQUCtKo+Smu5RtGALc
 ebNjoum2qiNN2g4MzZnZjsBtsar8ScJtjX/q6QPO674l6u6VoDc+PmhS7SG29rd9/Nsl
 sK0M5+clRlenBT8OmHvq0MCwCqe4Utbeu3xUsGAix+iE8cWwrZLZsQfxMs5kZXHVx4Jo
 NjHlvd+L2Z/Y2SW7JFDw10WHWlm7L5f6nNw7Z/yA+katG6UK+dsi6l/D63sbHfPFly6i
 svza27S7/xeVGBZkS0P6FS3fBgmVL9h9eDVE5gk8ZEiVt0A694kw/0JTameqhwOH9qgJ
 oy0w==
X-Gm-Message-State: AFq9FYK8mEDjIzOOzA5MvMATDp5F6PlcW0OLXzG6F65p5z17hK5C94ir
 V3HaELTCVDXH6wira10Bj7T54vijRncLHwrrHvFAXU+3GbvtJQgWDnSnTXOwpDmui8At4grXfs+
 27/5G2PmCQk6h+NsTvJgWg7XF5AhfGtCGPJcfcbD7YHa4pSGKOt8cX95rKzzn0sp8vR71fvMRzY
 ZtLag=
X-Gm-Gg: AYBFou32i/XodPvq2kguxpxpI+2cqgcnLTZylLuV7u9BeH2fSJnjuMxjVf3OUiYkL0n
 tx0MMYn3sxFjcphzUu8B/e9qvVhP9/dLkWlJKaa1ZVEwLFmvTzG0bYnWX1fKHUpygxolWIl3WIB
 uLw8/7QMXj18AGUm6dcujiYdLL2XAVo/UdtFjSMOG40ko75kr3G9gbtKtQCsiq7HcDM4hH7wWDT
 FTXCaAJtvZXm6I+9gS4Mkx1BW4aSfIWsKRN61RwNJ+HZVmAvpmomT9n/NrtRk9pR2EEtSn/vpc9
 LP2XE19wOYQkqu2dgTFJSLIAenNaJjJSpcgYa4XStGk32dvyqMXq/K8EFzo530v0ZkOPvuHfTtq
 EQydsOgjamFuYio/mtmwnOYdPTmXVblUuw/eaIcUdhQh6CT4myg==
X-Received: by 2002:a17:903:324d:b0:2d9:464f:d45f with SMTP id
 d9443c01a7336-2e84280aef7mr42482395ad.5.1791646895945; 
 Sat, 10 Oct 2026 08:41:35 -0700 (PDT)
X-Received: by 2002:a17:903:324d:b0:2d9:464f:d45f with SMTP id
 d9443c01a7336-2e84280aef7mr42482105ad.5.1791646895337; 
 Sat, 10 Oct 2026 08:41:35 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e8422db284sm23095575ad.68.2026.10.10.08.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 08:41:34 -0700 (PDT)
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
Subject: [PATCH v2 1/2] drm/msm/a6xx: Move a702/a704 to a6xx list
Date: Sat, 10 Oct 2026 08:41:19 -0700
Message-ID: <20261010154125.726149-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261010154125.726149-1-robin.clark@oss.qualcomm.com>
References: <20261010154125.726149-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: nBh0T9ajVngctKAmPNEq-YUJjonqkTog
X-Proofpoint-GUID: nBh0T9ajVngctKAmPNEq-YUJjonqkTog
X-Authority-Analysis: v=2.4 cv=E6hYNqdl c=1 sm=1 tr=0 ts=6aca5cb0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=lSLAbbbIx1VGLg0Ku8YA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEwMDA2MiBTYWx0ZWRfX7FRDDuiaCPRE
 7d5q4D5xEAjMfon0cQMXVK+d/8RKmuxOQqdyYeZcBpd/pXSH5YbiXTA9EWcI108opYuWEUSJViI
 PGk+L+R5/IjbhFXRpEayBgS17j4ln6GVvg9erUtqASRbwsfEXu3s3DQPoa11J6uAH5etr9YuWDe
 SOAVJUKTsQqxfafBydin2otNSwJZvig8XJqcVInzegdPEk8eQ/5DqbOy2IUzJ19rn8yvAM1GKDB
 m4WoDacmiddC7UJ/LecWyrx70S9057UvXdseP6M9rZ6ErraxJf/sxpOgEd1UAs7LQaU1Llymuvn
 XEQ6lCXvO7p7JbacMYvaF/yNxi6whyXJjlO2o7whtDx/m6YlYoOcLNjvLeWo9io+Vk5LDgF+luN
 eKMkxVMqhwuFTuVbeqO9zJoNiSaVL5Ki43pxt30hXHS9K087p1mPTg9OvZcIU0SyWwLE9QqBDqK
 HBxVVBR8jpym74TBuzQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEwMDA2MiBTYWx0ZWRfX/jI+ngHbmnh5
 Fjo7qe6pY+UlxbTltc1eBFRdKjNSJyrIumniVQyU8+0LpUaNxc4PgWEQfuJEcBd2ipBfvt/Edrl
 gE3EmqeK8ct+wzNzVG3g/eFI21JeiN4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-10_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610100062
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

It is a bit more a6xx than a7xx, and this simplifies the next patch.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 168 +++++++++++-----------
 1 file changed, 84 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 7319f3ed6968..b44b0fd916aa 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -678,6 +678,65 @@ static const struct adreno_reglist a640_gbif[] = {
 	{ },
 };
 
+static const struct adreno_reglist a702_hwcg[] = {
+	{ REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000081 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_SP0, 0x0000f3cf },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00022222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_TP0, 0x11111111 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY2_TP0, 0x11111111 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY3_TP0, 0x11111111 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY4_TP0, 0x00011111 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777 },
+	{ REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777 },
+	{ REG_A6XX_RBBM_CLOCK_HYST3_TP0, 0x77777777 },
+	{ REG_A6XX_RBBM_CLOCK_HYST4_TP0, 0x00077777 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_RB0, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL2_RB0, 0x01202222 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_CCU0, 0x00002220 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_RB_CCU0, 0x00040f00 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_RAC, 0x05522022 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL2_RAC, 0x00005555 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_RAC, 0x00000011 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_RAC, 0x00445044 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_TSE_RAS_RBBM, 0x04222222 },
+	{ REG_A6XX_RBBM_CLOCK_MODE_VFD, 0x00002222 },
+	{ REG_A6XX_RBBM_CLOCK_MODE_GPC, 0x02222222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_HLSQ_2, 0x00000002 },
+	{ REG_A6XX_RBBM_CLOCK_MODE_HLSQ, 0x00002222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_TSE_RAS_RBBM, 0x00004000 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_VFD, 0x00002222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_GPC, 0x00000200 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_HLSQ, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_TSE_RAS_RBBM, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_VFD, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_GPC, 0x04104004 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_HLSQ, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_UCHE, 0x22222222 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_UCHE, 0x00000004 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_UCHE, 0x00000002 },
+	{ REG_A6XX_RBBM_ISDB_CNT, 0x00000182 },
+	{ REG_A6XX_RBBM_RAC_THRESHOLD_CNT, 0x00000000 },
+	{ REG_A6XX_RBBM_SP_HYST_CNT, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_FCHE, 0x00000222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_FCHE, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_FCHE, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_GLC, 0x00222222 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_GLC, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_GLC, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_CNTL_MHUB, 0x00000002 },
+	{ REG_A6XX_RBBM_CLOCK_DELAY_MHUB, 0x00000000 },
+	{ REG_A6XX_RBBM_CLOCK_HYST_MHUB, 0x00000000 },
+	{}
+};
+
 static const struct adreno_info a6xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
@@ -1129,69 +1188,34 @@ static const struct adreno_info a6xx_gpus[] = {
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00800200,
 		},
-	}
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
+		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
+		.fw = {
+			[ADRENO_FW_SQE] = "a702_sqe.fw",
+		},
+		.gmem = SZ_128K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
+		.funcs = &a6xx_gmuwrapper_funcs,
+		.zapfw = "a702_zap.mbn",
+		.a6xx = &(const struct a6xx_info) {
+			.hwcg = a702_hwcg,
+			.protect = &a650_protect,
+			.gbif_cx = a640_gbif,
+			.gmu_cgc_mode = 0x00020202,
+			.prim_fifo_threshold = 0x0000c000,
+		},
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 236, 1 },
+			{ 178, 2 },
+			{ 142, 3 },
+		),
+	},
 };
 DECLARE_ADRENO_GPULIST(a6xx);
 
-static const struct adreno_reglist a702_hwcg[] = {
-	{ REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000081 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_SP0, 0x0000f3cf },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00022222 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_TP0, 0x11111111 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY2_TP0, 0x11111111 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY3_TP0, 0x11111111 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY4_TP0, 0x00011111 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x77777777 },
-	{ REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x77777777 },
-	{ REG_A6XX_RBBM_CLOCK_HYST3_TP0, 0x77777777 },
-	{ REG_A6XX_RBBM_CLOCK_HYST4_TP0, 0x00077777 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_RB0, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL2_RB0, 0x01202222 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_CCU0, 0x00002220 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_RB_CCU0, 0x00040f00 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_RAC, 0x05522022 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL2_RAC, 0x00005555 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_RAC, 0x00000011 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_RAC, 0x00445044 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_TSE_RAS_RBBM, 0x04222222 },
-	{ REG_A6XX_RBBM_CLOCK_MODE_VFD, 0x00002222 },
-	{ REG_A6XX_RBBM_CLOCK_MODE_GPC, 0x02222222 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_HLSQ_2, 0x00000002 },
-	{ REG_A6XX_RBBM_CLOCK_MODE_HLSQ, 0x00002222 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_TSE_RAS_RBBM, 0x00004000 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_VFD, 0x00002222 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_GPC, 0x00000200 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_HLSQ, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_TSE_RAS_RBBM, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_VFD, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_GPC, 0x04104004 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_HLSQ, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_UCHE, 0x22222222 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_UCHE, 0x00000004 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_UCHE, 0x00000002 },
-	{ REG_A6XX_RBBM_ISDB_CNT, 0x00000182 },
-	{ REG_A6XX_RBBM_RAC_THRESHOLD_CNT, 0x00000000 },
-	{ REG_A6XX_RBBM_SP_HYST_CNT, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_FCHE, 0x00000222 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_FCHE, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_FCHE, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_GLC, 0x00222222 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_GLC, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_GLC, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_CNTL_MHUB, 0x00000002 },
-	{ REG_A6XX_RBBM_CLOCK_DELAY_MHUB, 0x00000000 },
-	{ REG_A6XX_RBBM_CLOCK_HYST_MHUB, 0x00000000 },
-	{}
-};
-
 static const struct adreno_reglist a730_hwcg[] = {
 	{ REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x02222222 },
 	{ REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02022222 },
@@ -1454,30 +1478,6 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a7xx_dyn_pwrup_reglist);
 
 static const struct adreno_info a7xx_gpus[] = {
 	{
-		.chip_ids = ADRENO_CHIP_IDS(0x07000200, 0x07000400),
-		.family = ADRENO_6XX_GEN1, /* NOT a mistake! */
-		.fw = {
-			[ADRENO_FW_SQE] = "a702_sqe.fw",
-		},
-		.gmem = SZ_128K,
-		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
-		.quirks = ADRENO_QUIRK_HAS_HW_APRIV,
-		.funcs = &a6xx_gmuwrapper_funcs,
-		.zapfw = "a702_zap.mbn",
-		.a6xx = &(const struct a6xx_info) {
-			.hwcg = a702_hwcg,
-			.protect = &a650_protect,
-			.gbif_cx = a640_gbif,
-			.gmu_cgc_mode = 0x00020202,
-			.prim_fifo_threshold = 0x0000c000,
-		},
-		.speedbins = ADRENO_SPEEDBINS(
-			{ 0,   0 },
-			{ 236, 1 },
-			{ 178, 2 },
-			{ 142, 3 },
-		),
-	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x07030001),
 		.family = ADRENO_7XX_GEN1,
 		.fw = {
-- 
2.55.0

