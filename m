Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58FB8CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 13:03:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAE5910F0F4;
	Thu,  7 May 2026 13:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="DyY7RbIx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="foMXipgm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9204D10F0FA
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 13:03:47 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647C5cMw1971798
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 13:03:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3nTcAznbkZwTer2iw0uNN35IcgnJNjhKf/8GRJBkZC0=; b=DyY7RbIxYbh2nKpE
 1rEJbK7ZVNnnGsdLVtRsw2zvaK0rN1UVf2GBwUpYZ7AVWbu95KZvGtxjTHbMV4wP
 zInpeE7EmCtqaJF4/nL+4cGgTMl0fctLHCDijY/aMdmD/uH+J2O3zwNRTnJAxSiV
 eIIyzR+ophxkDUUTvLS6Njzk3+hG/DkZIjSPeu2aUsvgiLksKPVBaswmf4tb7Tad
 emvLwa/xazkFGhiZ5smlt8fSBV13PFVKTrR7KaCpc0aSTPuRFEgP2e5F8bcTWGI8
 +oHLpLLamra1O6yaRiDw/7aehgTfTzBq09UqNIvBcPSMyOAuKKXctnA8qWcJUEek
 lelZBw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0tej86df-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 13:03:47 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b2eba42b8dso10616775ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 06:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778159026; x=1778763826;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=3nTcAznbkZwTer2iw0uNN35IcgnJNjhKf/8GRJBkZC0=;
 b=foMXipgmRPF36WHQz0M9nyUS4vg9/elJR9CqHBoRYFf/CVAySpcyCcs5YMohfplfL1
 5/uIL96ZcDWSOmwwj73fU92uRum5owGlytqLOHLP2wC6zOM2FYTbEeGO317GWuOrOnH4
 oylgYc67ms7kaqeIQf0+kBqLCC8BF7Dwrtxa5TaeQELX6CMsQxKiz6za9QOle4epxaRK
 fHissic+pIw1fV2GUJlE4WMChdOHogXsaF9IMLXqKA/fS5uYvK5JpAn23BrHrgao61EI
 ZoPWDj4awtM5EbyBYXQvpcNcBnZnMTu2EX1FfIA7kb8qkc7vkurqfjLinVb7LWKi2/yR
 CoPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778159026; x=1778763826;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=3nTcAznbkZwTer2iw0uNN35IcgnJNjhKf/8GRJBkZC0=;
 b=F0CODe7NZOfL+R3eOiOp/qZKpiXEsTRHTr6fuR/zNygsA638W+UCBW74NjA7/eiH0H
 M82e1ie3FO2j3nHCEUYa/jxs8GRDROrKMpzQjaRhRcqywj4i01yFbDeXGqxPgfboMU/M
 YxtUhmGMjbgqVr6HL8e5dBgQjP2lnKVTddlsDaHoSV8kl2AeQwifUX0fPJuz1CsP3Qco
 caZIeQP2FKuhHPPiCph8Xul4AXsFiLptQT3umib5ps8v1Y4gM+bO+bJBi+fFaHsCy4tY
 T8id0va0K9Wa7ojL8SydiNitJCF5MTMe6aS8D9HIQEHzwy/oMbR8vxAidzA7ItYeHZwk
 4dYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yadlZCaLc4Sgx8tYc4nXjZzqnmOi/DU9mXfElNDv5VVEJ9infPo1boJYlKB2bQGNBrURf0TnjRyA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy1DFpzcsYXKZgbzvMRTlVc40X0Vh7El9D/sVatzlkdttNVXSOW
 CAVQNM+4oA83UfrCU9zRGQlZ88bIKsRmpRvHBWBs92Oaj738Nf92+mrMQQmkyrnnNj7VXmq6O4m
 giv5KXNbk87plGDTbVOtSVlyjbdGnvZmkojUNHy1GB6sKUOpw/YJVALtE2fRu1PC0rexRRGA=
X-Gm-Gg: AeBDietPY63cLPrmzmKO9qXTh9EzSOBFg59w/VzNnMxrhlU+BkDUv3DacVWA8ANNOsf
 DkTG5Yk0jXUc/k19N8XDa+xgGOiu769xnlWdA5/w54Eq/BtDI12seJuN+/983R2ICcV6UIijmPm
 PCrHZkLfgkP9J/pC1n+VcxNNBK/O6RSuh/oeKlhBLZcltOgVmYQD9+E0MC7DjnvNOV2RqFq7d1U
 kKtJATmYmIFgPe1KjfMOuodRolKvHxUkvG81CxzGbZR5SYUsf2ZrF4bk4yXO0eWFQjKvswWKGjF
 ss1wJbue2oqsAe9Nn7Thdd0sS90BDLY3FuNkOfJISXAZUEa9BEdsGAkIHc2W4d8gjkG0WaMNPmg
 c8cyNGL8IQK8IsyS3K05s0SPq5SDblYn+7h0bWJv3/9YwlViREtsqElb5DIeAP2A/5rQCbXSCzs
 jSecmlynT9jGc46sdsJI0EFDXKPpM6iXdQ1gZysPzve+4DWMtQHUeDvN8G
X-Received: by 2002:a17:903:280b:b0:2b4:65ab:57cd with SMTP id
 d9443c01a7336-2ba7a362979mr53135385ad.36.1778159026340; 
 Thu, 07 May 2026 06:03:46 -0700 (PDT)
X-Received: by 2002:a17:903:280b:b0:2b4:65ab:57cd with SMTP id
 d9443c01a7336-2ba7a362979mr53134665ad.36.1778159025532; 
 Thu, 07 May 2026 06:03:45 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a85c230c68sm5595959e87.19.2026.05.07.06.03.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 06:03:43 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 07 May 2026 16:03:09 +0300
Subject: [PATCH v4 13/29] drm/msm/adreno: use new helper to set
 ubwc_swizzle
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-ubwc-rework-v4-13-c19593d20c1d@oss.qualcomm.com>
References: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
In-Reply-To: <20260507-ubwc-rework-v4-0-c19593d20c1d@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2707;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=VltiGEFHSGgs78MqO7UweBRuc9YVg0/om0I7X8C3TaQ=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ+af3rZsu4rUyXLJG02kbPTsLHrFWO7fvKnQ+tj4isFeM
 ydtldudjMYsDIxcDLJiiiw+BS1TYzYlh33YMbUeZhArE8gUBi5OAZiIzzf2/yVrytOEbq0LWiVV
 /u/1R7PPS5dsymAIZ2SNeRUZ4bTk9JUrKS1Xn4ZO1Av7tr7UNPG//a7sR5eW7/nqcDWqc21X2q3
 Vmd+kHLqlTCr4DlWx6rq+651TdIA/oSdM26DIv+XVv3X9bhnuh1JvLZiZ/uqAXGaOtWvJzxvnep
 Yo9j8q2ryH+/5+2UfXd/5j8FL5tcFi/fYCTsHJLMdMnDh41HeuDc0+k7n2d1F9QMAZZf0nmb/++
 s673FgZYX1TMHeTRq/L8xstcZvCf9zjM8qQUdi9wzVe8JX/ySLPXZ8mMGVJCNRzzJphuDR63/RI
 CwPn6aEZahJq05TCDQsdo6T2Wfecip6W/SPU5InnxeQoAA==
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDEzMCBTYWx0ZWRfX7sQAD8Ph9cE0
 bah4GbASZa2gwc9KX3dCMMmMjG7ji1FwOiV6yWFksv/gWQ9kvHYjHI4/hNzvt7aprJhiynWYC5z
 NekK5CuKNolJiwCv8sRLA//i8Fu8OEZ3x6CvGm15VkRAJy5N9tjty7LVeR+n9Lt5AvuZPqahsxo
 M3oRfoprJI4kzWEXdWEk5HvXCSAq8bZ1qkmuDHOxvgVp/IfCCQBw76im8WB2wuTLWEdBlYJ55tR
 rQZWGxh691257Q/sYlLmL3qSP69e3PuV61i0zt6+r8VSyiOiDUPrsQ5XhGvBaIj0K+KqBi7XgPY
 F+cUMday3BfB66XE6vK9L8DNB+eeLE/KIpOniQ6EbDYoj/u7kt3dO1Axb0bW78tu426I3SUr+h3
 9Me21F8w1RtQpg8fdiDwNwHtvUvip9LMlAibl6rj+ag4L2zl7t9L10w4BJ9Mm7jBkvbbINjYWP5
 sTPGySFgOfi7nJrZX3w==
X-Proofpoint-GUID: BxKYcYzHAeZxEXHsL6jtSDqIRfZFurEv
X-Authority-Analysis: v=2.4 cv=VNbtWdPX c=1 sm=1 tr=0 ts=69fc8db3 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=yqhp3bNzI1c8ER7VfgcA:9 a=QEXdDO2ut3YA:10 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: BxKYcYzHAeZxEXHsL6jtSDqIRfZFurEv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 priorityscore=1501 malwarescore=0
 bulkscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070130
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

Use freshly defined helper instead of using the raw value from the
database.

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c   | 2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c   | 4 ++--
 drivers/gpu/drm/msm/adreno/adreno_gpu.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 76c681614416..5c17565b0499 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -745,7 +745,7 @@ static void a6xx_set_ubwc_config(struct msm_gpu *gpu)
 	BUG_ON(cfg->highest_bank_bit < 13);
 	u32 hbb = cfg->highest_bank_bit - 13;
 	bool rgb565_predicator = cfg->ubwc_enc_version >= UBWC_4_0;
-	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
+	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
 	bool ubwc_mode = qcom_ubwc_get_ubwc_mode(cfg);
 	bool amsbc = cfg->ubwc_enc_version >= UBWC_3_0;
 	bool min_acc_len_64b;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 1923f904d37d..53def136e0fc 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -275,8 +275,8 @@ static void a8xx_set_ubwc_config(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	const struct qcom_ubwc_cfg_data *cfg = adreno_gpu->ubwc_config;
-	u32 level2_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL2);
-	u32 level3_swizzling_dis = !(cfg->ubwc_swizzle & UBWC_SWIZZLE_ENABLE_LVL3);
+	u32 level2_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL2);
+	u32 level3_swizzling_dis = !(qcom_ubwc_swizzle(cfg) & UBWC_SWIZZLE_ENABLE_LVL3);
 	bool rgba8888_lossless = false, fp16compoptdis = false;
 	bool yuvnotcomptofc = false, min_acc_len_64b = false;
 	bool rgb565_predicator = false, amsbc = false;
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index bf1572156b0b..d26985c88115 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -430,7 +430,7 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		*value = adreno_gpu->has_ray_tracing;
 		return 0;
 	case MSM_PARAM_UBWC_SWIZZLE:
-		*value = adreno_gpu->ubwc_config->ubwc_swizzle;
+		*value = qcom_ubwc_swizzle(adreno_gpu->ubwc_config);
 		return 0;
 	case MSM_PARAM_MACROTILE_MODE:
 		*value = qcom_ubwc_macrotile_mode(adreno_gpu->ubwc_config);

-- 
2.47.3

