Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F156CC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60B8310E234;
	Sun,  5 Jul 2026 19:14:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JPV+UfJN";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FF610E305
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:35 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-47362928f65so2230112f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278873; x=1783883673; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eucsPGNd22T7/L/fPweBTQcc98PLGSu6dgszPF9AEJg=;
 b=JPV+UfJNLHFcD+4qu+AL0Qzi8I5HCyLypGqPVs8Ce2z/ZJNnudcmuWcoh5Wko/jeCm
 6LcmUEuiFEJZggxEBXR8xslIkI7Db1ZeVvFhC7cEDo5lJs+ADjN57GT+xSwk3ngMmwM3
 86E0g03CCUQcz0c8prpD3JYNi93BRg/gsXmP09Iwr3anYQ2Eu0CR27nNY6BFOcRhZfSe
 8+cS/uoIoyKlFjJD9Enfpr32LNuhs7OO6RdSO1f5VICnxXSeIu7PVy7bZxYAh+sJL8gH
 lUeNyRoChScIov97Tnfj941annywhx+do1SUCZwzTwTteQ1weF5/a00ZGs4JiKh4sxnI
 yT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278873; x=1783883673;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eucsPGNd22T7/L/fPweBTQcc98PLGSu6dgszPF9AEJg=;
 b=C1aoFwG1MOZSHhE3CKIMLwHjIJ5JwGaVUi6mZYJT8c9lCMK64ixjwVkFtaIuSoGyHl
 606ZJTac8aDQYMoiSY1A/V0Nn/Z6xyKoX/LmV6Um2i9BqBDofELLyjyv3oxSiQr8G1F2
 4xSp4GrPMbX1PmISfihvfFZiYXJRHHIeJKZnRbc+nAFldLLUlwvoGQbC+DCCMUcW9NBM
 f+Dd3QMZZ08hfDc1QoVa+gAJI50hGvpQwiFyue1wI31WQT5i93POaz5wRyAK4bJ8prkL
 5EqjEQv9Tu+xgO31Eb0BFZigazzGYWtu+as4ywQ3D9CEC/fPEOzT68Nb3un55uGHGMif
 y6vQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq7nYxuL4c/ze9HNw2081g+gyPZ4LwujMWb2sw3MZdJGAG/22Gw3Zh4+e88guBnF+apGfZpNfHSBIA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwbeNDdOmGXzs6OcP0IlB3jw+EKRfeUm2iTdCanmlSlC+txcr8v
 UgBVM40OM6CNtzYUb14KjjbrxaO3Vxm78ESuu0IqBH8EUU+eUxMO6ZU=
X-Gm-Gg: AfdE7clA+L/P6IwJ5Fih8DM88+02lK3UNROdj1YSA3OK94VQrtQpry9Fa9JBhFGvC/g
 JWBemZofAiS44wU8OIU5Zo0Wf+iy2oVr1WRPw+Z6QcfiNUZRa1BHs9ZTA3AWQfHx0lEODlbmrdD
 kJCkgCleaYlGgUrbVnWsysjBtmbXmvKA5CDpS+5vJKNrZ7Qp+78fZlMwq8KGeg7j18sRAXoHJIn
 Wzqv/yJznHKHf7fS+bCwVpsGlySQNFaUJh7l4BmBIvRpwt45NzlUZlDApLy/DWpQMkwr8q+jLXs
 DkmA76XM8Ydy5FuhFM3ASIC55d/vi0pXoqP60VlknaMUa1ZTSy7MEmjeeW5vX6RoSCdJWK/HlOy
 0fikyF2SG69as0nRuo+4WUWmg8OEjPOze4zqiQiQ78CtqjCsCP7yvRhKbQIKwEN96/o9TpeLoJe
 syGWvhNYV+aTo1t19aaSz0N9t7TI9MtQ==
X-Received: by 2002:a05:6000:18a3:b0:472:d857:5d39 with SMTP id
 ffacd0b85a97d-47aa91cad30mr9118667f8f.0.1783278873152; 
 Sun, 05 Jul 2026 12:14:33 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:32 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:44 +0200
Subject: [PATCH RFC 10/13] drm/msm: initialize LPAC ring
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-10-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=12456;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=US11y6MspkBO1wtbA8nmNx+MkENKkTwPRtQtLRAoYd0=;
 b=lj7oKumXTSdxDfAq0n1MJNK9Z10T2woYTOMUT5AqzVpbmXRZpRS/zOOTFgZ/nAGBm7NO1T56Z
 Hboji/xg/o9CIrqQ/JK6Px0J9pNGRTOb2KBPjVHktDKn6B6BDhdnNYg
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

Program all the register needed to start up LPAC and send initialization
sequence.

Additionally, now that the LPAC ring is live, make the code aware of it.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c  |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c      | 98 ++++++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/adreno_device.c |  6 ++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 32 ++++++----
 drivers/gpu/drm/msm/msm_gpu.c              | 21 ++++++-
 drivers/gpu/drm/msm/msm_gpu.h              |  9 +++
 6 files changed, 148 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 3e6f409d13a2..5ee00eead14c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1394,6 +1394,7 @@ static const u32 a750_ifpc_reglist_regs[] = {
 	REG_A6XX_SP_NC_MODE_CNTL,
 	REG_A6XX_CP_DBG_ECO_CNTL,
 	REG_A6XX_CP_PROTECT_CNTL,
+	REG_A6XX_CP_LPAC_PROTECT_CNTL,
 	REG_A6XX_CP_PROTECT(0),
 	REG_A6XX_CP_PROTECT(1),
 	REG_A6XX_CP_PROTECT(2),
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 8b3bb2fd433b..9f69aada9b7b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -168,6 +168,18 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 
 	update_shadow_rptr(gpu, ring);
 
+	if (ring == gpu->lpac_rb) {
+		/* Copy the shadow to the actual register */
+		ring->cur = ring->next;
+
+		/* Make sure to wrap wptr if we need to */
+		wptr = get_wptr(ring);
+
+		a6xx_fenced_write(a6xx_gpu, REG_A7XX_CP_LPAC_RB_WPTR, wptr, BIT(3), false);
+
+		return;
+	}
+
 	spin_lock_irqsave(&ring->preempt_lock, flags);
 
 	/* Copy the shadow to the actual register */
@@ -730,6 +742,12 @@ static void a6xx_set_cp_protect(struct msm_gpu *gpu)
 		  A6XX_CP_PROTECT_CNTL_ACCESS_FAULT_ON_VIOL_EN |
 		  A6XX_CP_PROTECT_CNTL_LAST_SPAN_INF_RANGE);
 
+	//TODO if LPAC
+	gpu_write(gpu, REG_A6XX_CP_LPAC_PROTECT_CNTL,
+		  A6XX_CP_PROTECT_CNTL_ACCESS_PROT_EN |
+		  A6XX_CP_PROTECT_CNTL_ACCESS_FAULT_ON_VIOL_EN |
+		  A6XX_CP_PROTECT_CNTL_LAST_SPAN_INF_RANGE);
+
 	for (i = 0; i < protect->count - 1; i++) {
 		/* Intentionally skip writing to some registers */
 		if (protect->regs[i])
@@ -972,6 +990,53 @@ static int a7xx_cp_init(struct msm_gpu *gpu)
 	return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
 
+static int lpac_cp_init(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct msm_ringbuffer *ring = gpu->lpac_rb;
+	u32 mask;
+
+	OUT_PKT7(ring, CP_ME_INIT, 7);
+
+	/* Use multiple HW contexts */
+	mask = BIT(0);
+
+	/* Enable error detection */
+	mask |= BIT(1);
+
+	/* Set default reset state */
+	mask |= BIT(3);
+
+	/* Disable save/restore of performance counters across preemption */
+	mask |= BIT(6);
+
+	/* Enable the register init list with the spinlock */
+	mask |= BIT(8);
+
+	OUT_RING(ring, mask);
+
+	/* Enable multiple hardware contexts */
+	OUT_RING(ring, 0x00000003);
+
+	/* Enable error detection */
+	OUT_RING(ring, 0x20000000);
+
+	/* Operation mode mask */
+	OUT_RING(ring, 0x00000002);
+
+	/* *Don't* send a power up reg list for concurrent binning (TODO) */
+	/* Lo address */
+	OUT_RING(ring, lower_32_bits(a6xx_gpu->pwrup_reglist_iova));
+	/* Hi address */
+	OUT_RING(ring, upper_32_bits(a6xx_gpu->pwrup_reglist_iova));
+	/* BIT(31) set => read the regs from the list */
+	OUT_RING(ring, BIT(31));
+
+	a6xx_flush(gpu, ring);
+	return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
+}
+
 /*
  * Check that the microcode version is new enough to include several key
  * security fixes. Return true if the ucode is safe.
@@ -1096,7 +1161,7 @@ static int a6xx_ucode_load(struct msm_gpu *gpu)
 	if ((adreno_gpu->base.hw_apriv || a6xx_gpu->has_whereami) &&
 	    !a6xx_gpu->shadow_bo) {
 		a6xx_gpu->shadow = msm_gem_kernel_new(gpu->dev,
-						      sizeof(u32) * gpu->nr_rings,
+						      sizeof(u32) * (gpu->nr_rings + !!gpu->lpac_rb),
 						      MSM_BO_WC | MSM_BO_MAP_PRIV,
 						      gpu->vm, &a6xx_gpu->shadow_bo,
 						      &a6xx_gpu->shadow_iova);
@@ -1289,6 +1354,8 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_UCHE_CACHE_WAYS, 0x4);
 	}
 
+	gpu_rmw(gpu, REG_A6XX_UCHE_DEBUG_CNTL_1, BIT(30), BIT(30));
+
 	if (adreno_is_a640_family(adreno_gpu) || adreno_is_a650_family(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_2, 0x02000140);
 		gpu_write(gpu, REG_A6XX_CP_ROQ_THRESHOLDS_1, 0x8040362c);
@@ -1386,6 +1453,11 @@ static int hw_init(struct msm_gpu *gpu)
 		gpu_write(gpu, REG_A6XX_CP_CHICKEN_DBG, BIT(24));
 	}
 
+	gpu_write(gpu, REG_A7XX_CP_LPAC_CHICKEN_DBG, 0x1);
+
+	gpu_write(gpu, REG_A7XX_SP_CHICKEN_BITS_2, BIT(4));
+	gpu_write(gpu, REG_A7XX_SP_LPAC_CHICKEN_BITS_2, BIT(4));
+
 	if (adreno_is_a690(adreno_gpu))
 		gpu_write(gpu, REG_A6XX_UCHE_CMDQ_CONFIG, 0x90);
 	/* Set dualQ + disable afull for A660 GPU */
@@ -1437,13 +1509,17 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Set the ringbuffer address */
 	gpu_write64(gpu, REG_A6XX_CP_RB_BASE, gpu->rb[0]->iova);
 
+	/* Set the ringbuffer address for lpac */
+	gpu_write64(gpu, REG_A7XX_CP_LPAC_RB_BASE, gpu->lpac_rb->iova);
+
 	/* Targets that support extended APRIV can use the RPTR shadow from
 	 * hardware but all the other ones need to disable the feature. Targets
 	 * that support the WHERE_AM_I opcode can use that instead
 	 */
-	if (adreno_gpu->base.hw_apriv)
+	if (adreno_gpu->base.hw_apriv) {
 		gpu_write(gpu, REG_A6XX_CP_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
-	else
+		gpu_write(gpu, REG_A7XX_CP_LPAC_RB_CNTL, MSM_GPU_RB_CNTL_DEFAULT);
+	} else
 		gpu_write(gpu, REG_A6XX_CP_RB_CNTL,
 			MSM_GPU_RB_CNTL_DEFAULT | AXXX_CP_RB_CNTL_NO_UPDATE);
 
@@ -1451,7 +1527,10 @@ static int hw_init(struct msm_gpu *gpu)
 	if (a6xx_gpu->shadow_bo) {
 		gpu_write64(gpu, REG_A6XX_CP_RB_RPTR_ADDR,
 			shadowptr(a6xx_gpu, gpu->rb[0]));
-		for (unsigned int i = 0; i < gpu->nr_rings; i++)
+		if (gpu->lpac_rb)
+			gpu_write64(gpu, REG_A7XX_CP_LPAC_RB_RPTR_ADDR,
+				shadowptr(a6xx_gpu, gpu->lpac_rb));
+		for (unsigned int i = 0; i < (gpu->nr_rings + !!gpu->lpac_rb); i++)
 			a6xx_gpu->shadow[i] = 0;
 	}
 
@@ -1469,9 +1548,16 @@ static int hw_init(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++)
 		gpu->rb[i]->cur_ctx_seqno = 0;
 
+	if (gpu->lpac_rb)
+		gpu->lpac_rb->cur_ctx_seqno = 0;
+
 	/* Enable the SQE_to start the CP engine */
 	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
 
+	/* Enable the LPAC SQE_to start the CP engine */
+	//TODO is this needed? Doesn't fw do this at init?
+	gpu_write(gpu, REG_A6XX_CP_LPAC_SQE_CNTL, 1);
+
 	if (adreno_is_a7xx(adreno_gpu) && !a6xx_gpu->pwrup_reglist_emitted) {
 		a7xx_patch_pwrup_reglist(gpu);
 		a6xx_gpu->pwrup_reglist_emitted = true;
@@ -1481,6 +1567,10 @@ static int hw_init(struct msm_gpu *gpu)
 	if (ret)
 		goto out;
 
+	ret = lpac_cp_init(gpu);
+	if (ret)
+		goto out;
+
 	/*
 	 * Try to load a zap shader into the secure world. If successful
 	 * we can use the CP to switch out of secure mode. If not then we
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7f20320ef66a..881fa09f3943 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -349,6 +349,9 @@ static void suspend_scheduler(struct msm_gpu *gpu)
 
 		drm_sched_wqueue_stop(sched);
 	}
+
+	if (gpu->lpac_rb)
+		drm_sched_wqueue_stop(&gpu->lpac_rb->sched);
 }
 
 static void resume_scheduler(struct msm_gpu *gpu)
@@ -360,6 +363,9 @@ static void resume_scheduler(struct msm_gpu *gpu)
 
 		drm_sched_wqueue_start(sched);
 	}
+
+	if (gpu->lpac_rb)
+		drm_sched_wqueue_start(&gpu->lpac_rb->sched);
 }
 
 static int adreno_system_suspend(struct device *dev)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 6a48e211fa3c..94dbec9464a4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -655,6 +655,22 @@ struct drm_gem_object *adreno_fw_create_bo(struct msm_gpu *gpu,
 	return bo;
 }
 
+static inline void init_ring(struct msm_ringbuffer *ring)
+{
+	ring->cur = ring->start;
+	ring->next = ring->start;
+	ring->memptrs->rptr = 0;
+	ring->memptrs->bv_fence = ring->fctx->completed_fence;
+
+	/* Detect and clean up an impossible fence, ie. if GPU managed
+	 * to scribble something invalid, we don't want that to confuse
+	 * us into mistakingly believing that submits have completed.
+	 */
+	if (fence_before(ring->fctx->last_fence, ring->memptrs->fence)) {
+		ring->memptrs->fence = ring->fctx->last_fence;
+	}
+}
+
 int adreno_hw_init(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -679,20 +695,12 @@ int adreno_hw_init(struct msm_gpu *gpu)
 		if (!ring)
 			continue;
 
-		ring->cur = ring->start;
-		ring->next = ring->start;
-		ring->memptrs->rptr = 0;
-		ring->memptrs->bv_fence = ring->fctx->completed_fence;
-
-		/* Detect and clean up an impossible fence, ie. if GPU managed
-		 * to scribble something invalid, we don't want that to confuse
-		 * us into mistakingly believing that submits have completed.
-		 */
-		if (fence_before(ring->fctx->last_fence, ring->memptrs->fence)) {
-			ring->memptrs->fence = ring->fctx->last_fence;
-		}
+		init_ring(ring);
 	}
 
+	if (gpu->lpac_rb)
+		init_ring(gpu->lpac_rb);
+
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 18ed00e5f143..932e2a7c24b3 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -739,8 +739,8 @@ static void retire_submits(struct msm_gpu *gpu)
 	int i;
 
 	/* Retire the commits starting with highest priority */
-	for (i = 0; i < gpu->nr_rings; i++) {
-		struct msm_ringbuffer *ring = gpu->rb[i];
+	for (i = 0; i < gpu->nr_rings + !!gpu->lpac_rb; i++) {
+		struct msm_ringbuffer *ring = i < gpu->nr_rings ? gpu->rb[i] : gpu->lpac_rb;
 
 		while (true) {
 			struct msm_gem_submit *submit = NULL;
@@ -782,6 +782,9 @@ void msm_gpu_retire(struct msm_gpu *gpu)
 	for (i = 0; i < gpu->nr_rings; i++)
 		msm_update_fence(gpu->rb[i]->fctx, gpu->rb[i]->memptrs->fence);
 
+	if (gpu->lpac_rb)
+		msm_update_fence(gpu->lpac_rb->fctx, gpu->lpac_rb->memptrs->fence);
+
 	kthread_queue_work(gpu->worker, &gpu->retire_work);
 }
 
@@ -973,7 +976,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	}
 
 	memptrs = msm_gem_kernel_new(drm,
-		sizeof(struct msm_rbmemptrs) * nr_rings,
+		sizeof(struct msm_rbmemptrs) * (nr_rings + 1),
 		check_apriv(gpu, MSM_BO_WC), gpu->vm, &gpu->memptrs_bo,
 		&memptrs_iova);
 
@@ -1006,6 +1009,15 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		memptrs_iova += sizeof(struct msm_rbmemptrs);
 	}
 
+	gpu->lpac_rb = msm_ringbuffer_new(gpu, nr_rings, memptrs, memptrs_iova);
+
+	if (IS_ERR(gpu->rb[i])) {
+		ret = PTR_ERR(gpu->rb[i]);
+		DRM_DEV_ERROR(drm->dev,
+					  "could not create lpac ringbuffer %d\n", ret);
+		goto fail;
+	}
+
 	gpu->nr_rings = nr_rings;
 
 	refcount_set(&gpu->sysprof_active, 1);
@@ -1046,6 +1058,9 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 		gpu->rb[i] = NULL;
 	}
 
+	msm_ringbuffer_destroy(gpu->lpac_rb);
+	gpu->lpac_rb = NULL;
+
 	msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
 
 	if (!IS_ERR_OR_NULL(gpu->vm)) {
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 271956e7f870..9a213fb65b4f 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -181,6 +181,8 @@ struct msm_gpu {
 	struct msm_ringbuffer *rb[MSM_GPU_MAX_RINGS];
 	int nr_rings;
 
+	struct msm_ringbuffer *lpac_rb;
+
 	/**
 	 * sysprof_active:
 	 *
@@ -323,6 +325,13 @@ static inline bool msm_gpu_active(struct msm_gpu *gpu)
 			return true;
 	}
 
+	if (gpu->lpac_rb) {
+		struct msm_ringbuffer *ring = gpu->lpac_rb;
+
+		if (fence_after(ring->fctx->last_fence, ring->memptrs->fence))
+			return true;
+	}
+
 	return false;
 }
 

-- 
2.54.0

