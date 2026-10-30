Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C15606A324
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=TSSnZqPG;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=BuOsJQlR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 193BC1129E1;
	Fri, 30 Oct 2026 21:28:13 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF3710E1E2
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:28:01 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULAY0a2832270
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=qcppdkim1; bh=NKRuHrdlCG2AC+LOZdX3rskzlgUqfcbnjlF
 bUOLAYSc=; b=TSSnZqPGqftosQMLqubn+JIQqcsjt3dhQMRu+zw7fqc8F+WuPox
 y7zZZNmAC7g7RR1ljTFH3ZQzYoROdFi3o90g0zg6v17y/41WVqOFX/8qJPDJMqsk
 bofxpli6mIj+jKNCOzN01ETlvvDu4KUYrpa9eBxNSX//DQ0a+yuzKsuBjucAfOlk
 PwxnYof1FE8JDb+KeIycCJ60I1GDMnZ2IPjQiL3zbrG8HMWRP3uDW/7xRJvAcKCd
 3RZ/SaMkVv1BZlPtQswWu7qfEi1ZT7J4ssxxFHqjHS8A80vvmaHMTLocFll2xqwD
 9nz84r+BrOaJjsqEDM5qJ8q9ZRsaV0m6cug==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x181h9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:28:00 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3ad91787a1aso835810a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395680; x=1794000480;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=NKRuHrdlCG2AC+LOZdX3rskzlgUqfcbnjlFbUOLAYSc=;
 b=BuOsJQlR6GepoW80i1UcYfGAzCKUxQ5ARuZ8ps/hdAJbtRMptsvkAVdpWGswQDtG96
 3Uq6Ja5bs1GVCffvgkbrWtFvKPLHTBWgEZEWs6Ck2M7BI/yUu8whr7NTqRxN7yrDYVc4
 c+lAxw96qbxS3R6WYKUJpSLRXt25FzUpJcrOfBEVnD4LfzjoyzvPyng5xgrcymLepIs5
 2NAxbNep5TOKJ2t5JuPZJ7dkSDzk/vhUFb2h4lAQcU9Qp6C+FixHCdvNWcjPqY6F/9f2
 TGQjjQshdzmHel1SFjYC62ucdTNzP35ML3S8QOuL0iDmuaGhiCM1QlAIWwni/QDVeP3F
 yvUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395680; x=1794000480;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NKRuHrdlCG2AC+LOZdX3rskzlgUqfcbnjlFbUOLAYSc=;
 b=S5DAG/AtvHnwtnI6qwRW/39zA6C8pVHZZiu8/csW61RT4dLb2nC4CyTDKOsVY1MKzI
 Q0EcRDI/iz9IEpOU9ZIa+J+DDTSx8ONfh9I4kFTV7QEhsHCKJImjVwaOGqKSH1LTWGdv
 b5LG7OYjpfNAacxGM2OWmNW0sblQfbygz9JXZTQOmYkbiQaPdbeek33o2kYpVUlCmEcc
 4DBl3mr8QXbwBHvahLqcVBhf2seJBpHTcp1WgoLgYPkGfzR8t388OE50dB62Pzu52TPf
 OuUo3vdOhEmpPareWA3/RqKIZMxZg2aXD9fHUjn0hNww71ecL20+GUWUWQ8d0JjlRZpY
 jvlQ==
X-Gm-Message-State: AFq9FYKDE4fRmArx3yyDUj/uBj9ZYn9JeQmRJoPn5nx6RDjYT9RBg/vj
 /q+6oimRzdpfIyXIGsURpEcCeegQiIkqBW+6DZSCdC1wXLypJNEK3WQbefUd9/ePRHpaRGUFDKo
 xExOs1335ZVibDtLQLJRkHTNKwRacD4wxkT3k2+ySUr5nJNG51T6MkGAWOVBcakBNDBzgy5NtTD
 79cEU=
X-Gm-Gg: AYBFou0WAK0AxrHF6znpJh061J232PXLpDSkqjemqQuzfqz8xob7QO6/hR9b6Z7/OR4
 Q8U+mqqp7/DrSEkuIMZxKRqX/9fyGMFC58pwTZM6jR3CFE+hgZsbdEnl7KjM0Y4iR/8HQMsBOii
 +2Jx7PCvYKauiS9jYZIamgx+xjZzMWgWoMZ4eSY6oRI/hpclHIL0Frm7dJLqeb8OJbTn/YlfeQE
 rzbVX6LiSRyaeH7vtbskppMCK1N8BBFX3s1km3R1DAAlb1hPRWkod8bgbKD9uOZc+GW+ZwqaJ3c
 b2EaIB6bNRdNT85ZNzxI/OZDQc25HrZPFRSl0ReNjg95NZZNwv9rNtiTEML19oCBZWdhG9F8Rze
 AOGVoawwN/zIHLUz+kUBYshg8ykq8uvCD5btyAUTjOtZ/Icv+EptlSoM8zPrQU1u8MCTduEAOX0
 g1hrZ9Kso3foewLY199NN1R5A=
X-Received: by 2002:a17:90a:e70c:b0:3ad:a232:4044 with SMTP id
 98e67ed59e1d1-3ae8979969fmr2618555a91.38.1793395679691; 
 Fri, 30 Oct 2026 14:27:59 -0700 (PDT)
X-Received: by 2002:a17:90a:e70c:b0:3ad:a232:4044 with SMTP id
 98e67ed59e1d1-3ae8979969fmr2618537a91.38.1793395679177; 
 Fri, 30 Oct 2026 14:27:59 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae87ee7765sm2711053a91.2.2026.10.30.14.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:27:58 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3] drm/msm/gem: Add some cleanup.h
Date: Fri, 30 Oct 2026 14:27:51 -0700
Message-ID: <20261030212752.51494-1-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: A_wvPyiykKUhcy3p58aDOenkQmybnN7z
X-Proofpoint-ORIG-GUID: A_wvPyiykKUhcy3p58aDOenkQmybnN7z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX+qm1Ci9Lm1cX
 0YprPEMDadlqHEhWfx0/AccBsCMJ1Af3OST7kd7xs0kedjLHi+JyDHEmdZUcRneyktCrj+3U948
 +jV93RtNpUm+JZa4QxocIfQnvK9VLI70sXrH6TwFBtfTaxPRErn+R+M96cl26JRkpGHwXXo0ppE
 f1axkOkDsYVIqKgQrCvRYDoNdAteHaQaaXW31V/Gu2pC7aIx3cmmwhQYoBUZJhRUnAEvHt/HS/B
 XST6VBkuNezgxqEi3TeztBUfvZJ4SatA5VXNXUBuiCBhiFyMfVrinJLHm84ZWH7KhEJQqQPUFLf
 AG+k72nHCXBydFiQ5X7/UqtzzoSCnfRgIkxiXHax+F8iJIVfPPk75W3k/iCkuS9nx2RzqfXyzaC
 rF0WEzL9Blj4MDG03ITLIrfIOvR07XYQkKKbxh1sbZL0OVHRGc2o5DPotvLlTCA6Eybvxld8AZ0
 VHJYTWfDsZE3WnhtuNw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX15VJqk8VRWWI
 p0NVN+U8zr8fVi93VzjQFLqVz3W27OjReRFwtmO8RUaoGgYmc+XWcz/KMOxdR2MjV2x5A3R470D
 zDGRlVo0Uc2yDaXX9+ZL1Qb8f+Qpqo8=
X-Authority-Analysis: v=2.4 cv=ZOdCCn7b c=1 sm=1 tr=0 ts=6ae50be0 cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=IPQtAqkb2_EUGazGSrUA:9 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610300085
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

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/Makefile         |  2 ++
 drivers/gpu/drm/msm/msm_drv.c        | 40 +++++++++------------------
 drivers/gpu/drm/msm/msm_gem.c        | 41 +++++++---------------------
 drivers/gpu/drm/msm/msm_gem.h        |  3 ++
 drivers/gpu/drm/msm/msm_gem_submit.c |  6 ++--
 drivers/gpu/drm/msm/msm_gpu.c        |  3 +-
 6 files changed, 32 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/msm/Makefile b/drivers/gpu/drm/msm/Makefile
index 1e246616f83f..6196a325b6f1 100644
--- a/drivers/gpu/drm/msm/Makefile
+++ b/drivers/gpu/drm/msm/Makefile
@@ -252,3 +252,5 @@ $(addprefix $(obj)/,$(msm-y)): $(addprefix $(obj)/,$(ADRENO_HEADERS))
 $(addprefix $(obj)/,$(msm-display-y)): $(addprefix $(obj)/,$(DISPLAY_HEADERS))
 
 targets += $(ADRENO_HEADERS) $(DISPLAY_HEADERS) $(ADRENO_PERFCNTRS)
+
+CONTEXT_ANALYSIS_msm.o := y
diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
index 7ab808322be6..3e921d24d22c 100644
--- a/drivers/gpu/drm/msm/msm_drv.c
+++ b/drivers/gpu/drm/msm/msm_drv.c
@@ -550,7 +550,6 @@ static int msm_ioctl_gem_info_set_metadata(struct drm_gem_object *obj,
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 	void *new_metadata;
-	void *buf;
 	int ret;
 
 	/* Impose a moderate upper bound on metadata size: */
@@ -559,32 +558,25 @@ static int msm_ioctl_gem_info_set_metadata(struct drm_gem_object *obj,
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
-		goto unlock;
+		return -ENOMEM;
 	}
 
 	msm_obj->metadata = new_metadata;
 	msm_obj->metadata_size = metadata_size;
 	memcpy(msm_obj->metadata, buf, metadata_size);
 
-unlock:
-	msm_gem_unlock(obj);
-
-out:
-	kfree(buf);
-
-	return ret;
+	return 0;
 }
 
 static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
@@ -608,26 +600,20 @@ static int msm_ioctl_gem_info_get_metadata(struct drm_gem_object *obj,
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
+	scoped_cond_guard (gem_lock_intr, return PTR_ERR(scope.lock), obj) {
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
 		ret = -EFAULT;
 	} else {
+		ret = 0;
 		*metadata_size = len;
 	}
 
diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index bcdb57866cf6..000dfcec7809 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -351,8 +351,6 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
 	struct page **pages;
 	unsigned long pfn;
 	pgoff_t pgoff;
-	int err;
-	vm_fault_t ret;
 
 	if (drm_WARN_ON_ONCE(obj->dev, drm_gem_is_imported(obj)))
 		return VM_FAULT_SIGBUS;
@@ -361,22 +359,19 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
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
@@ -387,12 +382,7 @@ static vm_fault_t msm_gem_fault(struct vm_fault *vmf)
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
 
 
@@ -778,13 +768,8 @@ void *msm_gem_get_vaddr_locked(struct drm_gem_object *obj)
 
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
@@ -811,9 +796,8 @@ void msm_gem_put_vaddr_locked(struct drm_gem_object *obj)
 
 void msm_gem_put_vaddr(struct drm_gem_object *obj)
 {
-	msm_gem_lock(obj);
+	guard(gem_lock)(obj);
 	msm_gem_put_vaddr_locked(obj);
-	msm_gem_unlock(obj);
 }
 
 /* Update madvise status, returns true if not purged, else
@@ -824,9 +808,8 @@ int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
 	struct drm_device *dev = obj->dev;
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
 
-	msm_gem_lock(obj);
-
-	mutex_lock(&dev->gem_lru_mutex);
+	guard(gem_lock)(obj);
+	guard(mutex)(&dev->gem_lru_mutex);
 
 	if (msm_obj->madv != __MSM_MADV_PURGED)
 		msm_obj->madv = madv;
@@ -838,10 +821,6 @@ int msm_gem_madvise(struct drm_gem_object *obj, unsigned madv)
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

