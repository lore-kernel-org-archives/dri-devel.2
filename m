Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62475606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 21:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=UTqZWwBq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BXYpKmAH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D30E310E3A9;
	Mon, 26 Oct 2026 21:37:20 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20DBA10E3A9
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:37:10 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69QIoClW417808
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:37:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=pIu8GhpwL+jzjKQYXaJ1hRumnv1fMlDksFz
 956xyz9A=; b=UTqZWwBqoLxrkOgHwfWznpU6NDTEeGe3CIqNjNOymCvLRjcqmL6
 8Tl3wj4BV3zIiDJV2Y4IhfUmwapY03wyeYdXjJGxTrI+nRXUCDH1i6WgMy9pDhTA
 0yVIXDhdVPZiofW+FNpkSHCTVt42rOUMCCViwhuxVowGky895XSIh+I2BJ9499mk
 614ufjRXJrlNLdG6Jz8kOjUZn5hXeK0lH9QYWnAzscClUmoIAItA2WT5eH1Mc8BW
 mOcBMhhtstH+ekloMdbd+ZO2oi8JhhYUt/LezU8Cj3XrzI7X2teKP3u1k0cMB7c3
 RwBmL+tzU5phB+3jIl1ZqLtMI81wMy6X8Pg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4s92kg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 21:37:08 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cd68b8579f2so1333877a12.3
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 14:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793050628; x=1793655428;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pIu8GhpwL+jzjKQYXaJ1hRumnv1fMlDksFz956xyz9A=;
 b=BXYpKmAHFnvIUxmac3ZDGce8s8SrDH/G8ss3QJs6svieX1nInH89XSPS2x9oJqXrUB
 WS29L7C7p6W2sE47tLFwQlW0VI1Ur5ipfWDzxm0lXHlRI/HqNWGsXiwMtLkThc5SMJof
 vh+Ibiyagt9O6CfJpucCUcL7S/NEprOOhbOEtX2HlNYLyaORaWEo16CS41+M7FDU9N4O
 OLk8mcVInY1JLAxfzN6UPN/Nvz3IvLWEtIFVh4dRv/LmPU9oT4WEIZTp8MYZwVvNsTU7
 hYJTH773wbiOgrkJChTRd+Wp0QpwZt3QvwtQ/T2YNzwRB2cDH0zd2/XGbpMzaye+KXjU
 nYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793050628; x=1793655428;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pIu8GhpwL+jzjKQYXaJ1hRumnv1fMlDksFz956xyz9A=;
 b=eksCHXoniNUZmH+RSXA+ruSTuHa371IVMub+t1BRNlcE0TAZ6S/zFajlMUIGjMMT2K
 vaFRIqjTzJ+Zqetx0NK76iCV5sLlbBOHDnTle4r5VRMljTWWVDJWmmibgIBr4h0JzBCP
 kWbWnCnsTCWRm+X2FbnDBqQkub0U75OuzUKEf6+kpd8PktvlpEyKvDSMG0RF3bXtbHfc
 h/OStDcRIFiEhKduu8BDmLauPefiYChvQrlss/J69WIDgxaZDd2tY1ypoBTt5FJI94JI
 SMj7NCSmOewmr+8p1YnBJE1i+t7bJRYaYd2AStohTWxuarRZod9SRqHffdcXfIgaEIv4
 df5A==
X-Gm-Message-State: AFq9FYJEuwGgJjEN0cqskp1vAZEa+hcOIdArJdQ9ZxDw8p/PTcE40UO6
 JXEjqjHgQx4Zb1ubCnL+zz3WdXYgOpiMyrxb+fzKR6hogvRGiYWQUE5vbvxU4ZE43875Vx7vpx9
 +h/vgbO7GZJ25ScXDsTfkjhrf8ENvK66xf1dLgxf1ZF2QIb7sXlo3/9Y77hsy+4ufSKp8bOncqW
 n1gS8=
X-Gm-Gg: AYBFou1xBpxXgtRM9gR81/u1+f838Nh6g3/AN/8SBFft/ONzNBZ2m5z3gX1uZg4EhFC
 blp6FBHuZ3MLdd2RQqnYhwNTYZ2DJgufGgG2dGfQXYXgGQ6P6B5IECdX4X26bW+IP68/Ajn1+dY
 zszCKg6JYfgYBzQ7aTNUje46i8PDptMO3Bq2m6rfrE4A1NRZltVZ+HkImuQtZhjvdoiwzKi69Ng
 1WxvYdE9vJGxtcTjBSqcC0aacVeICxad2iHPWsnSdkuUBAALP4GEE5Untkkciin4ed0VA3gk4m9
 MrYSGBJhLrgjBxRjs6LyULayEudlBZ296HrnWF9p2VRdTmDjpuW6j8q7qzfp1sh1GBlSqfViywS
 Tz3An5bpPfJI4hXNgQqqfaurYMfv29vakUDQJsqWil/TEyIPs
X-Received: by 2002:a17:90b:5823:b0:3ac:8897:7b98 with SMTP id
 98e67ed59e1d1-3adeae7644emr7043739a91.32.1793050627551; 
 Mon, 26 Oct 2026 14:37:07 -0700 (PDT)
X-Received: by 2002:a17:90b:5823:b0:3ac:8897:7b98 with SMTP id
 98e67ed59e1d1-3adeae7644emr7043709a91.32.1793050626968; 
 Mon, 26 Oct 2026 14:37:06 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae40614daasm886781a91.4.2026.10.26.14.37.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2026 14:37:06 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Bart Van Assche <bvanassche@acm.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] drm/msm/gem: Add some cleanup.h
Date: Mon, 26 Oct 2026 14:37:00 -0700
Message-ID: <20261026213701.22126-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA4NiBTYWx0ZWRfX3LhYrNDsYN3q
 NbolABTlHk5W7e1Z0dZd+Ua7YBogDvqmuWuLhZ7V+fE9fhwgmL8ewXMlwDf2tGaMKbpwUaETMgs
 98e7aQZZbH4eekfGeTm7L9NgTH+7oo7hwI4VOOnhCiDRmxtgkhKCacfhziM9ArgFnLlVIEieFw+
 igHOKvG25DSYPNd0Rr5T0Li356xItz3vRaOHJPYa+eR1t5+/XMhcmy68GA6bGNUrhITQ5IAcTrG
 8Syw0VWRVmjpu1cm9Pdz1N+oi21tF6ZZf0a+tdHaOMprytW8P9iA6NOxorxUw6bq4KVSUFLgmks
 SaDS3ZS7qIU4DupItOrZyvVV9leXpBqjFVF9E73iwIxGqsnp5DtceNxfFECxPZfA/SlPpueeyTg
 H5A5+9+MwSrJFI5d+EjWXQrR+3mIiYWyfmZGmVfQrBaNt/0aw5/U9Q2wtjyfZxpak6JihjgUyxL
 SZONWxHsQywhnXXp1mw==
X-Proofpoint-ORIG-GUID: y5-4eEqRuV5iaMChziekg6fgrGTA4UGn
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA4NiBTYWx0ZWRfX0IVjldKn05GD
 MU7o9/utoIbZi4Aq/9R4YtD945XIWXnCbAjSN2O5ROL7GahjTom9ED65Ot8aCg2pWLjO8KF75Rp
 vLp7VCyGRWBBRnfT1oryElsIiJgFCKg=
X-Proofpoint-GUID: y5-4eEqRuV5iaMChziekg6fgrGTA4UGn
X-Authority-Analysis: v=2.4 cv=HKhWhYtv c=1 sm=1 tr=0 ts=6adfc804 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=N54-gffFAAAA:8
 a=EUspDBNiAAAA:8 a=YqXTWzTma6UHzskxvDAA:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260086
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

Convert (most of) the msm_gem_lock() and friends over to scope based
cleanup.

Other than fixing a lock leak in msm_ioctl_gem_info_set_metadata() there
should be no functional change.

Reported-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_drv.c        | 38 ++++++++------------------
 drivers/gpu/drm/msm/msm_gem.c        | 41 +++++++---------------------
 drivers/gpu/drm/msm/msm_gem.h        |  3 ++
 drivers/gpu/drm/msm/msm_gem_submit.c |  6 ++--
 drivers/gpu/drm/msm/msm_gpu.c        |  3 +-
 5 files changed, 29 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 5e8f3ce26b32..42381db0c468 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -550,7 +550,6 @@ static int msm_ioctl_gem_info_set_metadata(struct drm_gem_object *obj,
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	void *new_metadata;
-	void *buf;
 	int ret;
 
 	/* Impose a moderate upper bound on metadata size: */
@@ -559,31 +558,25 @@ static int msm_ioctl_gem_info_set_metadata(struct drm_gem_object *obj,
 	}
 
 	/* Use a temporary buf to keep copy_from_user() outside of gem obj lock: */
-	buf = memdup_user(metadata, metadata_size);
+	void *buf __free(kfree) = memdup_user(metadata, metadata_size);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
 
-	ret = msm_gem_lock_interruptible(obj);
-	if (ret)
-		goto out;
+	ACQUIRE(gem_lock_intr, lock)(obj);
+	if ((ret = ACQUIRE_ERR(gem_lock_intr, &lock)))
+		return ret;
 
 	new_metadata =
 		krealloc(msm_obj->metadata, metadata_size, GFP_KERNEL);
 	if (!new_metadata) {
-		ret = -ENOMEM;
-		goto out;
+		return -ENOMEM;
 	}
 
 	msm_obj->metadata = new_metadata;
 	msm_obj->metadata_size = metadata_size;
 	memcpy(msm_obj->metadata, buf, metadata_size);
 
-	msm_gem_unlock(obj);
-
-out:
-	kfree(buf);
-
-	return ret;
+	return 0;
 }
 
 static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
@@ -607,21 +600,14 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
 		return 0;
 	}
 
-	ret = msm_gem_lock_interruptible(obj);
-	if (ret)
-		return ret;
-
-	/* Avoid copy_to_user() under gem obj lock: */
-	len = msm_obj->metadata_size;
-	buf = kmemdup(msm_obj->metadata, len, GFP_KERNEL);
-
-	if (!buf) {
-		msm_gem_unlock(obj);
-		return -ENOMEM;
+	scoped_cond_guard (gem_lock_intr, return -EINTR, obj) {
+		/* Avoid copy_to_user() under gem obj lock by making a copy: */
+		len = msm_obj->metadata_size;
+		buf = kmemdup(msm_obj->metadata, len, GFP_KERNEL);
+		if (!buf)
+			return -ENOMEM;
 	}
 
-	msm_gem_unlock(obj);
-
 	if (*metadata_size < len) {
 		ret = -ETOOSMALL;
 	} else if (copy_to_user(metadata, buf, len)) {
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 72e3cd8bb1e7..9abcc7beb268 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -376,8 +376,6 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 	struct page **pages;
 	unsigned long pfn;
 	pgoff_t pgoff;
-	int err;
-	vm_fault_t ret;
 
 	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
 		return VM_FAULT_SIGBUS;
@@ -386,22 +384,19 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 	 * vm_ops.open/drm_gem_mmap_obj and close get and put
 	 * a reference on obj. So, we dont need to hold one here.
 	 */
-	err = msm_gem_lock_interruptible(obj);
-	if (err) {
-		ret = VM_FAULT_NOPAGE;
-		goto out;
+	ACQUIRE(gem_lock_intr, lock)(obj);
+	if (ACQUIRE_ERR(gem_lock_intr, &lock)) {
+		return VM_FAULT_NOPAGE;
 	}
 
 	if (GEM_WARN_ON(msm_obj->madv != MSM_MADV_WILLNEED)) {
-		msm_gem_unlock(obj);
 		return VM_FAULT_SIGBUS;
 	}
 
 	/* make sure we have pages attached now */
 	pages = get_pages(obj);
 	if (IS_ERR(pages)) {
-		ret = vmf_error(PTR_ERR(pages));
-		goto out_unlock;
+		return vmf_error(PTR_ERR(pages));
 	}
 
 	/* We don't use vmf->pgoff since that has the fake offset: */
@@ -412,12 +407,7 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 	VERB("Inserting %p pfn %lx, pa %lx", (void *)vmf->address,
 			pfn, pfn << PAGE_SHIFT);
 
-	ret = vmf_insert_pfn(vma, vmf->address, pfn);
-
-out_unlock:
-	msm_gem_unlock(obj);
-out:
-	return ret;
+	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
 
@@ -803,13 +793,8 @@ void *msm_gem_get_vaddr_locked(struct drm_gem_object *obj)
 
 void *msm_gem_get_vaddr(struct drm_gem_object *obj)
 {
-	void *ret;
-
-	msm_gem_lock(obj);
-	ret = msm_gem_get_vaddr_locked(obj);
-	msm_gem_unlock(obj);
-
-	return ret;
+	guard(gem_lock)(obj);
+	return msm_gem_get_vaddr_locked(obj);
 }
 
 /*
@@ -836,9 +821,8 @@ void msm_gem_put_vaddr_locked(struct drm_gem_object *obj)
 
 void msm_gem_put_vaddr(struct drm_gem_object *obj)
 {
-	msm_gem_lock(obj);
+	guard(gem_lock)(obj);
 	msm_gem_put_vaddr_locked(obj);
-	msm_gem_unlock(obj);
 }
 
 /* Update madvise status, returns true if not purged, else
@@ -849,9 +833,8 @@ int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
 	struct drm_device *dev = obj->dev;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	msm_gem_lock(obj);
-
-	mutex_lock(&dev->gem_lru_mutex);
+	guard(gem_lock)(obj);
+	guard(mutex)(&dev->gem_lru_mutex);
 
 	if (msm_obj->madv != __MSM_MADV_PURGED)
 		msm_obj->madv = madv;
@@ -863,10 +846,6 @@ int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
 	 */
 	update_lru_locked(obj);
 
-	mutex_unlock(&dev->gem_lru_mutex);
-
-	msm_gem_unlock(obj);
-
 	return (madv != __MSM_MADV_PURGED);
 }
 
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index d8ec696d89d7..bd7968232d73 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -347,6 +347,9 @@ msm_gem_unlock(struct drm_gem_object *obj)
 	dma_resv_unlock(obj->resv);
 }
 
+DEFINE_LOCK_GUARD_1(gem_lock, struct drm_gem_object, msm_gem_lock(_T->lock), msm_gem_unlock(_T->lock));
+DEFINE_LOCK_GUARD_1_COND(gem_lock, _intr, msm_gem_lock_interruptible(_T->lock), _RET == 0);
+
 /**
  * msm_gem_lock_vm_and_obj() - Helper to lock an obj + VM
  * @exec: the exec context helper which will be initalized
diff --git a/drivers/gpu/drm/msm/msm_gem_submit.c b/drivers/gpu/drm/msm/msm_gem_submit.c
index 5862db05297a..ff6cf39587c9 100644
--- a/drivers/gpu/drm/msm/msm_gem_submit.c
+++ b/drivers/gpu/drm/msm/msm_gem_submit.c
@@ -536,9 +536,9 @@ void msm_submit_retire(struct msm_gem_submit *submit)
 		struct drm_gem_object *obj = submit->bos[i].obj;
 		struct drm_gpuvm_bo *vm_bo = submit->bos[i].vm_bo;
 
-		msm_gem_lock(obj);
-		drm_gpuvm_bo_put(vm_bo);
-		msm_gem_unlock(obj);
+		scoped_guard (gem_lock, obj)
+			drm_gpuvm_bo_put(vm_bo);
+
 		drm_gem_object_put(obj);
 	}
 }
diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
index 0c2c35636251..fb07803f5aba 100644
--- a/drivers/gpu/drm/msm/msm_gpu.c
+++ b/drivers/gpu/drm/msm/msm_gpu.c
@@ -308,10 +308,9 @@ static void crashstate_get_bos(struct msm_gpu_state *state, struct msm_gem_submi
 			struct drm_gem_object *obj = submit->bos[i].obj;
 			bool dump = rd_full || (submit->bos[i].flags & MSM_SUBMIT_BO_DUMP);
 
-			msm_gem_lock(obj);
+			guard(gem_lock)(obj);
 			msm_gpu_crashstate_get_bo(state, obj, submit->bos[i].iova,
 						  dump, 0, obj->size);
-			msm_gem_unlock(obj);
 		}
 	}
 }
-- 
2.56.0

