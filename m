Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D003960A2607
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=i73aYAik
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22C0C1126FC;
	Fri, 30 Oct 2026 10:05:12 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C34B1126F9;
 Fri, 30 Oct 2026 10:05:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5F83743D5A;
 Fri, 30 Oct 2026 10:05:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D744E1F00A16;
 Fri, 30 Oct 2026 10:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354704;
 bh=zs5Q1r6rP4M3nW9zmS+I8v/AXcQ97mITv2VrCDez6vc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=i73aYAikOPfdNlKf951IH6CtoxWLiSQioCbt2XC4WODEmfnH2ysKg87l7yA/3h6Zd
 6BPU+LJf5SqvjnCyQb6FHdrdVIE/T8DaZSXfsv89UaX+IPHYJ+n5Lzoml8D08s4jel
 GFISmzehkvH5wK24lg0Bdv5ARioUk8GzB3EqVXKXeC689Yms9B2AblKtTR7aX3J4sh
 JyerXIrcplCeHK81rSb0ZvcbnZeWWn0iFgbbcDUX7gVJNotioEdclSosGGvFbDg6wH
 /tQ4MNCEK0SdLY6/tMgKHuSNPyy+qYnUddnl3NFKEcyz+HUZynJ97dYJzqQm6k430L
 nrcuhbIyOAKNw==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 30 Oct 2026 11:04:03 +0100
Subject: [PATCH RFT 7/8] drm/msm/a6xx: Add IFPC tables for Adreno 650
 family
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-topic-a6xx_ifpc-v1-7-6992841a9a32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793354666; l=6661;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=W27p5ieY61FQiZHXylnSdOSb9we191DjVUaNV5hwHYc=;
 b=BBE0fWnTzwfVeqkI4CCMzMd+evRCB0/b2ljpj5jwnTrYuAOOnb8Ocl4YjW5k/OqNEgFYqFAyK
 vkswZEaWk0DCOIW9XuDpHWDa9y4izG357VmCpqj0wx6Cahczwydcrrp
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
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Fill out the register tables to enable IFPC on these SKUs.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 122 +++++++++++++++++++++++++++++-
 1 file changed, 118 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 89829fa8f4f4..2d59f7735c90 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -851,6 +851,108 @@ static const u32 a640_pwrup_reglist_regs[] = {
 
 DECLARE_ADRENO_REGLIST_LIST(a640_pwrup_reglist);
 
+/* A650-family IFPC state also includes CP_PROTECT registers 32-47. */
+static const u32 a650_ifpc_reglist_regs[] = {
+	REG_A6XX_CP_CHICKEN_DBG,
+	REG_A6XX_CP_DBG_ECO_CNTL,
+	REG_A6XX_CP_PROTECT_CNTL,
+	REG_A6XX_CP_PROTECT(0),
+	REG_A6XX_CP_PROTECT(1),
+	REG_A6XX_CP_PROTECT(2),
+	REG_A6XX_CP_PROTECT(3),
+	REG_A6XX_CP_PROTECT(4),
+	REG_A6XX_CP_PROTECT(5),
+	REG_A6XX_CP_PROTECT(6),
+	REG_A6XX_CP_PROTECT(7),
+	REG_A6XX_CP_PROTECT(8),
+	REG_A6XX_CP_PROTECT(9),
+	REG_A6XX_CP_PROTECT(10),
+	REG_A6XX_CP_PROTECT(11),
+	REG_A6XX_CP_PROTECT(12),
+	REG_A6XX_CP_PROTECT(13),
+	REG_A6XX_CP_PROTECT(14),
+	REG_A6XX_CP_PROTECT(15),
+	REG_A6XX_CP_PROTECT(16),
+	REG_A6XX_CP_PROTECT(17),
+	REG_A6XX_CP_PROTECT(18),
+	REG_A6XX_CP_PROTECT(19),
+	REG_A6XX_CP_PROTECT(20),
+	REG_A6XX_CP_PROTECT(21),
+	REG_A6XX_CP_PROTECT(22),
+	REG_A6XX_CP_PROTECT(23),
+	REG_A6XX_CP_PROTECT(24),
+	REG_A6XX_CP_PROTECT(25),
+	REG_A6XX_CP_PROTECT(26),
+	REG_A6XX_CP_PROTECT(27),
+	REG_A6XX_CP_PROTECT(28),
+	REG_A6XX_CP_PROTECT(29),
+	REG_A6XX_CP_PROTECT(30),
+	REG_A6XX_CP_PROTECT(31),
+	REG_A6XX_CP_AHB_CNTL,
+	REG_A6XX_CP_PROTECT(32),
+	REG_A6XX_CP_PROTECT(33),
+	REG_A6XX_CP_PROTECT(34),
+	REG_A6XX_CP_PROTECT(35),
+	REG_A6XX_CP_PROTECT(36),
+	REG_A6XX_CP_PROTECT(37),
+	REG_A6XX_CP_PROTECT(38),
+	REG_A6XX_CP_PROTECT(39),
+	REG_A6XX_CP_PROTECT(40),
+	REG_A6XX_CP_PROTECT(41),
+	REG_A6XX_CP_PROTECT(42),
+	REG_A6XX_CP_PROTECT(43),
+	REG_A6XX_CP_PROTECT(44),
+	REG_A6XX_CP_PROTECT(45),
+	REG_A6XX_CP_PROTECT(46),
+	REG_A6XX_CP_PROTECT(47),
+};
+
+DECLARE_ADRENO_REGLIST_LIST(a650_ifpc_reglist);
+
+/* A650-family restore state adds bicubic weights and UCHE_CMDQ_CONFIG. */
+static const u32 a650_pwrup_reglist_regs[] = {
+	REG_A6XX_VSC_ADDR_MODE_CNTL,
+	REG_A6XX_GRAS_ADDR_MODE_CNTL,
+	REG_A6XX_RB_ADDR_MODE_CNTL,
+	REG_A6XX_PC_ADDR_MODE_CNTL,
+	REG_A6XX_HLSQ_ADDR_MODE_CNTL,
+	REG_A6XX_VFD_ADDR_MODE_CNTL,
+	REG_A6XX_VPC_ADDR_MODE_CNTL,
+	REG_A6XX_UCHE_ADDR_MODE_CNTL,
+	REG_A6XX_SP_ADDR_MODE_CNTL,
+	REG_A6XX_TPL1_ADDR_MODE_CNTL,
+	REG_A6XX_UCHE_WRITE_RANGE_MAX,
+	REG_A6XX_UCHE_WRITE_RANGE_MAX + 1,
+	REG_A6XX_UCHE_TRAP_BASE,
+	REG_A6XX_UCHE_TRAP_BASE + 1,
+	REG_A6XX_UCHE_WRITE_THRU_BASE,
+	REG_A6XX_UCHE_WRITE_THRU_BASE + 1,
+	REG_A6XX_UCHE_GMEM_RANGE_MIN,
+	REG_A6XX_UCHE_GMEM_RANGE_MIN + 1,
+	REG_A6XX_UCHE_GMEM_RANGE_MAX,
+	REG_A6XX_UCHE_GMEM_RANGE_MAX + 1,
+	REG_A6XX_UCHE_FILTER_CNTL,
+	REG_A6XX_UCHE_CACHE_WAYS,
+	REG_A6XX_UCHE_MODE_CNTL,
+	REG_A6XX_RB_NC_MODE_CNTL,
+	REG_A6XX_TPL1_NC_MODE_CNTL,
+	REG_A6XX_SP_NC_MODE_CNTL,
+	REG_A6XX_PC_DBG_ECO_CNTL,
+	REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE,
+	REG_A6XX_UCHE_GBIF_GX_CONFIG,
+	REG_A6XX_UCHE_CLIENT_PF,
+	REG_A6XX_RBBM_GBIF_CLIENT_QOS_CNTL,
+	REG_A6XX_RBBM_PERFCTR_CNTL,
+	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(0),
+	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(1),
+	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(2),
+	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(3),
+	REG_A6XX_TPL1_BICUBIC_WEIGHTS_TABLE(4),
+	REG_A6XX_UCHE_CMDQ_CONFIG,
+};
+
+DECLARE_ADRENO_REGLIST_LIST(a650_pwrup_reglist);
+
 static const struct adreno_info a6xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
@@ -1068,7 +1170,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_IFPC,
 		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a620_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
@@ -1077,6 +1180,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00010000,
+			.ifpc_reglist = &a650_ifpc_reglist,
+			.pwrup_reglist = &a650_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0, 0 },
@@ -1180,7 +1285,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_1M + SZ_128K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_IFPC,
 		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a650_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -1189,6 +1295,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020202,
 			.prim_fifo_threshold = 0x00300200,
+			.ifpc_reglist = &a650_ifpc_reglist,
+			.pwrup_reglist = &a650_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0, 0 },
@@ -1207,7 +1315,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_1M + SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_IFPC,
 		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a660_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
@@ -1216,6 +1325,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020000,
 			.prim_fifo_threshold = 0x00300200,
+			.ifpc_reglist = &a650_ifpc_reglist,
+			.pwrup_reglist = &a650_pwrup_reglist,
 		},
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06060300),
@@ -1227,7 +1338,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_1M + SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			ADRENO_QUIRK_HAS_HW_APRIV,
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_IFPC,
 		.funcs = &a6xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.hwcg = a690_hwcg,
@@ -1235,6 +1347,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020200,
 			.prim_fifo_threshold = 0x00300200,
+			.ifpc_reglist = &a650_ifpc_reglist,
+			.pwrup_reglist = &a650_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },

-- 
2.56.0

