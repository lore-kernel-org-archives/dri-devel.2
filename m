Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B519CD343F
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50F6510EE3B;
	Wed,  6 May 2026 17:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="BsuQF20R";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VFmYrUgm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A6BC10EE3F
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:12:16 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646GcIDH3524241
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:12:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=iF+9PJLiAYx
 Yvbd4GKOtHlCv+ra6BRd9wFisnl+IW1w=; b=BsuQF20RYpBmejCv4FViiG3OiNb
 fVtxZ38fX4XQwUCyIW7o5+8olCAmAhlcR25c+xRppXfJzeskpAhZHHGKl1T42106
 3G2qbPm2yDAKjazPi89TGupsNUklWioRTmDRsaFVwgeNhjG9qwMTSFcKaXAa7xGf
 dsg6uANM3W1kGUexRUNJVvL+Qmiid4VAyEx89mGvw4Wj17C9CiO5lPld37uR2RGY
 GBpUadhoxHfQXa3MadcXPRDKbAKPGf60b29AKPyO2xuJzh8qjoMbteIdr8QXX7mx
 +xD6FonKws58ApAs7IbxBoOyke0kCT7eRNr4hT1sWclsIM71bLERRFCReCg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e03jwsm2u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:12:15 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35845fcf0f5so1081642a91.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087535; x=1778692335;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iF+9PJLiAYxYvbd4GKOtHlCv+ra6BRd9wFisnl+IW1w=;
 b=VFmYrUgmFdxhNPoElXvocHDLGMLobONjuW3GzPVrQb63q+DIfR+bKi+LObxaBvSRma
 v4syeywWdcYZoEI9b4mMNfiw1PIVxmgh02mcpqH+nLyPGgCm1N0VqhDRlVLJM0gXxt+R
 6F5YOo4xKT4VSZABV5TPyFO2Rtx8j+ZB8qjfkTrVl/IHf7qKolkYfmu/wd+rlwfHhn1H
 mvGJESCoYKFVWVX3GLtJdQhFFkAWf0KOKuEngzhk+M5QqFHeGot/Z2BQ8HCAXZ5HiTG1
 9UafU0nsHIWyk1Liqc5SN+LSWy3P9rMy8mc7tETk+/EA3FPzhzIzFIcQFn2K0K3+Hfze
 +cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087535; x=1778692335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iF+9PJLiAYxYvbd4GKOtHlCv+ra6BRd9wFisnl+IW1w=;
 b=GRUbvpr9/5lPNkt970y3aJVshqbDWTtF20Zaz/9fNrIDl5+B+/dNJPDjpGx17FAoiH
 greIp4Je/mvXoQ2ite+vriqpaiE9f4llI16bMbSgbomG5TgDGZf/6WvgYMEoBytB76Aq
 N5JMa0wAK22KPFf1dlIRXhpF1dKNiv+QJP8LURQ3HvXz36kMdfAri2WII8BzsD+sXTd4
 A0kPvbRjBRohhUL4W8uuTQ0Q44nLsLSsYt+JjHhwlprjcnAWnTDSKgEu7TUbk81PZYd8
 qOuA0U3bkH2EwmwSMRufQIqi+3UzNspnJO4GJTqYaiOlT8q8u9YqnDaZ16/G8whdkP3Q
 BZoQ==
X-Gm-Message-State: AOJu0Yz1QkuUMOzdAlYFhr7os84x2b1xjkpSAiRQibH/EXUirXf5NZsd
 46Et8UbAn4Z1XpuL1PeoNCyMz9aI9PerYasmPPn3WUDGmgpV7GK+jKk2SjcjKCLu5l2pXiwkQR8
 MW/bUEEsD2i8xApQ3yP5Dqlfk7ftynBiugAxs1+92uMZFIZFCJBQ83GTpnbWleYovQsod5twogn
 HOOi4=
X-Gm-Gg: AeBDiesjA48XYrelhgef6nlfxvyr32nghnfDtxtAcuApllXT/sJZn/mNWOxNCcjNRoY
 dcKrzLH+BS+8vbanG2UkEZMfykZ3bf0vCOD6+pdpYnoIm1ashDmc9QMTbrav1/wpuGVTNpGqCMY
 /uS1mePAFE/HTvHEYOuX7WOKDGTH7u+fx66sn04wbmM23St3zbK4vHbXIHUUU36MJc32j887EtU
 2GUhqOArXyi2dorOgeFhIF2bYxQUnqo7Pt9Mu/8bStAwFef5bCT291Ah8n9Yd3cNBlwBsixj9ie
 y+IzPENsQrpyPYWAg19PcewrqEaTCFXb8rnpd2ovxZlbd1vdcGBBSmc8bilSi2Ast5/xDcdCLVG
 k4OqxRXGcWCwvraYASjeRajGzU43bqV6BePjFQwI2hc0=
X-Received: by 2002:a17:90b:1b4e:b0:35d:93c7:e386 with SMTP id
 98e67ed59e1d1-3657224626amr8446168a91.4.1778087534549; 
 Wed, 06 May 2026 10:12:14 -0700 (PDT)
X-Received: by 2002:a17:90b:1b4e:b0:35d:93c7:e386 with SMTP id
 98e67ed59e1d1-3657224626amr8446137a91.4.1778087534011; 
 Wed, 06 May 2026 10:12:14 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c8242bb871dsm2698554a12.28.2026.05.06.10.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:12:13 -0700 (PDT)
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
Subject: [PATCH v4 15/16] drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
Date: Wed,  6 May 2026 10:10:39 -0700
Message-ID: <20260506171127.133572-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=J4CaKgnS c=1 sm=1 tr=0 ts=69fb766f cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=gjKahejJLxXXi_JFjLAA:9
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfX7bvMtGV0/UTo
 JX/uGtvRX8TcUOO2cWsu5eQupJ83iG13RK4baeLm4QBwN/ChoqwaF5K1M2Z9vD1cJcqyuh5yBxY
 NzzCz4qsoE6zSHpZwOoftABVzl/7TGCFo7shy7s4BkiiBNc6FwOML0YZn+kgpLp3cIQxCz4JkXv
 MwV8q4p9vznA25grMX5exk2cIH7CZoXrNodFcFA+vlt6qYkr43VGalNIIr50yfi4J0LflPvgfk6
 m1GCnEsLFQ4nJdDLk4aGtWfDNii8kB4/g3ilUEmCqCGySLaUnfx3a7tubR675HazmUXDX9Jz1KS
 dxjBEmBhWr2xH5IgDvVeo0jODGbcQL5YoaA4Cb/jx4bmlFttpHo19l5q3xC05zcr8kTDND5dCdL
 f5uDBrJQuz5/Fpa7fOO+rd5sqCMkYfhPywoBQUgRpfYnMKSgC/yVMGuZ9+ajwN0RCEfD5/wHWC/
 RwS9hVwYdaplidTP9QQ==
X-Proofpoint-GUID: atZCmx7FSnPsRgUG6a0mXkW-4R8GYPPf
X-Proofpoint-ORIG-GUID: atZCmx7FSnPsRgUG6a0mXkW-4R8GYPPf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
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

