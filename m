Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE918FED3E3
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1430910F611;
	Fri, 24 Apr 2026 15:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="L8hwhr6L";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="e9TVgpDY";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BFD210F608
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:19 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63OAF58g2447975
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=6gpiGKD6NOz
 XykXwNxb4bW/bNZG0eBfs5NrEf4+DquQ=; b=L8hwhr6LpCNIVlaWJwEeB/PkxcX
 zA6SD+xpM4BoQUanP5kBS2YwljfJ1l+/LcwUUI+cDhhfzNobEq2kLCA9t6sU0PkK
 u2MsbYhHZ25pZ47LrThPOY6ACfUdZIvPtJzJ47qpcQV2yJirFLZCNEdY4ajxxqH+
 H73RoH8MvLJYy3TctjpMMObA4cF3Wt0GZVl21F03qKBWkZjA81Qm1TaN76T1JDas
 /53SXYS9sLzQqU1qRsnGTDyD7k0yyvpuR1czw7YBRsMDyrXi+N7UtNuvUdWxvo9b
 pnCiM0xt94mhg1hjEWCCaTNqDCxQZySv0erHI3Q1VpH+d1+q0cnslk30mxw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dr6kps79x-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b630753cc38so10427532a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043538; x=1777648338;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6gpiGKD6NOzXykXwNxb4bW/bNZG0eBfs5NrEf4+DquQ=;
 b=e9TVgpDYBy8QMYR4Joi2CTOm2xpI75jIMz0/VUUsqgDJ53yWSAfg4VZ/Lv6GT+DUSk
 HdJ+PEpnCsorj8bnMoseuOzaplQ7AVxnYS0U5ZEdpR809XpJpKL29Oss1Cmk9jadqtK3
 tsHskW0EgrpBpHeXnKTXOrYl9yXCz5aP20w4TPrE97LvQUbM6VRjqdPhMQ0rkp06KwON
 6fmyvUJm3rtVqOMgB6ppInoD1wXabnr4SoyKtUZyRlTkkmNd7q6nYCPXj7nYGr02IyzJ
 3LFwO4eC9ZvXRPtH/ZOmwbqj4Ca/W112POzDaMu1GMYsJ3fCzu1Keu5VVb1GE7f8sku5
 8rAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043538; x=1777648338;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=6gpiGKD6NOzXykXwNxb4bW/bNZG0eBfs5NrEf4+DquQ=;
 b=l12eBkfEJPxbvAARDCZzI40D5ViK0Mrw3m4/7I6WtaGVuWh2MgoVp0DYmP+4NYE6+r
 ZWBHulVFb9T+U325GUNzI608TGBECRn0kZxSRhSfUdhQhFLkaplk+oYFijnxWdja0bLP
 mu3swMGKdvSAOvqUzDyY5oAXaY5RdoITNWeg05FzLQSWAR2Vg8qUtx1XZwD95ISfpv69
 m81QXqdsT6Ar0eoTMWz9LSJxaDTX8JmLe9Kx9U0C8YpsQO/m9qxKZ6ANzct06o6l7TS/
 K8EDpsY4E6+0UOC8Yhp6xd4LdRQfgQsJZtso9hARvKjtGSBeCJQWFw5JLgPsLqwYrNkS
 h2oA==
X-Gm-Message-State: AOJu0YzbBqLSoawArsrH+wvhUftQ7cmHrM/64nvB9CDS4tWGl6nujj/9
 5Lkqd3WiKwumUa8jYdmvZw1VW+mVa8pbwlkSpXcCuEAGQH1R2y4pP4/yZSZOgGygY14WMRZdMIj
 dx4ejAzeVbHn3Em5XmfJSUByI9qqVhdjA3R/gqKdzo+B7E0EcLgalGKIxI5HbUxGEMewmXJBQXr
 /+huw=
X-Gm-Gg: AeBDieu1B8T0BNlTAKfFEXWgQoridJPHYiN3WH2Lbbb+pU+AlQwyNx2etotDLvXlzQ1
 BQtIL2p5R5raidNDgG2tsIAhYPaQAYuY7Zkaeun9rm+oTQidxmmr+mW6Jg3lCsmeAdpP1uYiS4u
 TlpIdGutKaP8QZTGH9HhrjRSU2Er3CWRvqSn0scI5MwKCbCulLd/nD4E+sjOebfkfGmYiZw0E+S
 KVYLqFfBP6bkZ3RcBKpsS41UDLdtONUoD9ut9gXIIJflJNuWGmTtKRME+drdn5w33YHQz4x/kwG
 CC1acua1o05d06VGgkOxUrJDjK1d9zlbKivg+XdDFMG8alBs3gwlEdNDxqD8haueqL1t+5ggTMA
 msjjJ0kuUBG5kK2AJDhL+l3jr/BxMJKGutN+m41ZTGHw=
X-Received: by 2002:a05:6a20:e211:b0:3a0:cc67:39e with SMTP id
 adf61e73a8af0-3a0cc672136mr28254929637.41.1777043537925; 
 Fri, 24 Apr 2026 08:12:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:e211:b0:3a0:cc67:39e with SMTP id
 adf61e73a8af0-3a0cc672136mr28254868637.41.1777043537326; 
 Fri, 24 Apr 2026 08:12:17 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7976f9db0esm17494595a12.10.2026.04.24.08.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:16 -0700 (PDT)
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
Subject: [PATCH v2 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Fri, 24 Apr 2026 08:10:46 -0700
Message-ID: <20260424151140.104093-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=cdDiaHDM c=1 sm=1 tr=0 ts=69eb8852 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=oWecmCczN8450n14xlQA:9
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: widuv3It8hn63SnSQ66sqibiFRjieqWq
X-Proofpoint-ORIG-GUID: widuv3It8hn63SnSQ66sqibiFRjieqWq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfXxlpquxBnppUE
 ks2pXMYKC9p8UDKFvvh1Z7aLBOFL8djUUfqdJ/nhhDf3xbjyn6DnaPaiQn9YiJzWnln+T0QFFYm
 j9tqvJvMdSoJwkBsCMkk3i27Kk2Fl3tuLVWlthBARTED/DXBMTzgwByAiKJCIhyCDaZYUsuUuME
 Un9LDzOF5GRks31cKdVLn5qsOUtai2CasLuPoxjYH9FAQg9y/oDnSqgnokc+m37jIQwITMDYnk/
 sLXpCA3ks+8cO7Geet2drzIZAq0wKgUy0SN2dgqEeIJ85u4hXwGnfX0eoUbrGSdUdMYsEnmwmuU
 UIrg2JhK62Ix0DFGHdG6oyRJyL0NLWWcXhhTUfwvR2aDD3ZwCvIE6P+IqMyF4wJe4wBPFzt1kZn
 agHM/c/JM/vm5Nv5HUKwDFOe4lXTOQJxROkYIrnOLSambSWNKDHhEzSCIMzoTDhw7YJfI6dfcsd
 5lIWpXvUw+ByH2z0Hyw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 suspectscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604240147
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
index 415902f6e5d7..8b9dcca8e051 100644
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
+		for (unsigned s = 0; i < ARRAY_SIZE(counter->slice_select_regs); s++) {
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
2.53.0

