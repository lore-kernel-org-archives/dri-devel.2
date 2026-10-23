Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB22606A335
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 23:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=lv5xqKw3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=D3GdBlVT
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9777A10E736;
	Fri, 23 Oct 2026 23:26:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EBCD112D38
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:45 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NLvgBN3471283
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 PiQ/H+lk7/zKfY8sIc1ubl5QKrW3k0o+FiYvrYPjGHQ=; b=lv5xqKw35Ncp+fIs
 fV7M8GPHLSj6KdgNN2yAG6lFk6NEunQbnI36M8ixckXU4c2bvU2EiEk2FFQamyU2
 RPA7lNq6/BeiauXnlmmtghIDAF2K9jVgcb/umW5ySKWV/ZaBPXLP7mPD0nn2HEZ6
 SsQSe7CZU2lFMEKXrDV2U0UV6NnzL76yqDfLUt8t9+7ouc3dDyXoN/SwcnqgSGmi
 FJ5hWbkAnVq/SmL405kahlhUQyHaW8kdvSsBqqiw6EVmyRuOVRbGtQYQrLQkki7E
 ZVXBkF624Xl4QyrVvmyRSEFzOoLPxKKNl8bKEeZwpSeW1ozGVwsX6GjV7CQloWaa
 43BiOA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hgcrugv1f-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 23:25:44 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-91bebff9fcaso43400536d6.2
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 16:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792797944; x=1793402744;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PiQ/H+lk7/zKfY8sIc1ubl5QKrW3k0o+FiYvrYPjGHQ=;
 b=D3GdBlVT8CZj8JBkmhyqZcfJvxXO+kFtIQdfDXl9u+RTchcrgEKalFJju/NEqkixlT
 8HuyM//SfpyQAK7ATtVEyaTMoSHeDOASb5mNlPvKGUyqomfeHJjYY3OkkAgU/8Jl/+CM
 zRI1MExBc/UJvLLhXqM1a5mXYFmFLi1Teq0A20ItvMHzFw9bv5K+LnNbwoLDE3T7sSCY
 RQlm5mwLs5he5cd+2i7Y/0PgXwmT/sDn8z93TeQedtop70ooBZNZZiBn89iZY2kdt/Mk
 9KdP2QdtlvT9jMA4KMyN/sRB7TS0R6tCV6dbp1/JBvOOk2/Ta2Nys5q+XTR/MTdUsO8I
 YDCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792797944; x=1793402744;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=PiQ/H+lk7/zKfY8sIc1ubl5QKrW3k0o+FiYvrYPjGHQ=;
 b=o0K3z3qMsoTI19KqOGQugrgsE+r7TOCQmRHgrvf2BTbZsC+1DBwmlap8tAm6W3h+lh
 vOJik+9PskgHrshsTgLLgLq2o0gM5fEOrETinvYFYQO5DzQYA5ey3bMTivCJO/eIcXpq
 jIG7avzYjHHYJdeioV+n5onoc3c18eF/14NtNEj2QEelqKnqyQ8zpgDA7XA6qOpZZsZd
 Ec9ht5iCklPc1XU7XCyHHOa/f1/SwBFwUzFAUFD/xl+BK91CN8JfUVlRsDCDOxbm90ZQ
 RxeMsvs7Ik3aCvJqwFEjb3iRyLU4ZCONgrxXa/rkxZPr4kMlzOJnqQ3glqmXJY0Z1A7A
 NPzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByYZGgcaUfuFBZragUPhNB100OhUnVQSjufArMlA+ixqVWA414K4YkK2ofsbvZJuYq5xzb9PzHEz60=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKWYmCbSw29B22rh+xoPF3UI/z3ACqHENSvduWAAYNWEAnTcnEu
 X1UTIEZLm6e3nO482j6A0U6VGgXSnw5Y455KvQn3J3chSHM6Lal61xYeqGfE0nsdF1jZIlHXET9
 ugVEwd6g8bOMWVGMyIffH8PihM1Y5Bc4AsFSG3K7m50Hw90MYUKWaJYn5Eox8dziATrlMdNQfQA
 dDuWU=
X-Gm-Gg: AYBFou2Rv+bNNRYtkrtqN3F0lDsh9/p0mwTaCpznGNp3OFyEM06sNY8DVB+WffnnygD
 ii7RRpNr8qwCvYhlFTgVmBfk8okK5YuUESyEkxpGi/FQd364LzVAApaG2mjDnLpwwh2sYxc79jf
 lZHk5GgQRaf6hk2U1crUrdaawJui6fJbq5Zz6KtE8T3k1HXx7fyZfT09Oc+DM1jNGKgfCa5q/ew
 AsIiOmYJbNWW7dRu15UZMxMAqNf6K3unpU/6QG5JMg9IswaLy9OuFANtXKhPZaJoulo2iH8TMkm
 bP4UG71dtjyF7ykrEbR1fvZ25ysx2BYK/3kRVA/BFrq6XlpEjU7PrwEXLlQh3NRtEbh7Ivxbpd2
 o9RwMvoZngSiEjy7oNXIaAMtCe8z/27OLZqGknbVwLMvnF9X3yGV1MJf4KpxT9OpeuMOLf0df6M
 u9EzL8H09bvSxZ
X-Received: by 2002:a05:620a:4628:b0:93e:c12c:9dc9 with SMTP id
 af79cd13be357-940ef9d651bmr88682185a.73.1792797943697; 
 Fri, 23 Oct 2026 16:25:43 -0700 (PDT)
X-Received: by 2002:a05:620a:4628:b0:93e:c12c:9dc9 with SMTP id
 af79cd13be357-940ef9d651bmr88678985a.73.1792797943201; 
 Fri, 23 Oct 2026 16:25:43 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfb7a9ea71sm60217e87.81.2026.10.23.16.25.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 16:25:40 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 24 Oct 2026 02:25:23 +0300
Subject: [PATCH v5 02/10] drm/msm: fix framebuffer pin refcount leak on
 prepare failure
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261024-fd-kms-fix-smmu-v5-2-a5b0b284aead@oss.qualcomm.com>
References: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
In-Reply-To: <20261024-fd-kms-fix-smmu-v5-0-a5b0b284aead@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Antonino Maniscalco <antomani103@gmail.com>,
 Kalyan Thota <quic_kalyant@quicinc.com>,
 Federico Amedeo Izzo <federico@izzo.pro>,
 Helen Koike <helen.fornazier@gmail.com>,
 Vignesh Raman <vignesh.raman@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=/Y4+Ew8bQbr3xd07TJNsXmM99kEeC3E5cOSJ3Rcs2qc=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBq2+zmi8IM34DRGqWrJCYA9m0kbGboYUYA4FsqH
 KrgN2N/QGqJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCatvs5gAKCRCLPIo+Aiko
 1YniB/94HAdz8UhJFMKIN988mHG26Nn0vnk9L/t9IBX8IZ5deCt2VIY8H/3PYSyeTjTt9MHH7kG
 cKTbC8OZtoaeEqx4L6wpF3/qVZ1Il6AtDeY74Zcx6FY6Sq+C5bNaTbVl5hfyGgFKMSiSd6nxcIn
 6zjkMjNdOo2SwIaoxxgYO+/SaaKy8aktz+C3ABuqMd9j6mqTUMANVhepHxekCtdQZeVEn1Oc9MS
 nJM4hcJ8xunBCSXc0NCRM6j69gLW2HSf/Qo8PYg0AFUQw3n06Okfs0foka1ieXaZ/TpXUF0g5Yb
 HNlDNj6sCtusVaWoi16BVv2Hu60WuOA+oBSB+BKhzBFwY4Lf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfXz7OCF0hodVCZ
 /pJxf031WBsKTL94KqLh3pkGkn62T/d3vjcmWysGXpiJYrbV2Sm84p1j8J9wElqnCH/4fqmelMy
 iL+Zd/yBG8093BGH8SsVuOuLW1HWvCA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA5MiBTYWx0ZWRfX2Qds0dc9BoS9
 zcBmQ+nZ1b8r1Zdzmx/5rvjQpq3j1Qi3NvwOrGR9dNuOyQIfKZvk3fhmAyDy4d4yxnVxyfETnY3
 NbFkvRBXKXKle2z7QABKXdtaPIY9PjlpbaDrIMNj3ya5B1YOs10vasaR+UZjrS6Mv97bCn+KAuR
 BxNCuVjAnqzon32Txj7N2Q4nur2yw0LgMGRxnSw7yEN28ZMflLQKUqsle4WF+DMyzeJxiD6EjW/
 b1HKstyX2amtY0Nktfra22zoZaCr4xOGVLkJplcaK94TZkpesPcujQmL+u8dJb3AVOUSBSQnQv2
 jdvDCxVZyZlTtouK5W29hPMu3VSPchWFWFdD70iYV7Rbx4hnTlHemyHAqIymER0ra/Ak2PcnImT
 aLjNglazBbkMHcgONHJ2dMHusxhwaKPbIvhO99PyHV6T0XHlsJJY40Gj80LH9zOiIGX2uJIlJL9
 8RmhX1zA7x3QFbRAtkg==
X-Authority-Analysis: v=2.4 cv=Ju5kP84C c=1 sm=1 tr=0 ts=6adbecf8 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=oM4tAuVuu9RyGq0-O0gA:9 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-GUID: I1Y5Ujy_zfL303KEGZ3ja8Dm6KIwFC3Z
X-Proofpoint-ORIG-GUID: I1Y5Ujy_zfL303KEGZ3ja8Dm6KIwFC3Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 adultscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610230092
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

msm_framebuffer_prepare() bumps prepare_count before pinning, but returns
straight out of the pin loop on error, leaking the count, the
msm_gem_vma_get() reference and any planes already pinned.
drm_atomic_helper_prepare_planes() does not call cleanup_fb() for the
plane whose prepare_fb() failed, so nothing ever drops it.

Since commit 8ac37c88f991 ("drm/msm: Refcount framebuffer pins") a
prepare which finds the count already non-zero returns early, assuming
iova[] is populated.  With the count stuck, every later prepare of that
framebuffer reports success while iova[] is still zero, and DPU scans out
from a NULL base address:

  arm-smmu 15000000.iommu: Unhandled context fault: fsr=0x402,
      iova=0x00000100, fsynr=0x3e0023, cbfrsynra=0x1c00, cb=11

Unwind properly on failure instead.

Fixes: 8ac37c88f991 ("drm/msm: Refcount framebuffer pins")
Assisted-by: LLM
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_fb.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_fb.c b/drivers/gpu/drm/msm/msm_fb.c
index a38e5b3a1d1e..792d47b4acc4 100644
--- a/drivers/gpu/drm/msm/msm_fb.c
+++ b/drivers/gpu/drm/msm/msm_fb.c
@@ -80,6 +80,18 @@ void msm_framebuffer_describe(struct drm_framebuffer *fb, struct seq_file *m)
 }
 #endif
 
+static void msm_framebuffer_unpin_planes(struct drm_framebuffer *fb, int n)
+{
+	struct msm_drm_private *priv = fb->dev->dev_private;
+	struct drm_gpuvm *vm = priv->kms->vm;
+	int i;
+
+	for (i = 0; i < n; i++) {
+		msm_gem_unpin_iova(fb->obj[i], vm);
+		msm_gem_vma_put(fb->obj[i]);
+	}
+}
+
 /* prepare/pin all the fb's bo's for scanout.
  */
 int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
@@ -102,8 +114,17 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 		ret = msm_gem_get_and_pin_iova(fb->obj[i], vm, &msm_fb->iova[i]);
 		drm_dbg_state(fb->dev, "FB[%u]: iova[%d]: %08llx (%d)\n",
 			      fb->base.id, i, msm_fb->iova[i], ret);
-		if (ret)
+		if (ret) {
+			msm_gem_vma_put(fb->obj[i]);
+			msm_framebuffer_unpin_planes(fb, i);
+			memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
+			msm_fb->prepare_count--;
+
+			if (needs_dirtyfb)
+				refcount_dec(&msm_fb->dirtyfb);
+
 			return ret;
+		}
 	}
 
 	return 0;
@@ -111,10 +132,7 @@ int msm_framebuffer_prepare(struct drm_framebuffer *fb, bool needs_dirtyfb)
 
 void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 {
-	struct msm_drm_private *priv = fb->dev->dev_private;
-	struct drm_gpuvm *vm = priv->kms->vm;
 	struct msm_framebuffer *msm_fb = to_msm_framebuffer(fb);
-	int i, n = fb->format->num_planes;
 
 	if (needed_dirtyfb)
 		refcount_dec(&msm_fb->dirtyfb);
@@ -125,11 +143,7 @@ void msm_framebuffer_cleanup(struct drm_framebuffer *fb, bool needed_dirtyfb)
 		return;
 
 	memset(msm_fb->iova, 0, sizeof(msm_fb->iova));
-
-	for (i = 0; i < n; i++) {
-		msm_gem_unpin_iova(fb->obj[i], vm);
-		msm_gem_vma_put(fb->obj[i]);
-	}
+	msm_framebuffer_unpin_planes(fb, fb->format->num_planes);
 }
 
 uint32_t msm_framebuffer_iova(struct drm_framebuffer *fb, int plane)

-- 
2.47.3

