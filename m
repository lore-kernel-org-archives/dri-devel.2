Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8474FCD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:08:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 698F410E9CE;
	Mon, 18 May 2026 19:08:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ljy6+IO+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AVy31S6x";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B05CC10E9B0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:26 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64IHVkBX2083413
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ntrYj/Ki13u
 4Ie8f2izhqt5WotaMwwL8t/FAwrisOvU=; b=Ljy6+IO+ksuesFXgBTvrYAAc1oK
 jwSdF38/rXwSOSzybuflx6Mda95Y0Cp2IItVcpxZPLjrBrD+qQe7vJtbFWA3pQGl
 8qey8EBfLGEUkNOvoSNgiagUrCq0cYsyIkBCxbbkfh10h4E+GofTu4wcLK0AOrlR
 O130C5kYKUjVxmr9RyP4GhhyTJzQvEOe6xRIFZlGoIRMdWS4tVuzxF+ScyLwZ7TR
 NafoNlAsFQppY+Ke03qju/W6M6fOkcJt81dr92aWGG48q3AvfWkEGhmPzgTawH47
 0NkTXw81ZuhbPxvYiRQk5L8CrWkNok4OjSNzAKVbjNrPQgv4Novus7QpE1w==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e81ch9xc0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:08:25 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82f9429f49cso4287340b3a.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 12:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779131305; x=1779736105;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntrYj/Ki13u4Ie8f2izhqt5WotaMwwL8t/FAwrisOvU=;
 b=AVy31S6xcSaVs5tYPMpIw4Q77HdeWC644CaxBw8nsTqb8EUP8cA+AYxqB1j8FzEDNL
 QFF2MZEwZcvw45goolGwyiPrrYiB6ouQJ6rYxiRty78/i14tJP84VC4q1MysIvTMKm1q
 ORJU6gumnw8JTF9rMFBsvuGmy1xd3rcgOcs1SF2NXkk5d8FdYiKeeW4FMBzZJejlug6p
 D2ge9OsChhf5rnIgZjf5AFQ70MUVa2ZEB+HrP4mudANfpaIsVoBbeer7asL627r2/iti
 J+HEzXde8QMK3P4wo0EdRyjoc3Z0+mGWI7tI5GbBzvztAGp8rq2a5Pgh5SD+aSZwGqA/
 9l0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779131305; x=1779736105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ntrYj/Ki13u4Ie8f2izhqt5WotaMwwL8t/FAwrisOvU=;
 b=qp9iIQTm2ePnOeHfGsmtt/kReLhkUUWxzisJfKK4atVJeOTyTIPzmpZrrkxOIWEc89
 rwv1MIYcxOymqnQ9H7EC0xuaz4QFIOFDnkicXvMFEFc14+JrZybRgyLq6qfvgMhO7HG6
 eBl/teoWghfzXm6iofwrleI51N1SgxzksOKSomsEhTOCMpe49/88DLoLjEVTeq+zXxGu
 w3e5XxflkddZxp49EwO3hs0h3FiOpKi4kSAr4i9S350oF7IMgQuLJFfKpj5hSdXFzgJw
 nyqZ9Cc8BC907YtKP7EXq/TIbBt6W903pRfMv7YpyCaQksWE274Qp8IkhAnt3+c1bzoG
 3Myg==
X-Gm-Message-State: AOJu0Yw13Kn6gq8ULaZ5QO+oaD0TzSr+C7fXyENre722WwznbvlVbegu
 ZwSsGRVZKUM/b1jFTxXmqc7kSLz03PP9lsS33IuXSSbNd2ZU77YtxIxQJYdLaHggSAahmguo2zn
 Uv3PDixNYkEgW+H2v5lXWCiyfIaDYhIyjxbEee7CnN5QLU9dex6WZUE8AXWzHlIWf2iQHVyDPHA
 HwX0E=
X-Gm-Gg: Acq92OG20dHItegbv/ftFEQRbXbm8kBJpsa9H7EzrmbVbRchcX8hKSsKrhY4ZcyfK0a
 aKj1l5V0cpeCl8WbpU8QXxAf5H/N2BxTh6LvuwRbh8UrC2CMqrg9lRLP3fytY2zBs40m6VThHw1
 Keiv8cm5XeMLAMqslKz0olyIet1krBqPtQkNs9bvoWW8UGVC+H8ElGCDQPVJKsBU4PTxNZ5kJwH
 9DUQk1/tZmaqa1UUzDkahp/7Hh0Vscs64+wDSVkR9fLF9v5pIBgtE86B3LEBUYqQhPv43HVFCLN
 9BPbpk2KAQSwQ4vwhAiPYGP6u43XTuDFlzdii0XHl7AZDDHYfIrEMdprT27HeBfRdN7yUrKmU1u
 mnvZGGDbsH8tMEMFpimXyS26qaVWV5lnw
X-Received: by 2002:a05:6a00:400a:b0:835:cc47:6fe7 with SMTP id
 d2e1a72fcca58-83f33d96b70mr16429648b3a.30.1779131304575; 
 Mon, 18 May 2026 12:08:24 -0700 (PDT)
X-Received: by 2002:a05:6a00:400a:b0:835:cc47:6fe7 with SMTP id
 d2e1a72fcca58-83f33d96b70mr16429622b3a.30.1779131304131; 
 Mon, 18 May 2026 12:08:24 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f197815cesm18696721b3a.24.2026.05.18.12.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 12:08:23 -0700 (PDT)
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
Subject: [PATCH v7 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Mon, 18 May 2026 12:06:38 -0700
Message-ID: <20260518190735.16236-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
References: <20260518190735.16236-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=a4MAM0SF c=1 sm=1 tr=0 ts=6a0b63a9 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=F-OJb-hlSlUoWALVX24A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE4OCBTYWx0ZWRfX1yYqXpAD+lzq
 +bLe6KPW4e2l2SSCtTt9bEDREGDBgbiOe8WCEQy6gQU00rYBvinU8o1fInOI8p5RAyJsR+O0GkM
 D4wjfBoGC8Cfe0yaI7mQirKR6QcqYqz5l1Uo6YUU7ebYKWdDIrF4G+/YdkldrDHkh6BFFXWmv47
 n4gYklCIbx46p/2IIzg/5vhJ5i/lPiZUFv9WfRA5MB8FqCvwkZVnjmmIU/iEqWH3XJrc2vCDCQU
 T8ivm4yUdoMir83fEnfdJm9N/ZnhRgPTyuoipvneB3sVz+K9hmI56jRiL6iTAqLnjXFB1Cuo+lh
 ipljAPQNSH0KeVr6q52ZYb37VvJU7ax1yDVgcgVT8yZfOlJY2yi4hh/WjC+rIKKGSezilXeQGIW
 4Xi11ZmSQ2vbvvqlXBAoj7BhBMAnfGxSj0pehCtzpC2YwifnfulFGbsQ0mJiPS2naKcW+GZlGVo
 cEnbJvp8p+i6d+bQkOw==
X-Proofpoint-ORIG-GUID: g7D58YmYeSM0JS4rLfZ-FyGSTftMPV5e
X-Proofpoint-GUID: g7D58YmYeSM0JS4rLfZ-FyGSTftMPV5e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605180188
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

