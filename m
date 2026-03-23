Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A00F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:12:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBCF310E3E1;
	Mon, 23 Mar 2026 20:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CsFE33tL";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HU7qU4DB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2844010E3E1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:46 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqYPe2971815
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 WO2JyAUszUgTDdy1Htc6BOSwNDnhDSWgUZjYgndONWg=; b=CsFE33tLiaqHd1HK
 DB8KZMgGNpRNmMSKXDYtO3ffDHtmGt2oC/61hAW5BF1+4CcFT1W052bt/rYPY4Sb
 4fesmgyuJwLUbyKIfZgA1QdEGu8m2WjJyh67yH16fWZaoEyxSe+W54O5TOdjo1TR
 FUXTKaXcYjP6lpvQjyzzxdQOhDFCPQVV3qxT9G8SyBIQMCQgC3tLEiSM7iu+z2Cp
 jsKCc2b1WjuOt/HbkZ/bp1mVc66hQD8ULNYuUWWkBYJOa3JUaE7k1EMQKdvhadro
 X2itKnJA59LnPyKwkEQwbo4B6Bf4P6DtsL+luX74PurqbbHeGDHjyG+mHP1JNk21
 r2srVg==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d31jc2kwb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:12:45 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2adef9d486bso28146995ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296765; x=1774901565;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=WO2JyAUszUgTDdy1Htc6BOSwNDnhDSWgUZjYgndONWg=;
 b=HU7qU4DBR3MMRxCNPP6ZFXa2NJ1fR2JIdw/ha+bzPxq7SHIml/VYLlWb899AOoeviH
 eQUa9q440UmXh3OS1MJltORA6ZAWuaIZ+dss29TWudBIdv0A9AgkPv9M0JOiJsF5AUCq
 RV5A1e/hozLZKzyXxXF3inNxtNdUbBtA91nmkMu7XlvKd0lCJq1K8O6fVfUrK2ez+7Tx
 j61Oph9PDLO1Di2BFDi1CvbckR3qJJn2mHKqmvKEZFRNxhcHVQayn8Pv9atQNXE4EQrO
 9Fe1cAGkFStll1yIMQpuhW3/w66Bzz7UeUiKwg2ZZutq/pjfUYFPZ1mvCTfPhvWm1vi0
 VYZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296765; x=1774901565;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=WO2JyAUszUgTDdy1Htc6BOSwNDnhDSWgUZjYgndONWg=;
 b=PGmgfjN301uT8CP266t1BotU/OuduFHsk6V8761f4th/ekgqH8YvQ8bqImhch06iYm
 VaCO6EZoJg2X2lq05SjLZWvTUQoMWSCShX1glmnxlkdJfnMkCEOniLQhL56d0tKpDSjt
 lomBKfIa9RH2JWrAV4pL2M5XbGpwbidRJRsYiX+Tie5RyBOYEH+MD0hdOn6LXoVcOfON
 64U3xvsIwapffG7yV/nUuu7gtZyDGM4H03xlBRawv35T48skidmhxP+Z4N619mm5sGTF
 wdy6SoEKs2QqsfZA7JJmIG4Uzg43wqEHgIVFruyoBCnGO8F+l7puJVzuYIozjaQiXFyB
 XLqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWUl8roOjmJ1iX8u3nrbLGfid6kP6V2WKzqwdOp+HVOVNASyfkSoMP8FkSYRJ3k1D5sk6psRkQvfdc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxwbfWwxuDoFnAzlfQQenx0ek6VQNg7MbCy21NQUodmC4L/FM+N
 vUQ3car3h75wVzuALXBXGxQkz2Qug/iaJPIbnEYg5Lm8MQTLbynSFP9haYNq5yRTd2OY3PlYs1p
 3sovpdRYyt7nRDDnhvKKBQPQOh2l5jwg0Cb3ZDoYbwnuCLuqE8TD3xg9CC99WBYAczLEGsPw=
X-Gm-Gg: ATEYQzyg25vIFyHg7TdTTzH5m3Rc9zCH1ESsUtPOE79sthMS3BzbQoCg7XZt5n5VTY+
 s/brsE5WY+uiVYdyNqCMKNJTvERKDLalyoZSfSuQ4pxI9rokG+bS0/bnlrf/ZZREHEfPcpjFN5d
 2bg2wET/lqtaQbsQ9FyMj8bxTBPUtMAWv5Rmmshm3mDaVVoee9XOADf4wUn2AuEDeYfX/M06kpP
 NXQ8aOf4hyI2WVnE8IKHw7P/+wciYeWLeXwqMTlq5iosoVTqFvhaK5V2IgfvmaflvQ+JPdDg7Wk
 9wFgdH/u2liVUyLixSd/41SqPFigNtpDkuvCL3cRBuBDHy59/ke+gw3jeV4Hm4ZPC1mC+nCvA7N
 6f/96fOXKPcQbyeQIu6cCZH3v/IVqvmvR+/VvOkZDT1WUpw==
X-Received: by 2002:a05:6a20:2448:b0:39b:ff0b:8aee with SMTP id
 adf61e73a8af0-39bff0b9fa2mr5896614637.14.1774296764812; 
 Mon, 23 Mar 2026 13:12:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:2448:b0:39b:ff0b:8aee with SMTP id
 adf61e73a8af0-39bff0b9fa2mr5896586637.14.1774296764273; 
 Mon, 23 Mar 2026 13:12:44 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.12.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:12:43 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:13 +0530
Subject: [PATCH 01/16] drm/msm/a8xx: Fix the ticks used in submit traces
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-1-fc95b8d9c017@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=9030;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=fyL0L8FEEG4BJOzg7sRyFwEc/V7XoLzUNjMTow7BabM=;
 b=WoVnh+xAwdmgIsxoc5bnSMg4stSJg0DQtUvfoxU39imw6AQA1PFGFTB8+vm9WY4F7LpERgo3q
 6hKl2kE7XquCW84IoeGDu5hLPM469V8P4RhAhaTdmy0lzsGpC6Vgrfh
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Authority-Analysis: v=2.4 cv=fKc0HJae c=1 sm=1 tr=0 ts=69c19ebd cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=e5mUnYsNAAAA:8 a=EUspDBNiAAAA:8 a=KCeLXEH0ftFH6332X0AA:9 a=QEXdDO2ut3YA:10
 a=324X-CrmTo6CU4MGRt3R:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-GUID: p1MMy39YHsNem1SFy9BsZrnY8oEgj5Ot
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX7X+nT4hl9SWY
 55d2dnzi/QTLCA9KlsGvMD4yqIupG40wADbGA3cVmye6Nl31uC1ver1LGiPQZRj9aIiY6zo8HIs
 AXn+rY2RMZHxCXfC1fBuOkjr4oHYosm+7o88iiOekgMuLa4cLTmYxQnA93EMWBfXVI3/cyxabYO
 wU0MiJ0IVfaLJLPuAAJFvcH56GrboARH/r4Vn0m7CSk+mAo7fpuieQ10H4ts7pJOtfiRe1YhfhZ
 CtXy5wFM95zFiu2SgV+b7oqMUIkmk1Pp9NM+XyGasEF14R5PTMKnvK1rM+jpk1A1d+ErR5gGDS7
 dCaoNY+yCPLHN9hQTXvy085IrBvPijBN0H8FsqLwjpRT+xwHpyE/YgUJWa1RrWMUfzP788dVLkZ
 zw8tKP2IKXqe3gouNyxZCLZzMM4vnyoohJz33PLV0++v5AzbUapCNCxS6xeOyr0Og8PJUVh16jd
 n9qW5JcwVjSLgRa7jLg==
X-Proofpoint-ORIG-GUID: p1MMy39YHsNem1SFy9BsZrnY8oEgj5Ot
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0 malwarescore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603230149
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
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c             | 15 ++++++-------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h             |  2 +-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c             | 26 ++++++++++++-----------
 drivers/gpu/drm/msm/adreno/adreno_gpu.c           |  6 ++----
 drivers/gpu/drm/msm/adreno/adreno_gpu.h           |  2 +-
 drivers/gpu/drm/msm/registers/adreno/a6xx_gmu.xml |  6 ++++--
 8 files changed, 32 insertions(+), 37 deletions(-)

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
index 2129d230a92b..14d5b5e266f7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -404,7 +404,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_RING(ring, upper_32_bits(rbmemptr(ring, fence)));
 	OUT_RING(ring, submit->seqno);
 
-	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
+	trace_msm_gpu_submit_flush(submit, adreno_gpu->funcs->get_timestamp(gpu));
 
 	a6xx_flush(gpu, ring);
 }
@@ -614,7 +614,7 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	}
 
 
-	trace_msm_gpu_submit_flush(submit, read_gmu_ao_counter(a6xx_gpu));
+	trace_msm_gpu_submit_flush(submit, adreno_gpu->funcs->get_timestamp(gpu));
 
 	a6xx_flush(gpu, ring);
 
@@ -2414,20 +2414,17 @@ static int a6xx_pm_suspend(struct msm_gpu *gpu)
 	return 0;
 }
 
-static int a6xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
+static u64 a6xx_gmu_get_timestamp(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 
-	*value = read_gmu_ao_counter(a6xx_gpu);
-
-	return 0;
+	return read_gmu_ao_counter(a6xx_gpu);
 }
 
-static int a6xx_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
+static u64 a6xx_get_timestamp(struct msm_gpu *gpu)
 {
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
index b1887e0cf698..987c99097d40 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -1174,23 +1174,25 @@ void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_
 	gpu_write(gpu, REG_A6XX_GBIF_HALT, 0x0);
 }
 
-int a8xx_gmu_get_timestamp(struct msm_gpu *gpu, uint64_t *value)
+static u64 read_gmu_ao_counter(struct a6xx_gpu *a6xx_gpu)
 {
-	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-
-	mutex_lock(&a6xx_gpu->gmu.lock);
-
-	/* Force the GPU power on so we can read this register */
-	a6xx_gmu_set_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
+	u64 count_hi, count_lo, temp;
 
-	*value = gpu_read64(gpu, REG_A8XX_CP_ALWAYS_ON_COUNTER);
+	do {
+		count_hi = gmu_read(&a6xx_gpu->gmu, REG_A8XX_GMU_ALWAYS_ON_COUNTER_H);
+		count_lo = gmu_read(&a6xx_gpu->gmu, REG_A8XX_GMU_ALWAYS_ON_COUNTER_L);
+		temp = gmu_read(&a6xx_gpu->gmu, REG_A8XX_GMU_ALWAYS_ON_COUNTER_H);
+	} while (unlikely(count_hi != temp));
 
-	a6xx_gmu_clear_oob(&a6xx_gpu->gmu, GMU_OOB_PERFCOUNTER_SET);
+	return (count_hi << 32) | count_lo;
+}
 
-	mutex_unlock(&a6xx_gpu->gmu.lock);
+u64 a8xx_gmu_get_timestamp(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 
-	return 0;
+	return read_gmu_ao_counter(a6xx_gpu);
 }
 
 u64 a8xx_gpu_busy(struct msm_gpu *gpu, unsigned long *out_sample_rate)
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index d5fe6f6f0dec..1bc0e570bd12 100644
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
+			*value = (uint64_t) adreno_gpu->funcs->get_timestamp(gpu);
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

