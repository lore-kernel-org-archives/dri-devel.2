Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC05FCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25AE110EE50;
	Wed,  6 May 2026 17:12:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="In1xrwij";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FD+7qCYA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538E110EE4A
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:12:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646DVAWp1527753
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Tj+4RQOx8Hh
 IQqlvFHx13oj7kr9BKUs7jNTjZUXWM+M=; b=In1xrwij0vcHLFzpYoA3OMmh7Jp
 aawq0ks/4Sh0iPx8b6z1nPNua5KTtAm9J2Pm95lVYOqhnBJ0ryF3oE86v9XO/i6o
 9PLVbXr19XBbD66PPTsR+S4gLefXzi/WvDxWYic4ahbryrAazbuXM5IC7gMUvd3/
 Fzw3RJEL+Vb5n3B3KDmxY5/q16pc5Pz0sQebqb0E2cKZdg3mcp3ttPE4aEOrmHd/
 kZpCnA4SYmpj9CxC0gi4sV23hbA07nN+w8wVmx/yGPRyzzCPIerssKV3DXjemAAR
 lmrUg5wBhi3dbYhK3MZxcyyNoft8pijHB1rvTXgNPp7aDezIcZOtB9peQqg==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0128aaxe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:12:01 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f6a5b4f88so8592731b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087520; x=1778692320;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tj+4RQOx8HhIQqlvFHx13oj7kr9BKUs7jNTjZUXWM+M=;
 b=FD+7qCYAy1whYEgKtUt8IlZWgXwnqdpd7RmK3xb2JxGlJ3UmtKFr5d1i2mhOSCatcs
 Tw+Q+NnoH1DxKayjAJ5Hv5obly8lqHBT8X6TpjKCTgWgK/9O9wZM1YfdcJSJqstu5cV+
 euVLoDXffukPmwmiINQWaMPLzFjQq7zskNMpT5korS1qBUrp855levdOl5j6OYDy6/jI
 4qmwTjU/xdCBW1S6AhcF2Q3mk4VDG547mSwOiw/QyrdkLW0RjOK3yNl0aJ3gM5mg+8nn
 tFxol0wuLeIqVFf9IGZTTZHS1vFDKPySfMpQPkHwJYk7F9QUcNeFUdJwuTGkad9eCM6N
 QAGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087520; x=1778692320;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tj+4RQOx8HhIQqlvFHx13oj7kr9BKUs7jNTjZUXWM+M=;
 b=hoSHKjX3rr88APbYuLZVmQ4LmrNVgW77LmoKLk16wqxNHrAM4XfLFwEFWEWMY0z9k5
 s6Ej2iG/uxk4pgz6n0u/k62R5CRPa3Nuxu9lYmxo4t4eJ2FYaID/rMZmaF4SrDdQxSww
 P8RkNdxslcnHkh/yfJqJ2tmRuwu8OxMJSVnx3l3CIx/gQhT28A4Q+XHAxrC177chFBG+
 KQ0yr/MJVmcjstK/y2IlWKPMjSW2aT08Ry67whohbyUngWiABjjkWvhZSaUD9vWVLnQx
 D0SFDWFyu9n/OsNjz98bAUDpdcgR5sSQBtNYWDLsoH1Esdzr9YMIostNNKKJlR3ZKn9m
 bW1w==
X-Gm-Message-State: AOJu0Yxr4QWOuHCADI0lirSzrH7QL1xOoGpLpMUy6ySrSQrb7u6CelnQ
 iQmWvOy+R5mi6ctRQgZfXUjWdIa0SoqgY5Zi+Czdyq5HCr8PUnJcZYLWFf6A8wMcfrKf52cY9bz
 zx5Lit2AObTE5ZA/iPKEWjfNyBicLZtKmUnSV1bVUth0PIEn093aZhBIBEM1HxHQ+SaZhcHRn2Y
 vyuaE=
X-Gm-Gg: AeBDietcvhEccQnCZJTwpuLZ8dz4rtQ/fuSrUzHicBlGITHGQTypi+02fG2rahBzNmI
 u2sfMq7TpWHOKWDUCXZK/uI7sdpY8jNHm7CINRrun8IrRJllbrhtiWyRexS9r79uAwwYGcxtq3w
 E6fS9I9uReUrTEHMeOLzFDZMV639z5u+L3EwS/w8bWlHKDs0StIsBQGQMkh5bbrabQkJiiaYz8l
 cGenN5KUImD0XXKjWbgS7al/ePgTYLBkUaWHx8gPwyefM3k2LvPLy032d0PBalg5X6P/K5MxwIq
 cR9G+k5ETYn11AjNNZLRoLfr2Z+agi8d3C8XkEt1wHHO1vq9/wc1Mif3on5XVJs7BSU9XOb698e
 +WjdevTye6s/uHN5K0g6f+QTxfK15BkGyGhveaP0kBGprU+rkzKTgWA==
X-Received: by 2002:a05:6a00:a84:b0:838:ff63:2fe2 with SMTP id
 d2e1a72fcca58-83a5bada1c2mr4355277b3a.5.1778087520006; 
 Wed, 06 May 2026 10:12:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:a84:b0:838:ff63:2fe2 with SMTP id
 d2e1a72fcca58-83a5bada1c2mr4355221b3a.5.1778087519343; 
 Wed, 06 May 2026 10:11:59 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-839679c8c00sm5604070b3a.32.2026.05.06.10.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:11:58 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 07/16] drm/msm: Add sysprof accessors
Date: Wed,  6 May 2026 10:10:31 -0700
Message-ID: <20260506171127.133572-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: fymK3StoABsVt1dzuHbcFIPh63JlXWyC
X-Proofpoint-ORIG-GUID: fymK3StoABsVt1dzuHbcFIPh63JlXWyC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfX8AgwEdUP13N8
 llK2nGOO4zVwAiFMBbP8kXfxAxHw1fZ9kZ3Yp+KSQ3ZK9sCHJhcglx2U0mXTrxZgKeIpafI1UhO
 ZWjnP8OZNX892u0PGcdQ01WCF19DYtqqAw9tc8+ZnXwv5elLSLwyxS+TIAiOiPVNS/Fc3tQdyL+
 2OnPQryDA4EdR0Pa2Ii301h7cUGkzmN/e/VaGl8eZm1HgaOJ9oyVUr1DMWqO72qnvfa8u3tjRfY
 3EunHD860TKv5ryNuukylXlJ2ozoAjthNEY10SocEysrc47nLpvPZrV/GpZZsduOPKAjfkfi6G8
 gjA3ghsSSuDja6wzBK7UFBZHdhdsZbdX/7Gi4CxJ0wh0DaiNGtsWx/IKeQm7nBdqlV/eri/ARQF
 UFcGg5Ubzf3Uzz6/c1r3frYV2RYqlezPkMDbNKjwGxyGA1vdY8qwgJHiJTz2Wq1+Tp92kGv8lVT
 bMkYvLTol3jPNBVb4Ww==
X-Authority-Analysis: v=2.4 cv=A8xc+aWG c=1 sm=1 tr=0 ts=69fb7661 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=v4b4B-quZFKF0PxyZCUA:9
 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060168
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

Currently the sysprof param serves two functions, (a) disabling perfcntr
clearing on context switch/preemption, and (b) disabling IFPC.  In the
future, with kernel side global perfcntr collection/stream, the decision
about disabling IFPC will change.

To prepare for this, split out two helpers/accessors for the two
different cases.  For now, they are the same thing, but this will
change.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     |  8 +++-----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  5 +++--
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c |  2 +-
 drivers/gpu/drm/msm/msm_gpu.h             | 18 ++++++++++++++++++
 6 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 1b44b9e21ad8..aba08fb76249 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -2036,10 +2036,10 @@ static int a6xx_gmu_get_irq(struct a6xx_gmu *gmu, struct platform_device *pdev,
 
 void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
 {
+	bool sysprof = msm_gpu_sysprof_no_ifpc(gpu);
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
-	unsigned int sysprof_active;
 
 	/* Nothing to do if GPU is suspended. We will handle this during GMU resume */
 	if (!pm_runtime_get_if_active(&gpu->pdev->dev))
@@ -2047,15 +2047,13 @@ void a6xx_gmu_sysprof_setup(struct msm_gpu *gpu)
 
 	mutex_lock(&gmu->lock);
 
-	sysprof_active = refcount_read(&gpu->sysprof_active);
-
 	/*
 	 * 'Perfcounter select' register values are lost during IFPC collapse. To avoid that,
 	 * use the currently unused perfcounter oob vote to block IFPC when sysprof is active
 	 */
-	if ((sysprof_active > 1) && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	if (sysprof && !test_and_set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
-	else if ((sysprof_active == 1) && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
+	else if (!sysprof && test_and_clear_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status))
 		a6xx_gmu_clear_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 
 	mutex_unlock(&gmu->lock);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 727281fbef36..71f54ab5425d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -203,7 +203,7 @@ static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		struct msm_ringbuffer *ring, struct msm_gem_submit *submit)
 {
-	bool sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
+	bool sysprof = msm_gpu_sysprof_no_perfcntr_zap(&a6xx_gpu->base.base);
 	struct msm_context *ctx = submit->queue->ctx;
 	struct drm_gpuvm *vm = msm_context_vm(submit->dev, ctx);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
@@ -1608,7 +1608,7 @@ static int hw_init(struct msm_gpu *gpu)
 		a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_BOOT_SLUMBER);
 	}
 
-	if (!ret && (refcount_read(&gpu->sysprof_active) > 1)) {
+	if (!ret && msm_gpu_sysprof_no_ifpc(gpu)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 		if (!ret)
 			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
@@ -2854,6 +2854,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
+		.sysprof_setup = a6xx_gmu_sysprof_setup,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a8xx_gmu_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index df4cbf42e9a4..1e599d4ddea1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -261,7 +261,7 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 	mod_timer(&a6xx_gpu->preempt_timer, jiffies + msecs_to_jiffies(10000));
 
 	/* Enable or disable postamble as needed */
-	sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
+	sysprof = msm_gpu_sysprof_no_perfcntr_zap(gpu);
 
 	if (!sysprof && !a6xx_gpu->postamble_enabled)
 		preempt_prepare_postamble(a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index ccfccc45133f..e022c9a162a4 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -849,7 +849,7 @@ static int hw_init(struct msm_gpu *gpu)
 	 */
 	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_GPU_SET);
 
-	if (!ret && (refcount_read(&gpu->sysprof_active) > 1)) {
+	if (!ret && msm_gpu_sysprof_no_perfcntr_zap(gpu)) {
 		ret = a6xx_gmu_set_oob(gmu, GMU_OOB_PERFCOUNTER_SET);
 		if (!ret)
 			set_bit(GMU_STATUS_OOB_PERF_SET, &gmu->status);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
index 3d8c33ba722e..6cb53a071801 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
@@ -242,7 +242,7 @@ void a8xx_preempt_trigger(struct msm_gpu *gpu)
 	mod_timer(&a6xx_gpu->preempt_timer, jiffies + msecs_to_jiffies(10000));
 
 	/* Enable or disable postamble as needed */
-	sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
+	sysprof = msm_gpu_sysprof_no_perfcntr_zap(gpu);
 
 	if (!sysprof && !a6xx_gpu->postamble_enabled)
 		preempt_prepare_postamble(a6xx_gpu);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 8c08dc065372..9e5c753437c2 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -311,6 +311,24 @@ static inline bool msm_gpu_active(struct msm_gpu *gpu)
 	return false;
 }
 
+static inline bool
+msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
+{
+	return refcount_read(&gpu->sysprof_active) > 1;
+}
+
+static inline bool
+msm_gpu_sysprof_no_ifpc(struct msm_gpu *gpu)
+{
+	/*
+	 * For now, this is the same condition as disabling perfcntr clears
+	 * on context switch.  But once kernel perfcntr IFPC support is in
+	 * place, we will only need to disable IFPC for legacy userspace
+	 * setting SYSPROF param.
+	 */
+	return msm_gpu_sysprof_no_perfcntr_zap(gpu);
+}
+
 /*
  * The number of priority levels provided by drm gpu scheduler.  The
  * DRM_SCHED_PRIORITY_KERNEL priority level is treated specially in some
-- 
2.54.0

