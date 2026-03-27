Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21F710AB82F
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:15:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3912710EB2B;
	Fri, 27 Mar 2026 00:15:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="c5MQ0Kuv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WtnjYjYq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D50310EB2B
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:04 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QMCiMv2583509
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I6qiQZAeAHkMfZaS5U+lM8ZNG+un35OXAMScVQwU+LI=; b=c5MQ0KuvwCOS3yC9
 pPUHgBSDQa8F/ATSZSEp+GZWsMBfzQ3Ob4NFGJN+sEoxvbTXE7r9cYKCqEZw2mNu
 ofYUxpVLEY8oWD2cFAlHdj9P1sB/Dj6rfeM8Xbb6MaFTghMwFZzybV7m0dnGiQt5
 nSGegGpjpWShBZZFcVwsLaCTUZXPYTjbgWQwC2FV/HNQoBi/FJhJDPmVIcXDNmpS
 QRiBV7tWbYOCHl6VCNdvF1KXPSzUkAmg9z8kzbDByj6lK+8F9IGP54ED1NFxuUqT
 LtKNt0lNVl/CFMEYHprOhxbOElDIci+QySZlp5sVSdwJkg0cQFS1xkPwkyDQnOX4
 33PeWA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d5dd6g92c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:15:03 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35641c14663so2045406a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570502; x=1775175302;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=I6qiQZAeAHkMfZaS5U+lM8ZNG+un35OXAMScVQwU+LI=;
 b=WtnjYjYqTbWsWEMK3Hu0MhDwsOJpRaaEmrNmUfadF5biJsF50+1WSpyF/QdnY3og96
 l0srFrWHjbXgTXS9Bq0cWbUS9gmTh5NtHIKcS0zOhd25nDFGSWJ7jcZCNMbfStr3uB7L
 bDsqlaJcOPMWnleG8S5QGbMpPJFBmQWldqrjGSon6/xjCuGd9dmVLD8Uzst2qUcw3uMo
 MwjnKTnHpwFPPwZHeeV/f7clx0L9VhTVz3mEH4G0sQl4PLUpYN4qHw87n/8VbRYHVJHR
 Y7G8RLvk7Qo3mow7dkBGy58tueNKC/hwmfYwxwgDs0R3p86wORsXr8TyJ5F737poTZPz
 BSDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570502; x=1775175302;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=I6qiQZAeAHkMfZaS5U+lM8ZNG+un35OXAMScVQwU+LI=;
 b=IX6MkYCOrKxiDr6sxIuy3f4Rt7xDslcbhaUdQUycR9UchbkN0+G/8nasDXBmV1AHPI
 +yiKamMDmGzl37tQEAy31rYVVnsjLWSFK/GA8Fqa+nq5NofwEVPqK5iRgNJ2veLPY+5b
 x/q5pstqtGoEigXJWAykFf4yomjhUpNv7MPG2laDyQ5y+u83ynUrZAT1Lv9tXB1XFuVK
 S9oEINGY1ARZBejr6uFIpvxKXebwkcEsYMwf8Tn+NR1wR6GK6x0prKV0zv81mNaDuXS+
 H89xq9LonE11W4nW3oIeiVoEIVr2ss4kCijETonoCwNPU5FnQDGw9FxNpghgQYyx78LM
 RJ+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUICBfh10xghw3XQFJubN4QtX0Y9vFbZztFRRfnHYxXZ8oD9fzVdaT8qBKYym7iVhDj0Ww6dUWKxj8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxcauogRUlbuSIHiYsMq2EwPIvSw00szZAzp31E31FC9rzUoP7n
 wc6W7fHML1tIH6cEHbM/8BHgA6C+h8bJIdb8jqHNsjARTsBb2bUOrb4Gwd+nbb0HJAlBkE2jmoJ
 dPUWscuaJhJgUXw8Sv06rwwQ9gKYYJzvNhrvRfm06AGAzLj+2rHaU1aJf64ryg1rNYVVckOc=
X-Gm-Gg: ATEYQzxyCPApF8+OaJAYB77WDPj8VP3vo8BsiZYQ92tNF8JlPqGjKuRYSJ5a+Hgm09K
 LIsh1PoN6HyOapGm0joOECA+QQjCirIMZIRQnrOh+OmMLQVKtzr1GQze+gRWx87Le6wkX8hbufW
 y1Y2h4J2XLS88QeylOI6IVrzWNyqk2YEFr2ycXA/MPnujxsyt8qhODEMrFL7v8WSaVtI1s7q4RE
 E7e12/YONSfgvy8z6oyiasn47cGpeQ8U66uZYCncQ+koTR9Yotnu3dmP7nCHzMSaWqOChTypfP+
 K34uNoFZ9UVxHiBbgZHY/Q1D8IavRAuPdWNvI65WUf/sjOI4D97VCMQ8NqHG9cJt9vaIrjKonaB
 Y3pFL5rxIJN9m+y5GuRa51Ex7vkTyb75udwmtbd0ypXNFCg==
X-Received: by 2002:a17:90b:2d92:b0:359:ff8a:ee47 with SMTP id
 98e67ed59e1d1-35c2ffa8018mr458309a91.6.1774570502047; 
 Thu, 26 Mar 2026 17:15:02 -0700 (PDT)
X-Received: by 2002:a17:90b:2d92:b0:359:ff8a:ee47 with SMTP id
 98e67ed59e1d1-35c2ffa8018mr458268a91.6.1774570501521; 
 Thu, 26 Mar 2026 17:15:01 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:15:01 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:54 +0530
Subject: [PATCH v2 05/17] drm/msm/adreno: Implement gx_is_on() for A8x
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-5-2b53c38d2101@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=7113;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=8MXC4uVCZYnSPq+0j/p0Zim3j2cYP4dyn83VnAxglXQ=;
 b=PLqC5LbjwsHG7PtWfu2tcdz27kHyPiJHa6XfLKmpSc9/EDHmEEtHg6g+ZpzdfwOtvay0sCtA1
 EFZR8DwsCAeABB4+uB3Mr6J6yBvPQejCkRL5fQlmM0xlskJ4Zd5cKBO
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=NenrFmD4 c=1 sm=1 tr=0 ts=69c5cc07 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=wYauUFJWvglRPmXws0gA:9 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: nt32dDtlb-LPcmGTAmVq8Pde9IDsqQBf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX21mSpOf6NMk0
 vh/PdLyRzJ8Bi+J3NckkFnYDUlCA44F/SRHILjX9w8nw2F43o1DMll4/I9VoZG2sucR1ssPvx25
 o8QcSTYyy3GqQC3anMOjNFcb/mD6XmYI/6KId3rtcTAZesZQfL0rhtyMNT17izVUskkJD4bkYtZ
 AlrwurBS956bUMCxL2XB70Sn5gT8/F4Y19W65/nJxe07SLnBplhDwc9t0Ze6vGCvEC+Ta3OcyGL
 +cy5qTlqxKpPweqgikcMhaVVMts3+b5Lahoi5kWELQCtEHhCfQ6fzkmlfQ9SIim75yvv+ouOpKs
 PF+Ce0quMlGclmLqS9J1nqJq60ejQBooI0I7spjaZ5v1NBNewnBrtwz7xS5T9rfmjo6Du3ruK74
 Eblb6HeCjZ5vKBgJNR2+GovEdN7iOe+GGNrNa1H4QY8x2CAigT6dCEY0QZwLyX9RTyK5R6q1gVd
 HUSmypiXbl+ZehDMRKQ==
X-Proofpoint-ORIG-GUID: nt32dDtlb-LPcmGTAmVq8Pde9IDsqQBf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c       | 42 ++++++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.h       |  5 +++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  6 ++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c |  4 +--
 drivers/gpu/drm/msm/adreno/adreno_gpu.h     |  1 +
 5 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 690d3e53e273..b41dbca1ebc6 100644
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
@@ -117,6 +117,40 @@ bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu)
 		A6XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
 }
 
+bool a7xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu)
+{
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
+	u32 val;
+
+	/* This can be called from gpu state code so make sure GMU is valid */
+	if (!gmu->initialized)
+		return false;
+
+	val = gmu_read(gmu, REG_A6XX_GMU_SPTPRAC_PWR_CLK_STATUS);
+
+	return !(val &
+		(A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_GDSC_POWER_OFF |
+		A7XX_GMU_SPTPRAC_PWR_CLK_STATUS_GX_HM_CLK_OFF));
+}
+
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
@@ -240,7 +274,7 @@ static bool a6xx_gmu_check_idle_level(struct a6xx_gmu *gmu)
 
 	if (val == local) {
 		if (gmu->idle_level != GMU_IDLE_STATE_IFPC ||
-			!a6xx_gmu_gx_is_on(gmu))
+			!adreno_gpu->funcs->gx_is_on(adreno_gpu))
 			return true;
 	}
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
index 2af074c8e8cf..9f09daf45ab2 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.h
@@ -10,6 +10,7 @@
 #include <linux/notifier.h>
 #include <linux/soc/qcom/qcom_aoss.h>
 #include "msm_drv.h"
+#include "adreno_gpu.h"
 #include "a6xx_hfi.h"
 
 struct a6xx_gmu_bo {
@@ -231,7 +232,9 @@ void a6xx_hfi_stop(struct a6xx_gmu *gmu);
 int a6xx_hfi_send_prep_slumber(struct a6xx_gmu *gmu);
 int a6xx_hfi_set_freq(struct a6xx_gmu *gmu, u32 perf_index, u32 bw_index);
 
-bool a6xx_gmu_gx_is_on(struct a6xx_gmu *gmu);
+bool a6xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
+bool a7xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
+bool a8xx_gmu_gx_is_on(struct adreno_gpu *adreno_gpu);
 bool a6xx_gmu_sptprac_is_on(struct a6xx_gmu *gmu);
 void a6xx_sptprac_disable(struct a6xx_gmu *gmu);
 int a6xx_sptprac_enable(struct a6xx_gmu *gmu);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index f4b7fc28b677..8718919c7e19 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1643,7 +1643,7 @@ static void a6xx_recover(struct msm_gpu *gpu)
 
 	adreno_dump_info(gpu);
 
-	if (a6xx_gmu_gx_is_on(&a6xx_gpu->gmu)) {
+	if (adreno_gpu->funcs->gx_is_on(adreno_gpu)) {
 		/* Sometimes crashstate capture is skipped, so SQE should be halted here again */
 		gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 3);
 
@@ -2762,6 +2762,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a6xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
@@ -2794,6 +2795,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 	.get_timestamp = a6xx_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a6xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a7xx_gpu_funcs = {
@@ -2828,6 +2830,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 	.get_timestamp = a6xx_gmu_get_timestamp,
 	.bus_halt = a6xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a6xx_fault_handler,
+	.gx_is_on = a7xx_gmu_gx_is_on,
 };
 
 const struct adreno_gpu_funcs a8xx_gpu_funcs = {
@@ -2855,4 +2858,5 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 	.get_timestamp = a8xx_gmu_get_timestamp,
 	.bus_halt = a8xx_bus_clear_pending_transactions,
 	.mmu_fault_handler = a8xx_fault_handler,
+	.gx_is_on = a8xx_gmu_gx_is_on,
 };
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index d2d6b2fd3cba..7bec4e509d2c 100644
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

