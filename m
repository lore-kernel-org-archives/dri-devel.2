Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C530CD4F3C
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 16:25:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D5F010F0F2;
	Wed, 20 May 2026 16:25:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="cTxzk9qq";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HvNveCiM";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F34310F0EE
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:39 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64KE6d5g119201
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=7DkVqoNUSYo
 eBkjLEkY9jVmN2ecujeJJRqwKEcFSezk=; b=cTxzk9qqcG+7BD9/CV8IhQvL2ZO
 YsBk6kO5WaWL9nLM/u794tne+6pnDP7wiMccahdctA2osKu6Zs7loGUAA9kc0+Xr
 /ylByqskCICznLXv7Fxg2ThfZDG3vBx6I2PuGZign0A55yNbkXDjisN7/aOv9dKF
 /PoDP6SIfscM7rEG7tzU2RrVVPympGS3wU3+RpeZ+oQp9Q/eTf71sys6a5971lV0
 n3QNAC68QxupOEf3Mwq1FIpe4wz5LO5us+gQ0beRZGNf0gJnDGdeD+GVxNmx6/zr
 zqF2FOrFOf/31XZU+C+EoQu++ywYeKEMUWe+LlIR3xUyl4nhLq6VVQOVsSQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ee88n6n-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 16:25:38 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3663cbff31cso12757875a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779294338; x=1779899138;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7DkVqoNUSYoeBkjLEkY9jVmN2ecujeJJRqwKEcFSezk=;
 b=HvNveCiM1DRZj+EqEmXzOKsJ8bVLNnhQlz1EVwtgQ6EQTxWkMgpm5j1zp6BAmJVoYe
 9/8X5lrE0Z+o7t+c1SlzjTqPCh81OSQX7JLfCMfBiKoigyMtAhbtuiG+3NCoustTdo06
 T4a/XKDJwbOVFoPzOxRibNkDLwNDwwBIGCflGQROk46X8+fkAMmiU6FeUIQpCRoNtiDb
 o7woJTXzRvPyNdytBpqGlSOvtdAu8OdRxH6ORjYt7brcPIWPRzIV75evIl30cC3O2Uj3
 qU5n77jvxx1oA6mq+gyTG2U0LFgBbkISmqgCHFvgK4ONpDi9b5uPi6po28Jx8tZJ1xyF
 Mdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779294338; x=1779899138;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7DkVqoNUSYoeBkjLEkY9jVmN2ecujeJJRqwKEcFSezk=;
 b=n7DWUEH0kcALFPnaGGy0VYCbOk5eHegMyzWnd/gtSrHGu3In3+CZZzBizTle92N3ad
 4hf1P//jeuVvifzjbWGaXrr+zO7bHrreFdlRANqadkHE7wAzcYkdSePukRdEm9+gusaR
 XQdDwJnPnnrpmxYHqx0gNIAY+YsoCySRsMskiVVxHpgnuIH7nJ85/9JDE9tOX6dyx3kX
 j8YQhjlPXGdQYOu9KZkkgslbA2xj5XBZEHDVKRVmc6TfUxefnvGAwOB+/uXtfk3ozOLO
 ZgzemfxJJPCIL14aAcFCNLYVM2MW6FWXCmgDqELV16wV4ZVfy9BoinKxwNT+ubvcMttn
 2PBA==
X-Gm-Message-State: AOJu0YwXNnft8PJWMbANJzpEeMnxmPUNy0dIhfrL1X6sypZPJacsCqHw
 lANlALMZn+DRihdtqztAR97wNdlcZJbla1fVlbeXbjjdZTIsvhMwBdudYtBjgNJAxvXrPXdpvUG
 1Sinka1LySBhmg7UXfAsQRhEmvhcA0x+eEpqXvXh1NMllwjHdvIU6UKE0xPawMM0HkdPunqo6IH
 4Nemg=
X-Gm-Gg: Acq92OEePKFnnmPcOE/YcFLVKs8qlO9fsxFnijz8zcomxEysbEJGKJpaIq29ubvQNk4
 9lhjC380r8lFlJTijMWCivKeEtFAJHLuHeF5fffhJeg0pqB40D35vWag2j6EfWcxlqqAwEa5ZQM
 eQ6z8p5gQUAm/aG9QABtIma9oF4gXjh4ukH7VUAo+jLzrsj5HL6257ehYeJIr+zg+13dwTDQWWw
 KzxGNCDZvVp3M417zV/YOVDY7GKMG1xAXdCzlDUjr0fiHD2ls75TptvM/AWUSlrBLqq1ZKofnpG
 3OY82YXOQ/v2kaxUD8OpEmxUcw9twtV5dddV1rLi0m1NaZ+S4310qkS7RpfbogDK9F5FO7nLa76
 7+WKiY7xbOBclSL7YTY4IwqbRJGiKTahYF56hLvo5Eko=
X-Received: by 2002:a17:90b:350a:b0:369:a74b:28c5 with SMTP id
 98e67ed59e1d1-369e930bb1cmr10202229a91.19.1779294338183; 
 Wed, 20 May 2026 09:25:38 -0700 (PDT)
X-Received: by 2002:a17:90b:350a:b0:369:a74b:28c5 with SMTP id
 98e67ed59e1d1-369e930bb1cmr10202183a91.19.1779294337493; 
 Wed, 20 May 2026 09:25:37 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a3c83f226sm145920a91.0.2026.05.20.09.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 09:25:37 -0700 (PDT)
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
Subject: [PATCH v8 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Wed, 20 May 2026 09:23:58 -0700
Message-ID: <20260520162454.18391-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
References: <20260520162454.18391-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: v8yg9FpsmoMEII4M3CF7jfhqLnhwz57P
X-Authority-Analysis: v=2.4 cv=e5k2j6p/ c=1 sm=1 tr=0 ts=6a0de082 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=F-OJb-hlSlUoWALVX24A:9 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE1OSBTYWx0ZWRfXwsQUNie+S9lB
 UWNTjUc+4PtXrPjy0ECwdBzxhl6sTQdq54wTOuj/B+NeQ0qdxTUvdqNyASDP/lD6JNaRSWeXCxM
 aRs4SApoVktY6utzVJnBW5hOS6DnRSKlUgRW3XvXm/Uiw1Wq+fOZh24RFXrBvcYmcn46xRNyZhc
 AxPPUEiIfYFIybHWlRiWCr+ToPnF3hhV0eT0lUZcnc/4723KVPam2yPvLNsAcTDBJo7A/j9GzJU
 f/U2kwgI5AkdPGNMtNbx1oj/tdtSgOOq0Ol6ima59/kKTLuRoTMoMDj4RCvVr3OhmRn3/AGgj/p
 vwVzrid9nNoNIutlKz0R1zYRgPlA1eBmyl8bN9xLRZmrJ38XLVI8en4b5VdPTEvbR5dkljkfy17
 viN/QP8FjeE2yrXJEsnFOwMYx7mTVA688M+RuT4n3NKzCQiDWdkj8U+T+rF8uRf8gaUFjgyS+36
 jezK1TzPMyalOPu52qg==
X-Proofpoint-GUID: v8yg9FpsmoMEII4M3CF7jfhqLnhwz57P
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200159
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

