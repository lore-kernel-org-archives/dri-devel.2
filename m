Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5546BC43458
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 19:14:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0464F10E232;
	Sun,  5 Jul 2026 19:14:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B3ucvKhf";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9FDF10E22E
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 19:14:20 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso2560334f8f.3
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 12:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783278859; x=1783883659; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zDQluHb0hl8HpKdUOUtAwKScA61PoZ6/9MDK96/p22Q=;
 b=B3ucvKhf2elj/MT+dH3uxvx89xXogJMLhIRyg9c+5w1R9/AqVCeMKc3r9KmG4qFYbr
 cV8XgFyEVavFs/C+h4jRPpFv4paM03A1Ujg3wa6f7Vjf+b4HX26IcDzuFBzwv/e+FZmi
 k/NpGvORXxPakYbj4G2/BF62fuCGF5XkMqCmqUwIWPD/knWE8P3Edq06MzRV6rjnYSbV
 IG+/L898MP+2mXLYhumOle4o6hoXlcRaz4WNqaewcR9HaNFFS1OLRGRTx/Yx/UlzuzlR
 c0/ehT0kdY84hLnm8IojqGbd4eU71Yh0yvHp6BpOj5GErZwPiTzVrjEOZCG8kCP4PyT5
 wDqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783278859; x=1783883659;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zDQluHb0hl8HpKdUOUtAwKScA61PoZ6/9MDK96/p22Q=;
 b=dclf8RbhzllVChnO4IIgGK4iiGSZSWcqS3Rs3oYYl+WdPtD6ZfqdXmhNjNo1ikLZUM
 nOEY+Hr2mjaqpN6Q1eCibvOpSt+dgVbFqFu5jGzo+4NW2wNSCQx/AtOs4NfhzR37VWFN
 /eSY/hF9JV8RPjOmHsbvEDZ5YQf4CEXoUBoyLP1i+GyYEZIEN2TaOMSHR2C5aUDX4aip
 9fpsp/1r8fgCO92TmTdQxbZQfM/8zrkU6VXP/lCv1h8FHrzt1vQ3hEH09ZgbRCl4djbr
 3mh/dy6yXTlKDuX/9qNhT0XUEqZs6ZpXdOTKv+nFmmflzW6Di+3UpSUGXtk9uD1DRCgR
 ZA2w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDSNDd4PWLURFQRZiWQgtOw6K+7qXEzBIIp2xgnadbFjpQFexQfxSXAe0/tM6Jvu1g6sO0n7ai4Ss=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzBLqCwZ9JCVlXqMOBlPQhgGv7OnNLP3MEjme/F5L+MX5QWWxZE
 LyZsxkUxpCmfhcWfutWmMlW0SpgVw22Z/IXGcO50EJ1vjnrn/rUA5AA=
X-Gm-Gg: AfdE7cmqGbPaW9LOb3m3sU/8x2uhBR29RnamNkZO2zmPfYXrRwgrC7uh6iuRBJjgMU/
 0KDU/XSTmGc3VbMU+7k2KF1cHfISEAEvhPsSRs4luhIHy2O2jzbb7hlXB4cqxdvqVzx6xqJUTMx
 TLR4br4Vj3sNtyby/pwEiqSExL0KnOwnWuYG0+Ix0B2dVLKVvj0psPJpdfQO/DQQSDQFzB7TsOW
 A4XNhmFwASLRj7ZIBerwgFs5v13ziUTXontecG2aeeI9YbUfIeAG6G+uCKaGCmdN0MoADfq3zu3
 DwbkGFw2YqQcaOZEnV5lAvA0J8i8k6LhSbIFx0HODQKylXVGKnrdpEzAvTqVDFsYEZ5Ck3suWpF
 AyULBmzpRI0vcZDXt37r9DIYUY1xJSvJlcbaBFBl7iu5InA9Vd8FF3TmRFwddHWC5TivOXuXsRC
 p+ErgCqsLn0kF3ZsINPHK50X2XfPVf8w==
X-Received: by 2002:a05:6000:41e2:b0:46f:ca9:465a with SMTP id
 ffacd0b85a97d-47aaa60d512mr9236488f8f.21.1783278859133; 
 Sun, 05 Jul 2026 12:14:19 -0700 (PDT)
Received: from [192.168.1.67] ([2001:b07:2ec:601d:4b26:1672:75c7:805a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm19209528f8f.26.2026.07.05.12.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 12:14:18 -0700 (PDT)
From: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Date: Sun, 05 Jul 2026 21:13:37 +0200
Subject: [PATCH RFC 03/13] drm/msm: look for lpac from dts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-descriptive-name-lpac-upstream-v1-3-01d50c3e0c99@gmail.com>
References: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
In-Reply-To: <20260705-descriptive-name-lpac-upstream-v1-0-01d50c3e0c99@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783278851; l=3023;
 i=anna.maniscalco2000@gmail.com; s=20240815; h=from:subject:message-id;
 bh=bbKLUcBLFub1tb5TatUPZPAkNtWF5490OkNoXJdO3Uk=;
 b=7V8X3RcC17AsLp4EvKV8VBh99CxZsYWbT6DX1+PJ1oeSqvZHrZHxSjd1CzKlfExV5zUSLhrW1
 hjyiu/P/E73CA/bsNLALt50GwglEelh/PKZjB7H/Z0Rc38c39U6bUFN
X-Developer-Key: i=anna.maniscalco2000@gmail.com; a=ed25519;
 pk=0zicFb38tVla+iHRo4kWpOMsmtUrpGBEa7LkFF81lyY=
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

In order to associate the SID used by LPAC to it's own domain and
context bank we need a separate node on the DTS.

Add the code to look up that node on initialization.

Signed-off-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 21 ++++++++++++++++++++-
 drivers/gpu/drm/msm/msm_gpu.h           |  1 +
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index f3fc7032fadc..71ce4cbbf27a 100644
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
@@ -1200,6 +1205,20 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	gpu->allow_relocs = config->info->family < ADRENO_6XX_GEN1;
 	gpu->pdev = pdev;
 
+	lpac_node = of_parse_phandle(pdev->dev.of_node, "qcom,lpac", 0);
+	if (lpac_node)
+		gpu->lpac_pdev = of_find_device_by_node(lpac_node);
+	if (gpu->lpac_pdev) {
+		of_dma_configure(&gpu->lpac_pdev->dev, lpac_node, true);
+		platform_set_drvdata(gpu->lpac_pdev, &gpu->lpac_adreno_smmu);
+		if (!device_link_add(&pdev->dev, &gpu->lpac_pdev->dev,
+				     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER))
+			dev_err(&gpu->lpac_pdev->dev, "failed to link to gpu device\n");
+		pm_runtime_enable(&gpu->lpac_pdev->dev);
+	}
+	if (lpac_node)
+		of_node_put(lpac_node);
+
 	/* Only handle the core clock when GMU is not in use (or is absent). */
 	if (adreno_has_gmu_wrapper(adreno_gpu) ||
 	    adreno_has_rgmu(adreno_gpu) ||
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
2.54.0

