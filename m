Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B592AC55167
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 13:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5B210EF09;
	Thu, 30 Jul 2026 13:29:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LYURgvp1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eMlKMLzi";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 256A510EF24
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:44 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66UDD9TT715207
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4GiyYr8BNvsq5rBrfJ99f2IOVz7T7wBUN5vtVYuv3w8=; b=LYURgvp1IOeS0d3m
 HJGWxB91RSgH72Uo0Wdct4qEB0Z5w9mxpcC7DbYvvYgDuF1tehH0if988qoHbQYq
 Le4FvAaQhwnLlpAhDjC+Uf2YdruL91L9z3E/sI6FTdT6/uBoD8ABT8NfEreerjze
 TUut3vh+uCVTZltfqpNOLy4MeoIYwudZua9D0jXR8J4tbo3jB1qBLkpAkJ22i2zg
 UudXYyrIDWVIK7zHsR4SQ62EX7OnbzzAQEWXvV1kRqS0fuY6ClwmX62gWdItC+ed
 zMIWYBBCVSmlxo21fpgvXeVO9+NLYuIDXOtl9x+2YmLOxlS+lWoJlzX9vsL7aOqL
 LzdfQQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fr6ucr6x5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 13:29:43 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1c7f135bso38164391cf.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785418183; x=1786022983;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4GiyYr8BNvsq5rBrfJ99f2IOVz7T7wBUN5vtVYuv3w8=;
 b=eMlKMLzircPd1VDOcW9g0yk080WgGbD6Y6OkdXeudxq8GKuCJfzYRI+j+cB+bbwGOJ
 zyZL87cmnb5uoQTPQwPIIc+obD0IguPhcJK+IPMR9wzWnUwAlMu5bbvYtqBhGhzNk9s/
 jmbrNrwOhdMSsQJICANUsZhh/FzX4T+f7HjQNT1F8dqYXaOX+4z8e4QbeE3fdVU63Q4M
 YXCBGc2w6DP5cxb6h94A/0VeE6xuCUiCL7ZU3pfwK2WZHY8KDTNrAJe6yn8dqLgruNe1
 DQSVV49jlt5XoBsMscMXi4wom1NB+8hpv8p0FXErZP7FFsPhcyR3frjZiD6H1U8eLpy1
 4Aiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418183; x=1786022983;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4GiyYr8BNvsq5rBrfJ99f2IOVz7T7wBUN5vtVYuv3w8=;
 b=OgJWxM2MUUCdnxV9dmP3Smz3alNQ637B6lNLt6y8qneHYrkiSHd8xxg6AjJRgDmy44
 bFtGfnzl8SZK4mQ0+cbwI3MOJtA0Kj8nh+GGmCQiDCHBOQDrKF8fVdvLArV2X0FjqWVB
 f4k4eA2TUyMwcpY9HjwjRAgeHpLjSwkBUD3qbR/QOpP0jc+AVmrR9ks4H6d3P1v61G3V
 fqG37Zzyjye0qHg52v/Sfc/7vqhgYkphOxqjuieq2bPY7Wd2Nd/0BbgG7QOMki6Mh2d/
 dc1DSS4L/1tTyQuLX38/8ZgdBg2skZ/JwAX1tcJ29vXvRcYQPKfX/JEdcufJgl12ETGX
 B4mA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgMFw+WDgqYn6SffjumXqb1ymBTAyKD84+Wt90kKL0L8nSr6sd0jWKvZzQK1lTbTvbQvMwCTkjfAc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzeEjCnnOQ5/L1GJ5HpH6cANjIOrS4dne8iqPvEP1xMtvh22A58
 oA+k9hxIe06uYfbmvN09UlrkUyauw55lRZ9u4FJCYF+dP8t9Wk/4wyUqDP+H2rJ6kmzgkPx7TkI
 yVV4/rlKw9kQ7sDbd3UEZPBRF4188tZGFNnlbd3Xr8Bsm4PBvIwE9Y9O/KxbXuL6NVGWsDkY=
X-Gm-Gg: AR+sD12vnLgQEgDw7cflizV05dbiw2wYcxjTuoB2FMKby4vFGejNEC/u3YiOqX4hISj
 Vt+DvpSd1DGIp7wqbVra+LUFS6MP51lppdniwzfhQlULFyDlvgTzb2+tEB1vUSEElhL/1KU8WDR
 MrBTImKevVHFYpf4mVQkhXn8+IcXWnOec1efpXtZM+PJTMICHs020m517F7msd9FiyOeUzeTeCj
 4dk2lD8M6QlBlMr8yskSobqFJK2wi6YLFA8Y3FhQf+asF2DxPEyAw0DQrWmUme3bZBFXZNOlyQ8
 hGBcey1Y0lhaCvCprpftZsQTXlQ8mND5WDfgC4rjUr0CL5I7awjUB2CdXS+7NSL5Lt1PBjCPK/P
 Ql5RR6A+jLovU53JQKtjQ2Wm8B/ShS/zk2iA6cyNiZYQOfZnypmCD2w73Efv0uWVbrbTcequpmH
 KdzRSctHW3qRJXHA==
X-Received: by 2002:a05:622a:5ce:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-52b384c4702mr28152601cf.34.1785418182389; 
 Thu, 30 Jul 2026 06:29:42 -0700 (PDT)
X-Received: by 2002:a05:622a:5ce:b0:51b:eb55:2916 with SMTP id
 d75a77b69052e-52b384c4702mr28152121cf.34.1785418181713; 
 Thu, 30 Jul 2026 06:29:41 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-39f6acaa009sm2976631fa.34.2026.07.30.06.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:29:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 30 Jul 2026 16:29:33 +0300
Subject: [PATCH 3/3] drm/msm: detach the ARM DMA mapping before attaching
 our own domain
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260730-fix-qcom-smmu-v1-3-b12fa067804e@oss.qualcomm.com>
References: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
In-Reply-To: <20260730-fix-qcom-smmu-v1-0-b12fa067804e@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Joerg Roedel <jroedel@suse.de>, Russell King <linux@armlinux.org.uk>,
 Lu Baolu <baolu.lu@linux.intel.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heiko Stuebner <heiko@sntech.de>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2725;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=0nxp1o2ipBKscUADiWjzkVftGYkzppsXEG9Cty/+pmo=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1Z24J6b6wVbFP1Dv968/8bQ87nekTkSTCwmWXuZJ85pD
 0p7dd+ok9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATYZZg/5/7tEvjz+Qk7vJX
 k3zOtPEfveHQZOPl4cMrqnnMZovt2isnJ07bw6x5j8vBskrclyXQJOLU3mYN69k+OdufMkn28yd
 oXdC4vNBQvF0jvuL/n/j/7K8ND0z8nx1RFSH2t/XxES9nFumAE3fvXWXY3DaTe9kqjnu9bZuNdo
 dLV1y6baTwef+y11rGEiq3b7B7s71kDXk0Z+4zrVfqWba7mTbLbGKtv2mh8vb1iVWJ3zx2CRku9
 i18yJBVJC0nkiZqmZ1xIevEvNvmuSaTanI/pWr3Ou90PDhR7LSPW+8h1VfV63zFRHgmWO5Su/0z
 ZW7YKlWpl857L8hvdYlhjq6SKXyqyHe6lFEr5nTGR6P5AA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX9r1b3kmy1Q1b
 k6F5u3i0o4/c91zgpQEkdgi496hnwQYiMd6VcsUEknjsJz7jFTK/0Y4ywA+vt4jk6NObij44cEH
 IthmK/1DLYuRocAbz+tKDJgTb9UeLgo=
X-Proofpoint-GUID: FCf6_QFwFcheIQBrjcD0wY7zSM4ke4pz
X-Proofpoint-ORIG-GUID: FCf6_QFwFcheIQBrjcD0wY7zSM4ke4pz
X-Authority-Analysis: v=2.4 cv=W6QIkxWk c=1 sm=1 tr=0 ts=6a6b51c7 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=epCurf6C53ZFYVxhAokA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMwMDEwMiBTYWx0ZWRfX1bQkJIwD2dSe
 nWdpPda2j6LybAziLkaT3lmV1UPLPJ100bYwRGhSu1Zc7Yyd5U/r3+0rtz0ukzvZEJ+SeafkCEi
 oOjb+l8MGZZwG49SAPWmPEsyJ3zLr/CCo/HXkbnCOafY/S0qRaonM+xMaR9KHb72+hxIN+0kHSC
 ZpNe8B6zp6DKcr0ie74o1SLRM7jtozLV1tYPGrUoAz3Vk3rewNa1qIFg321b6WHtkJ5Ue6F8aPU
 ETIWZ4ytxJoc7c3udH6Si2DattNJHANf48LWdee83rO21KeG0nhgowZaF/QM6Qed/lE0ykAhulc
 F5lz/FeVCnU6XaIRHSguclDOrwqmoHgZYeNyxIBjFEYvwsojF+lMHD+A0+5ZV+nHZM4H0VilBLk
 XfWL3rPKZhsAD+d27hlqdMdVoAPNcTrm+I8Ahu8qv0/dsTjK4iVlOOhS4jBYGtG97qY/XLwiCSp
 t6rkRW+bnQsnW8nmTlA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-30_04,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 suspectscore=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607300102
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

On ARM32 with CONFIG_ARM_DMA_USE_IOMMU, arch_setup_dma_ops() creates a
dma_iommu_mapping for every IOMMU-backed device and attaches its domain
to the device's IOMMU group. That domain is neither the group's default
nor its blocking domain, so when msm_iommu_new() later attaches the
domain the driver manages itself, __iommu_attach_group() refuses it:

	if (group->domain && group->domain != group->default_domain &&
	    group->domain != group->blocking_domain)
		return -EBUSY;

Both the GPU and the display controller are hit by this on apq8064
(IFC6410), leaving the board with no GPU and no display:

  adreno 4300000.gpu: failed to load adreno gpu
  adreno 4300000.gpu: probe with driver adreno failed with error -16
  mdp4 5100000.display-controller: [drm:msm_drm_kms_init] *ERROR* failed to load kms
  mdp4 5100000.display-controller: adev bind failed: -16

Other ARM32 DRM drivers that manage their own domains (tegra, rockchip,
exynos) drop the arch mapping first. Do the same in msm_iommu_new(),
which both the display and the GPU paths go through.

With this the GPU and the KMS device both initialise:

  [drm] Initialized msm 1.13.0 for 4300000.gpu on minor 0
  [drm] Initialized msm-kms 1.13.0 for 5100000.display-controller on minor 1

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Assisted-by: Claude:claude-opus-5
---
 drivers/gpu/drm/msm/msm_iommu.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_iommu.c b/drivers/gpu/drm/msm/msm_iommu.c
index 897e42c8d5c8..da6782fca6bd 100644
--- a/drivers/gpu/drm/msm/msm_iommu.c
+++ b/drivers/gpu/drm/msm/msm_iommu.c
@@ -7,6 +7,15 @@
 #include <linux/adreno-smmu-priv.h>
 #include <linux/io-pgtable.h>
 #include <linux/kmemleak.h>
+
+#if defined(CONFIG_ARM_DMA_USE_IOMMU)
+#include <asm/dma-iommu.h>
+#else
+#define arm_iommu_detach_device(...)	({ })
+#define arm_iommu_release_mapping(...)	({ })
+#define to_dma_iommu_mapping(dev)	NULL
+#endif
+
 #include "msm_drv.h"
 #include "msm_gpu_trace.h"
 #include "msm_mmu.h"
@@ -749,6 +758,19 @@ struct msm_mmu *msm_iommu_new(struct device *dev, unsigned long quirks)
 
 	mutex_init(&iommu->init_lock);
 
+	/*
+	 * ARM32 attaches a DMA mapping domain to every IOMMU-backed device,
+	 * which would make attaching our own domain fail with -EBUSY.
+	 */
+	if (IS_ENABLED(CONFIG_ARM_DMA_USE_IOMMU)) {
+		struct dma_iommu_mapping *mapping = to_dma_iommu_mapping(dev);
+
+		if (mapping) {
+			arm_iommu_detach_device(dev);
+			arm_iommu_release_mapping(mapping);
+		}
+	}
+
 	ret = iommu_attach_device(iommu->domain, dev);
 	if (ret) {
 		iommu_domain_free(domain);

-- 
2.47.3

