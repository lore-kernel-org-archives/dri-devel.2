Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FAF606A324
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=U74tWlw5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D52410EBBF;
	Mon,  2 Nov 2026 08:04:02 +0000 (UTC)
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21F0210E3D5
 for <dri-devel@lists.freedesktop.org>; Sun,  1 Nov 2026 18:05:37 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-8a0673d9bd2so1297768b3a.3
 for <dri-devel@lists.freedesktop.org>; Sun, 01 Nov 2026 10:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793556336; x=1794161136; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KZfx8zG3lr0SxJdej5NZrOvMKfAGpQe9QBAGg9mMie8=;
 b=U74tWlw5ufg414vZbum4UUligPmcEU09QA/ldwuhfm3EHqVEMu81EKl07PUISv8iLf
 aHtzhMhdCdwddVYNC53cC7MNyHIeCIhOn11KiojAMLNjc4VUl1MbWkLgdOoKwAR8XfFN
 cGKqQOtXrYvR5iBeKC0oRVX7C4UhW4VV/3VUolldnOutihb3JVEdc2cwRmQiIAUJ0WdC
 BKvDhIj2jcj/aOwWdWMDUrXDaPKzEIuzlDmHkaOOYqZix4VqHAUj/ZBxjZRyj5CT1UlX
 B+XM3Bw3YVRYPV6ae/f0YkOzl76ni/GQ2h6XktrORJYFVaouaJh2/h7n6tCRubpFFV5T
 Cs0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793556336; x=1794161136;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KZfx8zG3lr0SxJdej5NZrOvMKfAGpQe9QBAGg9mMie8=;
 b=XhkCw/xCKZni1J0u9f57hCwz9QKK+iluONpZ7pEDNdYU3d1cWB6VmkN8CnEnWozjUS
 XhGXpQAc1d27kKXtR7YNFbavrWeyN7wQWX8hj7JkiwgoNoM8veu8eRK8CkDVyzecGRhP
 MrIWQkXcHsWXlcLENQncZBOcJHT0xz6J712oHNnODL4uGZ0+Cph90M0AqFBJoPdDJR0i
 0l3EQqmv9TuO32um3o3MWfNzh5lB5YYOGCnIVc6Dy2g2tQqWy29hB2OeWmnsl7P7Cwm4
 Kd6Eb969HzxwrZNGJiaGIRn3XUMUKmSctOAg49KQ8ZcY1RDNo7K50588WVVuYchS9D+F
 6pUw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6AvnGCSeeph8naZp2SfXQKTHiTOfjKVF0AXoJCqjb0pO8t04dO+xZvYhijRIilMIw9hCK+fLwmuU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKGK8XNY2RhK5GgjNO4V2Ch2VviR6EVgv5R/a74CPNVoBCl3Zth
 65Oo8vaPWUuPrhEyu5SegphbQZ7Se1ocWCqQXc+MQ/UCCoE095eUVHwF
X-Gm-Gg: AYBFou1kSb8rbbyqDbUE/x+e8bR23c1vVtUDa71d41Q2F2m1+RCADoCplWJpkU2QSVl
 1RxCWNQdHTXC28NBiYOou36QQU98g6xyaHUom0xgGUupUAj8pYAudRe8Fi4elh6zAw8MIaG6RYj
 ulPvbApW0R5POdMRcd9J5ZmuXmvNoo6G92NNUAHkT+rM+0zruQjz7tQkfdQnAH10TGu8S4Qm405
 C2YmbfvAoskYeBuI4MPPqcQZ3QjpuabVpQDMbe6gEETMBgYiE4AedpVoaermlPxulUXYkwbIjVP
 nMs0gmyrNZI6MK+nyhoEF+7AMMny7ccOJwH5teJ96D5FCgV/0rRjFziljVmiYd6buOUnwdkBQgD
 5LIht1lMvmxXfiw8zT+GuqkmR4yfsbm3KdbP8JgXGdsYpZk59qKDGACeQLDAFHaR+QmptBTivz4
 /5MAVI84QCy9DWra8JWVL9/tJr4e7zxjl16bxtypq0GfQBzhe7/i6UQt3D7ZmFA74FAMwpy+V2W
 VR/RPXNsvv041VM+YZJfFx+DWb3/ESO1mRSdiafHQUlg44QpQp9GdX9hVEABbLTJSeWYmGM6RkJ
 KnygHq6frfVgKgBYoq9tJT4=
X-Received: by 2002:a05:6a00:6c83:b0:899:915:792b with SMTP id
 d2e1a72fcca58-8a9bfddf73emr6622142b3a.54.1793556336463; 
 Sun, 01 Nov 2026 10:05:36 -0800 (PST)
Received: from tabby-boi ([2a09:bac5:4fad:e6::17:370])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8ac269b8805sm446544b3a.44.2026.11.01.10.05.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Nov 2026 10:05:35 -0800 (PST)
From: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Connor Abbott <cwabbott0@gmail.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
Subject: [PATCH 3/4] drm/msm/a8xx: add a memory-only GPU crash state
Date: Mon,  2 Nov 2026 02:05:07 +0800
Message-ID: <20261101180508.66598-1-nicoangelodelacruz@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
References: <20261101175553.53746-1-nicoangelodelacruz@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 02 Nov 2026 08:03:58 +0000
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

a8xx had no gpu_state_get callback, so no devcoredump was ever
produced when the GPU hung or faulted.

Add a8xx_gpu_state_get(), a memory-only snapshot: the generic Adreno
state from adreno_gpu_state_get() (ring buffer contents and fences,
with rptr read from the hw_apriv shadow rather than a register), the
GMU log/HFI/debug buffers and the HFI queue history. No register is
read, because the GMU may be wedged and GX powered off when this runs
from the recover worker or the SMMU fault path. As a result a8xx
dumps always report "gpu-initialized: 0", as a6xx/a7xx dumps do when
GX is off.

The shared part moves out of a6xx_gpu_state_get() into
a6xx_gpu_state_get_gmu(), which also runs adreno_gpu_state_get().
It is a pure move except for a new gmu_regs parameter that gates
a6xx_get_gmu_registers(); a6xx/a7xx pass true, so their output is
unchanged. Reviewed with git diff --color-moved=dimmed-zebra: apart
from the moved lines, the new code is the helper's signature, the
"if (gmu_regs)" check, the locals the helper needs, and the call.

Tested on an Adreno 830: IGT msm_recovery gpu-fault (6 of 6 runs) and
natural GPU hangs produce dumps with the ringbuffer, gmu-log, gmu-hfi
and queue-history sections; capture takes 1.1 to 4.0 ms.

a6xx/a7xx: build and pure-move review only, Tested-by welcome.

Signed-off-by: Nico Angelo Dela Cruz <nicoangelodelacruz@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c       |  7 +++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h       |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c | 47 ++++++++++++++++-----
 3 files changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 92e8c8abb..0f4b0af0a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2918,9 +2918,16 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.active_ring = a6xx_active_ring,
 		.irq = a8xx_irq,
 		.destroy = a6xx_destroy,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.show = a6xx_show,
+#endif
 		.gpu_busy = a8xx_gpu_busy,
 		.gpu_get_freq = a6xx_gmu_get_freq,
 		.gpu_set_freq = a6xx_gpu_set_freq,
+#if defined(CONFIG_DRM_MSM_GPU_STATE)
+		.gpu_state_get = a8xx_gpu_state_get,
+		.gpu_state_put = a6xx_gpu_state_put,
+#endif
 		.create_vm = a6xx_create_vm,
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 79912a33e..03432abf9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -338,6 +338,7 @@ void a6xx_show(struct msm_gpu *gpu, struct msm_gpu_state *state,
 		struct drm_printer *p);
 
 struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu);
+struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu);
 int a6xx_gpu_state_put(struct msm_gpu_state *state);
 
 void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
index 26c17861c..a3751358a 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu_state.c
@@ -1629,25 +1629,19 @@ static void a7xx_get_indexed_registers(struct msm_gpu *gpu,
 	return;
 }
 
-struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
+static void a6xx_gpu_state_get_gmu(struct msm_gpu *gpu,
+				   struct a6xx_gpu_state *a6xx_state, bool gmu_regs)
 {
-	struct a6xx_crashdumper _dumper = { 0 }, *dumper = NULL;
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-	struct a6xx_gpu_state *a6xx_state = kzalloc_obj(*a6xx_state);
-	bool stalled;
-
-	if (!a6xx_state)
-		return ERR_PTR(-ENOMEM);
-
-	INIT_LIST_HEAD(&a6xx_state->objs);
 
 	/* Get the generic state from the adreno core */
 	adreno_gpu_state_get(gpu, &a6xx_state->base);
 
 	if (!adreno_has_gmu_wrapper(adreno_gpu) &&
 	    !adreno_has_rgmu(adreno_gpu)) {
-		a6xx_get_gmu_registers(gpu, a6xx_state);
+		if (gmu_regs)
+			a6xx_get_gmu_registers(gpu, a6xx_state);
 
 		a6xx_state->gmu_log = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.log);
 		a6xx_state->gmu_hfi = a6xx_snapshot_gmu_bo(a6xx_state, &a6xx_gpu->gmu.hfi);
@@ -1655,6 +1649,21 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 
 		a6xx_snapshot_gmu_hfi_history(gpu, a6xx_state);
 	}
+}
+
+struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
+{
+	struct a6xx_crashdumper _dumper = { 0 }, *dumper = NULL;
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu_state *a6xx_state = kzalloc_obj(*a6xx_state);
+	bool stalled;
+
+	if (!a6xx_state)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&a6xx_state->objs);
+
+	a6xx_gpu_state_get_gmu(gpu, a6xx_state, true);
 
 	/* If GX isn't on the rest of the data isn't going to be accessible */
 	if (!adreno_gpu->funcs->gx_is_on(adreno_gpu))
@@ -1714,6 +1723,24 @@ struct msm_gpu_state *a6xx_gpu_state_get(struct msm_gpu *gpu)
 	return  &a6xx_state->base;
 }
 
+/*
+ * Memory-only snapshot for a8xx: no register is read, as the GMU may be
+ * wedged and GX powered off by the time this runs.
+ */
+struct msm_gpu_state *a8xx_gpu_state_get(struct msm_gpu *gpu)
+{
+	struct a6xx_gpu_state *a6xx_state = kzalloc_obj(*a6xx_state);
+
+	if (!a6xx_state)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&a6xx_state->objs);
+
+	a6xx_gpu_state_get_gmu(gpu, a6xx_state, false);
+
+	return &a6xx_state->base;
+}
+
 static void a6xx_gpu_state_destroy(struct kref *kref)
 {
 	struct a6xx_state_memobj *obj, *tmp;
-- 
2.53.0

