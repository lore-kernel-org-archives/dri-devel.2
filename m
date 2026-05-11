Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83BCCD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C7110E746;
	Mon, 11 May 2026 13:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eeqTjDuR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bex9AooR";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6E6410E746
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:31 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B9D4wV653467
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zVhhihIWGcW
 DVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=; b=eeqTjDuRBlJtvff1iwj74lli22x
 ZOr8cSr7/ZfiKBHclS65TbGdaQBfogF0nV9RhjoRhaZJXpHOjtSgB87ennT9kOuZ
 f9to+xxw/DLbHlU957C+Q0eFTXDxSywGWs4ouAwYAxxtnG1mMaOOvH9HhjikIJfm
 JHMidatSp+YwRnSI9OTwpb/p+5ba6cUZU8xLyy/bUSXaCgqcQZpt5ePPEUxM0wII
 5btuZVzMwcaLcf873D1sgkNsG8Jd7R9p2bLVx4gojf56Dmz3xUhnluL5/FgtVNSG
 wCR976KHtpXMkn3oPErzqqSQW+Ssk2ve0qVlWOtwcDerU4TUbxxq2HCrN0g==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e37xu9sq1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:30 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2ba86e35aa1so64143495ad.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504490; x=1779109290;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zVhhihIWGcWDVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=;
 b=bex9AooRFiHw+72MtsQZFFNA+HbcvxLb/o1WLOmbnqU0gHTIriA3wQMKFzUSnXzi46
 DjkMkB0KZa6YdxEg1TxBb4nFXrpPqWruklyK2E8+oll7Yc+5a8UFanzazPZ3v0OktQAS
 2U5dvfFrX2zeiYLgKOSIa/1Y5p2frQ1WhPIFgfrFwML2d5ftTiOGKrhNUYeX+Emh8kvl
 RalAuT5nRMjrPGwDEkHqR6yZdDUnM3lcNVDFoZg2/kqI/cgDpoL5+MTERulnAsYhjn6m
 djVJXZUl14nuK9jQDz0dO19zf+mcUdEEp5KKgzoIMkNrbZe2m7U893u8fqrJ6JrXkgOv
 YQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504490; x=1779109290;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zVhhihIWGcWDVKhVXioxlxo4w1o6vj94DNJvO2XJTbI=;
 b=TkDVzsNSVvsByweQBXQa8zhjTH8/XLNxexhkKugpnuZs8Ov7XwSuTkgyU/lSRdIqz4
 DLDN0TlSLWqCrBQcya06fOAWQoOyWFz7ZWEZg0cCuwn9alcCqgYz4HdxHfu5wIT534Ro
 CUMAf4KlVi7j6io5qKu9EE+6eQNvPlq8sNfK+ZAORMD5k1xQT2tp9k5pjLrEn2ulKgT7
 FW0Ps1w0DgM8gxDCjYFwi/lBfgAP0/ABjfIJr08j6s3oId6ZOCXH1vTKvWj+h/2LIGOx
 uLT9uVWmM/yNFo7a/kuQvII31JW4hItPoZR+FdNhLI62Hh6UpW067ElljcB7s/wZW9FG
 VD/A==
X-Gm-Message-State: AOJu0YyRBIO1ykJt7d+Mczps5OBoe7UWOilSs7JhLRpZ9yk2QttNy/kC
 9Vf6ZRjG3w+8JbxGlJTSfR7LUYBGJgUUxbgi2rLaWiCn1s3Fv1xW0c9sSND1Dd9IJ7bVdauLJLB
 EXJAgqxaIuNFarz7PinRf4lfjOeoyyO2hQFWvPd3y1jWtDVym8ffwhxTvRkV6IGc88Lkjvm+g5i
 CCylg=
X-Gm-Gg: Acq92OGpg9Z7vwAZBIKZ32fbAEkHzk39xgnCq9ECpsrE+79C7aN0QjoZgSr6e4Qfv4B
 rSPBGgAkGBD+R0TRyrhR+HC3yUa8UBaNj64/vCJbxIZHdORS+rpVEXPoAfLvtbZHSkT7ZXHj7BJ
 uOqUO+ofM0haKs7Epn169Wt4quGDbpsZ3TKDWd8CjwMu0uJvEC0HXwaNTAN4nFyGoITi3lprTbg
 DBEiW2HIEGUhTm0Eb1RRicSTh/lKaFYdztAQCyoflgWhYasorzTMF8EGsGBp5ra3u9XtTLmFTyy
 kAy8BFJlH+DN/05JIuz/zubYw3TJzRhlWE6SUQ2NVDR1spKLRyRETszSsl4P999EXbfo0l8EOeu
 TRFy6wEV7GrT85BHdPF4NKvT/1V6dyH4x
X-Received: by 2002:a17:903:280e:b0:2b2:50e1:f104 with SMTP id
 d9443c01a7336-2ba78f63defmr184146565ad.3.1778504489580; 
 Mon, 11 May 2026 06:01:29 -0700 (PDT)
X-Received: by 2002:a17:903:280e:b0:2b2:50e1:f104 with SMTP id
 d9443c01a7336-2ba78f63defmr184145755ad.3.1778504488598; 
 Mon, 11 May 2026 06:01:28 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d2700dsm107146375ad.2.2026.05.11.06.01.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:01:27 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v5 12/16] drm/msm/a8xx: Add perfcntr flush sequence
Date: Mon, 11 May 2026 05:59:25 -0700
Message-ID: <20260511130017.96867-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=EcL4hvmC c=1 sm=1 tr=0 ts=6a01d32a cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=W-43u8CF5Pkpiqpb4b0A:9
 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX5kgeTphqgGzV
 53MGWqPtxszzeUZoZEdfn5lX513ZnQk3lMGG9iDBifdy8OYY3JUElIDW1nOtYP9Fvbglz7e9BSm
 O8Q6EpgUirgtHSgw9fjb/2wzW56/C8xWg/ejdGB3X0h8LdCKcakYMfnr1kcf8OsIJS2Tt0zby2i
 MbFqcLzhnT0v1ZPOxo1wtd27dPRL2PbrDUDweA1tf8jZ7BlN+RgJuEHx4/Ce3eFyMRb/k0huaCm
 Cmkaq8TLbUiW86046S+GlHAq8+iRWKC8fL/2rhq50lWM6nJV8Qn3v7zILbDDOIGkPFo5OswNbdQ
 1JfE1hR8PPoP88hr6gmJ6tmKNUTB3hNT49p4V1rOJx5OhcQsIx/NtHSkHNGUE0SwVpFnLUYn2x3
 GV0hhuSZtiocIlcG9EqrW9Bwvnd6txYR56qOn2NkDVa0N9mRGnnuaweBHZNM5zOycY5bHRQAd7L
 RrOBfILnCxeqFVkNp5g==
X-Proofpoint-ORIG-GUID: ZxaFjIm7kWMsxE-na37ep3H2wv1a-58Z
X-Proofpoint-GUID: ZxaFjIm7kWMsxE-na37ep3H2wv1a-58Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 adultscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110144
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

With the slice architecture, we need to flush the slice and unslice
counters to perf RAM before reading counters.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c |  1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 20 ++++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 30df9bfa9ef8..a329d20033d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2921,6 +2921,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.progress = a8xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
 		.perfcntr_configure = a6xx_perfcntr_configure,
+		.perfcntr_flush = a8xx_perfcntr_flush,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a8xx_gmu_get_timestamp,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 99c3e55f5ca8..3491a24a9320 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -334,5 +334,6 @@ void a8xx_preempt_hw_init(struct msm_gpu *gpu);
 void a8xx_preempt_trigger(struct msm_gpu *gpu);
 void a8xx_preempt_irq(struct msm_gpu *gpu);
 bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+void a8xx_perfcntr_flush(struct msm_gpu *gpu);
 void a8xx_recover(struct msm_gpu *gpu);
 #endif /* __A6XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 124d315b2469..6c040f718176 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1345,3 +1345,23 @@ bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 {
 	return true;
 }
+
+void a8xx_perfcntr_flush(struct msm_gpu *gpu)
+{
+	u32 val;
+
+	/*
+	 * Flush delta counters (both perf counters and pipe stats) present in
+	 * RBBM_S and RBBM_US to perf RAM logic to get the latest data.
+	 */
+	gpu_write(gpu, REG_A8XX_RBBM_PERFCTR_FLUSH_HOST_CMD, BIT(0));
+	gpu_write(gpu, REG_A8XX_RBBM_SLICE_PERFCTR_FLUSH_HOST_CMD, BIT(0));
+
+	/* Ensure all writes are posted before polling status register */
+	wmb();
+
+	if (gpu_poll_timeout(gpu, REG_A8XX_RBBM_PERFCTR_FLUSH_HOST_STATUS, val,
+			     val & BIT(0), 100, 100 * 1000)) {
+		dev_err(&gpu->pdev->dev, "Perfcounter flush timed out: status=0x%08x\n", val);
+	}
+}
-- 
2.54.0

