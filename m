Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA39606A321
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 20:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=G8iivUkC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b1+MVvP+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D32F9112529;
	Thu, 29 Oct 2026 20:18:18 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE6C711251C
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:54 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69TJjQ8d1656811
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4iyKi3o3dnw
 WyP2nsGvDx0M5Mc69Qkq1oajv+rbaqtQ=; b=G8iivUkCx6xckf4Xyk60u1iWitL
 ekjcCtUppagzPwHjVNmGFOB0uIrPGNy0yp4Yho3qhfmtKULr/DS2eE91q7dHR3EY
 554Sx3lQCS8CmjIm7BNEhtiBtnwh/DouP0u8trhbIfHB2qpp2pjPnu8vMTt8GuyN
 DiVGJmBK7PcmRMbGaVPc0BIwyH9euYLpNEySmGZn0hss2UJX4qnmbJXYlDQEgsD7
 oG7tZ4z6dGbfLTJwxY4rB6mu9PP23Khdgc0fVqNdvwAWKrdu1YluxhcPfPl+u8FK
 4ziTvtR8zbUNkhXiVU1JvHAhpey9Qzm+za4wsMak32npKcSUYAyeAmyCOTw==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hmaunhh7w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 20:17:53 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-8a0589ff620so1934496b3a.1
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 13:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793305073; x=1793909873;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4iyKi3o3dnwWyP2nsGvDx0M5Mc69Qkq1oajv+rbaqtQ=;
 b=b1+MVvP+g08cqPBco3lSVUm6BG/M7PKN55RLYun/P7o7r/4VjUN6L8B9zZN7tNNCtq
 10xmi0BrEJz0PVonW4N2mna4ROIcrVTtpOCwZ9LIuY8Um4Ekrr+8DZ3lfdkfzBg/l1NC
 44+acr/Ri3DaAdGWJjSOO2wO6MBFpabGhrIG6YSTu5kiemPF/cwN2p+TlPXxMhYSxh6C
 ++PjpAW7iQbTeM9G4DfIztyf6fssfkHBYM/oTZxl/pgZMzXPySNqXcdtdbrUP7v+eqlK
 HZOCMe7cSyx9NZWMfkh//1NAXoEuOe2W14vxNWZFfq2GlISFsJPuCoBPXLq+fc3dDqEj
 nIWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793305073; x=1793909873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4iyKi3o3dnwWyP2nsGvDx0M5Mc69Qkq1oajv+rbaqtQ=;
 b=fWg7CsGKJqU3Cni7Vd5YA7H0dxSwtPJmyC20bFZd1RjquIuSrSqPCRXhIirOlnUr88
 cnbhXPy8jgZ3F2I1AuLZqgaHZj6oC0tDOzCqHRH/HOFjyGq11LnDDDRjRGZSTaJvwfjA
 ArPKDmJhiJBJPNCmZlYX9y3odyKASXs6pTby2e19DunoBkD0kvfePUY579cGcpeuxCsT
 HSL/mTzVQQkmjqXpuqcmS1+RsR8T+chtuKeHYzttAWaTOc4rlJBkKzPidPZBefT2o04v
 E9AQZE/x3ab8UMH7aJcB+BMkzHlpvy6RkYkHh36gXACt4+YXN7RuhwnSbWT5V11C+/mg
 wVXw==
X-Gm-Message-State: AFq9FYLKmm/BW6OBVZFDjU8E38kN9xl2LeqmYpR+MpXkh0e7Zcl20e+x
 gN4TZGvjp0g+PCMmaC+XYgHVR+gAVOUaQVUPBMLPjEhCwetHfKazUyewf8IvKbdXaPT4+vV1QoK
 QfzjhC0aabCsWaq0gFJr83xoesl1WElgGYFV0iwSw0jAN0scA7g+2tGqSqjepFI7Kj9Zj6tkp7I
 KEVzE=
X-Gm-Gg: AYBFou00oE+rBIXgrOzdHhGoY8Asz8v2lL39mK9EAMPHLdKVIesclH7JIPpJY76+T/s
 GzXKyZWQwZE9MXqwrr81e75iNug7k1pbNdB6ZGW/xk20AFtz+NxYa39CO/b1TgLCiZDpVOIZVYA
 iTwJn6K+hGZSxt5riYvvzA6r2ZZnmJ5MZ7tyfAIEBJPtYKZlQGuTq95R/OOfrl3QHsDiZElH4Dh
 874MDnx+BhHVgOeSKTAHGk39vXMxd4Q7ML6zyY67iA8kJeq4lNjYkIoV/hUlh6+D/WGu12zNgaO
 5aouGdJkj+OvR9HgCPQcp3hO6rm4T2OGjGAdYEbigD4Wm62f7dDfS4HA3tKnbJA97Pu3dZXdo3h
 vU6YWM9qGRrJ0yDuWMKzZCrkE7Ce8GiGeNnW7+dGEgvvNdBCQwDeNfb8ah+lGYVInc1PKWcIiJt
 JcGSlaQYL0CPXlrs9CcMjyHw==
X-Received: by 2002:a05:6a00:988:b0:882:bba:8791 with SMTP id
 d2e1a72fcca58-8a9bf71bbd3mr188260b3a.34.1793305072779; 
 Thu, 29 Oct 2026 13:17:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:988:b0:882:bba:8791 with SMTP id
 d2e1a72fcca58-8a9bf71bbd3mr188235b3a.34.1793305072335; 
 Thu, 29 Oct 2026 13:17:52 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a989cd5250sm257570b3a.49.2026.10.29.13.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 13:17:51 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Alexander Koskovich <akoskovich@pm.me>,
 Jie Zhang <jie.zhang@oss.qualcomm.com>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Bhaskar Reddy Valluru <bvalluru@qti.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 03/16] drm/msm/a8xx: Add a8xx_aperture_acquire_raw()
Date: Thu, 29 Oct 2026 13:16:13 -0700
Message-ID: <20261029201730.151754-4-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
References: <20261029201730.151754-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 4nY45tocv47rKKT52jITVsu_7MV38Hdg
X-Proofpoint-GUID: 4nY45tocv47rKKT52jITVsu_7MV38Hdg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX+DW6U7iuG78d
 wxg+pEn9O3TEq2W5LCmAOsQGfGaZ8H8RK6ah9nE4OZxH+p8ZJ3/pPs8N0AWnzb7qQnQ+ECLMasf
 MRu14OW0fIXIB1KX57jbZbQ3rYjSYDDykBrohEZ98AGxjfpDOLogOsOeavvpK7dhJeztmCTBho4
 VdDE3QC4PmBNtqKAK5KttidAH7kD9WMi0kn5X3lYwiNa1oyeVDp99hdA0HlLpJuZ4dyRTVXbxyA
 AGlBTQGX2fffBioCTtfnvJCNJoWiTbviz9zXdLAOPqhFfKbqELBPxyVxSE1jfTn7mrTL6Amse2h
 d5bRD65bMZWllgaU98SlsiTq8TV/3Jnky0JinHCMVQRhSAetXl57F6nHS4G8CfBLr+ebBhABwYa
 5ysHgu0FGO4aACNF5qiibJKjnu5xKOTuTfC3kazHy5U7UQcgNTSBHZ8r28MZB07U33Wb/O53nvD
 uIiia529GakUp5E90Ug==
X-Authority-Analysis: v=2.4 cv=It2L47/g c=1 sm=1 tr=0 ts=6ae3a9f1 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=qGl0e74_xy6xiHm5yPkA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA3OSBTYWx0ZWRfX3+kF6XuYbCyO
 T/N54VUE8nNb1aO3OmT+MEWHuMohKbL5MpvvBVGC7gxT0+ynNYdccNdauA1voeTtRHDY/zDzrUZ
 muyutDVtNEx4Xzd3q4RWF4m2yP76cPc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 adultscore=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610290079
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The snapshot code will need more control, setting additional bitfields.
Rather than add a list of additional args, add a helper to acquire the
aperture which directly takes a reg value.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h |  1 +
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c | 21 +++++++++++++--------
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index fb000b79fe2f..2a2ddba6761f 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -348,6 +348,7 @@ void a6xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a6xx_flush_yield(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 int a6xx_zap_shader_init(struct msm_gpu *gpu);
 
+void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags);
 void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags);
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags);
 void a8xx_aperture_clear(struct msm_gpu *gpu);
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index a14379e26fbe..a0983e2ee641 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -16,13 +16,10 @@
 
 #define GPU_PAS_ID 13
 
-static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe, u32 slice)
+static void a8xx_aperture_slice_set(struct msm_gpu *gpu, u32 val)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-	u32 val;
-
-	val = A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) | A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice);
 
 	if (a6xx_gpu->cached_aperture == val)
 		return;
@@ -32,14 +29,20 @@ static void a8xx_aperture_slice_set(struct msm_gpu *gpu, enum adreno_pipe pipe,
 	a6xx_gpu->cached_aperture = val;
 }
 
-void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+void a8xx_aperture_acquire_raw(struct msm_gpu *gpu, u32 val, unsigned long *flags)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
 	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
 
 	spin_lock_irqsave(&a6xx_gpu->aperture_lock, *flags);
 
-	a8xx_aperture_slice_set(gpu, pipe, 0);
+	a8xx_aperture_slice_set(gpu, val);
+
+}
+
+void a8xx_aperture_acquire(struct msm_gpu *gpu, enum adreno_pipe pipe, unsigned long *flags)
+{
+	a8xx_aperture_acquire_raw(gpu, A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe), flags);
 }
 
 void a8xx_aperture_release(struct msm_gpu *gpu, unsigned long flags)
@@ -74,8 +77,10 @@ static u32 a8xx_read_pipe_slice(struct msm_gpu *gpu, enum adreno_pipe pipe, u32
 	unsigned long flags;
 	u32 val;
 
-	spin_lock_irqsave(&a6xx_gpu->aperture_lock, flags);
-	a8xx_aperture_slice_set(gpu, pipe, slice);
+	a8xx_aperture_acquire_raw(gpu,
+		A8XX_CP_APERTURE_CNTL_HOST_PIPEID(pipe) |
+		A8XX_CP_APERTURE_CNTL_HOST_SLICEID(slice),
+		&flags);
 	val = gpu_read(gpu, offset);
 	spin_unlock_irqrestore(&a6xx_gpu->aperture_lock, flags);
 
-- 
2.56.0

