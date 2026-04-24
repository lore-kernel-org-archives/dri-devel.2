Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA8EFED3E2
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:12:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D433010F60F;
	Fri, 24 Apr 2026 15:12:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="CmnA3vt5";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YojW+BcO";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7313C10F60B
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:27 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63O9SFPn756631
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=PSZvuLL+r9s
 fCfccBd2ob0WPVN+nCe6j9d//PM4k63k=; b=CmnA3vt55xpV8+HzhjvomPbH4/a
 bED7Ez48WbrzrbFSeQs0MkheZNscjbCezTyq/S8srV0bLo/m3YiQXAp7IOxgODgW
 aw/Ib7KHoZvNDXUWkHVhFf2TEaS0HJfTFqdlsKNPs6HLTZeP7ScJGtToMpi87eBK
 /56sY0HXoCwMo1V1RS7Ct78bZAvou0mHxNOJ852BFJYrLz9mt2F+zNwGDFGZpCFu
 rIm7CpdRDToUdOJ6olyUIp2WmPw1f5xn11qtzRzL4etOW6ulujiLeko6avWXk0a5
 Ub87ZLPrFccUjbQXPsQ3DeurgnptoBsX256fhz1ZncKbX7d82ax4w8y7TxQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dqr4bmn58-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:12:26 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82f8bbb4045so4911914b3a.2
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 08:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1777043545; x=1777648345;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PSZvuLL+r9sfCfccBd2ob0WPVN+nCe6j9d//PM4k63k=;
 b=YojW+BcOI3VMdIQjWxWrIkIEm2SPEYjdut6cQ5SyG39Yyn5sekXQ9BVvrGDVBCmmfq
 Hmcod4E14Z/quMTKM3nOjogVGdoa7AcpjT5Ke54bSljS18B0sMkb/ZIEOn3VQPHJrdsq
 J4JeIbrPMRhsb6I2et6kJvgD/OlINE6ft6gf9dBdXXgo5x1iqa2tK64YnsXdiuTeSgZZ
 pGC8DEjVNMKT9MpQtQfqnRmYuT6eN7bgpoX396iHRrL0ekVW6a/X4ip7WnEJH+hbFHEm
 aF6Apgd9bVLHD5aAmcRKoAWNzrDhUginf1bMaEWyQHdSVmJ66D8o6D95xdgYdg4lshz5
 cjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777043545; x=1777648345;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PSZvuLL+r9sfCfccBd2ob0WPVN+nCe6j9d//PM4k63k=;
 b=V7mwRPao59hOMzY0X4fe/L0Loj2PphQ2e1SUxXimYHEVTTzLuvo23lhYZvPrVMn59/
 bcpIM4xJrha6QRiZF+Qxy5fwoS7jjYjlT8xVo9KwPU16aM/Pxc8pDC/qYaaYFuXU7pLN
 u/Y+X/v/ZZ5OAF4d/ytphBkkIrg/zi+dpT0j9uTR9eA4pK8VPJXjU4K57V8NApD6bzBx
 hMATA4iSYbOYbPBR4+qqUG3dR6JzBeNFodvXG/JsfvUlFFqZjUmMUJWT8qMkK3NiE2Ge
 rsBEQOxop9fWOGN0OM7nvxV7iRH6RrobxixajlW59wnMnCnotbzTIOUBQGFrbbr6NIH3
 5sOg==
X-Gm-Message-State: AOJu0YwMTTq4gGCuXaZk/Je6Wziw9fhKCVh85JAYRJtjyci2MGaLqHIh
 CW1h7NSy8d0b5diIxeLYaG+LSBg+0MpsJSeblFS/p8K+PrYY60iZQE5d6LdjopxY+FDxTTTiz1I
 mIL7cahjEV+fcs7iFBeNae9+SZjZeH16IGeBcvE9nc4sCDkm3iF73BzvQzktuExFbvutVK5EdLQ
 jstgc=
X-Gm-Gg: AeBDiesh/SeF0S7pUATxUUDoZn8SQsuRb9wIpKiTz/Pci/17+g06lXu4EkVBJ3pZQQF
 CJCSUnzDXxWmHG4fDZSGJkzN9gbXjiBamKG+RNKD9+T0j6eR/hcpdqqF/wvCyhZiZFx1nqtWrOw
 aJ799YWlf21dIPXDvOq5eEHt7I1/kxGAxz0C4U+9ylyGEONTCqBvicut4/oxZN3igg9p5InLh51
 cFV4jUlltRk5zCeGpX40OSAWHEpCcAD8DqHM6Iw09PQMPt418LRr8gaeaPnXYNlQu41PvX9RZZD
 Q9US4R28+smMNLOMGqOUl8Js0saRH68D9je9FT4Xeu34noqgex6HZq2k80u7zYv4KOx00cRXN9O
 W1tS841YPyXR0MFHWW8+7t3rOBVvyolE9wa1v4gEzyig=
X-Received: by 2002:a05:6a00:bc90:b0:82f:1e5d:db62 with SMTP id
 d2e1a72fcca58-82f8c885af2mr34624373b3a.12.1777043545040; 
 Fri, 24 Apr 2026 08:12:25 -0700 (PDT)
X-Received: by 2002:a05:6a00:bc90:b0:82f:1e5d:db62 with SMTP id
 d2e1a72fcca58-82f8c885af2mr34624325b3a.12.1777043544374; 
 Fri, 24 Apr 2026 08:12:24 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82f97eb5ce8sm21767932b3a.61.2026.04.24.08.12.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 08:12:23 -0700 (PDT)
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
Subject: [PATCH v2 15/16] drm/msm/a6xx: Append SEL regs to dyn pwrup reglist
Date: Fri, 24 Apr 2026 08:10:50 -0700
Message-ID: <20260424151140.104093-16-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
References: <20260424151140.104093-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI0MDE0NyBTYWx0ZWRfXzYnvHTRGLUwp
 Ex+4to9o1kLk70TM6DFQgm8+mHOLYGB+jmWujER1nIvnZeY969CEmSr6r2JBa7iRrTtjX1/m5QF
 lN1tNdGUAqAdXpnkiEM6uyewxCLUcMvIjnRcCSZC/nvHgmtsDpHaVn6ZSOjvj+md1CDMjtSW8Bc
 YAoCmJ6a1eQaiVWOQ59bB35b7lMdI6zSNnhQzPZ0tO9P2ghj1AmS2Ddp24slCX1Wio76DRP/DO+
 Z69lL1TI/LOaTKBleDuNJ4jbGcu3oEMeHWhIhF1FH2459CXlLT/Jz8ztk57AQ0VepBAY87ZKvn5
 9OVo+tNUg3Dn4/oiKWWPDoJ4QU/BVGYYs/zGfsJuB7mJrfE+vRS46WE7hv6AhAw8EWlbCLYQjpi
 VE7e7WFVAmEWyBL3AttOmioZ4GT/EQzpe3+sm+9zL7VPdOnvKavMsqggz4vsGnOwzzUPsp8+H29
 /YfNtUekLVib1ft7lpw==
X-Authority-Analysis: v=2.4 cv=TtnWQjXh c=1 sm=1 tr=0 ts=69eb885a cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=xqWC_Br6kY4A:10 a=A5OVakUREuEA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=3WHJM1ZQz_JShphwDgj5:22 a=EUspDBNiAAAA:8 a=pU0-7o-2YXwa03qK1oEA:9
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-ORIG-GUID: GLGTsj7n_sjyjbVZ5jBplxVLyCqoYpsM
X-Proofpoint-GUID: GLGTsj7n_sjyjbVZ5jBplxVLyCqoYpsM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-24_01,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 spamscore=0 bulkscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0
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

This is needed so that SEL reg values are restored on exit from IFPC.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 70 ++++++++++++++++++++++++---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h | 11 ++++-
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c |  1 +
 3 files changed, 75 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 04a6335ac5f4..c3305d18b87c 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -946,6 +946,7 @@ static void a7xx_patch_pwrup_reglist(struct msm_gpu *gpu)
 			  A7XX_CP_APERTURE_CNTL_HOST_PIPE(PIPE_NONE));
 	}
 	lock->dynamic_list_len = dyn_pwrup_reglist_count;
+	a6xx_gpu->dynamic_sel_reglist_offset = dyn_pwrup_reglist_count;
 }
 
 static int a7xx_preempt_start(struct msm_gpu *gpu)
@@ -2535,11 +2536,54 @@ static bool a6xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	return progress;
 }
 
+static void
+perfcntr_select(struct msm_ringbuffer *ring, enum adreno_pipe pipe,
+		uint32_t regidx, uint32_t *countables, uint32_t nr,
+		uint32_t **reglist)
+{
+	OUT_PKT4(ring, regidx, nr);
+	for (unsigned i = 0; i < nr; i++)
+		OUT_RING(ring, countables[i]);
+
+	if (!*reglist)
+		return;
+
+	for (unsigned i = 0; i < nr; i++) {
+		/*
+		 * Bitfield is in same position on a7xx, but only 2 bits..
+		 * which is sufficient for NONE/BR/BV:
+		 */
+		*(*reglist)++ = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe);
+		*(*reglist)++ = regidx + i;
+		*(*reglist)++ = countables[i];
+	}
+}
+
 static void
 a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 			const struct msm_perfcntr_stream *stream)
 {
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 	enum adreno_pipe pipe = PIPE_NONE;
+	uint32_t *reglist = NULL;
+	uint32_t *reglist_sel_start;
+
+	if (to_adreno_gpu(gpu)->info->family >= ADRENO_7XX_GEN1) {
+		WARN_ON(!a6xx_gpu->pwrup_reglist_emitted);
+
+		struct cpu_gpu_lock *lock = a6xx_gpu->pwrup_reglist_ptr;
+		int off = (2 * lock->ifpc_list_len) +
+			  (2 * lock->preemption_list_len) +
+			  (3 * a6xx_gpu->dynamic_sel_reglist_offset);
+
+		reglist = (uint32_t *)&lock->regs[0];
+		reglist += off;
+		reglist_sel_start = reglist;
+
+		/* Clear any previously configured SEL reg entries: */
+		WRITE_ONCE(lock->dynamic_list_len, a6xx_gpu->dynamic_sel_reglist_offset);
+	}
 
 	for (unsigned i = 0; i < stream->nr_groups; i++) {
 		unsigned group_idx = msm_perfcntr_group_idx(stream, i);
@@ -2567,17 +2611,15 @@ a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 
 		const struct msm_perfcntr_counter *counter = &group->counters[base];
 		unsigned nr = group_state->allocated_counters;
-		OUT_PKT4(ring, counter->select_reg, nr);
-		for (unsigned c = 0; c < nr; c++)
-			OUT_RING(ring, group_state->countables[c]);
+		perfcntr_select(ring, pipe, counter->select_reg,
+				group_state->countables, nr, &reglist);
 
 		for (unsigned s = 0; i < ARRAY_SIZE(counter->slice_select_regs); s++) {
 			if (!counter->slice_select_regs[s])
 				break;
 
-			OUT_PKT4(ring, counter->slice_select_regs[s], nr);
-			for (unsigned c = 0; c < nr; c++)
-				OUT_RING(ring, group_state->countables[c]);
+			perfcntr_select(ring, pipe, counter->slice_select_regs[s],
+					group_state->countables, nr, &reglist);
 		}
 	}
 
@@ -2591,6 +2633,22 @@ a6xx_perfcntr_configure(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
 	OUT_RING(ring, upper_32_bits(rbmemptr(ring, perfcntr_fence)));
 	OUT_RING(ring, stream->sel_fence);
 
+	/*
+	 * Update the pwrup reglist size before flushing.  Kgsl does a shared-
+	 * memory spinlock dance with SQE to avoid racing with IFPC exit.  But
+	 * we can skip that since the ringbuffer programming will be executed
+	 * by SQE after dynamic reglist size is updated.  So even if we lose
+	 * the race, the register programming in the rb will overwrite/correct
+	 * the SEL regs restored by SQE on IFPC exit, before sampling begins.
+	 */
+	if (reglist) {
+		struct cpu_gpu_lock *lock = a6xx_gpu->pwrup_reglist_ptr;
+		unsigned nr_regs = (reglist_sel_start - reglist) / 3;
+
+		/* Update dynamic reglist len to include new SEL reg programming: */
+		WRITE_ONCE(lock->dynamic_list_len, a6xx_gpu->dynamic_sel_reglist_offset + nr_regs);
+	}
+
 	a6xx_flush_yield(gpu, ring);
 
 	/* Check to see if we need to start preemption */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index 3491a24a9320..f3cc9478b079 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -21,17 +21,19 @@ struct cpu_gpu_lock {
 	uint32_t cpu_req;
 	uint32_t turn;
 	union {
+		/* a6xx: */
 		struct {
 			uint16_t list_length;
 			uint16_t list_offset;
 		};
+		/* a7xx+: */
 		struct {
 			uint8_t ifpc_list_len;
 			uint8_t preemption_list_len;
 			uint16_t dynamic_list_len;
 		};
 	};
-	uint64_t regs[62];
+	uint64_t regs[];
 };
 
 /**
@@ -100,6 +102,13 @@ struct a6xx_gpu {
 	uint64_t pwrup_reglist_iova;
 	bool pwrup_reglist_emitted;
 
+	/*
+	 * Offset of start of SEL regs appended to pwrup_reglist.  This
+	 * is equal to lock->dynamic_list_len if no SEL regs are appended
+	 * to the end of the dynamic reglist.
+	 */
+	uint16_t dynamic_sel_reglist_offset;
+
 	bool has_whereami;
 
 	void __iomem *llc_mmio;
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index 6c040f718176..2ce7c6ac4521 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -468,6 +468,7 @@ static void a8xx_patch_pwrup_reglist(struct msm_gpu *gpu)
 	}
 
 	lock->dynamic_list_len = dyn_pwrup_reglist_count;
+	a6xx_gpu->dynamic_sel_reglist_offset = dyn_pwrup_reglist_count;
 
 done:
 	a8xx_aperture_clear(gpu);
-- 
2.53.0

