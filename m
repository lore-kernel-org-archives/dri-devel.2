Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3507ACD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EDA810E822;
	Mon,  4 May 2026 19:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cf2cM+FH";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EAZ4goQf";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9C710E831
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:36 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644ELnpf1960446
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZFtTLmOQAzj
 qHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=; b=cf2cM+FH6ACHDWi0ShgqF+Lpf09
 /By6SaAMHztFm2ApbaYtnaM15NdXB/euzLVNLIsKq2uH5WTxZeUrUyf4zipqYHW0
 0x7wHXlyzvH9NWr3LuR6siIqrouAxjsLSCgkGuyOKRcBiLF2WuZfi3Ih+YgQQBm4
 cD7UXceANKX9CQrXQBNlKb0+PA26eB0Va1U8nbQekbE4YmW39mXnpWTyzuPx8Fc3
 4ZyC0iOLR0mzDLAyMSuG41W1kPCwQs6MPh0aDkQiy4nE5FkTxpysu5WrSKTb5w/H
 6THLiqNr9OGWLUrZrBH0wuWH5pW70GJ6v3Vrr2BqgzYLfOcZ52Y+FRXrYfw==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5ds5mn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-c81086bf930so617198a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921715; x=1778526515;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFtTLmOQAzjqHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=;
 b=EAZ4goQfmTgTNnt1S8tJ6AejaaWuZpd3HvhHJNveiFox87lydJkdS1PtUvB0+E4F/3
 SO2CABGjWn56qZD17L+6tIwMK6QKE5NUXWGXRRNnyYuXVLgYmoO/F9G7Qq3E6vMtHNq7
 1N4xYWYtZAC37ST7oX+eikvOd4W2DnziYjJknVZn+AIoYEmOwu9lG+lmkdmJPZofuzAk
 Nyw+FAnsnUjdti99xsPgIjLa/8qDNbdmOT3Y83PdcrJiNO4+YMbvIh746cHaF7Pk0CwD
 w9MDY9Hzp8KVyEK8uI2XDlEl2ps0I7cLo12tJ8Y3mkn+gW2unjcNopaqAaPy8o/Efoox
 faXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921715; x=1778526515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZFtTLmOQAzjqHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=;
 b=sNqL5bqSAwfmEVdGoeV5HYrTVpk2aWsn4l0YxgH7h56u+U2nGPlgMpdSEIc+pl0g+Z
 qhkaqDTJnmIAqPw0rD2ZvyE32/BsMgX1W/KK/qKoXMyfMPsb/nGscX0hLcZ+/HTeliX7
 hMcd4grlaOhY73CVWhutMyY/BNiwGDO4he6r8RKolmdOKMqQK1BpO5AAyKZyQ4ok7k4c
 TJyMi4TBQAvyZpHHyntQEIv5Hy1P8Ckw48FLUxai4bTt6WyS5gI+5T7K46VJuomGO5F3
 p8Sf2+1LFZCHKeRV8GrWQbhFzaCnMV+MCUSLAzeSxeDfebLVKXjWkCCys+7an0ZDh3y/
 vo+Q==
X-Gm-Message-State: AOJu0YzmcVLa+pdvq/ApjNJkbIG9m0UUx704WFb0e5dUOEvos3eAUOkf
 m5Tqn8C0tjL+bxRcTfK3ZARqbJqh+Bf7wg/lkSnHrxSr01PKRq3UwbGJf5rjcQ5B+xj/v8Inyvr
 FPUBxqHgtfbEafMXyolAMsze2Ix5U/fSje1628yQM5+DM1yCMZTk3s6O40+P+vB++rFOMrzzrT9
 QMGI0=
X-Gm-Gg: AeBDievmBr8fyiZpn2bYK8SEfhssyOsQ5bdcKXnd748wVdQptq6VMY/gC2VrrNzhDB9
 fZVMInGvy1jSWecR2dgtRZlR13+XoeacqzYxTlyi6NpaPMzmsKpyxxUtyFJzZiwdaTgmEcxEsX+
 JfPTbNDHl46Ma1FjKc3r2j9wy10xoLkHwOFALU/VMntEm5OH7waR9bnxHmNOuJbphYRxcwH4RO9
 dBm71dvobtjxV6t2SB406PYb/CCwNj9co8DpO8++ZJ3UAkNNqZEioiLlmpKm5N9Mp4j0O5kaNPB
 oPtcg+58VvBqy33XPgKwOBXteGrIbxoZdskoQ5Cxz8jnA32NAgGmiazp5H2HNenLk9xSOmkZ+pG
 fjnH7Lyr2KZKw4MKyDKAE2b0mrrt6v/fPX3WFJJZE3OI=
X-Received: by 2002:a05:6a20:4305:b0:39b:ca34:96e3 with SMTP id
 adf61e73a8af0-3a9f77bd7a2mr567268637.37.1777921715020; 
 Mon, 04 May 2026 12:08:35 -0700 (PDT)
X-Received: by 2002:a05:6a20:4305:b0:39b:ca34:96e3 with SMTP id
 adf61e73a8af0-3a9f77bd7a2mr567242637.37.1777921714478; 
 Mon, 04 May 2026 12:08:34 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbb05798sm10380209a12.0.2026.05.04.12.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:34 -0700 (PDT)
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
Subject: [PATCH v3 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Mon,  4 May 2026 12:06:51 -0700
Message-ID: <20260504190751.61052-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfX06QnBSGSBRoF
 OpQoGjjJaB7SPJ8G76Stl9odZGvN+c3JVkh+bpX6FRcDkEzynYaQhxdGOIa6qpDkE0iS3ipb7gM
 sMz/lZBWe/I/JYJm6vOZzPP7h/mPUhOhGHiLoSnBYG2c2QFrLEDbi3K91gsBPIub7PkP0IMEWl/
 6yU1gqMw+yr6/0wcyuyR7x298O0MKM8k38nxO3PhG7Jj1lc98qC3blKUsLyR0s7MhRy6DskMq3T
 hCP5LdwQIzejNfIURwcKRporSt1aCDuCQWE4sXYD0ROZqFsrIdS1HZElp49ZHo/HIj+SzkjL5qr
 lhOnYRnzIbseTWCWpm5nv1sbArCYuJC3krZmo2UY1pYgc8cgkwbB54DcwitFiEWCF8n0XHN/DG1
 6ZgKBXnRZDkmLMsM6A4XV1MZgLirvg+CLgeKB63Ofxzdhs5FeRywMKFUiZ8nAm3/7WwiYRwzpZj
 NgLrfgcHPbXpizP8Baw==
X-Proofpoint-GUID: Z0Y_4fVRy4OM2IbuKcV3dbpIDHhmQy0L
X-Proofpoint-ORIG-GUID: Z0Y_4fVRy4OM2IbuKcV3dbpIDHhmQy0L
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f8eeb4 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=7a4_7rcHm0II5uOVc2AA:9
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040175
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
2.54.0

