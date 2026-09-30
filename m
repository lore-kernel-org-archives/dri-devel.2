Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7389CA5FC5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 06:52:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2641910F57A;
	Thu,  1 Oct 2026 06:52:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NeIzMysu";
	dkim-atps=neutral
Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com
 [74.125.228.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28D1610E116
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 18:38:51 +0000 (UTC)
Received: by mail-pz2-f43.google.com with SMTP id
 d2e1a72fcca58-85469d249c6so3441925b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790793531; x=1791398331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tcLxcO8uIEkG6hV4cv0W1hvR/CfXs/3hY5D6RxZfqyQ=;
 b=NeIzMysukjad6LUCBFqchFSpQuR1b4GB7+Gxqz+vXHnK7z3BEXCtmEI2p14q2M0rRL
 KqkXHhZaqraBOipJca40bc4vyCa6Xz6paMU4/6OmKNWrSPkg+3MrA8wNTbhRb/nmRpOZ
 CzWv4FhyDUCgAHRRgNy2C54W3uiLYRWzMqK53NZjvLr8a39koIpUwFaQLR0YR10yJG0Y
 cZikpm40k0m2bJ29DJLqcBKwfjKmTZC3EUwShxoOgmb3kENFOPstyYWCstQ+XPOM6/Uy
 t0FMNYy2RJ499i749TROc5vr1O14TEH1tkgHAOv+yTOIX7cvf8CYs4Z2i3sR152/K6n4
 BaGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790793531; x=1791398331;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tcLxcO8uIEkG6hV4cv0W1hvR/CfXs/3hY5D6RxZfqyQ=;
 b=1m63pgyMKUT8BF2sI4pJCQD7245lt0pn1FraD/drroSK4Tcx+HVNFs5OQt0d1MxXVO
 AR6UrOxS+QV21H8OcMsdgeW5qqTttr+Tz/2+SAROHDhqVpjaJCxuQDjoVd1Lfp5MrbkP
 SeUZTNrGsEAmGj3NUU38TvfDneaMltrYkeMPQ1X5UpWeGwIsyY/I/qaSGPrRMt4naGol
 jeE9eolvcvUkviU/NrwEIOg6LetGi7hkq3z1siZk2lO/TQ8NWCsRZ61nTtLpnbW49koF
 2yhDOPA/bAskzyC4p2rxk/j9ZAe0mJ13ZjvUhumne10/WKgpz0DdLXIJ4TFRw4ywcr30
 JH2w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpSng9oEAtc2VW7BxDEMLXUkcher7r1KXDwW/xTolTMOOtDLhMc4zNerEk8DmgjSd7/bdoBEpLRxI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mdJDKDVLTiYeDXiIUeNbwT9IfDK9u2xWTcZW77wojGfIX9PFd0
 obK8LbkYAX1di3oleLqvjRkXi88UKUn0q+jVAhBvnDHgRFmjkEZKvisR
X-Gm-Gg: AYBFou11O2LINKDj6vOp79MHt4m8H4iiChNfNP59LbhIFWwf7KeRiqzPuhJ2ZWMdzBK
 g83q2htlHHH6Dzr9RUEHEvsXIMy6JFvgHLCTUDZIpYUMi7oXWLQ2pVFEuM+xIawc1CUr70a7ofv
 tqHimaNIFHbCMdpEN9Gbq+GZVFW4Ep4/o1jbI8olFNxtvXILN2HatcDDr11ncvydq4xpfK1n+Sp
 0wmzDgLFr9LNFKEfNim8DMDBPbI+SUuGloQNeg9rY+LG9jLUmpHPSl19W8GtfU/h61Pbuml/pqj
 dc6+9Wp734yY36NgRC+IgjKJwa08s/REOfSt9DDe04QnxWQ4npojpB445TWbanUZCnn035D1yst
 4HthlVVtQFYjZmSpZIvxx+T5msdp5gLoJYmNJbComeQXOzuu4s2VQ0TEMvTMx/iqV2/5oKTO05M
 nG09wknoc7WdYSq8W8f/zKU0JX0POEL7HdG7F3ggHcPmvSko22lt/ZmnG8/1mxRKwklY2Xsqsup
 5PZ07jPUvDXsf5FBHbSLwfswmoV0g9DIwTefwN8ZJPBReWccl/LmniQIMk82lr9Dt0c/Xvm3O/q
 wmzPGXi2v1nHSFl8hvn3P9NQs8hU0DPMm0w8
X-Received: by 2002:a05:6a21:7001:b0:3d3:aec2:4dcd with SMTP id
 adf61e73a8af0-3de9e6dc7a9mr2517958637.25.1790793530634; 
 Wed, 30 Sep 2026 11:38:50 -0700 (PDT)
Received: from rahuls-x2elite ([157.51.37.69])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc7e539e30esm347997a12.3.2026.09.30.11.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 11:38:49 -0700 (PDT)
From: Rahul Pon <theflyingrahul@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Konrad Dybcio <konradybcio@kernel.org>, Sean Paul <sean@poorly.run>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH msm-next v2] drm/msm/a8xx: report the GMEM size of the active
 slices
Date: Thu,  1 Oct 2026 00:08:39 +0530
Message-ID: <20260930183840.1171-1-theflyingrahul@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 01 Oct 2026 06:52:04 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

A8xx GPUs split GMEM evenly between their slices, and parts can have
slices fused off: a8xx_gpu_get_slice_info() reads the active slice mask
and folds the slice count into the chip ID. The GMEM size reported to
userspace (MSM_PARAM_GMEM_SIZE) is still the catalog value for all
slices, so on a part with fused-off slices userspace would size its
tiles and place its CCU caches past the end of the GMEM that exists.

Qualcomm's downstream driver reports GMEM for the active slices:
gen8_get_gmem_size() in KGSL divides the GMEM size by the number of
physical slices and multiplies it by the number of active ones. Do the
same when reading the slice mask. The GMEM protection and UCHE setup
still cover the full range, as in KGSL.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>
---
Changes in v2:
- Reword the commit message without the device it was found on
- Parenthesize the GMEM expression and keep it on one line
- Link to v1: https://lore.kernel.org/r/20260930111711.1160-1-theflyingrahul@gmail.com

 drivers/gpu/drm/msm/adreno/a8xx_gpu.c   | 3 +++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index add93c1fa0..2f6f36fb8b 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -112,6 +112,9 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	/* Chip ID depends on the number of slices available. So update it */
 	adreno_gpu->chip_id |= FIELD_PREP(GENMASK(7, 4), hweight32(slice_mask));
 
+	/* GMEM is split evenly between slices: report the active share */
+	adreno_gpu->gmem = (adreno_gpu->info->gmem / info->max_slices) * hweight32(slice_mask);
+
 	/* Update the gpu-name to reflect the slice config: */
 	const char *name = devm_kasprintf(dev, GFP_KERNEL,
 			"%"ADRENO_CHIPID_FMT,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 5832dc25d6..dadfe4c694 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -379,7 +379,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = adreno_gpu->info->revn;
 		return 0;
 	case MSM_PARAM_GMEM_SIZE:
-		*value = adreno_gpu->info->gmem;
+		*value = adreno_gpu->gmem;
 		return 0;
 	case MSM_PARAM_GMEM_BASE:
 		if (adreno_gpu->info->family >= ADRENO_6XX_GEN3)
@@ -1205,6 +1205,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	adreno_gpu->funcs = funcs;
 	adreno_gpu->info = config->info;
 	adreno_gpu->chip_id = config->chip_id;
+	adreno_gpu->gmem = config->info->gmem;
 
 	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
 	gpu->pdev = pdev;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 114a40f79e..8e6a881036 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -204,6 +204,8 @@ struct adreno_gpu {
 	struct msm_gpu base;
 	const struct adreno_info *info;
 	uint32_t chip_id;
+	/* GMEM size available to userspace, see a8xx_gpu_get_slice_info(): */
+	uint32_t gmem;
 	uint16_t speedbin;
 	const struct adreno_gpu_funcs *funcs;
 

base-commit: d33622598496c8994c35ba0a8a913de064dfc1a4
-- 
2.53.0

