Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4424CD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AA9310F22A;
	Thu, 14 May 2026 13:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ly+hBnf4";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BS8qXhkA";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B807810F20E
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:30 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeUKc889402
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t3fkEBTd8c7
 M226NlRdLECqyLGtXW1CncR7GLKvMNdQ=; b=Ly+hBnf40YrIKMaD5B+wj/bJsUf
 6KzBDm39uQft+bc0Z8k/9w1WvaUuY1eFGFKZUocdP1h55ZoJLe5h2fgVH7RtAZcc
 M3b4+q0Qa9kjjmkkxevdRpGihQ04E7idgQbzXwV5VRB1N71PoYuB1D1BGr4o5rqS
 k9IwjGcsT66Sx4WRrxL9kYpY0OeNj86qRNVys1TJ6HAjHVoRvrc3UhZ1MfHgtWei
 XOEEG71If9J6/fSwHUDiueeOV2t7vIhpdFYf5fzrEb18z2cxaYOKYfEFMGHl8v9T
 PmXyQnNqXf/lWu/TGuxaNOiEr3NwB/5+K+Ep23XxiS0Jy00ZNRdXw42mmsw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjm3wx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8386367b23cso6308166b3a.3
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766869; x=1779371669;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3fkEBTd8c7M226NlRdLECqyLGtXW1CncR7GLKvMNdQ=;
 b=BS8qXhkAYWhggBHBrst+TW3buBXkYRBdGwv9kDVerLohly9nEZbRAlFey3Gkn08HvF
 SiDCCgArNsEks5aUbQe23WkgEc9NVzVFKqfJT9/fHxOF6fUuhWqQ5EWpFqAnfQfimeQ1
 OZyrk5QKDjciHnvO+B7qB/2TNGy9YZiSGRxZ9kUmgydbvGi2HmhwviP4DQAiOVshufUE
 1cAVFzPD1pqX4fNLOh/TIfiDYjbz+AxqVLmnlhbmq2i5hmAGUTt/wbE7Pgdn93rKOzPn
 2aNWgVvnKTQFl+hlRFsRtLG79D3tgLy1xyc3RlDFocLPzI8lDXHmlaBQ7P2AY3SVARDt
 QhRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766869; x=1779371669;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t3fkEBTd8c7M226NlRdLECqyLGtXW1CncR7GLKvMNdQ=;
 b=GpMxP85EIjKfgq0P6xrRAbEUf/EKEktlaeJq4T8AbvyQNcf9QbrCYXyokuDhBZzgIH
 V8VfDbJEI2+PDDFj19yljpyGTVVCddJ6HMoMWqFpbArE+G7d54XHfVNQmv/+Faz9n8c0
 wJ0LujAgQkWztpbCUmJdR9ifa1clRlU5d0CUteuag8OXMCMMIFkKv6qYaWci1idEp9vm
 8Wm06l3FnMYMbLP67SbCNhJkRdYuuII9qVV9vcTzWM6HMLE0Le1HK/Lighmdi9FHHpdC
 ZYGNi0G0SgKcLOCAV3QIAfr5ERLXWzOLBriEJ6uSOwbVnXq3SWoxB7GYJqCfyHQ1Hv9N
 ln/A==
X-Gm-Message-State: AOJu0YzAMHz7w2oe9F2ub0ypRPCetrMjXO4UJliFD3MbGPmIwj3xi9uA
 q24LaBSXLSg9V7V3+FSRwX/K/N7tSsH14vV3epitu757norgCMh+9BZdfaNtlG2I7nMqP1cJ89g
 JVeW51BoUxH1KKxeGXDRux8K+6ZQbm2P8VXE6iYAcNsP7SjFisKM9I9FHuoy/m3MdA1qner1GJm
 2K3qc=
X-Gm-Gg: Acq92OEok8jt0Oj43ZvGARtXl/BiHHNL6KDcUcPxA/5eyfrqhwVWzlFCmZxzKr7DVQ/
 MtV7U3BfmE07XlT2x5e/2+cEfBXwsoBBDfDkkW+LGV9otSWokn1KQdAVLNHYrFEsqGy0+Jw3bkv
 KK0qsPa7B/BHlA16o6JTmx0x3oMlzlHlIf8llMN1BYmY+U06kdr5QB6RmNGwZq9m0s0fpwqOnoW
 p5NGYqxD7O/VvhW43uIw9AyOYqVQlTxTMbQfDDb0vjjYqYi4NG24Y8RVE/Cr5WgoqnnEgPQyh5s
 xSsAgdRa2IsK8WHrm8HFcJs+OgP4GcVWSMXfOwQv7cy99lS/Ho5KsQhrEM+jGcA5C1VDTk3bLNc
 IjrvVuj/sd72/ZyFFEnu4sunA6d0FhBAx
X-Received: by 2002:a05:6a00:8088:b0:838:20b7:40ed with SMTP id
 d2e1a72fcca58-83f042bdaebmr8212909b3a.42.1778766868507; 
 Thu, 14 May 2026 06:54:28 -0700 (PDT)
X-Received: by 2002:a05:6a00:8088:b0:838:20b7:40ed with SMTP id
 d2e1a72fcca58-83f042bdaebmr8212852b3a.42.1778766867873; 
 Thu, 14 May 2026 06:54:27 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19664220sm2638819b3a.4.2026.05.14.06.54.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:27 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Thu, 14 May 2026 06:39:56 -0700
Message-ID: <20260514134052.361771-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: EXtLrd-Fa5rKa2haFTO_9tkqAYtKbT7t
X-Proofpoint-ORIG-GUID: EXtLrd-Fa5rKa2haFTO_9tkqAYtKbT7t
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX4mt6Q+6Mf7jS
 nfDhzTnHrO8KLePukstGng11QZnuHs5GuQA0ZOC58rQ4dZZY8xvJlk53lEvQ4w0nc5q94e1+phD
 harB+VT3Fm6Thxz57SvHFjEIeU9dlE2nqh9RB5Bb+mbwWMM5+5SqxPCZ8FbrRf3IvOq2emPflZa
 wa+8aeQcmRWW2GNds3U1gl+BOUzktqr7w8TQV4xxKit9uZc44PQ/+V+5EULfWnimXBZuxFJuZ2Z
 fpc3MK21zjEz+xuPwu/UNJt+RKjEI9InYZ6J0BZ4SHsOnctgxTLwNM3iowpKfrgowDoVd4/zxzc
 8uLkoydHSVUCClpKgZk2i/hO246ibuPnfZ9RJLMLv7JXPQXyvQXvrSsAk967No4cGZ6LwKp2Dz+
 CwFjNhIcVIPSekRzt/s8WRqT/cLxLcJFCLBbcRwox1fzpnxdQyqvxtRvRYX8tZr3cszOzk8qymO
 kkBoUeItGkNrZlhbJcg==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a05d415 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=7a4_7rcHm0II5uOVc2AA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140140
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
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
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

