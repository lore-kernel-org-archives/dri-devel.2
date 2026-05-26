Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 434B3CD5BC8
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 808C410E6D9;
	Tue, 26 May 2026 14:54:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNrBTtCl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G2hF022X";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AB9F10E6D1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:11 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsY812496664
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=FTzqvCJ4e/b
 0k11FoL9bAgllsh2Gh/B4rquYdI+KjCM=; b=KNrBTtClxs239+IrLK6flfCerlV
 NE2iYGPUvBHFC2aLGMbbJbRUFONQmcHMe7kbmfjiQeOVvJU5wbO5pidrBUuWLV94
 /S7xsqp3E+tOtix11AwhMsC6z7SztrAnutw6R9MxbVgLaG+JcSDgwMRz8PfLGrnh
 XPADLkSa/yJNWgGmESZd/tUk842FMzNAAE3Xq5FSqTfl7N2gKq80g5Awgehw/Ucz
 6sdAl6WjBnSTOTrmq6xDXW8a1uZgwo6hpRbJX9TcgzGZu8LpjnVU+g4LcGTzitvb
 q64nSkG0ezBIWILqB/FbYAAkh1n4RjvQUqApOlbw5W+HH4yITqDmNlFznRg==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecpyqmybk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:10 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c8531d89e59so1975682a12.0
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807250; x=1780412050;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FTzqvCJ4e/b0k11FoL9bAgllsh2Gh/B4rquYdI+KjCM=;
 b=G2hF022XgQYcD0Zol5Y9rmxALT/0dmKqmPwyOpLNHu9HYYmq8E8Iur1aQTh5Bz/unK
 oG4TPjFABtxLU6tFypW9XsYTfmoKB5zc+nx5T56iHtP08e2tkH1vrpDVOeAVKYW42Q4U
 2HRrdS4mIvBZROfUvbRxNVhsMDe+5s8UiYqWJi/FT8w+DYzFkttOmVpbKZXtKAQWqjtO
 VyJYAcZ1isrj6S4NujVyQpJ8/e4/tPNsVnZfK9V+nbbZwlQbVJ0r+V4N6+vkXyB765n3
 tAvdO5LRRm6YxhN/NaoLk5R3HBjFu2k7eUExn9PziKra2S2dHRmccsqPOaRSSnOw9dxk
 ix7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807250; x=1780412050;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FTzqvCJ4e/b0k11FoL9bAgllsh2Gh/B4rquYdI+KjCM=;
 b=Ng6z9dn/rNM7z9TO9wgdrczDwirgpdAg2Pe7bmTaUXpmYID2E0l/VZI7+e+zfozKH7
 /qc9BqbG6LnEBowKZC3gg/BqK2AdO8Zpnnhr2fq6YoKR21eF4AF1eubKGmxk+i+JNGic
 yxnsQmptGS/Nu8y9sEXLM5+4BwuWgUkjkjfKwOnIduL+7bhfR5ZlRLedpaYvaViKb19v
 T3r+vYI4qt3503LmD72Hg8SuACzhfgyUJTx66NWuXJj0iMcD+MRH5N+EGUhnqCQjHudJ
 3t0KdoCrnUYNAVLu3LPISSFg86QBpwpBei3YLIt3zAkPybNaOnFlHmk/1xb/jP5UzWIs
 16cA==
X-Gm-Message-State: AOJu0YxbItUHS52jHBa5M8K4ztwSUR8jqp9cD9uI2tx0HRRqlIQ7eYT8
 Tys47TUWHxergMT63WpYi4TeA2fYGV4fy/sRtMYUzA/h+AKucgzhEy865ET3gGGqk1N47WgSDz+
 gUK0k0DOrN3Ep6S2AsDepgX8wS4QfZoJ1dEdi0XJtwjTqpjQpzGNsUZBjtK5AH5WVZJNiggv29m
 RSjY8=
X-Gm-Gg: Acq92OE+JWoUEVFGch7z2dsG9rBsp/8+rYGMvhmVt05+UGEbH5sj8E90GmnJAUQSOGZ
 PO3AhaonEg87qV28WlKq3dZFBeEhwLXFTISWx7prNOSufm0pAlN/ds/mRnMzIbN6lV0o2OOnfM1
 lHM8BrJ22+yVvEXCg1JQgZMZRCFXJhp24mG2O3FDq8tibCLF7YxnlcouxRCngjO6aTAlaGZ0sst
 x6jhBDYSgGmT4tFMPrkum411q4BevgNdsr8mijYisVcS27ujNSHgyPeNpsJCwDXYfH5DCPCWZaj
 PzdDHE78BF7KTskcqevNAcMwZ+/nJlQVv72bTOdeVnHAvPAMVcg+gCMpJSTc0JR+CdpFX3z1zl7
 HuU0rMYcayCeaLadw7mSg7p+vgmFuqJ07
X-Received: by 2002:a05:6a00:6c83:b0:82c:9c90:6ea0 with SMTP id
 d2e1a72fcca58-84160b84f62mr13220139b3a.3.1779807249820; 
 Tue, 26 May 2026 07:54:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:6c83:b0:82c:9c90:6ea0 with SMTP id
 d2e1a72fcca58-84160b84f62mr13220100b3a.3.1779807249163; 
 Tue, 26 May 2026 07:54:09 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8419a140893sm6498627b3a.46.2026.05.26.07.54.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:08 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 06/16] drm/msm: Add a6xx+ perfcntr tables
Date: Tue, 26 May 2026 07:50:40 -0700
Message-ID: <20260526145137.160554-7-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dtfrzVg4 c=1 sm=1 tr=0 ts=6a15b412 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=tmZHKQuSfWdd6biKE2QA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-GUID: KVChIKRznmFSX8DqJ2AVJHTvvzub9OOF
X-Proofpoint-ORIG-GUID: KVChIKRznmFSX8DqJ2AVJHTvvzub9OOF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfXyntfAW0Qo6cS
 GVy5v1O4P/dLYcT1jE1QZboBnWDjfl668eMiMTejMHH0JFRG1MZ80q8SgcZ0xgQVJ8jxnXpYTQ2
 q7gGqdG88Eji6TkqbmMl0PgwLT6OZdgExOCE8tIXwhbDGbnYUtuWh2b5g8rG4ndrMt8Socr8qIH
 R4Fn5WQFr3fVN3420B04kyOOvJQnUASREvhqsIVGQtrXEP9NGrM+uddVNZwpgMeazqBVq/RL9o+
 TVURLPxr3cPdAi97kprOSE2BiBubHsyDHG4n/Avb2nV+gJGrn/LLr+p9zycDF6Y2fOTwk2k4DE8
 mVQP03E9a9afH3ZoA1D6cG87B48z+EkFU4NdlCsl9VrawhK00HLmX9NMXF4YJXNACEkpEc7GCPX
 8a6PoOKdyKA9pAenInADjz73t88K8gkdW3eMHkCjGPwCp3IHOfQav+P20rCCwtBt2fLkhqeG+k3
 c8z7KLu3TTImGI8D2Cg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605260127
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

Wire up the generated perfcntr tables for a6xx+.  The PERFCNTR_CONFIG
ioctl will use this information to assign counters.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c | 15 +++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h         |  4 ++++
 drivers/gpu/drm/msm/msm_perfcntr.h    |  9 +++++++++
 3 files changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index e578417a4949..727281fbef36 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -5,6 +5,7 @@
 #include "msm_gem.h"
 #include "msm_mmu.h"
 #include "msm_gpu_trace.h"
+#include "msm_perfcntr.h"
 #include "a6xx_gpu.h"
 #include "a6xx_gmu.xml.h"
 
@@ -2637,6 +2638,20 @@ static struct msm_gpu *a6xx_gpu_init(struct drm_device *dev)
 	adreno_gpu = &a6xx_gpu->base;
 	gpu = &adreno_gpu->base;
 
+	if ((ADRENO_6XX_GEN1 <= config->info->family) &&
+	    (config->info->family <= ADRENO_6XX_GEN4)) {
+		gpu->perfcntr_groups = a6xx_perfcntr_groups;
+		gpu->num_perfcntr_groups = a6xx_num_perfcntr_groups;
+	} else if ((ADRENO_7XX_GEN1 <= config->info->family) &&
+		   (config->info->family <= ADRENO_7XX_GEN3)) {
+		gpu->perfcntr_groups = a7xx_perfcntr_groups;
+		gpu->num_perfcntr_groups = a7xx_num_perfcntr_groups;
+	} else if ((ADRENO_8XX_GEN1 <= config->info->family) &&
+		   (config->info->family <= ADRENO_8XX_GEN2)) {
+		gpu->perfcntr_groups = a8xx_perfcntr_groups;
+		gpu->num_perfcntr_groups = a8xx_num_perfcntr_groups;
+	}
+
 	mutex_init(&a6xx_gpu->gmu.lock);
 	spin_lock_init(&a6xx_gpu->aperture_lock);
 
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 78e1478669be..8c08dc065372 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -24,6 +24,7 @@ struct msm_gem_submit;
 struct msm_gem_vm_log_entry;
 struct msm_gpu_state;
 struct msm_context;
+struct msm_perfcntr_group;
 
 struct msm_gpu_config {
 	const char *ioname;
@@ -262,6 +263,9 @@ struct msm_gpu {
 	bool allow_relocs;
 
 	struct thermal_cooling_device *cooling;
+
+	const struct msm_perfcntr_group *perfcntr_groups;
+	unsigned num_perfcntr_groups;
 };
 
 static inline struct msm_gpu *dev_to_gpu(struct device *dev)
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.h b/drivers/gpu/drm/msm/msm_perfcntr.h
index 75300bd69e80..8b0d627b2779 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.h
+++ b/drivers/gpu/drm/msm/msm_perfcntr.h
@@ -35,6 +35,15 @@ struct msm_perfcntr_group {
 	const struct msm_perfcntr_counter *counters;
 };
 
+extern const struct msm_perfcntr_group a6xx_perfcntr_groups[];
+extern const unsigned a6xx_num_perfcntr_groups;
+
+extern const struct msm_perfcntr_group a7xx_perfcntr_groups[];
+extern const unsigned a7xx_num_perfcntr_groups;
+
+extern const struct msm_perfcntr_group a8xx_perfcntr_groups[];
+extern const unsigned a8xx_num_perfcntr_groups;
+
 #define GROUP(_name, _pipe, _counters, _countables) {                          \
       .name = _name,                                                           \
       .pipe = _pipe,                                                           \
-- 
2.54.0

