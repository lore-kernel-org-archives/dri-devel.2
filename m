Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E20B6F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50AB210E3EB;
	Mon, 23 Mar 2026 20:13:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R5JcowfY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Aq9ZTsyo";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A815D10E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:31 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHr8WQ618876
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i/EFVjmIq4o0XB7IqAunb20T4qbIQzoB4f8t5D0bKME=; b=R5JcowfYpShE6HKi
 ZZtR1afU1moPbs6WD1t9iUwFQRgLbARvEKpBPk/qiTNEqARgCK12/Z7u+nK4LRpq
 +YfE/PVdhkZ8X+lFKL4JJb18cSQL3la56GGS4TiS1bCl6L7oUKZoNt3AgrTJyzu/
 /jCCU5a+7x7AKKjKGGcR0D2gCcP88G/WeJzya8VOlSmFk3UWsNh/4pDsPaQUYsw4
 xkrg2sGcmZ8/S/wfiOUQrQn90C3B7kpFgEwXZD/iuILIL+C7yMjIr4XsPQdbmRSW
 cUfx1Lu3uWHCatPXwmMnPKzVnkq2mpFd28aWa9ydl5vSokCNPf4o5sF2U0gJ7NFw
 H6n7ew==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jgjkgp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:31 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c38b85ca2so1494380b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296810; x=1774901610;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=i/EFVjmIq4o0XB7IqAunb20T4qbIQzoB4f8t5D0bKME=;
 b=Aq9ZTsyoIOLtnZ25UdHA1tlUqAZgl2izDHJ4jJrOdJp3MaoajvBbMUj6mIKwaTC95D
 FSY4xMl+bY4ZnERuAFSG0Js0xE0CndhX8sjsUv8rPWHmVeHXNjhc06P5Rqw2k5BzNIQ+
 cijyECE/Lg7UaQu/wBp5qR0zEPyTVAtu6F5U3aVMq0tW0earq8xJqhgrbyuypyRxpXvA
 WutQQTk+DXZUB+XBLlWGGvZKqPR2bmRwrueVdNidl8x/HYZQ32vI4lFrzD+Bsnvi3LxF
 byXh6A6zwE1/fNMw+KwL3IwQAHh8EbtB/cuqvbUl4kbRzHzk2wCedxTglzsrPnPm/9B1
 c8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296810; x=1774901610;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=i/EFVjmIq4o0XB7IqAunb20T4qbIQzoB4f8t5D0bKME=;
 b=e6GODJJsZlKhpMY2cdY6i20Hosr+7EIcnn252ESorVLKf6KQthVKKXFfVF8v+LjV7E
 JIOvBi2ssjHwL9Y2AsDT9lXD9QX3Gv9GfD8zL6dWLBLvMkHH2YVwOX2ukBaMLFPfWIn1
 7UIKZ12uslY8EVc8KBPFo3fe/FcRw+GE3iky2wM+qO/95WQfZog3zpu74ed3HXCgMrV6
 Ku0O4qhB4aJ4CgVWNHvWHutsY/HTQPqi+4vxT0a6eG8UIymG71+KAWZNuUOQPymLxbpx
 FjL0of2/KhXEDGUthQQBoP931+ZNZjNEs2wjY1s3a4JnFp1mjhk7OukYi7W9oKNUlXmb
 iNRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4oXU5zuBA0mg1FJIjY4egT870M/q/Du7E8D04YnEODoxh/G+QDH0c/37hj8xZgmiW+EmrVLTTi3E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyVE6YCSGKgBEaoL+bL1ukCNLiV3ZJ/1NXrdnFBSluR0lEIYWPg
 pcaFIfp2HN0z7z9V1GdnS5rSnpkhNPHEs8qRunyMbzwJUp7/CPoPV36ISTIxui49QabEo0E++Zj
 NrzqViS3dGMs85m0vsRf/JPpOufDioelJ5c0cnR3dH1utTZ6++YToJmeQ3v51Lpg5q0A5dHY=
X-Gm-Gg: ATEYQzz9JisAkpj9o5/JpJwbXuCwn1Aoky+xDYCrQNheoBYdaa7QfIirrVruON4GBJI
 9OLsY9TZc5AQNdE6PEBB3NCG+qQxdC+sya7XILbFlh2Z/BLOR/kB9Mrhp9b2xNKgTrWhz2Y//iX
 V8AUqMRdLUo7jgrnJSn3VkGX6ef70p3UihFHnD0sQP2dHbuJIm4vn9MviRCGfzWzSSUFa/eSEla
 JivIAErSKV+U50c5haSWcsk1PMzwgKPP3my/6lnXq9ycfYdkZBYFvjpHWnVdW6h6ppWY+i/qPn7
 Xt4G3q/hTvi2NfftPq/zhU0cdNO701cA9ovJKFi575lHZR1Z6owvXvMSI502szYe92mdmPKPKBF
 ZJfBczVN0+i3eHTRZzVYrpwNAofVFLatrsP25ObTSeMG9Hg==
X-Received: by 2002:a05:6a00:1707:b0:82a:8163:4bfe with SMTP id
 d2e1a72fcca58-82a8c38da93mr10575879b3a.60.1774296810393; 
 Mon, 23 Mar 2026 13:13:30 -0700 (PDT)
X-Received: by 2002:a05:6a00:1707:b0:82a:8163:4bfe with SMTP id
 d2e1a72fcca58-82a8c38da93mr10575852b3a.60.1774296809650; 
 Mon, 23 Mar 2026 13:13:29 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:21 +0530
Subject: [PATCH 09/16] drm/msm/adreno: Implement gx_is_on() for A8x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-9-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=6497;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=2QHtgMqo3TglD7zXCiFywppEZUI75kRalKuvSCgmedA=;
 b=hquaopb4yfbmflNYOXExPzWdFx7cZL5F60eeWJy+fD6AopfspxA3QntDU/q/URSv5NPSWGMeF
 unE3v63PjiyDlPBks60CG219KYKk5i9OBmXmHMwdsjkpfZ3BiPXeHgD
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: IwRCsKIMunRTg7LIzlLhrrXAC52v4DHg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfXzan5jHWQ3w5j
 BmbIWpw9+gHH9Gg2zNaL5bPkJOG4GQlZz5EdlkSwEfq51CWQcQB3Lpm24dW3xc7G7JPCEd7ksgc
 SEDhA2xf5JBcjWWbCBa5HP1VJdByK7xJxZiXkat6BtW+eC8WWChNRxw3PY0E4pwi3pk/BXXmzwx
 m+mQgJDXYEaPwj68x56LqnoflB/TovpACKz84aH2YSLVzJVqOaThi4KxYmuLxKMarRG2qiIJ7AJ
 s8e48Q1SFh8hTsN8puEFJvrkGjGcW54B8vwwNrhmr9AIJs5P8xqDsERknxGod3HDreZQfKn+Znp
 sbqasfx6V6xHLklt19X2OoZa4R4GJUSP/OJaHR02yjsJOqUahu2Kw7QDFjhUS0PvyQUFIMq00GL
 Iew3bLaTtAcYPgOG6dOPD6Ha79QtiEdOEIev1vndO7Bhh2FSnJMtwMMg0CrvlbU/Mx+DzBMJw8x
 fNwDPU9JEd3Q5L48rJg==
X-Authority-Analysis: v=2.4 cv=CMInnBrD c=1 sm=1 tr=0 ts=69c19eeb cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=wYauUFJWvglRPmXws0gA:9 a=QEXdDO2ut3YA:10
 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: IwRCsKIMunRTg7LIzlLhrrXAC52v4DHg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230149
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

A8x has a diverged enough for a separate implementation of gx_is_on()
check. Add that and move them to the adreno func table.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c       | 25 +++++++++++++++++++++----
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h       |  4 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  6 +++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  4 ++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  1 +
 5 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 6d511dc54e43..cd6609bb66fe 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -91,10 +91,10 @@ bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu)
 }
 
 /* Check to see if the GX rail is still powered */
-bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
+bool a6xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu)
 {
-	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
-	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 val;
 
 	/* This can be called from gpu state code so make sure GMU is valid */
@@ -117,6 +117,23 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 		A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
 }
 
+bool a8xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu)
+{
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	u32 val;
+
+	/* This can be called from gpu state code so make sure GMU is valid */
+	if (!gmu->initialized)
+		return false;
+
+	val = gmu_read(gmu, REG_A8XX_GMU_PWR_CLK_STATUS);
+
+	return !(val &
+		(A8XX_GMU_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
+		 A8XX_GMU_PWR_CLK_STATUS_GX_HM_CLK_OFF));
+}
+
 void a6xx_gmu_set_freq(struct msm_gpu *gpu, struct dev_pm_opp *opp,
 		       bool suspended)
 {
@@ -240,7 +257,7 @@ static bool a6xx_gmu_check_idle_level(struct a6xx_gmu *gmu)
 
 	if (val == local) {
 		if (gmu->idle_level != GMU_IDLE_STATE_IFPC ||
-			!a6xx_gmu_gx_is_on(gmu))
+			!adreno_gpu->funcs->gx_is_on(adreno_gpu))
 			return true;
 	}
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index dd0614b19aac..9a5464fa6a07 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -10,6 +10,7 @@
 #include <linux/notifier.h>
 #include <linux/soc/qcom/qcom_aoss.h>
 #include "msm_drv.h"
+#include "adreno_gpu.h"
 #include "a6xx_hfi.h"
 
 struct a6xx_gmu_bo {
@@ -231,7 +232,8 @@ void a6xx_hfi_stop(struct a6xx_gmu *gmu);
 int a6xx_hfi_send_prep_slumber(struct a6xx_gmu *gmu);
 int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, u32 perf_index, u32 bw_index);
 
-bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
+bool a6xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
+bool a8xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
 void a6xx_sptprac_disable(struct a6xx_gmu *gmu);
 int a6xx_sptprac_enable(struct a6xx_gmu *gmu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 897522778fd4..cdecd91094c6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1641,7 +1641,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	adreno_dump_info(gpu);
 
-	if (a6xx_gmu_gx_is_on(&a6xx_gpu->gmu)) {
+	if (adreno_gpu->funcs->gx_is_on(adreno_gpu)) {
 		/* Sometimes crashstate capture is skipped, so SQE should be halted here again */
 		gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
 
@@ -2768,6 +2768,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a6xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
@@ -2800,6 +2801,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 	.get_timestamp = a6xx_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a6xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a7xx_gpu_funcs = {
@@ -2834,6 +2836,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a6xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a8xx_gpu_funcs = {
@@ -2861,4 +2864,5 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 	.get_timestamp = a8xx_gmu_get_timestamp,
 	.bus_halt = a8xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a8xx_fault_handler,
+	.gx_is_on = a8xx_gmu_gx_is_on,
 };
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 018c164ad980..c0b9661131e8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1251,7 +1251,7 @@ static void a6xx_get_gmu_registers(struct msm_gpu *gpu,
 		_a6xx_get_gmu_registers(gpu, a6xx_state, &a6xx_gpucc_reg,
 			&a6xx_state->gmu_registers[2], false);
 
-	if (!a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
+	if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
 		return;
 
 	/* Set the fence to ALLOW mode so we can access the registers */
@@ -1608,7 +1608,7 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	}
 
 	/* If GX isn't on the rest of the data isn't going to be accessible */
-	if (!a6xx_gmu_gx_is_on(&a6xx_gpu->gmu))
+	if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
 		return &a6xx_state->base;
 
 	/* Halt SQE first */
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index c08725ed54c4..29097e6b4253 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -82,6 +82,7 @@ struct adreno_gpu_funcs {
 	u64 (*get_timestamp)(struct msm_gpu *gpu);
 	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
 	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
+	bool (*gx_is_on)(struct adreno_gpu *adreno_gpu);
 };
 
 struct adreno_reglist {

-- 
2.51.0

