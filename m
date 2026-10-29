Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233EF606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jLmSsDn3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11C31112328;
	Thu, 29 Oct 2026 13:53:54 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4F2112311
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:29 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e4831c028so1779456f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793282008; x=1793886808; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d4muoCURO4txmduRtzfsIk82oRRKuCzaLk324mt4aBA=;
 b=jLmSsDn38goEkEy0T6DQSk3vyQ1tOmQ+gUOSO3XSvrUDt/ipSlECxzD6LtNFrUbd78
 33a/FvzCjb9iUMDS3lQoBEYwFnaL7nYNaoWysnhxPLXBfsmA/cpYmKINHRB0irSieOEa
 d57ey5lAoRB/fu11AC/WxQbDp9aeVXlIs5BD0H0og7aTObYnnCvBspD1OVpdeUB7pAcC
 DmGHYLPqv+X/S+1tw9Y7J5u7TATm8vy+TtYXDpGaNeYCkEUzwI3WN5zy+FMdlFo+5WAK
 wzc7lig7DyBh26cNoJJBzwvs3oSCpWrZYXtw/1AdqGLXt/h48Wv1AuP0/LHQhNsRo1NM
 e9SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793282008; x=1793886808;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=d4muoCURO4txmduRtzfsIk82oRRKuCzaLk324mt4aBA=;
 b=wVzC+1RJgZO7owE82lBE433M2/lz2VbsD/ZbVmgbs6NuFxV36kr5NVIJzEpn5oIhWe
 qGFgKb7UTETIIlw0l67Qzv+v2mpsINbTX4VTwM1AnchODl5gESjIu4k19tTGWEecRAgr
 pd4Tku1ZaCX3Y99AklRIwZtGXSyGCu+Yu8jq/XH0eCZ1rWqbM5DCKJycoxDrjACY558O
 i3fCoi3MYck8K8LTnR1nPYg+/T7K0enuTaaRngmFe9HJRuMzlrOHUfkd22R8GS/OSagM
 1yhw0E04P67Kcb4euK27ezxjodG1NNZScLoBla4pilEv/U8g0OPTz2Vh5uTtrSRUgRID
 bTIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxdTyLKbx3J/P0rnJUKed2N9XciCOerQzd7T5UmDpPAbX1uTKBU8+r4Eh0bZjKmBZcNu2S6IhuvJ9Y=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIVfEsStPlZa3bX5qpsFvjB1qgl90rj0k/CrKp+1OjaNsxzbJUq
 j3gj8OQVzkQaEpJHGBHm7oVvkRKdnFr6aKxFizGiqTVV8Kj+AdwYVMQ=
X-Gm-Gg: AYBFou0Tfre1yXMweOmmfvCy1I8v2mUYXMo3XD4dTpvrmed+eD6dnWs9zhHEfupw8Pn
 VjSFAwlw0HsHsqtbMXCrO7SGZz8zXoSA7oORMjK2a/ktPoEpuNIa92EWos48W4xioA6kqr9kZ/O
 o4Tv9fnQ3zJj1Frp8QVzEK8EVZDiZ0MbRPoXN7M2hHDtOVaAAs5b9I/DgKxJbznBHzfoK/7/ias
 FKMcljA0k8sCJCzmYD0JHcE2edEzewJlN1pHT0MhmLekWGgomsab38npTDRYWEPGaETmQIc6Pd5
 CNdoeaq/i88I4Eo6JTxg/o0TvLNrzDR6R/aNuuPph/+v2xa7RGUQYs7EfllPA+B/8JsDYRSVfRm
 UpMV7A9NUehjAAk4GCJIYaRgbGRtyaKCuvV/jvSdF0egk4VZDloogWY0j+XpjFiI5SHpm82cY3t
 FslEyfNj0pQvtR8BqiPwUwKydTLnvXGW2gBCFzB/THJvxrUxpb4agg+5nW8H4CRtVKssZcHpd2w
 bU6pJn+rJAptPaxDATiFZcBQrMnmBQYWuNFAP9jcU+FwT1bLftSzd/0mcCmWu96jgCVuQkAcrDw
 93hsJdnH5VFKi2XsG2+H06YlM2WRAjcIobIO0HhNhUJwoA==
X-Received: by 2002:a5d:6f0e:0:b0:48d:fbf2:555f with SMTP id
 ffacd0b85a97d-48e5d56d6d6mr12550769f8f.55.1793282007466; 
 Thu, 29 Oct 2026 06:53:27 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:26 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:47 +0100
Subject: [PATCH RFC v2 10/14] drm/msm: Add LPAC submitqueue
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-10-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=12665;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=Vudb/cxCObLS3HWW52CK/cv5tchjqlb2SOL5lEFP4J8=;
 b=UUojngUfhed+XShhn5U0h0uHuRHT+5idiUzPWzFKx4s6uAsn9/vuYKwavuyXf2CKe5jkrYfRV
 nLWbVGTFJxsDIXeZTKgTCQR+ZK4PcXbxFQ5iIf74mMfVj/v5RI6y/ls
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add UAPI and infostructure to support sending submission to the LPAC
ring.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 86 ++++++++++++++++++++++-------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  2 +-
 drivers/gpu/drm/msm/msm_gem_submit.c  |  6 ++-
 drivers/gpu/drm/msm/msm_gpu.c         |  8 ++--
 drivers/gpu/drm/msm/msm_gpu.h         |  4 +-
 drivers/gpu/drm/msm/msm_submitqueue.c | 14 +++++-
 include/uapi/drm/msm_drm.h            |  2 +
 7 files changed, 81 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e7bc12de650c..e82d0c0bc10f 100644
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
@@ -1220,6 +1237,7 @@ int a6xx_zap_shader_init(struct msm_gpu *gpu)
 		       A6XX_RBBM_INT_0_MASK_PM4CPINTERRUPT | \
 		       A6XX_RBBM_INT_0_MASK_CP_RB_DONE_TS | \
 		       A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS | \
+		       A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS_LPAC | \
 		       A6XX_RBBM_INT_0_MASK_RBBM_ATB_BUS_OVERFLOW | \
 		       A6XX_RBBM_INT_0_MASK_RBBM_HANG_DETECT | \
 		       A6XX_RBBM_INT_0_MASK_UCHE_OOB_ACCESS | \
@@ -2039,6 +2057,9 @@ static irqreturn_t a6xx_irq(struct msm_gpu *gpu)
 		a6xx_preempt_trigger(gpu);
 	}
 
+	if (status & A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS_LPAC)
+		msm_gpu_retire(gpu);
+
 	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
 		a6xx_preempt_irq(gpu);
 
@@ -2509,6 +2530,9 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
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
index aa3d6ff456fd..4244d9324cda 100644
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
index 2f6a96e560b9..877f88ef90d9 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -491,9 +491,11 @@ struct msm_context {
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
index 1a5a77b28016..a0249430bd00 100644
--- a/drivers/gpu/drm/msm/msm_submitqueue.c
+++ b/drivers/gpu/drm/msm/msm_submitqueue.c
@@ -175,6 +175,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 	struct msm_drm_private *priv = drm->dev_private;
 	struct msm_gpu_submitqueue *queue;
 	enum drm_sched_priority sched_prio;
+	struct msm_ringbuffer *ring;
 	unsigned ring_nr;
 	int ret;
 
@@ -209,6 +210,16 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
 			return ret;
 
 		queue = kzalloc_obj(*queue);
+
+		if (flags & MSM_SUBMITQUEUE_LPAC) {
+			ring_nr = priv->gpu->nr_rings;
+			ring = priv->gpu->lpac_rb;
+		} else {
+			ring = priv->gpu->rb[ring_nr];
+		}
+
+		if (!ring)
+			return -EINVAL;
 	}
 
 	if (!queue)
@@ -227,8 +238,7 @@ int msm_submitqueue_create(struct drm_device *drm, struct msm_context *ctx,
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
2.56.0

