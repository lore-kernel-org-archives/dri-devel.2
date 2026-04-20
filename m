Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFE1F5A8BC
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 22:27:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 07A6610E773;
	Mon, 20 Apr 2026 22:27:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="hyOAyhUB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dHMhZSwL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32D3410E799
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:28 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63KFp4iJ2281691
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=2/Y0xU0H+zu
 dioSG94bHnT6saitjlexOXZQ/Yt0BEtY=; b=hyOAyhUB2I5hIXIWDBpOrfwKeVM
 3eZSwH7LZTTUJR5YGyr287ZCBRCKK1NuP5As0WbHvs2BcBEDANOnDeZG2Kpnz0ug
 QPPiR2dLeqceTK9JyfsU2PwnHJabvC65w7Sw0nMc9YSe0p7ysVbHapPpSemvAKjg
 7L8yWedjpEBUKrBkCF4WkD+GHqiLBZdGSl6iXAtJE9ZI03wDlLEY3XijPlB3SsiY
 6N8LXJ0rcjLEwe6cRgh8j3S7eeocmy2DFRSaRjWh2OuFdmzXe1J6mR2a6dlE1qDC
 /4zzGpVtHFWKWz6kdSDguKTrB8J0ROXlYAKTC/dUO/fBZgoG8ujlN8nL8PQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh59asxw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 22:27:27 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2b242062308so65225395ad.2
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 15:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1776724046; x=1777328846;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2/Y0xU0H+zudioSG94bHnT6saitjlexOXZQ/Yt0BEtY=;
 b=dHMhZSwLmrBcXE94chSM978JUmbizjJdqXwzGfD5+Vw5B/9wcLBqaZGi7Zhke5y60+
 FPRxXIg7pJNOOpKCWwzqg8T7f/vGBQjFZA8fLzwLk6Z5bTOM5b9bgIIxtq6G3dYcqhc9
 Djp+q97wSjxeQbV5Vr4zvsJARI5qtc99bT4uhkI2yYcmcgUX/rftMa3W/L4krO77Dv1B
 +7AZb2AsIHQRSL4tvLMafw/GcxHoa2RxFtEOCKRXjGv/RlhQzFaSyjrjrvEWLeFPMHJP
 P2ZnbSjHYiW55GivCfWFNpbulydRLWzfJv4fu1kHZP904Ewsjanzz30GqA1FhjztaPvC
 L0Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776724046; x=1777328846;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2/Y0xU0H+zudioSG94bHnT6saitjlexOXZQ/Yt0BEtY=;
 b=paBAkwBgd+VSHurXi02e2LylpaWAG92KOlSnKxxhL2E2cdb3Bk+tOaUPetrjbqcuDZ
 bkVxwb3oU+hrV2sNRzgjPZHTj+vnoOnng0vy6rc3uC+rjqis4yJB7YEoiRwRt7dlAgm0
 zhRhF9DaaUceXQUgq77umC1H6kqZB9PlntnzEFgAP/NDuTmROmIdKqQZu/VULjj8FvcE
 RVnihUbsW8U7DZ/xo4985ug11ofGidzAGqKttuMQAeolZ58nVDpIR9rbK99lRTEEBoss
 oCyP74bElan6I9nxdrw93b224oBPnWjJz9WPzMKlIJJM38SHqGZ1jDlyq/RJDNudUX7U
 CyGA==
X-Gm-Message-State: AOJu0YxakmvBNGAYvzTrhAUbpKowxHZOqh2hsArSt510ZibQa7JuH47d
 8isUhRTlzrMo0A5QLST82X7shoITg9D/t0RtqR8f29GRV8ffz7G6Fhg9+cTWgKvBpOU6O5Zdud0
 QNePhKZZy7fIVhWAnM0fV+Q+tGLJlcPbBYCMMigRAWbkis/3c+8fR+KNmcQMBBrCSYR9N69EPQF
 DIWsg=
X-Gm-Gg: AeBDieuM6W/ZTjIm25j3VEQwTsVeV4nm/LRTifuztYLp1a5Df4BAtGIQpxDgQ/HXh9F
 omNHMlbJB8qRDNCxJZ6r0SRC2WjhmawjqoL+0y4U5HKmflEK2Um/enlM/fTj4+IAanKrsyDSm/5
 fcMljHPCNXysWXI0EE6mYij0G9bZxqxSXnJ2mW1PS7zIJC2uE9EFGVrVNPxGeSwNByoWeVFKqCf
 aklzB1XfU1DBNYhCj4O6R57ppYNSIY80C4tB/QBBA/BAWhosIyGOi2nzB/jxhwTFl1gGs0lsV/L
 mRpDUmRhUhkYpL1eM2Xlj35J9dPiO3OSfuOOpoROm9LDfqZIn57SQelU7QEFBmHx8QACIoKtP1k
 fvyOZ3VdAcbtC49vGpgf/S4fdXyqz7QAyoa0WaX09nG4=
X-Received: by 2002:a17:902:7c09:b0:2b2:81aa:f6ba with SMTP id
 d9443c01a7336-2b5f9f4e801mr119262595ad.26.1776724046031; 
 Mon, 20 Apr 2026 15:27:26 -0700 (PDT)
X-Received: by 2002:a17:902:7c09:b0:2b2:81aa:f6ba with SMTP id
 d9443c01a7336-2b5f9f4e801mr119262375ad.26.1776724045505; 
 Mon, 20 Apr 2026 15:27:25 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b5fa9ff39csm115725225ad.4.2026.04.20.15.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 15:27:24 -0700 (PDT)
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
Subject: [PATCH 11/13] drm/msm/a6xx+: Add support to configure perfcntrs
Date: Mon, 20 Apr 2026 15:25:33 -0700
Message-ID: <20260420222621.417276-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
References: <20260420222621.417276-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Fw7BFiAKF7OEUbiFZLYM6FbN_dzZDEPv
X-Proofpoint-GUID: Fw7BFiAKF7OEUbiFZLYM6FbN_dzZDEPv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDIyMCBTYWx0ZWRfX6gfBHkwulbLf
 ObvR4DFCJdvA+MiT+PiGQqlIeGn7lnloAu+NDl0rqfj11Wb9a8RrdWkqQRvSdxb78MkG8I0ii2X
 6pevZ0p83Fo85KIoupC3V4afgl5jA2jbOsefqwlJwGUSkQAPPQ+Vx+III8sgwm09CDK9wNv2iKA
 X9zjg0PoUjacdqBGoefYuSCUPJoXWLF1SbQaHUduOmmSFbpjpwXqKdOq42ldTXzrOHM9WOXaOiB
 ZbobkvKzdknhBSsygH0zwfwJg5cv9B10uLdOo6vw+cEH4ru9ENwXabEKQfGSqUW9LexzwFDIWvc
 xK9UMVZG0B9xfzRAIFR3Kby78L8fYzm20E1rO8etVAEBIGxpB/ElQ/8xRpEPKHSlBwINVKOz7fJ
 VVS+pVp+cffGODaSpbQZkbhxCmIwAvaon6MKfLlYNGZgkasCfdp1D6fxAg7y3WZmVVF6b3Y9QyC
 b54IooLDfZfF+paOqbQ==
X-Authority-Analysis: v=2.4 cv=HNrz0Itv c=1 sm=1 tr=0 ts=69e6a84f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=cYDoD9QTrnOhnChb1ZIA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_04,2026-04-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 impostorscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200220
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
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 66 +++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 415902f6e5d7..0149eba403e4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -2535,6 +2535,68 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
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
+	a6xx_flush_yield(gpu, ring);
+
+	/* Check to see if we need to start preemption */
+	if (adreno_is_a8xx(to_adreno_gpu(gpu)))
+		a8xx_preempt_trigger(gpu);
+	else
+		a6xx_preempt_trigger(gpu);
+
+	a6xx_idle(gpu, ring);
+}
+
 static u32 fuse_to_supp_hw(const struct adreno_info *info, u32 fuse)
 {
 	if (!info->speedbins)
@@ -2753,6 +2815,7 @@ const struct adreno_gpu_funcs a6xx_gpu_funcs = {
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
@@ -2786,6 +2849,7 @@ const struct adreno_gpu_funcs a6xx_gmuwrapper_funcs = {
 		.create_private_vm = a6xx_create_private_vm,
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
+		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_get_timestamp,
@@ -2822,6 +2886,7 @@ const struct adreno_gpu_funcs a7xx_gpu_funcs = {
 		.get_rptr = a6xx_get_rptr,
 		.progress = a6xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a6xx_gmu_get_timestamp,
@@ -2852,6 +2917,7 @@ const struct adreno_gpu_funcs a8xx_gpu_funcs = {
 		.get_rptr = a6xx_get_rptr,
 		.progress = a8xx_progress,
 		.sysprof_setup = a6xx_gmu_sysprof_setup,
+		.perfcntr_configure = a6xx_perfcntr_configure,
 	},
 	.init = a6xx_gpu_init,
 	.get_timestamp = a8xx_gmu_get_timestamp,
-- 
2.53.0

