Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C801606A33B
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6q47jxV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 842B71126F0;
	Fri, 30 Oct 2026 10:05:06 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B4E11126F8;
 Fri, 30 Oct 2026 10:04:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 61741401CA;
 Fri, 30 Oct 2026 10:04:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9A11F0093A;
 Fri, 30 Oct 2026 10:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354695;
 bh=rnaL+kVNjk+qwE0+x2Wn8dzdhiv+lBzw9SM0UVlu+fk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=P6q47jxVKqgySo9Q5bL4IiBAzZ9/QdFzeFepDtWCv1PIUNjdTI1lCgdPBuEVRT0Iu
 brazHJu/htNDZJgYnjsPxImx7CTRzIPJZ29r25ai2lHWB9sICUI9AGsyoH4INs8SuZ
 jF8V25b9zjxiNZawxJ+ZbTsl7NoVEKJubjUN28a4l4YXub33sPBURJ3cvB5bDfiZRO
 ssR1qrpW238CDgGLJvVxBXBPFbG4G2iJs0OPK8bh5RFz3AjIIgm3YI70KlIp1kjH1s
 s8G5PtC1KRunvIK9ojIJzzma+pfC3e5n3fOf9pF05CIkfGKrVn8wrNfXKKO+jSFI9P
 lTXPvftAZOo9A==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 30 Oct 2026 11:04:01 +0100
Subject: [PATCH 5/8] drm/msm/a6xx: Add IFPC tables for Adreno 630
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-topic-a6xx_ifpc-v1-5-6992841a9a32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793354666; l=3631;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=ySe0q2BlYULz/e91t03gJdxsYUc92f50azZxS4CeWCQ=;
 b=Emn+dMfVpxrwIx5QWU8MoKfY59M/lxODetgnkk7eD/Wr+KfIjnfho/m333JooYc97F/GqeLhF
 RJC3Q27N+7SARO+ZFZQ2qDS22kZ4wInFjUDCfhhkJFfZWZ0L/7MovfL
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

Fill out the register tables to enable IFPC on this SKU.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 83 ++++++++++++++++++++++++++++++-
 1 file changed, 82 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 4ef2bd6e7ad2..5e1d91a73a4e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -736,6 +736,84 @@ static const struct adreno_reglist a702_hwcg[] = {
 	{}
 };
 
+static const u32 a630_ifpc_reglist_regs[] = {
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
+};
+
+DECLARE_ADRENO_REGLIST_LIST(a630_ifpc_reglist);
+
+static const u32 a630_pwrup_reglist_regs[] = {
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
+	REG_A6XX_RBBM_VBIF_CLIENT_QOS_CNTL,
+	REG_A6XX_RBBM_PERFCTR_CNTL,
+};
+
+DECLARE_ADRENO_REGLIST_LIST(a630_pwrup_reglist);
+
 static const struct adreno_info a6xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x06010000),
@@ -1014,7 +1092,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_1M,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_4GB_VA,
+			  ADRENO_QUIRK_4GB_VA |
+			  ADRENO_QUIRK_IFPC,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a630_zap.mdt",
@@ -1023,6 +1102,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.protect = &a630_protect,
 			.gmu_cgc_mode = 0x00020202,
 			.prim_fifo_threshold = 0x00180000,
+			.ifpc_reglist = &a630_ifpc_reglist,
+			.pwrup_reglist = &a630_pwrup_reglist,
 		},
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x06040001),

-- 
2.56.0

