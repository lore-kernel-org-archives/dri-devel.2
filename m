Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B0BCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887F410E934;
	Mon, 18 May 2026 19:08:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="NIU3i0jm";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BGBc23tQ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C133910E9C3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:32 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IEnL462975542
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lSG8Ggz0BAp
 HT/OdECps9ZrqwsJXbtBLlduou4IQHiI=; b=NIU3i0jmtx/8VB6EKcFAYG9ZLTD
 NC37Cd1o03T58vGUQsddG183eaLRbBA2Dqv7yrzUu1Ao18EsupymaVmm5LoyOzW9
 Zx7q/IBK+K9efeiGr9QFXpQQTalMXocin47UT5vaeVkdGzcmZlYqQu4L5z32oqc7
 ALxw1S6h8wrmANgt/+4I0/16KGRBdrJEe1TIQfxexSRxJIGb6opE37+3uCjtXBiN
 Pde6cPeydD68FRx4RkP+JWyt37HhaHC+yZ9jPNYSGxfhvylWSRLLBjiBzJXLBJIM
 aom9xmb8x/YfI9pIRO4Dtmb5HjFgWl46wt6hnnOkWLImSJX7WZu/OZ797cQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e84v48yja-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:32 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b9a3c3c4eeso28550225ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131311; x=1779736111;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSG8Ggz0BApHT/OdECps9ZrqwsJXbtBLlduou4IQHiI=;
 b=BGBc23tQmCqIww03n7XZiOgrXy0+UlvLSc6VCPg6rFvOAoz2YvnNPEuMWCeLThuTtc
 D2k46Uae6IWqwWfStvJl7PjvrCUmrITNLbMqmkNNquvG3CQmmqiDd8ISPeMIrXHgfrPR
 pRIBhsFSBTxXj6d/Ll68D/sjtOCP2GCiiwv0OZHR/jBAEd7Tud8Uqq4FVFaiIAh+by/1
 HA2ZzMoowCubhqilFhHblB/hTaPn6P3U85dojfslyG8DcNoYOer1HbaRs0nRxhkfy6aH
 nNWaRjGqtaZTwqAjLSGpeOUWbHmBjRSWbWtRqkTIcMQD2VcWb0hUQYLdSU8n01i2Sm0u
 dtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131311; x=1779736111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lSG8Ggz0BApHT/OdECps9ZrqwsJXbtBLlduou4IQHiI=;
 b=P74cn5y4oMev1m0cTTkVWTy1LfrsKSqhnYfJXQ3FFtjCTidQ2lsZ8TZ7CdIg0fIC3e
 1knTF5yewrK02+Fn7BjEgNyQGjQOUpkdpSo1PBBqeikWemX66pHTxWzzDVRcrlBx2B6O
 TUc/iSwHcMPZE8/cGceE7cmlNyXtOXe6DkWL5cSlMskE4Zi4YUjrfSRjhah7LGOcjT5h
 /VAzz6I5HfL++BgRVjyTOTyaZbQScVFDh+zoSE5M9tRrVixrBTlg58QW49JLjt6BRDyR
 rN0cSOlsWUPW0hpMX8tzaKFVCBn3Rj8nlJkcabLrH0bVPZNmZ6GKcuzzT6pI13Q5a3Id
 VmmA==
X-Gm-Message-State: AOJu0Yx0itAQyMfXbv+3s5YO9jCjNq5l+PMPin5iH0j6vp8+FFE7QDrf
 Oit/tEKiGdUyWwwUZXr0mWccOEqGJsdul/Ai91JHQ02XuTqnlFzBjARbmWQoovB68jjLmSSKGdO
 8BlYQrgot+2tFDpWLOrqH86s2Ozy08KgUjtAS/9z0mmLoZzFNsLr26ZKOsdN3S4Ve43keqAl5WI
 KzkW0=
X-Gm-Gg: Acq92OEEW1a8vkqNlDElN7T+aBIBO/3U/Sg9KDhd1BRFGcsKkP3Z1MJTQepAhYm4lnJ
 ZAKn23+Jx3+4pvB6aruWbIfpYQmF7YHbXb5OkkK9jl/aaar4j9RTaQTVu2vG20Vs8Q4afZH7vmn
 YiqVa3aHOq9hhlS0m9DsYtVgkI0JbtxRsGQ41FguUhCMMZTF00h/ApA9R0uP0eDgHRieDvduKzV
 c2ejeBFBVteSJPgwEBm91Qn9qnCmR/zgBW/sJkVY2cexBM1x2fm+bR1ZSklD5lxK0FSlp5QVq1b
 wPblFhzrCTwnEY/fINh5+WTXmbd/0EzNICFSF0O0OEfyPVIE+sf1LdTcujOJwB840q/Yv5sY3RX
 511rnarq2uyf2TC0Ax8XtbFlQjkdFX2+t
X-Received: by 2002:a17:902:7892:b0:2bd:63dc:b7ad with SMTP id
 d9443c01a7336-2bd7e86c6b1mr128327165ad.2.1779131311469; 
 Mon, 18 May 2026 12:08:31 -0700 (PDT)
X-Received: by 2002:a17:902:7892:b0:2bd:63dc:b7ad with SMTP id
 d9443c01a7336-2bd7e86c6b1mr128326885ad.2.1779131310972; 
 Mon, 18 May 2026 12:08:30 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe498asm161629665ad.39.2026.05.18.12.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:30 -0700 (PDT)
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
Subject: [PATCH v7 15/16] drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
Date: Mon, 18 May 2026 12:06:42 -0700
Message-ID: <20260518190735.16236-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VJPtWdPX c=1 sm=1 tr=0 ts=6a0b63b0 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=gjKahejJLxXXi_JFjLAA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: KMggjeh3y8NuUJdvav9QOC6kEXLhSpQV
X-Proofpoint-GUID: KMggjeh3y8NuUJdvav9QOC6kEXLhSpQV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfX+MsQSSBhQMIl
 DoEoktRyIsYFQqBPeGiYAH3mBhVwgTrzJW63ymtMA+A9yzVlFFKBUFO2cG/1WPZyOak3P3EKyy1
 qI9+XkVlZQspl2FEsaz0QBPLVlDz09KPnakEuRlLn4/S67BYGQxvlf27ymT2Te0dCz3MLVoY9/8
 K6sl65BmsT1EStaXmWCPv5dBSQaVOOJCwf9DTPxLKYPAeY7WPAd8RIGgeJW6j7+20qRbDGigPeR
 HxFspRzSTKWVgs/LOtl2p2V8IqSRHgpFQkJJp+hkYbOGglq26bzAUhYoAe4a8IE198m2oUXylxb
 v3v/43UbiQRBruazCaWMXmZy43FiTFsZHRzUJB3zBd67EkUTD/UjrTeAydpwEf+HCU2ZW16b/FI
 3tj7yqAZrHquwTypwEBMjJ1w51Wgx67xRVG7hoHARKtNyB9eahun3KLrDikvmn5tAkHTIuFxvTP
 cXNfTcZaKk94CU0X00A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0 bulkscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
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

This is needed so that SEL reg values are restored on exit from IFPC.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 82 +++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 11 +++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  1 +
 3 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 61c6b0e781ce..47627e76adcf 100644
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
+		wmb();
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
 
@@ -2591,6 +2639,28 @@ a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
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
+		wmb();
+
+		/* Update dynamic reglist len to include new SEL reg programming: */
+		lock->dynamic_list_len = a6xx_gpu->dynamic_sel_reglist_offset + nr_regs;
+	}
+
 	a6xx_flush_yield(gpu, ring);
 
 	/* Check to see if we need to start preemption */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 3491a24a9320..f3cc9478b079 100644
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
@@ -100,6 +102,13 @@ struct a6xx_gpu {
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

