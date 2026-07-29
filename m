Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1C18C54F51
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1818D10ECCE;
	Wed, 29 Jul 2026 15:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Dof81QTv";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DFWWtKPB";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 481AB10ECC0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:12 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3MOK2108399
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=LKg0Jig2RkR
 o1/gnDZZ15WTbhHY0CsisFdaLrgf+he0=; b=Dof81QTvNcwf2CyhVLn0kGRaitj
 oANPKDN7pGI/v8NWBM0gih05ohSuM0f74e3cxglNn+7otP2J4DEvudF1WV6FOJNl
 hLO7E4cwLjpycexyL2J7CJ10a6tucFbZUChfOEYR0wlUgS6zwKM88zbgJ5xpZebO
 IjkRlUukoVGOFI7arO/QRG5Q4fdUOwOfIr8G9PKzf7elxh+KAJFlNYfBnz5FtHw5
 WKMp1l4WPElgCd16yP82IrUFlPJhAfY6OoFZeZnQDC24rDbUOvhLgUDasvNc+41Y
 MoGYc6yghro/R5pnFQhAcKCypql35rsZuRDoyNXX0t4UXExkDqRgvgSkfUw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqkds8fyw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:11 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cce14a21faso203505ad.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340631; x=1785945431;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LKg0Jig2RkRo1/gnDZZ15WTbhHY0CsisFdaLrgf+he0=;
 b=DFWWtKPB8ah94PlJ+6CtWIfXDBnJbxDX4DFjGsijKlkohu5DkNkqktoIrwLmRd6Kq5
 ZpoHLrS5i+u5jlNC4LC3E8YDQx2V9+jWTXnZjOvjiCPmiujbWTyt89aUIZpFUVnSDyJK
 salGZvuA1gXuwYAaLE7D5S1WKj/HVTUwBYw+U0jVi3+4xVD4ekquznuE3ScYkIDApxBb
 rJGP9eAm9WC2wJYzhJgjooMGapHTlJgsnqxuB6n7VCZJBF71hbNVEbyxAZKUPdH7ozyg
 vyABxbZgGA77COyvJTDllBRSwt1vpoMCy1NjeHJpw46uzGVUuR+6vpoKxJOkzeR59RHQ
 LqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340631; x=1785945431;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LKg0Jig2RkRo1/gnDZZ15WTbhHY0CsisFdaLrgf+he0=;
 b=Cb7xWzGy6VxBRkg9lIIwsZUn9RJaRLB6j7gQ/G8ZxkC0As2UD2nVBOsBMwCVn5BZ7h
 a057tQhu87xrLURehqTKvL8tYYToHN15EmJrGY8jHZw0seOs4lP/aJzexwvInaRINMEH
 xpziBq7SafdHHzZHUb2thCTHzKFwgIL+YkMMSkXwexkpTgZliIhwrgFxZ4JOK/NxQ0un
 rOtGilBvbDcY2i+rjWvV4VZSPRl5I2k0FeUKNeb+MUMcJ9vVniBo37G0r7Hi6EtLhazT
 4hSFwtHrPX5BRkbyuPYi7NLzJ0E6fyzBCf19MQdszZmVPfO77UAKXHtmC9ysgQ1KPfA2
 3AMQ==
X-Gm-Message-State: AOJu0Yw/Cx3RVS7xCKg2MauPApAAO7lJfd9SWCCbGu8swxOa5auh62/8
 oqPyWrzSPacvI5dfBHPRZJaiXxMW7nN57900A9Kmc3T7nKUa1PNCfjGvMEEFiRCbNa6C56k2CT1
 vnOg52C9AU2CDV/whPJh4NzRvT427qWnfvIbNpP4DPzVRkCpOh3WWj837935FrGRSzSxB079IeO
 IV4t8=
X-Gm-Gg: AR+sD11TYsqvRc+Y0vLxAdclzCh6lkJRt6bFPHe+OEOC216QZSYvXgRMbipTr/mSFSz
 LGoihalW5iVaLx/3hgY1bePwVuvzcjjP21E2qxkYATOR/EB3HMQUjc9iDGvT3entRJ+wkF3wbEm
 ZuhRJrssDn4GtcOcXg6TKok6H8317JmAaOzsmWRHgR99wy30kiJIf5g8yT3nAUnCWi8W07PSK7C
 yRqbD8lsL+K4DmU1VT7GiViKZPUiEoWc6YeR3PpmfFBYVZv0vY4N+l0tgJCMCGVl1yfWp9uC7z5
 3ZvLgB/5UIYEp9m2Nf/06nGKkriSQuWKTENTedE34fevCK2B+NG+fGUlJA8/j7D1SHJkagy65gJ
 vYo3D1sBtmW69Ht6QB4neo4NhuQEwe6nH3krFclp512fr+bg=
X-Received: by 2002:a17:903:2282:b0:2ca:53f7:3c69 with SMTP id
 d9443c01a7336-2d0266945f4mr30364685ad.9.1785340631065; 
 Wed, 29 Jul 2026 08:57:11 -0700 (PDT)
X-Received: by 2002:a17:903:2282:b0:2ca:53f7:3c69 with SMTP id
 d9443c01a7336-2d0266945f4mr30364355ad.9.1785340630566; 
 Wed, 29 Jul 2026 08:57:10 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022a7fabasm13833005ad.37.2026.07.29.08.57.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:10 -0700 (PDT)
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
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 12/17] drm/msm/gem: Set resv before exposing obj
Date: Wed, 29 Jul 2026 08:55:49 -0700
Message-ID: <20260729155609.20190-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX6VaKU0eBC/6Z
 FwbgCSBO3qXWrSCI1sY849UMvGIGPJDnez7H1pOg7ktDEli6t9INBrqrjjKHyBCK8pxAdyt8H2/
 2EhbGHwU2+xIo2jklktXpF96ehyRy98=
X-Proofpoint-ORIG-GUID: PQNrC7zYoxHA4zXpJMNa_CScGBC90F_I
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX+Sx5mfzp/p15
 BJDMLxaBReolG76hRLpV3yB3vnmd7btSw/dCQAgTYcg1p+x+BqUAEr1DAAukMCcla2vBVkwhSjX
 U98O7z9ztEuJpyAXfA6/wn6LknKvvDU4eUj6aF9AZEqaPiPPYHW5xn14dT7KRjsMoPNIDrYWob7
 LXkQU1CtD037Feh/l9fCRcfFDMIXCuP7q4NTx976F3Qh5GBTJxle4noCoVW2fjZipvc63+OhKg+
 XcHgwXCs6ih8i4KU+iQ1VKwcl9V7MO/Rs9AxWP6agLoOdt8EbBg9Xdq4pJ6TDdx7cupql0c+sWd
 Sp0e0LElcMCeN5+gAhq/nGuaUMHv6cq0iBiobFlVlqwkRuRbhr6nHaI1UzNuUJ8yMp+tAu+ifAP
 DvhVX+MUPrXPDF88FM/T11dbjyc69w2RxgxOCKLP+SCugI39g06k3GKaC5a2DsKLrKkVaLgAjLc
 huM8txFOrv00A1FBtqg==
X-Authority-Analysis: v=2.4 cv=VJTtWdPX c=1 sm=1 tr=0 ts=6a6a22d7 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=EaMrRQiLzwQp3BzynKIA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: PQNrC7zYoxHA4zXpJMNa_CScGBC90F_I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607290127
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
 drivers/gpu/drm/msm/adreno/a6xx_gmu.c    |  2 +-
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  2 +-
 drivers/gpu/drm/msm/msm_fb.c             |  4 +--
 drivers/gpu/drm/msm/msm_gem.c            | 32 ++++++++++++++----------
 drivers/gpu/drm/msm/msm_gem.h            |  2 +-
 5 files changed, 24 insertions(+), 18 deletions(-)

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
 
diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index 7726edb0d4ed..c289dff78cd5 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -463,7 +463,7 @@ static int mdp4_kms_init(struct drm_device *dev)
 		goto fail;
 	}
 
-	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_SCANOUT);
+	mdp4_kms->blank_cursor_bo = msm_gem_new(dev, SZ_16K, MSM_BO_WC | MSM_BO_SCANOUT, NULL);
 	if (IS_ERR(mdp4_kms->blank_cursor_bo)) {
 		ret = PTR_ERR(mdp4_kms->blank_cursor_bo);
 		DRM_DEV_ERROR(dev->dev, "could not allocate blank-cursor bo: %d\n", ret);
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
index 3c36b1c4a4d5..535c6e1acb3c 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1136,10 +1136,17 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
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
@@ -1147,15 +1154,6 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
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
@@ -1251,7 +1249,9 @@ static int msm_gem_init_bookkeeping(struct drm_gem_object *obj)
 	return drm_gem_create_mmap_offset(obj);
 }
 
-struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t flags)
+struct drm_gem_object *
+msm_gem_new(struct drm_device *dev, size_t size, uint32_t flags,
+	    struct drm_gem_object *r_obj)
 {
 	struct drm_gem_object *obj = NULL;
 	int ret;
@@ -1268,6 +1268,11 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t
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
@@ -1311,6 +1316,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	 * up in drm_gem_object_put() -> msm_gem_free_object()
 	 */
 	obj->import_attach = attach;
+	obj->resv = dmabuf->resv;
 	drm_gem_private_object_init(dev, obj, size);
 
 	npages = size / PAGE_SIZE;
@@ -1346,7 +1352,7 @@ void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t flags,
 			 uint64_t *iova)
 {
 	void *vaddr;
-	struct drm_gem_object *obj = msm_gem_new(dev, size, flags);
+	struct drm_gem_object *obj = msm_gem_new(dev, size, flags, NULL);
 	int ret;
 
 	if (IS_ERR(obj))
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 86dc93cc1804..dff60cbc9d95 100644
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

