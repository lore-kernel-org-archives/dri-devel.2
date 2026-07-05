Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D176CC44500
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C91F10E339;
	Sun,  5 Jul 2026 19:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UBhEzfyI";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D236910E305
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:36 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so418907f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278875; x=1783883675; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cMcg9y67rwunE2DKGeLYI29d8HcuwR2xGbFAhvqNdDI=;
 b=UBhEzfyI8GISNhTQIU9w1aFrdM8PxI2V6JzfAMtZpytlv3ty1pYdQzBQ/8hSmIy8Jd
 +8V67g5HxhSRpni0DkCWSqcApE5PK6CimevC94i/tRseiQeIHTcyNwFtsjLdDIISVo/o
 OwrKbDXqcXm2PF8bpAPmMsXltS3M4/fYUNJo7sDGQlLGX8pe8zz78z4TJ9l7vO6R+0X6
 6Qt5XvY7chrMpIHDgjymO7Q/GBUwS4rJQ8paYZor/gReBrR0/JMAm7DRemjozZqrgXY1
 kG4YhI2AeipRmSDMW5UHskTHhceMCFlYCUwDETiWLkzV6rbdnSrwrKEdroUgjV+Dxd1N
 rkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278875; x=1783883675;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=cMcg9y67rwunE2DKGeLYI29d8HcuwR2xGbFAhvqNdDI=;
 b=HT6h8eKKU2oyQsobu24lVczVoAJgsZD0JKZSXUc/GpstiomjI9sm5CM5WjCsq/PKKi
 JEAmsZuBt6tGNbpfY9Qg080TXSmMpFiLWDQoQk6Tpb5x3Z7Vps7tdN08VvV5m09L7ODb
 Pt9kNYqDC71KzgpbjWYYJxJUlUqqGkwWG0HMLptmyNTtOy4cieGSNTE1Bh1YGqjEcX6p
 8AJS8bYLMzLKk8wKO47uWIG1CwtE2b8wfKw1tZQg65Lu/znSmMl85Df9gnMp9Uzqcb7o
 TJJ6fAUX22WgRmDT9ifYjULw+5kr0y6r9WPJ/Ag5EkKktawrgj46n7Lycxdqb/ljTSym
 Vd5w==
X-Forwarded-Encrypted: i=1;
 AHgh+RpIysen5H90sLhL+mtRFOa+UJiw/Xdp+F/NMZUvx4krgfHcwiLnLxQak6tLfYMtp8jzwhV4SlUXi2o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+hJmdf+lv0A805F9++wILtDygm6GK9spsvAz0VisZMbY1HRIe
 Tr8hT6Q0YlUWCVatvZzWC2GFiiRxPDV5jOsaoq5CX31qs6GM6edGWDg=
X-Gm-Gg: AfdE7clM5yt4/0o13k3+8mz8mV7y0VGXIAEWkDq6hj/hQu4bX+vIiKt64MI00VWUKGo
 IFZA/sYBA90q9ZcOan8zkm+QHSobHh791RZwPky8lcIjPstJwQVLDbls5ebYpGShStr2OLMMWOT
 K5voKg8imgOE5h562o8UeG9T8YOh4M0PlTwcwkZiIIkL9ZEMjxcCH8TAqb2s59KGpZFn4lBBU5d
 3C21ij3JIeuzxUw6cay0ZpyB27w7f2U+AaqvLMrLJCvQqAoXDVBX9M1iWIWRST5WQzDAfp4xm3+
 NAQHYmS6v3a90DSeWt5CZm2gb4/F7oNK7j99g+wj1Y/dQAHQ0rR4Xe4wE488M2mks5CQNMbj8mt
 pPWfByaZfNpOyi5m+sc99Fcu1kMTy+WV9tFHJx39MyPC5ZGjEcbieucGvJDW+8+75zvyksSzYfQ
 S+Fy9bZ+4ui/zYjFc=
X-Received: by 2002:adf:e014:0:10b0:460:67e0:563e with SMTP id
 ffacd0b85a97d-47aad54f110mr5661523f8f.35.1783278875081; 
 Sun, 05 Jul 2026 12:14:35 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:34 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:45 +0200
Subject: [PATCH RFC 11/13] drm/msm: Add LPAC submitqueue
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-11-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=12622;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=QVn4kOxQbknn82h4eX+EDDWOieltJQF858rkTdECiao=;
 b=qgqiL6ZgqTya10uwOa+sdOJJc60i/UBr7933iu9z7wQw2WuosSibD6SgaGUPuNFU6OvwcK7Gr
 V9DFTssdykwBSfoa9LDlO7j5SA0jc2oy1m/9+kJ8wvFv/CEhL6RdkSP
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

Add UAPI and infostructure to support sending submission to the LPAC
ring.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 86 ++++++++++++++++++++++-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c  |  6 ++-
 drivers/gpu/drm/msm/msm_gpu.c         |  8 ++--
 drivers/gpu/drm/msm/msm_gpu.h         |  4 +-
 drivers/gpu/drm/msm/msm_submitqueue.c | 11 ++++-
 include/uapi/drm/msm_drm.h            |  2 +
 7 files changed, 78 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 9f69aada9b7b..4417a9d04d7c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -204,8 +204,10 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 void
 a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
+	bool is_lpac = ring == gpu->lpac_rb;
+
 	/* If preemption is enabled */
-	if (gpu->nr_rings > 1) {
+	if (gpu->nr_rings > 1 && !is_lpac) {
 		/* Yield the floor on command completion */
 		OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
 
@@ -244,6 +246,7 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 	struct drm_gpuvm *vm = msm_context_vm(submit->dev, ctx);
 	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
 	phys_addr_t ttbr;
+	bool is_lpac = ring == a6xx_gpu->base.base.lpac_rb;
 	u32 asid;
 	u64 memptr = rbmemptr(ring, ttbr0);
 
@@ -261,25 +264,27 @@ static void a6xx_set_pagetable(struct a6xx_gpu *a6xx_gpu,
 		OUT_RING(ring, upper_32_bits(rbmemptr(ring, fence)));
 		OUT_RING(ring, submit->seqno - 1);
 
-		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
+		if (!is_lpac) {
+			OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+			OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
 
-		/* Reset state used to synchronize BR and BV */
-		OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
-		OUT_RING(ring,
-			 CP_RESET_CONTEXT_STATE_0_CLEAR_ON_CHIP_TS |
-			 CP_RESET_CONTEXT_STATE_0_CLEAR_RESOURCE_TABLE |
-			 CP_RESET_CONTEXT_STATE_0_CLEAR_BV_BR_COUNTER |
-			 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
+			/* Reset state used to synchronize BR and BV */
+			OUT_PKT7(ring, CP_RESET_CONTEXT_STATE, 1);
+			OUT_RING(ring,
+				 CP_RESET_CONTEXT_STATE_0_CLEAR_ON_CHIP_TS |
+				 CP_RESET_CONTEXT_STATE_0_CLEAR_RESOURCE_TABLE |
+				 CP_RESET_CONTEXT_STATE_0_CLEAR_BV_BR_COUNTER |
+				 CP_RESET_CONTEXT_STATE_0_RESET_GLOBAL_LOCAL_TS);
 
-		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
+			OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+			OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BOTH);
 
-		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
-		OUT_RING(ring, LRZ_FLUSH_INVALIDATE);
+			OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+			OUT_RING(ring, LRZ_FLUSH_INVALIDATE);
 
-		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-		OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BR);
+			OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+			OUT_RING(ring, CP_THREAD_CONTROL_0_SYNC_THREADS | CP_SET_THREAD_BR);
+		}
 	}
 
 	if (!sysprof) {
@@ -493,7 +498,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = submit->ring;
-	u32 rbbm_perfctr_cp0, cp_always_on_context;
+	u32 rbbm_perfctr_cp0, cp_always_on_context,
+	    cp_always_on_counter;
+	bool is_lpac = ring == gpu->lpac_rb;
+	u64 timestamp_iova;
 	unsigned int i, ibs = 0;
 
 	adreno_check_and_reenable_stall(adreno_gpu);
@@ -511,19 +519,24 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	 * If preemption is enabled, then set the pseudo register for the save
 	 * sequence
 	 */
-	if (gpu->nr_rings > 1)
+	if (gpu->nr_rings > 1 && !is_lpac)
 		a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, submit->queue);
 
 	if (adreno_is_a8xx(adreno_gpu)) {
 		rbbm_perfctr_cp0 = REG_A8XX_RBBM_PERFCTR_CP(0);
 		cp_always_on_context = REG_A8XX_CP_ALWAYS_ON_CONTEXT;
+		cp_always_on_counter = REG_A8XX_CP_ALWAYS_ON_COUNTER;
 	} else {
 		rbbm_perfctr_cp0 = REG_A7XX_RBBM_PERFCTR_CP(0);
 		cp_always_on_context = REG_A6XX_CP_ALWAYS_ON_CONTEXT;
+		cp_always_on_counter = REG_A6XX_CP_ALWAYS_ON_COUNTER;
 	}
 
 	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, cpcycles_start));
-	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, alwayson_start));
+	if (is_lpac)
+		get_stats_counter(ring, cp_always_on_counter, rbmemptr_stats(ring, index, alwayson_start));
+	else
+		get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, alwayson_start));
 
 	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
 	OUT_RING(ring, CP_SET_THREAD_BOTH);
@@ -582,17 +595,19 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 		OUT_RING(ring, submit->seqno);
 	}
 
-	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-	OUT_RING(ring, CP_SET_THREAD_BR);
+	if (!is_lpac) {
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_SET_THREAD_BR);
 
-	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
-	OUT_RING(ring, CCU_INVALIDATE_DEPTH);
+		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+		OUT_RING(ring, CCU_INVALIDATE_DEPTH);
 
-	OUT_PKT7(ring, CP_EVENT_WRITE, 1);
-	OUT_RING(ring, CCU_INVALIDATE_COLOR);
+		OUT_PKT7(ring, CP_EVENT_WRITE, 1);
+		OUT_RING(ring, CCU_INVALIDATE_COLOR);
 
-	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
-	OUT_RING(ring, CP_SET_THREAD_BV);
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_SET_THREAD_BV);
+	}
 
 	/*
 	 * Make sure the timestamp is committed once BV pipe is
@@ -638,10 +653,12 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	a6xx_flush_yield(gpu, ring);
 
 	/* Check to see if we need to start preemption */
-	if (adreno_is_a8xx(adreno_gpu))
-		a8xx_preempt_trigger(gpu);
-	else
-		a6xx_preempt_trigger(gpu);
+	if (!is_lpac) {
+		if (adreno_is_a8xx(adreno_gpu))
+			a8xx_preempt_trigger(gpu);
+		else
+			a6xx_preempt_trigger(gpu);
+	}
 }
 
 static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
@@ -1219,6 +1236,7 @@ int a6xx_zap_shader_init(struct msm_gpu *gpu)
 		       A6XX_RBBM_INT_0_MASK_PM4CPINTERRUPT | \
 		       A6XX_RBBM_INT_0_MASK_CP_RB_DONE_TS | \
 		       A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS | \
+		       A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS_LPAC | \
 		       A6XX_RBBM_INT_0_MASK_RBBM_ATB_BUS_OVERFLOW | \
 		       A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT | \
 		       A6XX_RBBM_INT_0_MASK_UCHE_OOB_ACCESS | \
@@ -2030,6 +2048,9 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 		a6xx_preempt_trigger(gpu);
 	}
 
+	if (status & A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS_LPAC)
+		msm_gpu_retire(gpu);
+
 	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
 		a6xx_preempt_irq(gpu);
 
@@ -2500,6 +2521,9 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	if (to_adreno_gpu(gpu)->info->quirks & ADRENO_QUIRK_IFPC)
 		return true;
 
+	if (ring == gpu->lpac_rb)
+		return true;
+
 	cp_state = (struct msm_cp_state) {
 		.ib1_base = gpu_read64(gpu, REG_A6XX_CP_IB1_BASE),
 		.ib2_base = gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index b50c57f427b4..d85f2536551c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -75,7 +75,7 @@ struct a6xx_gpu {
 	struct drm_gem_object *preempt_smmu_bo[MSM_GPU_MAX_RINGS];
 	void *preempt_smmu[MSM_GPU_MAX_RINGS];
 	uint64_t preempt_smmu_iova[MSM_GPU_MAX_RINGS];
-	uint32_t last_seqno[MSM_GPU_MAX_RINGS];
+	uint32_t last_seqno[MSM_GPU_MAX_RINGS + 1];
 
 	atomic_t preempt_state;
 	spinlock_t eval_lock;
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 26ea8a28be47..45e7f8b72dc9 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -71,7 +71,8 @@ static struct msm_gem_submit *submit_create(struct drm_device *dev,
 	submit->cmd = (void *)&submit->bos[nr_bos];
 	submit->queue = queue;
 	submit->pid = get_pid(task_pid(current));
-	submit->ring = gpu->rb[queue->ring_nr];
+	submit->ring = queue->ring_nr == gpu->nr_rings ?
+		gpu->lpac_rb : gpu->rb[queue->ring_nr];
 	submit->fault_dumped = false;
 
 	/* Get a unique identifier for the submission for logging purposes */
@@ -599,7 +600,8 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 		goto out_post_unlock;
 	}
 
-	ring = gpu->rb[queue->ring_nr];
+	ring = queue->ring_nr == gpu->nr_rings ?
+		gpu->lpac_rb : gpu->rb[queue->ring_nr];
 
 	if (args->flags & MSM_SUBMIT_FENCE_FD_OUT) {
 		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 932e2a7c24b3..38fdf8d95cc0 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -537,8 +537,8 @@ static void recover_worker(struct kthread_work *work)
 	 * needs to happen after msm_rd_dump_submit() to ensure that the
 	 * bo's referenced by the offending submit are still around.
 	 */
-	for (i = 0; i < gpu->nr_rings; i++) {
-		struct msm_ringbuffer *ring = gpu->rb[i];
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
+		struct msm_ringbuffer *ring = i < gpu->nr_rings ? gpu->rb[i] : gpu->lpac_rb;
 
 		uint32_t fence = ring->memptrs->fence;
 
@@ -561,8 +561,8 @@ static void recover_worker(struct kthread_work *work)
 	 * Replay all remaining submits starting with highest priority
 	 * ring
 	 */
-	for (i = 0; i < gpu->nr_rings; i++) {
-		struct msm_ringbuffer *ring = gpu->rb[i];
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
+		struct msm_ringbuffer *ring = i < gpu->nr_rings ? gpu->rb[i] : gpu->lpac_rb;
 		unsigned long flags;
 
 		spin_lock_irqsave(&ring->submit_lock, flags);
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 9a213fb65b4f..263dafeb9652 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -490,9 +490,11 @@ struct msm_context {
 	 * create at most one &drm_sched_entity per-process per-priority-
 	 * level.
 	 */
-	struct drm_sched_entity *entities[NR_SCHED_PRIORITIES * MSM_GPU_MAX_RINGS];
+	struct drm_sched_entity *entities[NR_SCHED_PRIORITIES * (MSM_GPU_MAX_RINGS + 1)];
+
 	/**
 	 * @ctx_mem:
+	 *
 	 * Total amount of memory of GEM buffers with handles attached for
 	 * this context.
 	 */
diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
index 1a5a77b28016..042b4f90fb73 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -175,6 +175,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	struct msm_drm_private *priv = drm->dev_private;
 	struct msm_gpu_submitqueue *queue;
 	enum drm_sched_priority sched_prio;
+	struct msm_ringbuffer *ring;
 	unsigned ring_nr;
 	int ret;
 
@@ -211,6 +212,13 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 		queue = kzalloc_obj(*queue);
 	}
 
+	if (flags & MSM_SUBMITQUEUE_LPAC) {
+		ring_nr = priv->gpu->nr_rings;
+		ring = priv->gpu->lpac_rb;
+	} else {
+		ring = priv->gpu->rb[ring_nr];
+	}
+
 	if (!queue)
 		return -ENOMEM;
 
@@ -227,8 +235,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	} else {
 		queue->ring_nr = ring_nr;
 
-		queue->entity = get_sched_entity(ctx, priv->gpu->rb[ring_nr],
-						 ring_nr, sched_prio);
+		queue->entity = get_sched_entity(ctx, ring, ring_nr, sched_prio);
 	}
 
 	if (IS_ERR(queue->entity)) {
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 7f2e594be4eb..058228a56213 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -465,10 +465,12 @@ struct drm_msm_gem_madvise {
 
 #define MSM_SUBMITQUEUE_ALLOW_PREEMPT	0x00000001
 #define MSM_SUBMITQUEUE_VM_BIND	0x00000002  /* virtual queue for VM_BIND ops */
+#define MSM_SUBMITQUEUE_LPAC	0x00000004
 
 #define MSM_SUBMITQUEUE_FLAGS		    ( \
 		MSM_SUBMITQUEUE_ALLOW_PREEMPT | \
 		MSM_SUBMITQUEUE_VM_BIND | \
+		MSM_SUBMITQUEUE_LPAC | \
 		0)
 
 /*

-- 
2.54.0

