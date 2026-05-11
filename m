Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE18FCD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47C6510E770;
	Mon, 11 May 2026 13:01:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Qb79K+31";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jg6Pa5nM";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF78D10E77A
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:34 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BBIRP11344442
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OJPIWHLYmtY
 h2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=; b=Qb79K+31KB/Tr2YfwFhERDvwKQy
 +Xe2jobb5rKhUwSc/HLzhGk24P8BCM/5gYt2rMI4/hT2b10QGJyuiOs1S6iYJ66y
 7k3+mfF1Re0TVSnPEoP8iLkpbVen3BNWr0S4FFGKEIno8rMsqFvLpDyKP593nGeZ
 XiJxCzofedJGRr2RFc33lBYPcMkTRfAxYjjmjdqTJctpXCIqo9qrEXzkjgmm81by
 cdriA6u6oqozBhBN2XlxEyP7XKO5vmbc3jirXqrwHCvGCR1rvZui6QLbCKFYpVzM
 u8N869kexHZfSzUdAtcwVsex5e6R9wEi9H/bktDN7cvmhUZbyRoV47oRbHQ==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3e498afe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:29 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2b458add85aso47487065ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504488; x=1779109288;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJPIWHLYmtYh2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=;
 b=jg6Pa5nMG5kCBTSrbSObAXpK2vIk+5yVICL5N2D7GRlfX2DxCxD1S/zdzewspa2vXX
 LI7lIKHaYPmFNciB96ZHPWjYbaeFzopnqb6ywbAp6+l8pblWvvyDTJ+tVqgju+XUxFP4
 ZSO7lvf/K9/CjKmWXEOSdT1wvP3vArEeDnaNOXt2zxBA7v9y6XPC6AyOgyq88oAUbNRP
 aPu7TSE6AsFcjZDbmgVHWjMZ7/bhsIQoOHa1QPHVBtXr9AcfQbZHcl44E6BMydQw/21k
 Y9W2rJQnUbqyfZqewLF6WjVPnFZq4QrgjL8bAcPk7VFODxwchUS+lzKE0cE1G1KlAAaj
 GQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504488; x=1779109288;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OJPIWHLYmtYh2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=;
 b=DULWU7k6O3FHwfTOAJEsIC01QskBL41aTlEowio6FPr32kzJ6oLI9O78TANrP00R1c
 uq4y6ivrYMFsf0vF9E+6LfvVRtExIyxXaKAT32eVIEAVUQ3vvZG6PQSZRp2DFasUxLd6
 JNXcHm6vQli3m3JJo1XT777lupIOMVJZC9Ytrp3/PQljFr+1AJJsjyA+5emQNH+soVvQ
 NV9jCH8ClaBe2o4QtLLASOYjh/KchPrg8rxK7vPahUlpwY9pVSYAHm0pAhIjPOaX9m/f
 EtGRK/X8ada8svs49HZIffR5NAf8PmWMgE/oAoZJLG7TN38mBOXsMGdeVh40+Lvrr3KE
 2FOw==
X-Gm-Message-State: AOJu0Yzbz4mL4xpsc0g4MvGNiar87DR2pjm6epvAUCPfdBsG1bWyGJ1f
 HYoMlY7hYDzUMlHTJhg9Sm9XP6Li8SqXhG/cyUivR7v0O8eusGn2yFLzyG1A7DbrHbpGTOSvSzz
 7y+Op0VA2UdDbHpHNc4HVbOhtvhd64nlBQfl2T41J4SS/sDDP+Ul9XeUs5nGFV7vyWIQ06Ms8Sq
 e2Iuo=
X-Gm-Gg: Acq92OHCZsEC7L62YzCZ8i2sGyo32j8ravV6QgaxLi4T9kUE5J/uz/adS7IYAhK9d2J
 oFH9uWaPlcpnSQZ9KD4IZZVeG9KJLvVYT9J3ja9soXE/mK/AdCMWmbHlZEQiwzHHayAwgdDa5Ej
 d3+NR1E2yaa08HO5sRShpJB7okrafAt2mNPjYlZ/xa4QmWOn1yAQ78S7HIGar2evHRR1XY+0G9W
 o0MWf7Fn2cLW56qXLCTzlT8XF2s0bhcMSMN87AyDIvfFzgQSQ5e8nAirFWiffRAxRAdNDYVxtCs
 TPB7qOTkrrqYDS9sX0XZ6YvFzLnLRxqifAG4tngvYFOHh1LOgkmzHoGqJzz+mtmI33jj2TNTfOf
 vrWnjXEomqjC1mHKFAE+JV4UQej4lhIvz
X-Received: by 2002:a17:903:22c9:b0:2ba:b5a3:187b with SMTP id
 d9443c01a7336-2bab5a31e16mr224167245ad.23.1778504487349; 
 Mon, 11 May 2026 06:01:27 -0700 (PDT)
X-Received: by 2002:a17:903:22c9:b0:2ba:b5a3:187b with SMTP id
 d9443c01a7336-2bab5a31e16mr224166345ad.23.1778504486632; 
 Mon, 11 May 2026 06:01:26 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1d40434sm107088755ad.29.2026.05.11.06.01.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:01:25 -0700 (PDT)
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
Subject: [PATCH v5 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Mon, 11 May 2026 05:59:24 -0700
Message-ID: <20260511130017.96867-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _TTlqwYA37Qyo5rBXIPiB5EaAgeJkY9M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX1JaSLbdSr+Od
 RNPf8t6cYGe+rQIDhrWkZQJ2w3JzOtL7JH16uO0Vb8z0OpOmzcZcv2mWfCDEmpqf4TDsk4Xc4EA
 0BRDbEUUZFBGgP1DRSOeRajcVZmEybMaNSxB2974/V/o84zSQq90lPmS6thuUsEfOc+avjZAXkz
 ySsO8Zm8AXkt4mWYabQHSUBxWmmlXLrzpjUvKEqe//KRpqNbXHGBLjDM+AI8p8Lsl2AQrr+JIHY
 WMyDM7nHGU13zrFsQeUx1kWxAD+p+/l6rsZDqbRBuRaQNmuh93o2+njRRMAGsMnKxHhY4nPJ0mq
 MFrP17NG6yOzp9jJ2iLC/U3NGYJ24dVdmHC9cFhxR36TFDCvgnFl6VBXDUoHfRtDWRRXh/BwSiC
 bJPe4jvRr2YY6xpNl0xeW4bNk1QOZg==
X-Proofpoint-ORIG-GUID: _TTlqwYA37Qyo5rBXIPiB5EaAgeJkY9M
X-Authority-Analysis: v=2.4 cv=Yr0/gYYX c=1 sm=1 tr=0 ts=6a01d329 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=oWecmCczN8450n14xlQA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110144
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

Add support to configure counter SELect regs.  In some cases the reg
writes need to happen while the GPU is idle.  And for a7xx+, in some
cases SEL regs need to be configured from BV or BR aperture.  The
easiest way to deal with this is to configure from the RB.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 69 +++++++++++++++++++++++++++
 drivers/gpu/drm/msm/msm_perfcntr.h    |  3 ++
 drivers/gpu/drm/msm/msm_ringbuffer.h  |  2 +
 3 files changed, 74 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 415902f6e5d7..30df9bfa9ef8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2535,6 +2535,71 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return progress;
 }
 
+static void
+a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
+			const struct msm_perfcntr_stream *stream)
+{
+	enum adreno_pipe pipe = PIPE_NONE;
+
+	for (unsigned i = 0; i < stream->nr_groups; i++) {
+		unsigned group_idx = msm_perfcntr_group_idx(stream, i);
+		unsigned base = msm_perfcntr_counter_base(stream, group_idx);
+
+		const struct msm_perfcntr_group *group =
+			&gpu->perfcntr_groups[group_idx];
+
+		struct msm_perfcntr_group_state *group_state =
+			gpu->perfcntrs->groups[group_idx];
+
+		if (group->pipe != pipe) {
+			pipe = group->pipe;
+
+			OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+
+			if (pipe == PIPE_BR) {
+				OUT_RING(ring, CP_SET_THREAD_BR);
+			} else if (pipe == PIPE_BV) {
+				OUT_RING(ring, CP_SET_THREAD_BV);
+			} else {
+				OUT_RING(ring, CP_SET_THREAD_BOTH);
+			}
+		}
+
+		const struct msm_perfcntr_counter *counter = &group->counters[base];
+		unsigned nr = group_state->allocated_counters;
+		OUT_PKT4(ring, counter->select_reg, nr);
+		for (unsigned c = 0; c < nr; c++)
+			OUT_RING(ring, group_state->countables[c]);
+
+		for (unsigned s = 0; s < ARRAY_SIZE(counter->slice_select_regs); s++) {
+			if (!counter->slice_select_regs[s])
+				break;
+
+			OUT_PKT4(ring, counter->slice_select_regs[s], nr);
+			for (unsigned c = 0; c < nr; c++)
+				OUT_RING(ring, group_state->countables[c]);
+		}
+	}
+
+	if (pipe != PIPE_NONE) {
+		OUT_PKT7(ring, CP_THREAD_CONTROL, 1);
+		OUT_RING(ring, CP_SET_THREAD_BOTH);
+	}
+
+	OUT_PKT7(ring, CP_MEM_WRITE, 3);
+	OUT_RING(ring, lower_32_bits(rbmemptr(ring, perfcntr_fence)));
+	OUT_RING(ring, upper_32_bits(rbmemptr(ring, perfcntr_fence)));
+	OUT_RING(ring, stream->sel_fence);
+
+	a6xx_flush_yield(gpu, ring);
+
+	/* Check to see if we need to start preemption */
+	if (adreno_is_a8xx(to_adreno_gpu(gpu)))
+		a8xx_preempt_trigger(gpu);
+	else
+		a6xx_preempt_trigger(gpu);
+}
+
 static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
 {
 	if (!info->speedbins)
@@ -2753,6 +2818,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
@@ -2786,6 +2852,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
+		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_get_timestamp,
@@ -2822,6 +2889,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
@@ -2852,6 +2920,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a8xx_gmu_get_timestamp,
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.h b/drivers/gpu/drm/msm/msm_perfcntr.h
index bfda19e01535..14506bc37d05 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.h
+++ b/drivers/gpu/drm/msm/msm_perfcntr.h
@@ -45,6 +45,9 @@ struct msm_perfcntr_stream {
 	/** @nr_groups: # of counter groups with enabled counters */
 	uint32_t nr_groups;
 
+	/** @sel_fence: Fence for SEL reg programming  */
+	uint32_t sel_fence;
+
 	/**
 	 * @group_idx: array of nr_groups
 	 *
diff --git a/drivers/gpu/drm/msm/msm_ringbuffer.h b/drivers/gpu/drm/msm/msm_ringbuffer.h
index d1e49f701c81..28ca8c9f7463 100644
--- a/drivers/gpu/drm/msm/msm_ringbuffer.h
+++ b/drivers/gpu/drm/msm/msm_ringbuffer.h
@@ -37,6 +37,8 @@ struct msm_rbmemptrs {
 	volatile struct msm_gpu_submit_stats stats[MSM_GPU_SUBMIT_STATS_COUNT];
 	volatile u64 ttbr0;
 	volatile u32 context_idr;
+
+	volatile u32 perfcntr_fence;
 };
 
 struct msm_cp_state {
-- 
2.54.0

