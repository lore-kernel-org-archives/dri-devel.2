Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54F3EC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AEF210F60A;
	Fri, 17 Jul 2026 20:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Y4zW4Fae";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="XIqCrt/p";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F9710F607
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:08 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtHU82597481
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=u+dYORbwSI6
 uiQcDeTCc3vg91gVYcFDs6LJ+8okS1eM=; b=Y4zW4FaeZKeaIQj+XVZ8t/w6n/j
 YrIjsNVh72DLHXagGzNNc4xXLO5hO+uHRysQFBPFFiayL4bsJLOhbByhUXj8moML
 xzgiAZ6+kkDbthDRNJP0T5xYKPXvCGXc2MrKI0l+Jkj+R//iXmu3ipr6DM7Ke3vK
 9UhXD2vy1+wsNojfMUXh3FtV3vIeOPo9AC54Luj8Lk94Y/LGHx6tRYUT9lTBfyYu
 3p8SgvwquN9G1eaEbiYC3ItnfPpW4+fqdxmzSeawFFLBj3K3llx4+R6XsY0p9Lmd
 B5a1DLGovmGV53JSKxAvW2xGLFf9//yQVQV/hmkV7Lm3cF7NakRWuBNZ97Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffrp8rsgd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:07 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2cc88e22f92so169313065ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321347; x=1784926147;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u+dYORbwSI6uiQcDeTCc3vg91gVYcFDs6LJ+8okS1eM=;
 b=XIqCrt/pTNHE9EMHUmKiwp6/YsdNvS1XTIYVVhZv5FIaEHaH0iy2v4mBWYyS3BTdlj
 kD/GybyRnhradIpzn8lMi+aZRsunDAQt7z2XJhrnQ4I7HJEB/7wmD1vZsk2EM7MlPRsS
 +tumWbEtpBMFra8cQN7cCJ6RaGpbyNb4ATJ98OY++OLb5KEI5RiqJGK5jc9HrZhfIbyv
 zyzdhAUm1qLKyQuYy8kJIIaITbiB+VnCF3RtooiqlFIoBdkbtcX+Wb1wnQ0I4dMbcpCD
 xqB0LvK25zMZKW/VXEPN6CiZk+xbUKD9k5olAlqJ+x8vRkVYk+KN3c8qtSeR2ZrDwKBS
 fleg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321347; x=1784926147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u+dYORbwSI6uiQcDeTCc3vg91gVYcFDs6LJ+8okS1eM=;
 b=KzXtErUwfT3k1fV6gqZA0atG/iqHjdRwGwchfH84hzp8H2U1ttS5nIaEO/RsYKJykO
 iaLTd5Wc8XeAndyxJUvHQLdT6dTMmIdPYM/DhELwaSkbBf5A1fcvZoTioL4kUEORZA1F
 MS92s4QJX6hXoTkyKtfV72KEWKUpiOzZV+yuPZzg1DpANb807LU9dr/+kWkJxwFRUTrY
 3VISms7c7ka5RnQl81rCjLPtzPbLFVuNTd3D0X538HEyQlS6FZc/5ltRjKlFbJBTdENJ
 crkHt4aSkHiCP0HY8Kyh/fFV8z3TOQDTkvXCkJI/jubDPRlJejKSzHRioOt76degBXPN
 DV6w==
X-Gm-Message-State: AOJu0YwfA/uF3/rMYlSCECt6Or/1xx0DmJaXLdVYOoUNe/9fa7m8Ue6O
 hA7C0vlGyQBBh+nZCFDktvZR9evTb//HDJBkINnDoc5LQgpVuvU0ORA4IOMyy6Z3hi/xQdt1uH5
 TrIrnB0S/mzbDWeMV4/k//OOmC+72o024OYrIuwizTbMUL0K+qmqivxuHwWIUJNJejJG0AQDWSo
 klPJQ=
X-Gm-Gg: AfdE7cnGYWWmbVkritRPMkWkkmfg7lk8B9A1B1cO4eGfoy0rFwvBmzWkuyutVPhsabk
 BcMqxf1+XitiqSC0NlHmB8f15z8RqQWFa314IIpI9Dp1rPPAgFHV7rP46CCTsmyfUi6E+6hWAwF
 epfn5PgttpZp/SiA8w/fYkuOrFVdzumeOFuODJFFlqOBV307bhdsEY2g7nOv0iTslXUNNm+DsJL
 kADw0yaGqVAkdxcrbLFTjBzeTRl8X2YVOPuBNy3qxTHIV1lPDwBK9sbJKmRF5130Tf+huozXCOA
 Pt/TlnxueSBTYWvCu9joPqK2+6+6ivz8y5fipKEx5jOmGwd5iL4Mnnsfrf992COc+EJ9OpGHBj8
 rA2q9W98lJKgvfm3ySAbmVJ+NRHLbW6HrA22CvKUawMYOeXA=
X-Received: by 2002:a17:903:3c4f:b0:2cc:fe03:dc75 with SMTP id
 d9443c01a7336-2cf3499007bmr48336305ad.27.1784321346996; 
 Fri, 17 Jul 2026 13:49:06 -0700 (PDT)
X-Received: by 2002:a17:903:3c4f:b0:2cc:fe03:dc75 with SMTP id
 d9443c01a7336-2cf3499007bmr48335915ad.27.1784321346560; 
 Fri, 17 Jul 2026 13:49:06 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf34729df7sm17189185ad.63.2026.07.17.13.49.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:05 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>, Sean Paul <sean@poorly.run>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 11/16] drm/msm/gem: Set resv before exposing obj
Date: Fri, 17 Jul 2026 13:48:27 -0700
Message-ID: <20260717204841.26120-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX+FzMFBVsMabb
 uVCt/4Kpl5dLt2CW8MOMWIvANamqVJlwMlSP1S7hL9chVHz5EZrIEtwPXuUYkW8qYmEjm6uvLEa
 iMTQ28D/G2ube360lUrnyTzRAUQTwHQ=
X-Proofpoint-ORIG-GUID: nXvoDN_aYyZy2iyrCgpjwfhkb_wj5KdE
X-Proofpoint-GUID: nXvoDN_aYyZy2iyrCgpjwfhkb_wj5KdE
X-Authority-Analysis: v=2.4 cv=fMYJG5ae c=1 sm=1 tr=0 ts=6a5a9543 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=EaMrRQiLzwQp3BzynKIA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX+gaMbhqoEjK7
 vN4g3EGEH2kwC7IszOcnRCO7705c+lWQEpAH5Rkrk1m/VgDPb3GpkqT5VJjkJYOgWscfculzkUW
 uQCvby6qJ314cX4I6K2M7lowqqJU2QKxXCJPlf4o2gNsuSA8cm9XHDh4EjwUCN4SCOqXx3p8G9N
 PiOB83RMA3GHJ81Gd9jhQ6JlR+x2IG0rMH5f2CgZgayKbn4ySafpRCT5pfA2+FbV2o/3HnNGiVB
 msU55+DbWufE2DbrH9N8AgWA+iJItTBx/4sppON1FgADnQgNkL0CSo87QfPJWc1NlxB6DYeP8aB
 dJTDTfAns4buJwZAIudmzm6rycP+5pL3zl+6oEJ5OvCR9NVGouFhJuQonvd0j3sArRohvN/iQOL
 zIrR+9B+Jiy7W/z9P5BuSevjwBrYeBXgd41c/pJQEX9K5BPn+c6SsUdoICf+ObyOkrAacJxmuxh
 vbqCg1jJLOcRLSVu81w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 clxscore=1015
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170214
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

Don't swap the resv object _after_ exposing the newly created obj in LRU
or global objects list, as that creates a race condition where another
thread could lock the object using the original (per-obj) resv, but then
unlock after the resv is replaced.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c |  2 +-
 drivers/gpu/drm/msm/msm_fb.c          |  4 ++--
 drivers/gpu/drm/msm/msm_gem.c         | 32 ++++++++++++++++-----------
 drivers/gpu/drm/msm/msm_gem.h         |  2 +-
 4 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
index 2e5d7b53a0c3..9aed142faea1 100644
--- a/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
+++ b/drivers/gpu/drm/msm/adreno/a6xx_gmu.c
@@ -1546,7 +1546,7 @@ static int a6xx_gmu_memory_alloc(struct a6xx_gmu *gmu, struct a6xx_gmu_bo *bo,
 		flags |= MSM_BO_MAP_PRIV;
 	}
 
-	bo->obj = msm_gem_new(dev, size, flags);
+	bo->obj = msm_gem_new(dev, size, flags, NULL);
 	if (IS_ERR(bo->obj))
 		return PTR_ERR(bo->obj);
 
diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index 9b681e144c07..ee17a47f31c4 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -267,11 +267,11 @@ msm_alloc_stolen_fb(struct drm_device *dev, int w, int h, int p, uint32_t format
 	/* allocate backing bo */
 	size = mode_cmd.pitches[0] * mode_cmd.height;
 	DBG("allocating %d bytes for fb %d", size, dev->primary->index);
-	bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC | MSM_BO_STOLEN);
+	bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC | MSM_BO_STOLEN, NULL);
 	if (IS_ERR(bo)) {
 		dev_warn(dev->dev, "could not allocate stolen bo\n");
 		/* try regular bo: */
-		bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC);
+		bo = msm_gem_new(dev, size, MSM_BO_SCANOUT | MSM_BO_WC, NULL);
 	}
 	if (IS_ERR(bo)) {
 		DRM_DEV_ERROR(dev->dev, "failed to allocate buffer object\n");
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 59143be07428..cb00bdf21ef6 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1134,10 +1134,17 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 		size_t size, uint32_t flags, uint32_t *handle,
 		char *name)
 {
-	struct drm_gem_object *obj;
+	struct drm_gem_object *obj, *r_obj = NULL;
 	int ret;
 
-	obj = msm_gem_new(dev, size, flags);
+	if (flags & MSM_BO_NO_SHARE) {
+		struct msm_context *ctx = file->driver_priv;
+		struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
+
+		r_obj = drm_gpuvm_resv_obj(vm);
+	}
+
+	obj = msm_gem_new(dev, size, flags, r_obj);
 
 	if (IS_ERR(obj))
 		return PTR_ERR(obj);
@@ -1145,15 +1152,6 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	if (name)
 		msm_gem_object_set_name(obj, "%s", name);
 
-	if (flags & MSM_BO_NO_SHARE) {
-		struct msm_context *ctx = file->driver_priv;
-		struct drm_gem_object *r_obj = drm_gpuvm_resv_obj(ctx->vm);
-
-		drm_gem_object_get(r_obj);
-
-		obj->resv = r_obj->resv;
-	}
-
 	ret = drm_gem_handle_create(file, obj, handle);
 
 	/* drop reference from allocate - handle holds it now */
@@ -1245,7 +1243,9 @@ static int msm_gem_init_bookkeeping(struct drm_gem_object *obj)
 	return drm_gem_create_mmap_offset(obj);
 }
 
-struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t flags)
+struct drm_gem_object *
+msm_gem_new(struct drm_device *dev, size_t size, uint32_t flags,
+	    struct drm_gem_object *r_obj)
 {
 	struct drm_gem_object *obj = NULL;
 	int ret;
@@ -1262,6 +1262,11 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t
 	if (ret)
 		return ERR_PTR(ret);
 
+	if (flags & MSM_BO_NO_SHARE) {
+		drm_gem_object_get(r_obj);
+		obj->resv = r_obj->resv;
+	}
+
 	ret = drm_gem_object_init(dev, obj, size);
 	if (ret)
 		goto fail;
@@ -1298,6 +1303,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	obj->resv = dmabuf->resv;
 	drm_gem_private_object_init(dev, obj, size);
 
 	npages = size / PAGE_SIZE;
@@ -1331,7 +1337,7 @@ void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t flags,
 			 uint64_t *iova)
 {
 	void *vaddr;
-	struct drm_gem_object *obj = msm_gem_new(dev, size, flags);
+	struct drm_gem_object *obj = msm_gem_new(dev, size, flags, NULL);
 	int ret;
 
 	if (IS_ERR(obj))
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 762e546d25ef..47ff2bbc1915 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -296,7 +296,7 @@ int msm_gem_cpu_fini(struct drm_gem_object *obj);
 int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 		size_t size, uint32_t flags, uint32_t *handle, char *name);
 struct drm_gem_object *msm_gem_new(struct drm_device *dev,
-		size_t size, uint32_t flags);
+		size_t size, uint32_t flags, struct drm_gem_object *r_obj);
 void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t flags,
 			 struct drm_gpuvm *vm, struct drm_gem_object **bo,
 			 uint64_t *iova);
-- 
2.55.0

