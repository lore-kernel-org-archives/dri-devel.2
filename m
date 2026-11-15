Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887D9606A880
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 20:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g8vDAwNm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7547C10E48E;
	Sun, 15 Nov 2026 20:19:47 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CFB310E1D7;
 Sun, 15 Nov 2026 20:19:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 97DF46250A;
 Sun, 15 Nov 2026 20:19:35 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1794773975;
 b=C/K76IDeanjpZW2hI1ea/yvCttKcTGI5H8QaRw2x16kM8vLZP3OdTOZRN7bK83QejokO
 vNoYsGGGtFp1xLQHrNKUsD0Yvnw3yyLJaNFJex4AEkibiHT3Q/XsI6QRfffxFrL5TonbQ
 uKJPQvys6IHUcdCthXuqgX56yiUHlnTjRfvuF1ha3UMuLkqxTphaFxYm3Se4WVokcUBHZ
 oXgdPJg1OMso7GCmovwYsWxqntG3glL8BKBOCewge1m2i4ZsIQ9JgADv5Se10WOIXvtNV
 osGMFwYVt2w64QFxYdqq2I+meQsMTPmA+3R+NiVmcvxu1I5TtJE5yKWeScvOT12TLig==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1794773975;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=q4IgntDazxo2KddnGYy4M31C62yJDP5JDGNHab2DSxU=;
 b=Mz4lQd9KLWG0Hdr6bzaGikSlIVawI8ajh5/S60K0nlWy3IlbYa8N+0dK2dFTJE4MVI8P
 tWKGvJqBHd+KprBLkbPWcwYW9h3Te2QbrKoREAInhy6rbeJS856IrnJiwRuOuGBhLySGc
 Q5bL/5UHOh6pASl1psyJZBGaSHbjmdyFA9KsupMFDYR/ulTOHRwbSqs5SJW7+E2mb1xlo
 BQLfikB2QMu8Qx+cg0NmJva+o9PaN8II9WzS7VkKLq6kggx0C9HDUZwNk97ZdijXBue8i
 hwaXhhcO01FROCe8hz9+Qc5fQCX6Ggygg4qcfhP/JpN932jqriTVzoyviyOqXY56mOQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 730481F00930;
 Sun, 15 Nov 2026 20:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794773975;
 bh=q4IgntDazxo2KddnGYy4M31C62yJDP5JDGNHab2DSxU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=g8vDAwNmPgd2C6o0SP2NSQ+dLEpgfbSK+QHUq28G4G273wqw5X25jj6MULy+ZTkKZ
 Ym5dyba1WFYeDF9ZTKjUu2yuqBMwqj/vXnDC2AA+bpdzGzjrKOSN7JPoDfOeGucjMO
 SGdVPCD03/Qhpu0pJXRZbAkKqaUMWPxHlFf1GqQt63JMP2/ege4+9mL+LYumivFMlB
 10SWCk3/C1c0ZgrupSvj8f2eE6KYjYrFNW8bmZkHeBO2diT6qCO5VHWlNJxrgD4fKZ
 WutJGLoE0mZjmHArfYvRlcjsdLfhtoGSHZW0c3h1fqYuI06SGW8VGi89neHALDtH19
 p4CQ7Q8BEBm5A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id 037D54A19E;
 Sun, 15 Nov 2026 20:19:34 +0000 (UTC)
From: Venkat Yadlapati via B4 Relay
 <devnull+venkat.yadlapati.yahoo.com@kernel.org>
Date: Mon, 16 Nov 2026 01:49:34 +0530
Subject: [PATCH 2/2] drm/msm/adreno: Add Adreno 829 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-molokai-a829-v1-2-fb3005bfa921@yahoo.com>
References: <20261116-molokai-a829-v1-0-fb3005bfa921@yahoo.com>
In-Reply-To: <20261116-molokai-a829-v1-0-fb3005bfa921@yahoo.com>
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
 linux-kernel@vger.kernel.org, Venkat Yadlapati <venkat.yadlapati@yahoo.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794773972; l=7782;
 i=venkat.yadlapati@yahoo.com; s=20261023; h=from:subject:message-id;
 bh=D20N1/4DcSsehd9i7f6YeYD4O0S37h52fimLuF0CZM0=;
 b=Xv6cO6L8akgb3himKYbdjYphBeUQ4WoaACrqfxWdXzZyy389UhHBQ1xZXtb47SqfUaeMc08p0
 tRc3QPSYMOWDVjBdeiXy0RqKM9jBYQb1OKz+Qn+CkJMzNM8KuzEu/4o
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

Assisted-by: LLM
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
2.56.0


