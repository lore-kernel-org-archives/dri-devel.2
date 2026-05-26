Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC586CD6E40
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 14:54:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7778210E6AC;
	Tue, 26 May 2026 14:54:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="eNB8AWpr";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YMOMN7+U";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5CE410E6EB
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:18 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64QCsPbf2697737
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DmhVpNTPhIM
 S2CcisqTaU/pDxPHB4cvxd4lOGrQ1ShE=; b=eNB8AWprf8/7J7pWpA3KBijrkmk
 Sw5fCuJnor17xmeyy09PDEni3zmj5uD0X9Ld/MsJNFeOkkRk6gLsr5lm4LKiWjD4
 70K+eYvFr22O9QZ3HMRX2sBsrGt6fs+RbGvi0nTJPYJFcmGojEzzQK0e+FQ60h76
 lqS39+t5TNI5LRtEo7pduudrh87Xu8BK74ldtX8Ar4FL9szFvcf+Iso81RLEn+8O
 6MarBTnwz1K8NelsDZ/ReLDuY6LQOPdauvZ2Nwb0li+Mvni03L+PzeltSbTMRh/k
 KYh6ydVWABRh8Elvsp8AzkiukOQRhbeENENnIMvU0kZqW4Ku4v5hvdDqcnA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ecsm04d2b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 14:54:18 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-82fa1c94b37so10676217b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779807257; x=1780412057;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DmhVpNTPhIMS2CcisqTaU/pDxPHB4cvxd4lOGrQ1ShE=;
 b=YMOMN7+Uue1ubd4xYTqXpiaEGX+bpkw0zqjTOTycwOCOqkItTDyPfi6Mz6z8U/qBoK
 3SWl52bLjVVfu/eKW8Cvq0o/KxNpcDyhthv+SN+Jwrkyt7dVULiSrOpKDstyE1oo8LUB
 Et4S+VIkxkrDK+Oqu1x7U1G5BOenQLLKFg72QJO+TUvinGld3R4jn1vGFRV/2Kg3701L
 Lx9JeXumaup9Kqs15Tk5X+JFu+Ew/v6WuwZd9lhCEqIZn0jNu1WBI2In7dW/buyN3h57
 g89ZII4Sqw8JgrWcH5xxPNz1ZTvqn9c45kwEZOgiQvz7S0JSaHhNIFryF/GsYofIAKCN
 ypoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779807257; x=1780412057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DmhVpNTPhIMS2CcisqTaU/pDxPHB4cvxd4lOGrQ1ShE=;
 b=qH2MuVUfB9ZGsn+xQqtrn7zPi4OzqeClW5QmTOfxYGsuVmfEL8rOp+Du6Gt9B17evC
 oNqzEkNcdkuDKMZuw3+VNBU/4RNgORml/La/lv5qrop9MndUOZdwiw9xF99Za5s8S7bW
 VuKNcFBMgBOxnugwX2BRzgPGDDROwJsIG5NEKKP3rI0i7Ubb6635N/csPq73JzUAQXGo
 lQdEZHyKqiEXm6ynRbeWpOObGJ1rcNrch4O6PsPgFI+AX1G9xWA0lY6yPEaVG9QOLv/3
 Wof65KtS5IIApPIq89mhbXgdicWaWNHXpulSzkjaS7NYvCPcGtiRtrnkM8709bxovgtt
 zZrQ==
X-Gm-Message-State: AOJu0YxLGTNxC1u7KcWA38k5PywtfarFE7FiYpK0JM6gufbVSrvFu+Es
 musqN7sVO6TyCdZVaUEbXMlKw9+T9/99DUcaVUj4uV/iDor98Gej1/DgEWCd/K6KmsJ4u12dig6
 zsBpr6Bybzitt00crrZUxg5YCjPdA9nksDwLBR88OGz2G/Wzuqj7cYUdfeFq4YwyGkHgccm7Y3v
 hvitE=
X-Gm-Gg: Acq92OHUa62cZYA32DUX5bbIsQ6qp+OUo50T58AC5pItx5F6M26doC6Tnjdierjegmx
 igEufvwz3gNAiv1JquPqNYjUOKkvL/edk6uisH1nulYUFeeou27YLyADhnMEh/v0jMQsQwGMOIf
 IirS4T1+Ut25UlbRb8hBB4o8huGCLtJCPlzX5vt6Qlvg8po2jpn9omBwcV9IR7PHtAuUVBK+l6D
 nWnB3piK8G9U4+s23NfBUe7e7lkeqWJy9eLRZ9/5A0oLPDhurz2VyDOqZTFZZAAuX0Pv7YysTwF
 5LCw8EknopHDneIwtQCvNCIRJzThR8caflvscdpH3vu+law9Fzggr36izhAhv7r5G+E/TlWHvvl
 FQSLf0tmTgXt89m3YLaEhCpTwKnMJ/j8v
X-Received: by 2002:a05:6a00:8f0a:b0:827:2792:e401 with SMTP id
 d2e1a72fcca58-8414b43c999mr16549830b3a.15.1779807257192; 
 Tue, 26 May 2026 07:54:17 -0700 (PDT)
X-Received: by 2002:a05:6a00:8f0a:b0:827:2792:e401 with SMTP id
 d2e1a72fcca58-8414b43c999mr16549790b3a.15.1779807256362; 
 Tue, 26 May 2026 07:54:16 -0700 (PDT)
Received: from localhost ([2601:1c0:5000:d5c:4ec8:83f5:8254:6891])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84164ac9c77sm14180479b3a.2.2026.05.26.07.54.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 07:54:15 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Anna Maniscalco <anna.maniscalco2000@gmail.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v10 10/16] drm/msm: Add basic perfcntr infrastructure
Date: Tue, 26 May 2026 07:50:44 -0700
Message-ID: <20260526145137.160554-11-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
References: <20260526145137.160554-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=CLEamxrD c=1 sm=1 tr=0 ts=6a15b41a cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=xqWC_Br6kY4A:10 a=NGcC8JguVDcA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8
 a=hddbS_E73Iye693R-v0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-GUID: pSsGplz_JaRX1RicdnztdI_lLnVAEy1_
X-Proofpoint-ORIG-GUID: pSsGplz_JaRX1RicdnztdI_lLnVAEy1_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI2MDEyNyBTYWx0ZWRfX4/Z3dt9ytPXP
 mDgWMjHNU+7cwXxcJicFBsps70JA1zfbQe0AVT/mrNsFKBHq6/JnwoqYzg1HdPvltw5A6qq7pVX
 P6t+UFefU7TykvaLK6GV36I+HBv00aHNXDbFIQbuwt1IyDCOVCn83phoHGEXBvTzdwe7GRIb+c7
 QMOU0V1Am62c/v+DV5vmcwm2KR9PB5XwgnSK3JocTIhZrRj6eG7+7dE0YFG6UunPptWnFnYJ7Oo
 hIbZkcdqhwMMQ2zUHIq1E1QI9KwlyyHvJ5jseRfMnrb8+uDnIIApqzG8S3/JtzlMoNEKSBApxRq
 av+xPhk3wZ9EmyiosACO1qUfTn9dUjRhRyAjCuUfC2u/kzm/6dweDAm4wD/xC3ugChVU68fY7WN
 7i/vvq7o8IEBsmzK+KqtvieWXXL4rRVLR0CD32ycuOLCsKaVRFi4XkVn3xfnDrb8Orexo8IkS9n
 3h23+z0U4nQ2UXmdGPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-26_03,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 phishscore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1015
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

Add the basic infrastructure for tracking assigned perfcntrs.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
Reviewed-by: Anna Maniscalco <anna.maniscalco2000@gmail.com>
Reviewed-by: Akhil P Oommen <akhilpo@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile               |   1 +
 drivers/gpu/drm/msm/adreno/adreno_device.c |   8 +-
 drivers/gpu/drm/msm/adreno/adreno_gpu.c    |   5 +-
 drivers/gpu/drm/msm/msm_drv.h              |   6 +
 drivers/gpu/drm/msm/msm_gpu.c              |  12 ++
 drivers/gpu/drm/msm/msm_gpu.h              |  57 ++++++++-
 drivers/gpu/drm/msm/msm_perfcntr.c         | 133 +++++++++++++++++++++
 drivers/gpu/drm/msm/msm_perfcntr.h         |  23 ++++
 8 files changed, 239 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/msm/msm_perfcntr.c

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 337634e7e247..2466cb32dac5 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -122,6 +122,7 @@ msm-y += \
 	msm_gpu_devfreq.o \
 	msm_io_utils.o \
 	msm_iommu.o \
+	msm_perfcntr.o \
 	msm_rd.o \
 	msm_ringbuffer.o \
 	msm_submitqueue.o \
diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
index fc38331ce640..7f20320ef66a 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_device.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
@@ -307,8 +307,10 @@ MODULE_DEVICE_TABLE(of, dt_match);
 static int adreno_runtime_resume(struct device *dev)
 {
 	struct msm_gpu *gpu = dev_to_gpu(dev);
-
-	return gpu->funcs->pm_resume(gpu);
+	int ret = gpu->funcs->pm_resume(gpu);
+	if (!ret)
+		ret = msm_perfcntr_resume(gpu);
+	return ret;
 }
 
 static int adreno_runtime_suspend(struct device *dev)
@@ -322,6 +324,8 @@ static int adreno_runtime_suspend(struct device *dev)
 	 */
 	WARN_ON_ONCE(gpu->active_submits);
 
+	msm_perfcntr_suspend(gpu);
+
 	return gpu->funcs->pm_suspend(gpu);
 }
 
diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index 72b71e9e44f0..ee0bcf985934 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -702,11 +702,10 @@ void adreno_recover(struct msm_gpu *gpu)
 	struct drm_device *dev = gpu->dev;
 	int ret;
 
-	// XXX pm-runtime??  we *need* the device to be off after this
-	// so maybe continuing to call ->pm_suspend/resume() is better?
-
+	msm_perfcntr_suspend(gpu);
 	gpu->funcs->pm_suspend(gpu);
 	gpu->funcs->pm_resume(gpu);
+	msm_perfcntr_resume(gpu);
 
 	ret = msm_gpu_hw_init(gpu);
 	if (ret) {
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index e53e4f220bed..f00b2e7aeb91 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -235,6 +235,12 @@ int msm_ioctl_gem_submit(struct drm_device *dev, void *data,
 int msm_ioctl_vm_bind(struct drm_device *dev, void *data,
 		      struct drm_file *file);
 
+int msm_perfcntr_resume(struct msm_gpu *gpu);
+void msm_perfcntr_suspend(struct msm_gpu *gpu);
+
+struct msm_perfcntr_state * msm_perfcntr_init(struct msm_gpu *gpu);
+void msm_perfcntr_cleanup(struct msm_gpu *gpu);
+
 #ifdef CONFIG_DEBUG_FS
 unsigned long msm_gem_shrinker_shrink(struct drm_device *dev, unsigned long nr_to_scan);
 #endif
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 1bac70473f80..bf6845e5719e 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -1028,6 +1028,17 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	refcount_set(&gpu->sysprof_active, 1);
 
+	mutex_init(&gpu->perfcntr_lock);
+
+	if (gpu->num_perfcntr_groups > 0) {
+		gpu->perfcntrs = msm_perfcntr_init(gpu);
+		if (IS_ERR(gpu->perfcntrs)) {
+			ret = PTR_ERR(gpu->perfcntrs);
+			gpu->perfcntrs = NULL;
+			goto fail;
+		}
+	}
+
 	return 0;
 
 fail:
@@ -1066,6 +1077,7 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 	}
 
 	msm_devfreq_cleanup(gpu);
+	msm_perfcntr_cleanup(gpu);
 
 	platform_set_drvdata(gpu->pdev, NULL);
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index 19484774f369..dc2eaada18cb 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -25,6 +25,7 @@ struct msm_gem_vm_log_entry;
 struct msm_gpu_state;
 struct msm_context;
 struct msm_perfcntr_group;
+struct msm_perfcntr_stream;
 
 struct msm_gpu_config {
 	const char *ioname;
@@ -93,6 +94,13 @@ struct msm_gpu_funcs {
 	 */
 	bool (*progress)(struct msm_gpu *gpu, struct msm_ringbuffer *ring);
 	void (*sysprof_setup)(struct msm_gpu *gpu);
+
+	/* Configure perfcntr SELect regs: */
+	void (*perfcntr_configure)(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
+				   const struct msm_perfcntr_stream *stream);
+
+	/* Flush perfcntrs before reading (optional): */
+	void (*perfcntr_flush)(struct msm_gpu *gpu);
 };
 
 /* Additional state for iommu faults: */
@@ -266,6 +274,11 @@ struct msm_gpu {
 
 	const struct msm_perfcntr_group *perfcntr_groups;
 	unsigned num_perfcntr_groups;
+
+	struct msm_perfcntr_state *perfcntrs;
+
+	/** @perfcntr_lock: protects perfcntr related state */
+	struct mutex perfcntr_lock;
 };
 
 static inline struct msm_gpu *dev_to_gpu(struct device *dev)
@@ -311,10 +324,52 @@ static inline bool msm_gpu_active(struct msm_gpu *gpu)
 	return false;
 }
 
+/**
+ * struct msm_perfcntr_group_state - Tracking for the currently allocated counter state
+ */
+struct msm_perfcntr_group_state {
+	/**
+	 * @allocated_counters:
+	 *
+	 * allocated counters for global counter collection.  The
+	 * corresponding counters are allocated from highest to
+	 * lowest, to minimize chance of conflict with old userspace
+	 * allocating from lowest to highest.
+	 */
+	unsigned allocated_counters;
+
+	/**
+	 * @countables:
+	 *
+	 * The corresponding SELect reg values for the allocated counters
+	 */
+	uint32_t countables[];
+};
+
+/**
+ * struct msm_perfcntr_state - overall global perfcntr state
+ */
+struct msm_perfcntr_state {
+	/** @stream: current global counter stream if active */
+	struct msm_perfcntr_stream *stream;
+
+	/**
+	 * @groups: Global perfcntr stream group state.
+	 *
+	 * Conceptually this is part of msm_perfcntr_stream state, but is
+	 * statically pre-allocated when the gpu is initialized to simplify
+	 * error path cleanup in PERFCNTR_CONFIG ioctl.  (__free(kfree)
+	 * doesn't really help with variable length arrays of allocated
+	 * pointers.)
+	 */
+	struct msm_perfcntr_group_state *groups[];
+};
+
 static inline bool
 msm_gpu_sysprof_no_perfcntr_zap(struct msm_gpu *gpu)
 {
-	return refcount_read(&gpu->sysprof_active) > 1;
+	return (refcount_read(&gpu->sysprof_active) > 1) ||
+		(gpu->perfcntrs && READ_ONCE(gpu->perfcntrs->stream));
 }
 
 static inline bool
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.c b/drivers/gpu/drm/msm/msm_perfcntr.c
new file mode 100644
index 000000000000..aeea60cd002e
--- /dev/null
+++ b/drivers/gpu/drm/msm/msm_perfcntr.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#include "msm_drv.h"
+#include "msm_gpu.h"
+#include "msm_perfcntr.h"
+
+static int
+msm_perfcntr_resume_locked(struct msm_perfcntr_stream *stream)
+{
+	return 0;
+}
+
+int
+msm_perfcntr_resume(struct msm_gpu *gpu)
+{
+	if (!gpu->perfcntrs)
+		return 0;
+	guard(mutex)(&gpu->perfcntr_lock);
+	return msm_perfcntr_resume_locked(gpu->perfcntrs->stream);
+}
+
+static void
+msm_perfcntr_suspend_locked(struct msm_perfcntr_stream *stream)
+{
+}
+
+void
+msm_perfcntr_suspend(struct msm_gpu *gpu)
+{
+	if (!gpu->perfcntrs)
+		return;
+	guard(mutex)(&gpu->perfcntr_lock);
+	msm_perfcntr_suspend_locked(gpu->perfcntrs->stream);
+}
+
+/**
+ * msm_perfcntr_group_idx - map idx of perfcntr group to group_idx
+ * @stream: The global perfcntr stream
+ * @n: The requested group_idx
+ *
+ * The PERFCNTR_CONFIG ioctl requested N counters/countables per perfcntr
+ * group, but the order of groups is not required to match the order they
+ * are defined in the perfcntr tables (which is not stable/UABI, only the
+ * group names are UABI).
+ *
+ * But the order samples are returned in the stream should match the
+ * order they are requested in the PERFCNTR_CONFIG ioctl.  This helper
+ * handles the order remapping.
+ *
+ * Returns an index into gpu->perfcntr_groups[] and perfcntrs->groups[].
+ */
+uint32_t
+msm_perfcntr_group_idx(const struct msm_perfcntr_stream *stream, uint32_t n)
+{
+	WARN_ON_ONCE(n >= stream->nr_groups);
+	return stream->group_idx[n];
+}
+
+/**
+ * msm_perfcntr_counter_base - get idx of the first counter in group
+ * @stream: The global perfcntr stream
+ * @group_idx: the index of the counter group
+ *
+ * For global counter collection, counters are allocated from the end
+ * (last counter) while UMD allocates them from the start (0..N-1).
+ * Since UMD always allocated them from the start this also minimizes
+ * the chance of conflict when using old UMD which predates
+ * PERFCNTR_CONFIG ioctl.
+ *
+ * Returns the index of first counter to use.  An index into
+ * msm_perfcntr_group::counters[].
+ */
+uint32_t
+msm_perfcntr_counter_base(const struct msm_perfcntr_stream *stream, uint32_t group_idx)
+{
+	struct msm_gpu *gpu = stream->gpu;
+	struct msm_perfcntr_state *perfcntrs = gpu->perfcntrs;
+	unsigned num_counters = gpu->perfcntr_groups[group_idx].num_counters;
+	unsigned allocated_counters = perfcntrs->groups[group_idx]->allocated_counters;
+
+	return num_counters - allocated_counters;
+}
+
+static void
+__msm_perfcntr_cleanup(struct msm_gpu *gpu, struct msm_perfcntr_state *perfcntrs)
+{
+	struct device *dev = &gpu->pdev->dev;
+
+	for (unsigned i = 0; i < gpu->num_perfcntr_groups; i++)
+		devm_kfree(dev, perfcntrs->groups[i]);
+
+	devm_kfree(dev, perfcntrs);
+}
+
+void
+msm_perfcntr_cleanup(struct msm_gpu *gpu)
+{
+	if (!gpu->perfcntrs)
+		return;
+
+	__msm_perfcntr_cleanup(gpu, gpu->perfcntrs);
+	gpu->perfcntrs = NULL;
+}
+
+struct msm_perfcntr_state *
+msm_perfcntr_init(struct msm_gpu *gpu)
+{
+	struct msm_perfcntr_state *perfcntrs;
+	struct device *dev = &gpu->pdev->dev;
+	size_t sz;
+
+	sz = struct_size(perfcntrs, groups, gpu->num_perfcntr_groups);
+	perfcntrs = devm_kzalloc(dev, sz, GFP_KERNEL);
+	if (!perfcntrs)
+		return ERR_PTR(-ENOMEM);
+
+	for (unsigned i = 0; i < gpu->num_perfcntr_groups; i++) {
+		const struct msm_perfcntr_group *group =
+			&gpu->perfcntr_groups[i];
+
+		sz = struct_size(perfcntrs->groups[i], countables, group->num_counters);
+		perfcntrs->groups[i] = devm_kzalloc(dev, sz, GFP_KERNEL);
+		if (!perfcntrs->groups[i]) {
+			__msm_perfcntr_cleanup(gpu, perfcntrs);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	return perfcntrs;
+}
diff --git a/drivers/gpu/drm/msm/msm_perfcntr.h b/drivers/gpu/drm/msm/msm_perfcntr.h
index d73f1ad9039d..b5a00ab7362b 100644
--- a/drivers/gpu/drm/msm/msm_perfcntr.h
+++ b/drivers/gpu/drm/msm/msm_perfcntr.h
@@ -35,6 +35,29 @@ struct msm_perfcntr_group {
 	const struct msm_perfcntr_counter *counters;
 };
 
+/**
+ * struct msm_perfcntr_stream - state for a single open stream fd
+ */
+struct msm_perfcntr_stream {
+	/** @gpu: Back-link to the GPU */
+	struct msm_gpu *gpu;
+
+	/** @nr_groups: # of counter groups with enabled counters */
+	uint32_t nr_groups;
+
+	/**
+	 * @group_idx: array of nr_groups
+	 *
+	 * Maps the order of groups in PERFCNTR_CONFIG ioctl to group idx,
+	 * so that results in the results stream can be ordered to match
+	 * the ioctl call that setup the stream
+	 */
+	uint32_t *group_idx;
+};
+
+uint32_t msm_perfcntr_group_idx(const struct msm_perfcntr_stream *stream, uint32_t n);
+uint32_t msm_perfcntr_counter_base(const struct msm_perfcntr_stream *stream, uint32_t group_idx);
+
 /**
  * struct msm_perfcntr_context_state - per-msm_context counter state
  *
-- 
2.54.0

