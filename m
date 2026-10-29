Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FE260A2618
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B8/TqBSM
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193EE10E81E;
	Thu, 29 Oct 2026 13:53:25 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72C4510E15F
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:53:07 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a35a60499eso17973175e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793281986; x=1793886786; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gaJ4+9mmPD4lBBlHsni916fB1brqPSLNtulQU+Q8NCs=;
 b=B8/TqBSMgAZas78VOxgR8H/NXOY0cuUGBemSmyasC3RbC8jlgnS4YxOQqcS2BZcLlA
 mUr4FEx/w/6IfLlFJQ7hyRe49fnNnACwx3XKh6t//oG+h5WDkbu/l7IOEL93LarrmCnK
 cPKbwp9GLHtWtGjY6FWZ2zSEA3xpH97HkFC1BF9rQMKmcAuscnrosRxCsE7/Su7KUiC4
 OaPkoeyDffbW8XqcVlNmvTJ06Pr/jCTQscivrkaR81g/QJBEKMQ6cCAj6XhV2FaiFap6
 qVonx+rW8VuoFJQwmpj+m4CxV5WPzSNZtjB9SxCVnA65xanzWpOl62taOGMdbqSFAlvb
 t/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793281986; x=1793886786;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gaJ4+9mmPD4lBBlHsni916fB1brqPSLNtulQU+Q8NCs=;
 b=aX5wYtN2UmmWT2O5/gkgD2zCtTwIZt1aF6PH++Rlmt4WfgV07ZnQpRbBIljeWU0wtp
 +gayICN6Hx3cRpCqS7jlkBn/qbnYucZJGvzm420mrrEaSSPXw+iqFrzdfV+6A7EO+aVg
 5St9mi1glKCN3zr99k/PPmSRUd/AgmNEY7EThWlYs587vdfixflfOpFt6KuaZdFLzmTR
 4gxFsgElvKfpGI7c7EayvHLrLNXGpEFOL6OyEymGWvETZK7/H6jxonBYygVipjwSS9kF
 9lWNG26+yHEo2p1xSf2XZQjw0n5UyxWRHSG+cVFVqP4dgC6CnLjgML9mCza+Pnf/Hi8d
 U76w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVeCQi1n2OFL5cCvQ1ME6t/VvrNy6nj5V/uO0F9Q0gSmF+fzHSpXZoQPh197dgOHJa5HrAE/H+Zww=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJCEBkfq2j4/6FxLzrTVqOgifj85v/Zpc4kjokfJaz4m7HRwHwB
 pS0AjsUbZZidI86PBV+5iQzZtkd0oDOzJ11t8XBsNL6xMOZ2FoqaHxg=
X-Gm-Gg: AYBFou3Rx8tcKS8HbTuzs3I7RuwN5vd6NH9v1z8emqxI0+YiPP6kZRPvDZeXSxzZdBL
 qtaAi6E9m8JS3y18QAZ9UIL91xosOHq6RSGTS6HQiao8ewH66TnJ4ES0LpjKt+da5Tlz8T7uiRV
 n7Hw8X3ARosRgKD4u6oOHazKCgo8LIL7Hl1MlGOlrnqz9Qkveh+Sn2AVPaFtdyjm4ZrtJ6pSmmP
 dBVc40zbx+ETbDElC9eIQgRL7aAazcstsVoef5+f+8yNkGX0hUCvx8iQNI6LNHKVITlPnsPR8ec
 kLNANT0TeZGG8e3DunF54Iaz6EG4fUNVm1Cg5I23uqtJT/mKjV3NyFU4Vyv0hWk7Mtd8B3xgnqx
 Y5HMLOwKohzjAFoNuc+gjnrlKKAD7/4aexL4s/RVIEBaFf1560/K4tuQ3EgbSWgSCUENwTDhS4S
 dOU97DCB20HGU1dlXbQvs5U+w1YexGEdlYxRyzh1oOoCAUfC3isNO/aaQNycVgrEC/HXPvFtnTE
 HOESAkp2Z3orMGEoW4bqEdyjIBIKpiS/7Lhmcu8AD6tnR1Cty4HPt9nzakUmZkXzEswet5ynyxX
 tgaOCFQkdzTxs4Fk91uw4lKIrWTpfWTAw+98e4A1D4exSQ==
X-Received: by 2002:a05:6000:200c:b0:48b:116d:56fb with SMTP id
 ffacd0b85a97d-48e5d567e85mr13366844f8f.1.1793281985638; 
 Thu, 29 Oct 2026 06:53:05 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3dcbsm33456468f8f.14.2026.10.29.06.53.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 06:53:05 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Thu, 29 Oct 2026 14:52:40 +0100
Subject: [PATCH RFC v2 03/14] drm/msm: look for lpac from dts
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-descriptive-name-lpac-upstream-v2-3-a21a5c850961@gmail.com>
References: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
In-Reply-To: <20261029-descriptive-name-lpac-upstream-v2-0-a21a5c850961@gmail.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>, 
 Akhil P Oommen <akhilpo@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: iommu@lists.linux.dev, linux-arm-msm@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Anna Maniscalco <anna.maniscalco2000@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793281977; l=6436;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=XpQ9AteTwMtLcsxYohB2gJNeRwk7JfV+tvwdBjYtlVM=;
 b=qJvSiqvDD9GrBlIaJ1RKA9o8A4IaM3JohySZtd/JVEOLdgV49X0tKEgfd5R3pjwNDTF4Zh1r/
 nkMzJe2orBYCYxYltUajmFOI3R3Mior3UrbO69vtb5EGuRS9UYNb5Ry
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

In order to associate the SID used by LPAC to it's own domain and
context bank we need a separate node on the DTS.

Add the code to look up that node on initialization.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_device.c | 10 +++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    | 36 ++++++++++++++++++++++++++----
 drivers/gpu/drm/msm/msm_gpu.c              |  6 +++++
 drivers/gpu/drm/msm/msm_gpu.h              |  1 +
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index 7f20320ef66a..4d22223c3323 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -6,6 +6,8 @@
  * Copyright (c) 2014,2017 The Linux Foundation. All rights reserved.
  */
 
+#include <linux/of_platform.h>
+
 #include "adreno_gpu.h"
 
 bool hang_debug = false;
@@ -271,6 +273,12 @@ static const struct component_ops a3xx_ops = {
 
 static int adreno_probe(struct platform_device *pdev)
 {
+	int ret = 0;
+
+	ret = of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
+	if (ret)
+		return ret;
+
 	if (of_device_is_compatible(pdev->dev.of_node, "amd,imageon") ||
 	    msm_gpu_no_components())
 		return msm_gpu_probe(pdev, &a3xx_ops);
@@ -282,6 +290,8 @@ static void adreno_remove(struct platform_device *pdev)
 {
 	struct msm_drm_private *priv = platform_get_drvdata(pdev);
 
+	of_platform_depopulate(&pdev->dev);
+
 	if (priv->kms_init)
 		component_del(&pdev->dev, &a3xx_ops);
 	else
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f3fc7032fadc..1dedeb19946e 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -11,6 +11,8 @@
 #include <linux/firmware/qcom/qcom_scm.h>
 #include <linux/kernel.h>
 #include <linux/of_reserved_mem.h>
+#include <linux/of_device.h>
+#include <linux/of_platform.h>
 #include <linux/pm_opp.h>
 #include <linux/slab.h>
 #include <linux/soc/qcom/mdt_loader.h>
@@ -201,7 +203,9 @@ adreno_iommu_create_vm(struct msm_gpu *gpu,
 	struct drm_gpuvm *vm;
 	u64 start, size;
 
-	mmu = msm_iommu_gpu_new(&pdev->dev, NULL, gpu, quirks);
+	mmu = msm_iommu_gpu_new(&pdev->dev,
+				gpu->lpac_pdev ? &gpu->lpac_pdev->dev : NULL,
+				gpu, quirks);
 	if (IS_ERR(mmu))
 		return ERR_CAST(mmu);
 
@@ -1187,6 +1191,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		const struct adreno_gpu_funcs *funcs, int nr_rings)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *lpac_node;
 	struct adreno_platform_config *config = dev->platform_data;
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
@@ -1200,6 +1205,18 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
 	gpu->pdev = pdev;
 
+	lpac_node = of_get_compatible_child(pdev->dev.of_node, "qcom,lpac");
+	if (lpac_node)
+		gpu->lpac_pdev = of_find_device_by_node(lpac_node);
+	if (gpu->lpac_pdev) {
+		pm_runtime_enable(&gpu->lpac_pdev->dev);
+		if (!device_link_add(&pdev->dev, &gpu->lpac_pdev->dev,
+				     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER))
+			dev_err(&gpu->lpac_pdev->dev, "failed to link to lpac device\n");
+	}
+	if (lpac_node)
+		of_node_put(lpac_node);
+
 	/* Only handle the core clock when GMU is not in use (or is absent). */
 	if (adreno_has_gmu_wrapper(adreno_gpu) ||
 	    adreno_has_rgmu(adreno_gpu) ||
@@ -1221,8 +1238,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
 			ADRENO_CHIPID_ARGS(config->chip_id));
-	if (!gpu_name)
-		return -ENOMEM;
+	if (!gpu_name) {
+		ret = -ENOMEM;
+		goto err_put_lpac_pdev;
+	}
 
 	adreno_gpu_config.ioname = "kgsl_3d0_reg_memory";
 
@@ -1230,7 +1249,7 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	ret = adreno_get_pwrlevels(dev, gpu);
 	if (ret)
-		return ret;
+		goto err_put_lpac_pdev;
 
 	init_completion(&adreno_gpu->fault_coredump_done);
 	complete_all(&adreno_gpu->fault_coredump_done);
@@ -1241,6 +1260,10 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	return msm_gpu_init(drm, pdev, &adreno_gpu->base, &funcs->base,
 			gpu_name, &adreno_gpu_config);
+err_put_lpac_pdev:
+	if (gpu->lpac_pdev)
+		put_device(&gpu->lpac_pdev->dev);
+	return ret;
 }
 
 void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
@@ -1256,4 +1279,9 @@ void adreno_gpu_cleanup(struct adreno_gpu *adreno_gpu)
 		pm_runtime_disable(&priv->gpu_pdev->dev);
 
 	msm_gpu_cleanup(&adreno_gpu->base);
+
+	if (gpu->lpac_pdev) {
+		pm_runtime_disable(&gpu->lpac_pdev->dev);
+		put_device(&gpu->lpac_pdev->dev);
+	}
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 18ed00e5f143..20581be10ca7 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -963,6 +963,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		gpu->gpu_cx = NULL;
 
 	platform_set_drvdata(pdev, &gpu->adreno_smmu);
+	if (gpu->lpac_pdev)
+		platform_set_drvdata(gpu->lpac_pdev, &gpu->lpac_adreno_smmu);
 
 	msm_devfreq_init(gpu);
 
@@ -1032,6 +1034,8 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
 
 	platform_set_drvdata(pdev, NULL);
+	if (gpu->lpac_pdev)
+		platform_set_drvdata(gpu->lpac_pdev, NULL);
 	return ret;
 }
 
@@ -1062,4 +1066,6 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 	msm_perfcntr_cleanup(gpu);
 
 	platform_set_drvdata(gpu->pdev, NULL);
+	if (gpu->lpac_pdev)
+		platform_set_drvdata(gpu->lpac_pdev, NULL);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index e2291dfe3ca8..271956e7f870 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -172,6 +172,7 @@ struct msm_gpu {
 	const char *name;
 	struct drm_device *dev;
 	struct platform_device *pdev;
+	struct platform_device *lpac_pdev;
 	const struct msm_gpu_funcs *funcs;
 
 	struct adreno_smmu_priv adreno_smmu;

-- 
2.56.0

