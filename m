Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0330BCA6019
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 13:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FF74112149;
	Fri,  9 Oct 2026 13:19:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SIfJ0SSe";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gdJo5Opn";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC045112148
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 13:19:39 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6998KJLH1746859
 for <dri-devel@lists.freedesktop.org>; Fri, 9 Oct 2026 13:19:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lHYrzeSQljh
 SXcWIfXDm+2yArtTaNKlLE8yfNxhVQTc=; b=SIfJ0SSeg8QQMpGBVg6tkyITkrf
 L17Z8hEmZWj5tPCHzCq1hRM4hgh9cGB2/y3BkKoT/7ODn/g4KOll9QXGiLR5Qbce
 n+U3GZtlvY/ijAdPsCWrF4Q42/XxIByRdWWHY7B3QAvQ82zeWUfBhRl67PTMRJEs
 RrTxGEM6MFAQ96bwAisAtXZc8GjxLL5wmUETLYDqP4e3OkL23oTYHuxKfUTY5xg3
 bGnJ3D7JwloyM5mC/BLt+z4KUCmrzADiT/8/s50uMZHK6d9GyCxpDTVKMLYiGXl3
 mZlyHFWmESuhxjN4fGLGJmKdIgYAGq0amzc1FsTft9fv/i6TbQc++EHh5dg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6ekvc0f1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 13:19:38 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3ab1e771632so893287a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 09 Oct 2026 06:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791551977; x=1792156777;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lHYrzeSQljhSXcWIfXDm+2yArtTaNKlLE8yfNxhVQTc=;
 b=gdJo5OpneEVHnaq7w3NrpnDfsKchoSpUVVOi3zuRmLB9q9pKl3W+AquKIqqs+D6+JY
 DNr3/ddN5QobR9CXTFBFEX/gvZ9Ku3Ug6G1xZA36Hq3HJcgzvqtPTVaHgI2T1++LpKgD
 aHLVFUoF1y5QE69l4Td6sjCt/b1g7njQskK4z1H4vvjip3JkzMVMAT5+Tslll+BcmtPK
 vf12eS3OlWqrOXuVuc0SWWjQbvG5qrvFSinnzQUw3q85RM+CrsGsvU3ureaadAJYKAl1
 E7HOCUVsHxafDk9s6c8xG2mdMTqafodfj2659R/rfwd9iMAp5LJhT/ihwFxqv5tTWAos
 WrPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791551977; x=1792156777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lHYrzeSQljhSXcWIfXDm+2yArtTaNKlLE8yfNxhVQTc=;
 b=vpW6MceOoNP6gopfDrvvP2u72DQr++dDHJ7dF9URfAb9VmGK2igAsTMtDq6jmDPSPd
 JMwvy+CklGsp28njo9t8FjSyEIpsjUKfKOgJJ7MHIMmSJBADzRO49LizyUyhbbMfNz/p
 sLDHxxCezFgvtZuNb3hm35LczqMwxTiIjuG0ZfOywKP128j061W/yB+jtSJwH7l70CS2
 WLZKRH4XZSyYzVm3I7CvLALJQuUHE4NesQTwqzyI+fN8f5vs2Z/nJLVz2+knTtzRX2CR
 19+p61J0eKoUKy1z0zYmaKyVQYrvOy3oBE26un+ZwdKeg5bfCusoXA0rUe37RwE1rV/i
 yDtA==
X-Gm-Message-State: AFq9FYLW3TqKPlHUkaFy0AkPtP6LZckcNvKvKCQAygavgSEsWwQrX+GM
 sroePrP5WzyMrB9/LkEvfO30ySnEdttOSVXVhwEOYJYzsmfSO5irZqfyBspPwF8AYZ2CYA334lh
 b/uzFydtn/n+LWx9CDFRChp+RLtwtq2VuH4DNz1dXgmR03WJICulBvjNiQnDFxHNf2oKkv4ebgf
 MQD5E=
X-Gm-Gg: AYBFou0uHD+NTfdRueLd8lxhwTAOoTpzvfn9xI8VEDsM8RhGT2+oN84upQMIvU9pAEo
 tB82CXEoH4HLy1Sk4lZgmhiQiOYCAc0nQIK+UBDW9sOxK6iK8PyYyrRiWKQcRf+aGslcWyFO7g3
 SoIwQIiQ+G/zIQ21xmrfmSmoIIIRn5I1eFhUKHl0yvnkJQrBefo2zJ92nirznGE4ywIxbuogVlp
 O/DO2LgZwhb3QXVweZ5Qw0e9l2IUP5UxNIkvfmLi7re1o1ajFQQOUPZiQjJST9bqu1E4LB/4tjy
 DQHrfZdjljv7XxBmwNlC+qK/hEoGTGAed2t7ibtMou0cchGvXRol8IGPmkl4QChv1n/3XXxdE98
 rjpvCcZkoyIL4kfujJPSJ+Ek46DuTyDSM42G9IyN2fR0XfgA=
X-Received: by 2002:a17:90b:3a43:b0:3a8:23eb:d1d0 with SMTP id
 98e67ed59e1d1-3ab36f0dc09mr1733488a91.52.1791551977079; 
 Fri, 09 Oct 2026 06:19:37 -0700 (PDT)
X-Received: by 2002:a17:90b:3a43:b0:3a8:23eb:d1d0 with SMTP id
 98e67ed59e1d1-3ab36f0dc09mr1733470a91.52.1791551976557; 
 Fri, 09 Oct 2026 06:19:36 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd3d9e082e4sm910227a12.10.2026.10.09.06.19.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 06:19:36 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/2] drm/msm/a6xx: Move a702/a704 to a6xx list
Date: Fri,  9 Oct 2026 06:19:21 -0700
Message-ID: <20261009131927.551319-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009131927.551319-1-robin.clark@oss.qualcomm.com>
References: <20261009131927.551319-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 0kgAOzBmFEtKm8fFMElUqFmJWZ81OTKJ
X-Authority-Analysis: v=2.4 cv=csYOAF4i c=1 sm=1 tr=0 ts=6ac8e9ea cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8
 a=lSLAbbbIx1VGLg0Ku8YA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA1MiBTYWx0ZWRfX5OtLovmtQNXj
 HA8Acq5wtLJIUj7k+SHbl4wHVHZ1FFwAwpY0LH+z9BCJGYAQ1DYTekPKGCNo7UcHU4KxzONMBlG
 v3mjSNA4zQUmTW7q/P7td+U7652rNTm3l4WluE9Akes77kL6Uhmvi7Z6xTBJwFYIoAz4b7QZ/bS
 vFypkkm0i1jtpZsOd5k+48Fw6VFcwsCpZ9qB4t6B9G8N7GzLncSTxLLxHl+NWPxDOUX3jEliljj
 uC/S96+h0UU+HECyRtGoqGTqPOYh1evOUhrl5Rh2tSgTSGhrYZTLSGpJkuSOLnbk+ooV3iSVX4J
 YMHKG+QnhQ0OCUZ1lPXZr9gGYZ7j40p4G+aGKzi5Q5tSS0yR3JkwpcdYwOrKv2/M/xGjtMbhjUb
 sFIa5+d9og1Wh5Y3B8uEQecgZgF1OT0nv2TMvm7QobbOJVIb++3NrteqKHtawo3UTy8u8/Fqwv9
 oHYsrLf4HWhMKxJ9wgA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA1MiBTYWx0ZWRfXyHEkqzWSER7Q
 z0nH1Fvp2gc8ndZnDBtgC1aHdNwhgXTt8MXM0KAe3qV/f7tmSVUw98bgbyu/0Ffzz+koGKvWRlK
 S7HiHQESxIgxy4GkHENW3mgRCgYWxIo=
X-Proofpoint-GUID: 0kgAOzBmFEtKm8fFMElUqFmJWZ81OTKJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_03,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090052
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

