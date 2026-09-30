Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE1CA5FBE
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 12:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E516E10F36A;
	Wed, 30 Sep 2026 12:13:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rCY3f86Y";
	dkim-atps=neutral
Received: from mail-dl2-f42.google.com (mail-dl2-f42.google.com
 [74.125.229.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A226810F2F6
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 11:17:23 +0000 (UTC)
Received: by mail-dl2-f42.google.com with SMTP id
 a92af1059eb24-144efd1ea76so3102498c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 04:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790767043; x=1791371843; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=O8c6J6a8XxfczhTmsOGt/U+Fg7+WNxgVu0l55UiDc6U=;
 b=rCY3f86YxWsCrA7lZyAfJow6Sw/TDhDU/Yzt++CfSUUgGeR+3dcGQX6ESq8nfv8YHJ
 5V/aasaJC2C2ESaXObDGi9F8Q/ZI5a4FrYhHSNnlwlHu0NsrvUJlLSvKYH8uz0fxvtcU
 DXKX0I6uD06fHVX8ipQmsNYMZDMahQ+fsLURxxDi7iuVRobiYoSFPxzVuhzeK22OqSLK
 WVVuepoA269e2a8/Vxb/C39HELS7+XsXnTanVic/k+00iVm2ysY4S8dYQBkODvroU2Wu
 xNmrkmgLwiGWBjPpzNEJvAAQOQGONbXthnA5ow50zNT1OYtZQb8aJANQZKO3GmAkWlFx
 bhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790767043; x=1791371843;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=O8c6J6a8XxfczhTmsOGt/U+Fg7+WNxgVu0l55UiDc6U=;
 b=kdI94UPCkNrfRghVmBcf1KRlyMv3KBrystspCeH7HbkXgd0BtzZQz+nUQl5Dy3nnCV
 c2OkPEyH//B/xQJ9q6G899l/DmAUJ4pHBfwrlk1wqPpOFtXMHeQ9o4xmidSE+HjIt1iX
 SkxSrgTkEH+v52+5+XkzSVz/TOJn+qvuCPeIAW6QafIdJ2bBjGX1qL5NJAWssNefcob4
 iflOx6muT8iI1knyOvSmR+m60Z5da6IC2MG9J/DdAwaPAzK9XGRFyR9b7yxIuqVvSqYl
 PtvErde7ufHCXSw9GYALK9gGbcsugFcakz5pmlZr/YERNRkZqvvIBfp2HryBhkYxbISS
 j3CA==
X-Forwarded-Encrypted: i=1;
 AKwUvBznpjV24GPBRSWZWRhMatfI5MgdikOTqBTccVgJcx9icsOPy3JrtXMV6IJ3NLJdRW6rbzDvREj/hVg=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kxrAZxpY+NMMaGEpe/2YKqxX70Vqwq3aqiu4bl+9Awn2z5Hrc6
 Qlc91nGbWlvB8qq7acRGj1BKyWCHB2HHsxSQp+pPcPeLaHTlFjwiyNHr
X-Gm-Gg: AYBFou3YWxN7Zzt1vIHbOh428QHJAbJstP1zY1yU+VkMugzjreH9dFmjh6UFnr0p77t
 WftZeo4CmJIVRytEgB3dv49dSYFdKeuy04iTDP7CMGyKeP3htw4FJu04VO7ijLz4jauFYvIlrig
 TiRc9KWEOYykP5/roUekrwmsakwVnkNmMYFr2Hhu+wSIOI6OXXbfWm4hFARUf+TCn8htlJu/inL
 /kfOqcZLUj7hNgMwkIv6Mpg/d9TgNvplYDGp3+RCr2FOIIPtw4mE1qoXx+lRoha+mW6fe0Ng8Kd
 +9wAMMddqMMB6aFdvLbp5btLoGOKuz/QJEV1hwG1n9NHCdgX2OVD4xEB7uCRQMzdCSrTlpKQlVD
 fQ0ToTxw+WFrzGOEXTyJH01J8MOFZKrNH/vJMMLhv835PlJfJUstaJ2ldw/b2be9ebf90ITyjpy
 JYKqh8yj7q94uShbWSIge7RxhEYkkj+nismPh0BAgiai8M+L343sT+8W8X010fqHn7lZmNSWAA0
 kRy2gSnqAk7tCwYaZECEegq0MerqXmHK2UlV1FjALjxQXjeKwI4x7nsI6w58l/Pbj7mRRYsJLKV
 9xEgn7mMb0bKJ+uQ9osapas7OY5ro93qvFw=
X-Received: by 2002:a05:7022:49c:b0:143:46a6:b01f with SMTP id
 a92af1059eb24-14d330b01admr1588765c88.31.1790767042676; 
 Wed, 30 Sep 2026 04:17:22 -0700 (PDT)
Received: from rahuls-x2elite ([110.226.112.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14d063006f7sm4736344c88.2.2026.09.30.04.17.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 04:17:22 -0700 (PDT)
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
Subject: [PATCH msm-next] drm/msm/a8xx: report the GMEM size of the active
 slices
Date: Wed, 30 Sep 2026 16:47:10 +0530
Message-ID: <20260930111711.1160-1-theflyingrahul@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 30 Sep 2026 12:12:40 +0000
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
slices.

On an HP OmniBook 5 (Snapdragon X2 Elite, Mahua), the Adreno X2-85 runs
3 of 4 slices (chip ID 0x44070031) and the kernel reports 21 MB of GMEM.
Mesa sizes its tiles and places its CCU caches at the top of that range,
past the end of the GMEM that exists, and GPU-rendered output is visibly
corrupted: noise bands and block garbage, across the whole desktop with
GNOME Shell. Rendering without GMEM (FD_MESA_DEBUG=sysmem) is clean;
disabling UBWC, LRZ or compressed scanout is not.

Qualcomm's downstream driver reports GMEM for the active slices on this
GPU: gen8_get_gmem_size() in KGSL returns
gmem_size / GEN8_1_0_NUM_PHYSICAL_SLICES * active slices, 15.75 MB here.
Do the same when reading the slice mask. The GMEM protection and UCHE
setup still cover the full range, as in KGSL.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Assisted-by: LLM
Signed-off-by: Rahul Pon <theflyingrahul@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c   | 4 ++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 3 ++-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h | 2 ++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index add93c1fa039..9b95d9b3826a 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -112,6 +112,10 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu)
 	/* Chip ID depends on the number of slices available. So update it */
 	adreno_gpu->chip_id |= FIELD_PREP(GENMASK(7, 4), hweight32(slice_mask));
 
+	/* GMEM is split evenly between slices: report the active share */
+	adreno_gpu->gmem = adreno_gpu->info->gmem / info->max_slices *
+			   hweight32(slice_mask);
+
 	/* Update the gpu-name to reflect the slice config: */
 	const char *name = devm_kasprintf(dev, GFP_KERNEL,
 			"%"ADRENO_CHIPID_FMT,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 5832dc25d6bf..dadfe4c69438 100644
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
index 114a40f79ef3..8e6a88103610 100644
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

