Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CF59CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 17:12:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1DEE10EE51;
	Wed,  6 May 2026 17:12:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="a8Y82Mf7";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LdHOD584";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2164010EE51
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 17:12:10 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646DsNp22428163
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 17:12:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=OJPIWHLYmtY
 h2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=; b=a8Y82Mf7GdXaBGgPOsz/5d+9o0y
 Avtbc4RvcBqDN0+mUu5u1qJ3oFIpObEEqzGcJf7akRr2Nw05gUD5Vns6bO4mZGri
 ZZYa9geSMEYnhR7b5yKWjGttpOnQY1v+pxC16l3SaRRw+8TzAZkG34MnLh+HgEee
 u9a6WsGkENCN2Usqa4TADB18rgz6VCeIxM2SjMnjrWXoVWQ82/ok8HX+9NdEqvfm
 G8trLgHz/WLdfXtjoZDMzyASDL0o/s0jhJKVNhP6WWUkQ2Hz1l56Iwow7J4hPRS7
 Uvn5XUlMXIvVstJVzHrc+3FiRL9nkkf6s98xmRt1m50ln/fbZrN+uaxUUiw==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e01ph25w6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 17:12:09 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2ba718173d1so28254305ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 10:12:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778087528; x=1778692328;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJPIWHLYmtYh2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=;
 b=LdHOD584b+rtCmLxOjjKOlfjVHZVom/tBg0mAWjJf5G5Uc+suQk1tU3QkSvQMtFA/e
 xtG7e9BAQhdQ+mm/HaSUrlHUuHOddFmpYqpyaPS+imF52Ampe4J2Jv2/ihCWHq8K4VG+
 Q+m/jQJVi2/0G4RwcdvZJWwriauMt7Yp4U3Bwbs7o7RUbrmKOzFap5Mgh2ebmtwkP5WQ
 2i2llOD3djC01AlRajiKW/MYFLVPBBa9YrUAzQ4FvCERXONooN4D1Cd+Ln7FxXQJ/yDp
 F/kfZqYn2M66k9SAP0Otj9uI3reP/1+oxoIUkVngfiSmKpsbmv9k8vLRmNLSilksvPdt
 kFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778087528; x=1778692328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OJPIWHLYmtYh2vRJzlQwHbA8ExzYkFh40ePWlyvRs1s=;
 b=YOndCOvH1VbweQi0ol5GkU1bjAAdu+Vqj99xJT+/P4tD9uY1druLK3/ccgFRsKmpeR
 ZiPoPcU5kjRDtke0uI++4QQz02A7Uuy9nP0LIr9wdL2dLJDF+rngP/9TbTMvxo7UFeDL
 vn8WUPeLLlaC6UnjgyiHs5C7tVZfVI62lapXNphfmviNWG4O4GfV0dA5CaDSNHPYao94
 SLul2RI+lo5rMvaLeE5Ju/fnkSmlyzJ7/cbboILmwQm6FswwPuic4Y4ZGe7uMhpxlqK1
 +xmMCWbP/mUXX3QV25mwICm7fxvAEKJSVHvFPWle0eMg4uGIqTKpD75cw7izcFOoxcse
 mj7g==
X-Gm-Message-State: AOJu0YzSH4/JqqvLRiwDshG+ygNfBpaqCfPgSW5ScECrEIduL6UFgtM/
 Q+e3XsCKuAF8srrUgnSZ2ddIxgEmayYpWN0XDsweRd5lv5VbO73Z/IO7sNR3mEjKaYVYPH5h+HA
 ZtcFsK1Ap2tSiDnahvYXBDIweiQHKGXqLgjRneWsleluMApe91f0GTre0NnaozH49WpPV0SrXfc
 49gVU=
X-Gm-Gg: AeBDievrL0keu1EuV2m+rMXg0vxH427WAuiTMVEzKTLo7n+WCYn39H+Y79/Ouat3Rm7
 EHUd1AlG6v/p9gkqgh1O59NzoEoKnBeaowVr7P1TJ/tbKDamFMFG/3UgiECTMFrcfKZLH/FTpl3
 k3BA21aM/yquRMrsgtWTsQY7Z7chL85Tu0WJDi0je8cBvBzDy/9X7MTgFuAsGAXRPAierowV4k3
 vxZqGu95mkdWO03I5dYW+jTo8x1Xw9IubcJ5EN5/wtD7Jd8cmBdjeP41UCHLGQtrqSeMbj0J/Ah
 V2/Rwg2GitQQoH2U7eHWqeNXaq9WjFa5sImAc1NxnrJoekz8RDjE6S8V1o1V1XQgl/+LYgfOrcK
 xvqqiWiul6YVfXbUr0KRQ3AnmJ18zkdpUog+YONpD3N8=
X-Received: by 2002:a17:903:1b10:b0:2b0:bebb:1081 with SMTP id
 d9443c01a7336-2ba7a20ce22mr42688375ad.28.1778087527866; 
 Wed, 06 May 2026 10:12:07 -0700 (PDT)
X-Received: by 2002:a17:903:1b10:b0:2b0:bebb:1081 with SMTP id
 d9443c01a7336-2ba7a20ce22mr42687895ad.28.1778087527221; 
 Wed, 06 May 2026 10:12:07 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ba7c033711sm32920865ad.33.2026.05.06.10.12.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 10:12:06 -0700 (PDT)
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
Subject: [PATCH v4 11/16] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Wed,  6 May 2026 10:10:35 -0700
Message-ID: <20260506171127.133572-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
References: <20260506171127.133572-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2OCBTYWx0ZWRfX+xILt5iAU8A+
 OAryfeNuURFcjm6ef7oZ7m/M9JLmKC27IW238IVPAuvTM7hkj57QiHi9bkL+xWIWbfjCwSVPOYZ
 3Ghsr82OqdMq2d8zvvw72gq97IssvER9V9mkPejdC/Tt/jKuR6IwtCr80UfZV06roOlaDuvsINh
 X3xRgVnYP8o+H9JsN8mBN4qZ2kDI6vGWDSTq3Q51y/5kNpHJXk8YzjsbbwEa0Jx8Rtb5qkHvY71
 DIDubnt5uZQZaqnKGFPmkYSu6yTwLMUa0pZJRi7b7Y7d2N/7TzTMczwOcvsX5nQ1m//F8WvMe35
 yS71dzvawJAJ3il03QxNO893CqzESSwA8cViBReDXucwJKDA/+60KOtVp9ZCauDT9uY1dPr42CY
 CXpVNyFVXwU4mQzVl6V9e/jIy7FGWltYQUrgA/2B5Cks/9s6uIS4RGqUaZa/OJTm7BlSvlIvOCz
 SozBWi4ZcCPsfrfdUlQ==
X-Proofpoint-GUID: KiGrzTEh6MkYwFCymAyWVy-tvZUgbmEA
X-Proofpoint-ORIG-GUID: KiGrzTEh6MkYwFCymAyWVy-tvZUgbmEA
X-Authority-Analysis: v=2.4 cv=MYhcfZ/f c=1 sm=1 tr=0 ts=69fb7669 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=oWecmCczN8450n14xlQA:9
 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 clxscore=1015 impostorscore=0 adultscore=0
 spamscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060168
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

