Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1ABECD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:51:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05E9810F0A5;
	Wed, 20 May 2026 14:51:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="o4xMXNAy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C83ywfuQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0166810F0A7
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:31 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6TAx118986
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Djk2zkStwaWZHr0e4GFbsUt4SMVtvVziVb4lu5RPX68=; b=o4xMXNAyRg0UAL2c
 JG79nbqqiWoxdFdV8PS8egzELwuuFJXb8Jb3jcQNQHFocYYxkPGRjuDK7o7Tjr0+
 AEpwYe2ZNPuiACAJFgxuRSk27S8CXLcZvUsceK5qEQm29hwjdhHY7ULsx20dLeCW
 OZ5RTMnochYAwmTzLHBnlLOL3mNDlHmODDTO16kJ2qMvg4dqRcP+uZdwS9mede/4
 dEoOQPDdt9L9BgJrHhDY4wq6Cn+qcjY+lvPps0ZbKFbrmiLM11zbeoKOuBfLgc41
 6/VcIvD3AdyMyYJei8QrpTYW28LFkpEivvoqM3VwqSjUITxCYgkvQwAp8H5Y3fX8
 YeVgnw==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee886dp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:51:31 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-6343bea7909so1924004137.0
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779288690; x=1779893490;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Djk2zkStwaWZHr0e4GFbsUt4SMVtvVziVb4lu5RPX68=;
 b=C83ywfuQMyPnZiPBsr68vUOYhmW7TtY1v+yimZw5xRP3HvZYCrGFB/6UJY5BZLgoWb
 OImQYnmnpILjpYWkERUqG+XFxza1AcIULOr1bFP+B318NkFEztoK3q1W6Xaq95bwUj86
 qEuMQT9rUPMEQb4UPKFOCR0RFwnFxYjEKtwVrbptX9fNVbO/IecwlfmLJJILqJu2LC7Z
 3GaFmELVA64SrReFR8ZjACcgbXL4wkeSndSFo3q4qb3h12soYStA7F0rVX9HojIEb1Rv
 VbgJj+tAuT411alomyJeZHy7uB4CwBv3RuH9CiuQGO+HpGTYMtleu4NXEHxyum9BGqx5
 SusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779288690; x=1779893490;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Djk2zkStwaWZHr0e4GFbsUt4SMVtvVziVb4lu5RPX68=;
 b=LWz4luDLamQPhGMAwScc+6TByIgn2xjRqfGEdhysYRTv1k661t63qs/t/3TfB3LUJr
 MIToTfrBR0nGzNS0DwHNQhyU67WF1/qelgUsJtHeChMus1q2frpznmdlQUDd0PqKyY5v
 MvUeWJyHpn0vvjbFH+qKkrN1MzwHCTsuMa1AMxNwSTZwsqYUmzksbizd306blrqQUo6w
 AdCKgWjY56Zag0qwZFQfoSBoyS7yWQNj1IKB73Pn/YROicIwrWB2j7JMdEvEiH4yHQD2
 q9dtXSOgXNtQBkpxAOG7Ay4IOseapZcL9G8SAFe9puamyUcya9cjsDomqR9+8i4aBwtL
 ZE5g==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+DyKswAywYyUHuEfKGXyxMGnbGgz0iuEJJacUSx7rVJ/5VpTYNRS4IB2ae7d0VhyXg3h8Y7J3zxc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCmgOWhf/+as8MyKMrU4Aey/npkUmGuRei7hdTZBGYBX1GJ+3I
 hNNF4lJAjSnj3Hi5YPOQd7Ba29YwTx0pEtrxX8l5c1H9sgISvNFijJctb3Au3PTRxaxN1NzuUZz
 XQW9vpAF++4UfRDkh+MiLncBTysnUJriQx2QG+kzTTgz/G45y+Ohookou+//4prk3AVNHHNs=
X-Gm-Gg: Acq92OH02LRPBQbFjFYR2tTu2rjz9+PZjfTAkstK2by8zr+zar7FEERSG5eg9oNeS1Q
 oLvVMZGmtZR3ubXrEIzxPwGfT5qn9osLzFRemvdZnLTk4D3VdU4UpMvLZjCe/L/6oP85tkUlxWC
 AXCRwHQObblJ9mg119AKGDVHoYbQmqY1bgyEelbO/3S6ZZulq0mtbxFkwXiAxTiLoomubgE8Tga
 /Bj92/06Lux6aa2wMpXe+m0MEs/idbqxXRxl0sYDPdGi3fUX3Y6bvDckI4atUXnD2jCySlZ5mYS
 0zO05oczBHZwNrJ8KttFbYl8L9jLqOnzYFDGIgSzEyf2ZtGY5OJ3lOSImzmTi16Kl3OmQAT7WG5
 jF/6/FYPaBrlAkrdzNJ7OkLp9S+p/Hgkf10xda42PmtmS98r3TJ7aaDB1JlfIO3c7/+EXJ/YWV3
 a1na1oudxU+aEDDQoRpg0oFhW/A4zLM3900p8=
X-Received: by 2002:a05:6102:4b14:b0:602:a9f3:74d8 with SMTP id
 ada2fe7eead31-63a3f9980dcmr11919384137.25.1779288690433; 
 Wed, 20 May 2026 07:51:30 -0700 (PDT)
X-Received: by 2002:a05:6102:4b14:b0:602:a9f3:74d8 with SMTP id
 ada2fe7eead31-63a3f9980dcmr11919340137.25.1779288689885; 
 Wed, 20 May 2026 07:51:29 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a90f10c78csm5128907e87.14.2026.05.20.07.51.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 07:51:28 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 20 May 2026 17:51:11 +0300
Subject: [PATCH v5 04/28] drm/msm/adreno: Trust the SSoT UBWC config
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-ubwc-rework-v5-4-72f2749bc807@oss.qualcomm.com>
References: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
In-Reply-To: <20260520-ubwc-rework-v5-0-72f2749bc807@oss.qualcomm.com>
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5936;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=v3UCol6mfqB5clR/DI5HzrndmV9Fvkwgup9nT+3uePc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqDcpmcLmb1eTiMXqdlk7HOL2ywGiNyaADZQB1d
 bOd8qORDTiJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCag3KZgAKCRCLPIo+Aiko
 1bWbB/9ljxlAsqB63oP1geucWwRblpeTznE0EEUs7ZYNHv2c9V2hMnIOyatoxgNm2Uy7PyzC9yC
 7fCb9Q9+JiCtCi16OzeCcJU9Th/vV1IWUeTjWxPU0579QSeF5rNSU7SA6DsAfpGdDEzTOd/aG8f
 tSF9w9yhybsILaKwXed3NopqALRzxQEExfkIO/Cs0tviU56xqBFGJ8jz3RiLCAmrpglE4TYyFah
 CT1XQ/c2vDpqG2Bdnb1AcHm+HRCJwPmDwpVM7rlt/HWeXWJVSvJO1sWWpbvZWkcV7b+kJ2JUTZ3
 SgZQlmBBYCetsfkVEnROC59AE260LENTA9NCEHmfXVJ6iEpF
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: EehhMqu8wt2ZiNhW2q9ClPclqhb6BIYW
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0dca73 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=IhcC-CrlSmvFA89tYH4A:9 a=QEXdDO2ut3YA:10 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE0NCBTYWx0ZWRfX9PPr2ay5SqSc
 ZC4KMiuhBq4Ei7NhIHxrRw/EefOzJIGbEPyCo+448uaG624/nOYlpAjZtZar4DtSL1YFehjTiNv
 DKeS5BV4KKG5lXulNYBoYAU4zXKcm77QQ/AtN6bJ0BHK2eN2mpuL6MMWwYuFmcM4jZRXMeEKsiR
 4mWr3c3UlE52MrbTxclIHJuyBxg3zzmKfNSJ/4ub2hDa4+XfC+m9TjaCW7kO6dJBZa92evYA22t
 muKZDq4gmCk7ASm2z0zIbpjU3qOJw5vKzTcf5c3TLUOzn/V9dKyIZrDhsJNYvwrCE5TONq5Z2Mj
 5hQoGWqkStouBlyfRBKB8s6+O0n9J2fLoetXnLW2SntB4Paxn96wjQFQBgIl6kfmHXVdaeFDlhZ
 AYyxHpfQooT5q0b3RMHJxhJnIZucSAbGX8ckgNYTJC91zj6x2RT0hCXvV5gIfFss7SzkXC902vC
 pg9i3bOIRbZonzOKZ8Q==
X-Proofpoint-GUID: EehhMqu8wt2ZiNhW2q9ClPclqhb6BIYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_02,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200144
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
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
index 7a3e3c2f5cf3..90e814c64c6e 100644
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
@@ -2700,10 +2624,10 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
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

