Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C5BECD484A
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D33710E789;
	Mon, 11 May 2026 13:01:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cRBqXdZW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PlVjbW7+";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E20D210E784
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:41 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BC4NbF1106444
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iF+9PJLiAYx
 Yvbd4GKOtHlCv+ra6BRd9wFisnl+IW1w=; b=cRBqXdZWj5PROv3zQHsxVV+fu+J
 zHF8BBe7IMiOPTOe4Jl65IWd41x3g2YpfUWbYXb4u7cPUg5eY9hSxE/waJzCLf0A
 USmr15Gx5rvviCEdLgv7BZ6/17NGw/8bnhsnmmjggePnM3b08vd42PAYkOe7RAkM
 LHkugfj+3V19ZsiUGdUBMpSjM5AY8Frh7UPRdeyO0SZa3V5nokoXrv9tXnB9HQoC
 42ISSTbAXW/kktPlHrT9Azp/bL+j4KIfm/EKfvGJtupeGsydBMNXd9KMqo/eD/JI
 CdEF5rza5DN9Heacg+pO7JRA4DDZoIyS5h0BcI7ZS0t/FtKpm+wUQkVMP9g==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3esr85rd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:36 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c81086bf930so3101784a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504496; x=1779109296;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iF+9PJLiAYxYvbd4GKOtHlCv+ra6BRd9wFisnl+IW1w=;
 b=PlVjbW7+QP0P+0vbElq7ykTLwF9I8LafoDhXE1htidKZQiC1njSCVaOpJIEmWOzz/e
 Q3WqT7B6HPhVAFsGg90L9yq1VLCI6FRIeimNt4C4TJPEoELaRBIf/YcpiUwgauR0ZkFc
 +bjs4YNxIVzQTeJJmjDeyZpjYDlXfHunUY6ahpMCVNMnQhfcC2o13LfaZqXjwuh8KNw8
 MQCElQHRc2SuYzFKM8OfFJ2GYGC4VlckaudjFq/CsCWXNRbKFusU2ca/HqpT6BzjBdZE
 JsmDNaIUv36ag7xNNCYa96ssEYPkPnKea8vPvINyXJHSUuyKm3peC35HX+/F5ZIYSlMu
 XSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504496; x=1779109296;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iF+9PJLiAYxYvbd4GKOtHlCv+ra6BRd9wFisnl+IW1w=;
 b=cqD+CIlvF3ct95RCR0PdcjsfPCRJUNXaAHDP/k28Fl6NyunVRzL9hObzFuGE7/cK64
 icOSgEubs/OaY9ohCYHtG7ZbzM6Sk7I/8A0f8akPFmzDQw8/rpglaPiCPmsdcaRy7iuB
 hI2FIcpLhsvsdUcfAb8/4p9vcuOBMCwfWXmgIAnykuSsGnzBtwEKxMCzX2k2AR3DBfM3
 x85ffZhc4i7tfeKwFfQ5zT1V4KvgEDBtZcBRbKfvth1TwX1uK89vKkvt9ORmOZGc+R8L
 cjgT8ZiolsT1y5MNYvzYlYb12aF1AvRCkFFJifn3SXkV+ij08StcRzry/xt34Oa30zCY
 L4jQ==
X-Gm-Message-State: AOJu0YwFX2FS7tyvhqdoCYb2Tbhn9pEf6eZkOrslAJut3keZz+ZMKJ/5
 h3KWQpHZNRL7gApiahRpnWh48W8G6MDtr7DSgJJHp1LXVBVEDvLG0Bu8QfbzIax8cPh9keGqYF5
 PoyhT2Pvn9QgLqp4+NaMpDK0qFp5Hf5WG9kCwzndIPAEnRHlHLjAZyGsYh8pBpOdZECLYj+UuuB
 txwHI=
X-Gm-Gg: Acq92OFbS4LB3t++WKovx12LG9pcDJXEWkbKxl8Qq2Z6vVJzhpSab20qR6/R2ItdEpP
 pchkT4I1o8gnaD0jw5jqmYLkjfIVfun/7bwSKkwnmgIdEnf4JDJ9HB8Ou2R/c++RKllydAXngZq
 9t44bkaxD5LCndYldvk02EXyTmD2L/SvGwzxIHzv6v8fXFBuOJkHWv/i16oUHoZBamq2MM6xceV
 mXU1rTRMuokWcvHlwdqThXmbMmk1Bo6VjTBjGUd78JpZTSHY93v6layGFStBFeUY02bdOqqy3+4
 N2/s0QKoCjLT79p7FVSt1cZVpDS64ZbSxEPecCNpdcciYJMUKowawLe6Mlf6czVSkqdf6ozq51e
 /QOmqr/a2jTU807AWL1jAaeLVE7kePqkx
X-Received: by 2002:a17:903:320b:b0:2bc:b834:6ec7 with SMTP id
 d9443c01a7336-2bcb8346f43mr38716945ad.2.1778504495598; 
 Mon, 11 May 2026 06:01:35 -0700 (PDT)
X-Received: by 2002:a17:903:320b:b0:2bc:b834:6ec7 with SMTP id
 d9443c01a7336-2bcb8346f43mr38715875ad.2.1778504494798; 
 Mon, 11 May 2026 06:01:34 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1e35bcfsm102094915ad.38.2026.05.11.06.01.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:01:34 -0700 (PDT)
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
Subject: [PATCH v5 15/16] drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
Date: Mon, 11 May 2026 05:59:28 -0700
Message-ID: <20260511130017.96867-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfXxswsvGQMfgmo
 M+xA9hsJc32k0hZaH7R9lxOFHygSU2x59AdqDk9pzDcXS5f71Oh+mwCFoHGrtZzuehGy2UEc+ZO
 B+kegujU+vE7o366iAwgpi0Z6NxbTbTSUWbdDMNF3RQ10htkntlR8Cb+Xl9nulgJBZWAXNHqDQO
 HZcH7hOIYjOgx7I1dtPGapL1fAj4RQxc24Wl9rtXT7ojgcYg9p5nKbcTDdWiX3VBCMZnzM2tnh5
 OEHVZDAP9z0O5kb6iQlVU1MjI/jTu/u/i4LUN2yqe0g8lmfu48rf7wbPa+SzV6uMdRcwKDXWrQ2
 AdPuAfDb2NDzaysyh5k98ykqJDixj9pEKklg4R1DuEZ+qGvxLoraBIZKnEHKAnQSS67PHgXOaHj
 9ujFT5Bf0RqxZwgN/6cWjjpf3i9m6A==
X-Proofpoint-ORIG-GUID: aKZPg2mlVXFpWRiNiO050aJYNR6hrY9P
X-Authority-Analysis: v=2.4 cv=G40s1dk5 c=1 sm=1 tr=0 ts=6a01d331 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=gjKahejJLxXXi_JFjLAA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: aKZPg2mlVXFpWRiNiO050aJYNR6hrY9P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2604200000 definitions=main-2605110144
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

