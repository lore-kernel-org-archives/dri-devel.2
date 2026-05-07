Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 301A2CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88AF510F0C5;
	Thu,  7 May 2026 13:03:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="X0UHr3AL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="E8xxCe7e";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9E9810F106
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:53 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647BO3wx3157423
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uukH2Hr1fThFSWIyYnWWKO/3affNsowUSHW3Fd24TQE=; b=X0UHr3ALeJ2X85U2
 5aKqfOdFP9Ga3vs76pr9M9mcPS7945AG7Mq904XnUcBJxxNTSPTPyYSyr395OsEz
 cuoBKD4ORvFQzksB4afNRARa0HDRrsuPqm7KbHphKGERb71Fp2wYs8slZ8uoyf+V
 7NAylGFjkwxkTIwYiMMMErhx5SpNHDwp2KKmdpdbouxLb87TkteS4AADQX9+UnE1
 FUHMSUYUxaVkVp6IdtImZBWYcSv5J6BKpSgmaSbkMYZGQkhR1kJyVoufrP0g2mf4
 3/aZ0KN5yfkumFDXGy7L65Ioct2shd2t9mkImCzFd114jZOiO6q+EPUm99uLjdhL
 KD9RhA==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0mhf1n34-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:52 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b461b36990so10420925ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159032; x=1778763832;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uukH2Hr1fThFSWIyYnWWKO/3affNsowUSHW3Fd24TQE=;
 b=E8xxCe7eRg5TWuBZWelMJ+TQw7XVGqNlQM1R55GwN5L5e07NcBZV09f6QwFAlaYSG1
 K6+aZLuUPHNdAGL5mt3gQVvlIFC4FgXnYFmF9fpoYAmse5qjuk8kn2iSikuDN2nTq/ez
 +cDLMI/mSAqP1LHpkU70eN3Hfa1Idi5Tpjugi4H/mXbOR/nfh7ntr8YEDDEsXQhK0aQ4
 d4YDFhOHLg9/eYYjhCI5NWaY8upSR624nAP/MDCfyswaQZt39LEWMBZ/US3biE7YYTCX
 pHPaUUAQzR90RZtJw9T+BYt6RIrLMVpxYm14PDIJrSo0uID5N67KcTp9IWAThhurETnx
 I0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159032; x=1778763832;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uukH2Hr1fThFSWIyYnWWKO/3affNsowUSHW3Fd24TQE=;
 b=H3BaQPQLzXq2rQd3B/7UZaXT7t30MJMRz7DU5UD/bA8yvPRBKo+IX91ylVsxUz6nze
 5N/B3UIJ5DQ84nEQ+JM3MWtHYkFn2UEFP1S4kOTvsto8ajk0DAOfA2EuAm20tlJzs0lE
 2aDtL4KpBxW2cfrGnDnX92QjFzFEe9l8BzExUHNxorwRhe+biQJV4ldCmq2X2yAtsQPs
 xLigVyAL7Vmv3eFpwRCy3EkOCPlNFuPxfwsj3AxCsPmtqSENjEr8P4PlaS+HQzxae252
 TgD3JJVfz1wSDRqu3BsWOr+LSlmR3XIzTDhiz0cYg9UbAZw1CoKhRngz2hPSE9mlyyhO
 LZtw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LtTIwLe64Gq1c5bD30oSdP6WI/qDb8IJfFdSZIsLFt2Q4jXEQmhFWgWdpUeewg1ohDmAk/1fBhcw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzlyb05vJA3vZTpC5kXieuOvDhV4tfydqkxuF76c5MqEBzRYGCv
 yCRuqOTSyZCqTju/FQZAxQFtpKazBYs3WZ6DQcTiUI4uXAJzydOdUiSSEmT/Zkd8n9dNuvSmhAM
 YkJTHX15HNn4e/Vjg5aiaJuvT8MMiI+dtQ9jR13aZuHFPmv0va0sXo8/R0qTS1MHwm6xUGQE=
X-Gm-Gg: AeBDietT89xelmcjgpaPlG5A33YVXFtTXq/x20WZ2WwdEkW+YJ/NPbLy1TIV46NG/L/
 2+q+rQV5YSJ6srNqF6MH5Wxf0tunNcOy55c0RPahwDvx/AMDEcRUTCePxCujEUdt3Nhe4jJF/xB
 P0qUgN2E3t3dIUC8fryl+fs4QI6xPAVE8mzz0O2etNpXsO37k/d2un9FuJpSvrDceU++yiPC/JF
 5zcximifw0+Gbw8XuEE+mjtKhkqON2zywmOYq0BruKNDEfMsuRpKsw8jgQblqhbj7zOC1pm/hEF
 dzNDWkV/bvj41FsQlVbmn9JNSzs7DgneDRFfDBUd0jw3Yqf1ok4xSA/ZKXIZ7+jGm6oGEwRhwzp
 BNV+MXIdAh2seXjwxJ8DGLNk6gZWtme/NwvXw4ifFjvR8Nfox79N5SspPLbCdWQfx2n7Oh17/E9
 /ENSJb1q0n558T64sTjvqOdzLgQOTgSTPwEXyyUKwZhwQFCQ==
X-Received: by 2002:a17:903:1aa6:b0:2b2:b117:1d5d with SMTP id
 d9443c01a7336-2ba7a358945mr82837975ad.33.1778159031774; 
 Thu, 07 May 2026 06:03:51 -0700 (PDT)
X-Received: by 2002:a17:903:1aa6:b0:2b2:b117:1d5d with SMTP id
 d9443c01a7336-2ba7a358945mr82836845ad.33.1778159030983; 
 Thu, 07 May 2026 06:03:50 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:48 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:11 +0300
Subject: [PATCH v4 15/29] drm/msm/mdss: use new helper to set ubwc_swizzle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-15-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2044;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=6iZnedW4RBQxA96XKjwsTUc9JsPI83to3JJHc5dyQQ4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2G9ANDXPjlZexp+XhfAK0XepXdN3d9kDcOB
 kYWyWUseyKJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhgAKCRCLPIo+Aiko
 1f2eCACpC1lnsPAc81O0pYhBeuPkG7mEdw2fwShl44wnSc0uzz1Ke4np7eTGJ3sNDJfEMVbGmZA
 SDtQST7+/BolNJvvzmWooCgJowDyCLUBOH9TMs+49kZrkbx2UmNbQnPUnGi+9HDXOzJ9KAs63kh
 EE51MckhcC4/vBYQgu7hoaZ87ffFPl2iWv0UMbXJkH49yi4qean9X0bDEpmtyhjbJLquLsinVTZ
 /EH4ab6GXPAGzPhLa8AxDOP06ykclcM4iT5IRKWiPhiARDoztOSbSZtsNo877qSak3X4nT5QvDk
 qiIlNGfZsvkX48s/w/XumIMX7qn9IcM54iZe1K9JeD6xNwc/
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfXxCG6YzVtk9ZS
 foPdWorFsS8wadtdxcNqMrqX3iLjyVllh8JhzuA6lapRDfQDJ9FLrRIZeJGm462QFFFeVoZ5xti
 dxpFB6drcIsv3Gs9E/oVaN8Buc4lk9Mx5xvtsxWSsXLpJuBTOwwWEVEElA/dTDcxYLsxcPVnW5d
 7BitDGlx01QYV0Dt+qaR0QoQKEXa6NBghnWLoO/VrSMX48BTwTXMo6hI8l23vLI4WTwyAqi22Un
 X5KjaIwNcEQ5FSvFbSNTFlQdU3hDHJfdPub/FW2EBKS0LxGSgHFsOXf79R0IEpoaMBlbRKByvEQ
 CCYwWTGibtMh9lu/ZO3YPrlSPz/c3yQZRCQbvhYeD12mHjv0lL72wOFxsQ/yfjzWCn0jYohWtSj
 Totf1TO4hsRHwJSKdm+90u0o0rR57BDjWwWX71gLep0Wpdlh14bQatdiOU+KjIet9nbRNe6APu8
 ifcOnEMNig88NIws5og==
X-Proofpoint-ORIG-GUID: XE0qfOWvgs5pkPsR15RjGhz1R6BDkqJQ
X-Authority-Analysis: v=2.4 cv=SuagLvO0 c=1 sm=1 tr=0 ts=69fc8db8 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=crYPmtHWi7n-_IQ59sQA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: XE0qfOWvgs5pkPsR15RjGhz1R6BDkqJQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

Use freshly defined helper instead of using the raw value from the
database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_mdss.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_mdss.c b/drivers/gpu/drm/msm/msm_mdss.c
index bf106d849dea..3c1f04f12c3d 100644
--- a/drivers/gpu/drm/msm/msm_mdss.c
+++ b/drivers/gpu/drm/msm/msm_mdss.c
@@ -169,7 +169,8 @@ static int _msm_mdss_irq_domain_add(struct msm_mdss *msm_mdss)
 static void msm_mdss_4x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
-	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(qcom_ubwc_swizzle(data) &
+						  UBWC_SWIZZLE_ENABLE_LVL1) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
 	value |= MDSS_UBWC_STATIC_UBWC_MIN_ACC_LEN(qcom_ubwc_min_acc_length_64b(data));
@@ -180,7 +181,8 @@ static void msm_mdss_4x_setup_ubwc(struct msm_mdss *msm_mdss)
 static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
-	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle & 0x1) |
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(qcom_ubwc_swizzle(data) &
+						  UBWC_SWIZZLE_ENABLE_LVL1) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 
 	if (qcom_ubwc_macrotile_mode(data))
@@ -197,7 +199,7 @@ static void msm_mdss_5x_setup_ubwc(struct msm_mdss *msm_mdss)
 static void msm_mdss_6x_setup_ubwc(struct msm_mdss *msm_mdss)
 {
 	const struct qcom_ubwc_cfg_data *data = msm_mdss->mdss_data;
-	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(data->ubwc_swizzle) |
+	u32 value = MDSS_UBWC_STATIC_UBWC_SWIZZLE(qcom_ubwc_swizzle(data)) |
 		    MDSS_UBWC_STATIC_HIGHEST_BANK_BIT(data->highest_bank_bit - 13);
 	u32 prediction_mode;
 

-- 
2.47.3

