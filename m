Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CCFF5A8C8
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:27:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC2E610E7A1;
	Mon, 20 Apr 2026 22:27:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gLs6ZNZO";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bj60Kwjq";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4006310E78B
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:23 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KHMBlL3015219
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2tbDv2EIvIT
 EuQGnte4mfjJJTKVcwabfjQz6jqcfywA=; b=gLs6ZNZO1h7Lj/2qhZOJ/Efrodc
 ybLAyZE0plDpdvsTX8HLc1ekMOL+ePlK6zBr/Sd1uLbkP/Mkw9KjMZ6XEFTpM2QW
 QbknPWMG83ci5JV6vdXOLExWs7ODAtp/KEK13ybQbdaU7/NWklsQIF/IR++hYClz
 ZPapiaxuqkOrlzBv4DQ8NmW+ExyzNxQ+x/7WVS/0sjCUt9Iz9JN8BllcGmajS5JR
 IYVXhzRsLYIw/LyGhGpRNgKizhlTOCb2xgz8HVEo2VJFowsCXyJuyUqpD5Bmsd+2
 nT86+3UkJtZ/esicM2M6lvMZ32EpQdWfiVISIEThySS/V9A9u4J1LpJS/Lg==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnjuktc9m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:21 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82fa2165c3eso1622800b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776724040; x=1777328840;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tbDv2EIvITEuQGnte4mfjJJTKVcwabfjQz6jqcfywA=;
 b=bj60KwjqlMJs378d3O0TGpSyqiwJuoi2iOPVvCHTUAPrEzIWAU5eo5fmc4YDdaJ2Wd
 6wDnnLHKyBZwqh6wkF+msFBUtsn/P1ft9/eYUNyIFcNi9rbMj+KATeBgoht8ahc82TXV
 E5yEWdD83PC8/o1+336CnC+vs1+rYrskcITFIa1RqKuqcWeDoCCkJRkOptD+vQBcUUBV
 +FauIpjU1bKEvXq+NKSpiyY7lYE0ZpJ14AAuMiuaPnPe5JMj5UDv/8HrXSgncfCVI37j
 yLFYoUxUi4RoOpgvy5egX1u3kcdVtMIkFnln4A5MpIqS2Ajxq3J5YGU0AmYfH+s1pQrz
 G/wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724040; x=1777328840;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2tbDv2EIvITEuQGnte4mfjJJTKVcwabfjQz6jqcfywA=;
 b=A0k+ORArwRGlBz82zu5FHST5a5xQuzbPzPGxIJTsEQNLfS4iWkqnLJUvlXanwR191Y
 bO0cBSXQ+acjAVejn19BTP8EzcLvR1/mpsW5z7myRMkwuqYPuR3pqGf+8mOOwqUw64Xs
 nUKzXiZ3x1usjbpwZDJZFSlTh7Pr9GAQLVlhSIVoFvSZXD9AKqn9TWJA5U6c0k/fCDfu
 bQBKvUVJ61+uNyw0hN4GCLqOqaIm6zgc9MrFVGcXX1n3jNwdS/OkeDOpIFqafArY7c+V
 dfsE6V+aIcNROTS3GI0K9+Nd3N1S+zLeeH2xVthHb8f28kcRD5SuVpXQ1jzMo6+tHzku
 Pkpg==
X-Gm-Message-State: AOJu0YxnYXSZOIWDbZaxwri0v+ZQh+3t22u3rZte7mhKdUGGs6GOi1l5
 j1Od+5MTLsEmKUnUbxdP3O7nuw64iCtG2QHLtcnVltbTPirTqJ30UCI3tRPRx1UvynzerGa5Z6n
 U5wjQzIyExCTbtoZOSKi4x9Ir6t41esWIcOi65X55sq7LEXvylugNnVtOM52e77Avmyt3oS1VDN
 kUC8c=
X-Gm-Gg: AeBDietVt+Gk1BIYyIaWej01H338sIcSq2p1a9BjI7Adn72CdErHonFQJ2GJoILQk3W
 lkS1Xjbex8I8lBcC9lmBklBO/Z+VoqaMIvlauQA0jM9DmPrHugTpTmIJLKg1gx+xWwFL2EYaqwW
 2r7e+F5n+Il7VNrrf31EMu+CMhQE6pmTIs2CG5WTgB5n6KwkYDXXKj+PSKC8M/QQAisBFkO+Yp2
 GTfvo6j6Arsv/XcHdt51Aax0etPNzz5KZbo23vy5VhUPKgwGH4GHOd3OA841IJGjSx8GGo3FYfE
 uKUdk2yKzjTKsArLCdDZQsFJgQj69VIY6zKFnvbzYOzwq5utypgt4jqiBhkmFIS/ychhWo48uyA
 Hso4sYuoWyw6yIymegoiFIfLol46HiM9l4hqVzTll3bU=
X-Received: by 2002:a05:6a00:ab8c:b0:829:800b:9fe with SMTP id
 d2e1a72fcca58-82f8c99a9a3mr16205979b3a.39.1776724040104; 
 Mon, 20 Apr 2026 15:27:20 -0700 (PDT)
X-Received: by 2002:a05:6a00:ab8c:b0:829:800b:9fe with SMTP id
 d2e1a72fcca58-82f8c99a9a3mr16205962b3a.39.1776724039643; 
 Mon, 20 Apr 2026 15:27:19 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f8e981c07sm14029049b3a.1.2026.04.20.15.27.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 15:27:19 -0700 (PDT)
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
Subject: [PATCH 08/13] drm/msm/a6xx: Add yield & flush helper
Date: Mon, 20 Apr 2026 15:25:30 -0700
Message-ID: <20260420222621.417276-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: yzmOveSiECGERomuAYeS-3CVyoWXTH8d
X-Proofpoint-ORIG-GUID: yzmOveSiECGERomuAYeS-3CVyoWXTH8d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIyMCBTYWx0ZWRfX4TKQ+7utCHGm
 ojrmOhtbdI2vI22kI/Ki5bajgKo37xJfPSGjTiP1dNvugeaw94kJvCgpQRzOIcTOf1Qf2DPZiIu
 oMXVY/n4resihVCKCWb3nRImuSFocBhASspPIH4qlH329wzplDoyEaS3xO9pxQmCv9aWXwEsVGg
 T2XFSFZ1pFKHtnH4IPh3q+Jmvk6x56jeaRaxerXqYUcv7f9mGKWyKvoZd7xghD7RkkqvVnAxzCv
 T8ctQ3b0R7uA48ZqZDU2um+863RmbHeG5nVwXUhNbZ7VnB6waoeUTZBIQ//SC0PbnrQnzoLQTW6
 b0shGAFwGsrQ2carSW6KNOs9XQ+z7SjE4NKf8hK/kJViP/04hye+mJdw43kQd2W831uDtR9B8Ux
 z31C/FF6RRzOdKge1m5MHjlyVErxdO6vGHrlNzXpdtFmDT01IWC6ec+sN2/olSm2Kmgi1OoUc+s
 LX2IA23Pz6u3r83M3qA==
X-Authority-Analysis: v=2.4 cv=WuUb99fv c=1 sm=1 tr=0 ts=69e6a849 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=7a4_7rcHm0II5uOVc2AA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200220
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

It's a common pattern, needing to insert a yield packet before flushing
the rb.  And we'll need this once again for configuring perfcntr SEL
regs.  So add a helper.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 55 +++++++++++++--------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 10 +----
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 71f54ab5425d..415902f6e5d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -189,6 +189,30 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 }
 
+void
+a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	/* If preemption is enabled */
+	if (gpu->nr_rings > 1) {
+		/* Yield the floor on command completion */
+		OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
+
+		/*
+		 * If dword[2:1] are non zero, they specify an address for
+		 * the CP to write the value of dword[3] to on preemption
+		 * complete. Write 0 to skip the write
+		 */
+		OUT_RING(ring, 0x00);
+		OUT_RING(ring, 0x00);
+		/* Data value - not used if the address above is 0 */
+		OUT_RING(ring, 0x01);
+		/* generate interrupt on preemption completion */
+		OUT_RING(ring, 0x00);
+	}
+
+	a6xx_flush(gpu, ring);
+}
+
 static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 		u64 iova)
 {
@@ -597,28 +621,9 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_PKT7(ring, CP_SET_MARKER, 1);
 	OUT_RING(ring, 0x100); /* IFPC enable */
 
-	/* If preemption is enabled */
-	if (gpu->nr_rings > 1) {
-		/* Yield the floor on command completion */
-		OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-
-		/*
-		 * If dword[2:1] are non zero, they specify an address for
-		 * the CP to write the value of dword[3] to on preemption
-		 * complete. Write 0 to skip the write
-		 */
-		OUT_RING(ring, 0x00);
-		OUT_RING(ring, 0x00);
-		/* Data value - not used if the address above is 0 */
-		OUT_RING(ring, 0x01);
-		/* generate interrupt on preemption completion */
-		OUT_RING(ring, 0x00);
-	}
-
-
 	trace_msm_gpu_submit_flush(submit, adreno_gpu->funcs->get_timestamp(gpu));
 
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	/* Check to see if we need to start preemption */
 	if (adreno_is_a8xx(adreno_gpu))
@@ -958,15 +963,7 @@ static int a7xx_preempt_start(struct msm_gpu *gpu)
 
 	a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, NULL);
 
-	/* Yield the floor on command completion */
-	OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	/* Generate interrupt on preemption completion */
-	OUT_RING(ring, 0x00);
-
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index eb431e5e00b1..99c3e55f5ca8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -317,6 +317,7 @@ void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_
 void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
 int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 mask, bool is_64b);
 void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e022c9a162a4..124d315b2469 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -488,15 +488,7 @@ static int a8xx_preempt_start(struct msm_gpu *gpu)
 
 	a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, NULL);
 
-	/* Yield the floor on command completion */
-	OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	/* Generate interrupt on preemption completion */
-	OUT_RING(ring, 0x00);
-
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	return a8xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
-- 
2.53.0

