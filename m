Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49A7FCD343F
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9791810F10B;
	Thu,  7 May 2026 13:03:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gk7eN6vB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BkC/pSVB";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F00F10F0FA
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:23 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647AF3Td879602
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uowZPAe0p/cWkm8GtHlypt4vcKjscGJ6WfGzYlQEuf8=; b=gk7eN6vBYHaAk0pk
 vja9fa0W+hP56hqQu2NPbo03OhN5dJLdY1GEhM3fNjBGFue4pPzrLe6pBUSGkdeE
 rmGjhPnP38BpmZ/Nsj+rHdAb/oJX+SRcrkDgrad8ZbhzXY3EDez+WJ1/nnfMWkj7
 jjLatUkXXO1iw2gWhdw4s3DRi1SjAXY0AjO8GjRTlksefU7I1anN9Al4Y8eCF4fa
 R34vMIhiWomLOlRc9j0veBGZylRCBJdBSh9TbZLjqJ2pNjKdouxuXXEoN1IvJwJ/
 2j9wNsmWceCmpLdBlPt3Cq25gnpeedLgmehN0kTXXKNVOYMN3U0bvSbac12AQuzh
 ZRFDbw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0kdq1v8x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:22 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2adc527eaf5so7568395ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159001; x=1778763801;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=uowZPAe0p/cWkm8GtHlypt4vcKjscGJ6WfGzYlQEuf8=;
 b=BkC/pSVB1RX428E/tdplsT7QXRbuZ717G/5lLBczrgP5rHd07gGlG+8NymFXI6Q8IN
 SNKTpk1Y/V1oWa8bFfpiYLPUmtAVnFBKCUgmW2X8LUXx+cLfJ1AZJ8ZgVS1d/X3xPxZ6
 FSl4g8kyh5sF88mL9ZnKD0qwWB4odxyMaItBW5HIjVdkfRSiyznsA3tTmncQ30vTnnXE
 Fq0bME/EnDkeHWCTLqKPCNvbEgtUIGlIyzg/9516Z8A0kMuEBaumCef+u05hhJaLrCCo
 vhfBUF6G6Fx8x1zICEInR3BSIn/611aj2FfSaxlIATk05I6D43Lsd+Lqvi+n1IAX+nj+
 362A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159001; x=1778763801;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=uowZPAe0p/cWkm8GtHlypt4vcKjscGJ6WfGzYlQEuf8=;
 b=RevSNs5PQCgUiMduKnpBDzh7bnHn4pvaFR10M1IU563UiHkgcS7B4KmETTxRI+eyiZ
 OFc8uKXLJ/+jjcExKddpCsxR+sqHAtXdony87A31Vf9C5IB0GBDPzFeH9rXvi0HWhXp/
 TNIZPBT9QuVrQVJwXs1pp4Lok6qpuqAMZEogZmobDF29v51fX9V8OmO+UhEtqC2oOPA+
 M4yXzuPh8NhiNTof5eaoSpcOtIC9ESYiPL3Y+zEyt8eKV470gHIJZ5xO5EQj70PQbOCz
 CY4T08BLnxjO2VqLxXdHJyiYdDp3yqyTwxnjFCxNI//hoAJrKcUhPajpds1/FCCgVyU7
 S+QA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9k1qP8Nv37hg9PtMpVUFJ+ixBNzOOGb9YnJ1DNqhV+LXQbOvRquNvCZypi63vQGoUT469A71I/gH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDTjP/bRP/mjoKLH2OeRYk4hXDacO/XCGAELEGH7uepBf/5Ka+
 sdMjMBRDaSiX9IsBbOmCseXDgbnfnSfc4ov9/OXtyG4gFk5Fyq43Qi6zGmQ1nk+0z+MzHF6bJKD
 SoGzPUuvyJBNguSLAw9eU+CZ7oEBFAZCSVbT2sSZGkwjxvR4QDu5kQfpQVTWLdC67uts9UHU=
X-Gm-Gg: AeBDievIcTOAB3CMC5wTkT7FGr9JuXR4DK0RBBOBqnn0xc7Xa3OxyyuiKJat6WV9b/8
 ZfPrJuS+n+JdmMWnfaasVD7/LSoQJcx7VVCD8YKHUlm09xxr5PF1e96HtOhF8Lb0dHtaYa23z2r
 5qj8Oi0YjKd862DOz5LTOoZz5MLgV6KJs4BTmWSZUMCKgq0szY4GtVV8ye1X4kaaJFaF8WFHVdQ
 pRtwFtLiBYiSOQaQ1SK5O7Jg+s6XRhwjptNYIJPqVyeygKjiuXXOQuHv8bnD6Lrq8lAKEZnsQqp
 kWvwRKgh9nA4Rwuvf6qATEzMgCb0gVyLoI6Y5s00Faj5vkGjDL3fH+MsZKIBIDL7dkO2boo56qM
 AHVwKnugBA8DqcpDMr/31hpKsuD1+9rCdRtkY62hnij4HqeqxEQK8/3AXUMRJ6+9yHD3cImRoDd
 QEuQcumeTw7ThdzTBVJSbW0bKUfK49dxeQB9d7aSML0UhKhw==
X-Received: by 2002:a17:903:b46:b0:2b2:eb9d:1648 with SMTP id
 d9443c01a7336-2ba79c25ad9mr82066325ad.37.1778159001089; 
 Thu, 07 May 2026 06:03:21 -0700 (PDT)
X-Received: by 2002:a17:903:b46:b0:2b2:eb9d:1648 with SMTP id
 d9443c01a7336-2ba79c25ad9mr82065745ad.37.1778159000507; 
 Thu, 07 May 2026 06:03:20 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:18 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:01 +0300
Subject: [PATCH v4 05/29] drm/msm/adreno: Trust the SSoT UBWC config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-5-c19593d20c1d@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5880;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=vKJ5Okv8/mY/+V92nlnNVbn5KJI7SCcR+qGexLCfQKA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBp/I2EmchDTOZURru4fhGhuxYu51QFJpZ+gv2t3
 OmJhWoG+IyJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCafyNhAAKCRCLPIo+Aiko
 1YHLB/4hGDgjAN+g+/IfxdO1kUadLQo3qblGRGZpcSt2/UzQqQGzVB23s2ST5tHCprS1ZGi4llv
 JP4B87hY4kt9JhUR3Bjc5FB1hAcTLb4IAGL/Xz0tLmX2WLvxQ7bUkEg15xE194G+208HMFeTJke
 9Mc+h8aoOkAx9cgwAEvgTfgPR256fDjkbm+B2iELYnFjEjEiPl962BnS1ZH7ZaG8+ugw+KWA7yj
 ldnIGWcK3yKOTja8ap3z7HyMF68G32wwVGRYkXkCkFvs/Lqr8aPuJtjVN57UE0f6IlQkfbvANsu
 SRxZu7HMeY+bzdUJxrrg8hBZE7segrr1OgbQctx1MHD5voQ7
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=P6IKQCAu c=1 sm=1 tr=0 ts=69fc8d9a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=IhcC-CrlSmvFA89tYH4A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: JXgIGAviYyXKAjn2N5QDjeiBtJfVr5ST
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfXzEnD0efURChL
 Ony5RRXPQbQgx/j94JFurJD3WvYOoHwEBNsTF851ifGsB8khY8F3wuDnPnuAWsqNrj4j0xIf/IF
 fYHsA5W8ZkF3PGnitF2hHFostFEnqZ7z8r41SaLJtnmgua1J70U/LjH24taG4M67ipwRCvRuSM6
 KURLB/ElGQTiSc50vVBLidP1x16Uhzfyfk2ZbVIUpi/j9lV4DgCGTep9YQ3obV1QsoefmKvEPl5
 TPOZHpfYxp25kI2XU1z3hiVsSzrwPhr130goEVbf77W6C5UIHik41/YSdWzqLSjfLkgV3LTm0CZ
 XuEFyOud6tnVCr8NZb+nnOq17AMBHL5GgT/94h5SSYp7Mt6cIxU6lJxkWPdV/C7R+ePRHxy0bxJ
 sXCPATWjouQ8zUdt/RMUluncQoePGHTQEkOvE1vsI5VQcLclQfPVa4tRhBD2Rm48rspQGK2OE5+
 DqBvDVL5wnEt1MPzEpA==
X-Proofpoint-GUID: JXgIGAviYyXKAjn2N5QDjeiBtJfVr5ST
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605070130
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

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Now that the highest_bank_bit value is retrieved from the running
system and the global config has been part of the tree for a couple
of releases, there is no reason to keep any hardcoded values inside
the GPU driver.

Get rid of them.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 11 ++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 82 ++-------------------------------
 drivers/gpu/drm/msm/adreno/adreno_gpu.h |  5 --
 3 files changed, 6 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 79acae11154a..699fc0f551ed 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1725,7 +1725,6 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
 	struct adreno_platform_config *config = pdev->dev.platform_data;
-	const struct qcom_ubwc_cfg_data *common_cfg;
 	struct a5xx_gpu *a5xx_gpu = NULL;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
@@ -1769,13 +1768,9 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	a5xx_preempt_init(gpu);
 
 	/* Inherit the common config and make some necessary fixups */
-	common_cfg = qcom_ubwc_config_get_data();
-	if (IS_ERR(common_cfg))
-		return ERR_CAST(common_cfg);
-
-	/* Copy the data into the internal struct to drop the const qualifier (temporarily) */
-	adreno_gpu->_ubwc_config = *common_cfg;
-	adreno_gpu->ubwc_config = &adreno_gpu->_ubwc_config;
+	adreno_gpu->ubwc_config = qcom_ubwc_config_get_data();
+	if (IS_ERR(adreno_gpu->ubwc_config))
+		return ERR_CAST(adreno_gpu->ubwc_config);
 
 	adreno_gpu->uche_trap_base = 0x0001ffffffff0000ull;
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index d5aba072f44c..1d998636c5a3 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -733,82 +733,6 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 	gpu_write(gpu, REG_A6XX_CP_PROTECT(protect->count_max - 1), protect->regs[i]);
 }
 
-static int a6xx_calc_ubwc_config(struct adreno_gpu *gpu)
-{
-	const struct qcom_ubwc_cfg_data *common_cfg;
-	struct qcom_ubwc_cfg_data *cfg = &gpu->_ubwc_config;
-
-	/* Inherit the common config and make some necessary fixups */
-	common_cfg = qcom_ubwc_config_get_data();
-	if (IS_ERR(common_cfg))
-		return PTR_ERR(common_cfg);
-
-	/* Copy the data into the internal struct to drop the const qualifier (temporarily) */
-	*cfg = *common_cfg;
-
-	/* Use common config as is for A8x */
-	if (!adreno_is_a8xx(gpu)) {
-		cfg->ubwc_swizzle = 0x6;
-		cfg->highest_bank_bit = 15;
-	}
-
-	if (adreno_is_a610(gpu)) {
-		cfg->highest_bank_bit = 13;
-		cfg->ubwc_swizzle = 0x7;
-	}
-
-	if (adreno_is_a612(gpu))
-		cfg->highest_bank_bit = 14;
-
-	if (adreno_is_a618(gpu))
-		cfg->highest_bank_bit = 14;
-
-	if (adreno_is_a619(gpu))
-		/* TODO: Should be 14 but causes corruption at e.g. 1920x1200 on DP */
-		cfg->highest_bank_bit = 13;
-
-	if (adreno_is_a619_holi(gpu))
-		cfg->highest_bank_bit = 13;
-
-	if (adreno_is_a621(gpu))
-		cfg->highest_bank_bit = 13;
-
-	if (adreno_is_a623(gpu))
-		cfg->highest_bank_bit = 16;
-
-	if (adreno_is_a650(gpu) ||
-	    adreno_is_a660(gpu) ||
-	    adreno_is_a690(gpu) ||
-	    adreno_is_a730(gpu) ||
-	    adreno_is_a740_family(gpu)) {
-		/* TODO: get ddr type from bootloader and use 15 for LPDDR4 */
-		cfg->highest_bank_bit = 16;
-	}
-
-	if (adreno_is_a663(gpu)) {
-		cfg->highest_bank_bit = 13;
-		cfg->ubwc_swizzle = 0x4;
-	}
-
-	if (adreno_is_7c3(gpu))
-		cfg->highest_bank_bit = 14;
-
-	if (adreno_is_a702(gpu))
-		cfg->highest_bank_bit = 14;
-
-	if (cfg->highest_bank_bit != common_cfg->highest_bank_bit)
-		DRM_WARN_ONCE("Inconclusive highest_bank_bit value: %u (GPU) vs %u (UBWC_CFG)\n",
-			      cfg->highest_bank_bit, common_cfg->highest_bank_bit);
-
-	if (cfg->ubwc_swizzle != common_cfg->ubwc_swizzle)
-		DRM_WARN_ONCE("Inconclusive ubwc_swizzle value: %u (GPU) vs %u (UBWC_CFG)\n",
-			      cfg->ubwc_swizzle, common_cfg->ubwc_swizzle);
-
-	gpu->ubwc_config = &gpu->_ubwc_config;
-
-	return 0;
-}
-
 static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -2701,10 +2625,10 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
 				  adreno_gpu->funcs->mmu_fault_handler);
 
-	ret = a6xx_calc_ubwc_config(adreno_gpu);
-	if (ret) {
+	adreno_gpu->ubwc_config = qcom_ubwc_config_get_data();
+	if (IS_ERR(adreno_gpu->ubwc_config)) {
 		a6xx_destroy(&(a6xx_gpu->base.base));
-		return ERR_PTR(ret);
+		return ERR_CAST(adreno_gpu->ubwc_config);
 	}
 
 	/* Set up the preemption specific bits and pieces for each ringbuffer */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index ec643b84646b..324319762383 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -236,12 +236,7 @@ struct adreno_gpu {
 	/* firmware: */
 	const struct firmware *fw[ADRENO_FW_MAX];
 
-	/*
-	 * The migration to the central UBWC config db is still in flight - keep
-	 * a copy containing some local fixups until that's done.
-	 */
 	const struct qcom_ubwc_cfg_data *ubwc_config;
-	struct qcom_ubwc_cfg_data _ubwc_config;
 
 	/*
 	 * Register offsets are different between some GPUs.

-- 
2.47.3

