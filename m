Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C4BF483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:13:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7037210E45D;
	Mon, 23 Mar 2026 20:13:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="pAVxtE/s";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iPKvo2uS";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AD9810E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:56 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqXHD3817469
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ++AqkByfrQV0XRfPXuc9etfMULCFiMNJAf5WZLb9rpY=; b=pAVxtE/so+Yx4b3R
 IT1Kvccr+m0wgfSV0RBQbapibVXIezMWPrZfmYNfZzhUHjXpy3/iFD13Rkhciict
 NAYBB0TLZp0z/knj7iGpIO1gX4RT+hdu2mmjbz94LMGj/jKntrXS6wLOCYFoV7k4
 cUJ7Z6kAD+SNrJ2D8ZPaZ8vDD0/oc/Vua4t0VUU5dUDxootz0Tuk4zyN/lHxRVvQ
 B5ysEFAjFWaLNK4eeWp/qZG4ajaMyZd7/GQF5PXyKrIM+JoNzQFM8e1S3IReslJE
 08jQJbrCC6n6fXfk846NCsqJyTDTn94tsNYbeZ3YzqBsGvt7VGiyfeIa5QaEW+CH
 bUI11g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d355w1q6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:13:55 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a88a2704fso2151197b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296834; x=1774901634;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=++AqkByfrQV0XRfPXuc9etfMULCFiMNJAf5WZLb9rpY=;
 b=iPKvo2uSzQwfapzpj36ynz8tMsN4M+aLUEpOxNGkbk0XXatjhbinRihsVnv3lYf2JT
 2gNgjlzxJirWJDjloB8XRM6GOCyD26gFFGtOZHH+zE6QS2/auXnnAn6mwTb7Q2VGfy8m
 QHWabIp558UDZJIEmSAEurH73hb0T7hyLjjrSwpx+91wwXc1KFKAQLHYiAvsBmtw2FBy
 pbb97X6bUHGjj7Narh/xHplrW/XEwLL/jeMQN1kOJDyAECM3H3hkEmyFXhksA/XpkvQx
 G42oT4lrj+XqiIsHMdbuhlC4lehuOWMhnxEaVXTDVE8gcz6aSnO5l+ogOcqf1VLtuOk+
 tmGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296834; x=1774901634;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=++AqkByfrQV0XRfPXuc9etfMULCFiMNJAf5WZLb9rpY=;
 b=HkWjGIT7BiQAgFIBbZQ+1GtrjjvsYKpGDd8yMjrzbynKJqSDU+Ous+aL6bHjor/IeG
 A74mBCB9CI6dIkDiyptveDdvDlm/11elz5v19lhVYuH4uefAN+KssZqLnfNBH0ooEP0p
 gATlYDBLKdcrIvoe5hpmCfh0bfuaA4hpQzEW6LS0GM2/ldoKrYpMqWdMsYyT75CC83bZ
 icGGRd1Erou3EO3fQQzzAbBdCT2grot4YoBgEAJSxDd7jWap1plr2DeGeMUHkHKnR/Un
 WkfxFUrgntaQBzC+tymyS32giLrvLSTk60u18287VenOocQISdWoTPINe/63++PInKca
 aiTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0KnsSav6EoQCUcXxBs+ShQ12H6ALtyT1qNT1ALCqyjnGAqAKfMi50p4PnlKKqFWssjG7t/TU0uY4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyCNtAjm9S088LahQRrO1HEY6UOp437XkI/KXnWYY0TjcvS1l/Z
 azDlT5Bu5ake4ng/M0BRmUrOnNWzgxm7aIlVgM+vLyI/R+HYidIVytpzMbBLVd/kZ1QPPvm5ig4
 Zx+12q24DARwACt/PfS2u5xkeoht6fB/eRp/BVkojnKo0LVQ/C0YHW110r0QM1FH+ju7f7U8=
X-Gm-Gg: ATEYQzz6F+RX72S4lXROjL4ObWEpa3a9dJNb/DQ92ME4XXpKrufrLjZbKPl/D7Q2fuY
 l3iGU/Gy0gfj9QYzVp3ho6cqs5iyZBOECFVhxCZWV+ieBtnR7qEZmRUaxQ3YkDdqr2B4wg8P0CE
 3cMWMRoqoiiqz2Rv8RDi4y4fdekf/C4CWjF1ZoY0J+h+xxxhKLQFVJEP5mRBM7ZcCRFSpM4Zess
 cFpPpisE/2qJM5f1hSV3Vp1rwNUZpToFEyyCfwCPp8FhxOzNq4WITo344eqdqoi9xfziSI3Z7KN
 krJAagcyUyag38mtqzFPnTlB0YsBaaQiGT0XtrD/Jzv0nQc+RXOKZGttAmmv4cFWCrilgqZi7ly
 LWO5q1KSIRw/Sfr6UCx60jX4dnvwI3U16S9ZlnaJxK+N71Q==
X-Received: by 2002:a05:6a00:a248:b0:824:b03f:2f65 with SMTP id
 d2e1a72fcca58-82c5bd62488mr583999b3a.7.1774296834116; 
 Mon, 23 Mar 2026 13:13:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:a248:b0:824:b03f:2f65 with SMTP id
 d2e1a72fcca58-82c5bd62488mr583977b3a.7.1774296833505; 
 Mon, 23 Mar 2026 13:13:53 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:53 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:25 +0530
Subject: [PATCH 13/16] drm/msm/a8xx: Implement IFPC support for A840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-13-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=13599;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=BOYNB5erOcTcXYtZi4okQGOy9Gb4kZCAjXNcLR1sRo0=;
 b=NQW2gdQvVmcHxacDjjqKshLJaDdaA7zwuU8lmNpV63yHDxi/oCh+VB6OK4sy0k3uNAKldE3lK
 x/tyDBQDgBCBdmTko+MuiCjy78G5lr3jzr4JYeuG+Sjzko258ZzhrPT
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=fq7RpV4f c=1 sm=1 tr=0 ts=69c19f03 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=gVRFLEIR9Vaz-UcNYaQA:9 a=QEXdDO2ut3YA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: r6kNCAo13E7CHYLDazMyoZeWTI-bYDj2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfXzX4qS1NtyHaz
 JDbpjASrVy3clBibs2eIGPjDOFXT0SE9E1d9aQiqD0BwHx2SPnnth4NnE7Rg1oGizPMwN0PgEAQ
 0dR4PwCnHHInWQFBhzXHbd3qxMLuMbsNyY42zoTHO08FGnLtHu/F3HnnFqaHkVo8rwLcQKNf4pC
 Ra9kG+WKcBY0hmJnG+CwGyrtPt4bbpNm739yXRw5IjQbSZ+S9AuzUfFiaisOWXVb8xk0Cec1XNm
 tKNgMdkU0srl9tGU2w80kW3Djz4+WCINFW0zEjM5pw1Ed7yFmJPC2zB9xPYXgORt5pJzFTEkyUM
 3L5q4b/qFIb0eeYo1qIuU74FhXM7b264pRz/7Rbc9Z5DXRK6GX0CE7UepB9TuJiwyFEgXV2orAU
 u7UwsnsWKg73b+2i0f/OUL5FjnirqMsASPs19duoZOqx/bBt0aNCFl+hrA/C0b6/M0omBA8AEQw
 PRZJzSA7s7Hr59zsbvA==
X-Proofpoint-GUID: r6kNCAo13E7CHYLDazMyoZeWTI-bYDj2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015 impostorscore=0
 lowpriorityscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 phishscore=0
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

Implement pwrup reglist support and add the necessary register
configurations to enable IFPC support on A840

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c | 185 +++++++++++++++++++++++++++++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  97 +++++++++++++++-
 2 files changed, 280 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 758bc7bd31f6..53548f6e891b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -1891,6 +1891,185 @@ static const struct adreno_reglist a840_gbif[] = {
 	{ },
 };
 
+static const uint32_t a840_pwrup_reglist_regs[] = {
+	REG_A7XX_SP_HLSQ_TIMEOUT_THRESHOLD_DP,
+	REG_A7XX_SP_READ_SEL,
+	REG_A6XX_UCHE_MODE_CNTL,
+	REG_A8XX_UCHE_VARB_IDLE_TIMEOUT,
+	REG_A8XX_UCHE_GBIF_GX_CONFIG,
+	REG_A8XX_UCHE_CCHE_MODE_CNTL,
+	REG_A8XX_UCHE_CCHE_CACHE_WAYS,
+	REG_A8XX_UCHE_CACHE_WAYS,
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
+	REG_A8XX_RB_CMP_NC_MODE_CNTL,
+	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN,
+	REG_A8XX_SP_HLSQ_GC_GMEM_RANGE_MIN + 1,
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
+DECLARE_ADRENO_REGLIST_LIST(a840_pwrup_reglist);
+
+static const u32 a840_ifpc_reglist_regs[] = {
+	REG_A8XX_RBBM_NC_MODE_CNTL,
+	REG_A8XX_RBBM_SLICE_NC_MODE_CNTL,
+	REG_A6XX_SP_NC_MODE_CNTL,
+	REG_A6XX_SP_CHICKEN_BITS,
+	REG_A8XX_SP_SS_CHICKEN_BITS_0,
+	REG_A7XX_SP_CHICKEN_BITS_1,
+	REG_A7XX_SP_CHICKEN_BITS_2,
+	REG_A7XX_SP_CHICKEN_BITS_3,
+	REG_A8XX_SP_CHICKEN_BITS_4,
+	REG_A6XX_SP_PERFCTR_SHADER_MASK,
+	REG_A8XX_RBBM_SLICE_PERFCTR_CNTL,
+	REG_A8XX_RBBM_SLICE_INTERFACE_HANG_INT_CNTL,
+	REG_A7XX_SP_HLSQ_DBG_ECO_CNTL,
+	REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_1,
+	REG_A7XX_SP_HLSQ_DBG_ECO_CNTL_2,
+	REG_A8XX_SP_HLSQ_DBG_ECO_CNTL_3,
+	REG_A8XX_SP_HLSQ_LPAC_GMEM_RANGE_MIN,
+	REG_A8XX_SP_HLSQ_LPAC_GMEM_RANGE_MIN + 1,
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
+DECLARE_ADRENO_REGLIST_LIST(a840_ifpc_reglist);
+
+static const struct adreno_reglist_pipe a840_dyn_pwrup_reglist_regs[] = {
+	{ REG_A8XX_GRAS_TSEFE_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_NC_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_GRAS_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A6XX_PC_AUTO_VERTEX_STRIDE, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_2, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_3, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CHICKEN_BITS_4, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_CONTEXT_SWITCH_STABILIZE_CNTL_1, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_PC_VIS_STREAM_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_RB_CCU_DBG_ECO_CNTL, 0, BIT(PIPE_BR)},
+	{ REG_A8XX_RB_CCU_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_NC_MODE_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_RBP_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_RB_RESOLVE_PREFETCH_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_RB_CMP_DBG_ECO_CNTL, 0, BIT(PIPE_BR) },
+	{ REG_A7XX_VFD_DBG_ECO_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BV_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BR_THRESHOLD, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_BUSY_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VFD_CB_LP_REQ_CNT, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_VPC_FLATSHADE_MODE_CNTL, 0, BIT(PIPE_BV) | BIT(PIPE_BR) },
+	{ REG_A8XX_CP_HW_FAULT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_INTERRUPT_STATUS_MASK_PIPE, 0, BIT(PIPE_BR) |
+		BIT(PIPE_BV) | BIT(PIPE_LPAC) | BIT(PIPE_AQE0) |
+		BIT(PIPE_AQE1) | BIT(PIPE_DDE_BR) | BIT(PIPE_DDE_BV) },
+	{ REG_A8XX_CP_PROTECT_CNTL_PIPE, 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC)},
+	{ REG_A8XX_CP_PROTECT_PIPE(15), 0, BIT(PIPE_BR) | BIT(PIPE_BV) | BIT(PIPE_LPAC) },
+	{ REG_A8XX_RB_GC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A8XX_RB_LPAC_GMEM_PROTECT, 0, BIT(PIPE_BR) },
+	{ REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE, 0, BIT(PIPE_BR) },
+};
+DECLARE_ADRENO_REGLIST_PIPE_LIST(a840_dyn_pwrup_reglist);
+
 static const struct adreno_info a8xx_gpus[] = {
 	{
 		.chip_ids = ADRENO_CHIP_IDS(0x44070001),
@@ -1940,11 +2119,15 @@ static const struct adreno_info a8xx_gpus[] = {
 		.gmem = 18 * SZ_1M,
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
-			  ADRENO_QUIRK_HAS_HW_APRIV,
+			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
 			.protect = &a840_protect,
 			.nonctxt_reglist = a840_nonctxt_regs,
+			.pwrup_reglist = &a840_pwrup_reglist,
+			.dyn_pwrup_reglist = &a840_dyn_pwrup_reglist,
+			.ifpc_reglist = &a840_ifpc_reglist,
 			.gbif_cx = a840_gbif,
 			.max_slices = 3,
 			.gmu_chipid = 0x8020100,
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index d414f24ddbd9..b1784e0819c1 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -173,7 +173,7 @@ void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	/* Update HW if this is the current ring and we are not in preempt*/
 	if (!a6xx_in_preempt(a6xx_gpu)) {
 		if (a6xx_gpu->cur_ring == ring)
-			gpu_write(gpu, REG_A6XX_CP_RB_WPTR, wptr);
+			a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
 		else
 			ring->restore_wptr = true;
 	} else {
@@ -386,8 +386,87 @@ static void a8xx_nonctxt_config(struct msm_gpu *gpu, u32 *gmem_protect)
 	a8xx_aperture_clear(gpu);
 }
 
+static void a8xx_patch_pwrup_reglist(struct msm_gpu *gpu)
+{
+	const struct adreno_reglist_pipe_list *dyn_pwrup_reglist;
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	const struct adreno_reglist_list *reglist;
+	void *ptr = a6xx_gpu->pwrup_reglist_ptr;
+	struct cpu_gpu_lock *lock = ptr;
+	u32 *dest = (u32 *)&lock->regs[0];
+	u32 dyn_pwrup_reglist_count = 0;
+	int i;
+
+	lock->gpu_req = lock->cpu_req = lock->turn = 0;
+
+	reglist = adreno_gpu->info->a6xx->ifpc_reglist;
+	if (reglist) {
+		lock->ifpc_list_len = reglist->count;
+
+		/*
+		 * For each entry in each of the lists, write the offset and the current
+		 * register value into the GPU buffer
+		 */
+		for (i = 0; i < reglist->count; i++) {
+			*dest++ = reglist->regs[i];
+			*dest++ = gpu_read(gpu, reglist->regs[i]);
+		}
+	}
+
+	reglist = adreno_gpu->info->a6xx->pwrup_reglist;
+	if (reglist) {
+		lock->preemption_list_len = reglist->count;
+
+		for (i = 0; i < reglist->count; i++) {
+			*dest++ = reglist->regs[i];
+			*dest++ = gpu_read(gpu, reglist->regs[i]);
+		}
+	}
+
+	/*
+	 * The overall register list is composed of
+	 * 1. Static IFPC-only registers
+	 * 2. Static IFPC + preemption registers
+	 * 3. Dynamic IFPC + preemption registers (ex: perfcounter selects)
+	 *
+	 * The first two lists are static. Size of these lists are stored as
+	 * number of pairs in ifpc_list_len and preemption_list_len
+	 * respectively. With concurrent binning, Some of the perfcounter
+	 * registers being virtualized, CP needs to know the pipe id to program
+	 * the aperture inorder to restore the same. Thus, third list is a
+	 * dynamic list with triplets as
+	 * (<aperture, shifted 12 bits> <address> <data>), and the length is
+	 * stored as number for triplets in dynamic_list_len.
+	 */
+	dyn_pwrup_reglist = adreno_gpu->info->a6xx->dyn_pwrup_reglist;
+	if (!dyn_pwrup_reglist)
+		goto done;
+
+	for (u32 pipe_id = PIPE_BR; pipe_id <= PIPE_DDE_BV; pipe_id++) {
+		for (i = 0; i < dyn_pwrup_reglist->count; i++) {
+			if ((dyn_pwrup_reglist->regs[i].pipe & BIT(pipe_id)) == 0)
+				continue;
+			*dest++ = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe_id);
+			*dest++ = dyn_pwrup_reglist->regs[i].offset;
+			*dest++ = a8xx_read_pipe_slice(gpu,
+						       pipe_id,
+						       a8xx_get_first_slice(a6xx_gpu),
+						       dyn_pwrup_reglist->regs[i].offset);
+			dyn_pwrup_reglist_count++;
+		}
+	}
+
+	lock->dynamic_list_len = dyn_pwrup_reglist_count;
+
+done:
+	a8xx_aperture_clear(gpu);
+}
+
 static int a8xx_cp_init(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	struct msm_ringbuffer *ring = gpu->rb[0];
 	u32 mask;
 
@@ -409,6 +488,9 @@ static int a8xx_cp_init(struct msm_gpu *gpu)
 	/* Disable save/restore of performance counters across preemption */
 	mask |= BIT(6);
 
+	/* Enable the register init list with the spinlock */
+	mask |= BIT(8);
+
 	OUT_RING(ring, mask);
 
 	/* Enable multiple hardware contexts */
@@ -420,6 +502,14 @@ static int a8xx_cp_init(struct msm_gpu *gpu)
 	/* Operation mode mask */
 	OUT_RING(ring, 0x00000002);
 
+	/* Lo address */
+	OUT_RING(ring, lower_32_bits(a6xx_gpu->pwrup_reglist_iova));
+	/* Hi address */
+	OUT_RING(ring, upper_32_bits(a6xx_gpu->pwrup_reglist_iova));
+
+	/* Enable dyn pwrup list with triplets (offset, value, pipe) */
+	OUT_RING(ring, BIT(31));
+
 	a6xx_flush(gpu, ring);
 	return a8xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
@@ -702,6 +792,11 @@ static int hw_init(struct msm_gpu *gpu)
 	WARN_ON(!gmem_protect);
 	a8xx_aperture_clear(gpu);
 
+	if (!a6xx_gpu->pwrup_reglist_emitted) {
+		a8xx_patch_pwrup_reglist(gpu);
+		a6xx_gpu->pwrup_reglist_emitted = true;
+	}
+
 	/* Enable hardware clockgating */
 	a8xx_set_hwcg(gpu, true);
 out:

-- 
2.51.0

