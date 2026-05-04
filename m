Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 097EDCD3427
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 19:08:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EFF610E813;
	Mon,  4 May 2026 19:08:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Wn3GBvrJ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cmObs79h";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CDE10E82F
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 19:08:43 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644EM0g61960830
 for <dri-devel@lists.freedesktop.org>; Mon, 4 May 2026 19:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OJPIWHLYmtY
 h2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=; b=Wn3GBvrJzKSU9RwPkJUnX9CvYv4
 LBGfMEj28DgRQPt+MQRkcO+OOqdA3DPaDEjXUzI8yo5qKovmxudQVpJQRMUaDZvB
 Bizim9nhsSpEPWg64aad8u4Rwd5veR7kkBsQroiTO3qn803U3Y8A2GIZ3w1UGMdD
 rMgDbipMc5XoOVlE0H3oe70SpFt3F5aFghXpL+yhoNOEs53949ByDth7wG3LM3Gr
 Oh3EWai9ZxDLKRN1oUkZZzhM8OA+v/Q8uQjAcTG1u+HmBCbz7YjzYXy8x711REnk
 b5n556S0nOLVzavKLLKL+HNoTP15w8ZwoAApLP5Lw3tD9O/fQeBz1twf77Q==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dxw5ds5n6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 19:08:42 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c7948640854so1868942a12.1
 for <dri-devel@lists.freedesktop.org>; Mon, 04 May 2026 12:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777921722; x=1778526522;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJPIWHLYmtYh2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=;
 b=cmObs79hOx5T6kw/i8u3iQMLhVmj9PpqKGZsJ+R+2ATHumbncwOBoxdZ2A5VvKRq2C
 L5j8OlXsZKda1vZniX8DQyl6ON5Kfdc0fXDoBfZ7QKaNg7NnD1+8lDsFU8pXkKS8qdhH
 9G1sZPZoqHxrXkRePa+2d+LPQsLpMVW+ukCIHJKhjnFruuuO5g+is/oPDi6Ry6E3f0ov
 tZXvnabgcZu1pmiZxRqbI0bW1uEcyhjidoABP/9UmEXd7dbwE3oKvj0MZI4OK6b1TZtF
 ex05Pljn5WC36hipwY2rgcEQP7aYVlroafX/kddVkhcoYJoMnxqObI1GufZsgVA9Y2fT
 ye8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777921722; x=1778526522;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OJPIWHLYmtYh2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=;
 b=XwSFdlmzSH9QTG7i+QC/eeh33MlDOTGdAgro5owsWmQAW0HaQQcfE+oNHvlgMuc+5C
 foMMqkNaaNO8NYhzQbsG/q6hv1rDE62o22NoW7XOpQkvGyvewWaoHDB5arOxwhij7sWB
 WP3Z/L+iIdTKn71ch1KLhDrUds8jBQS8KWFbSED76O/xC5JDI99+lL+rvADPH9rXqBbQ
 lDe7AI6uY5UhV5Dx4bCgG+xNG9dRx0/hHJ/M0mRyHiHOCt5/Osf1o7TydePAgc8zyvsn
 DIE9X7S1vldaCcJLLuNt7FTA0yhJYkfdOSyvhhQSuLnkOUiua62fKvg/AXwhpDRmKnc2
 +/EA==
X-Gm-Message-State: AOJu0YzDemuw+8yXl0l0Wpsa2Wa/GtypOx1K9AA3GJGhJXxyg4/YkwJb
 5sjHQEyJ9fKu9IqRc7liC5B1ZfoTiXt1iTmoNmODtHKq+wCKc0dgtnrNJU8NYMWS1YxFWtbkkGZ
 6aSC7rbaT2IXAOkwOJkOhu7qM0WziSniqXjUSMDMJToBYw0/av2StQnrvtVXxXdam8HjHOYG1FD
 n0OXQ=
X-Gm-Gg: AeBDiesorB6qL7dmAk+j5D+oE5+IqZRCnjcZVcwlDkZSzVU5O+mi3a077cl2GkblzPN
 Y273/WmkSipzX4PenE8V9jhH0QGKloISBjlZ+lGf9BBqS4XRl6Ddofzr4ln1hS9f0sPPzvOJY+C
 d5HbPBR42T5Ma04++F29G/OPtZXA5UpYfhHPZy+EgqD5tZtlmVXR3YM9x5cU/b2B2xlw+HCj6tT
 IVpedANW9U+JXmdKCSJiJxn6a8AQCC/1LcQ4FehgkQke+cUUNTaKFCQ9/an9sHoXLyWy/86XwG0
 xfnDie9hMW67CgTDC31r126AZjUKSI8obv2FiJBJTeebMLM7/Xi5gcnFSJcdDzEDfMAfKQRw7+y
 iTQwO9APYnqZETZF6cNAI7yGNG+O3MDCE5FuWw/pdZmc=
X-Received: by 2002:a05:6a20:2589:b0:3a3:90d8:fd7f with SMTP id
 adf61e73a8af0-3a7f1ad4c45mr11338468637.8.1777921721585; 
 Mon, 04 May 2026 12:08:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:2589:b0:3a3:90d8:fd7f with SMTP id
 adf61e73a8af0-3a7f1ad4c45mr11338418637.8.1777921720906; 
 Mon, 04 May 2026 12:08:40 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7ffbcaa477sm10418922a12.31.2026.05.04.12.08.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 12:08:40 -0700 (PDT)
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
Subject: [PATCH v3 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Mon,  4 May 2026 12:06:54 -0700
Message-ID: <20260504190751.61052-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
References: <20260504190751.61052-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDE3NSBTYWx0ZWRfXyYTwjcSH4ixL
 6570XvdJWz3NQFkz94aXZywhT7SioMJIbue3305uTAiTqmkzp9Si82JfJhz6HUriUgLVG6w3fz5
 F9AUARn/n459kk0aUG1SjedPtc3QsCPqkT7FppL04yAtbs0aWARBr8V/1UdF+XUMNXnTaERwo2D
 7mmMzTsNOcaJeKWb3jj4axxE3QPKtXm/+AOcr/ZQnnh2uLKleDAt+40THwoFAmeIwmj1SEYK9j9
 Ufz+3PkcxKN5TckwZ78Z0g6pqwOIytJJoxLHmjNXwfoaaT3ELrBl3e5CCXzgQsjfzl0P+/v50+0
 l2Wgc4B0wYHVXxopdp07JRzfTyFau4e/7UbKECAO39g6k+9xSvUalQQXFU+0j3BlL/xr5ZNdKF4
 /ACU06VKVziSV0J793c2hwViZdALtCeo34KZwY5HVmH4Hwt7TejrLeLL1PeMsXcu0dYonomvjW6
 ySO29a5i0D6iTS6LH1w==
X-Proofpoint-GUID: h5bLtjs2fF6gONbztOpE4me7O9R9gLV_
X-Proofpoint-ORIG-GUID: h5bLtjs2fF6gONbztOpE4me7O9R9gLV_
X-Authority-Analysis: v=2.4 cv=HpJG3UTS c=1 sm=1 tr=0 ts=69f8eeba cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8 a=oWecmCczN8450n14xlQA:9
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_05,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605040175
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

