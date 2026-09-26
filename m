Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B591C9832F
	for <dri-devel@archiver.kernel.org>; Sat, 26 Sep 2026 18:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B6BD10E1BB;
	Sat, 26 Sep 2026 18:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="dHDE1InM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NtHnHA58";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9009910E1CF
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:57 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68QGxQ1t474685
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=m3YHNJZHv+9
 lQJD2w9H1e8e2ppiLvEr6xRng+1PaLnI=; b=dHDE1InMEA33pCQxgqAVyeZQBQt
 qiEYM0tHeY/kljnteYXcmcjeQjVgphjj5lwci1mVfrBz7bjjDBzDE2z8sNYYBXj9
 /scqbncZoSxcMdy8ZiSsNrY8Sg/qYuhqp7Si2jqJUuI7q6SLClUgf0nLgyTOLl2T
 ZhREj5/6iY+VyBOSPGxtgo454ReDsT0gaV1yX8rUvSPhKbdUzc4uhudG0Tm6ZTML
 /7fWwNC7CPvsc9BumunZmU2xWuLd66542iKNLJGt4VeToPx4wElQQde1qfjW0Wt3
 c5nb+b4fCHOH50BAxG44WYFfOGyaeNobt9IhE/pfHccVsj0lcE8Vg7CmqYw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gx6939gx6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 18:31:56 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cc795ad1f5aso647106a12.2
 for <dri-devel@lists.freedesktop.org>; Sat, 26 Sep 2026 11:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790447516; x=1791052316;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=m3YHNJZHv+9lQJD2w9H1e8e2ppiLvEr6xRng+1PaLnI=;
 b=NtHnHA586jla8KeMa+qpJvmsAb49KEQhyfn0cRLHj5lQ2mnmfUcqyVhcCI/qwQe4yA
 +XB6uJfGvHqT/jOrkFpXg3nW3Kq02gEmRmoESn783V7ifwNhT+zwcugPIHRrcWnEUnpV
 gku1YAFPU/ILv/qfGpuxlckNO/8s04/V06w+JhyljSYI4qkQ2SWCLXIfkiiTGpLom/kL
 GDYRX9aeLLIlcXX3dPaDDf9eOkSyGM49Ky4d/Qt8upjNfiSAV3CN9O3h53bvD5cNfsam
 xc3/UXwireJFtpCzy0xxAe0And8WmuyzHF+UYu5rxDAjksQsBQgm8aszjdCSEeqfjaOr
 J35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790447516; x=1791052316;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=m3YHNJZHv+9lQJD2w9H1e8e2ppiLvEr6xRng+1PaLnI=;
 b=Y4HkXJ2/O1+m6ntConoHGpeWwgV5SJoEJummg8oU3eFqOKS6kJhWVRgKBi+4k0XrzO
 GAWku2jj6NQstChwso+2ZstlCJRZ2xqr/Qd05PVHRKdcMvCvEtpsD0TC2UwnpfXiCtl7
 9fATa03CoEh9uEEsqwn3JI23a9VVe6c8o1y//FmTm30suT8ZS9X0h+aKisR0hLuBDvSp
 3gpk577FzpfmYlnwJR2whtUNkXZzfz0IyOap4zQ6lovcrLH+mM02kvL2hh12saeY0Ze9
 XEtvhIsSV68xIm5cTo/vGnkdezU7pqQ52bdcHZmA+sMXeGKlqzFFCBf/3dgl8gWO1J1c
 cjnQ==
X-Gm-Message-State: AFuF++lu1i0uKWQvvuSWgA8FlEOcZuLERfCt+ua4rK2eQie6zeGZiYBK
 mNKmUhLVaVb5Id/dgy0NsKMgdRqY1/WIMlcyWiCXkUTuiubC0pbZgaEryMwZXVQsua8MmYjwOrK
 FsZL6OsNe44md7Tk4YnOclgqSEkw1yKMVMgkbUL91HophkaFCQjNvG6hCypQOI9sB3Hxo+a8mAK
 BGzns=
X-Gm-Gg: AYBFou06PsivD+K4OAoZ/55yWYO0rDSGD9IN+O2+sJ97JzLigckhDL6cVgqMpEXmomt
 OYONospQAKuE1D5YdOW23t8ztZA6GEi3kTMORjg5afvp9SoHwJA8hHcdxEaR8d73GgfjM2gSECW
 vxnnJEF6afqLw4C8vdg1g09JBq9QmdpVCl7wQw/VDOtgjj8cjUkK2D4gjSsbpMZ9QdPMp1rnGvR
 4DMxPzbjEykNLbMfak4gMvuL+4FqZnedUORjwgFzADiwan9kE2i1SBXEbVtEAdX46PJjEm0CO0t
 CFxVOGWtdl5R6c5lHUP9tE0sgVdmBljfB4d+ztu8VE2E9jDHjSi7OzQnpk4ESAEgFVWdWC19bTY
 AxNL2ze9lpGWIcUw3oo/6ahP6Lk2qGAOalIAosJ8xutzNhGU=
X-Received: by 2002:a05:6a20:43a9:b0:3dd:a196:906a with SMTP id
 adf61e73a8af0-3de0e904a06mr8183371637.52.1790447516287; 
 Sat, 26 Sep 2026 11:31:56 -0700 (PDT)
X-Received: by 2002:a05:6a20:43a9:b0:3dd:a196:906a with SMTP id
 adf61e73a8af0-3de0e904a06mr8183355637.52.1790447515796; 
 Sat, 26 Sep 2026 11:31:55 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8804b52066dsm2106079b3a.49.2026.09.26.11.31.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2026 11:31:54 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 4/6] drm/msm/gem: Stop exposing a page array
Date: Sat, 26 Sep 2026 11:30:44 -0700
Message-ID: <20260926183051.25754-5-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
References: <20260926183051.25754-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX+Vowlhnjj9Kr
 r4du90VKIijMGyjcLr2ZHzl+0J3T1kVYQR2twhNY4MCQ/7nMbLZheegzklgy8UQEDCZw9HDsR8I
 3RsrCpqZXbV/Wuq7eIJDeOrYTC7YjLY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI2MDA3MyBTYWx0ZWRfX1cY/hrV56ybb
 ayqWdTZKxszePEXFRsJhtUTDHCIKx/Z3pIXzt1DwuQPodNelXBWUZqZStnq65ZVo075mnN694FW
 lXw2ERjTr6IiXzAY9bBnZoFNzII712dWhdPIyueLveqrkNrs/qGq+S02Kgbu/Lz+MVEfiYivvNV
 6iMSxftJ2jiOUGE/RVuvcdJU27UnuLDFck+GN8gn4NxjQ0NAIM7nF7ARgk9JJzeejGdUFs4l6YF
 U5hH3ANbkpWcbedM1z7y0Mr8vWFksCaYSfJM+shpHemWXSDi2EstKXCBE9p2j1BE47jCrdzVjGL
 y8wzYnM8JcnIPQe3iU8RJjckuY+YHPQiosUSUczpp7rbRl/NkH9DLNPrftd092O8x7t9KDSULRf
 oAlsn9XMmaUZraOCjAitXcSjWBqYZRK1PeR480/EJcxXBLvR8GRHyWMBpZTr5hOsSOsybuHJQob
 hPx5ZJwcVyAOsRiujyQ==
X-Proofpoint-GUID: hoSOWufETa257tbAZiKX2bxAO2XOgHx0
X-Authority-Analysis: v=2.4 cv=f6Pdl+yM c=1 sm=1 tr=0 ts=6ab80f9d cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=qy49VNyTqSxgYBYDrycA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: hoSOWufETa257tbAZiKX2bxAO2XOgHx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609260073
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

The remaining callers of msm_gem_pin_pages_locked() and
msm_gem_get_pages_locked() don't actually care about pages, other
than as a conduit for returning an error.  So convert them to
just directly return an int instead.

And rename _get_pages_locked() to _make_resident_locked() to
better reflect it's purpose.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c       | 28 ++++++++++++++++------------
 drivers/gpu/drm/msm/msm_gem.h       |  4 ++--
 drivers/gpu/drm/msm/msm_gem_prime.c |  5 +----
 drivers/gpu/drm/msm/msm_gem_vma.c   |  8 ++++----
 4 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index bf6a8939af7c..2341f209adf5 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -280,12 +280,16 @@ static int check_madv_locked(struct drm_gem_object *obj, unsigned madv)
 	return 0;
 }
 
-struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv)
+int msm_gem_make_resident_locked(struct drm_gem_object *obj, unsigned madv)
 {
 	int err = check_madv_locked(obj, madv);
 	if (err)
-		return ERR_PTR(err);
-	return get_pages(obj);
+		return err;
+
+	struct page **pages = get_pages(obj);
+	if (IS_ERR(pages))
+		return PTR_ERR(pages);
+	return 0;
 }
 
 /*
@@ -310,17 +314,17 @@ static void pin_obj_locked(struct drm_gem_object *obj)
 	mutex_unlock(&dev->gem_lru_mutex);
 }
 
-struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj)
+int msm_gem_pin_pages_locked(struct drm_gem_object *obj)
 {
-	struct page **p;
+	int ret;
 
 	msm_gem_assert_locked(obj);
 
-	p = msm_gem_get_pages_locked(obj, MSM_MADV_WILLNEED);
-	if (!IS_ERR(p))
+	ret = msm_gem_make_resident_locked(obj, MSM_MADV_WILLNEED);
+	if (!ret)
 		pin_obj_locked(obj);
 
-	return p;
+	return ret;
 }
 
 void msm_gem_unpin_pages_locked(struct drm_gem_object *obj)
@@ -487,14 +491,14 @@ int msm_gem_prot(struct drm_gem_object *obj)
 int msm_gem_pin_vma_locked(struct drm_gem_object *obj, struct drm_gpuva *vma)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
-	struct page **pages;
 	int prot = msm_gem_prot(obj);
+	int ret;
 
 	msm_gem_assert_locked(obj);
 
-	pages = msm_gem_get_pages_locked(obj, MSM_MADV_WILLNEED);
-	if (IS_ERR(pages))
-		return PTR_ERR(pages);
+	ret = msm_gem_make_resident_locked(obj, MSM_MADV_WILLNEED);
+	if (ret)
+		return ret;
 
 	return msm_gem_vma_map(vma, prot, msm_obj->sgt);
 }
diff --git a/drivers/gpu/drm/msm/msm_gem.h b/drivers/gpu/drm/msm/msm_gem.h
index 73dafe080bfd..4f681100ecb0 100644
--- a/drivers/gpu/drm/msm/msm_gem.h
+++ b/drivers/gpu/drm/msm/msm_gem.h
@@ -279,8 +279,8 @@ int msm_gem_get_and_pin_iova(struct drm_gem_object *obj, struct drm_gpuvm *vm,
 			     uint64_t *iova);
 void msm_gem_unpin_iova(struct drm_gem_object *obj, struct drm_gpuvm *vm);
 void msm_gem_pin_obj_locked(struct drm_gem_object *obj);
-struct page **msm_gem_get_pages_locked(struct drm_gem_object *obj, unsigned madv);
-struct page **msm_gem_pin_pages_locked(struct drm_gem_object *obj);
+int msm_gem_make_resident_locked(struct drm_gem_object *obj, unsigned madv);
+int msm_gem_pin_pages_locked(struct drm_gem_object *obj);
 void msm_gem_unpin_pages_locked(struct drm_gem_object *obj);
 int msm_gem_dumb_create(struct drm_file *file, struct drm_device *dev,
 		struct drm_mode_create_dumb *args);
diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index beb7f22fd694..b14cda87df4f 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -109,7 +109,6 @@ struct dma_buf *msm_gem_prime_export(struct drm_gem_object *obj, int flags)
 
 int msm_gem_prime_pin(struct drm_gem_object *obj)
 {
-	struct page **pages;
 	int ret = 0;
 
 	if (drm_gem_is_imported(obj))
@@ -118,9 +117,7 @@ int msm_gem_prime_pin(struct drm_gem_object *obj)
 	if (to_msm_bo(obj)->flags & MSM_BO_NO_SHARE)
 		return -EINVAL;
 
-	pages = msm_gem_pin_pages_locked(obj);
-	if (IS_ERR(pages))
-		ret = PTR_ERR(pages);
+	return msm_gem_pin_pages_locked(obj);
 
 	return ret;
 }
diff --git a/drivers/gpu/drm/msm/msm_gem_vma.c b/drivers/gpu/drm/msm/msm_gem_vma.c
index c11d021581e0..311205c7f1ba 100644
--- a/drivers/gpu/drm/msm/msm_gem_vma.c
+++ b/drivers/gpu/drm/msm/msm_gem_vma.c
@@ -1300,11 +1300,11 @@ vm_bind_job_pin_objects(struct msm_vm_bind_job *job)
 	 * trigger get_pages())
 	 */
 	job_foreach_bo (obj, job) {
-		struct page **pages;
+		int ret;
 
-		pages = msm_gem_get_pages_locked(obj, MSM_MADV_WILLNEED);
-		if (IS_ERR(pages))
-			return PTR_ERR(pages);
+		ret = msm_gem_make_resident_locked(obj, MSM_MADV_WILLNEED);
+		if (ret)
+			return ret;
 	}
 
 	struct drm_device *dev = job->vm->drm;
-- 
2.55.0

