Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFF4CD4F57
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E61A10E9C7;
	Mon, 18 May 2026 19:08:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="XTD9TNRx";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VRIqhXe4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB55210E9D7
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:20 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IIA58Z2482392
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=t3fkEBTd8c7
 M226NlRdLECqyLGtXW1CncR7GLKvMNdQ=; b=XTD9TNRxVBVOToW76jWGXBN1paC
 9Tsq8HvWlIIGOKqoO9jRgXCZpgSVSLuIYjflJnE9J4Te6nWiH+lG8BS9QEY8sM3O
 z6n3w6o81DucGXn6H9SgpG7xrkvkMuwbNiDnYrVz2DsEpeY6iC13uK+nevgBDReS
 fjA/M14X7uolSgD82lhMpKrlHAL+9ZyFKhPm7e7GUNJcZ3cMutWjmwU+08MWFUc4
 qsi4G4fHSOut7cGGdokOvFcmrJoQ7hkJQRAeQ9v6IzFkmHMmiflLicqaCm1NLooO
 qXRg+FaOL5mzVn421cMBn6FvVbT5bUO3PHYY5aNTUL94R3P/+olbvvpsNBA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81rvhrw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:19 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-36641bb3d97so1538501a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131299; x=1779736099;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=t3fkEBTd8c7M226NlRdLECqyLGtXW1CncR7GLKvMNdQ=;
 b=VRIqhXe4omDREq3UpP0UqSrXcvH031gBAV5OQfsphkZorZd+uRtRJSuFRi9OcRlX8U
 4gxKEDeWkk5V1gJorsRe/yWtU9/spMbycM28NKsX82wc0Wfskzt+RLYdz1hBBVDGxXca
 SPVHZ37yLQQFAFeHqGNmbhn6VUopZw3daeaXYPvKfZo+lt9YrYhPv8yE1QAj6Y/90Z2I
 95GJSbFo4UNy5WaWpNPdRWkcTr5Y0QhK/S1hlH4CY3Bhd+PxoIMaoeZjNIeBqp9b7aZx
 MPrdvxw4wh6duxeiYdJe8yURln2mmGnOLlVKWDIQ7eHyEkYcZw6fnRBJ6LeNVnFpTzR5
 KnjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131299; x=1779736099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=t3fkEBTd8c7M226NlRdLECqyLGtXW1CncR7GLKvMNdQ=;
 b=P/D2CKbgDyx4gWCd4IGIA1TLTljXKwWUSIfDJ9K0K0L6Ypj4jnBbqkw/Wdywp5uIAN
 t/pAaoIs1lvDDdum8GW6BEiz89obtiRidop3tOanfE8LjsidjskooR9o8tWVykDSaQHw
 +WkupZhEq8SVEF/NxqAIfAstHMgrHokFiXZ/cLp4E5ZSSGzJaUP6aXBHp/31BWUPv78g
 gNuFLh6vKvix3hB+tz4FF3hcmby6HxrsVJ1QBkzrEWVToCUUzAIQ70gAuklWuuWsaX+r
 viTzOQd/HY8hwFiGIQWPQtLyi/1Cz6flfKBnK6A9uB+hSKAA0eCcBhFqhq9qUfcDm+sv
 DDsA==
X-Gm-Message-State: AOJu0YwjiDdjDUNWh37cKoTWq8fjZ33Q+9RPR4ZiNyGLWNMrGGOzba5Y
 4H4kUWBue8kLXujdBRMA54DAtg/dIY5i+cuVFb0B9/9RYcXz5YJXadq9XVUUlATRL/rmTTv0R9A
 +IwqTKbblqWRi0Vn+x/A13mLWIegh9TA7T3k3F0Jc5LvyzjN8jvw3E5rjPvLiLOPRJwcKZQl8fw
 a+FVo=
X-Gm-Gg: Acq92OFfCLfffGT7Dpu5vvRR3V039no933yS7krfd/NelabPwC4xwZ2JxiPLw+S57cT
 Y7Sx4SBH++mKBVoDSPt1JWOxYQuQJihWCtg2Od8QmYknKk9hsskekwoZ66rROEs2Ox5+RO2a7xE
 qaxP0vyTR3nriFAfIVSqVC/Fk8tPwfxgMBFhFUX3hsTbd965jRiVidMYe3gPC6Pzo2txCKrjiiW
 N2uu6PLRbxsDwfD5zCGczHil52imMcePOKngxWN0tCrMJ0++YhmARigdFOGFU/MAUHRhWCqGE92
 Jk+hIQVUQwN8B3PWMDCji/1vliNb2OhO6dM2jTp93NDmwqBk+PX8taigj3nDwZJ4TtoeOvIq6fG
 at0LE87H/9ns/bepnJcm+y82jbTWjOUdD
X-Received: by 2002:a05:6a21:6d9a:b0:398:aea8:a9c0 with SMTP id
 adf61e73a8af0-3b22eb9e9admr18155062637.19.1779131298613; 
 Mon, 18 May 2026 12:08:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:6d9a:b0:398:aea8:a9c0 with SMTP id
 adf61e73a8af0-3b22eb9e9admr18155030637.19.1779131298119; 
 Mon, 18 May 2026 12:08:18 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c82da93df0dsm7667139a12.19.2026.05.18.12.08.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:17 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Mon, 18 May 2026 12:06:35 -0700
Message-ID: <20260518190735.16236-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfX9w9asrctV5yl
 gw9OaytlqkcaGTBqQkd4ugFZqSl+6udDRWehXDkiDVTzmgbfJ0Y8L6jHDJHycWS1/nUIk4DNeuw
 UzpCRbPrqpBeZ2NQ9o3pBX6KD2rH3mZ8+vf82RRCLTo2JLgVPL3pNr4AHwEP0F57/jSSM2YPWfW
 1HKU7IWMs5oPm83yqrqa/M8Z7zqBQKOapXgvSsO/QMq3vAe7fbVJVTJYFbyl/qt7E5dql1OJ6Wy
 etT5eJ/V6OXoROp0oU+NoD+QQ7ooYj+fACl0KV3yPFnPaMW+8rh0mhy9L9FekdGqpWE47Pbb7gq
 UvvJrbcydUx5Vj+J0UyqgtmvoO5b1GVEKgTXuahjxRW+b2Nk6eJN13lOZEUH9MO69yaQv3ksFRc
 4SwBMpYG0FHqLggBIUlUkqWt6EfQaNdaOFsF7FAZ42Kbe3J/Y+3XdtYpbMJIK/g/xrNTECGci90
 WLolbsSiA59ft/6RsCw==
X-Proofpoint-GUID: s43jrsu3ZW9ReSBjz3hWWBvaFcfkjKLp
X-Proofpoint-ORIG-GUID: s43jrsu3ZW9ReSBjz3hWWBvaFcfkjKLp
X-Authority-Analysis: v=2.4 cv=Lf0MLDfi c=1 sm=1 tr=0 ts=6a0b63a3 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=7a4_7rcHm0II5uOVc2AA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180188
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

