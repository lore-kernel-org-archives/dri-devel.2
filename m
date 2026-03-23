Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1322F483F3
	for <dri-devel@archiver.kernel.org>; Mon, 23 Mar 2026 20:14:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3DD10E476;
	Mon, 23 Mar 2026 20:14:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="OznWtNKr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fQKOxXur";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3247510E440
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:02 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62NHqV5R943490
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7LQmunI4gQedz7r93OpyXpHZ3BB8yObf9HrBwMQos40=; b=OznWtNKruncN03KZ
 o3EWBPCUGMLrmAMWSgsDQuLzr6eq5z7XpdnLa76x+Lusm2UHXiSX/qV7WAKt0/d/
 dV5uyYk1fhVPnHtKJYdNp2HN1wmVnTmI+dZF0PF2yTeoqCnpbaiePB6Y/XwLo8vv
 Xfl0bmuu12MkWte12YBDkYRSL9fK/2cuKxM2OCTdNgttXtuzCw7xXtBONl0aKXDV
 tqNybogA/oxJpifItUVbqeYOfVFlAkJ7VdXE3GPlSLTZmEkb5gV6cpsoYyEa4cqZ
 ZLVNj4L9/zffRuCzCmlrMkrb8KNaAVw+I/OotzIkPJ+KQZ48Cqm5hvTUyjufi3S2
 z0dO5g==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d34vkss52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 20:14:01 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-82a11aeee8cso1714502b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Mar 2026 13:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774296840; x=1774901640;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=7LQmunI4gQedz7r93OpyXpHZ3BB8yObf9HrBwMQos40=;
 b=fQKOxXurcTVCCUyKejeVuvdr8Co662Sru0TacKERt0eqidekpaMuGyJjqAhkRtCIab
 SUfC8IQH+22FtQu05vzMEsAatop8q9tNrvxIAffTd+RW7da+YlGzLcvmOOMkeP5UBts6
 quADCTYJzGgll7uHIudXnvGTke+htkWWDNnTvIsMPZjuNge3UtcOqhqIbpu0ryUhpOsM
 udEn7pYlE6Ue9aE/CWN5qMRLLtF0i9wYEL9gcTWaQfYylq85Nehk0QiJRtRsapigqHC3
 q93awFVU+aXIQIl7QeiLHGHoPehnJCSJMs2ny3ACzA8Znvm7pC9k3YyF3dNyjOZYoHhN
 6reg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774296840; x=1774901640;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=7LQmunI4gQedz7r93OpyXpHZ3BB8yObf9HrBwMQos40=;
 b=PF1PIs+755Cv4SaYstdR1MhfDQjDZDGaISJ9EeEU60AJwtnhMvffsYUtIH3EKI2pVz
 i1iHSjyCqyRqFc0BisNh+veBYEi0M1DC1s/VhA2u3dv7o+Ng7ug4aCx4D3FHRtaoJmwS
 P8J1ekliH6YyktWWxausaEMsPPb9cE5t1OpOGa5dam83J9qPqYUJ5dcf0m1OmgTgvgWJ
 aLnBDP8tZJNqSv0bleTl+EOp7lOyeWR7PDzFgQNFNTf1XrHIh8XFJxdcE9VIRKFlt5MO
 qFVeVTdGn2HN94BjYR/agR1LLQwLiDAenqvEM285VHW3R/Lh9XzXflFUuqpAq3k5+Apa
 r4Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdn3fAXIo/DFcxmDjojY2A7moWtFtSgx09zlUbbklxo9BPtcTiDD8dYDvOJ2xOCOlES4EcOgrha+8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzZId0piYT534RcdY/d8mR1HcC4VUHSVfP/a69iREE1zoO4njUl
 4Jg9A/lhb6Fm1H1Xb4SwUk1F5PTInuS0wJ7rm02PuTwZLXIg/i6iBskG5RWZP5elD5vWAUp8+sw
 KLONUb7ls7z2XfPmVUSOAks/N92f3bBPZRG/22ooh8n8QbKre0OjCj02Kre0eAMIgXaA9naM=
X-Gm-Gg: ATEYQzwy9weEhgqyuBZkqkHdbLX6Sa07tHI63lKc65JknF8YZ0ER5x3oGCO/2lz1G9/
 SMUL0f9p9hJxU63cXr9dEQyqoW8MruImhAsGnwtuvKE0XSVWrJyVLEUsWFgwjzpnG6FiilHGSII
 kNqRtjqs5TANA6NhTnqftmWFkkebq989fbr6XHGaWp/HfZQj6CjOTKa3VUNBvjsRkSI/doTec3a
 Ln9Lc3H3Yk/cP3egIvO0pW7pHcfqrGEku9YK6PLWht7UReHWChXMGBRi6E7PM02oMHmDeEEiFW8
 CVuw8upzzKhKgdeAoXTwH+VwoYHjnIp2m9NcflU+3AchbgVqqVVz0Idc1aTOhBtvccLA3ZIZllx
 fkd4r6AyPDm6RUGIO1z8qqhIjRPYHAfPTFoxgFm6QDVzj3g==
X-Received: by 2002:a05:6a00:2d96:b0:829:7b0f:c9de with SMTP id
 d2e1a72fcca58-82a8c3217aemr10910284b3a.35.1774296839876; 
 Mon, 23 Mar 2026 13:13:59 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d96:b0:829:7b0f:c9de with SMTP id
 d2e1a72fcca58-82a8c3217aemr10910260b3a.35.1774296839280; 
 Mon, 23 Mar 2026 13:13:59 -0700 (PDT)
Received: from hu-akhilpo-hyd.qualcomm.com ([202.46.23.25])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82b0409d148sm9510738b3a.29.2026.03.23.13.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Mar 2026 13:13:58 -0700 (PDT)
From: Akhil P Oommen <akhilpo@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 01:42:26 +0530
Subject: [PATCH 14/16] drm/msm/a8xx: Preemption support for A840
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-a8xx-gpu-batch2-v1-14-fc95b8d9c017@oss.qualcomm.com>
References: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
In-Reply-To: <20260324-a8xx-gpu-batch2-v1-0-fc95b8d9c017@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Connor Abbott <cwabbott0@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774296753; l=20443;
 i=akhilpo@oss.qualcomm.com; s=20240726; h=from:subject:message-id;
 bh=FEe8R/rRX361Ss9+y/FT4W1Kn3g7sYPWTSDSorPhJG8=;
 b=EY82Vnw4rrZ6M0p7UwGnQZ03qMdmO9QvxLosP04+LZqtu2A+S/LYjtfj3oavmYyMH8btrHpvV
 A4/lxU4XP43CmPnNXurptT4xJsRon/a5wVzV7KAd/rbsVbks2DLAgIF
X-Developer-Key: i=akhilpo@oss.qualcomm.com; a=ed25519;
 pk=lmVtttSHmAUYFnJsQHX80IIRmYmXA4+CzpGcWOOsfKA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIzMDE0OSBTYWx0ZWRfX0E3fpT8dTrVd
 piUW4tR+nNpQ7OoK3fWBHVV8cuNMo6tatpzWttz8vR5jY7guuwMgnITDkH8CYUzt0+0teJJSzD7
 8VM/xV1hAw65e2OCr53/AhlUpc8Mv1KNqZls4Udo0/rIvhSwzKus8G8rFs2ksfxODC+fN3RT77n
 K7jTx6pWqmaL6kbOi0UpS0kZP2etYt5FZwr/DtpSwtSUwqXltqzDr8qZEqzcvCbtW+VANTEmXcK
 HOnjXAKXU3n7Uv7NOAmkDWb8RSRfpXS47vWFl3+6uuMP3uKtkx7QiTVI1C8N3gqFmaYxFmm1l9R
 81S6QS4aJbFQBFllkCQokkAn6yGte4wF06wPqQ5SKSuOGlaaA5L5ss4PKCcMmw8Zm8I1/KEAx9A
 22iPe1NKtUme1iLoqlbdtxdQMQl6AlKaiyqxm/WQm4AarURFcGHuEW1XtXRy2DcZSzsdqFDF7g5
 vROf1IKJdFbMiBqA+RA==
X-Authority-Analysis: v=2.4 cv=eMoeTXp1 c=1 sm=1 tr=0 ts=69c19f09 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=fmxdy_jVxe639krZ1D8A:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-GUID: S2Xqu6CFMZc1PPeuYwtb0ldSQQxa11d7
X-Proofpoint-ORIG-GUID: S2Xqu6CFMZc1PPeuYwtb0ldSQQxa11d7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-23_05,2026-03-23_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603230149
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

The programing sequence related to preemption is unchanged from A7x. But
there is some code churn due to register shuffling in A8x. So, split out
the common code into a header file for code sharing and add/update
additional changes required to support preemption feature on A8x GPUs.

Finally, enable the preemption quirk in A840's catalog to enable this
feature.

Signed-off-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile              |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_catalog.c |   1 +
 drivers/gpu/drm/msm/adreno/a6xx_gpu.c     |   7 +-
 drivers/gpu/drm/msm/adreno/a6xx_gpu.h     |   5 +
 drivers/gpu/drm/msm/adreno/a6xx_preempt.c |  77 +--------
 drivers/gpu/drm/msm/adreno/a6xx_preempt.h |  82 ++++++++++
 drivers/gpu/drm/msm/adreno/a8xx_gpu.c     |  37 ++++-
 drivers/gpu/drm/msm/adreno/a8xx_preempt.c | 262 ++++++++++++++++++++++++++++++
 8 files changed, 392 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 8b94c5f1cb68..ba45e99be05b 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -25,6 +25,7 @@ adreno-y := \
 	adreno/a6xx_hfi.o \
 	adreno/a6xx_preempt.o \
 	adreno/a8xx_gpu.o \
+	adreno/a8xx_preempt.o \
 
 adreno-$(CONFIG_DEBUG_FS) += adreno/a5xx_debugfs.o \
 
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
index 53548f6e891b..21f5a685196b 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_catalog.c
@@ -2120,6 +2120,7 @@ static const struct adreno_info a8xx_gpus[] = {
 		.inactive_period = DRM_MSM_INACTIVE_PERIOD,
 		.quirks = ADRENO_QUIRK_HAS_CACHED_COHERENT |
 			  ADRENO_QUIRK_HAS_HW_APRIV |
+			  ADRENO_QUIRK_PREEMPTION |
 			  ADRENO_QUIRK_IFPC,
 		.funcs = &a8xx_gpu_funcs,
 		.a6xx = &(const struct a6xx_info) {
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
index 0fe6d803e628..df739fd744ab 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.c
@@ -408,7 +408,7 @@ static void a6xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	a6xx_flush(gpu, ring);
 }
 
-static void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
+void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
 		struct a6xx_gpu *a6xx_gpu, struct msm_gpu_submitqueue *queue)
 {
 	u64 preempt_postamble;
@@ -618,7 +618,10 @@ static void a7xx_submit(struct msm_gpu *gpu, struct msm_gem_submit *submit)
 	a6xx_flush(gpu, ring);
 
 	/* Check to see if we need to start preemption */
-	a6xx_preempt_trigger(gpu);
+	if (adreno_is_a8xx(adreno_gpu))
+		a8xx_preempt_trigger(gpu);
+	else
+		a6xx_preempt_trigger(gpu);
 }
 
 static void a6xx_set_hwcg(struct msm_gpu *gpu, bool state)
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
index a4434a6a56dd..eb431e5e00b1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gpu.h
@@ -278,6 +278,8 @@ void a6xx_preempt_hw_init(struct msm_gpu *gpu);
 void a6xx_preempt_trigger(struct msm_gpu *gpu);
 void a6xx_preempt_irq(struct msm_gpu *gpu);
 void a6xx_preempt_fini(struct msm_gpu *gpu);
+void a6xx_emit_set_pseudo_reg(struct msm_ringbuffer *ring,
+		struct a6xx_gpu *a6xx_gpu, struct msm_gpu_submitqueue *queue);
 int a6xx_preempt_submitqueue_setup(struct msm_gpu *gpu,
 		struct msm_gpu_submitqueue *queue);
 void a6xx_preempt_submitqueue_close(struct msm_gpu *gpu,
@@ -327,6 +329,9 @@ void a8xx_gpu_get_slice_info(struct msm_gpu *gpu);
 int a8xx_hw_init(struct msm_gpu *gpu);
 irqreturn_t a8xx_irq(struct msm_gpu *gpu);
 void a8xx_llc_activate(struct a6xx_gpu *a6xx_gpu);
+void a8xx_preempt_hw_init(struct msm_gpu *gpu);
+void a8xx_preempt_trigger(struct msm_gpu *gpu);
+void a8xx_preempt_irq(struct msm_gpu *gpu);
 bool a8xx_progress(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 void a8xx_recover(struct msm_gpu *gpu);
 #endif /* __A6XX_GPU_H__ */
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
index 747a22afad9f..df4cbf42e9a4 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.c
@@ -6,85 +6,10 @@
 #include "msm_gem.h"
 #include "a6xx_gpu.h"
 #include "a6xx_gmu.xml.h"
+#include "a6xx_preempt.h"
 #include "msm_mmu.h"
 #include "msm_gpu_trace.h"
 
-/*
- * Try to transition the preemption state from old to new. Return
- * true on success or false if the original state wasn't 'old'
- */
-static inline bool try_preempt_state(struct a6xx_gpu *a6xx_gpu,
-		enum a6xx_preempt_state old, enum a6xx_preempt_state new)
-{
-	enum a6xx_preempt_state cur = atomic_cmpxchg(&a6xx_gpu->preempt_state,
-		old, new);
-
-	return (cur == old);
-}
-
-/*
- * Force the preemption state to the specified state.  This is used in cases
- * where the current state is known and won't change
- */
-static inline void set_preempt_state(struct a6xx_gpu *gpu,
-		enum a6xx_preempt_state new)
-{
-	/*
-	 * preempt_state may be read by other cores trying to trigger a
-	 * preemption or in the interrupt handler so barriers are needed
-	 * before...
-	 */
-	smp_mb__before_atomic();
-	atomic_set(&gpu->preempt_state, new);
-	/* ... and after*/
-	smp_mb__after_atomic();
-}
-
-/* Write the most recent wptr for the given ring into the hardware */
-static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_ringbuffer *ring)
-{
-	unsigned long flags;
-	uint32_t wptr;
-
-	spin_lock_irqsave(&ring->preempt_lock, flags);
-
-	if (ring->restore_wptr) {
-		wptr = get_wptr(ring);
-
-		a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
-
-		ring->restore_wptr = false;
-	}
-
-	spin_unlock_irqrestore(&ring->preempt_lock, flags);
-}
-
-/* Return the highest priority ringbuffer with something in it */
-static struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
-{
-	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
-	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
-
-	unsigned long flags;
-	int i;
-
-	for (i = 0; i < gpu->nr_rings; i++) {
-		bool empty;
-		struct msm_ringbuffer *ring = gpu->rb[i];
-
-		spin_lock_irqsave(&ring->preempt_lock, flags);
-		empty = (get_wptr(ring) == gpu->funcs->get_rptr(gpu, ring));
-		if (!empty && ring == a6xx_gpu->cur_ring)
-			empty = ring->memptrs->fence == a6xx_gpu->last_seqno[i];
-		spin_unlock_irqrestore(&ring->preempt_lock, flags);
-
-		if (!empty)
-			return ring;
-	}
-
-	return NULL;
-}
-
 static void a6xx_preempt_timer(struct timer_list *t)
 {
 	struct a6xx_gpu *a6xx_gpu = timer_container_of(a6xx_gpu, t,
diff --git a/drivers/gpu/drm/msm/adreno/a6xx_preempt.h b/drivers/gpu/drm/msm/adreno/a6xx_preempt.h
new file mode 100644
index 000000000000..4e69ed038403
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a6xx_preempt.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2018, The Linux Foundation. All rights reserved. */
+/* Copyright (c) 2023 Collabora, Ltd. */
+/* Copyright (c) 2024 Valve Corporation */
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+/*
+ * Try to transition the preemption state from old to new. Return
+ * true on success or false if the original state wasn't 'old'
+ */
+static inline bool try_preempt_state(struct a6xx_gpu *a6xx_gpu,
+		enum a6xx_preempt_state old, enum a6xx_preempt_state new)
+{
+	enum a6xx_preempt_state cur = atomic_cmpxchg(&a6xx_gpu->preempt_state,
+		old, new);
+
+	return (cur == old);
+}
+
+/*
+ * Force the preemption state to the specified state.  This is used in cases
+ * where the current state is known and won't change
+ */
+static inline void set_preempt_state(struct a6xx_gpu *gpu,
+		enum a6xx_preempt_state new)
+{
+	/*
+	 * preempt_state may be read by other cores trying to trigger a
+	 * preemption or in the interrupt handler so barriers are needed
+	 * before...
+	 */
+	smp_mb__before_atomic();
+	atomic_set(&gpu->preempt_state, new);
+	/* ... and after*/
+	smp_mb__after_atomic();
+}
+
+/* Write the most recent wptr for the given ring into the hardware */
+static inline void update_wptr(struct a6xx_gpu *a6xx_gpu, struct msm_ringbuffer *ring)
+{
+	unsigned long flags;
+	uint32_t wptr;
+
+	spin_lock_irqsave(&ring->preempt_lock, flags);
+
+	if (ring->restore_wptr) {
+		wptr = get_wptr(ring);
+
+		a6xx_fenced_write(a6xx_gpu, REG_A6XX_CP_RB_WPTR, wptr, BIT(0), false);
+
+		ring->restore_wptr = false;
+	}
+
+	spin_unlock_irqrestore(&ring->preempt_lock, flags);
+}
+
+/* Return the highest priority ringbuffer with something in it */
+static struct msm_ringbuffer *get_next_ring(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+
+	unsigned long flags;
+	int i;
+
+	for (i = 0; i < gpu->nr_rings; i++) {
+		bool empty;
+		struct msm_ringbuffer *ring = gpu->rb[i];
+
+		spin_lock_irqsave(&ring->preempt_lock, flags);
+		empty = (get_wptr(ring) == gpu->funcs->get_rptr(gpu, ring));
+		if (!empty && ring == a6xx_gpu->cur_ring)
+			empty = ring->memptrs->fence == a6xx_gpu->last_seqno[i];
+		spin_unlock_irqrestore(&ring->preempt_lock, flags);
+
+		if (!empty)
+			return ring;
+	}
+
+	return NULL;
+}
+
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
index b1784e0819c1..3ab4c1d79fdb 100644
--- a/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/a8xx_gpu.c
@@ -463,6 +463,34 @@ static void a8xx_patch_pwrup_reglist(struct msm_gpu *gpu)
 	a8xx_aperture_clear(gpu);
 }
 
+static int a8xx_preempt_start(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct msm_ringbuffer *ring = gpu->rb[0];
+
+	if (gpu->nr_rings <= 1)
+		return 0;
+
+	/* Turn CP protection off */
+	OUT_PKT7(ring, CP_SET_PROTECTED_MODE, 1);
+	OUT_RING(ring, 0);
+
+	a6xx_emit_set_pseudo_reg(ring, a6xx_gpu, NULL);
+
+	/* Yield the floor on command completion */
+	OUT_PKT7(ring, CP_CONTEXT_SWITCH_YIELD, 4);
+	OUT_RING(ring, 0x00);
+	OUT_RING(ring, 0x00);
+	OUT_RING(ring, 0x00);
+	/* Generate interrupt on preemption completion */
+	OUT_RING(ring, 0x00);
+
+	a6xx_flush(gpu, ring);
+
+	return a8xx_idle(gpu, ring) ? 0 : -EINVAL;
+}
+
 static int a8xx_cp_init(struct msm_gpu *gpu)
 {
 	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
@@ -738,6 +766,8 @@ static int hw_init(struct msm_gpu *gpu)
 	gpu_write64(gpu, REG_A6XX_CP_RB_RPTR_ADDR, shadowptr(a6xx_gpu, gpu->rb[0]));
 	gpu_write64(gpu, REG_A8XX_CP_RB_RPTR_ADDR_BV, rbmemptr(gpu->rb[0], bv_rptr));
 
+	a8xx_preempt_hw_init(gpu);
+
 	for (i = 0; i < gpu->nr_rings; i++)
 		a6xx_gpu->shadow[i] = 0;
 
@@ -800,6 +830,9 @@ static int hw_init(struct msm_gpu *gpu)
 	/* Enable hardware clockgating */
 	a8xx_set_hwcg(gpu, true);
 out:
+	/* Last step - yield the ringbuffer */
+	a8xx_preempt_start(gpu);
+
 	/*
 	 * Tell the GMU that we are done touching the GPU and it can start power
 	 * management
@@ -1209,11 +1242,11 @@ irqreturn_t a8xx_irq(struct msm_gpu *gpu)
 
 	if (status & A6XX_RBBM_INT_0_MASK_CP_CACHE_FLUSH_TS) {
 		msm_gpu_retire(gpu);
-		a6xx_preempt_trigger(gpu);
+		a8xx_preempt_trigger(gpu);
 	}
 
 	if (status & A6XX_RBBM_INT_0_MASK_CP_SW)
-		a6xx_preempt_irq(gpu);
+		a8xx_preempt_irq(gpu);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/msm/adreno/a8xx_preempt.c b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
new file mode 100644
index 000000000000..05cd847242f3
--- /dev/null
+++ b/drivers/gpu/drm/msm/adreno/a8xx_preempt.c
@@ -0,0 +1,262 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+#include "msm_gem.h"
+#include "a6xx_gpu.h"
+#include "a6xx_gmu.xml.h"
+#include "a6xx_preempt.h"
+#include "msm_mmu.h"
+#include "msm_gpu_trace.h"
+
+static void preempt_prepare_postamble(struct a6xx_gpu *a6xx_gpu)
+{
+	u32 *postamble = a6xx_gpu->preempt_postamble_ptr;
+	u32 count = 0;
+
+	postamble[count++] = PKT7(CP_REG_RMW, 3);
+	postamble[count++] = REG_A8XX_RBBM_PERFCTR_SRAM_INIT_CMD;
+	postamble[count++] = 0;
+	postamble[count++] = 1;
+
+	postamble[count++] = PKT7(CP_WAIT_REG_MEM, 6);
+	postamble[count++] = CP_WAIT_REG_MEM_0_FUNCTION(WRITE_EQ);
+	postamble[count++] = CP_WAIT_REG_MEM_POLL_ADDR_LO(
+				REG_A8XX_RBBM_PERFCTR_SRAM_INIT_STATUS);
+	postamble[count++] = CP_WAIT_REG_MEM_POLL_ADDR_HI(0);
+	postamble[count++] = CP_WAIT_REG_MEM_3_REF(0x1);
+	postamble[count++] = CP_WAIT_REG_MEM_4_MASK(0x1);
+	postamble[count++] = CP_WAIT_REG_MEM_5_DELAY_LOOP_CYCLES(0);
+
+	a6xx_gpu->preempt_postamble_len = count;
+
+	a6xx_gpu->postamble_enabled = true;
+}
+
+static void preempt_disable_postamble(struct a6xx_gpu *a6xx_gpu)
+{
+	u32 *postamble = a6xx_gpu->preempt_postamble_ptr;
+
+	/*
+	 * Disable the postamble by replacing the first packet header with a NOP
+	 * that covers the whole buffer.
+	 */
+	*postamble = PKT7(CP_NOP, (a6xx_gpu->preempt_postamble_len - 1));
+
+	a6xx_gpu->postamble_enabled = false;
+}
+
+/*
+ * Set preemption keepalive vote. Please note that this vote is different from the one used in
+ * a8xx_irq()
+ */
+static void a8xx_preempt_keepalive_vote(struct msm_gpu *gpu, bool on)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+
+	if (adreno_has_gmu_wrapper(adreno_gpu))
+		return;
+
+	gmu_write(&a6xx_gpu->gmu, REG_A8XX_GMU_PWR_COL_PREEMPT_KEEPALIVE, on);
+}
+
+void a8xx_preempt_irq(struct msm_gpu *gpu)
+{
+	uint32_t status;
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	struct drm_device *dev = gpu->dev;
+
+	if (!try_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED, PREEMPT_PENDING))
+		return;
+
+	/* Delete the preemption watchdog timer */
+	timer_delete(&a6xx_gpu->preempt_timer);
+
+	/*
+	 * The hardware should be setting the stop bit of CP_CONTEXT_SWITCH_CNTL
+	 * to zero before firing the interrupt, but there is a non zero chance
+	 * of a hardware condition or a software race that could set it again
+	 * before we have a chance to finish. If that happens, log and go for
+	 * recovery
+	 */
+	status = gpu_read(gpu, REG_A8XX_CP_CONTEXT_SWITCH_CNTL);
+	if (unlikely(status & A8XX_CP_CONTEXT_SWITCH_CNTL_STOP)) {
+		DRM_DEV_ERROR(&gpu->pdev->dev,
+					  "!!!!!!!!!!!!!!!! preemption faulted !!!!!!!!!!!!!! irq\n");
+		set_preempt_state(a6xx_gpu, PREEMPT_FAULTED);
+		dev_err(dev->dev, "%s: Preemption failed to complete\n",
+			gpu->name);
+		kthread_queue_work(gpu->worker, &gpu->recover_work);
+		return;
+	}
+
+	a6xx_gpu->cur_ring = a6xx_gpu->next_ring;
+	a6xx_gpu->next_ring = NULL;
+
+	set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
+
+	update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
+
+	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
+
+	a8xx_preempt_keepalive_vote(gpu, false);
+
+	trace_msm_gpu_preemption_irq(a6xx_gpu->cur_ring->id);
+
+	/*
+	 * Retrigger preemption to avoid a deadlock that might occur when preemption
+	 * is skipped due to it being already in flight when requested.
+	 */
+	a8xx_preempt_trigger(gpu);
+}
+
+void a8xx_preempt_hw_init(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	int i;
+
+	/* No preemption if we only have one ring */
+	if (gpu->nr_rings == 1)
+		return;
+
+	for (i = 0; i < gpu->nr_rings; i++) {
+		struct a6xx_preempt_record *record_ptr = a6xx_gpu->preempt[i];
+
+		record_ptr->wptr = 0;
+		record_ptr->rptr = 0;
+		record_ptr->rptr_addr = shadowptr(a6xx_gpu, gpu->rb[i]);
+		record_ptr->info = 0;
+		record_ptr->data = 0;
+		record_ptr->rbase = gpu->rb[i]->iova;
+	}
+
+	/* Write a 0 to signal that we aren't switching pagetables */
+	gpu_write64(gpu, REG_A8XX_CP_CONTEXT_SWITCH_SMMU_INFO, 0);
+
+	/* Enable the GMEM save/restore feature for preemption */
+	gpu_write(gpu, REG_A6XX_RB_CONTEXT_SWITCH_GMEM_SAVE_RESTORE_ENABLE, 0x1);
+
+	/* Reset the preemption state */
+	set_preempt_state(a6xx_gpu, PREEMPT_NONE);
+
+	spin_lock_init(&a6xx_gpu->eval_lock);
+
+	/* Always come up on rb 0 */
+	a6xx_gpu->cur_ring = gpu->rb[0];
+}
+
+void a8xx_preempt_trigger(struct msm_gpu *gpu)
+{
+	struct adreno_gpu *adreno_gpu = to_adreno_gpu(gpu);
+	struct a6xx_gpu *a6xx_gpu = to_a6xx_gpu(adreno_gpu);
+	unsigned long flags;
+	struct msm_ringbuffer *ring;
+	unsigned int cntl;
+	bool sysprof;
+
+	if (gpu->nr_rings == 1)
+		return;
+
+	/*
+	 * Lock to make sure another thread attempting preemption doesn't skip it
+	 * while we are still evaluating the next ring. This makes sure the other
+	 * thread does start preemption if we abort it and avoids a soft lock.
+	 */
+	spin_lock_irqsave(&a6xx_gpu->eval_lock, flags);
+
+	/*
+	 * Try to start preemption by moving from NONE to START. If
+	 * unsuccessful, a preemption is already in flight
+	 */
+	if (!try_preempt_state(a6xx_gpu, PREEMPT_NONE, PREEMPT_START)) {
+		spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
+		return;
+	}
+
+	cntl = A8XX_CP_CONTEXT_SWITCH_CNTL_LEVEL(a6xx_gpu->preempt_level);
+
+	if (a6xx_gpu->skip_save_restore)
+		cntl |= A8XX_CP_CONTEXT_SWITCH_CNTL_SKIP_SAVE_RESTORE;
+
+	if (a6xx_gpu->uses_gmem)
+		cntl |= A8XX_CP_CONTEXT_SWITCH_CNTL_USES_GMEM;
+
+	cntl |= A8XX_CP_CONTEXT_SWITCH_CNTL_STOP;
+
+	/* Get the next ring to preempt to */
+	ring = get_next_ring(gpu);
+
+	/*
+	 * If no ring is populated or the highest priority ring is the current
+	 * one do nothing except to update the wptr to the latest and greatest
+	 */
+	if (!ring || (a6xx_gpu->cur_ring == ring)) {
+		set_preempt_state(a6xx_gpu, PREEMPT_FINISH);
+		update_wptr(a6xx_gpu, a6xx_gpu->cur_ring);
+		set_preempt_state(a6xx_gpu, PREEMPT_NONE);
+		spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
+		return;
+	}
+
+	spin_unlock_irqrestore(&a6xx_gpu->eval_lock, flags);
+
+	spin_lock_irqsave(&ring->preempt_lock, flags);
+
+	struct a7xx_cp_smmu_info *smmu_info_ptr =
+		a6xx_gpu->preempt_smmu[ring->id];
+	struct a6xx_preempt_record *record_ptr = a6xx_gpu->preempt[ring->id];
+	u64 ttbr0 = ring->memptrs->ttbr0;
+	u32 context_idr = ring->memptrs->context_idr;
+
+	smmu_info_ptr->ttbr0 = ttbr0;
+	smmu_info_ptr->context_idr = context_idr;
+	record_ptr->wptr = get_wptr(ring);
+
+	/*
+	 * The GPU will write the wptr we set above when we preempt. Reset
+	 * restore_wptr to make sure that we don't write WPTR to the same
+	 * thing twice. It's still possible subsequent submissions will update
+	 * wptr again, in which case they will set the flag to true. This has
+	 * to be protected by the lock for setting the flag and updating wptr
+	 * to be atomic.
+	 */
+	ring->restore_wptr = false;
+
+	trace_msm_gpu_preemption_trigger(a6xx_gpu->cur_ring->id, ring->id);
+
+	spin_unlock_irqrestore(&ring->preempt_lock, flags);
+
+	/* Set the keepalive bit to keep the GPU ON until preemption is complete */
+	a8xx_preempt_keepalive_vote(gpu, true);
+
+	a6xx_fenced_write(a6xx_gpu,
+		REG_A8XX_CP_CONTEXT_SWITCH_SMMU_INFO, a6xx_gpu->preempt_smmu_iova[ring->id],
+		BIT(1), true);
+
+	a6xx_fenced_write(a6xx_gpu,
+		REG_A8XX_CP_CONTEXT_SWITCH_PRIV_NON_SECURE_RESTORE_ADDR,
+		a6xx_gpu->preempt_iova[ring->id], BIT(1), true);
+
+	a6xx_gpu->next_ring = ring;
+
+	/* Start a timer to catch a stuck preemption */
+	mod_timer(&a6xx_gpu->preempt_timer, jiffies + msecs_to_jiffies(10000));
+
+	/* Enable or disable postamble as needed */
+	sysprof = refcount_read(&a6xx_gpu->base.base.sysprof_active) > 1;
+
+	if (!sysprof && !a6xx_gpu->postamble_enabled)
+		preempt_prepare_postamble(a6xx_gpu);
+
+	if (sysprof && a6xx_gpu->postamble_enabled)
+		preempt_disable_postamble(a6xx_gpu);
+
+	/* Set the preemption state to triggered */
+	set_preempt_state(a6xx_gpu, PREEMPT_TRIGGERED);
+
+	/* Trigger the preemption */
+	a6xx_fenced_write(a6xx_gpu, REG_A8XX_CP_CONTEXT_SWITCH_CNTL, cntl, BIT(1), false);
+}
+

-- 
2.51.0

