Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27631606A329
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=Cj3zBLG3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7583410E758;
	Tue,  3 Nov 2026 01:15:07 +0000 (UTC)
Received: from mta1.migadu.com (out-197.mta1.migadu.com [95.215.58.197])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1999B10E75F
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:15:00 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=lNXLLbEeqUH/mMzBqqTzZLUvl7muWrYcqXhU83WuGQQ=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793668499; v=1; x=1794273299;
 b=Cj3zBLG3TVxip4THiBIwb61+V/bnfqEp0vHlUZYBLDaEL3MA9lJ3Nl0iY/FxZK0/7wtFxYQ6
 CbyxOPShG1Ug4zKaGJcdgZzkGU4hPDid5I7WxMXIiU3RqJFF0GiwGc7fsYakO44jUvTVSluslfk
 b8ln7i2Z+2bUg6CVFLZ2CyXuJRZWG+6PAD5p7NV4fIfKUDRHloF//dTxVSOsVJ18ScbgPTYBvOA
 BrcEK2NXrkwbTYhi6qAVx/i7ncSgIdWtPcvdu9Uw6CM0phH46veQI2wM+OG9PIQYR52IfH4E+wz
 o5JmopsqjRkgOuiPD/HmNCnB8pB+EhmyveiOG+PIFTwpw==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 6eebfda754537df2;
 Tue, 03 Nov 2026 01:14:58 +0000
X-Mizu-Trace-ID: 6eebfda754537df2
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Val Packett <val@packett.cool>, Maximilian Luz <luzmaximilian@gmail.com>,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] drm/msm/a6xx: Import a680 hwcg sequence from kgsl
Date: Mon,  2 Nov 2026 22:13:53 -0300
Message-ID: <20261103011358.65398-5-val@packett.cool>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103011358.65398-1-val@packett.cool>
References: <20261103011358.65398-1-val@packett.cool>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The initialization sequence for a680 differs from a640 in a few places.
Match downstream by using this a680 specific one.

Signed-off-by: Val Packett <val@packett.cool>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 56 ++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 6c154792cb07..48197a54984c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -9,6 +9,7 @@
 #include "adreno_gpu.h"
 #include "a6xx_gpu.h"
 #include "a6xx.xml.h"
+#include "a6xx_gmu.xml.h"
 
 static const struct adreno_reglist a612_hwcg[] = {
 	{REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x22222222},
@@ -449,6 +450,59 @@ static const struct adreno_reglist a660_hwcg[] = {
 	{},
 };
 
+static const struct adreno_reglist a680_hwcg[] = {
+	{REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x02222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220},
+	{REG_A6XX_RBBM_CLOCK_DELAY_SP0, 0x00000080},
+	{REG_A6XX_RBBM_CLOCK_HYST_SP0, 0x0000F3CF},
+	{REG_A6XX_RBBM_CLOCK_CNTL_TP0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL2_TP0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL3_TP0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL4_TP0, 0x00022222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_TP0, 0x11111111},
+	{REG_A6XX_RBBM_CLOCK_DELAY2_TP0, 0x11111111},
+	{REG_A6XX_RBBM_CLOCK_DELAY3_TP0, 0x11111111},
+	{REG_A6XX_RBBM_CLOCK_DELAY4_TP0, 0x00011111},
+	{REG_A6XX_RBBM_CLOCK_HYST_TP0, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST2_TP0, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST3_TP0, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST4_TP0, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_CNTL_RB0, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_CNTL2_RB0, 0x01002222},
+	{REG_A6XX_RBBM_CLOCK_CNTL_CCU0, 0x00002220},
+	{REG_A6XX_RBBM_CLOCK_HYST_RB_CCU0, 0x00040F00},
+	{REG_A6XX_RBBM_CLOCK_CNTL_RAC, 0x05222022},
+	{REG_A6XX_RBBM_CLOCK_CNTL2_RAC, 0x00005555},
+	{REG_A6XX_RBBM_CLOCK_DELAY_RAC, 0x00000011},
+	{REG_A6XX_RBBM_CLOCK_HYST_RAC, 0x00445044},
+	{REG_A6XX_RBBM_CLOCK_CNTL_TSE_RAS_RBBM, 0x04222222},
+	{REG_A6XX_RBBM_CLOCK_MODE_VFD, 0x00002222},
+	{REG_A6XX_RBBM_CLOCK_MODE_GPC, 0x00222222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_HLSQ_2, 0x00000002},
+	{REG_A6XX_RBBM_CLOCK_MODE_HLSQ, 0x00002222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_TSE_RAS_RBBM, 0x00004000},
+	{REG_A6XX_RBBM_CLOCK_DELAY_VFD, 0x00002222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_GPC, 0x00000200},
+	{REG_A6XX_RBBM_CLOCK_DELAY_HLSQ, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST_TSE_RAS_RBBM, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST_VFD, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_HYST_GPC, 0x04104004},
+	{REG_A6XX_RBBM_CLOCK_HYST_HLSQ, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_CNTL_UCHE, 0x22222222},
+	{REG_A6XX_RBBM_CLOCK_HYST_UCHE, 0x00000004},
+	{REG_A6XX_RBBM_CLOCK_DELAY_UCHE, 0x00000002},
+	{REG_A6XX_RBBM_CLOCK_CNTL, 0x8AA8AA82},
+	{REG_A6XX_RBBM_ISDB_CNT, 0x00000182},
+	{REG_A6XX_RBBM_RAC_THRESHOLD_CNT, 0x00000000},
+	{REG_A6XX_RBBM_SP_HYST_CNT, 0x00000000},
+	{REG_A6XX_RBBM_CLOCK_CNTL_GMU_GX, 0x00000222},
+	{REG_A6XX_RBBM_CLOCK_DELAY_GMU_GX, 0x00000111},
+	{REG_A6XX_RBBM_CLOCK_HYST_GMU_GX, 0x00000555},
+	{REG_A6XX_GMU_GX_GMU_SP_RF_CONTROL_0, 0x00000001},
+	{REG_A6XX_GMU_GX_GMU_SP_RF_CONTROL_1, 0x00000001},
+	{},
+};
+
 static const struct adreno_reglist a690_hwcg[] = {
 	{REG_A6XX_RBBM_CLOCK_CNTL_SP0, 0x02222222},
 	{REG_A6XX_RBBM_CLOCK_CNTL2_SP0, 0x02222220},
@@ -1163,7 +1217,7 @@ static const struct adreno_info a6xx_gpus[] = {
 		.funcs = &a6xx_gpu_funcs,
 		.zapfw = "a640_zap.mdt",
 		.a6xx = &(const struct a6xx_info) {
-			.hwcg = a640_hwcg,
+			.hwcg = a680_hwcg,
 			.protect = &a630_protect,
 			.gbif_cx = a640_gbif,
 			.gmu_cgc_mode = 0x00020202,
-- 
2.56.0

