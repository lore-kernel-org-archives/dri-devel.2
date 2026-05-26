Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6749BCD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E35810E6B1;
	Tue, 26 May 2026 14:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="ZxZbiWzK";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hgi9bnQL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE3F810E6E7
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:20 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QEIBJU1361204
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=0di5UIbflTB
 I141kxS5NLO0kr0e+AulUYsw1NrtDCDA=; b=ZxZbiWzKQiqWv5HDTCzDGSqxc+a
 A3rBL9R7kXpQ00Ap3cJ8UzniGLPoblm6n9EDJApT4o6IkDjVsvFWmKT5TX4raHQR
 iKYo+jUMsoZ6EUqrKeK7jSM95UIkaMtIjs1eRijxLhLm5qYuPsM4NS4b52zPVXO+
 j6tUg21GuK8YYFdC8f7Tsul9HPHJKOuWoOxonK0e2LAn5nT2at799rksGwE4VCOa
 a5tNZAWHQncBhwaLPBynqxu4og+G9DW89UXwfqtiFSfV5kIoWxqWnnPKzvLW8rfg
 Vfqsylk3JSYuYZz+O+f2fMe2mE80RQV+odU+pEEbW+pcLeyJgxuzaLPdgJg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4edd5ng55t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:19 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2bc977e6aedso113279575ad.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807259; x=1780412059;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0di5UIbflTBI141kxS5NLO0kr0e+AulUYsw1NrtDCDA=;
 b=hgi9bnQLSZTDfvFyXMjlJTZhlIMAoaB9dRThE9StPpRammC3TJ5uvuFRWchSy7mJ7a
 5rJM1QZuj6NitK+gCT0otJQcZa/WVIR8mdPnc+hRt8ZcqiQFeIZyyshhKbE9n9fuc3iC
 4i9iD3tug9tm7yXLJbSJzFCpAdBTZAk2KNRqy3TZ8069dID+fk22y/iZmlit7uepM9X3
 92qUUoBLPZTb0ngaOufFgBiakMjP7Hg+5hDHIKXCwePZCzIhSZ0JmSCs+Y/etBW4yX/m
 xwOQXn0nCo8h0L8RSIH/DtEVrhKOUF7A794Rlx7luyRIf6cUDA1WkLvvOpNg5dUuW7U4
 MBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807259; x=1780412059;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0di5UIbflTBI141kxS5NLO0kr0e+AulUYsw1NrtDCDA=;
 b=lzNr8q37rc5QVbq7eLsOrrmuRq43Ufv5a3sjwWkL97HsmERGNZ69oMDOr/hugHlCxv
 H0e7fbHDuGDS5J8yAcK0KOv9MXETux8np5oNv4c4+ekpj3ZQAloUOiDu10yArspn8O3o
 155fxsxToUwi+sgaS40gI03amwbgHyGeNzoZyOMPjN3fl4zHWaeMEuVmfYvTsUZTvnDY
 0XgelyIuqfbcGuH66gczfaAwBFUq4NiDoWNlaZEmHLXkvB1Z4F8gd6SZwzaEvqwQUODI
 0QX6wWunkZbd7RVQZqutzFreqno7VRDQZR8WjtMVJCcN+RJp0290gawGpKVTP2E/+VdP
 sXxQ==
X-Gm-Message-State: AOJu0YwSeTpsNwolx/dFFVNaMrshfN5861K7RejJa+gPoKJ/iqx6nGQG
 9DAoqLv/CZuzh8mBlXWO5sdP5UggzAZVBy2kGyJOUkGM+qO/NwFerYzOk2W7QyZrEgfdFI1stjJ
 tWVMI5+HmotX8v0j0Df/4RN6wfX35gxAlz3mpnzOw0DxvVi5DspTCxApjYLDIMVqwvfPlmfQptM
 f5PPg=
X-Gm-Gg: Acq92OHGhhvd1HIh+v2LZm9QkDajhkv4Dsq0fPRBPR9BkVufQsYEsXqVaDLTvzlQ4j2
 qGnpcGnFw9ZzEjXxtLcTyj0tgpC5cD022t9suXml+FSROCxao7SGtWFfRsCl32Wh64WSqkpVseJ
 Zb5Ds8FAhMUi9j6CVhWYvCBBU/SBBIAZR8DiK8+tZ4Dnn0kLJFpWLRGO6XkPkBWImih9vI8wXaJ
 nWoVME///w1tz2rEMvVozP5rtxHC557rqZ/sFpWY3xzZ7stO3deVSTws1FfFy+Pkx5okycmo3bg
 VyNzoS+oTs4Y4v7JqiAk9Qzn48p0KV7O7LXCRrylepiZ8iTUzo2eBXH/RVyfwttjgoEh4cRPuNq
 s32l0/E6NUi/ODpSX2LAYdohF80eYFPuC
X-Received: by 2002:a17:902:d50c:b0:2bd:105c:91cb with SMTP id
 d9443c01a7336-2beb059e13fmr218616145ad.15.1779807258681; 
 Tue, 26 May 2026 07:54:18 -0700 (PDT)
X-Received: by 2002:a17:902:d50c:b0:2bd:105c:91cb with SMTP id
 d9443c01a7336-2beb059e13fmr218615685ad.15.1779807258102; 
 Tue, 26 May 2026 07:54:18 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2beb591f63dsm167225565ad.83.2026.05.26.07.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:17 -0700 (PDT)
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
Subject: [PATCH v10 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Tue, 26 May 2026 07:50:45 -0700
Message-ID: <20260526145137.160554-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vdUWLla6ZjHWWm3yE7wGJo4Ju1xm8TZw
X-Authority-Analysis: v=2.4 cv=TZ+mcxQh c=1 sm=1 tr=0 ts=6a15b41b cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=F-OJb-hlSlUoWALVX24A:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: vdUWLla6ZjHWWm3yE7wGJo4Ju1xm8TZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX7YXRHOOzahRG
 DDvedr6BiajN9iHDByy0E5S7SDeWinpSvYmoxhWro2OmlU894/7R2qvoRYEJJakhUmQcQE7DMfE
 SF1kSzNNoUNqn3zYQbAlcTaYVx/fLqXoPedADW0jkqWMBrCKkPu3tipvfxzjJVEJKCdvyJBXgUt
 dN6ckc4LN59BJjenTVss1N68kjbzkYZl1hgs6VSpXFgc4+7wkxX8Pmd23Z1Bc2gzNB/RVqeFrpM
 6HVxexMA06hmwS/3iU16CxG5hCMSuDmVkCsOlwULj81vC5zQ7dR1/m8K3yMGWlkGe5C8xWB72Xd
 UQwn4LiusLrBDwIUpzcTHuxuG1s7jL/oJyS0a65OB4snoRiKOtjArX0EjrcvoSqrF4OSfLHuNV3
 b1HKaCJdzwEjGyyIJkmVPDH7DKaTckXLuUlDGRPJ/KX8hDGTqdfXxfyspgxD6LSrUwACs2LtzW2
 u2sRk9VzQIdgbwca9ww==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 adultscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260127
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
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
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
index b5a00ab7362b..2ceedec5296b 100644
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

