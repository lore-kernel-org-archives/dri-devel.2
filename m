Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3745C5AD4E
	for <dri-devel@archiver.kernel.org>; Sat,  8 Aug 2026 20:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F249310E082;
	Sat,  8 Aug 2026 20:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1dmMkXN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Mp/WSsjr";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1EEF10E082
 for <dri-devel@lists.freedesktop.org>; Sat,  8 Aug 2026 20:23:32 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 678JwAoU1055011
 for <dri-devel@lists.freedesktop.org>; Sat, 8 Aug 2026 20:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 FDqkagTPQACDOXZY1P3gUVjoqzvDSmh+t7K7Az44YvA=; b=p1dmMkXNeKi4Cnxx
 zQC2hSeYkfBPv1+3udrG1knnbtU2Bu9iCV3JYHM8Q7xpwxO3n8xEOAa5c1rc6uwf
 +PwQlIvOjQqAHswympknbhAdI8DV1ZycKKij04GJtegbgoJjNpkPg4wX5+mgOaUZ
 q2FvyfRUUW/2F5cS1OIb3YX74HOz7L+hkzYsabNaPoqnvrG0qfZxrdSFo2mS9QA1
 c+3+WTuPEBrbvXP6ZkWFM5yDnfW7qz11rkf5bJ2o7wdruq4BYoss10X+h9MCmBz8
 3G3strV4ylesZGosajJ/ecldTGA0Dl6wrGXXk36yR865XeovcQHABOYiNJ067RXo
 kCgIjw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fwuf79rvs-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 20:23:31 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c856470fe9fso418652a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 13:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786220610; x=1786825410;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FDqkagTPQACDOXZY1P3gUVjoqzvDSmh+t7K7Az44YvA=;
 b=Mp/WSsjrAmdYFK5I8Xy3ADPZakyX2RUJMWV96IJuvBSXBU5sm4/Cu9zfQsyyXJ1EXP
 aVNWigChqbjgPDCnrxuzmowQ4Zlv5kX5WECOnC+NvqDGoKKwcwOT5lE3RmN1VhRGymUP
 fSq0n8GfS6UE70JaQIfaPamGIGehnPj93sscIkrduE8WnhdAxYz+mGKqQ0Zr+zBFqfXc
 Z31lzvIpkhGiXyS7ueNUhZIjeKLksdzftYswCTYAbtU/Ils5nV92529dDdVrtjHkyweZ
 IRiZIT02f3Sm7PhVIUhxtFX63TKZq3OQ93CCaFl9P2t5ClIjy7SsdgDTr+q+rctDhng1
 Dv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786220610; x=1786825410;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FDqkagTPQACDOXZY1P3gUVjoqzvDSmh+t7K7Az44YvA=;
 b=ALj82ZlYud4jp7LcXeNviM4F7ukBiQNMzp9lJbhtDqBD10Cyp4Lf/ZAWt23+RTGpyJ
 cHoZFOnii7mTs7yytDLvq7Q31HFT1qe1GPMyLrlhJBb2kjRlJ9D7YgIOKE4peo8mbJy9
 3mzRGR013bY1o1HaJwD7Qxj47VJPXwW+pQa6UzfTDQ2eGDwFby8NR5xxHZEU10EnvYDN
 cff4EBxxXJ5PJnptyblIU53OmgL1cztZ3H/tSxgyd+hJ9mNVQYPOyHZrHec/WMCqmkHF
 kSSAIwwcAq9G0fuoyivAJaQSBR5IC0yn1MSdH+PZSMBvo66XVDXTP+9zXPSU/BoEPw3W
 LQOg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rolz209CkEWMOo07XXGP3sAukEcf8vLvcG9sPT6Egjs3qaPE0Rz64RVkqXCJeKtQ34EKMMCaqo+xbs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwmvUbyeJWCD/d+bUF25+3JMJVEOyHmI62z1/tAEF0yEyEwHjV9
 uJvFX2KXD7ovtzGkU6olI+9a0In6r3DrD4iMVYfsW0edonNyJhUSygRpzAavnYRdZHitz1N53Q5
 QEUU6Zu0fN89fhMt59K1ee7wv6Phu3wum+lC+ASoXy9r3ttQn48tpSTIPaWYO0mK4O1EejrM=
X-Gm-Gg: AR+sD10TgKKKwj12PsNfq8knlvZBYclc7udqpA09Z4CBKeYoFqVktpKKo6f1tXKW/c0
 Jbrlq674+OgsxjKfGg533yGQ+WY00N9lBkW2Q9VKOT41klXQF+r152i/1Xc12bG5dZ4v3ZNJO5l
 QkmJRwejGT+3GiA5YgoXNO9yFuNSprJk38SXSLmkv1KzU1LQnTNzFx23ZxMNFcvwav+SUXUiCDH
 /oGEDdkyq4IPGoJd+O1nRazEuVb1mOwXmrLJEG67fBFLJwuyzeTK+SQWBPO5CaHOCon2LliMGoC
 AZF5AnwcnEkST+QXggyDn3Li73P6QLS66CW98M/aPgURh0rOnP0SRtkbaQRs0bNayj0D9fSWsK3
 R4UbLUU3DSrDYkLOczBf0QOUf
X-Received: by 2002:a05:6a20:94cd:b0:3c3:8d4c:6673 with SMTP id
 adf61e73a8af0-3cbcea2730amr12021850637.37.1786220610089; 
 Sat, 08 Aug 2026 13:23:30 -0700 (PDT)
X-Received: by 2002:a05:6a20:94cd:b0:3c3:8d4c:6673 with SMTP id
 adf61e73a8af0-3cbcea2730amr12021791637.37.1786220609533; 
 Sat, 08 Aug 2026 13:23:29 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be86e917sm26357417eec.5.2026.08.08.13.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Aug 2026 13:23:29 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Sun, 09 Aug 2026 01:53:08 +0530
Subject: [PATCH 1/6] drm/msm/a8xx: Add support for Adreno 830 GPU
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260809-pakala-gpu-v1-1-207ad1fac1c7@oss.qualcomm.com>
References: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
In-Reply-To: <20260809-pakala-gpu-v1-0-207ad1fac1c7@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786220595; l=17236;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=EKgPaLE8/LHgm30NviZws8p0cal67wtIuQjQQ2tc2yA=;
 b=9drCskYgtsSudF7Jq7iRJUa/nAGY/YRaK7+Pyntp4ZQ4SUoEjyMsC3+MHev6RUCqAlNpc0jZ7
 r/Bw45YnlD2A1fhW43mP2WZXwTrNautIKVL+ixLA5xgpnh0n2VOfodx
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX4XvGzMUt3DhD
 spX6WpmNuLxJJKvZXIkJqTxCmlP5mpcgA2xoop01q92iWeucBofTbDVnHZlLx0g3kHGHfRJOvzc
 CfcKYUjX3UgZDvO1EkZ76e08jxMJKeE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA4MDE3NiBTYWx0ZWRfX/5giBU0gLY1N
 IDMyWRiGUaKqNBOILne+lxvnHAf2WBJT7lWsxSKp545APmturgFTDakU+V0nYF7/1jwN/RjSD8c
 xggODjKOrWRnkPisGCzC2xKgKt2QOmcKLb4vDHDGELHhAJvl9eEybHFQ/Qsr4gQCuksKcaiiAqM
 6eFwrr64AMNdBO4Hg1ho34Fp29g4//1dYL94FwFTfS5vDacomOe+rgOd0iECPqh2ho8EP8Dcp5V
 BYHVCye0O1k6rIyflMVXbIENg76CRD19LIp5jZ6ddkbVIsHqgYafq/G5cR8AEUXisO9bsfNieBE
 6IvjS8HCUVxgtGoFhFZ0pfzDnz4nwkyK7vM6Clhvwu0rT98wV0e1fcs08oCkMsOxKv8pn9DxfR+
 ZcQbeRt2t/2l5/u8LmX5bku41EL9wjSCy/VwjIkVg7VrTjYZuuebR7/PerPK/9EUOLVmV6dBgdU
 WNXoaffZMVxHO+XzIiQ==
X-Authority-Analysis: v=2.4 cv=ecENubEH c=1 sm=1 tr=0 ts=6a779043 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=dJSqcjJV3w71M6jyNNgA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: UoUH5323yqgnzRewM3BA8TQ7LERx4fkR
X-Proofpoint-GUID: UoUH5323yqgnzRewM3BA8TQ7LERx4fkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-08_07,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 malwarescore=0 spamscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608080176
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

From: Jie Zhang <jie.zhang@oss.qualcomm.com>

Add support for the Adreno 830 GPU present in SM8750 SoC. Adreno 830 GPU
belongs to the A8x Gen 1 family and it is architecturally close Adreno 840.
Add a new catalog entry along with the register list to enable support
for this GPU.

Signed-off-by: Jie Zhang <jie.zhang@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 334 ++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |   2 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |   5 +
 3 files changed, 340 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 90a0c7ffb3c8..418edde9104e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1693,6 +1693,294 @@ static const struct adreno_info a7xx_gpus[] = {
 };
 DECLARE_ADRENO_GPULIST(a7xx);
 
+static const struct adreno_reglist_pipe a830_nonctxt_regs[] = {
+	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
+	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0x00000001, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0x10010000, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0x00000002, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_PC_CHICKEN_BITS_1, 0x00000003, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_PC_CHICKEN_BITS_2, 0x00000200, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_PC_CHICKEN_BITS_3, 0x00400000, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_PC_CHICKEN_BITS_4, 0x00500050, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	/* Configure GBIF GX registers */
+	{ REG_A8XX_UCHE_GBIF_GX_CONFIG, 0x010240e0, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_GBIF_CLIENT_QOS_CNTL, 0x22122212, BIT(PIPE_NONE) },
+	/* Enable full concurrent resolve and unresolves */
+	{ REG_A7XX_RB_CCU_CNTL, 0x00000068, BIT(PIPE_BR) },
+	/* Partially enable perf clear, Disable DINT to c/z be data forwarding */
+	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0x00002200, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0x0c000000, BIT(PIPE_BR) },
+	/* Configure number of outstanding transactions to 32 */
+	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0x00000007, BIT(PIPE_BR) },
+	/* Configure UCHE request time out to 16 cycles for CCU/UCHE arbitration */
+	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0x00004000, BIT(PIPE_BR) },
+	{ REG_A8XX_RBBM_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_SLICE_NC_MODE_CNTL, 0x00000001, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL, 0x00000030, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_WAIT_IDLE_CLOCKS_CNTL2, 0x00000030, BIT(PIPE_NONE) },
+	{ REG_A8XX_RBBM_CGC_P2S_CNTL, 0x00000040, BIT(PIPE_NONE) },
+	/* Enable contribution of all shader stages to SP perfcounters */
+	{ REG_A6XX_SP_PERFCTR_SHADER_MASK, 0x0000003f, BIT(PIPE_NONE) },
+	/*
+	 * BIT(26): Limit the number of wave-slots for Eviction buffer to 1 per ALU GRP
+	 * BIT(30): Disable LPAC auto-promotion
+	 */
+	{ REG_A7XX_SP_CHICKEN_BITS_1, BIT(26) | BIT(30), BIT(PIPE_NONE) },
+	/*
+	 * BIT(22): Disable PS out of order retire
+	 * BIT(23): Enable half wave mode and MM instruction src&dst is half precision
+	 */
+	{ REG_A7XX_SP_CHICKEN_BITS_2, BIT(22) | BIT(23), BIT(PIPE_NONE) },
+	{ REG_A7XX_SP_CHICKEN_BITS_3, 0x00300000, BIT(PIPE_NONE) },
+	{ REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP, 0x00000080,  BIT(PIPE_NONE) },
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL, 0x10000000, BIT(PIPE_NONE) },
+	/* Enable cubemap small miplevel optimization settings */
+	/* BIT(26): Disable final clamp for bicubic filtering */
+	{ REG_A6XX_TPL1_DBG_ECO_CNTL1, 0x04000724, BIT(PIPE_NONE) },
+	/* Disable tag bank id hashing */
+	{ REG_A6XX_UCHE_MODE_CNTL, 0x00080000, BIT(PIPE_NONE) },
+	{ REG_A8XX_UCHE_CCHE_MODE_CNTL, 0x00001000, BIT(PIPE_NONE) },
+	/* Limit gmem number of ways for GMEM requests in each set */
+	{ REG_A8XX_UCHE_CCHE_CACHE_WAYS, 0x00000800, BIT(PIPE_NONE)},
+	/* Disable write slow pointer in data phase queue */
+	{ REG_A8XX_UCHE_HW_DBG_CNTL, BIT(8), BIT(PIPE_NONE) },
+	/* Configure UCHE to CCU switchthreshold timeout cycles */
+	{ REG_A8XX_UCHE_VARB_IDLE_TIMEOUT, 0x00000020, BIT(PIPE_NONE) },
+	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0x00008000, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0x00500050, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0x00600060, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0x00200020, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0x00100020, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0x00000001, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	/* Disable redundant tile data optimization */
+	{ REG_A8XX_VSC_KMD_DBG_ECO_CNTL, BIT(11), BIT(PIPE_NONE)},
+	{ },
+};
+
+static const u32 a830_protect_regs[] = {
+	A6XX_PROTECT_RDONLY(0x00000, 0x03a3),
+	A6XX_PROTECT_RDONLY(0x003b4, 0x008b),
+	A6XX_PROTECT_NORDWR(0x00440, 0x001f),
+	A6XX_PROTECT_RDONLY(0x00580, 0x005f),
+	A6XX_PROTECT_NORDWR(0x005e0, 0x011f),
+	A6XX_PROTECT_RDONLY(0x0074a, 0x0005),
+	A6XX_PROTECT_RDONLY(0x00759, 0x0026),
+	A6XX_PROTECT_RDONLY(0x00789, 0x0000),
+	A6XX_PROTECT_RDONLY(0x0078c, 0x0013),
+	A6XX_PROTECT_NORDWR(0x00800, 0x0029),
+	A6XX_PROTECT_NORDWR(0x00837, 0x00af),
+	A6XX_PROTECT_RDONLY(0x008e7, 0x00c9),
+	A6XX_PROTECT_NORDWR(0x008ec, 0x00c3),
+	A6XX_PROTECT_NORDWR(0x009b1, 0x0250),
+	A6XX_PROTECT_RDONLY(0x00ce0, 0x0001),
+	A6XX_PROTECT_RDONLY(0x00df0, 0x0000),
+	A6XX_PROTECT_NORDWR(0x00df1, 0x0000),
+	A6XX_PROTECT_NORDWR(0x00e01, 0x0000),
+	A6XX_PROTECT_NORDWR(0x00e03, 0x1fff),
+	A6XX_PROTECT_NORDWR(0x03c00, 0x00c5),
+	A6XX_PROTECT_RDONLY(0x03cc6, 0x1fff),
+	A6XX_PROTECT_NORDWR(0x08600, 0x01ff),
+	A6XX_PROTECT_NORDWR(0x08e00, 0x00ff),
+	A6XX_PROTECT_RDONLY(0x08f00, 0x0000),
+	A6XX_PROTECT_NORDWR(0x08f01, 0x01be),
+	A6XX_PROTECT_NORDWR(0x09600, 0x01ff),
+	A6XX_PROTECT_RDONLY(0x0981a, 0x02e5),
+	A6XX_PROTECT_NORDWR(0x09e00, 0x01ff),
+	A6XX_PROTECT_NORDWR(0x0a600, 0x01ff),
+	A6XX_PROTECT_NORDWR(0x0ae00, 0x0000),
+	A6XX_PROTECT_NORDWR(0x0ae02, 0x0004),
+	A6XX_PROTECT_NORDWR(0x0ae08, 0x0006),
+	A6XX_PROTECT_NORDWR(0x0ae10, 0x036f),
+	A6XX_PROTECT_NORDWR(0x0b600, 0x1fff),
+	A6XX_PROTECT_NORDWR(0x0dc00, 0x1fff),
+	A6XX_PROTECT_RDONLY(0x0fc00, 0x1fff),
+	A6XX_PROTECT_NORDWR(0x18400, 0x003f),
+	A6XX_PROTECT_RDONLY(0x18440, 0x013f),
+	A6XX_PROTECT_NORDWR(0x18580, 0x1fff),
+	A6XX_PROTECT_NORDWR(0x1b400, 0x1fff),
+	A6XX_PROTECT_NORDWR(0x1f400, 0x0477),
+	A6XX_PROTECT_RDONLY(0x1f878, 0x0787),
+	A6XX_PROTECT_NORDWR(0x1f930, 0x0329),
+	A6XX_PROTECT_NORDWR(0x20000, 0x1fff),
+	A6XX_PROTECT_NORDWR(0x27800, 0x007f),
+	A6XX_PROTECT_RDONLY(0x27880, 0x0381),
+	A6XX_PROTECT_NORDWR(0x27882, 0x0001),
+	A6XX_PROTECT_NORDWR(0x27c02, 0x0000),
+};
+DECLARE_ADRENO_PROTECT(a830_protect, 64);
+
+static const u32 a830_pwrup_reglist_regs[] = {
+	REG_A6XX_UCHE_MODE_CNTL,
+	REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
+	REG_A8XX_UCHE_GBIF_GX_CONFIG,
+	REG_A8XX_UCHE_CACHE_WAYS,
+	REG_A8XX_UCHE_CCHE_MODE_CNTL,
+	REG_A8XX_UCHE_CCHE_CACHE_WAYS,
+	REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN,
+	REG_A8XX_UCHE_CCHE_GC_GMEM_RANGE_MIN + 1,
+	REG_A8XX_UCHE_CCHE_LPAC_GMEM_RANGE_MIN,
+	REG_A8XX_UCHE_CCHE_LPAC_GMEM_RANGE_MIN + 1,
+	REG_A8XX_UCHE_CCHE_TRAP_BASE,
+	REG_A8XX_UCHE_CCHE_TRAP_BASE + 1,
+	REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE,
+	REG_A8XX_UCHE_CCHE_WRITE_THRU_BASE + 1,
+	REG_A8XX_UCHE_HW_DBG_CNTL,
+	REG_A8XX_UCHE_WRITE_THRU_BASE,
+	REG_A8XX_UCHE_WRITE_THRU_BASE + 1,
+	REG_A8XX_UCHE_TRAP_BASE,
+	REG_A8XX_UCHE_TRAP_BASE + 1,
+	REG_A8XX_UCHE_CLIENT_PF,
+	REG_A8XX_VSC_KMD_DBG_ECO_CNTL,
+	REG_A8XX_RB_CMP_NC_MODE_CNTL,
+	REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP,
+	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN,
+	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN + 1,
+	REG_A7XX_SP_READ_SEL,
+	REG_A6XX_TPL1_NC_MODE_CNTL,
+	REG_A6XX_TPL1_DBG_ECO_CNTL,
+	REG_A6XX_TPL1_DBG_ECO_CNTL1,
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(0),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(1),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(2),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(3),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(4),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(5),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(6),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(7),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(8),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(9),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(10),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(11),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(12),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(13),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(14),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(15),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(16),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(17),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(18),
+	REG_A8XX_TPL1_BICUBIC_WEIGHTS_TABLE(19),
+};
+DECLARE_ADRENO_REGLIST_LIST(a830_pwrup_reglist);
+
+static const u32 a830_ifpc_reglist_regs[] = {
+	REG_A8XX_RBBM_NC_MODE_CNTL,
+	REG_A8XX_RBBM_SLICE_INTERFACE_HANG_INT_CNTL,
+	REG_A8XX_RBBM_SLICE_NC_MODE_CNTL,
+	REG_A6XX_SP_NC_MODE_CNTL,
+	REG_A8XX_SP_HLSQ_LPAC_GMEM_RANGE_MIN,
+	REG_A8XX_SP_HLSQ_LPAC_GMEM_RANGE_MIN + 1,
+	REG_A7XX_SP_CHICKEN_BITS_1,
+	REG_A7XX_SP_CHICKEN_BITS_2,
+	REG_A7XX_SP_CHICKEN_BITS_3,
+	REG_A6XX_SP_PERFCTR_SHADER_MASK,
+	REG_A7XX_SP_HLSQ_DBG_ECO_CNTL,
+	REG_A8XX_CP_INTERRUPT_STATUS_MASK_GLOBAL,
+	REG_A8XX_RBBM_PERFCTR_CNTL,
+	REG_A8XX_CP_PROTECT_GLOBAL(0),
+	REG_A8XX_CP_PROTECT_GLOBAL(1),
+	REG_A8XX_CP_PROTECT_GLOBAL(2),
+	REG_A8XX_CP_PROTECT_GLOBAL(3),
+	REG_A8XX_CP_PROTECT_GLOBAL(4),
+	REG_A8XX_CP_PROTECT_GLOBAL(5),
+	REG_A8XX_CP_PROTECT_GLOBAL(6),
+	REG_A8XX_CP_PROTECT_GLOBAL(7),
+	REG_A8XX_CP_PROTECT_GLOBAL(8),
+	REG_A8XX_CP_PROTECT_GLOBAL(9),
+	REG_A8XX_CP_PROTECT_GLOBAL(10),
+	REG_A8XX_CP_PROTECT_GLOBAL(11),
+	REG_A8XX_CP_PROTECT_GLOBAL(12),
+	REG_A8XX_CP_PROTECT_GLOBAL(13),
+	REG_A8XX_CP_PROTECT_GLOBAL(14),
+	REG_A8XX_CP_PROTECT_GLOBAL(15),
+	REG_A8XX_CP_PROTECT_GLOBAL(16),
+	REG_A8XX_CP_PROTECT_GLOBAL(17),
+	REG_A8XX_CP_PROTECT_GLOBAL(18),
+	REG_A8XX_CP_PROTECT_GLOBAL(19),
+	REG_A8XX_CP_PROTECT_GLOBAL(20),
+	REG_A8XX_CP_PROTECT_GLOBAL(21),
+	REG_A8XX_CP_PROTECT_GLOBAL(22),
+	REG_A8XX_CP_PROTECT_GLOBAL(23),
+	REG_A8XX_CP_PROTECT_GLOBAL(24),
+	REG_A8XX_CP_PROTECT_GLOBAL(25),
+	REG_A8XX_CP_PROTECT_GLOBAL(26),
+	REG_A8XX_CP_PROTECT_GLOBAL(27),
+	REG_A8XX_CP_PROTECT_GLOBAL(28),
+	REG_A8XX_CP_PROTECT_GLOBAL(29),
+	REG_A8XX_CP_PROTECT_GLOBAL(30),
+	REG_A8XX_CP_PROTECT_GLOBAL(31),
+	REG_A8XX_CP_PROTECT_GLOBAL(32),
+	REG_A8XX_CP_PROTECT_GLOBAL(33),
+	REG_A8XX_CP_PROTECT_GLOBAL(34),
+	REG_A8XX_CP_PROTECT_GLOBAL(35),
+	REG_A8XX_CP_PROTECT_GLOBAL(36),
+	REG_A8XX_CP_PROTECT_GLOBAL(37),
+	REG_A8XX_CP_PROTECT_GLOBAL(38),
+	REG_A8XX_CP_PROTECT_GLOBAL(39),
+	REG_A8XX_CP_PROTECT_GLOBAL(40),
+	REG_A8XX_CP_PROTECT_GLOBAL(41),
+	REG_A8XX_CP_PROTECT_GLOBAL(42),
+	REG_A8XX_CP_PROTECT_GLOBAL(43),
+	REG_A8XX_CP_PROTECT_GLOBAL(44),
+	REG_A8XX_CP_PROTECT_GLOBAL(45),
+	REG_A8XX_CP_PROTECT_GLOBAL(46),
+	REG_A8XX_CP_PROTECT_GLOBAL(47),
+	REG_A8XX_CP_PROTECT_GLOBAL(48),
+	REG_A8XX_CP_PROTECT_GLOBAL(49),
+	REG_A8XX_CP_PROTECT_GLOBAL(50),
+	REG_A8XX_CP_PROTECT_GLOBAL(51),
+	REG_A8XX_CP_PROTECT_GLOBAL(52),
+	REG_A8XX_CP_PROTECT_GLOBAL(53),
+	REG_A8XX_CP_PROTECT_GLOBAL(54),
+	REG_A8XX_CP_PROTECT_GLOBAL(55),
+	REG_A8XX_CP_PROTECT_GLOBAL(56),
+	REG_A8XX_CP_PROTECT_GLOBAL(57),
+	REG_A8XX_CP_PROTECT_GLOBAL(58),
+	REG_A8XX_CP_PROTECT_GLOBAL(59),
+	REG_A8XX_CP_PROTECT_GLOBAL(60),
+	REG_A8XX_CP_PROTECT_GLOBAL(61),
+	REG_A8XX_CP_PROTECT_GLOBAL(62),
+	REG_A8XX_CP_PROTECT_GLOBAL(63),
+};
+DECLARE_ADRENO_REGLIST_LIST(a830_ifpc_reglist);
+
+static const struct adreno_reglist_pipe a830_dyn_pwrup_reglist_regs[] = {
+	{ REG_A8XX_CP_HW_FAULT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_INTERRUPT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CCU_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_2, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_3, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_4, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0, BIT(PIPE_BR) | BIT(PIPE_BV) },
+	{ },
+};
+DECLARE_ADRENO_REGLIST_PIPE_LIST(a830_dyn_pwrup_reglist);
+
 static const struct adreno_reglist_pipe x285_nonctxt_regs[] = {
 	{ REG_A8XX_CP_SMMU_STREAM_ID_LPAC, 0x00000101, BIT(PIPE_NONE) },
 	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0x00000800, BIT(PIPE_BV) | BIT(PIPE_BR) },
@@ -2399,6 +2687,51 @@ DECLARE_ADRENO_REGLIST_PIPE_LIST(a840_dyn_pwrup_reglist);
 
 static const struct adreno_info a8xx_gpus[] = {
 	{
+		.chip_ids = ADRENO_CHIP_IDS(0x44050001),
+		.family = ADRENO_8XX_GEN1,
+		.fw = {
+			[ADRENO_FW_SQE] = "gen80000_sqe.fw",
+			[ADRENO_FW_GMU] = "gen80000_gmu.bin",
+			[ADRENO_FW_AQE] = "gen80000_aqe.fw",
+		},
+		.gmem = 12 * SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_PREEMPTION |
+			  ADRENO_QUIRK_IFPC,
+		.funcs = &a8xx_gpu_funcs,
+		.a6xx = &(const struct a6xx_info) {
+			.protect = &a830_protect,
+			.nonctxt_reglist = a830_nonctxt_regs,
+			.pwrup_reglist = &a830_pwrup_reglist,
+			.dyn_pwrup_reglist = &a830_dyn_pwrup_reglist,
+			.ifpc_reglist = &a830_ifpc_reglist,
+			.gbif_cx = a840_gbif,
+			.max_slices = 3,
+			.gmu_chipid = 0x8000100,
+			.bcms = (const struct a6xx_bcm[]) {
+				{ .name = "SH0", .buswidth = 16 },
+				{ .name = "MC0", .buswidth = 4 },
+				{
+					.name = "ACV",
+					.fixed = true,
+					.perfmode = BIT(2),
+					.perfmode_bw = 10687500,
+				},
+				{ /* sentinel */ },
+			},
+		},
+		.preempt_record_size = 13536 * SZ_1K,
+		.speedbins = ADRENO_SPEEDBINS(
+			{ 0,   0 },
+			{ 252, 0 },
+			{ 242, 1 },
+			{ 232, 2 },
+			{ 221, 3 },
+			{ 190, 4 },
+		),
+	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x44070001),
 		.family = ADRENO_8XX_GEN2,
 		.fw = {
@@ -2537,4 +2870,5 @@ static inline __always_unused void __build_asserts(void)
 	BUILD_BUG_ON(a690_protect.count > a690_protect.count_max);
 	BUILD_BUG_ON(a730_protect.count > a730_protect.count_max);
 	BUILD_BUG_ON(a810_protect.count > a810_protect.count_max);
+	BUILD_BUG_ON(a830_protect.count > a830_protect.count_max);
 }
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index add93c1fa039..62df0569c62b 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -200,7 +200,7 @@ static void a8xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	struct a6xx_gmu *gmu = &a6xx_gpu->gmu;
 	u32 val;
 
-	if (adreno_is_x285(adreno_gpu) && state)
+	if ((adreno_is_x285(adreno_gpu) || adreno_is_a830(adreno_gpu)) && state)
 		gpu_write(gpu, REG_A8XX_RBBM_CGC_0_PC, 0x00000702);
 
 	gmu_write(gmu, REG_A6XX_GPU_GMU_AO_GMU_CGC_MODE_CNTL,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 114a40f79ef3..338e02271fcc 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -602,6 +602,11 @@ static inline int adreno_is_x285(struct adreno_gpu *gpu)
 	return gpu->info->chip_ids[0] == 0x44070001;
 }
 
+static inline int adreno_is_a830(struct adreno_gpu *gpu)
+{
+	return gpu->info->chip_ids[0] == 0x44050001;
+}
+
 static inline int adreno_is_a840(struct adreno_gpu *gpu)
 {
 	return gpu->info->chip_ids[0] == 0x44050a01;

-- 
2.54.0

