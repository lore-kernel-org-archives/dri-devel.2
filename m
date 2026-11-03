Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC9606A326
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 01:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=packett.cool header.i=@packett.cool header.a=rsa-sha256 header.s=key1 header.b=xUB2bOwL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84AFE10E7B1;
	Tue,  3 Nov 2026 01:14:55 +0000 (UTC)
Received: from mta0.migadu.com (out-200.mta0.migadu.com [91.218.175.200])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9AA8D10E75C
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 01:14:48 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=M7KNsVL52+HwE/KuKiYMZJHZOwiCnmNAq9sLJ6hYIck=; 
 c=simple/simple; d=packett.cool;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793668486; v=1; x=1794273286;
 b=xUB2bOwLp5bpr5+F48OHM/aO88IDyrddFUNZWumraqq+lXSZFCWtcTUvWO9cUqnGESwW/rLE
 86VKij2vVZg3zS4PBAziS3DajvdAsGIYQ+KjcqtDhEhkXBb/U8Yo3b333CazpPvf1K9zW9QJSuO
 9LBVhEklEri4L3f4q//7tagVW5yK6nV/wKBnVvUwFhyWfflulQW2tEwufzVKKnevNs0Uo60LDTY
 RIRGCL8ZLmuuU6D/VUTdbT75LrG2MdDDLNwHHiYYNYiVi8F/nI8gPR6L/M1Pm5+ZwJyC+lLrC+N
 evoHqaGct6d9523N4ILc4P9KusSwrgvmQUxSA2sCCId6Q==
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 347836c0883605c2;
 Tue, 03 Nov 2026 01:14:46 +0000
X-Mizu-Trace-ID: 347836c0883605c2
X-Migadu-Flow: FLOW_OUT
From: Val Packett <val@packett.cool>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>
Cc: Val Packett <val@packett.cool>, Maximilian Luz <luzmaximilian@gmail.com>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drm/msm/a6xx: Fix GMEM range on a680
Date: Mon,  2 Nov 2026 22:13:51 -0300
Message-ID: <20261103011358.65398-3-val@packett.cool>
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

On a680, the GMEM range starts at 0, like on newer generations.
Trying to use the 1M value results in texture corruption in Vulkan.
Fix the wrong range by introducing checks specific to this model.

Link: https://gitlab.freedesktop.org/mesa/mesa/-/work_items/15349
Fixes: 4b565ca5a2cb ("drm/msm: Add A6XX device support")
Signed-off-by: Val Packett <val@packett.cool>
---
I have tried adding it to the if (!(..)) condition i.e. not
touching the REG_A6XX_UCHE_GMEM_RANGE_* at all -- that just
made launching gtk4-demo instantly hang the system..

So the only thing that works and solves the issue
is actually writing the zero for the start.
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 7 +++++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 3e4afaa5345f..26440a3ccecb 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -1279,8 +1279,11 @@ static int hw_init(struct msm_gpu *gpu)
 	if (!(adreno_is_a650_family(adreno_gpu) ||
 	      adreno_is_a702(adreno_gpu) ||
 	      adreno_is_a730(adreno_gpu))) {
-		gmem_range_min = (adreno_is_a740_family(adreno_gpu) ||
-				  adreno_is_a722(adreno_gpu)) ? SZ_16M : SZ_1M;
+		gmem_range_min = SZ_1M;
+		if (adreno_is_a740_family(adreno_gpu) || adreno_is_a722(adreno_gpu))
+			gmem_range_min = SZ_16M;
+		else if (adreno_is_a680(adreno_gpu))
+			gmem_range_min = 0;
 
 		/* Set the GMEM VA range [0x100000:0x100000 + gpu->gmem - 1] */
 		gpu_write64(gpu, REG_A6XX_UCHE_GMEM_RANGE_MIN, gmem_range_min);
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index dadfe4c69438..67bd66c78424 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -382,7 +382,8 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = adreno_gpu->gmem;
 		return 0;
 	case MSM_PARAM_GMEM_BASE:
-		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
+		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3 ||
+		    adreno_is_a680(adreno_gpu))
 			*value = 0;
 		else
 			*value = 0x100000;
-- 
2.56.0

