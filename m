Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10017606A31F
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FCPb1mPN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 494051126F5;
	Fri, 30 Oct 2026 10:04:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0BAC31126F2;
 Fri, 30 Oct 2026 10:04:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E88FF404F6;
 Fri, 30 Oct 2026 10:04:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3795E1F00A02;
 Fri, 30 Oct 2026 10:04:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354684;
 bh=2Km72riBSxbB78ZLWTvdk5C/oNGGA8nwjAjVFneM95Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=FCPb1mPNobjkY5vELG7orR/HMCbSFjB/biiI52tJv0j694wfZVksoQl+m4EW9OlFd
 OQZ6B2sYzvXJxiIiiPPTE+tCS6tE+2UxLSK9vINyGnQmxgZaLqtScnYKT18Qa8Qyfc
 e8lTjCM/NMNp2hI9xokY5ib4cs/dXubBPokUEX7EpU4DC+m+OI6i5pBZJl2YluQ2Y7
 TZ3+4LztiMbfTIh8C4rIPLhOVqC+huScsQ2KCl7sU032USK0NrOvMowearFL7sQSGu
 JsVRx8fKAAklFaJ3dwOV3Xn1hgsqndf9vXMhSfyNo9HUNR9Q4+lOee8rpyQ1srfv/N
 6iJoQ4ptK7N7A==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 30 Oct 2026 11:03:59 +0100
Subject: [PATCH 3/8] drm/msm/a6xx: Expose GMU IFPC entry count in debugfs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-topic-a6xx_ifpc-v1-3-6992841a9a32@oss.qualcomm.com>
References: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
In-Reply-To: <20261030-topic-a6xx_ifpc-v1-0-6992841a9a32@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793354666; l=6722;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=0aOndrWHEh4zmhYvnE2Brc3+1iBno8gF1nV/vdEKIg8=;
 b=ZGf0PjmtGTpEi37/Ql36ujTyjuCBH7+uD5vtcWnN0RneNAXSlzsZLiM2fzjaZkGMPVrgvbTA1
 sjsUNkhMhFsAd6V17WTmaNE2mNp2ICVg+rtRFNxXL1wPUWfNh4ZxQJV
X-Developer-Key: i=konrad.dybcio@oss.qualcomm.com; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Add a read-only debugfs file, ifpc_count, that reports how many times
the GMU has entered IFPC.

The count is accumulated from the GMU XOCLK_4 power counter. The
counter is selected in hw_init, and the delta is folded into the total
from the busy callback, so the value advances whenever devfreq samples
the GPU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile              |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_debugfs.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     | 30 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     | 10 ++++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  9 +++++++++
 5 files changed, 73 insertions(+)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 1e246616f83f..afd42e5bda00 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -30,6 +30,7 @@ adreno-y := \
 	adreno/a8xx_preempt.o \
 
 adreno-$(CONFIG_DEBUG_FS) += adreno/a5xx_debugfs.o \
+	adreno/a6xx_debugfs.o \
 
 adreno-$(CONFIG_DRM_MSM_GPU_STATE)	+= adreno/a6xx_gpu_state.o
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_debugfs.c b/drivers/gpu/drm/msm/adreno/a6xx_debugfs.c
new file mode 100644
index 000000000000..a3f622cb189f
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a6xx_debugfs.c
@@ -0,0 +1,23 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/types.h>
+#include <linux/debugfs.h>
+
+#include <drm/drm_file.h>
+
+#include "a6xx_gpu.h"
+
+void a6xx_debugfs_init(struct msm_gpu *gpu, struct drm_minor *minor)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+
+	if (!minor)
+		return;
+
+	if (!(adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC))
+		return;
+
+	debugfs_create_u32("ifpc_count", 0444, minor->debugfs_root,
+			   &a6xx_gpu->ifpc_count);
+}
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 48d3ee4d55d9..e7c3da5d3ac6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1338,6 +1338,11 @@ static int hw_init(struct msm_gpu *gpu)
 			GENMASK(7, 0), 0x4);
 	}
 
+	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC) {
+		a6xx_gpu->ifpc_counter_last =
+			gmu_read(&a6xx_gpu->gmu, REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L);
+	}
+
 	/* Select CP0 to always count cycles */
 	gpu_write(gpu, REG_A6XX_CP_PERFCTR_CP_SEL(0), PERF_CP_ALWAYS_COUNT);
 
@@ -2334,6 +2339,17 @@ static void a6xx_destroy(struct msm_gpu *gpu)
 	kfree(a6xx_gpu);
 }
 
+void a6xx_ifpc_count_update(struct a6xx_gpu *a6xx_gpu, u32 cur)
+{
+	/* A counter below the last sample means the GMU restarted it */
+	if (cur >= a6xx_gpu->ifpc_counter_last)
+		a6xx_gpu->ifpc_count += cur - a6xx_gpu->ifpc_counter_last;
+	else
+		a6xx_gpu->ifpc_count += cur;
+
+	a6xx_gpu->ifpc_counter_last = cur;
+}
+
 static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -2347,6 +2363,11 @@ static u64 a6xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
 			REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L,
 			REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
 
+	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC)
+		a6xx_ifpc_count_update(a6xx_gpu,
+			gmu_read(&a6xx_gpu->gmu,
+				 REG_A6XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L));
+
 	return busy_cycles;
 }
 
@@ -2818,6 +2839,9 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 #if defined(CONFIG_DRM_MSM_GPU_STATE)
 		.gpu_state_get = a6xx_gpu_state_get,
 		.gpu_state_put = a6xx_gpu_state_put,
+#endif
+#if defined(CONFIG_DEBUG_FS)
+		.debugfs_init = a6xx_debugfs_init,
 #endif
 		.create_vm = a6xx_create_vm,
 		.create_private_vm = a6xx_create_private_vm,
@@ -2889,6 +2913,9 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 #if defined(CONFIG_DRM_MSM_GPU_STATE)
 		.gpu_state_get = a6xx_gpu_state_get,
 		.gpu_state_put = a6xx_gpu_state_put,
+#endif
+#if defined(CONFIG_DEBUG_FS)
+		.debugfs_init = a6xx_debugfs_init,
 #endif
 		.create_vm = a6xx_create_vm,
 		.create_private_vm = a6xx_create_private_vm,
@@ -2921,6 +2948,9 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.gpu_busy = a8xx_gpu_busy,
 		.gpu_get_freq = a6xx_gmu_get_freq,
 		.gpu_set_freq = a6xx_gpu_set_freq,
+#if defined(CONFIG_DEBUG_FS)
+		.debugfs_init = a6xx_debugfs_init,
+#endif
 		.create_vm = a6xx_create_vm,
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 79912a33e17c..8f0cb168a535 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -139,6 +139,10 @@ struct a6xx_gpu {
 	spinlock_t aperture_lock;
 
 	u32 slice_mask;
+
+	/* Total GMU IFPC entries, accumulated from the XOCLK_4 counter */
+	u32 ifpc_count;
+	u32 ifpc_counter_last;
 };
 
 #define to_a6xx_gpu(x) container_of(x, struct a6xx_gpu, base)
@@ -254,6 +258,12 @@ struct a7xx_cp_smmu_info {
 #define A6XX_PROTECT_RDONLY(_reg, _len) \
 	((((_len) & 0x3FFF) << 18) | ((_reg) & 0x3FFFF))
 
+#ifdef CONFIG_DEBUG_FS
+void a6xx_debugfs_init(struct msm_gpu *gpu, struct drm_minor *minor);
+#endif
+
+void a6xx_ifpc_count_update(struct a6xx_gpu *a6xx_gpu, u32 cur);
+
 extern const struct adreno_gpu_funcs a6xx_gpu_funcs;
 extern const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs;
 extern const struct adreno_gpu_funcs a7xx_gpu_funcs;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index f892731cd3d3..ba81a1c9c551 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -680,6 +680,10 @@ static int hw_init(struct msm_gpu *gpu)
 	gmu_write(&a6xx_gpu->gmu, REG_A8XX_GMU_CX_GMU_POWER_COUNTER_SELECT_XOCLK_1,
 		  FIELD_PREP(GENMASK(7, 0), 0x4));
 
+	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC)
+		a6xx_gpu->ifpc_counter_last =
+			gmu_read(gmu, REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L);
+
 	/* Select CP0 to always count cycles */
 	gpu_write(gpu, REG_A8XX_CP_PERFCTR_CP_SEL(0), 1);
 
@@ -1354,6 +1358,11 @@ u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
 			REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_L,
 			REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_0_H);
 
+	if (adreno_gpu->info->quirks & ADRENO_QUIRK_IFPC)
+		a6xx_ifpc_count_update(a6xx_gpu,
+			gmu_read(&a6xx_gpu->gmu,
+				 REG_A8XX_GMU_CX_GMU_POWER_COUNTER_XOCLK_4_L));
+
 	return busy_cycles;
 }
 

-- 
2.56.0

