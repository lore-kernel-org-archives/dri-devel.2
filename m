Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C82AC4451B
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:42:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D882910E4FB;
	Fri, 17 Jul 2026 20:42:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="F8KWpHMR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dWavKSsQ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CBFA710E4F0
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:09 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtadX2780359
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HEJ0uZQVI09LETC6xozJYzAod+qX4DJ0MzQIJLZn12I=; b=F8KWpHMRjsjMPMsl
 iZCB39fkxhgaevrxxSw/OnsjJu9+UxkQXWwyBPOT+jkzHSgljNuwfR7rUYwSxqBj
 97ZmV+/G7hGE5Xy3FoeF2vRifP56AW3n4++Q6qbFuWC9LZDrXBRmsdvMY9Y3m/3W
 JTladnYYNU26T2lZCh4aEjapaV/kTGlnmi8WGIEIlYuvhEiwWdNvxFT/fmuhoQu5
 HNiMz5Mxfl8UV9xci0w+ayfeCtSJ68XMLnAeCljwOQ6KhI7Oaqn3rihx1GWzciVU
 MMb8dhXBsTpKqwWFXnYvm/VipgnF/2ly2maxApBLr7xG32iInLxmzEiovSZ8DRVz
 Ih6oew==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9gu959-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:42:08 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38127ae6b99so2570899a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784320927; x=1784925727;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HEJ0uZQVI09LETC6xozJYzAod+qX4DJ0MzQIJLZn12I=;
 b=dWavKSsQfMsXBZRH8krTPTDSUK1wFjisFWWxQ6DSLGCFcwSYOutpDS5Zh7Q/p2R8rc
 eBROU9S7lgS4jL8SV0AEybFYjZ/m0nEn6cgpQ5QD+PgvxQsg0FKlomanbJu8tTkXJfFj
 rvGCiQH5NcpcISXuks6FSVFyFJcBt6wOsJ9PrMHYZenOK+TrqSKUMSEYN5glS7GQIX8H
 2LKbL7xU1Xe4Lcteeb6GaitlhXoeYSwg9/n2U5wtNh6PopdWcLEThCqPSYMbp6RTUJOK
 3nCHOobl851Bv5cFcNG6MMERAQpNfV54g6aBwd8vM8WLMD6N+tWmoYTX/lVWSse0jOqV
 9m+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784320927; x=1784925727;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HEJ0uZQVI09LETC6xozJYzAod+qX4DJ0MzQIJLZn12I=;
 b=fUHkDi4d/wBQJ7/R+e6wWH0F7k2h3AZYmE7Jn6AXQB8dYo0EyeIVLanJLL/Tqv+bPi
 fel9E20MDqwjjEbCwJEkM6gksC3kbGY3+l9+TS8M2QMyyPcPfZeBP4nINtjBbfDBld7f
 R7yZR0ll1vq4hdElKVKXMOI4f1KsY559NWjQ7qXMl14yu54wJGOAreEwMTs7T7fiTcF+
 sqsFmbnr7wC6+KFjwB6wo8iQPAaiObb/XpOqA1DNzeFpsfwsO6w5wDSKaU0OyzJmQ6OK
 zSL1iS8b+kKY2mO4zjV7Pu+InoWEnQFFyDlGzUvEtTKHYGsMH8vH4sYklckgIUUDpXs6
 PqvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8QDmNO8/MKEjrY2Xl7sauL4sGZi1xllPj4B0SbBT17Vx6TtNJvpKGOYqFmdq8QFbGjdTq+DGnGJo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yze95G8E/J1FjdVusn4oXhvMG0s9J2fvJS0zSdgZlup00I/TYrW
 5IIgvnzYusf3I8w4BGwGjY67tuFlxWyWiyjKTV6xQXOnMcmHRw9yOL9wItvDjPtmL85PjNVJMuy
 Iqwkytv5u9ErVyJk4yS1lQzVwPJWie7tKV0wtUnQ2ibMok2qni59txgqszfKQfBZbym5Lf/I=
X-Gm-Gg: AfdE7cldPvgt3l2SZSixuZAlGW74dDU7U8xOGOK5jgXeRDbRt97SL42K+gxFTXOdVuV
 2kE7TdxKcazanfO4K5/R6ryr6EowVDXfD0l5eXwp+iKC3DfcGb0VkHVNBn29JJ2znhLzL4+8b4u
 7hoz6Vdpcr5ffqahY7x8+HV54B+I5kSQYcMlkYIih4r54ktutc6CQpD3QgM/uShg3XtWm/IJ6js
 PbMrDUU9SM62srwjz4ZWLIAXkUJCPE8X4YEJ2nBQIp9SKluyGNi/H1gauo0Hqz8r6cw+8yd0gSI
 QflwjCSTQM4D+/UCjqG7cdm+9b5LV36GsVCGsl9kyCNMkKTD2eJ17WmK9rEJkoVEHPhnmvblAVA
 +SduttwGl5jVrS4Z5RCrrSX2F
X-Received: by 2002:a17:90b:540f:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38e3d163538mr10090691a91.5.1784320927541; 
 Fri, 17 Jul 2026 13:42:07 -0700 (PDT)
X-Received: by 2002:a17:90b:540f:b0:37f:e5b1:ec4b with SMTP id
 98e67ed59e1d1-38e3d163538mr10090626a91.5.1784320926891; 
 Fri, 17 Jul 2026 13:42:06 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3142a1e348bsm11322997eec.25.2026.07.17.13.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:42:06 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sat, 18 Jul 2026 02:11:27 +0530
Subject: [PATCH v2 2/9] drm/msm/a6xx: Rename GBIF_CX_CONFIG to a A6XX-
 variant register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-eliza-gpu-v2-2-64379dbebd7a@oss.qualcomm.com>
References: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
In-Reply-To: <20260718-eliza-gpu-v2-0-64379dbebd7a@oss.qualcomm.com>
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
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784320899; l=3230;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=OTjz/hUYsdXL1nGMP1P88FY2BvXLf3kfPOscxh457b4=;
 b=arW5LOtnhsz7GNASG3k6T6849UaVGE8SxWpxFRJrV5xGwidmIhco5hKA79Zbb2P93PIK0zXO5
 NW9ANLNRiHjBZZmVwziWRlZIJZJK1ayJsn7ebxeRUw+CxcdiSQZwX1A
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX8IQxk6Tq2dU5
 3/mGpaS0HmBRQbyjcW0WKewTgAWhmcbE88BTXaT9hi2iZ+ft7LwwGxQB9CgEDTOae36qdI5OoTE
 DWfCcgpCviJpo26DIyowEjUA2s24kMY=
X-Proofpoint-ORIG-GUID: r0tjQ2VUhVZ6rhHo-V-v3G_Tx-K0EZPc
X-Proofpoint-GUID: r0tjQ2VUhVZ6rhHo-V-v3G_Tx-K0EZPc
X-Authority-Analysis: v=2.4 cv=TaumcxQh c=1 sm=1 tr=0 ts=6a5a93a0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=W9u8H8Hp_niEWJubwdoA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxMiBTYWx0ZWRfX6SEjFXRCTOiX
 XsX2Fy08LWu94SsQvYaK7zL/Vo/dm1Vxy2IzlCeH1KiGfEyEsdnfGcJUOj/Qwwn7whdw5PgHcUm
 EOY4zcZRKhyLDNYhYvxAH8O+Gmou5Ea8Q7zI0/akzcjsBKbdtEv3iYv+qesb9w66GmXBzXOuoNv
 HcOUm4Pdm9WdlNlxPlp52dknIc5RIHKq1f6dd7d6GKfqrJ8OCZFXry1Sjy4C2YajMydnRS37Jk4
 OiWAKIcq5cpz1kb5dhaf8nR71zyfBF5m2S57gCyv+r8FTh4mersfBepiNVlbJ33NO2cRM0jMRV9
 HTABz/gG92Dfb0oBT5bSX36ZYJvXRvGxRypOimozIZnKcH7ZCxyUB+RvA+kSy81kjvL4c7HFfDc
 yMS+Wdd65RkxZmsjFgJiaMsO1IzlOACSojAW4sJQlCbefOm04NyOiA1eMe9ihTAAttT8qMDcA68
 pqO6UzxidHEbD7Qr/Lg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 adultscore=0 phishscore=0
 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170212
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

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
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

