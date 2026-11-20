Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCA2606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 15:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8Q0JfxD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E703112B9C;
	Fri, 20 Nov 2026 15:53:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D50D10E277;
 Fri, 20 Nov 2026 15:52:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4311E46744;
 Fri, 20 Nov 2026 15:52:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1795189972;
 b=pfbkkzyIHPX7B3EiTLKcfAM2qFYuFewVRRd9JWAH8l5Lcwk9E4eFhIsluklkwlchTDHc
 UxwdV+1SItEmAfNiIsEIJZw3/vhjXfTj7YWWmkZ9m/mDI7f/nK8sGLFo1VAlMIf7xqPUv
 R4xYkXVM4Hs9PIViOdgemKhaTYue3wB8+wJgrRxs5y4Vyl4KugQivPR4c9CYM4MnQogg2
 Q3+PbKkHdNsmWG2tn6C6Nw7Pd5WiyiIHv/wkR8UathBbPlmVrd1V9L89akS4IzKvSAOAM
 X38K9eDmXkAkvkhZmi20spo14b24iGJVvatLv/olZV1s0ceawgDyu14vZhIwJshL5BA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1795189972;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=VC4qyV258udwYJeEWal0u7urGFClu/zmC6JfCNyLnrQ=;
 b=rLnrXHxPvFFckNc7iuH9v4RzqzPSV7Ik+lxGEOWwhJO0R6/lrEhPRQ2xexwJ/0o8MSt6
 UxsqNrtfqyn5QFQbVOTl/MPvDNqNQClZldbsE+dhaplv5H7rjR9TlBzC7AiPxBAasTzZZ
 X9P8QJ4Y7uXg0jmTQDOGcsOC0gw2xGNQcran3LcwV1BVC1Bsjjsx/1p0Rnh+Kad3QsCiq
 YdOkEndbbLLn3/d5E0PivZDvYMKVreUA92l8+sWM4qs3nAZ2p3raHk9c8Fo5Jz/DEVQtd
 yxNRw8n/5gXzDW5xFJ7iEeu3xZl9DDRMYZda9zC1pwRyWFMMqJGMhwl/hbDj+tmXESw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 35CE41F000F0;
 Fri, 20 Nov 2026 15:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795189971;
 bh=VC4qyV258udwYJeEWal0u7urGFClu/zmC6JfCNyLnrQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=V8Q0JfxDGA21oa9gebnR5HmiQGijQYk7i+CZzQWKzJDBSKV0b4/2rxWUCR6vCpGf1
 LwyJ6EAKo0i/hmAUNoAAdF3FN7V1JUb8GlpryWj6Z7huC7khAHJJGfhKPSy7xGaYJ3
 nVpAnZhZaiQt/wiNYRlfKNF2Ht7wi4LFfU7g0eAGxji20m7yiVmZ1A4LUaKyxpKda5
 fpfanxun5ZFyxne5te3AXUgDMORYgTit51k/nXY7w/yH+2A8UJPAQtzarghQFJji0y
 dOMfnWOPFw3M77FoWB5cezbOGlMhuJQYxsXmE+HHireMh4NAozi+vSSGzg9Wxh2Q5g
 OoRSisUzPXTCQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id EAA124992A;
 Fri, 20 Nov 2026 15:52:37 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Fri, 20 Nov 2026 21:22:38 +0530
Subject: [PATCH v2 2/2] drm/msm/adreno: Add Adreno 829 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261120-molokai-a829-v2-2-c63c268d5ab3@yahoo.com>
References: <20261120-molokai-a829-v2-0-c63c268d5ab3@yahoo.com>
In-Reply-To: <20261120-molokai-a829-v2-0-c63c268d5ab3@yahoo.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795189956; l=7967;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=BqP0iWkCUwDgvB1i4/t6//61ObFnD1KDtrfIcRQrNyI=;
 b=89K+sNhIohlSdqsFmxNIoAUhTsIRYwBxl9em+SC0/EpPcvTosr+8jvoAhq7c2ihiQ6SETZY17
 0wSuWTcMAvfBEYfbI5Oa0x8EEiAETg49hl4kJA2i29ziby+VLKZoLHU
X-Developer-Key: i=venkat.yadlapati@yahoo.com; a=ed25519;
 pk=e8KStCtEMvUP1Se/riB/KVnDAQFEVR2Dw2PcuA8/eME=
X-Endpoint-Received: by B4 Relay for venkat.yadlapati@yahoo.com/20261023
 with auth_id=1303
X-Original-From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
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
Reply-To: venkat.yadlapati@yahoo.com
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FORGED_MSGID_YAHOO,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Venkat Yadlapati <venkat.yadlapati@yahoo.com>

Add support for the Adreno 829 (gen8_9_0) found on the Qualcomm Molokai
(SM8845) SoC. It is a two slice variant of the A840: same protected
registers, power-up lists and GBIF settings, but a smaller GMEM
(2432 KiB, hence a different GMEM protection range), its own firmware
and a smaller preemption context record.

Like on the A840, the GPU RSC signals that it is off through bit 30.

The A840 CLX and limits tables are not reused, as their values are not
known to apply to the A829; without them the GMU is not sent a CLX
configuration, like on the other GPUs without these tables.

Signed-off-by: Venkat Yadlapati <venkat.yadlapati@yahoo.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     |   3 +-
 drivers/gpu/drm/msm/adreno/a8xx_catalog.c | 100 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 ++
 3 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 662f09bec9d5..b8d94b2ca227 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -658,7 +658,8 @@ static void a6xx_rpmh_stop(struct a6xx_gmu *gmu)
 	if (!test_and_clear_bit(GMU_STATUS_FW_START, &gmu->status))
 		return;
 
-	if (adreno_is_a840(adreno_gpu) || adreno_is_a850_family(adreno_gpu))
+	if (adreno_is_a829(adreno_gpu) || adreno_is_a840(adreno_gpu) ||
+	    adreno_is_a850_family(adreno_gpu))
 		bitmask = BIT(30);
 
 	gmu_write(gmu, REG_A6XX_GMU_RSCC_CONTROL_REQ, 1);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
index 55a805ab438c..6478849f6c96 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_catalog.c
@@ -840,6 +840,69 @@ static const struct adreno_reglist_pipe a840_nonctxt_regs[] = {
 	{ },
 };
 
+static const struct adreno_reglist_pipe a829_nonctxt_regs[] = {
+	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
+	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0x00200000, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00500000, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	/* Disable Dead Draw Merge scheme on RB-HLSQ */
+	{ REG_A6XX_RB_RBP_CNTL, BIT(5), BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
+	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
+	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x02600000, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
+	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_OVERRIDE, 0x70809060, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_POWER_UP_RESET_SW_BV_OVERRIDE, 0x30000000, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_INTERFACE_HANG_INT_CNTL, 0x0fffffff, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
+	/* Disable mode_switch optimization in UMAS */
+	{ REG_A6XX_SP_CHICKEN_BITS, BIT(24) | BIT(26), BIT(PIPE_NONE) },
+	/* Disable LPAC large-LM mode */
+	{ REG_A8XX_SP_SS_CHICKEN_BITS_0, BIT(3), BIT(PIPE_NONE) },
+	/* Disable PS out of order retire */
+	{ REG_A7XX_SP_CHICKEN_BITS_2, 0x00c21800, BIT(PIPE_NONE) },
+	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
+	/* Disable SP2TP info attribute */
+	{ REG_A8XX_SP_CHICKEN_BITS_4, 0x00000002, BIT(PIPE_NONE) },
+	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
+	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL, BIT(14), BIT(PIPE_NONE) },
+	/* Ignore HLSQ shared constant feedback from SP */
+	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_1, BIT(17), BIT(PIPE_NONE) },
+	/* Disable CS dead batch merge */
+	{ REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_2, BIT(24), BIT(PIPE_NONE) },
+	{ REG_A8XX_SP_HLSQ_DBG_ECO_CNTL_3, BIT(7), BIT(PIPE_NONE) },
+	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080, BIT(PIPE_NONE) },
+	{ REG_A7XX_SP_READ_SEL, 0x0001ff00, BIT(PIPE_NONE) },
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10100000, BIT(PIPE_NONE) },
+	/* BIT(26): Disable final clamp for bicubic filtering */
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000720, BIT(PIPE_NONE) },
+	{ REG_A6XX_UCHE_MODE_CNTL, 0x80080000, BIT(PIPE_NONE) },
+	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
+	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE) },
+	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
+	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
+	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00000020, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ },
+};
+
 static const u32 a840_protect_regs[] = {
 	A6XX_PROTECT_RDONLY(0x00008, 0x039b),
 	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
@@ -1664,6 +1727,43 @@ static const struct adreno_info a8xx_gpus[] = {
 			{ 252, 2 },
 			{ 221, 3 },
 		),
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x44030a00),
+		.family = ADRENO_8XX_GEN2,
+		.fw = {
+			[ADRENO_FW_SQE] = "gen80900_sqe.fw",
+			[ADRENO_FW_GMU] = "gen80900_gmu.bin",
+			[ADRENO_FW_AQE] = "gen80900_aqe.fw",
+		},
+		.gmem = 2432 * SZ_1K,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_PREEMPTION |
+			  ADRENO_QUIRK_IFPC,
+		.funcs = &a8xx_gpu_funcs,
+		.a6xx = &(const struct a6xx_info) {
+			.protect = &a840_protect,
+			.nonctxt_reglist = a829_nonctxt_regs,
+			.pwrup_reglist = &a840_pwrup_reglist,
+			.dyn_pwrup_reglist = &a840_dyn_pwrup_reglist,
+			.ifpc_reglist = &a840_ifpc_reglist,
+			.gbif_cx = a840_gbif,
+			.max_slices = 2,
+			.gmu_chipid = 0x8090000,
+			.bcms = (const struct a6xx_bcm[]) {
+				{ .name = "SH0", .buswidth = 16 },
+				{ .name = "MC0", .buswidth = 4 },
+				{
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(2),
+					.perfmode_bw = 10687500,
+				},
+				{ /* sentinel */ },
+			},
+		},
+		.preempt_record_size = 3708 * SZ_1K,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x44010000),
 		.family = ADRENO_8XX_GEN1,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 4b2156825bdf..af13d4599d0d 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -612,6 +612,11 @@ static inline int adreno_is_x285_family(const struct adreno_gpu *gpu)
 	       gpu->info->chip_ids[0] == 0x44070001;
 }
 
+static inline int adreno_is_a829(struct adreno_gpu *gpu)
+{
+	return gpu->info->chip_ids[0] == 0x44030a00;
+}
+
 static inline int adreno_is_a830(struct adreno_gpu *gpu)
 {
 	return gpu->info->chip_ids[0] == 0x44050001;

-- 
2.56.1


