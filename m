Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F9ECD5BB6
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 17:35:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3353810F6EB;
	Fri, 22 May 2026 17:35:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="GonL8aot";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="cAeFjnvx";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5600D10F6EB
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:58 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MBx3621298051
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7DkVqoNUSYo
 eBkjLEkY9jVmN2ecujeJJRqwKEcFSezk=; b=GonL8aotiu22+EUFgM42vZ2GtwE
 IAaBnUG3JiROkT3W51up7M7JratwBqsl4uUQ3MkUXbqQx30m0RAIvUylfqLHe4vH
 TXEIP1cIuTWLBy48Qw1KvvT6AUMm8GwK81T4tCWvvt5488VxWLaTmpfmC1q5fO8x
 oZvKEZHvU4RkpZtcmAVJWhNZsd4L1++fIrWef+aLBvo2oxBCzs71nsdhVF+fHyDR
 LbWCnIDrnBbTkic/COLjAW3dBkU+P/xZkDO9O4vPLgC9aGI72oZXE3tBm5k+zi0T
 ayZARX1UCCkQ6EI73JKbo1Sgty2AO29uIe12b9DCZtjZMVub2WTiIP3rCSA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eaah0c7j8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 17:34:57 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-369ef27fd09so5801869a91.3
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 10:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779471297; x=1780076097;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DkVqoNUSYoeBkjLEkY9jVmN2ecujeJJRqwKEcFSezk=;
 b=cAeFjnvxzw03yHrXgR5+AgnmoQ8N69dFeYQ6NYNys4Ez9va0b1U7b3+khgy43PC/hx
 rZmxKy464+9qA1IxZa3A6iGSjSP5b6URJlN47XdGxPn3hng67/6nl6Xjm7DgVERPuQv4
 jLWHnraW4/8F1BRqoHzFm8gbpTPMoLv14x5faiY8lfVuUo3DJF76Zy5myBUD3ako9fVf
 p7C8t96Md0+8r2juJMfDiiCXehtQCWp/UwXHEdEiZolC9NI1+IOWGxkYr6f0sYKlXHRd
 +LoX1vv1N6qzZAduJ+8trEYgm7SgQpbFgCT0w0++kk1on0B0QwgHmO87UAFXdF2K/Brb
 nbIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779471297; x=1780076097;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DkVqoNUSYoeBkjLEkY9jVmN2ecujeJJRqwKEcFSezk=;
 b=Ui8d7drdwrKboJm6b5EquuveIfwxxHiDNrWn2YvEhG67PDYu1i2QO0c6EwFaq8S5qM
 W3DxY8LPGzEF0N3fMh6FOmE1tWJkPKjeKTio4XdlFPcM/MY5wcqHzylDVe0j5Q9T/1AS
 cqv3S4d1GZRRj5Ab3AoWkfkeOIM7nBle6heh81c+KKq5z5cfTeh4LDP1CfOC/6kd3HnF
 vyPjMoekzSstjXltHnhTLj2YfMZlkdnOvyvI2M7hZDnxe40nXOWE8DZwbuw4FK7yL3QC
 7uRQ8cdD/yzvfPS/fCv5qFXg27ojxXcU5ATGPaQS0b0g+fg3v/oMPxUJHyeR36OgTSsM
 CJGA==
X-Gm-Message-State: AOJu0YxZHZ5zAKVQjy5vf1J4qXVX75tkf+ld2dcR5olKdV2U8rZ4SU1s
 SsoSuSlt8gE8gQ7/DnEXKM077oe5UgEmCcFiFOZW7Pycq3tbLsn8qL1Ts56zbyeKEF1eldEAwxw
 m34OnbOWm+5Uf2YPWNF96X6QBSfGm58b5sWVNtjAYweJA3gb2dlXIaLCczhEBa43H2bXeaUOTtt
 X5kZU=
X-Gm-Gg: Acq92OGkEUWRBvn58KYACdk7PpdiVRRJGMf0HqLQWTr8QhVFGUpV9l6SeyTjyvnp/MV
 2BkGvLO5xmeykJY/IyRsU0BbOj9pskHkdjc85CuC5GDrLPPWEaKF5xxyERr8u0uqP/9+FQaWZUI
 9QdgewYARDM6wE+J4JV06OS0z5NR2OiUIFPCPU4DtJKuBboiOAN1+kaPVByhqW70SYcqytVt5EN
 oRKC94ufQ2FrkqNPexJyl0MmLuThg6taeC4IMe5FPdYeLz1eEG6ulQ8exCcPGiA6rjPeIWrPBXB
 pz67cu16aPDs6kSLFQOGkHU/jeJx9Xnj54BLANnSkV/77gKLIjuMUKq1f2FsvulYIS5GQ/5mTzQ
 +5lSKDvtCJTP/hrJB6xi17v2TUdjFeDfI
X-Received: by 2002:a17:90b:5208:b0:35d:a5cb:95c1 with SMTP id
 98e67ed59e1d1-36a676287b9mr4361132a91.23.1779471297052; 
 Fri, 22 May 2026 10:34:57 -0700 (PDT)
X-Received: by 2002:a17:90b:5208:b0:35d:a5cb:95c1 with SMTP id
 98e67ed59e1d1-36a676287b9mr4361108a91.23.1779471296574; 
 Fri, 22 May 2026 10:34:56 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a721c7b92sm2318481a91.12.2026.05.22.10.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2026 10:34:56 -0700 (PDT)
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
Subject: [PATCH v9 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Fri, 22 May 2026 10:32:57 -0700
Message-ID: <20260522173349.55491-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
References: <20260522173349.55491-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NSBTYWx0ZWRfX6NVrp4YVfXhE
 0x4CqsJepzR+sDoeIy7mI30tJUHMsxyFgXTch0FYrPmFZUERi4SkpyVJVarLKmqJqIr3rr7Bpey
 4gZLWb5lZHzl0kCu8isK6ERXjHF1oSwVNbw4NogaKRwfUOhEm5/1Wo6l2+s9mLkgr0U+Ngi+R/H
 QN5Sy/nRPoZz/SjwPo8PH/5T4nGZuuOq0ulPgo2PDxS4lrgVCr4UVPnGZU5HRBAwqmhOxho8XAH
 Ac1Edb494KDnpMmupSaB2DhNsvIlEh93qgmnzPloxNN4v+gq+ybPm5cv8GEeg6N4sEYcv9xNfrI
 mPyZICc7NVldnSE2kohiOu4JHkGfvVHbvuqhCI1YNYgZsI2/6nnrQLb2xDDpwIvW9wmLAgY6RL2
 nPQifGdD3sSilM9zI3hFeov6N6PwrAAtc8fW2Qqw4wZa+FbAqRB4ufarpqUe6pdKiKzWPI5Iot4
 qMK90W/TWPunmWFHy9A==
X-Proofpoint-GUID: _RYHIprRTXBGQchMYhD7DwJK0bkGIwoW
X-Authority-Analysis: v=2.4 cv=LNdWhpW9 c=1 sm=1 tr=0 ts=6a1093c1 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=F-OJb-hlSlUoWALVX24A:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: _RYHIprRTXBGQchMYhD7DwJK0bkGIwoW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220175
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

