Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9460CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5C75010F241;
	Thu, 14 May 2026 13:54:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EMpKWF8V";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fmrNX6ri";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62BE310F243
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:49 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeWEP2841099
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=lSG8Ggz0BAp
 HT/OdECps9ZrqwsJXbtBLlduou4IQHiI=; b=EMpKWF8VGMFXeilUYYHIIKOXwnL
 uHu8zdqGFvZIHkY7f4PJeeyULy9DMTTBh1L/tkXXqSSSKcDW3EudRCyipmHQHC5Y
 AkZjX98R1KAvikxyhPoYqZQ2LkeZCpK82X/GjnHIsINQcpybWOzYI1D4wTYVcbRV
 kMi8fRCORQDkUSVpA4FtqEeIUkbZOExEiSBXpvN25ZpWob4YC6H06cfRPv01plEz
 ZZkP5EPnc/h4NZAsljQNo8LO6/zGHtbyT4JQ0UvyDtRWeP1UE5a560Vig/HrI0vf
 HYEJrQLLsRQVahGmanwHxn631VAkM1Th73SAaZBSuE+73+gf1//vWhDbiLw==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5899sn7p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:48 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-367bb9caa54so7286015a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766887; x=1779371687;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lSG8Ggz0BApHT/OdECps9ZrqwsJXbtBLlduou4IQHiI=;
 b=fmrNX6rit6bmH60IXqhcfEzbvsceiDEjHfOXpNrAjTvcxAdKJY8u5bKjxjRrvewHe2
 qXY007KTBIYUlfWM31mwaNwkRSRDTJW/TNIYJoJkkkXsAxuPnTBegd+24ptMQ6q0pjeD
 KQrkPf5DyVAGTxuzVxPgzlq3/jrfaedZIRO3A9mjYLOvb4JfsrwDSgABEvG9JyNthTLY
 RZyyozmCVBHGJwHJG3420Iob06Xr53TXab1gdCbBqYJA9G+wPHu9tkeG5oRpImX+PH3S
 khjGBjEvrPbOqwQt81Ui2asn4PQYHORiFajVticSscUgBV+gLya3obbQnGEiZO69zm2X
 Q/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766887; x=1779371687;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lSG8Ggz0BApHT/OdECps9ZrqwsJXbtBLlduou4IQHiI=;
 b=X6XTKNY02DBq+kgLI7lOihnglPcHQ3r2yTZqOAsBVhGV4rrXt8/xischJRzcPVlzGq
 h6xpm1jaMZUH87Bs7EGlNbqx4gY3Q74yBIlq7Kk5mgOYG9gmmbvl0dhFuoXvQt5jn+AW
 h7u63PLbb4WzxUsYTIMeq+DroEPPDRTuoaod4G72idz7tc8hmv3sxNR4DbEkNJr0EMJe
 v3zF/jZQiDlNsaPxqfh79J1PyCi0P3jRAgZEA5NR6toN+/JSSthr5bMzPAswX0tH2pyU
 5EewRHIR1dpyk+ajcHmVSEQC0+/pNJ4rfiTRLX984x7JU0ovS1H5uXHOK70XNI9hrSJA
 6nTQ==
X-Gm-Message-State: AOJu0Yx75dMFGMSQBf8gLgsRr9a8zHkWIkuBNLWJqC2YYFcjN4+06Crw
 aSPM8th8MUzCSi1++EduRgMA+/CAxcDlV7Txo7+mOjk7wSG7IEKx6TQxY0GW/TU84AEYpTVvilC
 THjtHdyyeEg5t0FmluBsT9wULAJqOmNxgzyD82DP8+oBibH1XasKPmLwlCkuJA4CvC1sXYxcg8K
 ScD+I=
X-Gm-Gg: Acq92OFYuovZo4RC6ukzXTV/UfcqJzUJoeh/ho2D6psjTol+2Lq0R+J0PX6T83cvf4W
 frFamzMlvO9Y/Q6ZjGmfKm3hqFdVkOrK2aVXS9aOyU8fAe9UKDKDWVsaAENXP63Gh2MMeZNaitL
 54pPWIcGViccIO7wr8OP9ogZJXDgyt15OJ7R7hG5igy7A3S1ssRJRdEECAhj9tx9jadK2myqAOe
 Wz3ZEMg52xqxDVGQtFlmRer6KMJi5eC8DedLhT1lzqRjFXskJZDaoAOTssoYmWrio13ZPoLfQXp
 z2VrI91JUaKZsabwSVsRx6yANdP9lkkXPMnb0kUglTwkyXR4oAVv5JYaw7VpygPXazyj/7sTjF7
 v1lz0DOf4u4uIVgFO4g9U5/JIpz2H/2S3sBRKR7CHdDw=
X-Received: by 2002:a17:902:f54f:b0:2bd:7ca:e67d with SMTP id
 d9443c01a7336-2bd276dfda1mr91696745ad.29.1778766887248; 
 Thu, 14 May 2026 06:54:47 -0700 (PDT)
X-Received: by 2002:a17:902:f54f:b0:2bd:7ca:e67d with SMTP id
 d9443c01a7336-2bd276dfda1mr91696205ad.29.1778766886583; 
 Thu, 14 May 2026 06:54:46 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe4935sm27139415ad.42.2026.05.14.06.54.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:45 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 15/16] drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
Date: Thu, 14 May 2026 06:40:03 -0700
Message-ID: <20260514134052.361771-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX2iWoD70FI3it
 Zmydg2JwsnOFHl5Sc+Gw/VN7BrHkBQtFxrR4xYlab/L+sfozmkR4fEaFMY40yJYMqH+NqLcraId
 jz5SLUSOdlGwZmrpodX67DdAnt1jgMLSBGhCiYh7MagdPRyFAqxyvPEiQxXb7Sl1h7cmjoLeRiO
 7Pz4X0WN/jev2I+6UhspV55zPjkrpr46Ykw4ACKUVgXlQgPd5nHrbAP1lyg6SHwbqSXJMNr1C9M
 PWML3YZW5UMBPcFQgsdzrMn4fgiidCANWdjN7WBiY/0P2CTIUSKT5Wq5phbhlKS+Lfwxz9dtRz8
 Twr1pAELMcgb8WEhbM+HtbCxBFxnfgJXII7tDhjhh0ElMvxFogX8x/fa2KQB2b9VC91IkcldjHy
 xrHQDQ0lRQoLEgjPxF+nUYFFHlsU8dY6uqTsqWU86HbveRFVa6ROLpp6/rOl5DgHmOQqIUSppnu
 XEF7lxpBtlJO/rZVn3A==
X-Proofpoint-ORIG-GUID: qkMLo5_IxDwff97edGWIi21PymMjVZmx
X-Authority-Analysis: v=2.4 cv=N6AZ0W9B c=1 sm=1 tr=0 ts=6a05d428 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=gjKahejJLxXXi_JFjLAA:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: qkMLo5_IxDwff97edGWIi21PymMjVZmx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140140
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

