Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3F33CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 13:01:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F33110E775;
	Mon, 11 May 2026 13:01:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Jn1yekCp";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="C+7NSEAY";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48EDF10E77A
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:26 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BBIToE1344461
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=ZFtTLmOQAzj
 qHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=; b=Jn1yekCpstrqz+ayP+8M7z8c/BS
 Q3Z5rFpJR+3tTpCkhmtleSEu3T1D08jVw6+3IDHyhMC0YZDzj11boH04xu2P1sbN
 D1UmonVNJ9kH2Gc4SaVRrsb63TMF7n1c9iQNGVydZj+hEwMT4l7GCPYxZEmlM5Jr
 rRAH9qTdIU/IhUKYzvuzvsDHtz7JJZu3r6jT9qYWaGUnkyc4aPVsE24taIF9D/SY
 Y8JZwcR5AECRi745OjV+XviR4YMzADuAeaH3W3auczopHXZZ9GGqJw0raX6XEf11
 /jzpUo2O2NQOhb1qeSh+zRfIAegJbgyuSaMLEcacAdJ/fU1Job7U5uNMnqQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3e498ae3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 13:01:20 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-36641bb3d97so2406464a91.3
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 06:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778504480; x=1779109280;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZFtTLmOQAzjqHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=;
 b=C+7NSEAYWW2d3oFosfDoyn8h21hwCQfk0WjIvQMju2tDwJWitnxgk7aZKD2agJwwpg
 7UPZ+5g+Cn+f7HlBshLq5MRC3JVknsQ9Dp0zallfY9q2/1PEKttlL9tFHACwfYxYirbx
 FYEAJ3gQ+Ih7cNlCK29lFuKyKS5o4P9pi1pzSgY87XgqURXwY/Q//Rkl2hXb2mZB4A19
 tyI9TPFPiGLJOLyUuO7mdQ1W4uGHlIVOViy8vzNIvRxrZbYUpfJ2dHFTvP8EbXfgFj86
 Stf5QtqZh8KQsuJccKRVb44+2+dtAm77kVH0M/16WAjn/IwEbVAx7fGQHDLaclOG9S6h
 VDEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778504480; x=1779109280;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZFtTLmOQAzjqHoC3Fafdx5s7yem/Cv9ClA1WpeTUDMw=;
 b=pOzRQ/mOrg/1+xWqkmHDgaYv3Cu+sYmd3Iaz5zIsca+AQemN0Q+7bp+YjsTE9FBxMY
 wEHZ9rUVt6bhbjGHrofiApZxBk5/DSkj2GOq/m5HwovpcrePSpZypq40J1gYWZ/Yn8wD
 CG5imJ6nOO1OJ/I5UfJW5zNlYvOWwoP7s/bfNA5sSTwI/aElHXWoxLmjdZKu/tqQTPKS
 GFUIqwJC+oSJTVrFGHxycs61QHMHz1Jvab9+OGe7sG157cflbUCBmJ2IpfjJUb18KqkN
 xEjayV22nHXv+NYZg4TykM8fr7Kv0teVLNBqckUGZawBAB5xDgixCJKK4b7P1axto+bD
 hgsg==
X-Gm-Message-State: AOJu0YyGdYTyXcVkKqDiANVN2LFmGfdJ9+KoIY8p+ZvwVo0/UkxybVyq
 Bx2YFYB/ovnrdAmWil2qNRkHGh5ZrTyCVl3ts+Nq7xmry9bXn/EQ6cF023kibCMy6TjAtIXfwsC
 TtJzSSZi2rpT5IytXaGhYOo08FRq+PoiMgUd5Wsrq4c+GYsleqgGkTjHwq4b9fkjzB53ss4mOkm
 AXXiI=
X-Gm-Gg: Acq92OHxKYMQS9k0ZmdbNUrzX0ZUUBxfFFuasgY6mRZdPax8wvHLnaUdAwqhXFir1xh
 2ZSG9D+uhgNaOXq//rKR9rBJm9hnoYiiS5y3CCuyMNfwCT8bEpNG5i4ojp4g7Wa74g8spP3p7dL
 N4ei/bvN5qV4pN11xPk5tVFuL0yhjzS1nrr56j4cQvKMSsd5GxMdRR6yH4yJZIQLmAhBlDwh4xI
 EMkvbGsajIG3cL0DM7Y+vs9lBA2X/vq6ZFdEigLz3F14kseU2nKY1arCK83hxECtIp6QEKEgsef
 Ia4ygag2xOKWva7aLrRITv4sb5nosF5jElca2mI3dBwPzGu9Jrz2xhnBxCv0goZxGcpduO505Xg
 F6QyqgwFLP1ZwIzBEPV9ufmqsfCOAWSNy
X-Received: by 2002:a17:90b:3c0a:b0:367:b9ed:dec4 with SMTP id
 98e67ed59e1d1-367d4a171c0mr10379139a91.27.1778504479512; 
 Mon, 11 May 2026 06:01:19 -0700 (PDT)
X-Received: by 2002:a17:90b:3c0a:b0:367:b9ed:dec4 with SMTP id
 98e67ed59e1d1-367d4a171c0mr10379049a91.27.1778504478897; 
 Mon, 11 May 2026 06:01:18 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-367d625ee39sm8246435a91.4.2026.05.11.06.01.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 06:01:18 -0700 (PDT)
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
Subject: [PATCH v5 08/16] drm/msm/a6xx: Add yield & flush helper
Date: Mon, 11 May 2026 05:59:21 -0700
Message-ID: <20260511130017.96867-9-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
References: <20260511130017.96867-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pm01pWi_cJQT22X-it5WbQL7vaoQZr_W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE0NCBTYWx0ZWRfX/JftRX4kaDY0
 tzSRNKWptk0d2sXcD+7qHvosnEHatuxyCweCLFkyyB92hzrXO0WmDHQR/e3Jh+7GICmOR56Ybui
 bva0Way4D501qf8gD/4gyctbPEBUcOJKjXMMeGCvuw2cU3CWNT6zDyzcDLu6FgpZU3K5QmIrJqY
 qxFfMuJJxh6T0nwU+T93Xe1a/BvguBzACCXA8uh7CBqutB7F0WLlppDG10whwPughEASOYzcM3V
 AziDB2FRaQblkPkKLIYePfvCNM3sakrsIDh8QSEaRkZXj+47KH/VYZS68M80B83hXecgLz4Vj/B
 Q2aOeZubXY/t2tgAJOrz4MgenI1d4DFmUYonaSmfgOJ+l4978N4zDLfm70WPkPjWqb/7jljSVs/
 x3eDXpc8rsxIV3yTCVG6yuOqOXh95Q==
X-Proofpoint-ORIG-GUID: pm01pWi_cJQT22X-it5WbQL7vaoQZr_W
X-Authority-Analysis: v=2.4 cv=Yr0/gYYX c=1 sm=1 tr=0 ts=6a01d320 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=7a4_7rcHm0II5uOVc2AA:9
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 suspectscore=0 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605110144
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

It's a common pattern, needing to insert a yield packet before flushing
the rb.  And we'll need this once again for configuring perfcntr SEL
regs.  So add a helper.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 55 +++++++++++++--------------
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 10 +----
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 71f54ab5425d..415902f6e5d7 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -189,6 +189,30 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
 	spin_unlock_irqrestore(&ring->preempt_lock, flags);
 }
 
+void
+a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
+{
+	/* If preemption is enabled */
+	if (gpu->nr_rings > 1) {
+		/* Yield the floor on command completion */
+		OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
+
+		/*
+		 * If dword[2:1] are non zero, they specify an address for
+		 * the CP to write the value of dword[3] to on preemption
+		 * complete. Write 0 to skip the write
+		 */
+		OUT_RING(ring, 0x00);
+		OUT_RING(ring, 0x00);
+		/* Data value - not used if the address above is 0 */
+		OUT_RING(ring, 0x01);
+		/* generate interrupt on preemption completion */
+		OUT_RING(ring, 0x00);
+	}
+
+	a6xx_flush(gpu, ring);
+}
+
 static void get_stats_counter(struct msm_ringbuffer *ring, u32 counter,
 		u64 iova)
 {
@@ -597,28 +621,9 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	OUT_PKT7(ring, CP_SET_MARKER, 1);
 	OUT_RING(ring, 0x100); /* IFPC enable */
 
-	/* If preemption is enabled */
-	if (gpu->nr_rings > 1) {
-		/* Yield the floor on command completion */
-		OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-
-		/*
-		 * If dword[2:1] are non zero, they specify an address for
-		 * the CP to write the value of dword[3] to on preemption
-		 * complete. Write 0 to skip the write
-		 */
-		OUT_RING(ring, 0x00);
-		OUT_RING(ring, 0x00);
-		/* Data value - not used if the address above is 0 */
-		OUT_RING(ring, 0x01);
-		/* generate interrupt on preemption completion */
-		OUT_RING(ring, 0x00);
-	}
-
-
 	trace_msm_gpu_submit_flush(submit, adreno_gpu->funcs->get_timestamp(gpu));
 
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	/* Check to see if we need to start preemption */
 	if (adreno_is_a8xx(adreno_gpu))
@@ -958,15 +963,7 @@ static int a7xx_preempt_start(struct msm_gpu *gpu)
 
 	a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, NULL);
 
-	/* Yield the floor on command completion */
-	OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	/* Generate interrupt on preemption completion */
-	OUT_RING(ring, 0x00);
-
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	return a6xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index eb431e5e00b1..99c3e55f5ca8 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -317,6 +317,7 @@ void a6xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_
 void a6xx_gpu_sw_reset(struct msm_gpu *gpu, bool assert);
 int a6xx_fenced_write(struct a6xx_gpu *gpu, u32 offset, u64 value, u32 mask, bool is_64b);
 void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
+void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
 void a8xx_bus_clear_pending_transactions(struct adreno_gpu *adreno_gpu, bool gx_off);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index e022c9a162a4..124d315b2469 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -488,15 +488,7 @@ static int a8xx_preempt_start(struct msm_gpu *gpu)
 
 	a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, NULL);
 
-	/* Yield the floor on command completion */
-	OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	OUT_RING(ring, 0x00);
-	/* Generate interrupt on preemption completion */
-	OUT_RING(ring, 0x00);
-
-	a6xx_flush(gpu, ring);
+	a6xx_flush_yield(gpu, ring);
 
 	return a8xx_idle(gpu, ring) ? 0 : -EINVAL;
 }
-- 
2.54.0

