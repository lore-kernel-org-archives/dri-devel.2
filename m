Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41D8ECD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D8AE10EE4D;
	Wed,  6 May 2026 17:12:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gzT/d7WN";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SZxM+XKP";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B12F10EE4D
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:12:03 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646GmX3i1953133
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:12:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZFtTLmOQAzj
 qHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=; b=gzT/d7WNqGmxVLtlW2PMnUu3LvO
 pVFpqm0R0wCsUY41DCKVjP4WEJG848U6lwXUmChfZgW3foHt5xBMZEzzodKLVuQk
 YOjFliIqCsy376bDsAaohLxPxr0skFqXIrPbgBQAafslEA+ozXZUIRSKkRN8rPJJ
 Ctq6N0/XeVV+RyKlv2Y4DBpZE10B3PhSxim6SldaRhhFQqH+IDhOq2DcvMS1Lero
 9lRcWHDsYfDQN5uiIpymmD4xdzgvadFDP/CrWlIdlf+zHC+nuGsLFRB8wJ6Ovoyt
 iAyLdP/BhWN5CV2WMSV4i1m8uHUmAVkopggu2YKrKoSs0tj78mWzMWKs4UA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jc1mje-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:12:02 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-364f007d1f3so731695a91.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087522; x=1778692322;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFtTLmOQAzjqHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=;
 b=SZxM+XKPkLyBAHYT+aSuXQA7hQaBLZk3k18V5rbHs173A+MzDGaFUVbXxQf+ifg+ik
 fSdJAfYTwrUAo/DqncOlVqArVp9wAuMllMb7iNkd5qDrzQlu34edovXSe+DoSgC1EYN/
 wZQtGfXHOvX+WBqJqlE6YzqKTy4c+mfkFJBL9xKVZoV6EVBqzqU+WshJxME9USH94zfp
 VhYeFU5nGr46e2C2GH8FjcmA9AejQB2Ihqdar2nU9O/8883Vxd7+F5TQPRWka0NAdbFe
 CbcA28JuW1FnaV2L2jBtg7E8JV1f/Pqa8OUe9xK8pLXtu0XZ2eQZGk9L2TdRfJGASh87
 QCyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087522; x=1778692322;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZFtTLmOQAzjqHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=;
 b=lFo7IP0nr9bMDLdH+otTgzsAXTd4IGRzTy87TNQTd4NiKYjmdeG/IG0VQGMI1Vx9yF
 5bOWaFmQAE/3IjLhJZdqHAp0Cfg34w6O14JYF55ot/NlFUIsQbPpGZNh1YHkcuj6+SJ2
 s0hVG/D7QFG47GtshQ63Ay3imEBhiAszh7Wx24Ioc2wvOC51sl6sNJPdJKN1ei138CzN
 789kxdjo2f3j6pUe1CYgeaJ7TjESn4kcrSFqjr3mfDm9tnhMpSAJZQsgkADBK+L4Bj6t
 z1SKFSSH+BGRg7XzU+BOZWUGUrc7JBvVLylELUKdXNV/h/gSA0AWCI7TKJvhB2cDjPgl
 ZPOA==
X-Gm-Message-State: AOJu0Yy9qFUQ0X6gS89WGp4qpPx44F1SKMcjsZqDDAKhv+FhJQGzFIpk
 NNYVAqoVKHX6fyTeOZzXG3j/4Xj/98NmSufafT9KPdh4IItOgwerJSAdNt3VMRrfrQa8gaGImzf
 0GX9/1GxxztnkhcDH1nCxfLatn1obWxd+jHHjPJoQXajSsFgZEL2GUtDgn3cwlDzGj2fqcrLxx+
 O438w=
X-Gm-Gg: AeBDieu8COgqJ9VZ1PB0lg+nAn41/vVgt+ES/N3OILuNhuqw0rr94IdaYAx6XzWdkoJ
 9Y65Un2V6zSl0mAmjLOTCbGgtXSKHb6uf3Z51ky3TOhY4rXSPbT3lvZYe/d2yneZmY/Ek76hwn/
 VfFcDj2st6qC56zCFC2JujiA/kNRg3ojfpzRBLabVM6plGiRGuuZ98fHMSXO/63NfRrjW6Tw54p
 qYDrEogC+VgUFg02v9U9YLN/FBZmuedtEOTFr9N+T+xgkCKiew9yU63aXkJtQhFAGSxVdfBqMXh
 vXmYh3sDeSriLHrYbToGKPRX2YK/Nu7H3H8YmGkvC3Ny0pCiYWeNvlZi8xCuB5RARNYz6kZ/pID
 CFsHRLnf0cpN+UaQ2i07REK5mGuhhifLoJeFnr1uwxSY=
X-Received: by 2002:a17:90b:3d08:b0:35f:bb17:39f with SMTP id
 98e67ed59e1d1-36572246912mr7800354a91.1.1778087521640; 
 Wed, 06 May 2026 10:12:01 -0700 (PDT)
X-Received: by 2002:a17:90b:3d08:b0:35f:bb17:39f with SMTP id
 98e67ed59e1d1-36572246912mr7800316a91.1.1778087521065; 
 Wed, 06 May 2026 10:12:01 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8242ac9146sm2903659a12.8.2026.05.06.10.12.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:12:00 -0700 (PDT)
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
Subject: [PATCH v4 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Wed,  6 May 2026 10:10:32 -0700
Message-ID: <20260506171127.133572-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfX+YVunCAA44ui
 zn5nXHH/COsfDfOJ9mUhu35SvX+N1R8pZ4HgqVGAwAUGEHR7jBrul3IVvfZls/FEGFPs8yiN0b8
 5Ln9uTO6UBLuogpHsXRSvYmvwJRhEjspVzJqs45kDz3lltHElJB2/WRieZ9M2qzgn8KJIGBq8AV
 g2k2YOOUH0zVvAErl5mQZj8XmM/3Ej9d/n4O8T4JqqO3NVjwnsK/jF5odYuYxUOg3YU5DZUh4PX
 n2pGfnHAxyFJTOrv7CUfrAi6RhxTAvW2N0IcPaE7wcwY9Hmd05F17Nd27NDMHFBCH6FTlQsK8nV
 Zi4b/zmsvnDb9HleMpJtvkgw9znUpnuaNNtPbguQgqDJYF4bq26eNEIrwuXVcINEEb3HriD8C8/
 xmtNw1MiHOsmITNZ02h/UGtAEO3uyofGuNcZBHiY2UE43ZHc47Rg5lWabhfgOmccdeIQskzGHkl
 Jy0JewucJrYetCwmWMA==
X-Proofpoint-ORIG-GUID: 7Gg_KN52xNqHPwaUyjBtG-Kx29GpBvbC
X-Proofpoint-GUID: 7Gg_KN52xNqHPwaUyjBtG-Kx29GpBvbC
X-Authority-Analysis: v=2.4 cv=EpHiaycA c=1 sm=1 tr=0 ts=69fb7662 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=7a4_7rcHm0II5uOVc2AA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060168
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

