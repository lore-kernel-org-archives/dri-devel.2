Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F483606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 02:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W5V9Ko5T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C58610F1BF;
	Tue, 20 Oct 2026 02:05:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B6E10EB54;
 Tue, 20 Oct 2026 02:05:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E50E143E83;
 Tue, 20 Oct 2026 02:05:11 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792461911;
 b=HJmHi9I1ZO7Q48qZliS5qErV2xyV8wstjwn6xzaMht1gzwE5IZRIg9yP8dcH672lf/GJ
 nDrh3I39obeDafUoQfD7rJ7FxZN0ROc4m2+1HK0pGIxg04X2Gz2yNDbGy5S/rgp1oHHPj
 9aG9xXi8jAtef0veLgEQSaKnot8dR3saEFPy5Me3NvPFaCGxgz7MLT3h1jmNemzZLXbYR
 uJDUTyTlBwAAmmBQinMrTlkDYTZXyHHuNBaE7zzTGDxsTED1cYa+B6GbeoHWatbeAiFGa
 zRuut9k0TmjzgMuAJ/+bGKeE7IZVs+oTDuv4dIXI7CZu4Nb+X1mg/N2tqjNMQjOlhHw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792461911;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=eJQuOexEgpdk7VwVX4QrR7l6/dOu2j4nAC9tnG/f0sw=;
 b=UeG+slfU276rdsDo4I/NVD67RKi+rZLtTYmylymavO0ktY4D7m5Bi7pY2sTdZV/5icw9
 ueE2YYfhQ8YAGxH02Pk4EFnfXyvnsUeq3+tmUjki1dbBUSe3nGGFLLXYzExGYyyvlkD50
 4F8PkyqCLV1V5P0Bykccs9tYKtS9IkCkkFyrzagTpqCbXeLSWAuSYIYwJgqvzDuRft4Te
 NfyiINcRGftgBPMvLmLahtLKnEhC7mpkP1o+3WN1sjT/5zhucaa/msVzq6uStA+A7LfGt
 mC7yk7UIKjn5ztdpXdJFFnGclcme7mEYq84a7RMpq9CBcD/bnnpkU5frIJQVdTKODQg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id B80EA1F000C6;
 Tue, 20 Oct 2026 02:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792461911;
 bh=eJQuOexEgpdk7VwVX4QrR7l6/dOu2j4nAC9tnG/f0sw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=W5V9Ko5THN8vDZ/KJYXKW830lz0O5+6hwDRyN8+NyzLt8Nf1FhgaTK4/f4lSqWmwC
 eyK0LURrhS2iIX98fwitNfqSP5fQ/6wHBmGcHDuTjNGdvimmmKIj5YbTl8/kwmbyPJ
 aE1hUS6Z7SbBuI7SRfcRYGVw9B9kqpDSKbSY4TDRS6FkFyb1Ie2b9AmvI7LVrQmvoG
 2adeEBCSO9ogVga8fG/l9T/9m4O4QS+4e6NETNBccVrCnGTDk2tz2KprCxKkS3HZHW
 QtBQfPwRTp1RNMrlzZjZNO4J0U+F4CAScS8LuSSMeVgVRs37scuwPz/Vc6TcTg6RBb
 j2jYjanbv37sQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 2FE1F406E6;
 Tue, 20 Oct 2026 02:05:10 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Mon, 19 Oct 2026 23:05:09 -0300
Subject: [PATCH v2 2/3] drm/msm/a5xx: Hold a CPU latency request while the
 GPU is powered
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261019-a5xx-gpu-pm-v2-2-457aafbb28da@gmail.com>
References: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
In-Reply-To: <20261019-a5xx-gpu-pm-v2-0-457aafbb28da@gmail.com>
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
 Paul Sajna <sajattack@postmarketos.org>, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792461909; l=6502;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=EOivWPqxZYU9wVSqYSPUS5LvXLSkjIEIuto/5ol8fAU=;
 b=ZiPqZ7Fk8gHeLgFtb03089QCefhaqFo8hVu0a7xe4WSh2VOogHyGFl/dSQ+WK+QUtcm2v6t4U
 tYeE8tMY71KDR1Qek/oj9sLElzsEL5ZwXUcMLeG9YBIFYcTW38Wo7lw
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Content-Transfer-Encoding: 7bit
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
Reply-To: fabricioakio@gmail.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-24.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Fabricio Akio <fabricioakio@gmail.com>

On SDM630 the GPU was observed to stop executing while the SoC is in
system-level power collapse, and to continue once the SoC wakes. Its
interrupts have no wakeup route through the MPM, so it cannot wake the
SoC itself. A submission overlapping such a state would stall until a
CPU wakes, and a stall longer than the hang detector's threshold makes
the driver recover the GPU, which can lose a frame.

Qualcomm's downstream driver holds a CPU latency request while the GPU
is active, qcom,pm-qos-active-latency, which keeps the CPU idle
governors out of cluster and system-level power collapse. Do the same:
take the request when the GPU resumes and drop it when it suspends, so
those states remain available once the GPU has gone idle, and on
destroy, which unbind reaches even when suspending the GPU failed. The
limit is a per-GPU catalog value, downstream's for each SoC: 424 us
for the A508 in SDM630, and 518 us for the A509 in SDM636 and the A512
in SDM660.

Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
The values are downstream's CPU latency while the GPU is active, per
SoC:
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm630-gpu.dtsi#L117
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm660-gpu.dtsi#L126
SDM636 takes SDM660's by including sdm660.dtsi:
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/arch/arm/boot/dts/qcom/sdm636.dtsi#L13
Downstream reads it at probe, applies it when the GPU starts and drops
it when the GPU slumbers:
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno.c#L887
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno.c#L1451
https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/kgsl_pwrctrl.c#L2753

The A509 and A512 values are downstream's for SDM636 and SDM660;
tested on an A508 only.
---
 drivers/gpu/drm/msm/adreno/a5xx_catalog.c |  3 +++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 13 +++++++++++++
 drivers/gpu/drm/msm/adreno/a5xx_gpu.h     |  4 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  5 +++++
 4 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
index babd320f3b73..7b261f045eae 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_catalog.c
@@ -55,6 +55,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		 * the GDSC which appears to make it grumpy
 		 */
 		.inactive_period = 250,
+		.cpu_latency_us = 424,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
 		.funcs = &a5xx_gpu_funcs,
 		.zapfw = "a508_zap.mdt",
@@ -72,6 +73,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		 * the GDSC which appears to make it grumpy
 		 */
 		.inactive_period = 250,
+		.cpu_latency_us = 518,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
 		.funcs = &a5xx_gpu_funcs,
 		/* Adreno 509 uses the same ZAP as 512 */
@@ -105,6 +107,7 @@ static const struct adreno_info a5xx_gpus[] = {
 		 * the GDSC which appears to make it grumpy
 		 */
 		.inactive_period = 250,
+		.cpu_latency_us = 518,
 		.quirks = ADRENO_QUIRK_LMLOADKILL_DISABLE,
 		.funcs = &a5xx_gpu_funcs,
 		.zapfw = "a512_zap.mdt",
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 0aff8252a00f..1d4993f8cb7c 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1060,6 +1060,10 @@ static void a5xx_destroy(struct msm_gpu *gpu)
 		drm_gem_object_put(a5xx_gpu->shadow_bo);
 	}
 
+	/* Still held if suspending the GPU failed before it was destroyed */
+	if (cpu_latency_qos_request_active(&a5xx_gpu->pm_qos_req))
+		cpu_latency_qos_remove_request(&a5xx_gpu->pm_qos_req);
+
 	adreno_gpu_cleanup(adreno_gpu);
 	kfree(a5xx_gpu);
 }
@@ -1360,6 +1364,7 @@ static void a5xx_dump(struct msm_gpu *gpu)
 static int a5xx_pm_resume(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a5xx_gpu *a5xx_gpu = to_a5xx_gpu(adreno_gpu);
 	int ret;
 
 	/* Turn on the core power */
@@ -1367,6 +1372,11 @@ static int a5xx_pm_resume(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
+	if (adreno_gpu->info->cpu_latency_us &&
+	    !cpu_latency_qos_request_active(&a5xx_gpu->pm_qos_req))
+		cpu_latency_qos_add_request(&a5xx_gpu->pm_qos_req,
+					    adreno_gpu->info->cpu_latency_us);
+
 	/*
 	 * The GX power domain is not necessarily switched off while we are
 	 * suspended: on SDM630, SDM660 and MSM8998 it follows the GPU's SMMU
@@ -1450,6 +1460,9 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
 	if (ret)
 		return ret;
 
+	if (cpu_latency_qos_request_active(&a5xx_gpu->pm_qos_req))
+		cpu_latency_qos_remove_request(&a5xx_gpu->pm_qos_req);
+
 	if (a5xx_gpu->has_whereami)
 		for (i = 0; i < gpu->nr_rings; i++)
 			a5xx_gpu->shadow[i] = 0;
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
index fb05f1ca3e81..07a36c05be25 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.h
@@ -4,6 +4,8 @@
 #ifndef __A5XX_GPU_H__
 #define __A5XX_GPU_H__
 
+#include <linux/pm_qos.h>
+
 #include "adreno_gpu.h"
 
 /* Bringing over the hack from the previous targets */
@@ -48,6 +50,8 @@ struct a5xx_gpu {
 
 	/* True if the microcode supports the WHERE_AM_I opcode */
 	bool has_whereami;
+
+	struct pm_qos_request pm_qos_req;
 };
 
 #define to_a5xx_gpu(x) container_of(x, struct a5xx_gpu, base)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 4b2156825bdf..fcc382f4a9a1 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -118,6 +118,11 @@ struct adreno_info {
 	const struct adreno_gpu_funcs *funcs;
 	const char *zapfw;
 	u32 inactive_period;
+	/**
+	 * @cpu_latency_us: CPU latency limit to hold while the GPU is
+	 * powered, in microseconds, or 0 for none
+	 */
+	u32 cpu_latency_us;
 	union {
 		const struct a6xx_info *a6xx;
 	};

-- 
2.56.0


