Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D58CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80E7D10E6BC;
	Tue, 26 May 2026 14:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dbg6vf+v";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LXOF0rTa";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A45F610E6E2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:26 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsXvx1430513
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OlrCc+t7CrC
 NbDyoSUL1NFgB6ARlkR4nNT8vRThHknA=; b=Dbg6vf+vFEl8ZiTZpsab0OHehin
 sVEGOXecXy8rTn/LMbJYeQ3oiL2AOrolljzvgLxxDJWpkEx0rC1xGTQV0chjXkEt
 JXFVM4VM+nahxP0qzK7lLuPbxjcpAjrp1Jm/pS/+dlv7h0qCAxxOnUGLdbZWj/Cb
 GUPJz6o5+GiqudBzFjjGzI5ODkTNFSePwbjtHV7Kn/1/3oJHMjii7SvTfjv8ti5I
 voorpSm+3j0ccKHzJobbtgWfbL0jB44DJ+ju4JoctzkWKIsGPnTnz59NEQpaOdmb
 oNZyOpAy9NTobK07Jx6J3QV7suLav0W43MjDx/CNZgDQ6DC3YQoRMxBt6kg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecmbv5m4c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:26 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bd00a65673so81959165ad.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807265; x=1780412065;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OlrCc+t7CrCNbDyoSUL1NFgB6ARlkR4nNT8vRThHknA=;
 b=LXOF0rTag0oxf9NrrGljt3AZiMSkyJ7q4hwVlsBUuTJCXDH70NHAK37qRjqhhFY6mF
 L2QoCMkhg9vd9oET8pUUx3Yv8vjPVXhpvISIiIQYxAPSgp4OF/wDeJnk5824yclKfAuI
 jeStdmbS4ACrEbG7aaA6OyvYdDR6v3JQAxoJoyV6lT1UaW41jVjWh7MVF94nntBM58AB
 nkUOGSlDFVOvPtFEz4o/2T13ijGS3SelS8K0EaqMb3vOUCvZ5vRlTB49eLZRLXRSbMVS
 UFgh67Ryj7m5Vc8ygAnH3PADq10DvSwKQH8wv3muZTqruzyrdCpfp0rkoGC+d5jBNYsi
 8rfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807265; x=1780412065;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OlrCc+t7CrCNbDyoSUL1NFgB6ARlkR4nNT8vRThHknA=;
 b=iYRa5u8mVZnFeuDaqPBEOPAIRvu7+zmz3Jrm45a8SydlenMa4fiQARvQLMyLyQPikw
 RTPH8w9ZZN140Nfe+cTDVK/6eqUtiKu7XKQ/884Vq4CozzxZfBVSoJJQqGUU3hwSlvQP
 4cKxlSL65eVaJgiz9bthBidC8EbmtmWmo04jbRvuukuTW8hoduUCUHknw9tMkqI0bHBf
 MIKMQSQw3jse9M9o4S9bS+YTsxaXzwNSWBS/li7dZ/lQylYDM1x5/ittmUCgi0Wk+qmk
 DXQ0bGvHrCHHZt2Znjp/kj4q9ualmtdHzUliSG1K2MfTWw1WR3SlxH6R/oPXU/ESQZGx
 7Njg==
X-Gm-Message-State: AOJu0YyVAqqvMwPBU6M4gski+YSgn7ryMi3qCq6Tvh84I/jm2n5TZpnl
 OF8TmAAXgFXh/FcpRtVROI2x4Wm7KddaCCQrMsiLk7954ZzD/NexnWVLrkBQsvvmtyYRhkXA3Hu
 L3m32foJJJrLRzrisHc748XeRgnitMLXKTMKwmjHrIbmGcxVHat68UJW0s4NoMoJ0owzOxKm5gy
 SQNrI=
X-Gm-Gg: Acq92OESRUYrE9HpGK9Ie4xcUkuuz1F7ptTJz5AUwLPZ5XPYKWlKoc/+B+x8X8eBDgj
 bVLEZ/7brvUdQK3HQjL/ZNAi76ftOtWRpHHUeIIf0Y5V0PzRBtURxmpobe/rqMQnzwqZNCUNVBU
 0whEyNh3zwf8N+Ih/RFwK0B9y2knmXwQXKx1+ytba0u1oKntltk+DCEKUN54cQIguSHWRhN3XRz
 nGKLRyVdr7qF4Qr+GJ3cwRroCYWFAeAzBf3/3oRkqlrZtwG2fkTLBL3JnkfsKGbK0MkpkL7caW4
 4IHqSpHHVkRtPyk1dbYq5+PPZ4HdH3FfWuVAuumJUTBgcOiN5S2r4vNaLbkbH7WwDZICJl920Ac
 acM4VYzxfNj2hhZ0Adqx2WMf17dArKmNq
X-Received: by 2002:a17:902:f546:b0:2bc:8e7d:3dce with SMTP id
 d9443c01a7336-2bea23e2057mr203790405ad.27.1779807265381; 
 Tue, 26 May 2026 07:54:25 -0700 (PDT)
X-Received: by 2002:a17:902:f546:b0:2bc:8e7d:3dce with SMTP id
 d9443c01a7336-2bea23e2057mr203790015ad.27.1779807264811; 
 Tue, 26 May 2026 07:54:24 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb56b5886sm114221225ad.20.2026.05.26.07.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:24 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 15/16] drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
Date: Tue, 26 May 2026 07:50:49 -0700
Message-ID: <20260526145137.160554-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX4GnwaQKltJTx
 5woxiWNC18/79LDhe5Ricv6KFvPDVIkHpetZPtn2LJJ1ZEmnabTLJPLYwKKs/S49mlY/EfF5g72
 2gsx/8xGTQ8wvIryJPpIqW/TRMmdIHhlSlf3dgaUOE0daj7wLmPRrhnOYXbJuGKG5gugQ1lPLgK
 TNwMXfgIFpWkOFBaAWvlNAZvuDL6dBC9yVMSMdX2zOmqbr8XMuPwR2aRaLIAmW6XkqvLCLf71vo
 w7SJaJSrtbkGqCt6gQQVdodVjVfxsDQyLrjFaxcjYrF7J5ZfrFnUHs5Ud4euteWAqe3fB3EGv/a
 1gYUeAIdtBMfozYb+8VBR3Waeb5BjK2MFlkMa8fUbKBSARLpAJzDhxjexy+zyJh5EWJniwYKmQg
 g945eJaKzxThohYifrIFzG1QKkhHbIlae4+MS5aI85xMAbzR1fV8zF+ZBAdxDxeSvYCTGP65Mkj
 t6dKl5DeuMbIygq/MwQ==
X-Proofpoint-GUID: jA4h2gKFjmnvtfm7OJoeCeYgAkWhQFP3
X-Proofpoint-ORIG-GUID: jA4h2gKFjmnvtfm7OJoeCeYgAkWhQFP3
X-Authority-Analysis: v=2.4 cv=XqTK/1F9 c=1 sm=1 tr=0 ts=6a15b422 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=gjKahejJLxXXi_JFjLAA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605260127
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

This is needed so that SEL reg values are restored on exit from IFPC.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 84 +++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 11 +++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  1 +
 3 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e6c362c55dee..af524130d5c4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -946,6 +946,7 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
 			  A7XX_CP_APERTURE_CNTL_HOST_PIPE(PIPE_NONE));
 	}
 	lock->dynamic_list_len = dyn_pwrup_reglist_count;
+	a6xx_gpu->dynamic_sel_reglist_offset = dyn_pwrup_reglist_count;
 }
 
 static int a7xx_preempt_start(struct msm_gpu *gpu)
@@ -2535,11 +2536,60 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return progress;
 }
 
+static void
+perfcntr_select(struct msm_ringbuffer *ring, enum adreno_pipe pipe,
+		uint32_t regidx, uint32_t *countables, uint32_t nr,
+		uint32_t **reglist)
+{
+	OUT_PKT4(ring, regidx, nr);
+	for (unsigned i = 0; i < nr; i++)
+		OUT_RING(ring, countables[i]);
+
+	if (!*reglist)
+		return;
+
+	for (unsigned i = 0; i < nr; i++) {
+		/*
+		 * Bitfield is in same position on a7xx, but only 2 bits..
+		 * which is sufficient for NONE/BR/BV:
+		 */
+		*(*reglist)++ = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe);
+		*(*reglist)++ = regidx + i;
+		*(*reglist)++ = countables[i];
+	}
+}
+
 static void
 a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 			const struct msm_perfcntr_stream *stream)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	enum adreno_pipe pipe = PIPE_NONE;
+	uint32_t *reglist = NULL;
+	uint32_t *reglist_sel_start;
+
+	if (to_adreno_gpu(gpu)->info->family >= ADRENO_7XX_GEN1) {
+		WARN_ON(!a6xx_gpu->pwrup_reglist_emitted);
+
+		struct cpu_gpu_lock *lock = a6xx_gpu->pwrup_reglist_ptr;
+		int off = (2 * lock->ifpc_list_len) +
+			  (2 * lock->preemption_list_len) +
+			  (3 * a6xx_gpu->dynamic_sel_reglist_offset);
+
+		reglist = (uint32_t *)&lock->regs[0];
+		reglist += off;
+		reglist_sel_start = reglist;
+
+		/* Clear any previously configured SEL reg entries: */
+		lock->dynamic_list_len = a6xx_gpu->dynamic_sel_reglist_offset;
+
+		/*
+		 * Ensure CP sees the dynamic_list_len update before we
+		 * start modifying the SEL entries:
+		 */
+		dma_wmb();
+	}
 
 	for (unsigned i = 0; i < stream->nr_groups; i++) {
 		unsigned group_idx = msm_perfcntr_group_idx(stream, i);
@@ -2567,17 +2617,15 @@ a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 
 		const struct msm_perfcntr_counter *counter = &group->counters[base];
 		unsigned nr = group_state->allocated_counters;
-		OUT_PKT4(ring, counter->select_reg, nr);
-		for (unsigned c = 0; c < nr; c++)
-			OUT_RING(ring, group_state->countables[c]);
+		perfcntr_select(ring, pipe, counter->select_reg,
+				group_state->countables, nr, &reglist);
 
 		for (unsigned s = 0; s < ARRAY_SIZE(counter->slice_select_regs); s++) {
 			if (!counter->slice_select_regs[s])
 				break;
 
-			OUT_PKT4(ring, counter->slice_select_regs[s], nr);
-			for (unsigned c = 0; c < nr; c++)
-				OUT_RING(ring, group_state->countables[c]);
+			perfcntr_select(ring, pipe, counter->slice_select_regs[s],
+					group_state->countables, nr, &reglist);
 		}
 	}
 
@@ -2591,6 +2639,30 @@ a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 	OUT_RING(ring, upper_32_bits(rbmemptr(ring, perfcntr_fence)));
 	OUT_RING(ring, stream->sel_fence);
 
+	/*
+	 * Update the pwrup reglist size before flushing.  Kgsl does a shared-
+	 * memory spinlock dance with SQE to avoid racing with IFPC exit.  But
+	 * we can skip that since the ringbuffer programming will be executed
+	 * by SQE after dynamic reglist size is updated.  So even if we lose
+	 * the race, the register programming in the rb will overwrite/correct
+	 * the SEL regs restored by SQE on IFPC exit, before sampling begins.
+	 */
+	if (reglist) {
+		struct cpu_gpu_lock *lock = a6xx_gpu->pwrup_reglist_ptr;
+		unsigned nr_regs = (reglist - reglist_sel_start) / 3;
+
+		/*
+		 * Ensure CP sees updates to the pwrup_reglist before it
+		 * sees the new (increased) length:
+		 */
+		dma_wmb();
+
+		/* Update dynamic reglist len to include new SEL reg programming: */
+		lock->dynamic_list_len = a6xx_gpu->dynamic_sel_reglist_offset + nr_regs;
+
+		WARN_ON_ONCE(reglist > (uint32_t *)((uint8_t *)lock + PWRUP_REGLIST_SIZE));
+	}
+
 	a6xx_flush_yield(gpu, ring);
 
 	/* Check to see if we need to start preemption */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index d3f0b40787db..b72fb58bf223 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -21,17 +21,19 @@ struct cpu_gpu_lock {
 	uint32_t cpu_req;
 	uint32_t turn;
 	union {
+		/* a6xx: */
 		struct {
 			uint16_t list_length;
 			uint16_t list_offset;
 		};
+		/* a7xx+: */
 		struct {
 			uint8_t ifpc_list_len;
 			uint8_t preemption_list_len;
 			uint16_t dynamic_list_len;
 		};
 	};
-	uint64_t regs[62];
+	uint64_t regs[];
 };
 
 /**
@@ -101,6 +103,13 @@ struct a6xx_gpu {
 	uint64_t pwrup_reglist_iova;
 	bool pwrup_reglist_emitted;
 
+	/*
+	 * Offset of start of SEL regs appended to pwrup_reglist.  This
+	 * is equal to lock->dynamic_list_len if no SEL regs are appended
+	 * to the end of the dynamic reglist.
+	 */
+	uint16_t dynamic_sel_reglist_offset;
+
 	bool has_whereami;
 
 	void __iomem *llc_mmio;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 6c040f718176..2ce7c6ac4521 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -468,6 +468,7 @@ static void a8xx_patch_pwrup_reglist(struct msm_gpu *gpu)
 	}
 
 	lock->dynamic_list_len = dyn_pwrup_reglist_count;
+	a6xx_gpu->dynamic_sel_reglist_offset = dyn_pwrup_reglist_count;
 
 done:
 	a8xx_aperture_clear(gpu);
-- 
2.54.0

