Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D3E10AB832
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 00:14:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F7D310EB2D;
	Fri, 27 Mar 2026 00:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YOjxcWib";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Di6I+4F7";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82B0910EB0D
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:46 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62QF9dQS334190
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ypVmLmZoKp0ZQrPOn04KrEzrtKR2UKnrkXkHej2c9lo=; b=YOjxcWib7A38DVxc
 RCQcQ7z/4YxztOfn10nn0ZsnYUllMs47RszsCGdPDpGmYQ9kXW/bmx64vabchvNa
 oirZ1J0kVlkXL4IQDEIPuGZp+mMN8Z8TgXqTM99Xjn1bpFJ7I8MTo5/c1UQwvHZm
 TFyXws0z3cypikMSuANfnaI6c/+6xSqL8OqB/fPuaxetLK9O6i/8HrQDnRHR7YEc
 Ul8jLRMmRL4xYYWLfBxuDW90tmMJbalvIpGtoQl9y6CJORgFrSYf5oycQhJDXeTc
 5lLlSWFw2BkEsmXysjMBk+UbjECkiFk0E6GdUttS6PUHl7pFyNoYoq/tkm9KlmJW
 3qjLuw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d527ytutd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 00:14:45 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-358f058973fso2169317a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 17:14:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774570485; x=1775175285;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ypVmLmZoKp0ZQrPOn04KrEzrtKR2UKnrkXkHej2c9lo=;
 b=Di6I+4F7ngfLNrylAOcGyMnlAyyDLFI6weQbFQrPjrL7K4nbaGqTev+owyya8XZOie
 6ez4OKyv843oXknNaNjXnIDjQQmnFndqV/g1CtfXx2qzN9g/zJ1fPw7MiLduTmbxpaRC
 5R1PLT5iOqqr7Fftnphpl+opVnOFMpGRarAI2CUbsvoGic0vd7CyEQdD6srmUHbM0+Wa
 3h7n0zA9a8j9KjOG/OhBa8aPVvtIhaQVoDuLoseG9J9VB5vFUruszYLV5cq3h/LspljP
 ntH1kG4hhiYHgfobmP9hpNJrV+APo9V9siOLHZKpglxMJ+pkzPhB71L0e7VQkQxKMsQt
 4HOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774570485; x=1775175285;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=ypVmLmZoKp0ZQrPOn04KrEzrtKR2UKnrkXkHej2c9lo=;
 b=XEQZOAnqsTjOK0bBsIRvC8YSQImR5SpG1ls7rseZ41BdSGERF4jEi7przbLDZuMhzq
 8i07gggh/2+4GDKzw4uinVZUwqlXBAs8x9+s8MDfa0+ACi48jHLoGvuv+3hUpeYXF0G+
 +3qib1L5U1QU+HZ0w9Nfkv4iCQIv9Egnno1UqfCyfS1UCJSmSQdxd6xzmsmLRTbQcAPk
 cGXd5vG9aJe41kI/ikdbj4fA+Jb/doLhVblF1QfJX3devU/PHTU1ph4reKptd206kIiI
 AOWbkOgNLeqan0+Syjqz2m0hlzoY9IiqQjxYRAJ38fvQSjPeItxlvdpluvRGTlUwsFYz
 gRng==
X-Forwarded-Encrypted: i=1;
 AJvYcCU2WTcdXwGHgeKf7MMZfVeaz24x8siJT4ejp5+bm6biB+BROpOkjxLzLhqGbYH4xN9l2lgp4wE0ebY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzSxB4qDzH7yjYjLWInjc8D1ir223sUfiROsy3URWseN8BbFZBq
 Tn9V5CvxsW6qYlrCPPox8TI/mRRmG3u0ur9LNKVmRQ8wNfkfps2/SBvLiNQfPbIeHDPOgtOdMaE
 OOud1ba8u7SbPdP8cHGijCGmpQg6qhGqu27F6LnKrtnfLESETBtPQt+HtrC28wBh4o/+BIEo=
X-Gm-Gg: ATEYQzwpHQ/io5fh0ybhvw7QILAZ9aAOyEwoajEIs2xQ3oCdH5hvDCIXIZPLtWJdp2N
 fCiCxrr6PrW8ivdF3HLwrd/e86+c4dhVa5j/iQyBa2IQ/TNgJn4TK7QgEpf5yRhKtssHeneE5dO
 FNHzeH8kguBS20nQRUA55w2V8aJVGu1nvymIts1Oi3T/qLPx7UC5WDabQmQ1Z1ovqgCsVBgedq8
 UM0awPjYS4CIRwH0fWADe8MGB4aFNLwXYUMzGCQ/zIi5z9XzegDV6HUMoJSdAhLd4MfIFNWgd+s
 IG++LUmPrxivfqt9oIgUMwgx8UwaUme5InMDjEb0/QecOEe4oQIV0QRZlJ0jM+jQuVH8cAG0CPc
 hw2JGBwaOnyeoQIagT/WXrpeOLSvsk6OV7D91E4rwlF12sQ==
X-Received: by 2002:a17:90b:4c8e:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-35c300ba450mr459561a91.16.1774570484617; 
 Thu, 26 Mar 2026 17:14:44 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8e:b0:340:4abf:391d with SMTP id
 98e67ed59e1d1-35c300ba450mr459523a91.16.1774570484033; 
 Thu, 26 Mar 2026 17:14:44 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35c2ec799eesm163155a91.10.2026.03.26.17.14.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 17:14:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Fri, 27 Mar 2026 05:43:51 +0530
Subject: [PATCH v2 02/17] drm/msm/a8xx: Fix the ticks used in submit traces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-a8xx-gpu-batch2-v2-2-2b53c38d2101@oss.qualcomm.com>
References: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
In-Reply-To: <20260327-a8xx-gpu-batch2-v2-0-2b53c38d2101@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774570466; l=9033;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=4sNlSSX01xvTjnuR3bo4sHiMTLNkYzfz+0imYgUO+AY=;
 b=46/uTwtLhlypkw7TNF9KlOd+hv8EjygBujiXy/XCtNsoC/2mP0dzG0gCljqXP/6drRoDQiOBf
 Wn90MhhodBCAulHMuH9eYe8SV+w2+Ds3RAkZ8yphS0rj7Fe/x37z5J/
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=dLurWeZb c=1 sm=1 tr=0 ts=69c5cbf5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=wZqpmLHwZRrC_MsAvYoA:9 a=QEXdDO2ut3YA:10
 a=mQ_c8vxmzFEMiUWkPHU9:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-ORIG-GUID: -edAqeKT2H2fXaBF6MEfW6kVCmJ0bxks
X-Proofpoint-GUID: -edAqeKT2H2fXaBF6MEfW6kVCmJ0bxks
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDAwMCBTYWx0ZWRfX/V6tOYCWt31+
 alMOb7lgiTnKtWBGLG1rdcjKfxfrw2RDTQZkvJ+uTr9YUBOmQHmDms+5VuigaZkTGNu5k+vSaej
 eid96jWK+VKz+LY8bfuouzn6z9mgXnlqX4K5WBpvhYDIAv+hGDIMM1M4zkO4o3nJOY6lhz/wnXB
 RVZezoXgLa/Apl199NNMCxvmdJ77gdp8cUUYVc5XIL7VAjNE/Epb2wHkyF+ltx6nnJPqBvr51Tf
 5hQh2AfG1ZyZHlqe/9vu4WKZ5x/rv6iD4eXdpYpN5oB1XBbW+jivV0D+xvNRsu8V1V8M901Z9Hs
 7PBfYQg7isbr5bt5d5Ln4XIexfcoX8HcRI97wi1yl3AnttJp85hE/3LmgmSJhcuTdr9f1RuU2S7
 KYxSpENx7EcGpoiIt1EfJvVBRdwN5tggGq1puCcDH1pJh6L8VsLaSUNEIbG4RP/Rz+fDBKBrCdw
 Rc+B8fhiHr1hwaqiAww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 impostorscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270000
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

GMU_ALWAYS_ON_COUNTER_* registers got moved in A8x, but currently, A6x
register offsets are used in the submit traces instead of A8x offsets.
To fix this, refactor a bit and use adreno_gpu->funcs->get_timestamp()
everywhere.

While we are at it, update a8xx_gmu_get_timestamp() to use the GMU AO
counter.

Fixes: 288a93200892 ("drm/msm/adreno: Introduce A8x GPU Support")
Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a4xx_gpu.c             |  6 ++----
 drivers/gpu/drm/msm/adreno/a5xx_gpu.c             |  6 ++----
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 23 +++++++----------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c             | 20 ++++++++------------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c           |  6 ++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h           |  2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  6 ++++--
 8 files changed, 27 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
index db06c06067ae..0ed8bf2b5dd5 100644
--- a/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a4xx_gpu.c
@@ -604,11 +604,9 @@ static int a4xx_pm_suspend(struct msm_gpu *gpu) {
 	return 0;
 }
 
-static int a4xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
+static u64 a4xx_get_timestamp(struct msm_gpu *gpu)
 {
-	*value = gpu_read64(gpu, REG_A4XX_RBBM_PERFCTR_CP_0_LO);
-
-	return 0;
+	return gpu_read64(gpu, REG_A4XX_RBBM_PERFCTR_CP_0_LO);
 }
 
 static u64 a4xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
index 56eaff2ee4e4..79a441e91fa1 100644
--- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
@@ -1435,11 +1435,9 @@ static int a5xx_pm_suspend(struct msm_gpu *gpu)
 	return 0;
 }
 
-static int a5xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
+static u64 a5xx_get_timestamp(struct msm_gpu *gpu)
 {
-	*value = gpu_read64(gpu, REG_A5XX_RBBM_ALWAYSON_COUNTER_LO);
-
-	return 0;
+	return gpu_read64(gpu, REG_A5XX_RBBM_ALWAYSON_COUNTER_LO);
 }
 
 struct a5xx_crashdumper {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 2129d230a92b..50bd7aa4e792 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -16,8 +16,10 @@
 
 #define GPU_PAS_ID 13
 
-static u64 read_gmu_ao_counter(struct a6xx_gpu *a6xx_gpu)
+static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	u64 count_hi, count_lo, temp;
 
 	do {
@@ -404,7 +406,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_RING(ring, upper_32_bits(rbmemptr(ring, fence)));
 	OUT_RING(ring, submit->seqno);
 
-	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
+	trace_msm_gpu_submit_flush(submit, adreno_gpu->funcs->get_timestamp(gpu));
 
 	a6xx_flush(gpu, ring);
 }
@@ -614,7 +616,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	}
 
 
-	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
+	trace_msm_gpu_submit_flush(submit, adreno_gpu->funcs->get_timestamp(gpu));
 
 	a6xx_flush(gpu, ring);
 
@@ -2414,20 +2416,9 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 	return 0;
 }
 
-static int a6xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
+static u64 a6xx_get_timestamp(struct msm_gpu *gpu)
 {
-	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-
-	*value = read_gmu_ao_counter(a6xx_gpu);
-
-	return 0;
-}
-
-static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
-{
-	*value = gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER);
-	return 0;
+	return gpu_read64(gpu, REG_A6XX_CP_ALWAYS_ON_COUNTER);
 }
 
 static struct msm_ringbuffer *a6xx_active_ring(struct msm_gpu *gpu)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 4eaa04711246..a4434a6a56dd 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -320,7 +320,7 @@ int a6xx_zap_shader_init(struct msm_gpu *gpu);
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
 int a8xx_fault_handler(void *arg, unsigned long iova, int flags, void *data);
 void a8xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
-int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value);
+u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu);
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate);
 int a8xx_gpu_feature_probe(struct msm_gpu *gpu);
 void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index b1887e0cf698..840af9c4d718 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1174,23 +1174,19 @@ void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_
 	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
 }
 
-int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
+u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	u64 count_hi, count_lo, temp;
 
-	mutex_lock(&a6xx_gpu->gmu.lock);
-
-	/* Force the GPU power on so we can read this register */
-	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
-
-	*value = gpu_read64(gpu, REG_A8XX_CP_ALWAYS_ON_COUNTER);
-
-	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
-
-	mutex_unlock(&a6xx_gpu->gmu.lock);
+	do {
+		count_hi = gmu_read(&a6xx_gpu->gmu, REG_A8XX_GMU_ALWAYS_ON_COUNTER_H);
+		count_lo = gmu_read(&a6xx_gpu->gmu, REG_A8XX_GMU_ALWAYS_ON_COUNTER_L);
+		temp = gmu_read(&a6xx_gpu->gmu, REG_A8XX_GMU_ALWAYS_ON_COUNTER_H);
+	} while (unlikely(count_hi != temp));
 
-	return 0;
+	return (count_hi << 32) | count_lo;
 }
 
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index d5fe6f6f0dec..785e99fb5bd5 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -391,13 +391,11 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 		return 0;
 	case MSM_PARAM_TIMESTAMP:
 		if (adreno_gpu->funcs->get_timestamp) {
-			int ret;
-
 			pm_runtime_get_sync(&gpu->pdev->dev);
-			ret = adreno_gpu->funcs->get_timestamp(gpu, value);
+			*value = adreno_gpu->funcs->get_timestamp(gpu);
 			pm_runtime_put_autosuspend(&gpu->pdev->dev);
 
-			return ret;
+			return 0;
 		}
 		return -EINVAL;
 	case MSM_PARAM_PRIORITIES:
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.h b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
index 1d0145f8b3ec..c08725ed54c4 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.h
@@ -79,7 +79,7 @@ struct adreno_gpu;
 struct adreno_gpu_funcs {
 	struct msm_gpu_funcs base;
 	struct msm_gpu *(*init)(struct drm_device *dev);
-	int (*get_timestamp)(struct msm_gpu *gpu, uint64_t *value);
+	u64 (*get_timestamp)(struct msm_gpu *gpu);
 	void (*bus_halt)(struct adreno_gpu *adreno_gpu, bool gx_off);
 	int (*mmu_fault_handler)(void *arg, unsigned long iova, int flags, void *data);
 };
diff --git a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
index c4e00b1263cd..33404eb18fd0 100644
--- a/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
+++ b/drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml
@@ -141,8 +141,10 @@ xsi:schemaLocation="https://gitlab.freedesktop.org/freedreno/ rules-fd.xsd">
 	<reg32 offset="0x1f9f0" name="GMU_BOOT_KMD_LM_HANDSHAKE"/>
 	<reg32 offset="0x1f957" name="GMU_LLM_GLM_SLEEP_CTRL"/>
 	<reg32 offset="0x1f958" name="GMU_LLM_GLM_SLEEP_STATUS"/>
-	<reg32 offset="0x1f888" name="GMU_ALWAYS_ON_COUNTER_L"/>
-	<reg32 offset="0x1f889" name="GMU_ALWAYS_ON_COUNTER_H"/>
+	<reg32 offset="0x1f888" name="GMU_ALWAYS_ON_COUNTER_L" variants="A6XX-A7XX"/>
+	<reg32 offset="0x1f840" name="GMU_ALWAYS_ON_COUNTER_L" variants="A8XX-"/>
+	<reg32 offset="0x1f889" name="GMU_ALWAYS_ON_COUNTER_H" variants="A6XX-A7XX"/>
+	<reg32 offset="0x1f841" name="GMU_ALWAYS_ON_COUNTER_H" variants="A8XX-"/>
 	<reg32 offset="0x1f8c3" name="GMU_GMU_PWR_COL_KEEPALIVE" variants="A6XX-A7XX"/>
 	<reg32 offset="0x1f7e4" name="GMU_GMU_PWR_COL_KEEPALIVE" variants="A8XX-"/>
 	<reg32 offset="0x1f8c4" name="GMU_PWR_COL_PREEMPT_KEEPALIVE" variants="A6XX-A7XX"/>

-- 
2.51.0

