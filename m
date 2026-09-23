Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1183BC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:27:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F63910ED4F;
	Wed, 23 Sep 2026 10:27:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="lXMWh7I6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dkoYeRbw";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C52E310E89A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:12 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68NA31Ei4087761
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LOjyHEWtGuZjCr/VrUZ6KrtiiGIwDJckbv8O61ITjRs=; b=lXMWh7I6BCc9a1Xg
 OJ+rel88sk7wxqBiynIpx5ySBTcq4DCa9VNhXEU2qJKNLhUfXkABlKoAazX8AeUT
 FrXOy4aovigOqahx/E1Gz29P8/GpE1C0v5VxyWYuX5MZMy85WZrYY8KXb31BDt4a
 tdUQvFp0Af22WmCWF61Tn4KikvYcbdSIN2cslgo9SQ6onkfYO/fzigipkEnUVVc6
 lxm70d2xgcz5kQylT0PS7+/CDH0DZcocvp3EMw83Cy8gIFU5VoPRGQwlOvu4ci4t
 p9szL44+bo2yY6unJHOjNLVzdqlIK0mvOIBPgxVOLLJzpoR1wgDkgMJ4gCb0ysi8
 lI57dA==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gux8c3vjf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:12 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-1383723dfddso1451385c88.0
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 03:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790159231; x=1790764031;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LOjyHEWtGuZjCr/VrUZ6KrtiiGIwDJckbv8O61ITjRs=;
 b=dkoYeRbwk6imYoUBOE2q6P8owlHMVSJ6NWPH75NYv5oZRdCZitkFFuWal5JGISy0Tr
 nVFqTj2bAWXzV/WZoAnDcrSlRDGcAiWxzCrgVx4kYeQIDQDTxACRkqabKWnc57ev8RzJ
 OX9/hYpX7XQh9Pi8cmmI2QPcpTKcQZhX9aLlroC2/hP/EME9+2M8HGeD3gqzPK59Ky2z
 OsUd4YL2+Wk/CKmWhSkGOSpaS2gSCz/MRvGKNvnXQaYBHjB4auNjXbqXKuiQS82U4WmL
 WMzbtRH0mtBKLyJ5bk8iXDLQBGatNLNlNDGIz7D3pxws/w9zoyFiSuD8o6kBncJCa9Pd
 TnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790159231; x=1790764031;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LOjyHEWtGuZjCr/VrUZ6KrtiiGIwDJckbv8O61ITjRs=;
 b=YYHZBjuHyyRGLaDn3Ya2FDw7J9uPPYuMYCW5kjm3qiHCdCO3lvnMCwTUFMI4HA/MYQ
 ppephjk/wnuwfn4vMY2VtRAawOaf2Hy15LNuV8I6Z2LS5dS/cHDNNY5GMx/3eL8192pL
 oA8Q9iXjBuuihVlx85gPyJE9oDMhcrHK4l+Ju5SVld+ICGV+W4CC0Ax87w2NczCw9Csz
 xCujvXWeJclOH4NG1AplCDvxHiN+TvXFu0bSNwDihbDhZCHZUJrAemeQ+T0KmeKripga
 cyQ939ZQJDb/U6WasZmqWuQBnZDzTLDvviJCHK36vu9hhnBk//LMBoqSGd3LCgqovPbT
 9dPQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzeU0LJNaLqDVVaXrCvZ70aave5AQEbVFOh1dkXUkb/EhYLN/QloJmluWxt4tZqlOOFlbdNQiV6Qqs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k2bEZJL78hkamJuPcsN8JCFqSdQRzzdr1ZfKZiS1u2wB5qocVY
 KJzGj59FIlfkyI01xv5Ew+7PIC82Q1LgHoj++fyzGhq6/5tP/ADCh50+9w9jC1SBu8ZDMMYTeOb
 fjwnqY5CSuqeYdGwqElc9oY6Fdaep255NX/C5xtGbPZqpH5O4S4YYYT/yCf3XghcUgbf+Vhw=
X-Gm-Gg: AYBFou2gAGFIVFVU4QIgCJdBOoqa8RaJTwzq8KicF4GHZRQ9pNjJKhJrewP5LLTNTX1
 8LOLccOUqx9Ov7cVUR48oGAS8sPhICrye6Zowae+e0BySM+JnRMiSvEqENsE33C3ztQ5znT5WES
 XEc4HG2o1e5FKu8941UkljVxiKFMNZxTOeey+zHHgTdZxrU6EeTeYlk8zBwyR3otcBy3C1S0hab
 x+5qq+QaBXAMGtzJrFqTYoWTbdfYyKRs0AbjZd9E33hdAEL42xTx1kvwmlYYhwT4U9QaYnkLUpy
 V5eML+y6g007F+yMwIGCXB12s6b/suyBxQNhptnAM7N7QOcaOASoske81F5/2QFB7Ox1so1Z+pb
 yhkuiqmMxonffkKcMwU9G5P4=
X-Received: by 2002:a05:7022:43:b0:143:5d6f:5532 with SMTP id
 a92af1059eb24-144f916f3femr3112528c88.40.1790159231117; 
 Wed, 23 Sep 2026 03:27:11 -0700 (PDT)
X-Received: by 2002:a05:7022:43:b0:143:5d6f:5532 with SMTP id
 a92af1059eb24-144f916f3femr3112479c88.40.1790159230408; 
 Wed, 23 Sep 2026 03:27:10 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-144f98a288esm8766646c88.13.2026.09.23.03.27.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 03:27:09 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 23 Sep 2026 15:55:48 +0530
Subject: [PATCH 08/15] drm/msm/a6xx: Send THINMEM config to GMU for A850
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-hawi-gpu-v1-8-0c3c79a1a470@oss.qualcomm.com>
References: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
In-Reply-To: <20260923-hawi-gpu-v1-0-0c3c79a1a470@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: Akhil P Oommen <akhilpo@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790159163; l=3541;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=r8Yu5tb0l7jWK4wCyJ4+Ppu+uskbOfyIKW3R4yDaSUw=;
 b=VQH6iln49RMi+LSqM9cgazdGzSBd4skt8mdl9ONuSZt9VvEUe1p6XhSpuTJAzz9ZTFJvBemuE
 8FiFfOPDfoOBh8eVGmn4TinLbwNbifpPPDG+Yjb+7fAGE0/BSfsYO6R
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX4dMBowc2WFO6
 damF7OwiJSr3Tl9hfBqxdfcmifdQM4oLCF889k1TCh5QYN3PTP0ZBnNDPewNdpGGgK4Rq5nvJYE
 i17Fd9UQFCZ0trvZ+tC9ma5jKn3BdWOf0PtfWY/BBlNuG3E8HmzXXdYMHcA1TvWvQQLvvFJwgPL
 wLydu1EFeW92zNxK5jeM/+Oe09kMEgty6XYUeR+v644BP3rtm2wkVr53T9m01Sr+h+ME6lDT+GG
 U16msIFWaGWqrUqCGk7Ecxwt7ZZeUn2Sh5S0ITRzE6CPYoQbt7eP0VgOKu71qIHoV/ebAln/Er/
 /8fGv2qCac0JS109Wlr55v2DJsUUZyoslh+Zt4N+IL0ayrKqwOnlzTYwzD5TI9QfuwtLQ9imAnT
 nS49nJzXKSX9hqP/SboXKipwvcsv9VSXNkqbcEfehMSUKdWDxNUgPT4bN+6BloyWP48O6pHrMK2
 HUOcNfALel5pK9UsPXg==
X-Authority-Analysis: v=2.4 cv=P9evFSAu c=1 sm=1 tr=0 ts=6ab3a980 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=uikLNib5dCET3MXmAjQA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-ORIG-GUID: KeSJybLVUrQK9NIXa0rMVXO5ZvT5Iw8Q
X-Proofpoint-GUID: KeSJybLVUrQK9NIXa0rMVXO5ZvT5Iw8Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDA0MSBTYWx0ZWRfX9IkM0y1WBHQb
 jpwevySggapMie1Q0YlRrLapJa7Z+iDNZqgvIGIz/bwGWOoG4AMriu1TLxyn4XGQfnuQ+E42zyA
 g+KL9U2E66bEO/kjLnjs5x7JxzjD2FQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501 phishscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609230041
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

Add HFI support for the GMU THINMEM_CFG feature and provide the
configuration value used by the Adreno 850 GPU in the catalog.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |  2 ++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.c     | 25 +++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a6xx_hfi.h     |  1 +
 4 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index de576816ec7c..83c6f257f478 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -2849,6 +2849,7 @@ static const struct adreno_info a8xx_gpus[] = {
 			.gbif_cx = a850_gbif,
 			.max_slices = 3,
 			.gmu_chipid = 0x80b0100,
+			.thinmem_config = 14,
 			.bcms = (const struct a6xx_bcm[]) {
 				{ .name = "SH0", .buswidth = 32 },
 				{ .name = "MC0", .buswidth = 4 },
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index b50c57f427b4..43273e5f8b5b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -42,6 +42,7 @@ struct cpu_gpu_lock {
  * @hwcg: hw clock gating register sequence
  * @protect: CP_PROTECT settings
  * @pwrup_reglist pwrup reglist for preemption
+ * @thinmem_config: GMU thinmem configuration
  */
 struct a6xx_info {
 	const struct adreno_reglist *hwcg;
@@ -56,6 +57,7 @@ struct a6xx_info {
 	u32 gmu_cgc_mode;
 	u32 prim_fifo_threshold;
 	const struct a6xx_bcm *bcms;
+	u32 thinmem_config;
 };
 
 struct a6xx_gpu {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
index 186a73c0b99c..e33a2258e0f9 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.c
@@ -888,6 +888,27 @@ static int a6xx_hfi_enable_acd(struct a6xx_gmu *gmu)
 	return 0;
 }
 
+static int a6xx_hfi_send_thinmem_config(struct a6xx_gmu *gmu)
+{
+	struct a6xx_gpu *a6xx_gpu = container_of(gmu, struct a6xx_gpu, gmu);
+	struct adreno_gpu *adreno_gpu = &a6xx_gpu->base;
+	const struct a6xx_info *info = adreno_gpu->info->a6xx;
+	u32 data;
+	int ret;
+
+	if (!info->thinmem_config)
+		return 0;
+
+	/* Bits [7:4] contain the thinmem_cfg data. */
+	data = FIELD_PREP(GENMASK(7, 4), info->thinmem_config);
+
+	ret = a6xx_hfi_feature_ctrl_msg(gmu, HFI_FEATURE_THINMEM_CFG, 1, data);
+	if (ret)
+		DRM_DEV_ERROR(gmu->dev, "Unable to send THINMEM_CFG (%d)\n", ret);
+
+	return ret;
+}
+
 static int a6xx_hfi_send_test(struct a6xx_gmu *gmu)
 {
 	struct a6xx_hfi_msg_test msg = { 0 };
@@ -993,6 +1014,10 @@ int a6xx_hfi_start(struct a6xx_gmu *gmu, int boot_state)
 	if (ret)
 		return ret;
 
+	ret = a6xx_hfi_send_thinmem_config(gmu);
+	if (ret)
+		return ret;
+
 	ret = a6xx_hfi_send_core_fw_start(gmu);
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
index e10d32ce93e0..5123349a3de6 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_hfi.h
@@ -244,6 +244,7 @@ struct a6xx_hfi_msg_feature_ctrl {
 #define HFI_FEATURE_TDCVS		30
 #define HFI_FEATURE_DCE			31
 #define HFI_FEATURE_IFF_PCLX		32
+#define HFI_FEATURE_THINMEM_CFG		38
 #define HFI_FEATURE_SOFT_RESET		0x10000001
 #define HFI_FEATURE_DCVS_PROFILE	0x10000002
 #define HFI_FEATURE_FAST_CTX_DESTROY	0x10000003

-- 
2.55.0

