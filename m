Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28BB4606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PmCAs8AD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628831126F8;
	Fri, 30 Oct 2026 10:05:01 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA8E10E87E;
 Fri, 30 Oct 2026 10:04:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0E14560619;
 Fri, 30 Oct 2026 10:04:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F26F1F00A02;
 Fri, 30 Oct 2026 10:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354689;
 bh=eNr9dnCkIR9pj1WBZtZvQl4J+dfCkPAYIU8zKR6mMjo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=PmCAs8ADe3gd6k1AMqbkC6jqNhWQCHfHZQEBOaduu7zg/vByPpU41OFQGciBE7T2j
 9kEEe4d7zfenXu11R9Ocs0F1Ohkk/TgOOPC49an96wE7l4cE9kZQdJ8dyILN0NytHj
 iL8+tb/dVmrHX7EvktKJC7LYm5LxGoe0lzC8pqzHxYN/uUq0SInU2T0AAMi9D52wFq
 MefFbKoDqZJJc2GBmwvSLmkOxpTx8IWfQPJE740QHY0a7mRfSnstS16JatzkCPzjQy
 QprQByW3XFHWCRdGc2sUPPs3U+ddutV8jSlLD3/+NvD4FRSXb5f8DlSKeY0m1SFVoJ
 2KtPbY6LKviqQ==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 30 Oct 2026 11:04:00 +0100
Subject: [PATCH 4/8] drm/msm/a6xx: Add A6xx IFPC support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-topic-a6xx_ifpc-v1-4-6992841a9a32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793354666; l=7868;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=tzqff6PXIby6DnSjlBute6+JeM8A+PAtyWC2JBC9/rM=;
 b=6GdvVnMyqDYL/4+NC3GRXOYzGvBun8BsYY5ag8FO7inMBIKWO4d1uJ+ZrST1fqLWi5P1coFcj
 HlJCxlrkzJ5Af/aA4ks7VBzAPeNoUkMCYK7T61g/dtLDTIY+Y8M3M1P
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

IFPC is largely supported by the current upstream driver, add the
missing plumbing that's specific to A6xx, based on kgsl.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 97 +++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c             | 11 ++-
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  1 +
 3 files changed, 98 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e7c3da5d3ac6..8ea9ab5b9886 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -647,6 +647,7 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	unsigned int i;
 	u32 cgc_delay, cgc_hyst;
 	u32 val, clock_cntl_on;
+	u32 gmu_wfi_config;
 
 	if (!(adreno_gpu->info->a6xx->hwcg || adreno_is_a7xx(adreno_gpu)))
 		return;
@@ -674,12 +675,20 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	else
 		cgc_hyst = 0x5555;
 
+	/* TODO: Also A620 */
+	if (adreno_is_a640(adreno_gpu) || adreno_is_a650(adreno_gpu))
+		gmu_wfi_config = 0x2;
+	else
+		gmu_wfi_config = 0;
+
 	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL,
 			state ? adreno_gpu->info->a6xx->gmu_cgc_mode : 0);
 	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_DELAY_CNTL,
 			state ? cgc_delay : 0);
 	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_HYST_CNTL,
 			state ? cgc_hyst : 0);
+	gmu_write(&a6xx_gpu->gmu, REG_A6XX_GMU_CX_GMU_WFI_CONFIG,
+			state ? gmu_wfi_config : 0);
 
 	if (!adreno_gpu->info->a6xx->hwcg) {
 		gpu_write(gpu, REG_A7XX_RBBM_CLOCK_CNTL_GLOBAL, 1);
@@ -878,6 +887,43 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
 	a6xx_gpu->dynamic_sel_reglist_offset = dyn_pwrup_reglist_count;
 }
 
+static void a6xx_patch_pwrup_reglist(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	const struct adreno_reglist_list *reglist;
+	void *ptr = a6xx_gpu->pwrup_reglist_ptr;
+	struct cpu_gpu_lock *lock = ptr;
+	u32 *dest = (u32 *)&lock->regs[0];
+	int i;
+
+	lock->gpu_req = lock->cpu_req = lock->turn = 0;
+	lock->list_length = 0;
+
+	/* Static IFPC-only registers */
+	reglist = adreno_gpu->info->a6xx->ifpc_reglist;
+	if (reglist) {
+		for (i = 0; i < reglist->count; i++) {
+			*dest++ = reglist->regs[i];
+			*dest++ = gpu_read(gpu, reglist->regs[i]);
+		}
+		lock->list_length += reglist->count * 2;
+	}
+
+	/* The CP sees IFPC-only and IFPC + preemption as one list from list_offset */
+	lock->list_offset = lock->list_length;
+
+	/* Static IFPC + preemption registers */
+	reglist = adreno_gpu->info->a6xx->pwrup_reglist;
+	if (reglist) {
+		for (i = 0; i < reglist->count; i++) {
+			*dest++ = reglist->regs[i];
+			*dest++ = gpu_read(gpu, reglist->regs[i]);
+		}
+		lock->list_length += reglist->count * 2;
+	}
+}
+
 static int a7xx_preempt_start(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -898,13 +944,43 @@ static int a7xx_preempt_start(struct msm_gpu *gpu)
 	return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
 
+/* Select whether multiple hardware contexts can run at once or are serialized */
+#define CP_INIT_MAX_CONTEXT BIT(0)
+/* Enable register protection mode */
+#define CP_INIT_ERROR_DETECTION_CONTROL BIT(1)
+/* Header dump information, reserved */
+#define CP_INIT_HEADER_DUMP BIT(2)
+/* Default Reset states enabled for PFP and ME */
+#define CP_INIT_DEFAULT_RESET_STATE BIT(3)
+/* Drawcall filter range */
+#define CP_INIT_DRAWCALL_FILTER_RANGE BIT(4)
+/* Ucode workaround masks */
+#define CP_INIT_UCODE_WORKAROUND_MASK BIT(5)
+/* Disable the save/restore of performance counters across preemption. */
+#define CP_INIT_OPERATION_MODE_MASK BIT(6)
+/* Register initialization list */
+#define CP_INIT_REGISTER_INIT_LIST BIT(7)
+/* Register initialization list with spinlock */
+#define CP_INIT_REGISTER_INIT_LIST_WITH_SPINLOCK BIT(8)
+
+#define CP_INIT_MASK (CP_INIT_MAX_CONTEXT | \
+		CP_INIT_ERROR_DETECTION_CONTROL | \
+		CP_INIT_HEADER_DUMP | \
+		CP_INIT_DEFAULT_RESET_STATE | \
+		CP_INIT_UCODE_WORKAROUND_MASK | \
+		CP_INIT_OPERATION_MODE_MASK | \
+		CP_INIT_REGISTER_INIT_LIST_WITH_SPINLOCK)
+
 static int a6xx_cp_init(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = gpu->rb[0];
 
-	OUT_PKT7(ring, CP_ME_INIT, 8);
+	OUT_PKT7(ring, CP_ME_INIT, 10);
 
-	OUT_RING(ring, 0x0000002f);
+	/* Enabled ordinal mask */
+	OUT_RING(ring, CP_INIT_MASK);
 
 	/* Enable multiple hardware contexts */
 	OUT_RING(ring, 0x00000003);
@@ -919,9 +995,12 @@ static int a6xx_cp_init(struct msm_gpu *gpu)
 	/* No workarounds enabled */
 	OUT_RING(ring, 0x00000000);
 
-	/* Pad rest of the cmds with 0's */
-	OUT_RING(ring, 0x00000000);
-	OUT_RING(ring, 0x00000000);
+	/* Operation mode mask */
+	OUT_RING(ring, 0x00000002);
+
+	OUT_RING(ring, lower_32_bits(a6xx_gpu->pwrup_reglist_iova));
+	OUT_RING(ring, upper_32_bits(a6xx_gpu->pwrup_reglist_iova));
+	OUT_RING(ring, 0);
 
 	a6xx_flush(gpu, ring);
 	return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
@@ -1485,8 +1564,12 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Enable the SQE_to start the CP engine */
 	gpu_write(gpu, REG_A6XX_CP_SQE_CNTL, 1);
 
-	if (adreno_is_a7xx(adreno_gpu) && !a6xx_gpu->pwrup_reglist_emitted) {
-		a7xx_patch_pwrup_reglist(gpu);
+	if (!a6xx_gpu->pwrup_reglist_emitted) {
+		if (adreno_is_a7xx(adreno_gpu))
+			a7xx_patch_pwrup_reglist(gpu);
+		else
+			a6xx_patch_pwrup_reglist(gpu);
+
 		a6xx_gpu->pwrup_reglist_emitted = true;
 	}
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 6b34e704a70d..b07ba7233c2e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -855,7 +855,7 @@ static int a6xx_hfi_feature_ctrl_msg(struct a6xx_gmu *gmu, u32 feature, u32 enab
 
 #define IFPC_LONG_HYST 0x1680
 
-static int a6xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
+static int a7xx_hfi_enable_ifpc(struct a6xx_gmu *gmu)
 {
 	if (gmu->idle_level != GMU_IDLE_STATE_IFPC)
 		return 0;
@@ -1059,6 +1059,7 @@ static int a6xx_hfi_start_v1(struct a6xx_gmu *gmu, int boot_state)
 
 int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
 {
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
 	int ret;
 
 	if (gmu->legacy)
@@ -1081,9 +1082,11 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
 	if (ret)
 		return ret;
 
-	ret = a6xx_hfi_enable_ifpc(gmu);
-	if (ret)
-		return ret;
+	if (!adreno_is_a6xx(&a6xx_gpu->base)) {
+		ret = a7xx_hfi_enable_ifpc(gmu);
+		if (ret)
+			return ret;
+	}
 
 	ret = a6xx_hfi_send_thinmem_config(gmu);
 	if (ret)
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index 4f934c194f73..e5fe940d6cbf 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -68,6 +68,7 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x1f82d" name="GMU_CM3_CFG"/>
 	<reg32 offset="0x1f840" name="GMU_CX_GMU_POWER_COUNTER_ENABLE"/>
 	<reg32 offset="0x1fc10" name="GMU_CX_GMU_POWER_COUNTER_ENABLE" variants="A8XX"/>
+	<reg32 offset="0x1f802" name="GMU_CX_GMU_WFI_CONFIG"/>
 	<reg32 offset="0x1f841" name="GMU_CX_GMU_POWER_COUNTER_SELECT_0"/>
 	<reg32 offset="0x1f842" name="GMU_CX_GMU_POWER_COUNTER_SELECT_1"/>
 	<reg32 offset="0x1fc40" name="GMU_CX_GMU_POWER_COUNTER_SELECT_XOCLK_0" variants="A8XX-"/>

-- 
2.56.0

