Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18775FED3E3
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C2E510F603;
	Fri, 24 Apr 2026 15:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iVI7UgBA";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bCqesMDQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71AC210F600
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O9AdEU1532371
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=cFtUg4FJvx5
 MF1DaQQ57KRHQULyf4GIu8b9MO2ARFjM=; b=iVI7UgBAK3aMEMV4Xjsh7tZEE5I
 uZcJ0XXcoiOXIzgliX/B/QG/jwXlIvZcJn+s7AmOA3HaCyagKNVVXS5dqYC1JXp8
 V0HF7g41PMgoB+qIcCiZRvXyBeq9KErsKo/ohnkiNIwDuHVFqKg/MEKW10NFfaHu
 maeB5osyUCmuKTKq4dHRj9nK1Zvr3Ajb6nkic51pCcTIAwVHm6gqWhtFRPJTiwHb
 WkjXOnlWHS0NZGelTOA8+2zCplbHhSDIf9+n4yzXFgi9NdcGiPP6hnRMhYV7Di5m
 ccgKPvVSiIuH9VXNR1AAxmVqpq0rQFAgoIvOy7rWEiusJ/4kSrYhv/ygcSQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr26mpdx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:09 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24af7ca99so107545325ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043528; x=1777648328;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cFtUg4FJvx5MF1DaQQ57KRHQULyf4GIu8b9MO2ARFjM=;
 b=bCqesMDQ7iL/7pWtZwHUXLcWDU+uVRsYR4YHXEjDM4ppanVfzJAkDV46Yh76DLATf9
 Okh+qpod33FZYteeNCkW8tOURLDxpxZm6i7UPM6uwnCv5b2JCZKb6kLuU8VultfQAA5Q
 8cEfvCGmlYHdHsAjWY+w/cQ3iNDJo30lT4ntAV3pJdQUp8gbc/v0sh23l62X1gnTqp3R
 24MJeRrCZRItkGbcichklPqs7YQlAY/IroJhwdVCMstr/a7bM1uIRWwL+Ycx8U5fNlBL
 6lRhW8bxhW6IL2jnPM9cTJBp+gGaJKDOfx4wJkZ6er4+q/xIglRyTQ+/2vUAO2kfCyl9
 mHxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043528; x=1777648328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=cFtUg4FJvx5MF1DaQQ57KRHQULyf4GIu8b9MO2ARFjM=;
 b=Zz23jTkkFDc6CtoAAhouG4GnlzzznnNDI+4d68TUaFTTfUrSl7TmnO3lLiQqWJMeyU
 NyiqOENLxuPr4mYUK5PVHpaqbMp37NF17ItyxW4HFsNAGxC+UaUfMirqWUwcJNCB9eG5
 poP9DeOtyklrKVvXnO+59IcGpnjh345lf8SkerLPffavD+ET6kKB++v8OG1euq+e4sUP
 Lc3rfRxkebXvR9GiLaZAozJh34t8QoEuJXFaidtyNKU/RVvRUV0hm4RFCQF9U2+NnNpg
 W/6a2slDg1BVyeKZ7okvoCHVNxxFvKG1CwiTEPNR1EhnCpaUnNQ0kfjLw+/toiloEbK8
 hoqQ==
X-Gm-Message-State: AOJu0YzLEwFXk7R/pYzVMEtzocEw6W/boFyRl3X0iVPsjcJ6aLXd2igs
 BftTQkUKPRbfS4p+cyOzQoviQ2LECKFUr0VvYQj6anA9bxBRLkELGrllewtM4HkZ9EXrA0V/xt+
 8AIbIM+p8nlV7DRHbkUxXBIHrRK03tW1nMw8MSxWMFB/dyNMtAmoThWEHJWCBGOBDrXDjV8Kf2a
 6q4tA=
X-Gm-Gg: AeBDietQJyzmooyWzwQq5yMJZgjgOU3Kr5ZqmYOHHrlmQoiDwiYTv3W6Mjt+0rbjTb/
 r2QilYZyaEA4RgcGDW9IlZ4O2qFB4UlbzC1L4mXt/nqzxQMgaOBbImrWhj04IkrUO2QuBQhArZR
 l1sEhhqlRnbM29HhyfeseJ+zrawNZo+/lhp92scsyJegLt7c8ilo8zWGdkhhtWBvRICRa/fG+ic
 rDmTq/+2Wz4gJzai69YzJebLIZzYYQbwDwL7qpStYGCJDrLRUov6U5/TFHLnIaYhyfGXm0pDc5t
 TebLO/AwlXt5eJcC7Y+pMTRbs+6B5F/IqFOTpi/2rxmcSbPdaWwFl3E2bYlreHBdpY5s9A24Zz+
 KTexdwPVKcaguZvLe9kTYtLGbeXezHMEDsNUeYVkNXrw=
X-Received: by 2002:a17:902:8649:b0:2b4:65ab:57cd with SMTP id
 d9443c01a7336-2b5f9fbdd39mr245951085ad.36.1777043528187; 
 Fri, 24 Apr 2026 08:12:08 -0700 (PDT)
X-Received: by 2002:a17:902:8649:b0:2b4:65ab:57cd with SMTP id
 d9443c01a7336-2b5f9fbdd39mr245950785ad.36.1777043527613; 
 Fri, 24 Apr 2026 08:12:07 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab29398sm233545215ad.66.2026.04.24.08.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:07 -0700 (PDT)
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
Subject: [PATCH v2 07/16] drm/msm: Add sysprof accessors
Date: Fri, 24 Apr 2026 08:10:42 -0700
Message-ID: <20260424151140.104093-8-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 2kB9OE65b6JQtpiJ72EAyGzU9oq44ywb
X-Authority-Analysis: v=2.4 cv=QLhYgALL c=1 sm=1 tr=0 ts=69eb8849 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=v4b4B-quZFKF0PxyZCUA:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: 2kB9OE65b6JQtpiJ72EAyGzU9oq44ywb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfXxjZjQ7w5cJog
 wDAoohTSqSyoRr6mw8Khzy327AHbwCG43odwfRqgII/i4/88FIJAwPac3vznkJz/jE/mjaq6K/m
 e8mF2Zw/4CTIBz1Uk6f1fzZ9nwYAC/GkPiVwphUJa/Ptpb1/+b/1zdOkkDyaJN/NlYn3qIaihxS
 W8SeU4D4y0uPkzjVP1VXg80oavsAGkIw9gqNYfRNN7nA3+LqSZJIQLhGxDMe5JXI+npTnBttN3N
 HCXGjPZiijMEmLpbxIEqrpoBKzB1cnCzCWmOrGdlk1jxRSJGgJCMSyPqUDAylZZJ0BF07JwYB+3
 CSPBtn2LjrqmZFSS6sIq99fwNlYDY5st9q543BB0ymFiTkzMYp475lX02oyQSaRVkawKF+Wqn49
 ON6twoqjx2DQ8UoMtFnartIXy21ykJHwYhMSobgi+GWNCXeKeCUzDiwhZ2/tYs+zKKt8x3rzkso
 LZ+qy5On8GotvOnkC4Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240147
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
2.53.0

