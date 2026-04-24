Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D667FED3DF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C46F10F602;
	Fri, 24 Apr 2026 15:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="H+fP8P0P";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DzwImTHK";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4A2E10F602
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:12 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O9K26I2710298
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2tbDv2EIvIT
 EuQGnte4mfjJJTKVcwabfjQz6jqcfywA=; b=H+fP8P0PCGkZ4VKvQsiyXXH6pAI
 PWMDUQg3mPbCCkxLd61NwCxbx4AHOx2blz5ZOWB7nZL9kmcNzjLJ1EtXk7wxL3hN
 c/pVYbREtelpiif/vSuyvc3hWu29jtW+ji7JwmWvceHTyqU8FTm5+ygj7yBbSh0/
 UVbYsYHNZ7ydvndsRtR/rNTzkHF/u/jzhya32hZK+B943SZGE3ogTLILjQnq1FSx
 DvOcyGccc5XrbE3qGDieMdBjBijYPnefESJko51p7N/OVaO/6ZJQkZxsbTiwaahx
 aMNdJqJzTchKpF8kvO7pesYac8whsR7WwLFLkxy9QnxUBwnfVL1GENTaZ3w==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqqu9vr8t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:11 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-35842aa350fso15802113a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043531; x=1777648331;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2tbDv2EIvITEuQGnte4mfjJJTKVcwabfjQz6jqcfywA=;
 b=DzwImTHK2k9GMV1mkxVo+ZDcj3BqeCYG5qMc642IRgxVpjduQsblxhdob8J45SqC/h
 9o87SDfd7u/CJAXjS8n5pj+ulDIY2SUZnoQ1Yoj8ISSZaBQfzpdbB0BIyL293Ez1fz/U
 1V3cTNbl86Ctt5nGvXlw94dvp/LRLfNWprLnzHinTnL9ZFjPwvfrSM3GVzwrXkbMlGWe
 g27YFAtph/zWhqXvsVOhhsetwrKQfC3abK5Xj8ZLL3XgChYTDv/GNiXf58JCRN4hHIYJ
 GRtQgPBvG2vLOEDIX/QozqMGuIyfVr67okVL4lP4b80QEsLfLDWn+aR81+QG4UwPioPG
 51Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043531; x=1777648331;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2tbDv2EIvITEuQGnte4mfjJJTKVcwabfjQz6jqcfywA=;
 b=CbtCJb0VG9Any+jzYuhhqjRN2aaoMcTw91O8Bza7SMRV/FtKTmr/FlreZ/6g6dtwfk
 czN5B2cBM3QwaG+vJzzUF9D9jl/R3vE/JlDEIl4ZrhwboVZcLDZqqCyRzdPtp+PQsrjn
 CH6pA5LysUGM6LE5GxijzmVYEPMTuW9o9vsTqRecTuIRgeo/TsF3pE9yk7thQFwYIVNx
 5Rblj94yGKqf2vThJCjxkpOpZ6UAprFxc5oznW7+3oV1YDmx75uHVzQIgvjcjB0x8QJ+
 lqXxFJNXC3IotcrMyIVoFPkqcuv9v74Ju0QYQ+iEhOmCHb8H2qPc/a2onBDzyGX8f/Kp
 Kn2Q==
X-Gm-Message-State: AOJu0YzZ4CkMbkigMRV7qpBNzLmtmVqKfR+ObC+KCUApwQ91BDwAhI09
 bLUvNichlbwam5jpvqdqfFocvpxq9tXysAfZUZ7W8EVNu0xtZjCdGFBCMplw/Db+pFQvQiBnuRt
 hESwmBkupW0fOwzVyqGHo7Mq7ccxw0bZJXpg1YrO2nqcujjO+a9tqxPY333/8Ei5ZHMrXRGBILO
 Vxf1M=
X-Gm-Gg: AeBDietV0Rusnz8xGKZ+hpKUBE1ABDHIxRNe9hH2+05BwYw962TOdqqOFwt/NJY/wnB
 35rX/yHs9TIRk9M85eoMiC6S8uoJxDlewtdo69Zpw2sKNFP6nE9x6TQHmRqT8Vd0VSO3LT15hPj
 M6KOVEE5BkOHnYla+i02fqsp+5ZyYBQZlZZDRcgkczRD8Rat4Ni72TljFxqwTOEJHKJHRbBvkoa
 nfCOZECkcfpAr1Lr2M0iZl4/GatoKk26Emv71rVH++ghSJyijIMgNUJjffHaR1Czkt9jDcUIdRw
 DAdrrQvvfbSoI4fZVt54UKPH0MYlXZ387dLfiMspZfeAo6iUIfcrSkFBkyLj47MqYKldav+fX6s
 ZxLu7GT3bYRCq8OLiJSDAGV+03sYsC450LVVpm7iCXsw=
X-Received: by 2002:a17:90b:1fc4:b0:359:8de8:1229 with SMTP id
 98e67ed59e1d1-36140490bf8mr36783572a91.21.1777043530261; 
 Fri, 24 Apr 2026 08:12:10 -0700 (PDT)
X-Received: by 2002:a17:90b:1fc4:b0:359:8de8:1229 with SMTP id
 98e67ed59e1d1-36140490bf8mr36783527a91.21.1777043529584; 
 Fri, 24 Apr 2026 08:12:09 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fab20c4fsm285138165ad.59.2026.04.24.08.12.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:08 -0700 (PDT)
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
Subject: [PATCH v2 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Fri, 24 Apr 2026 08:10:43 -0700
Message-ID: <20260424151140.104093-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: e7bkDVb97elk84n3zYNGrDTYTDZvp2lE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfX+/FsA3S02JwE
 h3z5K4hvoC88omyAM7+kCeTLq5qrE20qA4JsGF/puIFNddA2n8TL+PQiar28B1Go7ROp1kAyDvs
 119boU9nfg8U/2fy9z+MYAWjuf8omWLI4IdXHqzigvfZ7lijmSVZfalZ9s5cbWWuH7GLkakuStz
 /x/dVfN8Viwqj+TenlS0PPNk1w3TP9n9O/bUuCca/GtZsGOjrR5THbcGSQVL6CVjSh5Nt2nof+e
 4hq32Qe0/j5QN5+gJ6cq60EXyrJ1KAKAO4QyW+vZucjtgUvDHxfaU+e8040yY0FhTFy2xwpnVTb
 hyLiKplnEaUkqz+sAcQWL5rdUlfDEMZsnxKdEm16NAQ7wrq8aJD5rzPN3tN5b57ertT0wkM2VEH
 pT6MAdrWll1mgyr252CGwLx6QtruSF24nYvgKv52x97v1VTkFUyBkiV6AulK19bFWLLfc/Z9DTE
 J+P2INcMFQApC9Smlfw==
X-Proofpoint-ORIG-GUID: e7bkDVb97elk84n3zYNGrDTYTDZvp2lE
X-Authority-Analysis: v=2.4 cv=QJNYgALL c=1 sm=1 tr=0 ts=69eb884b cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=7a4_7rcHm0II5uOVc2AA:9
 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2604240147
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

