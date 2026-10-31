Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503FF606A31A
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Ul+qqobJ;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=LbbQy2F3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEB4310E207;
	Sat, 31 Oct 2026 16:12:27 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F99710E1C8
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:12 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69VD03NI1233038
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YlNWAbWxc2wGAyprwee+/8Ir/9KyjTs260dvwuhzGw8=; b=Ul+qqobJ51OrUyVV
 CjXjwQvobQ49QFcavLbVkrWBwooT77J2i/NX9YsVJueglIxSQIEaoct3kAQTUVEl
 4XFf2+vMX5I2adkRprrBqLk1TR1k2QREr7CQOOlJIxQmR3zIJITTXVvwUwFGgh/E
 cSiE9M5/WlAZh1WSrnLiULVx9PYbJgnyyi81Ab+TxUhnaVM1KD4cKl/Zsjcqo+iz
 2ydMYZC5ioj2ZsxMKhDnQ+AyhWI5lZYRdnROxTUPWapLm+08nvN4jq8RjtafHJgN
 4FhlMn608LbAlsUsfAB9aK4sRo6DziI/ubbpKfb6wL1tJp06vPZRlMBsyvfA/I6h
 TlkNTQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn9m999xc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 16:12:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-917a7c17166so14807866d6.1
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 09:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793463131; x=1794067931;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=YlNWAbWxc2wGAyprwee+/8Ir/9KyjTs260dvwuhzGw8=;
 b=LbbQy2F3YmASVHWOahdBpd0b7ai0EndlmDedw1g2O00pV6H9l7uHwIhDD+VVqaLrpP
 fN6Zo6BH6x0tc3VlFRolxjHmYCwZ8InpicW5ovXmV9IbpyhW+6cFawpjJEOBzns9n4n5
 Z4Wk/FTm8/vmiPKoGFetvK6rkuOG5wSZUfxjh8DEi0xGN4Ol5AcRKaLdjTDpMGGBSsZY
 e5FJwZ5SZVIXqOhFX3HKRI1s9yEtjp/LRu2vkQjOztQPO1867rxai26MqD/CrJ853DKH
 idCX5tr1s/Jx5z1uJoXZoDZUvbCPElngyNP3zo+GMNfPQKwCVWnhHTXi94pegdA0ggWt
 WFTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793463131; x=1794067931;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YlNWAbWxc2wGAyprwee+/8Ir/9KyjTs260dvwuhzGw8=;
 b=q+Rk4BjyBjHhCsxyYtVZEVoNDOV9WO/W7l+i8zFA9qyAhPZCAjKMd/Ii+kIE+xszfL
 sP7d3gTFx41RExJP4H3713XTWacp9ZnJVrIRCjuCL4P+d8NM928egU70FmPWj1vBxGiw
 bl6KddBOKBwAEzEgA1S0pmj+YsBATzX7b5yUWllPMFQak5zcpUAHWY1kisyRgP5EDIKX
 T4uk+UfYzwv+klwx4o41/DfCdfu+ys7y2gcE7cNclVbt+K6b16gwZ77ArZ3+w3wprkbV
 9YtfK4uFSuf8deGiyxCePo7lSNuTr51pFXAoHBsW072fpTtkjLNSqj39f4X3vhZ8oNn1
 lXcQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5C94LDOzr2K4AVp9Cy6L/fc5wF3N9xDGppXk8eMhiwQ48DpV+TeRfJ+Ps0u2KG9xCKwMYb/mDX8c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIUgiSrQUamprH0lSDKBIb/P8nn3omudF8Crg3StI7OEUHPo/Jz
 TTya1DWwJKR4MadXJjQkYKYVJjTu8XLPEqCeY2fsMlESkQeFNQQJ9Yh56yEfx2Fn+kPr0lCS/T7
 G5Ju9EEtSRJlCAo9oLlqsL0DF3T7GysKT0HJtQ/r+7pxlF0WHj9idzK2yORAEzywQzIBPfhM=
X-Gm-Gg: AYBFou1BrmhKkU7idORxq5aDF7HE1AqdtrN7JzFoHjNkTR3ylUUS1H+xAe2YBrja1cT
 K3UKI8SIcU1KebvOCjECrDan/NphZyfhjDSLLgX6RmxwGNX0ruUys4jtfc+Vejx5e5+P5/UIWF7
 OaJY1A7xTVwEj8qzrRKl8OCB4yPY8kWsxTvW9mv1iJ+Fwh46pkvQKtEQTDXU9hx7csIx0spNPJY
 g5tknb8xxnREjWGq7bkuy6WgEOssjjmr3iLKYFLKd7PWVgv0MuMM+QWfHp/CCirrqmkWtxKk+FD
 a0UvUwfmviecK4KmJrAkI5FMflmKcrVEp9gVkQuDzFFVaWI4hWnw4F0oSnLLLs5IiK7CN3pWyMa
 zFw6iH3HdzXsIKs+RytmWOSl2FxnyaMDrnsz1IX7ZcK66i7wh1bHe2VVpjfES09Qil+Gebyridk
 mEohR4j2rhMClItC+0zwMGfRAi4FVSJeGtYMFAQSkbT1YbmmS08a63KB8SE10GIg==
X-Received: by 2002:a05:620a:3188:b0:93f:2ab9:728c with SMTP id
 af79cd13be357-94421758732mr964914985a.71.1793463130922; 
 Sat, 31 Oct 2026 09:12:10 -0700 (PDT)
X-Received: by 2002:a05:620a:3188:b0:93f:2ab9:728c with SMTP id
 af79cd13be357-94421758732mr964909385a.71.1793463130295; 
 Sat, 31 Oct 2026 09:12:10 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfe0720e3csm666666e87.28.2026.10.31.09.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:12:07 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 31 Oct 2026 18:11:51 +0200
Subject: [PATCH v2 1/4] drm/msm: share a page of kernel state with the GPU
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261031-b4-adreno-timestamp-v2-1-0836856b228f@oss.qualcomm.com>
References: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
In-Reply-To: <20261031-b4-adreno-timestamp-v2-0-0836856b228f@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4278;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=devFZRDNTr6q6aJyRKFG/wEH3BHC9t43r+Sc04fgzcg=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq5hNOz9wL/xUO+pSkXEeVhIU4b1JPmDaik6zm/
 nGpO7t6ediJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCauYTTgAKCRCLPIo+Aiko
 1aDPCACV4otGXIUcaP/Cai51XWlkQ5I0qL+MXwcLy+AmXSLy4auKgXOOnts7LrrT3b/yExLBlUp
 uRnSjveAEV375p3PLLyZM5PqMoYxu23WDyL4NC1j86/6YpXZhgeXu3WzKdIEPtBMHy19lWgDHV8
 GRiKalOFFV4zlNJmrDn4uo+J6VRR2Q48pZMf+lW1j0NOXJDCZnRnRm5W2DqGZiUxtQl+Ws07Rgv
 Q77V41YdSomCvmkIfmRHWTZwggFqByCieRAS4rghDV7CKlc+h3Oom9X91HpfMWYFRqNIZDVxpZB
 LbuNi+8GbeoZn/BPiEosWV6R/BEp6k7WKeVHs8c9iKV9hg5U
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: NTm1Lz-T2KlQlI4dmoSdh8jBwO3iCHsE
X-Proofpoint-GUID: NTm1Lz-T2KlQlI4dmoSdh8jBwO3iCHsE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDA2NCBTYWx0ZWRfX/Q5wmzoAeTKs
 qnbArOAxweDiIm6Sl46pR7mlfZEGfAINObpGOF+krggDsa2ZGDw9l0m4pYguxJnrq9nlPlyhvHQ
 99mjzzuyc/DMJjqnK5yfKwUD3gpE2Agubohs2Vdi7e/+WxObyYQIFuUbi81vVW8uQ499I+FMU7z
 UV8MK7UfQ96bxpvW+GlVhpYNunNa/5C74iXj2LvnWJbhsrhA38AQeBN/7EJAl+vegx4I5gOpzFP
 3HwX11X8l781yl/fBnxZ5rsa1Sv1LTXxwxe/tjqdyBSSiCJbbN8iAREppewJ6yUkFmfu8pcCMkU
 ijW3tCS0HfdDWJJ2ChKuQYqkvDQoBh5HIuqMALGAg45nmhe0dDuNc6OxgeMGd8VIuP1u54/AHES
 zT0nXVHt+7xNarK8FE+dUKve3cqjME0IBhYwIC7hQtG0elSRXYa4kUZgFwFuY5WaIl276SHA9h7
 oY1gLAmW0dVhSxyNVKQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDA2NCBTYWx0ZWRfX90jecIJsWLAz
 3jqLR1XeIaM0G1T6oyg2ExOcX+tPWIBFuNYoQrbTJJfcarNueKiFbh6Uz+tfiiy9QK0mgaxPhnU
 YqMmmHww2A6VUr74tREBTZsaO7bd8JA=
X-Authority-Analysis: v=2.4 cv=cfVHPXDM c=1 sm=1 tr=0 ts=6ae6135c cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=Sjt1sVUzr0hdpTIL:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=h5xwza0VLmx2EBWN6JMA:9 a=QEXdDO2ut3YA:10
 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310064
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

Some state the kernel keeps has to be applied to values the GPU produces
by itself, the first case being the always-on counter that restarts
across a GPU power collapse. A GET_PARAM can't carry it, as command
streams need the value at the time they execute.

Allocate one page in the global GPU address space, read-only to the GPU
and not privileged, so the command streams of every context can read
it, and report its address. Start it with a flags word so that fields
appended later can be announced.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/adreno_gpu.c |  3 +++
 drivers/gpu/drm/msm/msm_gpu.c           | 15 +++++++++++++++
 drivers/gpu/drm/msm/msm_gpu.h           |  5 +++++
 include/uapi/drm/msm_drm.h              |  9 +++++++++
 4 files changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/msm/adreno/adreno_gpu.c b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
index dadfe4c69438..0adf56fb9563 100644
--- a/drivers/gpu/drm/msm/adreno/adreno_gpu.c
+++ b/drivers/gpu/drm/msm/adreno/adreno_gpu.c
@@ -404,6 +404,9 @@ int adreno_get_param(struct msm_gpu *gpu, struct msm_context *ctx,
 			return 0;
 		}
 		return -EINVAL;
+	case MSM_PARAM_VDSO_IOVA:
+		*value = gpu->vdso_iova;
+		return 0;
 	case MSM_PARAM_PRIORITIES:
 		*value = gpu->nr_rings * NR_SCHED_PRIORITIES;
 		return 0;
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0c2c35636251..747cd90e329a 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -989,6 +989,19 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 
 	msm_gem_object_set_name(gpu->memptrs_bo, "memptrs");
 
+	gpu->vdso = msm_gem_kernel_new(drm, PAGE_SIZE,
+		MSM_BO_WC | MSM_BO_GPU_READONLY, gpu->vm, &gpu->vdso_bo,
+		&gpu->vdso_iova);
+
+	if (IS_ERR(gpu->vdso)) {
+		ret = PTR_ERR(gpu->vdso);
+		gpu->vdso = NULL;
+		DRM_DEV_ERROR(drm->dev, "could not allocate vdso: %d\n", ret);
+		goto fail;
+	}
+
+	msm_gem_object_set_name(gpu->vdso_bo, "vdso");
+
 	if (nr_rings > ARRAY_SIZE(gpu->rb)) {
 		DRM_DEV_INFO_ONCE(drm->dev, "Only creating %zu ringbuffers\n",
 			ARRAY_SIZE(gpu->rb));
@@ -1033,6 +1046,7 @@ int msm_gpu_init(struct drm_device *drm, struct platform_device *pdev,
 		gpu->rb[i] = NULL;
 	}
 
+	msm_gem_kernel_put(gpu->vdso_bo, gpu->vm);
 	msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
 
 	platform_set_drvdata(pdev, NULL);
@@ -1050,6 +1064,7 @@ void msm_gpu_cleanup(struct msm_gpu *gpu)
 		gpu->rb[i] = NULL;
 	}
 
+	msm_gem_kernel_put(gpu->vdso_bo, gpu->vm);
 	msm_gem_kernel_put(gpu->memptrs_bo, gpu->vm);
 
 	if (!IS_ERR_OR_NULL(gpu->vm)) {
diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
index d27d54bdb7a7..f78f3bc62977 100644
--- a/drivers/gpu/drm/msm/msm_gpu.h
+++ b/drivers/gpu/drm/msm/msm_gpu.h
@@ -252,6 +252,11 @@ struct msm_gpu {
 
 	struct drm_gem_object *memptrs_bo;
 
+	/* page of kernel state shared read-only with the GPU: */
+	struct drm_gem_object *vdso_bo;
+	struct drm_msm_vdso *vdso;
+	uint64_t vdso_iova;
+
 	struct msm_gpu_devfreq devfreq;
 
 	uint32_t suspend_count;
diff --git a/include/uapi/drm/msm_drm.h b/include/uapi/drm/msm_drm.h
index 3d363f12f66a..f8bf48fdc339 100644
--- a/include/uapi/drm/msm_drm.h
+++ b/include/uapi/drm/msm_drm.h
@@ -118,6 +118,7 @@ struct drm_msm_timespec {
  */
 #define MSM_PARAM_EN_VM_BIND 0x16  /* WO, once */
 #define MSM_PARAM_AQE	     0x17  /* RO */
+#define MSM_PARAM_VDSO_IOVA  0x18  /* RO: GPU address of struct drm_msm_vdso */
 
 /* For backwards compat.  The original support for preemption was based on
  * a single ring per priority level so # of priority levels equals the #
@@ -127,6 +128,14 @@ struct drm_msm_timespec {
  */
 #define MSM_PARAM_NR_RINGS   MSM_PARAM_PRIORITIES
 
+/* A page of kernel state that the GPU can read, at MSM_PARAM_VDSO_IOVA, for
+ * command streams to use.  New fields are only ever appended, and the kernel
+ * sets a bit in @flags for each one that needs announcing.
+ */
+struct drm_msm_vdso {
+	__u64 flags;
+};
+
 struct drm_msm_param {
 	__u32 pipe;           /* in, MSM_PIPE_x */
 	__u32 param;          /* in, MSM_PARAM_x */

-- 
2.47.3

