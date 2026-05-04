Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F77CD342F
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 121F210E842;
	Mon,  4 May 2026 19:08:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="aPs2TjY/";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Qry2RRMD";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1193410E842
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:51 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644E2m8M1187179
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Z8lEzDrgE0f
 TV0/Bl+mAwrGTsTYAYegTQN4ZDI/6vu0=; b=aPs2TjY/rYPJTdi3pXmVJ1ePfa/
 ANxYbErzlam8vmYB0u70GwkggRL3L7M4RB3dKhaFcEY4yLlPumtEHgcwNtdFbsDi
 UnTD7SGSLrmmDlq608+aoOdTa8UNkpMXIS7GU6FnV7NX9EAAG/nmzxCDWvz9Z91g
 8k0cvd9O3nwPeHQB8EOunM/6vjv00JPVjfyYdOP7r6kkXEY4qhaSTTGTf6ZDKix8
 OHitn/XV2xDNMOec8r/vQhEa8gDAYHms4eSFdU5d2NNLqCJ0GGc9FK5PZDTRXZFl
 Kx1fpXzoDfpr7Fftcha/hl1K0BK0FvYDRjt69HsFfjdzRcEoSS076VROWBA==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxvvg97g0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:50 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-365290bc580so949388a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921729; x=1778526529;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z8lEzDrgE0fTV0/Bl+mAwrGTsTYAYegTQN4ZDI/6vu0=;
 b=Qry2RRMDibWCGYCBsslNuuC1my4c68zneGv0hrFmaQgoTgCvRZLpVjYHvUrWPZhxOR
 BtDJeVqYPSz5puv08geI2B1qdawz/tOy/ejebtNDuMZ05PP+movd0z5jBMwNwsLWCKKR
 JpfHw1jbJEl2YSY1I6A/Jej5x5A1LWzS1hBGD1cdrcyAiJGrl8widNHF2/UP7J8mwoCX
 xZdw+B+Md2mBQtM3eUIL23g3VCknNGN+MAwZg0wHlKu9jldz9SwvP6XPnXNnSV1NkRIg
 M7gE4fr8GqO8vizS3NiLs4/mHgmRBc4E1eumo+Iw2saFiK14ojowc3OayvO8hTgwqF32
 sNMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921729; x=1778526529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z8lEzDrgE0fTV0/Bl+mAwrGTsTYAYegTQN4ZDI/6vu0=;
 b=BLUKPRYHNvKSRJfzNu7o/ewFvxn7Nwv4x1dPXvxlC8+55U4nyy2FE6AWUrDpoTQ7Lp
 EOwB09JvocvaZ+GLPLw8gEqNoJ5OVzbd8IVqsJa5LfT3F4mUzhX1rawU99m8LT6fmQfM
 +QXJgI/Ppi+M89qm6X5upXJ1pCXPAs6+qgm0DehMR3SBpHqq8fQItPQwn8VOJe40Jiso
 zXAjO8euctXWIcNHC/gNKHnfrbA67+FGkE7zPyxo2MjlRTbjrmZQJPyy5Ley7V0FQzhA
 hOVGJtGivi157nEaTKt91a3tkZFADTfAltCPjgSvAlp/7p5sra79BdcC59ON6xBISnYw
 t9tw==
X-Gm-Message-State: AOJu0YwZ/8gDkB3T53pSvz43FO7OdZVMuZ8GsuWoekBXW5tykSjom4Xw
 tC9tGiBAf1TxQjXG+SuZ5s3R2UF+PZqxV1w+853vRvkdzT3pEQdjpK5fdwgS+tJ8cU/36SKen3B
 8w3wftvp22wgqCLesHcZ2S8emOsCDvssr/Z5eDQKLcXDYaNJvd8kwzYUPxiq0zMS8GkC9DcZkin
 LaMFw=
X-Gm-Gg: AeBDiet/9smoyhYggz01JLOS2zEtdGG1wtIgECtZXLpgAQHouPPZ1NKGhWLftFaIymQ
 PWPglv1gzNdXeXtN2UfedPZETtAHxboqzuurSeENiCOrHKBodMiK8IkbtnwXD6NgsSLCxYZyuwg
 mM5MF/18KOyJsFdpGdNHQiewATS7G1/4ioLwePaK++bHhEsPZ+BGk8/+y63tK5qVHBKHgjPN4To
 dMWQATwTcW9tMS6c93Tr12ID3Ly9niUUqd6n8RWnHO9xsUIDaMfilCRdpTQh7SWs0YaLkeGBoXc
 YeD5oQYtPAvK9pIHc703afOf+/UXVTwkpxs0NStURZgAM/C8VQQDlpi4ojMAtKDL6NfuVTk3DmQ
 mwpmdfD95YAsAlN3g8U3CAWipVqg97oNwe80133VNoDE=
X-Received: by 2002:a17:90b:2f03:b0:35e:30bc:804d with SMTP id
 98e67ed59e1d1-3650cdffb46mr10418216a91.15.1777921728680; 
 Mon, 04 May 2026 12:08:48 -0700 (PDT)
X-Received: by 2002:a17:90b:2f03:b0:35e:30bc:804d with SMTP id
 98e67ed59e1d1-3650cdffb46mr10418188a91.15.1777921728018; 
 Mon, 04 May 2026 12:08:48 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36576332a4dsm88877a91.13.2026.05.04.12.08.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:47 -0700 (PDT)
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
Subject: [PATCH v3 15/16] drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
Date: Mon,  4 May 2026 12:06:58 -0700
Message-ID: <20260504190751.61052-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y854TEmH7XT5iWEQR-p49z4gKhi943cM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfX8J5h1m4EV2wg
 B6cfbSypbVMq6xm5Bgo1aCT7FwyQN1KoH1cdjERC99KrZGhAwuWQ8Qcme/R1Uov/r+q0bQC19/H
 VcNMxJVMd/45nBpU9Yy20nBGfED640wlXGArYtMJi7PTydRwvgfPbjbVDbJBcFRIEJOz6DxNiCb
 9nNU73370kV5yz4hwP+AUwTBXkTrlkFJgPHRFVgp/dbXcPGrFlBOVnI6M0df7qOqX1Yytr+5ZpR
 HNSdqBJVP/n5Sja1tdWxI8KGoQX9kO3qJ1wjXW+rKUTQmMTQA7Nnxk3+I0qId+ylVyafjF/gQP6
 HLTFAdCZ2xUnOJ4BkF7IEiByNKXbx6PFC5Qk8GPUW9cnSzJSlU5zXtQsRzEu0Ij4a0/1GXTH2wT
 mv/UJtlGTPRnqDGlhfzAjzRz3rivshcTnY3iRIJBNWQ1SHOBqJWB416rtGpy6k578m2czJJd1R/
 D9cohhkWK5ftJZ8ODqg==
X-Authority-Analysis: v=2.4 cv=K+AS2SWI c=1 sm=1 tr=0 ts=69f8eec2 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=gjKahejJLxXXi_JFjLAA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: Y854TEmH7XT5iWEQR-p49z4gKhi943cM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605040175
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
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 82 +++++++++++++++++++++++++--
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 11 +++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  1 +
 3 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 61c6b0e781ce..e047ed550347 100644
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
+		unsigned nr_regs = (reglist_sel_start - reglist) / 3;
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

