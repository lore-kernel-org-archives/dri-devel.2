Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 094CDC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FD7C10ECD0;
	Wed, 29 Jul 2026 15:57:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="i4NB1F1U";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="eNdpFnX5";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 161A110ECCD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:07 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF3Aco1700409
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Ci5a3i1KHTi
 GYmRN5tAXD+AHcmxzUAUAXBR1lwdlYe4=; b=i4NB1F1UfAVUYHKl03lQVOqD1Rk
 oLB+opu7ZPiRCAPzai8aAZxHWeQajb8cTccGO935ykfNar6X+vamagMjGmPJ4AsF
 e7N1BzvQYSsp89d61+jszhkU86MW2aNhGHIo18YPT7lPvs1Aup2GVAQ7UEaamVPs
 sQ4HWya5DD7KE4fSNZo+GoUyQ6gXDvHR5sGbmOKhqZsfHhBlgUF3Wi0ooNeRBlxt
 1+Rg8wmuq5H7evgNhcwiOUJxbGSM1QuV9kC+t5KW/1PDx61o2kcLJANqBzJgRawg
 j6wrrzZVpIKOMdsEYkS3hCt9p7VzXk6Xe7gXA0A3XvhwGX1cHbovNohQsBg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqgrj19ru-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:06 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc6dd43737so23907485ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340626; x=1785945426;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ci5a3i1KHTiGYmRN5tAXD+AHcmxzUAUAXBR1lwdlYe4=;
 b=eNdpFnX57LUz3NgrLqgIi0hcsX+MR0lgZ21YHpQD9cbJw+eqbbwchpjKk5/juioH/1
 7xsGw9pc4ZlK4gxRP1jJ7eiLVtmswQK6/dJ2E3S4hvLas/uTolOBV0M1JBfSBgW6gK13
 E7CRfdw+FxhGdp0yqexcwIWLA70ID2oQYOKYCCifKno22o1HnuYQ1DOptZnj/bSynUFa
 yl/EvTkZV5IxFD/JkUA3Zd6PGxO4t0xPVh1C2CqsL2qhyj0BkPK5jH0ACaGehlHALCTh
 484c24SDnBpQZmJYAbl0SkHTiDkHOALF6eLWYQ8pOLWrJJx9c7TVvzp+9lULB3/W1fpt
 wg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340626; x=1785945426;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ci5a3i1KHTiGYmRN5tAXD+AHcmxzUAUAXBR1lwdlYe4=;
 b=iRiZLx9b7wevNehdY/N2f59G0nxb87UmD7hSTnENs2w3sacPgQCbIg2JUb2fwXLbnk
 HexFvZoCfewVfb/i7rvPCDUAq++Ojd3enRigoA9nwkKndd/ROK/Ufy5yEmpopmoccCdb
 4qbQIFODHIGOYlXZNqjD4crPIcEf5SHHK+CNPsdVR8j5vWLXrtjxCl7axqHGoIOwPHON
 h9ZYJJeSVmjGcBDifABysnGkVG5iMwwj0+Ct5H1N0UJ4g+89ATD41pFwfiiwfF0yr9Xz
 AyYvqXtZSclXbMASFJCD/JdxZOqUdkWPcHSfXtTCl5bZ1O1W4qHoBydm94/dCxSec/6e
 ZqdQ==
X-Gm-Message-State: AOJu0YxxIomZp3Wn9yojV2l1sweZbQ5fWn/n77bIeSrhdtlvTiw7POiF
 Be9Mau9swiXiSKFqSww1fLZXM7oYAyylOdgMcdbFjPKZa8DHA4QnCc84RN7TEFLg8MgDlvwpUjb
 7LsYVINjQPOdtiHBGfLdUlsApEGGBBuwSFZbYCfn6qDY8HASEXz7+2mXu2wXi3/KtP5LrzJJBvo
 xR8nM=
X-Gm-Gg: AR+sD13yyHwMIeLJk5qF8vN2BVu76zbt7tpDxqcs924QS7hPKM2jWmPBccXlClwS58Y
 ntfiPNkjKIDWHKGyAT7tIE5BxV0DNgwUHFwxv76oZOyyFUg7RIX0tlqx6p8s+a3YVEvjy24eexx
 e+h/O0bwJ/GeDjXzrhpC0JWB+0bh2EJKL8+DWHtvKsay8ZBiqnTL4cbVivS9+C2QE06m7F0edAq
 PYEe3XU42v3VpBfSkaw4velOLy9A3QATrma9hRuoyFUVpZRZha9R4jzeHLNp0CYvCLjRACSS5Lv
 ew9hUkzalbbYDSIx6e51uXf75f+u2vh97QOJF1/7OU2Cy5iI61TGdV5U4HWT+giFGvwU9Ai8TGX
 AzVPyiwVocmmpRG/BvFiLoGPbYfF7JuIcoXyG1Ik5PxAvXbU=
X-Received: by 2002:a17:903:1b08:b0:2c6:d710:3e58 with SMTP id
 d9443c01a7336-2d015d5b940mr84316045ad.36.1785340625640; 
 Wed, 29 Jul 2026 08:57:05 -0700 (PDT)
X-Received: by 2002:a17:903:1b08:b0:2c6:d710:3e58 with SMTP id
 d9443c01a7336-2d015d5b940mr84315725ad.36.1785340625211; 
 Wed, 29 Jul 2026 08:57:05 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bf39b5sm13502115ad.57.2026.07.29.08.57.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:04 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b), 
 linaro-mm-sig@lists.linaro.org (moderated list:DMA BUFFER SHARING
 FRAMEWORK:Keyword:\bdma_(?:buf|fence|resv)\b)
Subject: [PATCH v7 09/17] drm/msm/gem: Fix dma_buf import error paths
Date: Wed, 29 Jul 2026 08:55:46 -0700
Message-ID: <20260729155609.20190-10-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=RJOD2Yi+ c=1 sm=1 tr=0 ts=6a6a22d2 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=sWKEhP36mHoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CL2m_loAqK5Y4tUKEbYA:9
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-ORIG-GUID: TmiE7T5PNA_jS23TH9tqQnIYXJlZG1Co
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXyb1rE3D681rC
 wOHeENTAZYF7RLAOnDsuKh4l/3hjslV7y8/Oj0ht433axzch2IQeX7RbYODaOi/ODyks3OUZd1+
 s4RnWohVkwbEgoB/ZvdfQlT3MgGtnUB2GC1OqyN30Yc9CV+NfJMqDTWb7PTZqGZ0vEwmvof0nWh
 +xvgYkiMAKpkIKAdJldhyhiZ6P4M6EMDLsYgWuaTe2OOlniH2V1egy36xSUospLSO6ovCO0Um6N
 tg8qT5R1Kadx/qhDm6YwhLMqBhj/6N2IUiTS4jUitvoIIH9KxRVtJPkxaFH+KVCJWRVi4Cy/Ugf
 cvU7cjx8uw8GYNlRoNQn3QKHMG6WGC7L7FCf00Ra4HB5I41Y+RR3hFAa4ee3Q3GHXgNMYOwbbZW
 c7irkwilkR7ZWrxXGik/jq1tEtwvzHh6OxaeTNRaKQhngn90It+WePnTTVch7XgquqBCSdBa1jw
 nEZjNmM6Mc7WzVYKzQQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX/DtecqTJHhs/
 xdGqu3WcIJGaxLVN6p5AI1ajThiW1rvitvibzNQfh9l5w05HzviRPq7rPrWVFa1POmoMt1mWv2x
 1A0j77Cn30ocKrTQiNh6qgR+9R/4QME=
X-Proofpoint-GUID: TmiE7T5PNA_jS23TH9tqQnIYXJlZG1Co
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290127
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

Set import_attach early, so that if we hit an error path
msm_gem_free_object() goes down the drm_gem_is_imported()
path.

Set sgt late so _free_object() skips drm_prime_gem_destroy()
as this is done by drm_gem_prime_import_dev().

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c       | 17 ++++++++++++++---
 drivers/gpu/drm/msm/msm_gem.h       |  3 ++-
 drivers/gpu/drm/msm/msm_gem_prime.c |  2 +-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index efd3d3c9a449..74c3728f45bd 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1093,7 +1093,9 @@ static void msm_gem_free_object(struct drm_gem_object *obj)
 		 */
 		kvfree(msm_obj->pages);
 
-		drm_prime_gem_destroy(obj, msm_obj->sgt);
+		/* In msm_gem_import() error path, sgt won't be set yet: */
+		if (msm_obj->sgt)
+			drm_prime_gem_destroy(obj, msm_obj->sgt);
 	} else {
 		msm_gem_vunmap(obj);
 		put_pages(obj);
@@ -1282,11 +1284,13 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t
 }
 
 struct drm_gem_object *msm_gem_import(struct drm_device *dev,
-		struct dma_buf *dmabuf, struct sg_table *sgt)
+				      struct dma_buf_attachment *attach,
+				      struct sg_table *sgt)
 {
 	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj;
+	struct dma_buf *dmabuf = attach->dmabuf;
 	size_t size, npages;
 	int ret;
 
@@ -1296,13 +1300,17 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	if (ret)
 		return ERR_PTR(ret);
 
+	/*
+	 * Set import_attach here in case we hit an error path that ends
+	 * up in drm_gem_object_put() -> msm_gem_free_object()
+	 */
+	obj->import_attach = attach;
 	drm_gem_private_object_init(dev, obj, size);
 
 	npages = size / PAGE_SIZE;
 
 	msm_obj = to_msm_bo(obj);
 	msm_gem_lock(obj);
-	msm_obj->sgt = sgt;
 	msm_obj->pages = kvmalloc_objs(struct page *, npages);
 	if (!msm_obj->pages) {
 		msm_gem_unlock(obj);
@@ -1328,6 +1336,9 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	if (ret)
 		goto fail;
 
+	/* Now that we are past potential failure points, set sgt: */
+	msm_obj->sgt = sgt;
+
 	return obj;
 
 fail:
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 762e546d25ef..86dc93cc1804 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -302,7 +302,8 @@ void *msm_gem_kernel_new(struct drm_device *dev, size_t size, uint32_t flags,
 			 uint64_t *iova);
 void msm_gem_kernel_put(struct drm_gem_object *bo, struct drm_gpuvm *vm);
 struct drm_gem_object *msm_gem_import(struct drm_device *dev,
-		struct dma_buf *dmabuf, struct sg_table *sgt);
+				      struct dma_buf_attachment *attach,
+				      struct sg_table *sgt);
 __printf(2, 3)
 void msm_gem_object_set_name(struct drm_gem_object *bo, const char *fmt, ...);
 
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index 036d34c674d9..beb7f22fd694 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -83,7 +83,7 @@ struct drm_gem_object *msm_gem_prime_import(struct drm_device *dev,
 struct drm_gem_object *msm_gem_prime_import_sg_table(struct drm_device *dev,
 		struct dma_buf_attachment *attach, struct sg_table *sg)
 {
-	return msm_gem_import(dev, attach->dmabuf, sg);
+	return msm_gem_import(dev, attach, sg);
 }
 
 struct dma_buf *msm_gem_prime_export(struct drm_gem_object *obj, int flags)
-- 
2.55.0

