Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEBA5CD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 13:54:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CC010F255;
	Thu, 14 May 2026 13:54:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CqbXjaWf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Zql3LAqG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1917E10F233
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:38 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EBeWnA889453
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ntrYj/Ki13u
 4Ie8f2izhqt5WotaMwwL8t/FAwrisOvU=; b=CqbXjaWfVH7ccfrdW/KNfNnEyqq
 IQelHsCaIZrxNENvrjK8T1LI+y/MvKLZ9hlPFvOAypBZydJZo8RBr9YCa6JH/fCv
 09WX4qByDbkHbmK2RRPbUydms3NFLH9mzKXyoclBASluTmqqB6gya0XI1BJ7eOAN
 QRp7V0viOJv3Ncc+lW+u2p44mN0XMGeY3Ko7a4z5ZAEJIs8fF4LU6i7+HTmFiFRj
 183a6Ulxa2izGxsjjbCIVdK9Q6uaODlJVgt5qBpQHhQHTPGjmTs5oNIPbalG8gHo
 NWHMILKoYlasob7zrBvYlrWUSrw+PLJHXySG0JpFta7xKdFPw80AGqaxNUQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjm3xh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 13:54:37 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c70ea91bfe1so4913991a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 06:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778766876; x=1779371676;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntrYj/Ki13u4Ie8f2izhqt5WotaMwwL8t/FAwrisOvU=;
 b=Zql3LAqGHNOxz9Qobn7+pKIq6/X3yGor9bWooxEUGXN3Nm5/tKbUxkGHjxZUL5SQ0X
 +jd8zOybeQ+HbgONb8kfB7ZpUlGoyODMo+lBXk1v38fZAbqLCiBgFhCBooSTQcW28LEr
 48o1lO3sutW+vdFscpw2DTRebBOlpmeOSMvjK6MlBdbcWEM4Fh1vf7lt1Wbva07SfoHV
 jiZNyk+IjJ0siL7R8jLhsbPPUItaz3yBKp3NUOVqIsofGOx6xgWXKoloKTjR72h5km3z
 M3f93pZ1a4rN6ehZuxd/zu8YjKc5mKIN1l7vTHum+ZpQRx42eXEbP3gWo482cmOLF5jP
 qhTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778766876; x=1779371676;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ntrYj/Ki13u4Ie8f2izhqt5WotaMwwL8t/FAwrisOvU=;
 b=VFSYMfEp+1tKmL3/xVSFrUEXwByHc2IAUvcI+GhjnABZHADXZop+RzJEaAqRxXF1Dy
 bey0GQMbb61qCjAzn1KNtde6ovZhSDMrabR+AkVRRrrs6E+EQtCvATWCjMdX7YsxRbPM
 lkuyeh3G8CTZqsSBzg7WHmc3ypEBMP7utSFqBZFjSfFn8xqD6cnpqAcJgyjemBceEF1l
 7QirVp/plpmSl1kXE6wrAlaU5szkrxAYcGe7t+qLdSuqQ1CHxB/xe4osMJocdJp/Zl1z
 zg90XU0MR9RJDEhrZIimLzNDXgPqh+qCYBJYvTDErGwqSBKDxUy92RZDu8BGKdorHl2P
 nNxg==
X-Gm-Message-State: AOJu0Yzw/fLNwyJqqYhjV5kXs81kxOccwS8hBNyGIZm4ZcBWbBb38Jrb
 ySoqd0epFYpwSuddDshEwOzRicKFvZBlUzFjbEWQHVLRRXfm9J0vZlVTAD9aIMGiXcR6DrOHisB
 JkFBunAt52Qaln0S42UnB8+owv5bRQYO0m/79BzHg6D7soBnwW93lCw9zMacg66p1pxVij6pwNZ
 poQSU=
X-Gm-Gg: Acq92OFDxqxXoDBvh+CmTxSEVL0UvqkSzWGf/6pvPxE7bxEDX+xN/UL5+iazaObbEjc
 no2Diwh0A4nL7/IRLUUVkZh4/XW9Hl+DAaa0IrPCGjiAfl73hkYC6N8xEP7F2Sa/x3yip6IevX3
 +cV6BMtHL63XZaRk/9DQEYY9wUbsO8WPfirQ/w8QHn/wBJtmJxqPwDc4ojIKHwUTPBsN08cDMod
 5fVSh/rY/5RpDMaeCLU9A+3Ith5gVfyr64nmFXJ4HLhiJS7kgrkbOebDGOvwvcryuhyeukKpU8N
 WZ//Dzkj61+nydYS1UGz10qm92F2mdfIuHkfkX+QjiqRMvneSx/ixbdbWTNNbrZ+n6beS0MfjiS
 RgI+QzTJnxcgY2TK6ZGoV0/YdIQph9+eoow9uVjWlHks=
X-Received: by 2002:a05:6a00:929a:b0:82d:29f:d003 with SMTP id
 d2e1a72fcca58-83f0578088bmr8503840b3a.12.1778766875417; 
 Thu, 14 May 2026 06:54:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:929a:b0:82d:29f:d003 with SMTP id
 d2e1a72fcca58-83f0578088bmr8503791b3a.12.1778766874847; 
 Thu, 14 May 2026 06:54:34 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f196818efsm3793780b3a.16.2026.05.14.06.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 May 2026 06:54:34 -0700 (PDT)
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
Subject: [PATCH v6 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Thu, 14 May 2026 06:39:59 -0700
Message-ID: <20260514134052.361771-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
References: <20260514134052.361771-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 9ZBvE00BgbkcPWjVnCC1fidgl2ikArZl
X-Proofpoint-ORIG-GUID: 9ZBvE00BgbkcPWjVnCC1fidgl2ikArZl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE0MCBTYWx0ZWRfX0gXIV9brLcRq
 5f4XAijreOEoRO6iB9ExiZvTLCJNK7FuuxAj5VIgvuCSeh/Y4Oxb0Xy1jOBGPDLk0+BwKcCOfHa
 9tZnRdLRKltVUd78ann0XL5tOAmLc/NuIAgJeKTSIsgXwxOXbMSnF/DXH3lSpSEITaGKdCU15+2
 FVQMJcuE/6xkSvBwwf8Mn7ihy6fxD1eik5Swh20DOERpohlplrViOmAmhdIFg9UwY0jpOg5PQY7
 HCy+Z1t4GGS5d4lNXQ8y1bmf4nfSaCueBjPzg9C4ESoGag3sEeVTmN3uR0XUpjyYTl6LHniF7dc
 hVIJP+YgAJnjLWeEGS8QDEg18aYcZIH6SCkx1go45Zu6eniv5K0e8tfRYMkILIyn3ePdDsBHFaI
 b8L90qS/PsRdbCxNVdagCJMTNJI3JWYtYGs3Ufqlto5ClqA0CbncLOSwqDBZCC1OBOVTPl5A9ic
 0f3X6PGQnYlAufopaGw==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a05d41d cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=F-OJb-hlSlUoWALVX24A:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_03,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605140140
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

