Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674B0606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 18:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=O2Viqlx6;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X+kf4YYL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29BFB10F73B;
	Tue,  3 Nov 2026 18:47:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF18810F73B
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 18:47:46 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A3IZ0Yw3675764
 for <dri-devel@lists.freedesktop.org>; Tue, 3 Nov 2026 18:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=98+efzo09kb
 w5iIRTLbRGy1+7tpqmLMHl/q8KP/fTh4=; b=O2Viqlx6q4On4YuXRVWsryI9EJe
 IvPAz/YkxmJulHIXQteQjRgQryHQEz4qZAHNNggYKR3a57Pr7jg5mqiY89lfVP9j
 jnVpXz3agPKxHyBZ9WMOdCLvFXcyOuj65uBxTs7AJQxB110k1L9jGfeMY2ssOtpK
 RcFCjlkh0hJrSuyJSyokZWu+lr2bn+tA1JK3tl3nuB28AtToDNk7YFP5qLC7LBYK
 e4e+OME0TjqU0nZow7v6laLkrTltQ60YFN6T3JvKK2pSdqAswem+ADPw5Z4ZKm/u
 AeDA2KgDPkk/rer8ZXjnYLx3FaY9SkQT3Hw5LAuVz60zKytkDe3YO6Lw/jg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hqhyph4ng-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 18:47:45 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3b07b06027eso1428294a91.0
 for <dri-devel@lists.freedesktop.org>; Tue, 03 Nov 2026 10:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793731661; x=1794336461;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=98+efzo09kbw5iIRTLbRGy1+7tpqmLMHl/q8KP/fTh4=;
 b=X+kf4YYL0y7yPLHcB37SC8iVcDrCIJO5iX/pxoniN73qdalp8ZmSlcC7WCQwkPIKr1
 ml9nqnXlPA/lf4w5NpXzt03xePn81rWMNZOp1RfI888z9LItCM8gWawEDhicFcS6OQs/
 K+R1hriHgPp3ePrTAbDzm16AO2HYuRmKSBWbLDyh+zu0ZzarMrXEi3HnM1P4SHz/IgUk
 gtNGkza0zOOBho/tJqPWVCALcOC+EmP4V1UMDMBBEiBt/0Y+JKHjF4l6REuEStcFWfSg
 n82zIEunmTCYYG9xfMPfe9Xo4de/wvEHcDdqtvy0W+rhLmIf+nD/kFYUjCQsdA0hdXQe
 hTFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793731661; x=1794336461;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=98+efzo09kbw5iIRTLbRGy1+7tpqmLMHl/q8KP/fTh4=;
 b=tJzIoiLtc6Ziez2HS1YHdb2HkX5ThdbQefIAoPV8cgyOQdm6Je1A5D8Yli1uRSdeeX
 m8IRcH5W36DSfXfa1weKn3S6mIetJ5UNDjHYIHyPVEDKqWX5T4vExri1POyh+s74YTVs
 Ic3jUzv3tdiApUzzkTduQ6tdp6D7ia3w1kj+r3ZhvRobzCD7Ebwi5BOCc/7nqyt97p4C
 FTMNEM+vMqFhkjqgmp39Usc39Y6Ie4YbKNU6wuJAySfu0Sj+LrNCBIZpF90zon/RdHII
 J1cfV8J+bcj6V9S/sYDlXWc1DFSXePM8/CLn13NTu9PQUEkd/9yI5Nx+IcYQBVh3pGLF
 wl0Q==
X-Gm-Message-State: APuU4Z/+rPyaVvWzzeaPgGL3wNY2v1Cwo7eN3BYoUrH1yfDgWxR2r5uj
 6JfIW/JhZm26E7qBtpFv0CyXrLko1UEB8B9D48kKnU4789VYD0Sjn8j7SiMppSD1R4Ok01SIbyM
 HPm8XrcO8CjPZzzI2ge+EIME4FJ5k2xvODsXgaLRAlnjSkVakwYJPOwN5BET8LWVU8OC7qtMYiT
 KjkUtIoQ==
X-Gm-Gg: AYBFou0edq0VeALxV3EerGC/Xyax2zG7rs5tYXLRq2uD198mxTQPy2qncJRWRoPcWj4
 B4POaDqst9bBOPpE6ibHgPNUzOnOMB+QMOzkovZVK9O55H/wsnH7hfw9rqQ9X/dgQEA31VIm9PB
 DoigDs7cY8kbwTYkmcFFGclMTXhbQ0DEwJgmoYBlx9U2as0dR0GvdxPtrEjKuJfDfu1bDu6Cr+w
 2e1NaFjEpkWwAkjhj85x2CU5Fsofsqa6r4RH1eGFztxHtSnQVqXFVOoY3sX1SBTlKMK5ykcpl0F
 OcJYP+Q1gC5+djtWJr6UJdUxPmONv4XWE8mdHjija+GC+1QcDcQdi1gB/oNvQ81m59pPOqLiErd
 XUI/dY0EVdr9MhBJwHEUSDHwfYAHitxb9Ft2PF38nXdDJfJEAgkCR5f1tw4HuvZI0AZY6j+toBD
 rX170K7VENH5/1EIMOArFUQc8uvogAG2qdtXBb/ZC2u3R5kPVugBe7iqBjBek=
X-Received: by 2002:a17:90b:4f87:b0:3ae:5572:c4e2 with SMTP id
 98e67ed59e1d1-3ae897e5685mr11081716a91.57.1793731660556; 
 Tue, 03 Nov 2026 10:47:40 -0800 (PST)
X-Received: by 2002:a17:90b:4f87:b0:3ae:5572:c4e2 with SMTP id
 98e67ed59e1d1-3ae897e5685mr11081306a91.57.1793731647224; 
 Tue, 03 Nov 2026 10:47:27 -0800 (PST)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b07c896cc6sm5412361a91.9.2026.11.03.10.47.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 10:47:26 -0800 (PST)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] drm/msm: Rework IFPC disable
Date: Tue,  3 Nov 2026 10:47:07 -0800
Message-ID: <20261103184713.29664-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
References: <20261103184713.29664-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX+MezQPlSYF7I
 uDLYw/ZLbpdtNI2B8hLbdVnxpG84XVRbBTHx9Sng2NLKTTzxoM68v/+tbBVXD9S5a292I3EY9a6
 caZe30qbgIyN+68bWuovEYDtb2uOygE=
X-Proofpoint-ORIG-GUID: OK34YyyYSVbiL9EC0KeEiFXdtt-ISd_0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA3NCBTYWx0ZWRfX1wO+iIXGj/JT
 P74/y9kaeme3XiGWfJkndpuIXTXLs8Au0QjVjEbjSx9+IJ0SRSV3JYQLxmxfIU+kjUe5jqYFLuD
 b1X0VLlDbWCJ0/yAl2czWVJ81NhxAXITnLl3FoBihADYH48m5KXMaK8K8IiwwewSb/0DZU78Nqo
 zww2RuITw0ycg5CyNd84aiKPKWRASohztfEwyH3CzWkc7Ikae507n5/opZUITbAVMsC9kYvNLnz
 GtPUeiKXEhBsH/ePMu8+/uTUBJ/XAYzUqn0oeT0F+qdsxwY50LnV9MiC8VfUMpNPiqCO63zwExe
 U9BBCVn3hd1mzrf5wMei7uDvUxnBcrs0MxM2t0EcMcdNMCFgsy5xvqoCOIxyKXYwasU9yV6gEM6
 YrjcIgyaAKTyMd+NJb/XZcowh0GfgReXSqYlZasjgeZeVM0XGMKqKuqWMbutogeoJe5t85ULzs5
 0bmei9fYBt8J9/EzNjA==
X-Proofpoint-GUID: OK34YyyYSVbiL9EC0KeEiFXdtt-ISd_0
X-Authority-Analysis: v=2.4 cv=T94Z3PKQ c=1 sm=1 tr=0 ts=6aea2c51 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=0FW7IQkLa0pm2cqxDqMA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_04,2026-11-03_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030074
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Previously this was coupled to SYSPROF level, which made sense at the
time.  But there are other places that we need to inhibit IFPC.  So
decouple it from the sysprof refcount.

Now it has it's own refcount, so multiple threads can vote to inhibit
IFPC safely.  The renamed gpu->ifpc_update() simply applies the new
state by setting or clearing an OOB request.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c | 34 ++++++++++++++-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 11 ++++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  5 ++--
 drivers/gpu/drm/msm/msm_gpu.c         |  1 +
 drivers/gpu/drm/msm/msm_gpu.h         | 26 ++++++++++++++++----
 drivers/gpu/drm/msm/msm_perfcntr.c    |  6 ++---
 drivers/gpu/drm/msm/msm_submitqueue.c | 10 ++++----
 8 files changed, 57 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..28d93c60929c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2128,31 +2128,33 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 	return irq;
 }
 
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on)
+void a6xx_gmu_ifpc_update(struct msm_gpu *gpu)
 {
-	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu) || force_on;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 
-	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
-	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
-		return;
+	/* Caller must hold a runpm ref: */
+	drm_WARN_ON_ONCE(gpu->dev, pm_runtime_status_suspended(&gpu->pdev->dev));
 
-	mutex_lock(&gmu->lock);
+	guard(mutex)(&gpu->lock);
+	guard(mutex)(&gmu->lock);
+
+	bool ifpc_disable = refcount_read(&gpu->ifpc_disable) > 1;
 
 	/*
-	 * 'Perfcounter select' register values are lost during IFPC collapse. To avoid that,
-	 * use the currently unused perfcounter oob vote to block IFPC when sysprof is active
+	 * But the caller need-not ensure hw_init is done.  If we need_hw_init,
+	 * simply update the gmu->status mask, and hw_init() will re-apply the
+	 * OOB request when it is done.  This way we preserve the ordering of
+	 * OOB requests that the fw expects.
 	 */
-	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
-		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
-		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-
-	mutex_unlock(&gmu->lock);
-
-	pm_runtime_put(&gpu->pdev->dev);
+	if (ifpc_disable && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
+		if (!gpu->needs_hw_init)
+			a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
+	} else if (!ifpc_disable && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
+		if (!gpu->needs_hw_init)
+			a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
+	}
 }
 
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 09d76cdf059f..2a4f81d14400 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1565,10 +1565,9 @@ static int hw_init(struct msm_gpu *gpu)
 		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
 	}
 
-	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
+	/* re-apply IFPC-disable OOB request, if needed: */
+	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-		if (!ret)
-			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
 	}
 
 	return ret;
@@ -2851,7 +2850,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
@@ -2922,7 +2921,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
@@ -2953,7 +2952,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
-		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
 		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 81d21acccea1..cdb830b7b778 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -298,7 +298,7 @@ void a6xx_gmu_clear_oob(struct a6xx_gmu *gmu, enum a6xx_gmu_oob_state state);
 int a6xx_gmu_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 int a6xx_gmu_wrapper_init(struct a6xx_gpu *a6xx_gpu, struct device_node *node);
 void a6xx_gmu_remove(struct a6xx_gpu *a6xx_gpu);
-void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu, bool force_on);
+void a6xx_gmu_ifpc_update(struct msm_gpu *gpu);
 
 void a6xx_preempt_init(struct msm_gpu *gpu);
 void a6xx_preempt_hw_init(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e7d04c865968..ba8306e9eb44 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -846,10 +846,9 @@ static int hw_init(struct msm_gpu *gpu)
 	 */
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
-	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
+	/* re-apply IFPC-disable OOB request, if needed: */
+	if (!ret && test_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-		if (!ret)
-			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
 	}
 
 	return ret;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index fb07803f5aba..37f9e93daa43 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -1012,6 +1012,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->nr_rings = nr_rings;
 
 	refcount_set(&gpu->sysprof_active, 1);
+	refcount_set(&gpu->ifpc_disable, 1);
 
 	mutex_init(&gpu->perfcntr_lock);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb7a7..0334a0f604ac 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -93,7 +93,7 @@ struct msm_gpu_funcs {
 	 * for cmdstream that is buffered in this FIFO upstream of the CP fw.
 	 */
 	bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
-	void (*sysprof_setup)(struct msm_gpu *gpu, bool force_on);
+	void (*ifpc_update)(struct msm_gpu *gpu);
 
 	/* Configure perfcntr SELect regs: */
 	void (*perfcntr_configure)(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
@@ -186,6 +186,14 @@ struct msm_gpu {
 	 */
 	refcount_t sysprof_active;
 
+	/**
+	 * ifpc_disable:
+	 *
+	 * Count of votes to disable IFPC (1-based, values above 1 mean IFPC
+	 * is disabled).
+	 */
+	refcount_t ifpc_disable;
+
 	/**
 	 * lock:
 	 *
@@ -375,10 +383,20 @@ msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
 		(gpu->perfcntrs && READ_ONCE(gpu->perfcntrs->stream));
 }
 
-static inline bool
-msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
+static inline void
+msm_gpu_disable_ifpc_get(struct msm_gpu *gpu)
+{
+	refcount_inc(&gpu->ifpc_disable);
+	if (gpu->funcs->ifpc_update)
+		gpu->funcs->ifpc_update(gpu);
+}
+
+static inline void
+msm_gpu_disable_ifpc_put(struct msm_gpu *gpu)
 {
-	return refcount_read(&gpu->sysprof_active) > 1;
+	refcount_dec(&gpu->ifpc_disable);
+	if (gpu->funcs->ifpc_update)
+		gpu->funcs->ifpc_update(gpu);
 }
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
index ce65b1160955..867dd476ed88 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.c
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -259,8 +259,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Inhibit IFPC while accessing registers: */
-	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu, true);
+	msm_gpu_disable_ifpc_get(gpu);
 
 	if (gpu->funcs->perfcntr_flush)
 		gpu->funcs->perfcntr_flush(gpu);
@@ -297,8 +296,7 @@ sample_worker(struct kthread_work *work)
 	}
 
 	/* Re-enable IFPC: */
-	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu, false);
+	msm_gpu_disable_ifpc_put(gpu);
 
 	smp_store_release(&stream->fifo.head, head);
 	wake_up_all(&stream->poll_wq);
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index d307cdd17d90..8434a09319bc 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -24,7 +24,10 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 		pm_runtime_get_sync(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
+		/* Disable zapping perfcntrs on context switch: */
 		refcount_inc(&gpu->sysprof_active);
+		/* Disable IFPC: */
+		msm_gpu_disable_ifpc_get(gpu);
 		fallthrough;
 	case 0:
 		break;
@@ -36,16 +39,15 @@ int msm_context_set_sysprof(struct msm_context *ctx, struct msm_gpu *gpu, int sy
 		pm_runtime_put_autosuspend(&gpu->pdev->dev);
 		fallthrough;
 	case 1:
+		/* Drop our vote for inhibiting IFPC: */
+		msm_gpu_disable_ifpc_put(gpu);
+		/* Drop our vote for disabling perfcntr zapping: */
 		refcount_dec(&gpu->sysprof_active);
 		fallthrough;
 	case 0:
 		break;
 	}
 
-	/* Some gpu families require additional setup for sysprof */
-	if (gpu->funcs->sysprof_setup)
-		gpu->funcs->sysprof_setup(gpu, false);
-
 	ctx->sysprof = sysprof;
 
 	return 0;
-- 
2.56.0

