Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144960A260E
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Fq6KzKvC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14EBA1126FD;
	Fri, 30 Oct 2026 10:05:19 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCE8C1126F7;
 Fri, 30 Oct 2026 10:05:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5EEE9605CE;
 Fri, 30 Oct 2026 10:05:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61151F00A15;
 Fri, 30 Oct 2026 10:05:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793354708;
 bh=uXANpd37Cwct/XYEMrUojU13RnTVzqQRUO49MH414bM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=Fq6KzKvC0OSv4kJ8BggJ28ffUYWzBX0hsh4aBDAV2V2dFG4O7vG8Q2dzzqq8pVmpS
 CK+sAs5tIvey4a+irk4a9vA6mGqyv0gcdiEZXWU5rv8wlBoZMBy1S5rG1/ox9SAsUR
 KCBl9qcBw60Ye9iwRBViFbgDVYEHBnnyjWinJ6r+iEv4NXMn7W0dd1ddGXBlrBcpnu
 7uxflcb1UzQ6vnKiL+qywdqSlQN9tyeo4r4JDsefLx1O0iBzsOSkT8d6bt4m5HkYaq
 PdBkooTcfXRWTlA4Tt72snC8JwzBPgbU6zoIaI+d+F7om9OmlU+R3ofu7OBssqS9fD
 v9lodZRSQcv1g==
From: Konrad Dybcio <konradybcio@kernel.org>
Date: Fri, 30 Oct 2026 11:04:04 +0100
Subject: [PATCH RFT 8/8] drm/msm/a6xx: Wire up IFPC on A615-family GPUs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-topic-a6xx_ifpc-v1-8-6992841a9a32@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793354666; l=3728;
 i=konrad.dybcio@oss.qualcomm.com; s=20230215; h=from:subject:message-id;
 bh=7+mQhNOKwZ569zUjyDExjz0WvGK+xLO8MfwYOD29iQ8=;
 b=6mY+eOBczsyZyU4GTHYPtvV31HzVN9slpW2hH7LAey1Vd0cQajYhucnpcJ5bBfcOhYYX4r3qp
 X+0ZEySZfMQC3jcOd9hY2NcOEJP7TVxh1LNWQRn3KOnF3aM2wJJI2FP
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

They reuse the existing tables, so just wire them up.

Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 2d59f7735c90..257771d4eb4d 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1012,7 +1012,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			[ADRENO_FW_GMU] = "a630_gmu.bin",
 		},
 		.gmem = SZ_512K,
-		.quirks = ADRENO_QUIRK_4GB_VA,
+		.quirks = ADRENO_QUIRK_4GB_VA |
+			  ADRENO_QUIRK_IFPC,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a615_zap.mdt",
@@ -1021,6 +1022,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.protect = &a630_protect,
 			.gmu_cgc_mode = 0x00000222,
 			.prim_fifo_threshold = 0x0018000,
+			.ifpc_reglist = &a630_ifpc_reglist,
+			.pwrup_reglist = &a640_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			/*
@@ -1044,7 +1047,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_4GB_VA,
+			  ADRENO_QUIRK_4GB_VA |
+			  ADRENO_QUIRK_IFPC,
 		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a615_zap.mbn",
 		.a6xx = &(const struct a6xx_info) {
@@ -1052,6 +1056,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.protect = &a630_protect,
 			.gmu_cgc_mode = 0x00000222,
 			.prim_fifo_threshold = 0x00180000,
+			.ifpc_reglist = &a630_ifpc_reglist,
+			.pwrup_reglist = &a640_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
@@ -1071,12 +1077,15 @@ static const struct adreno_info a6xx_gpus[] = {
 		.gmem = SZ_512K,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_4GB_VA,
+			  ADRENO_QUIRK_4GB_VA |
+			  ADRENO_QUIRK_IFPC,
 		.funcs = &a6xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a630_protect,
 			.gmu_cgc_mode = 0x00000222,
 			.prim_fifo_threshold = 0x00180000,
+			.ifpc_reglist = &a630_ifpc_reglist,
+			.pwrup_reglist = &a640_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
@@ -1102,6 +1111,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.protect = &a630_protect,
 			.gmu_cgc_mode = 0x00000222,
 			.prim_fifo_threshold = 0x00018000,
+			.ifpc_reglist = &a630_ifpc_reglist,
+			.pwrup_reglist = &a640_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
@@ -1127,6 +1138,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.protect = &a630_protect,
 			.gmu_cgc_mode = 0x00000222,
 			.prim_fifo_threshold = 0x00018000,
+			.ifpc_reglist = &a630_ifpc_reglist,
+			.pwrup_reglist = &a640_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },
@@ -1143,7 +1156,8 @@ static const struct adreno_info a6xx_gpus[] = {
 		},
 		.gmem = SZ_512K,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_4GB_VA,
+			  ADRENO_QUIRK_4GB_VA |
+			  ADRENO_QUIRK_IFPC,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a615_zap.mdt",
@@ -1152,6 +1166,8 @@ static const struct adreno_info a6xx_gpus[] = {
 			.protect = &a630_protect,
 			.gmu_cgc_mode = 0x00000222,
 			.prim_fifo_threshold = 0x00018000,
+			.ifpc_reglist = &a630_ifpc_reglist,
+			.pwrup_reglist = &a640_pwrup_reglist,
 		},
 		.speedbins = ADRENO_SPEEDBINS(
 			{ 0,   0 },

-- 
2.56.0

