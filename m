Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40985C43602
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 08:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C30E10E15C;
	Sun,  5 Jul 2026 08:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SLZNNmCl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PahGOW1w";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15AD110E15C
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 08:14:54 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6655H49c829146
 for <dri-devel@lists.freedesktop.org>; Sun, 5 Jul 2026 08:14:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1TkRZqzKaTEbf88oqgt4IklNVBeRmMVYMA2DtoASnZk=; b=SLZNNmCligj73r9a
 HmTSVxVWqJcHqpk5129dmpy7qmKlR3hvUrApOZdaL/B6xsrRis07VNYTQb3NuaiO
 E1V7NU/NgcStSN4LHLkr6K43wagLw1Uz3I5JcnoS3rTHHSm/IudS+ngwDC2Pvr8d
 qJjX6kuo6A1UuSChmy9ncv0KL50r6SLdjvCyeQ7hbS66oaOsZ4khPDchsMJmGq1+
 xAQxIsqsxDgVnVZB3KLIKCW7m9WWwhrVZbK7qWZhcT/4R1PvMGXu+kKdOnD59gYx
 vF39FU9+LoYsF+cnyBpU+lEWhh2Ikb0vCoWJwtxqcfXiTGObZxASozwujX6u/dp9
 24bQ+g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6td3aanx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 08:14:53 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so6964885ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 01:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783239293; x=1783844093;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=1TkRZqzKaTEbf88oqgt4IklNVBeRmMVYMA2DtoASnZk=;
 b=PahGOW1wuPU8Ozs1bfU0XxKBTm8MY/vJeTiXDL+eoQuG254E9P8AzsSrkzjibtU5Q8
 ++pkD3cO64oiDgj3KBouMQu38MOA4GW2C5CStX05aTDn1SlxVyACcN4hzA5wtNolQjOX
 NZfBme1pjhClfovW/avPX/bBc3p/m2pQRCguTLwrmM8R+zfQByE5auT01IPhvCOi5zTM
 ULPRL2eUpt1MytrHc0zaGdZLhXJTATpG7W6BEJz3ZMYo9PvzRx0W4QEaCDl2Cb3ImYtQ
 pZppxmTK/bsfj48pzBLyNOuOqmWP/OFnvIXYKy2Pa/GtEXf/eHgFRpIos6MUsTeAFHXW
 usdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783239293; x=1783844093;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1TkRZqzKaTEbf88oqgt4IklNVBeRmMVYMA2DtoASnZk=;
 b=jnlLVhXyHLpG1KhmcBttl/+sQ/KksDyfdxsxkMSOUEdL7Pjmr3fUZO+UuKILREbpE2
 vcQp70lGYzMfhdujuTbm2DIfC8igKtEV8aDBWPzgoYiFjjsoUAfJH7bJ/c4XDe0Cj6pp
 7QNX2lSNFBLywU3FuHntovNzHOG7a1SCk/Q01urruxjiiKKQ8DHy+hNHo7MmT6DPjoDq
 pjxIPbXklMbzNGH/odbe61ahV/WP76Ji9tm78gpZ2GZWow1oubeDeJ13NJ+nKTuuAqeH
 Ku6lwVSo7baQSXW2Gsi27TTNA++HJ6QextkpCzWD0Tw0cvYQl6Orin+hiD0n2VR73t9r
 Wpyw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQFW5Ie0/11BTyrV+mB7nh6Zo8S9rAKYLtC3FLeHOGevW62LVK1EO2Hd8sGzWW1hUleWSM2zQHBa4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzaraPyCmYM0XPTtpOpbu9h6Q8P1pZnbBN/AGIpkktsC+RHI7vB
 OaaoUuzTH30gAEsOfPyq0YzmawM9C0l53FVZ3xzbzs+zpS1GXBNUh3O+pPxIRH10FzR2M2Xj37g
 3KC886AUeWjM/PRZm+6SN/pozWpPwriiUmvetpxGzNPbI3Eo9Xlbi8Bh3IE6mnUcSCR3oLmU=
X-Gm-Gg: AfdE7ckhXyy/VydoyU9ej6YizdxpblwX/sOibudTROz8mQ9sm7D02xpq+7dTBhH4upQ
 X+DBDJfz7oq48LWpwFy+vGYxwR6lt6DqKGVID2HAM3wbtNXaSycJhzvdUBulKcPyk5hK+Wug3nf
 9FcR3XYGzGUdfxNwhVhBRpv4KwbXWTHiisjoDtbRCRa1E7qmQ0znpYr6ZKHxtIL3ZB3tJkeLtBK
 0z/QufIxkxftzRO93MnREFDv0NhqG9RxbXW2h9KFukIg9MEjT4Fa+kGjMj+2kCCBE22/zeHKNZk
 78K7USthgjDKVBtXCIhllEXE2zVtI0wSAhRwuoVDgm+L/bvBJGXqMFhzP8KuolhHesRNnJxo+3i
 vA+xhuBZWfoYqI2Pt9TvwBZNktV5IWKqSCLQ=
X-Received: by 2002:a17:903:2b0c:b0:2cc:5fae:cc36 with SMTP id
 d9443c01a7336-2cc5faeceb4mr48253395ad.11.1783239292354; 
 Sun, 05 Jul 2026 01:14:52 -0700 (PDT)
X-Received: by 2002:a17:903:2b0c:b0:2cc:5fae:cc36 with SMTP id
 d9443c01a7336-2cc5faeceb4mr48253135ad.11.1783239291889; 
 Sun, 05 Jul 2026 01:14:51 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b3c85d4fesm36403980c88.11.2026.07.05.01.14.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 01:14:51 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 05 Jul 2026 13:44:17 +0530
Subject: [PATCH 2/8] drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX- variant
 register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-eliza-gpu-v1-2-c9f1354dbd29@oss.qualcomm.com>
References: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
In-Reply-To: <20260705-eliza-gpu-v1-0-c9f1354dbd29@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, "Joerg Roedel (AMD)" <joro@8bytes.org>
Cc: Puranam V G Tejaswi <puranam.tejaswi@oss.qualcomm.com>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783239265; l=3102;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=ycJJry48vK1w/9pKWHhMt2Pa7b3Ht8W/8/Z4qRb1cBM=;
 b=RzMbhCYJ2ZVJ46j3xP2zUIMGGw8WVIy+lZYD70YsCCbS1sIJXmkNFXeiuEyreMuBB7MYQZS1g
 RXh6zlYFDeoD3GtnpNrTlKyIUkDM7BSY1PSqKYgqQVY0hbbpW7vVH5g
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfXxR699NoA7M7a
 doifBaQmoDKjgm17Zi3jKV01AgjjY/YS1Kp7yu0y5gLYL/aTEbYPWxK3aLlFQ+j/3oubg/WcCXl
 f3lm/Uag6Vg//IOZUNWvp4FoIs8ymCY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDA4MiBTYWx0ZWRfX7bDRyaSd014O
 kD01n4vX0DygnWArPb0sYB1yQ0yEKBxQae4eOIuaIljSu8PPGH6bkDYDGxc/v1+XEg/+g4BC1Qb
 l6dn1AQtKZGqjuJT9x6O7vLREorFKf/eHBEgkNtck8znwTk/LzJq77rD/UVDmYbZZwh1XzxcuVq
 0O8xo/xiomZ+wSsq5YxM7QPuE/jVwFVvcBFeoSHAfmfFeBPpsD3s5LMrHwpcC6v+GYoSktbzxgP
 zjwmmq9L4OrgAyzgAbvxAW/BtKSFDFvjh7MMY6xLKTPxqKY/N9V4x94nZWF2uumQx9rPzJtvusW
 oQwG68wwxpZxMzbNRc8uKQphEKBGVQXW56HexoA2P8jB9S2nbgWwrl7wsnu0OnXosA18D0tFVg4
 PFeBSscbRGAn6FPFMJvCAAzOtxc9kxYXzW/VutaiDO4jsX49XfdAd5xS4yFnjEVGkHylMx1IGwR
 3vd4p5t6Wt/OwY2ofQQ==
X-Proofpoint-GUID: khc0MWv8eqHGgxQKNNXannekg7BH5ov-
X-Proofpoint-ORIG-GUID: khc0MWv8eqHGgxQKNNXannekg7BH5ov-
X-Authority-Analysis: v=2.4 cv=b9GCJNGx c=1 sm=1 tr=0 ts=6a4a127d cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=W9u8H8Hp_niEWJubwdoA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-04_03,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050082
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

The GBIF_CX_CONFIG register exists on GPUs prior to A8XX (it is used on
A722, for example), so it should be tagged as an A6XX variant to match
the register spec. Widen its variant range from "A8XX-" to "A6XX-" in the
register XML and rename the generated macro accordingly at all existing
usage sites.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c     | 2 +-
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c         | 2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c         | 2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx.xml | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index a98d550b72d0..4b68416e4d05 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -2180,7 +2180,7 @@ static const struct adreno_reglist a840_gbif[] = {
 	{ REG_A6XX_GBIF_QSB_SIDE1, 0x00071e20 },
 	{ REG_A6XX_GBIF_QSB_SIDE2, 0x00071e20 },
 	{ REG_A6XX_GBIF_QSB_SIDE3, 0x00071e20 },
-	{ REG_A8XX_GBIF_CX_CONFIG, 0x20023000 },
+	{ REG_A6XX_GBIF_CX_CONFIG, 0x20023000 },
 	{ },
 };
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2e5d7b53a0c3..4a3c8dc8bb88 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1032,7 +1032,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 		gpu_write(gpu, gbif_cx[i].offset, gbif_cx[i].value);
 
 	if (adreno_is_a8xx(adreno_gpu)) {
-		gpu_write(gpu, REG_A8XX_GBIF_CX_CONFIG, 0x20023000);
+		gpu_write(gpu, REG_A6XX_GBIF_CX_CONFIG, 0x20023000);
 		gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
 	}
 
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 9e44fd1ae634..6a75bfb6cec1 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -228,7 +228,7 @@ static void a8xx_set_hwcg(struct msm_gpu *gpu, bool state)
 		 * GMU enables clk gating in GBIF during boot up. So,
 		 * override that here when hwcg feature is disabled
 		 */
-		gpu_rmw(gpu, REG_A8XX_GBIF_CX_CONFIG, BIT(0), 0);
+		gpu_rmw(gpu, REG_A6XX_GBIF_CX_CONFIG, BIT(0), 0);
 	}
 }
 
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
index 3349c01646e1..69dd0446f8d2 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx.xml
@@ -1268,7 +1268,7 @@ by a particular renderpass/blit.
 	<reg32 offset="0x3119" name="VBIF_PERF_PWR_CNT_HIGH1" variants="A6XX"/>
 	<reg32 offset="0x311a" name="VBIF_PERF_PWR_CNT_HIGH2" variants="A6XX"/>
 
-	<reg32 offset="0x3c00" name="GBIF_CX_CONFIG" variants="A8XX-"/>
+	<reg32 offset="0x3c00" name="GBIF_CX_CONFIG" variants="A6XX-"/>
 	<reg32 offset="0x3c01" name="GBIF_SCACHE_CNTL0"/>
 	<reg32 offset="0x3c02" name="GBIF_SCACHE_CNTL1"/>
 	<reg32 offset="0x3c03" name="GBIF_QSB_SIDE0"/>

-- 
2.54.0

