Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09EDF606D810
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qgh6Zhqw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE94C10EA96;
	Fri,  6 Nov 2026 16:46:42 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F52A112F1A
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 16:46:36 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4a207b02a2cso5810535e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 06 Nov 2026 08:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793983594; x=1794588394; darn=lists.freedesktop.org;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=tR9PIZMp1/B1VZp61PDJflUuOC+d7CAwP94G0NwVvBg=;
 b=qgh6Zhqw7vuth3ZD8ci417O3pVzyRSddEbw8Ch+K9OOOOl/e5uVTOu1mFZrXikJFIn
 T36EDEZkmtoYK26qG22R4GHR1rDD2D1MRLXBP35hsWUI+9npEZI6DRLfn/2FLj0W0c9r
 gGUBiSDMFVCA0n/okt0WaKmnchBXloLu8+qw6YSrzUnctCp/a48N9R+yA71a3ax0GrPU
 KaAfz9FEION4eWImLMXPOZVp1mQ3Fq2tNjmQ//8/oYdZUNFYI+UraTRmyx+r9LBv9o1a
 Y48r0FYwE6KInrWw3ha0Zc4oGVRSjKNuAx/gnG/TmiBxF3HKoHitEzGvJNhZLS43F8Hi
 juzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793983594; x=1794588394;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=tR9PIZMp1/B1VZp61PDJflUuOC+d7CAwP94G0NwVvBg=;
 b=DQfDMMMAW6E77SVu6uzlBRJ7K/OOnCs6spkku38p+K0JHmAnANDG1nMOcWdSxuRDUK
 lFWXKG7lrXjva5n6G6MGJXrepCnd3nbBdhATpfSljH5a2+lZ/G6SbpFYeeGN1uDi7uQz
 YNsKapIVvgWf+SV2IfINqvnXwjszllgcqSLO7iIOM3bGY2c1fzeNOqjynhoHMMYqs1Qz
 2a4NpfzfMQNqQDay0k1/wnx/Ha9beTKoO8Qk9z2TVI+NTlCWHdX/tO7XldWZdh+U2CLb
 A2ZlJItPyQXGYxjT6wqeDVuShf3F8WT4lVN1wU8+qUEo5/G/vi30sdDEYGOJPdI9s75i
 qkbg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxfNUI/7jQ0GRy1Dy8bITKzcEUnxkb/fI/W0ks541cS73MW++idrcEb6OfefLU6tIFWk8ah45QL124=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8G046j8jZMDY2WrcjTP2O8hipINGOak+Se7n8CoB26EqOM1nMR
 fMFlMBwxfT/Kt5Xq7straKDV60hddnXRbHJmd+njU5qdS5LBB53/ySE=
X-Gm-Gg: AYBFou2hSkjidwTDzWs4Os+LfJE98nf8TLRo1HZ5Bknrf1ZvGhDBogjxyGjWJQ2n75K
 puBMOgI7Vz/gk/oBGKzlcpTXcSOlztSLBtITam9V73BeH5gMiTJp9s0XqlAyx7OrlDhjopPwaOF
 n632FKmtTdvNEaIbdL+P/GCpeUIHrkxHO/g9VtbanOrE7fDG3uasD7dIKruk79MyYLy/imWZYAQ
 jiSsNv+K/ZzmNpk+VuQj9fZjKF+C675th6agW1n8bvUeCJz/h9RM0vORmkkCV0LVsfDHEZCKig2
 ejVs+Ud/hRzj0TWOwWEP7Np6zBTzZyoWFKTsf3U2YKcN7v22cQHmJoDE1kARyV94YsGZ9KtPbIW
 6FwyHV1d9gTVCLWpohbZSA0sUxVjwyDrV6gnBQoAf6Oz/w4f9mI8WD5w97tXJcUq+U7ddkDMhmK
 9/3a0cmAqfSUUwD5MgbuQ+DmIo1GPmZFQ8rjSGsuGhFiUc53Nea5+jrjnqOa9urpQQBGQA2Z2XM
 rdQ6DaX4G0snl1n/Ta6l4JiXEVU9mby5KW55G9+rNI96sr6LITNzn8JoaKpY74pJpHOGgSfalDz
 bTj3+xRRi5JmfSDbZEJ+ez15L39Sx5Aj5YnQNjScv1oXmg==
X-Received: by 2002:a05:600c:34ce:b0:4a3:59ee:86b with SMTP id
 5b1f17b1804b1-4b6dc400256mr57508205e9.4.1793983594180; 
 Fri, 06 Nov 2026 08:46:34 -0800 (PST)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b76cb75939sm6920425e9.2.2026.11.06.08.46.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Nov 2026 08:46:32 -0800 (PST)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Fri, 06 Nov 2026 17:46:28 +0100
Subject: [PATCH v3] drm/msm: preemption aware hangcheck
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-preemption_aware_hangcheck-v3-1-852acf72102c@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/43NTQrCMBAF4KtI1kZmUtsmrryHSEnTaRu0PyQlK
 qV3Ny0IrsTNwHs8vpmZJ2fJs9NuZo6C9XboY0j2O2Za3TfEbRUzEyBSUIh8dETdOMVZoR/aUbG
 uTEvmxmWpyiQHSbUxLAJxWtvnhl+uMbfWT4N7bb8Cru1fbEAOXOVHiUrmWbznptP2fjBDx1Y2i
 A+VIQj1kxIceUkAaUZYg6i+qWVZ3qb+1fAPAQAA
X-Change-ID: 20250911-preemption_aware_hangcheck-8b9b3708efcc
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Anna Maniscalco <anna.maniscalco2000@gmail.com>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793983590; l=19376;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=3YuXm70yMdYjYDs5BkuqBGUpJREbdPh3eisb0CkPUZQ=;
 b=tDYnguVvGxA3EqQpfsxq0XhzHSlCi0aXQpyIxh/Mwjd+u0KQHnKReb6/xDulpI0JFhoXKyfiX
 LWTZXBs50bNBvuYND31rrvhd/rmL58/pDrewl47RsmeClpsUrUqmSrB
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Rework hangcheck code to work well toghether with preemption.

Track the time a job has spent in a ring by storing timestamps of the
`CP_ALWAYS_ON_CONTEXT` register at the beginning of a job and when
switching rings as well as reading it back if the ring is currently
active.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
Ever since we added support for preemption hangcheck has been somewhat
broken as it is not aware of multiple rings.

In some cases it might not recognize that one ring is stuck if the gpu
switches in and out of it.

depends on https://lore.kernel.org/linux-arm-msm/20261102190010.720443-1-robin.clark@oss.qualcomm.com
---
Changes in v3:
- Addressed sashiko's feedback
- Rebased on reworked IFPC disable series
- Link to v2: https://patch.msgid.link/20261029-preemption_aware_hangcheck-v2-1-be0056e1f02d@gmail.com

Changes in v2:
- Various fixes
- Fix interaction with IFPC by using OOB vote
- Link to v1: https://lore.kernel.org/r/20250911-preemption_aware_hangcheck-v1-0-974819876819@gmail.com

To: Rob Clark <robin.clark@oss.qualcomm.com>
To: Sean Paul <sean@poorly.run>
To: Konrad Dybcio <konradybcio@kernel.org>
To: Akhil P Oommen <akhilpo@oss.qualcomm.com>
To: Dmitry Baryshkov <lumag@kernel.org>
To: Abhinav Kumar <abhinav.kumar@linux.dev>
To: Jessica Zhang <jesszhan0024@gmail.com>
To: Marijn Suijten <marijn.suijten@somainline.org>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: freedreno@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     |  5 +--
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     |  6 +---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 54 +++++++++++++++++++++++------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c | 32 +++++++++++++-----
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     | 12 ++-----
 drivers/gpu/drm/msm/adreno/adreno_gpu.c   |  3 +-
 drivers/gpu/drm/msm/msm_gpu.c             | 56 ++++++++++++++++++++++++-------
 drivers/gpu/drm/msm/msm_gpu.h             | 11 ++++++
 drivers/gpu/drm/msm/msm_ringbuffer.h      | 10 ++++++
 10 files changed, 140 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 16c7335c4b1f..8800352455df 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1251,10 +1251,7 @@ static void a5xx_fault_detect_irq(struct msm_gpu *gpu)
 		gpu_read64(gpu, REG_A5XX_CP_IB2_BASE),
 		gpu_read(gpu, REG_A5XX_CP_IB2_BUFSZ));
 
-	/* Turn off the hangcheck timer to keep it from bothering us */
-	timer_delete(&gpu->hangcheck_timer);
-
-	kthread_queue_work(gpu->worker, &gpu->recover_work);
+	msm_trigger_recovery(gpu);
 }
 
 #define RBBM_ERROR_MASK \
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index bba5468db42e..bcbe1b949217 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -28,11 +28,7 @@ static void a6xx_gmu_fault(struct a6xx_gmu *gmu)
 	/* FIXME: add a banner here */
 	gmu->hung = true;
 
-	/* Turn off the hangcheck timer while we are resetting */
-	timer_delete(&gpu->hangcheck_timer);
-
-	/* Queue the GPU handler because we need to treat this as a recovery */
-	kthread_queue_work(gpu->worker, &gpu->recover_work);
+	msm_trigger_recovery(gpu);
 }
 
 static irqreturn_t a6xx_gmu_irq(int irq, void *data)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 773c1727dd31..179e42119307 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -519,6 +519,9 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	get_stats_counter(ring, rbbm_perfctr_cp0, rbmemptr_stats(ring, index, cpcycles_start));
 	get_stats_counter(ring, cp_always_on_context, rbmemptr_stats(ring, index, alwayson_start));
 
+	get_stats_counter(ring, cp_always_on_context,
+		rbmemptr(ring, last_job_start_ctx));
+
 	OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
 	OUT_RING(ring, CP_SET_THREAD_BOTH);
 
@@ -1474,8 +1477,11 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Always come up on rb 0 */
 	a6xx_gpu->cur_ring = gpu->rb[0];
 
-	for (i = 0; i < gpu->nr_rings; i++)
+	for (i = 0; i < gpu->nr_rings; i++) {
 		gpu->rb[i]->cur_ctx_seqno = 0;
+		gpu->rb[i]->memptrs->last_job_start_ctx = 0;
+		gpu->rb[i]->memptrs->last_active_ctxcycles = 0;
+	}
 
 	/* Enable the SQE_to start the CP engine */
 	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
@@ -1838,13 +1844,10 @@ static void a6xx_fault_detect_irq(struct msm_gpu *gpu)
 		gpu_read64(gpu, REG_A6XX_CP_IB2_BASE),
 		gpu_read(gpu, REG_A6XX_CP_IB2_REM_SIZE));
 
-	/* Turn off the hangcheck timer to keep it from bothering us */
-	timer_delete(&gpu->hangcheck_timer);
-
 	/* Turn off interrupts to avoid triggering recovery again */
 	gpu_write(gpu, REG_A6XX_RBBM_INT_0_MASK, 0);
 
-	kthread_queue_work(gpu->worker, &gpu->recover_work);
+	msm_trigger_recovery(gpu);
 }
 
 static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
@@ -1861,11 +1864,8 @@ static void a7xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
 	 * to legacy blending.
 	 */
 	if (status & (A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
-		      A7XX_CX_MISC_SW_FUSE_VALUE_LPAC)) {
-		timer_delete(&gpu->hangcheck_timer);
-
-		kthread_queue_work(gpu->worker, &gpu->recover_work);
-	}
+		      A7XX_CX_MISC_SW_FUSE_VALUE_LPAC))
+		msm_trigger_recovery(gpu);
 }
 
 static void a6xx_gpu_keepalive_vote(struct msm_gpu *gpu, bool on)
@@ -2293,6 +2293,39 @@ static u64 a6xx_get_timestamp(struct msm_gpu *gpu)
 	return gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER);
 }
 
+static int a6xx_get_ctx_timestamp(struct msm_ringbuffer *ring, uint64_t *value)
+{
+	struct msm_gpu *gpu = ring->gpu;
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	int ret = 0;
+
+	/* Inhibit IFPC while accessing registers: */
+	guard(ifpc_disable)(gpu);
+
+	/*
+	 * a6xx_gmu_set_oob cannot be called while holding a spinlock.
+	 * Limit the scope.
+	 */
+	if (gpu->nr_rings == 1) {
+		guard(spinlock_irqsave)(&a6xx_gpu->eval_lock);
+
+		/*
+		 * Make sure the GMU keeps the GPU on while we read the register
+		 *
+		 * This should normally not be waking up the gpu since the
+		 * hangcheck timer shouldn't fire when the gpu is idle.
+		 */
+		if (a6xx_in_preempt(a6xx_gpu) || ring != a6xx_gpu->cur_ring)
+			return -EBUSY;
+
+		*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_CONTEXT);
+	} else
+		*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_CONTEXT);
+
+	return ret;
+}
+
 static struct msm_ringbuffer *a6xx_active_ring(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -2892,6 +2925,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 		.progress = a6xx_progress,
 		.ifpc_update = a6xx_gmu_ifpc_update,
 		.perfcntr_configure = a6xx_perfcntr_configure,
+		.get_ctx_timestamp = a6xx_get_ctx_timestamp,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index c0d7ca0969e1..36cf6d7f3d44 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -105,6 +105,7 @@ struct a6xx_gpu {
 	struct drm_gem_object *preempt_postamble_bo;
 	void *preempt_postamble_ptr;
 	uint64_t preempt_postamble_iova;
+	uint64_t preempt_postamble_cntreset_end;
 	uint64_t preempt_postamble_len;
 	bool postamble_enabled;
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 1e599d4ddea1..e85a4d0e9257 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -21,14 +21,18 @@ static void a6xx_preempt_timer(struct timer_list *t)
 		return;
 
 	dev_err(dev->dev, "%s: preemption timed out\n", gpu->name);
-	kthread_queue_work(gpu->worker, &gpu->recover_work);
+	msm_trigger_recovery(gpu);
 }
 
-static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu)
+static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu, struct msm_ringbuffer *ring)
 {
 	u32 *postamble = a6xx_gpu->preempt_postamble_ptr;
+	uint64_t last_active_ctxcycles = 0;
 	u32 count = 0;
 
+	if (ring)
+		last_active_ctxcycles = rbmemptr(ring, last_active_ctxcycles);
+
 	postamble[count++] = PKT7(CP_REG_RMW, 3);
 	postamble[count++] = REG_A6XX_RBBM_PERFCTR_SRAM_INIT_CMD;
 	postamble[count++] = 0;
@@ -43,6 +47,17 @@ static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu)
 	postamble[count++] = CP_WAIT_REG_MEM_4_MASK(0x1);
 	postamble[count++] = CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0);
 
+	a6xx_gpu->preempt_postamble_cntreset_end = count;
+
+	if (last_active_ctxcycles) {
+		postamble[count++] = PKT7(ring ? CP_REG_TO_MEM : CP_NOP, 3);
+		postamble[count++] = CP_REG_TO_MEM_0_REG(REG_A6XX_CP_ALWAYS_ON_CONTEXT) |
+			CP_REG_TO_MEM_0_CNT(2) |
+			CP_REG_TO_MEM_0_IS_64B;
+		postamble[count++] = lower_32_bits(last_active_ctxcycles);
+		postamble[count++] = upper_32_bits(last_active_ctxcycles);
+	}
+
 	a6xx_gpu->preempt_postamble_len = count;
 
 	a6xx_gpu->postamble_enabled = true;
@@ -54,9 +69,9 @@ static void preempt_disable_postamble(struct a6xx_gpu *a6xx_gpu)
 
 	/*
 	 * Disable the postamble by replacing the first packet header with a NOP
-	 * that covers the whole buffer.
+	 * that skips the counters reset part.
 	 */
-	*postamble = PKT7(CP_NOP, (a6xx_gpu->preempt_postamble_len - 1));
+	*postamble = PKT7(CP_NOP, (a6xx_gpu->preempt_postamble_cntreset_end - 1));
 
 	a6xx_gpu->postamble_enabled = false;
 }
@@ -263,10 +278,9 @@ void a6xx_preempt_trigger(struct msm_gpu *gpu)
 	/* Enable or disable postamble as needed */
 	sysprof = msm_gpu_sysprof_no_perfcntr_zap(gpu);
 
-	if (!sysprof && !a6xx_gpu->postamble_enabled)
-		preempt_prepare_postamble(a6xx_gpu);
-
-	if (sysprof && a6xx_gpu->postamble_enabled)
+	if (!sysprof)
+		preempt_prepare_postamble(a6xx_gpu, ring);
+	else
 		preempt_disable_postamble(a6xx_gpu);
 
 	/* Set the preemption state to triggered */
@@ -382,7 +396,7 @@ void a6xx_preempt_init(struct msm_gpu *gpu)
 	if (IS_ERR(a6xx_gpu->preempt_postamble_ptr))
 		goto fail;
 
-	preempt_prepare_postamble(a6xx_gpu);
+	preempt_prepare_postamble(a6xx_gpu, NULL);
 
 	timer_setup(&a6xx_gpu->preempt_timer, a6xx_preempt_timer, 0);
 
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index b6250a2bd113..f83de4de8b35 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1184,10 +1184,7 @@ static void a8xx_fault_detect_irq(struct msm_gpu *gpu)
 	a8xx_aperture_release(gpu, flags);
 	a8xx_aperture_clear(gpu);
 
-	/* Turn off the hangcheck timer to keep it from bothering us */
-	timer_delete(&gpu->hangcheck_timer);
-
-	kthread_queue_work(gpu->worker, &gpu->recover_work);
+	msm_trigger_recovery(gpu);
 }
 
 static void a8xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
@@ -1204,11 +1201,8 @@ static void a8xx_sw_fuse_violation_irq(struct msm_gpu *gpu)
 	 * to legacy blending.
 	 */
 	if (status & (A7XX_CX_MISC_SW_FUSE_VALUE_RAYTRACING |
-		      A7XX_CX_MISC_SW_FUSE_VALUE_LPAC)) {
-		timer_delete(&gpu->hangcheck_timer);
-
-		kthread_queue_work(gpu->worker, &gpu->recover_work);
-	}
+		      A7XX_CX_MISC_SW_FUSE_VALUE_LPAC))
+		msm_trigger_recovery(gpu);
 }
 
 irqreturn_t a8xx_irq(struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index dadfe4c69438..9218fc567144 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -335,7 +335,8 @@ int adreno_fault_handler(struct msm_gpu *gpu, unsigned long iova, int flags,
 		struct msm_gpu_fault_info fault_info = {};
 
 		/* Turn off the hangcheck timer to keep it from bothering us */
-		timer_delete(&gpu->hangcheck_timer);
+		for (int i = 0; i < gpu->nr_rings; i++)
+			timer_delete(&gpu->rb[i]->hangcheck_timer);
 
 		/* Let any concurrent GMU transactions know that the MMU may be
 		 * blocked for a while and they should wait on us.
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 8ed395cc69f5..5232305de58a 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -467,7 +467,9 @@ static void recover_worker(struct kthread_work *work)
 	struct drm_device *dev = gpu->dev;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_submit *submit;
-	struct msm_ringbuffer *cur_ring = gpu->funcs->active_ring(gpu);
+	struct msm_ringbuffer *cur_ring = gpu->hung_ring ?
+		gpu->hung_ring : gpu->funcs->active_ring(gpu);
+	gpu->hung_ring = NULL;
 	char *comm = NULL, *cmd = NULL;
 	unsigned int noreclaim_flag;
 	struct task_struct *task;
@@ -629,11 +631,11 @@ void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_
 	mutex_unlock(&gpu->lock);
 }
 
-static void hangcheck_timer_reset(struct msm_gpu *gpu)
+static void hangcheck_ring_timer_reset(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	struct msm_drm_private *priv = gpu->dev->dev_private;
-	mod_timer(&gpu->hangcheck_timer,
-			round_jiffies_up(jiffies + msecs_to_jiffies(priv->hangcheck_period)));
+	mod_timer(&ring->hangcheck_timer,
+			  round_jiffies_up(jiffies + msecs_to_jiffies(priv->hangcheck_period)));
 }
 
 static bool made_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
@@ -651,11 +653,31 @@ static bool made_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return true;
 }
 
-static void hangcheck_handler(struct timer_list *t)
+static bool check_ring_timeout(struct msm_ringbuffer *ring, unsigned long timeout)
+{
+	struct msm_gpu *gpu = ring->gpu;
+	u64 start, end;
+
+	if (!gpu->funcs->get_ctx_timestamp)
+		return !made_progress(gpu, ring);
+
+	start = ring->memptrs->last_job_start_ctx;
+
+	if (gpu->funcs->get_ctx_timestamp(ring, &end))
+		end = ring->memptrs->last_active_ctxcycles;
+
+	if (end >= start)
+		return (end - start) > timeout;
+	else
+		return false;
+}
+
+static void hangcheck_worker(struct kthread_work *work)
 {
-	struct msm_gpu *gpu = timer_container_of(gpu, t, hangcheck_timer);
+	struct msm_ringbuffer *ring = container_of(work, struct msm_ringbuffer, hangcheck_work);
+	struct msm_gpu *gpu = ring->gpu;
+	struct msm_drm_private *priv = gpu->dev->dev_private;
 	struct drm_device *dev = gpu->dev;
-	struct msm_ringbuffer *ring = gpu->funcs->active_ring(gpu);
 	uint32_t fence = ring->memptrs->fence;
 
 	if (fence != ring->hangcheck_fence) {
@@ -663,7 +685,7 @@ static void hangcheck_handler(struct timer_list *t)
 		ring->hangcheck_fence = fence;
 		ring->hangcheck_progress_retries = 0;
 	} else if (fence_before(fence, ring->fctx->last_fence) &&
-			!made_progress(gpu, ring)) {
+			check_ring_timeout(ring, priv->hangcheck_period * 19200)) {
 		/* no progress and not done.. hung! */
 		ring->hangcheck_fence = fence;
 		ring->hangcheck_progress_retries = 0;
@@ -674,17 +696,26 @@ static void hangcheck_handler(struct timer_list *t)
 		DRM_DEV_ERROR(dev->dev, "%s:     submitted fence: %u\n",
 				gpu->name, ring->fctx->last_fence);
 
+		gpu->hung_ring = ring;
 		kthread_queue_work(gpu->worker, &gpu->recover_work);
 	}
 
 	/* if still more pending work, reset the hangcheck timer: */
 	if (fence_after(ring->fctx->last_fence, ring->hangcheck_fence))
-		hangcheck_timer_reset(gpu);
+		hangcheck_ring_timer_reset(gpu, ring);
 
 	/* workaround for missing irq: */
 	msm_gpu_retire(gpu);
 }
 
+static void hangcheck_handler(struct timer_list *t)
+{
+	struct msm_ringbuffer *ring = timer_container_of(ring, t, hangcheck_timer);
+	struct msm_gpu *gpu = ring->gpu;
+
+	kthread_queue_work(gpu->worker, &ring->hangcheck_work);
+}
+
 /*
  * Cmdstream submission/retirement:
  */
@@ -826,7 +857,7 @@ void msm_gpu_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	submit->ring->cur_ctx_seqno = submit->queue->ctx->seqno;
 
 	pm_runtime_put(&gpu->pdev->dev);
-	hangcheck_timer_reset(gpu);
+	hangcheck_ring_timer_reset(gpu, submit->ring);
 }
 
 /*
@@ -923,8 +954,6 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	if (funcs->progress)
 		priv->hangcheck_period /= 2;
 
-	timer_setup(&gpu->hangcheck_timer, hangcheck_handler, 0);
-
 	/* Map registers: */
 	gpu->mmio = msm_ioremap(pdev, config->ioname);
 	if (IS_ERR(gpu->mmio)) {
@@ -1006,6 +1035,9 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 			goto fail;
 		}
 
+		timer_setup(&gpu->rb[i]->hangcheck_timer, hangcheck_handler, 0);
+		kthread_init_work(&gpu->rb[i]->hangcheck_work, hangcheck_worker);
+
 		memptrs += sizeof(struct msm_rbmemptrs);
 		memptrs_iova += sizeof(struct msm_rbmemptrs);
 	}
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index e7912d2180a5..ae83e5059eea 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -101,6 +101,7 @@ struct msm_gpu_funcs {
 
 	/* Flush perfcntrs before reading (optional): */
 	void (*perfcntr_flush)(struct msm_gpu *gpu);
+	int (*get_ctx_timestamp)(struct msm_ringbuffer *ring, uint64_t *value);
 };
 
 /* Additional state for iommu faults: */
@@ -249,6 +250,8 @@ struct msm_gpu {
 	/* work for handling GPU recovery: */
 	struct kthread_work recover_work;
 
+	struct msm_ringbuffer *hung_ring;
+
 	/** retire_event: notified when submits are retired: */
 	wait_queue_head_t retire_event;
 
@@ -816,6 +819,14 @@ static inline void msm_gpu_crashstate_put(struct msm_gpu *gpu)
 	mutex_unlock(&gpu->lock);
 }
 
+static inline void msm_trigger_recovery(struct msm_gpu *gpu)
+{
+	for (int i = 0; i < gpu->nr_rings; i++)
+		timer_delete(&gpu->rb[i]->hangcheck_timer);
+
+	kthread_queue_work(gpu->worker, &gpu->recover_work);
+}
+
 void msm_gpu_fault_crashstate_capture(struct msm_gpu *gpu, struct msm_gpu_fault_info *fault_info);
 
 /*
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index 0bfb6b0f42fa..6209c2fd3e67 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -39,6 +39,9 @@ struct msm_rbmemptrs {
 	volatile u32 context_idr;
 
 	volatile u32 perfcntr_fence;
+
+	volatile u64 last_job_start_ctx;
+	volatile u64 last_active_ctxcycles;
 };
 
 struct msm_cp_state {
@@ -77,6 +80,13 @@ struct msm_ringbuffer {
 	uint64_t memptrs_iova;
 	struct msm_fence_context *fctx;
 
+	/* Hang and Inactivity Detection:
+	 */
+	struct timer_list hangcheck_timer;
+
+	/* work for handling GPU hangcheck: */
+	struct kthread_work hangcheck_work;
+
 	/**
 	 * hangcheck_progress_retries:
 	 *

---
base-commit: 446a86f7c96426b3f9f7d23d239c95cf9dd95ffe
change-id: 20250911-preemption_aware_hangcheck-8b9b3708efcc

Best regards,
--  
Anna Maniscalco <anna.maniscalco2000@gmail.com>

