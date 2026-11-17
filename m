Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57653606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 23:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=HXmjkkCX;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=EmZfWe4o
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 596C410F9C0;
	Tue, 17 Nov 2026 23:00:58 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C07310F9C0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:46 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AHMtaoP1527125
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wyYVsbnjSgxZrolaAwdyDnBFwjgdkdQVgoD2DRLJVBo=; b=HXmjkkCXMmQ07/pQ
 dK5tApiuY6ApddYlMeBxpHYCJ/DEz+OHOuaPrSZrvGsA89m/mdBeD2jTh4wtGbr+
 IbkrH5YUH19dbAx2t/R/NIrNySHYr1zAomTssvUFwCVXLmeSizj7XtGULAc6nTpN
 Iix5wD9BGVcL5uoP7ZrujhV6xeM4x4kstm6VoxjPGkY4sQPDfpvQunyNkPsCFcsy
 5c1GcpOOkbTSWfE9fArk3GxXSR+p6gizcYRzXAEu4HqHy0l70gEqV1rN0cEtbjLn
 cthjbRGuZmBEDj7APlm0p7+hAfmy3gKh+IpxbGWCHSUnm372TW6ieBnCrh9Vz2bp
 6bYs9w==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv8g371-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 23:00:45 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-1b53bfc9534so192833c88.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 15:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794956444; x=1795561244;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wyYVsbnjSgxZrolaAwdyDnBFwjgdkdQVgoD2DRLJVBo=;
 b=EmZfWe4oZBcBIrjnNYvq2KFb0k/uY3I6rVsWRg6pLVQ6dCY7H3dP1gB4uY9LJ9ojTH
 iLSNrMEKF1LRfxo95/lX4Cj4QxJ9Uc4RrAgcIPBVFs/fpUZATZES0Z561VkbjCEtq0X1
 nVGQzRW7MPJlV2hOba0I01+r3fkSn+Eh3DuVZP5UPYsJnzcBVuA/VX9usNza0QPk9AAD
 C5DMBR3DbfHyx7O++myk6phs9qPPIdIsAkVNBGFG/hBKbcQxjgPOROC+xFm7traKY2Mj
 ECSklta+hy8FX5bNfgK0F6+TBBT1GQviN3f/dKkTEVHvF/85nWeThCTTF8j8MGW+0xCE
 kihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794956444; x=1795561244;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wyYVsbnjSgxZrolaAwdyDnBFwjgdkdQVgoD2DRLJVBo=;
 b=auXgTX9TayWsmjxMqiUcaYtoSLfAqrChc9SPkolk0jfqqOq+VjpCiEO0jEkE2yHr2f
 5Y/OrVea7w+Wxoj7dpG7qhSPS8W7PTdCs2BACgYAk9rkAhsGmbZHLni3TT/4kUPvqaCk
 Czb7Z6YHvix0yrR8oq7Z0gsQznUf7+s6tw3o49ivJOr2+rj/lVPHfZJRhWOq5nWPD7Ie
 dWnsGyMyTc/0760DmUBqnuUSrwedzr4j7Oh0wllQSXraN4rWPowiMT9MBxMuB+uhMh9R
 qp4Zse3Ev5gi3ZrtIFV7SXko06tZxAbNeSSxozeuPLkVlQtnVgtFHqULSjF9OtSwXgEp
 c3CQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHz9gb+1SrM1vuB/9dvDWTBWlkdS5+yRHibflA5dSTIAUhjH2t+zjP3ONBB1Zpog+83HvdGrCjLUyk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/q2juqtXrF+pUF+/8sLiCV8b2IHhW56isS78s5p9UmnigZOgaD
 6yNp41vBiVP7fYQXS1bA5uVUjj5iELlKeTkwa3fb6jP4MLfjUnpTC/XEXzuUHliPzA6FrcJt5n/
 33Yuzm9D+x/Ns880pbwa2rtjb99ryySZqeWNWpiFjr/1olQlmCBMj2OSX+egRJ+yZoiBk8Wg=
X-Gm-Gg: AYBFou0FEpIXKsJJrMkwhSukdaD0uy9UZZpLMzLYJlqzm8UFyKxTyXtSWugRE7g3jGu
 kbe9MarIQDaZYyPOXA5OnUCp6uBVOuHZkRPcAtv4yNBnpPjZb0ylBjnPKY0JQxQ21X2HhTWiSHq
 afQJjHW802TWMuQQAe9aWzHPN7MvoZhjmSNiSlO6cF6lwCLlHAYqDj6ShWW8S4zf62z4Hd9rRfx
 rdNKNpfbaO4D7Oiwt5QQuDDJPW4+SFXUhUSTP5rOcEWZwcO7D3x/1yqIg83bJwRa1xwy8X9warj
 3w0W3avTaKyRMXnamTOEj9+DFdpEWZcIpS3l9AbKEA4CPYAybJ2eB0hUSWYh/wfJYI+rOks1ySo
 1yM+lWKDmXm9NFvhbYj9wU5ov3sCd10ZGi5r+Vha7KSrNR/Oev2gKcULLsm+zKK1UcXiDPid+ig
 ==
X-Received: by 2002:a05:701a:cc82:10b0:1b5:22fb:848d with SMTP id
 a92af1059eb24-1b543cb3e8fmr889028c88.16.1794956439042; 
 Tue, 17 Nov 2026 15:00:39 -0800 (PST)
X-Received: by 2002:a05:701a:cc82:10b0:1b5:22fb:848d with SMTP id
 a92af1059eb24-1b543cb3e8fmr888979c88.16.1794956438333; 
 Tue, 17 Nov 2026 15:00:38 -0800 (PST)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b5445eb29esm1380839c88.0.2026.11.17.15.00.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 15:00:37 -0800 (PST)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 04:30:04 +0530
Subject: [PATCH v2 1/5] drm/msm/a6xx: Add Adreno 753 support
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261118-nord-gpu1-v2-1-8d6d9908b7c5@oss.qualcomm.com>
References: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
In-Reply-To: <20261118-nord-gpu1-v2-0-8d6d9908b7c5@oss.qualcomm.com>
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
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Abel Vesa <abelvesa@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Shivam Rawat <shivrawa@qti.qualcomm.com>,
 Shawn Guo <shengchao.guo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794956423; l=5375;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=XPMx9YeTMn3NW5my/QSibulL4PbEkf63zt5e+XGribE=;
 b=iQMioyMW+Gvwiy55j00nRWZ/pCqgAtJMxr8lzXpjw5zjYAooUHT6Dqslag4VAiHXESG2z8yWL
 1tgkT/OatFMCZ8oeyQfQI9bi+jZcFuHBIs8pCcOtktDzRS2DaS0MSEJ
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-GUID: _WCCMK838iWsSsqR5lt8vcrI24SSVllN
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfX97G9sA5dRi5c
 4yIHKK3+LrTb+a8iksSGKLCKDAbqmotgkBL7e88OqqSMZAK9UHlrGNrcwICvVTUsL8v2eh7OsgF
 PoxRtFIxwxr074ZGRldeq1uBaBty/Hc=
X-Authority-Analysis: v=2.4 cv=c60+0h9l c=1 sm=1 tr=0 ts=6afcdc9d cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=hH_-AztgxIDa4u2WOLkA:9 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE3MDA5MSBTYWx0ZWRfXxlXJ7Yg/fa5N
 waU8EcRH/lXVeA+yIGAq5YBni+fcwDjXiBzXAh/AB5xKyN+90WmNbZlzS0lAI2RdwYh+EHq3Ba6
 9Du16m1+6AAG10Jq4IHI6jC5ZCsr3QCQv7xRYbmvWyPunJGw4fhHkSDb++FmJGU64rsjRYdCIn2
 lDKZH3Ob+mzDWmXCSbQ5Mlx8jT0FP3TYATUzsPV3qtdfXBHKNpKygvaiQdVDGa0RoUT8aSvBIPG
 YRVm4DTKTiJVFdTRGkWBzvQ9SAoufsFhYayeBRKOW4+KoHL03XFkb686GuDUj9jlA82wENnkYlX
 ZkV1u1SnJO/VdsoffIvEl+NHwiHVwZ3N35LmWKpFMv72JXn/NtMgd/eyGAH40EqzBJekWqJkDzU
 zHRIrjcrgBHt3dyfrZTzLmCJvDF15jnyv5831hDKBT3Z2ep8yPyXYNoe3aFJGBuOOH7xBfE8eLO
 ORZOFJrmfRhNCnuZp4A==
X-Proofpoint-ORIG-GUID: _WCCMK838iWsSsqR5lt8vcrI24SSVllN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-17_05,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611170091
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Shivam Rawat <shivrawa@qti.qualcomm.com>

Adreno 753 is the primary GPU in the Qualcomm Nord SoC and belongs to
the A7xx Gen3 family. It is derived from A750 and shares the same
IP-level configuration: protected registers, pwrup/IFPC register lists,
GBIF CX registers, gmu_cgc_mode, 3MB GMEM, bus BCMs and preemption
record size. The differences visible to the KMD are the chip id
(0x43051701), the GMU chip id (0x70d0000) and the gen71300 SQE and GMU
firmware.

The Nord primary GPU is the same as A750 but has a different chip id,
so it needs its own catalog entry. Add a new catalog entry for this
GPU and an adreno_is_a753() helper. HW clock gating is not working at
the moment, so it is kept disabled for now.

Signed-off-by: Shivam Rawat <shivrawa@qti.qualcomm.com>
Tested-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c     |  6 ++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |  5 ++++-
 drivers/gpu/drm/msm/adreno/a7xx_catalog.c | 35 +++++++++++++++++++++++++++++++
 drivers/gpu/drm/msm/adreno/adreno_gpu.h   |  5 +++++
 4 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index a1561ca41a5b..0fa2d2091f3e 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1051,7 +1051,7 @@ static int a6xx_gmu_fw_start(struct a6xx_gmu *gmu, unsigned int state)
 	for (int i = 0; (gbif_cx && gbif_cx[i].offset); i++)
 		gpu_write(gpu, gbif_cx[i].offset, gbif_cx[i].value);
 
-	if (adreno_is_a8xx(adreno_gpu)) {
+	if (adreno_is_a8xx(adreno_gpu) || adreno_is_a753(adreno_gpu)) {
 		gpu_write(gpu, REG_A6XX_GBIF_CX_CONFIG, 0x20023000);
 		gmu_write(gmu, REG_A6XX_GMU_MRC_GBIF_QOS_CTRL, 0x33);
 	} else if (adreno_is_a722(adreno_gpu))
@@ -1227,7 +1227,9 @@ static int a6xx_gmu_secure_init(struct a6xx_gpu *a6xx_gpu)
 	if (test_bit(GMU_STATUS_SECURE_INIT, &gmu->status))
 		return 0;
 
-	if (adreno_is_a750(adreno_gpu) || adreno_is_a8xx(adreno_gpu)) {
+	if (adreno_is_a750(adreno_gpu) ||
+	    adreno_is_a753(adreno_gpu) ||
+	    adreno_is_a8xx(adreno_gpu)) {
 		/*
 		 * Assume that if qcom scm isn't available, that whatever
 		 * replacement allows writing the fuse register ourselves.
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 3e4afaa5345f..ee885c663ac1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -651,6 +651,9 @@ static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
 	if (!(adreno_gpu->info->a6xx->hwcg || adreno_is_a7xx(adreno_gpu)))
 		return;
 
+	if (adreno_is_a753(adreno_gpu))
+		state = false;
+
 	if (adreno_is_a630(adreno_gpu))
 		clock_cntl_on = 0x8aa8aa02;
 	else if (adreno_is_a610(adreno_gpu) || adreno_is_a612(adreno_gpu))
@@ -1421,7 +1424,7 @@ static int hw_init(struct msm_gpu *gpu)
 				  BIT(6) | BIT(5) | BIT(3) | BIT(2) | BIT(1));
 	}
 
-	if (adreno_is_a750(adreno_gpu)) {
+	if (adreno_is_a750(adreno_gpu) || adreno_is_a753(adreno_gpu)) {
 		/* Disable ubwc merged UFC request feature */
 		gpu_rmw(gpu, REG_A6XX_RB_CMP_DBG_ECO_CNTL, BIT(19), BIT(19));
 
diff --git a/drivers/gpu/drm/msm/adreno/a7xx_catalog.c b/drivers/gpu/drm/msm/adreno/a7xx_catalog.c
index 6f704898cea6..9465ffa3dd12 100644
--- a/drivers/gpu/drm/msm/adreno/a7xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a7xx_catalog.c
@@ -451,6 +451,41 @@ static const struct adreno_info a7xx_gpus[] = {
 			},
 		},
 		.preempt_record_size = 3572 * SZ_1K,
+	}, {
+		.chip_ids = ADRENO_CHIP_IDS(0x43051701), /* "C523v2" */
+		.family = ADRENO_7XX_GEN3,
+		.fw = {
+			[ADRENO_FW_SQE] = "gen71300_sqe.fw",
+			[ADRENO_FW_GMU] = "gen71300_gmu.bin",
+		},
+		.gmem = 3 * SZ_1M,
+		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
+		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_PREEMPTION |
+			  ADRENO_QUIRK_IFPC,
+		.funcs = &a7xx_gpu_funcs,
+		.a6xx = &(const struct a6xx_info) {
+			.protect = &a730_protect,
+			.pwrup_reglist = &a7xx_pwrup_reglist,
+			.dyn_pwrup_reglist = &a7xx_dyn_pwrup_reglist,
+			.ifpc_reglist = &a750_ifpc_reglist,
+			.gbif_cx = a640_gbif,
+			.gmu_chipid = 0x70d0000,
+			.gmu_cgc_mode = 0x00020202,
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
+		.preempt_record_size = 3572 * SZ_1K,
 	}, {
 		.chip_ids = ADRENO_CHIP_IDS(0x43030c00),
 		.family = ADRENO_7XX_GEN2,
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 4b2156825bdf..2911d440ab17 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -559,6 +559,11 @@ static inline int adreno_is_a750(struct adreno_gpu *gpu)
 	return gpu->info->chip_ids[0] == 0x43051401;
 }
 
+static inline int adreno_is_a753(struct adreno_gpu *gpu)
+{
+	return gpu->info->chip_ids[0] == 0x43051701;
+}
+
 static inline int adreno_is_x185(struct adreno_gpu *gpu)
 {
 	return gpu->info->chip_ids[0] == 0x43050c01;

-- 
2.55.0

