Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90631F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E95EC10E42F;
	Mon, 23 Mar 2026 20:13:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OpH6XsGD";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="X+lbKm64";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C9EA10E444
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:49 +0000 (UTC)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqXE13634280
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zf9OgMQW8kjaOJM6YV3ZDejW7RqNIctSZqIvD7mhJNg=; b=OpH6XsGDtibgAOR7
 WJf+yxZInuWfm0AxCIPK5gtZVLkpeHl71AgrpSZsJSwbx1ebeBo6VHtrpuxlSk2H
 vNd8VqM3yE7ryRjloLGw6w3hSHt4MM9h069+ltqozlhMq4wITUSPBGm51JcRlH/J
 MlTb1W1TEXyq9Sd5HFqDrquA75uuwjIIPH1J2PN8CXm3RoTnbEa1kA42GNNET1pM
 V+oCOXIPYsXvccn1bubFEtUbdn/bmS6I+igoSlqi/T3jEcv5kKtn3CbKWVEXGsf1
 5YYDbdtH7UBjFM3WPI136nI8/MG59CPbuN4HCYacntZCrnQ/T8Z1iWjxJBr8YejS
 TvvGGw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34k4hwm4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:49 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c7424d91b2dso2699482a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296828; x=1774901628;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zf9OgMQW8kjaOJM6YV3ZDejW7RqNIctSZqIvD7mhJNg=;
 b=X+lbKm64iA7PC9U6JrPDlZ9S6iJccWkF9rddNBO7bFOfrNcI8R0F4gQ4InxfbE4FBo
 ua6wakBGRCRm6v90B2/8Gr859zQ+Gkh8/3aKuXgqURZcmbZOAfz+jkP9ah5Q1hgD0/3u
 lDLjOtaIXwFjHmNNWrwp4bnX2sXv7z+CpjHP/9iP17KHN/XyKm4Oz6AqQ7w/fTOnIXBh
 NZiVCRgbWm17pmKVUM2IHmYk7Mpv8WxjS8KtGUs1x3akpZHzfgcUfv0rdbl4zQDQ1Fp/
 qzsAefMgVeYf3JWve+o8hN8dw3a6eAQiBUkvgeYKImZw7YYjAucgy07Bbx27YrNhv096
 1F+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296828; x=1774901628;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zf9OgMQW8kjaOJM6YV3ZDejW7RqNIctSZqIvD7mhJNg=;
 b=BUXAr51ZzGkznzTi8wyH9o8kWDCh+fgoXTzZO0BL82JodLkLpViIDZrrEQyQ0FZ6UH
 O/hXG6f2L6SmjF1I2N5QdwKrj0Cj0L70krDBipPA4dqydrK9TUqRpjCW59XHkF4T6i79
 srz86nnljegpbZj8cK+vtpuoImtQk8U2JAq8IpAimaaAD3LDLGlmfEjFG/w3QwrtzUAx
 ClNF5qcRcCIxJiYCHVtnlDrZ2+pQYjwwPlMhzBM+L5YoWtsi+rQlBY2yGZnLFTlK7k7Q
 9fv362AvIFQmAm/V6SA/gcXgGh6HdOi98nGMVY0QZLXVPpJAgkQjrFwJCu8XkQOPl1f1
 MO/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgbwvJElUr+nCBu2mQp4xibHlnd8zwE/BDYycUorRZKrarYyHbME64pQJE6wglpRoqjsUOVPEwYac=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzPSHwHQb60AKOW19Qfe4tcMTcBme0v+rsf2Is9gaUcN4YHoJR0
 9eCY4SfexXm6ezywSWK5nxpcbXq2cT10Jr6Nwi+/xdaK1SMIWii3iOotlYqTd6eB9vT46vmOW6R
 I8kUjxLSFCCf/75XsWgGPFhygDh95D2viRfkQdmB9zgMD4nagPPLBKChWTXK0Wlb0q7Gs8SA=
X-Gm-Gg: ATEYQzwUHTNoNJZFmax3kg8qOSZTAoEmSE/8RIXfztxb7TRlryVXtr33H0Ei10myPH2
 mMgkwlw+GqsruoxT5H8vlBdat7AgNxrGufTYe07kvGO1NiQ463l5EQHP5lqRidx4oa0URt2BLPX
 XuEa2vfjn/AUX7jLE2rnRKc8DLq7pf26VD1amsIgfBsMVsyLGt1gx/sLm5DvgsyBKw+U6fCW7FS
 REjYREgkLIahBJJ2wKCB5oqcL9YvW0Y1vlDm0juZneu8s5MkjMtTeH4KdozvOzp+97NtbIR/9OY
 L6xpv8aSTQX/qCWuikdAoyQ/3+mbvoFzeCCUU3EPPtv/wRPsKmX1X3W3HJiApHqTXtzTOOycqwR
 SK8leiM/xtgxNNVIGPmfZETU75sXX3dNCt2nfAQG31WvskA==
X-Received: by 2002:a05:6a00:908e:b0:81f:3afe:281e with SMTP id
 d2e1a72fcca58-82a8c247e08mr10525721b3a.3.1774296828354; 
 Mon, 23 Mar 2026 13:13:48 -0700 (PDT)
X-Received: by 2002:a05:6a00:908e:b0:81f:3afe:281e with SMTP id
 d2e1a72fcca58-82a8c247e08mr10525689b3a.3.1774296827835; 
 Mon, 23 Mar 2026 13:13:47 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:47 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:24 +0530
Subject: [PATCH 12/16] drm/msm/a6xx: Add SKU detection support for X2-85
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-12-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=8395;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=4D9q9C/KDNPPGKfghm5SOHAW/QvZXC4Fp7RMJpvJjag=;
 b=1xObmfn+e0DZqh5iORmJvf7AxvHH2VJWAdzdwD0fdLez9VuwcH4Eb16dXCUGwoFaamkuBDawz
 N5x4BdbWjegDXcBoLK1rf21/W8F+bXgpUncqcvk+cZHPwPEmWrVytvt
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: 0kpbXYuOL21i2XV6nuHAMDijbEv10qdm
X-Proofpoint-ORIG-GUID: 0kpbXYuOL21i2XV6nuHAMDijbEv10qdm
X-Authority-Analysis: v=2.4 cv=c+imgB9l c=1 sm=1 tr=0 ts=69c19efd cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=Vdb0TAve2SCM4sGFxkMA:9 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX8HWkQwhekc9s
 duhkfbzjP8D2y6n35iIKRGZNlLh1r2PmaQ5JBCGSjMmHKtVeP88an+NvmbX59zPQius6uxcXLon
 VZvFCrhy4Z7SxmIdw1862tt3IRCpYmdhwrvB7D9ay5QJvAus2Y8QC/we1qVlEKamV8vVYRuLUMN
 znUaPs3Km1Qz7IusFFPZsPvt2diLSOZ6xCScYSO22fqKn2Sl6rEEdrywlqUblL8uKZSh/LAor1S
 LfuHGyC7nj0jqYlr+51lIc7w7oNM3bLyistm8T4+pnkG7DWz7Hl2kncdJkUnJMnwiMqPuvVVHYe
 XwJgD57nNw7LUO/pk6umV36jGNC1AirkNQmVZzuYWp/k95o/oCXi2/qJ5EtKv/5AAbX7l+K/3Ib
 sdZVFzORRIblNLDd4xn9ualiDexOvSHbvAYFnytssTXGGdZlhj1CAyDRx3DofgtkdQPKOyYp0ph
 njbVUs4OPu0W9KNWUkw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 phishscore=0 lowpriorityscore=0 spamscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230149
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

Adreno X2-85 series present in Glymur chipset supports a new mechanism
for SKU detection. A new CX_MISC register exposes the combined (or
final) speedbin value from both HW fuse register and the Soft Fuse
register.

Implement this new SKU detection along with a new quirk to identify the
GPUs that has SOFT SKU support. Also, enable this quirk for Adreno X2-85
and add its SKU table to the catalog.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c         |  6 ++++
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c     |  9 +++++-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c         | 41 ++++++++++++++++++++++-----
 drivers/gpu/drm/msm/adreno/adreno_gpu.c       |  5 ----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h       |  1 +
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml |  4 +++
 6 files changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 79a441e91fa1..d7ed3225f635 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1731,6 +1731,7 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
 	unsigned int nr_rings;
+	u32 speedbin;
 	int ret;
 
 	a5xx_gpu = kzalloc(sizeof(*a5xx_gpu), GFP_KERNEL);
@@ -1757,6 +1758,11 @@ static struct msm_gpu *a5xx_gpu_init(struct drm_device *dev)
 		return ERR_PTR(ret);
 	}
 
+	/* Set the speedbin value that is passed to userspace */
+	if (adreno_read_speedbin(&pdev->dev, &speedbin) || !speedbin)
+		speedbin = 0xffff;
+	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
+
 	msm_mmu_set_fault_handler(to_msm_vm(gpu->vm)->mmu, gpu,
 				  a5xx_fault_handler);
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index f6b9792531a6..758bc7bd31f6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1902,7 +1902,8 @@ static const struct adreno_info a8xx_gpus[] = {
 		.gmem = 21 * SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_SOFTFUSE,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &x285_protect,
@@ -1922,6 +1923,12 @@ static const struct adreno_info a8xx_gpus[] = {
 				{ /* sentinel */ },
 			},
 		},
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 388, 1 },
+			{ 357, 2 },
+			{ 284, 3 },
+		),
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x44050a01),
 		.family = ADRENO_8XX_GEN2,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index cbc803d90673..0fe6d803e628 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2552,13 +2552,33 @@ static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
 	return UINT_MAX;
 }
 
-static int a6xx_set_supported_hw(struct device *dev, const struct adreno_info *info)
+static int a6xx_read_speedbin(struct device *dev, struct a6xx_gpu *a6xx_gpu,
+		const struct adreno_info *info, u32 *speedbin)
+{
+	int ret;
+
+	/* Use speedbin fuse if present. Otherwise, fallback to softfuse */
+	ret = adreno_read_speedbin(dev, speedbin);
+	if (ret != -ENOENT)
+		return ret;
+
+	if (info->quirks & ADRENO_QUIRK_SOFTFUSE) {
+		*speedbin = a6xx_llc_read(a6xx_gpu, REG_A8XX_CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS);
+		*speedbin = A8XX_CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS_FINALFREQLIMIT(*speedbin);
+		return 0;
+	}
+
+	return -ENOENT;
+}
+
+static int a6xx_set_supported_hw(struct device *dev, struct a6xx_gpu *a6xx_gpu,
+		const struct adreno_info *info)
 {
 	u32 supp_hw;
 	u32 speedbin;
 	int ret;
 
-	ret = adreno_read_speedbin(dev, &speedbin);
+	ret = a6xx_read_speedbin(dev, a6xx_gpu, info, &speedbin);
 	/*
 	 * -ENOENT means that the platform doesn't support speedbin which is
 	 * fine
@@ -2592,11 +2612,13 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	struct msm_drm_private *priv = dev->dev_private;
 	struct platform_device *pdev = priv->gpu_pdev;
 	struct adreno_platform_config *config = pdev->dev.platform_data;
+	const struct adreno_info *info = config->info;
 	struct device_node *node;
 	struct a6xx_gpu *a6xx_gpu;
 	struct adreno_gpu *adreno_gpu;
 	struct msm_gpu *gpu;
 	extern int enable_preemption;
+	u32 speedbin;
 	bool is_a7xx;
 	int ret, nr_rings = 1;
 
@@ -2619,14 +2641,14 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu->gmu_is_wrapper = of_device_is_compatible(node, "qcom,adreno-gmu-wrapper");
 
 	adreno_gpu->base.hw_apriv =
-		!!(config->info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
+		!!(info->quirks & ADRENO_QUIRK_HAS_HW_APRIV);
 
 	/* gpu->info only gets assigned in adreno_gpu_init(). A8x is included intentionally */
-	is_a7xx = config->info->family >= ADRENO_7XX_GEN1;
+	is_a7xx = info->family >= ADRENO_7XX_GEN1;
 
 	a6xx_llc_slices_init(pdev, a6xx_gpu, is_a7xx);
 
-	ret = a6xx_set_supported_hw(&pdev->dev, config->info);
+	ret = a6xx_set_supported_hw(&pdev->dev, a6xx_gpu, info);
 	if (ret) {
 		a6xx_llc_slices_destroy(a6xx_gpu);
 		kfree(a6xx_gpu);
@@ -2634,15 +2656,20 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	}
 
 	if ((enable_preemption == 1) || (enable_preemption == -1 &&
-	    (config->info->quirks & ADRENO_QUIRK_PREEMPTION)))
+	    (info->quirks & ADRENO_QUIRK_PREEMPTION)))
 		nr_rings = 4;
 
-	ret = adreno_gpu_init(dev, pdev, adreno_gpu, config->info->funcs, nr_rings);
+	ret = adreno_gpu_init(dev, pdev, adreno_gpu, info->funcs, nr_rings);
 	if (ret) {
 		a6xx_destroy(&(a6xx_gpu->base.base));
 		return ERR_PTR(ret);
 	}
 
+	/* Set the speedbin value that is passed to userspace */
+	if (a6xx_read_speedbin(&pdev->dev, a6xx_gpu, info, &speedbin) || !speedbin)
+		speedbin = 0xffff;
+	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
+
 	/*
 	 * For now only clamp to idle freq for devices where this is known not
 	 * to cause power supply issues:
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 10d9e5f40640..826661cb7988 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -1184,7 +1184,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 	struct msm_gpu_config adreno_gpu_config  = { 0 };
 	struct msm_gpu *gpu = &adreno_gpu->base;
 	const char *gpu_name;
-	u32 speedbin;
 	int ret;
 
 	adreno_gpu->funcs = funcs;
@@ -1213,10 +1212,6 @@ int adreno_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 			devm_pm_opp_set_clkname(dev, "core");
 	}
 
-	if (adreno_read_speedbin(dev, &speedbin) || !speedbin)
-		speedbin = 0xffff;
-	adreno_gpu->speedbin = (uint16_t) (0xffff & speedbin);
-
 	gpu_name = devm_kasprintf(dev, GFP_KERNEL, "%"ADRENO_CHIPID_FMT,
 			ADRENO_CHIPID_ARGS(config->chip_id));
 	if (!gpu_name)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 29097e6b4253..044ed4d49aa7 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -63,6 +63,7 @@ enum adreno_family {
 #define ADRENO_QUIRK_PREEMPTION			BIT(5)
 #define ADRENO_QUIRK_4GB_VA			BIT(6)
 #define ADRENO_QUIRK_IFPC			BIT(7)
+#define ADRENO_QUIRK_SOFTFUSE			BIT(8)
 
 /* Helper for formating the chip_id in the way that userspace tools like
  * crashdec expect.
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index 3941e7510754..2309870f5031 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -5016,6 +5016,10 @@ by a particular renderpass/blit.
 		<bitfield pos="1" name="LPAC" type="boolean"/>
 		<bitfield pos="2" name="RAYTRACING" type="boolean"/>
 	</reg32>
+	<reg32 offset="0x0405" name="CX_MISC_SW_FUSE_FREQ_LIMIT_STATUS" variants="A8XX-">
+		<bitfield high="8" low="0" name="FINALFREQLIMIT"/>
+		<bitfield pos="24" name="SOFTSKUDISABLED" type="boolean"/>
+	</reg32>
 </domain>
 
 </database>

-- 
2.51.0

