Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67049606A336
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 15:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=LfiPJpxg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=U2ypPGLe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95BC110F676;
	Tue, 27 Oct 2026 15:28:46 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F288010F669
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:29 +0000 (UTC)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RFKw1D2242131
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IQvi+0f2Rse
 41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=; b=LfiPJpxgxqDN1jOOc2kc09Dt+ic
 PI4CGH3S/uz3OVQaYks7W8g7UAlAJlqVAJRaDCe5h5lOqv0WIETC+z9W7zpLDgZX
 2KPG8xkoj32Ao6qWJmP9hInwa9YNhq4J2JPXWABumBRStAfjkKJV1n43tJCMrf7H
 0o3DyAHEn/W4VKOB8qdTS2dgbXEx/gHpZKfLbrGjYtwoXIM1zVPbPWc1/jeau5pZ
 C7WRsTJhtKzDjqbZahmE4nDINrpeEfY+BEuZXjoGyM4bULN1aTeUqxjr5klgPA0a
 JGJDfmzbI/PWHZ3OXVG3w/QaqbfzX+lCAbh3Mol1xhllWIrNPEnSabLeCDQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjqf5sy97-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 15:28:28 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-8a01e2962a1so8056b3a.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 08:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793114908; x=1793719708;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IQvi+0f2Rse41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=;
 b=U2ypPGLejp0PoucCJKUHcxjx1rseisrd6pPnieOQmPS1pPM8nhabZ/dDZQoN9nOR3F
 2BdIUPMIiyPkLkAG6+sV8/ayJm6tkkHEj49QWQDIPyPWFaxl6yWfyvjHLbwT272AbQ/V
 S9zaF9uxO5yshqMnbNPqxVeJ+UB+9LgWMgxWmXshFWSSnYDp41QiyvKIerzY+tkVbmmW
 WO2BwQalaa0fBnXooMC+HqtaI7x7rcc+b1eFVO4wYkC0hh3NSxxORcOQ8Pb57njWqIw2
 T7YJ2WNXuSZgCg51L+0YOMGtzW1eT+ZzvnWJorqw5N4hBLiv9YpSVp7cEEPnaFRSgNk8
 59Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793114908; x=1793719708;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IQvi+0f2Rse41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=;
 b=0YAWtQNjBkacGalEvZWMz3+nEUSN2UdpBYpomiEiKR5pmk+dZm+RHrwkTYJZuF+ik5
 e66oqMAVfCRCqMLRwriYAcDwJl+VPkJ9jyk8m/cV+65mSYHOJ1GXGmVKOrNTLf5rc94K
 jAvcDitRdg+IRwFCnT7/EjZoh+6hA1Sy4WsXZBhQUJFNUmntePYz+llj9IEnztbbHIkN
 d3onFNfg+A+axkp6vDpoIkVdmDGtjjEeodYN9ZqUAC3feUBQGUtsJC9/xR6dLwHk4IeE
 ld7N2Mrx9lJjrLSh5thOBowPOSeEjpU6RsXP6+SRjEOd+0JcD9GhxFejsB+ME9qka6N4
 bmxQ==
X-Gm-Message-State: AFq9FYI0XWrUpm+j0jtYXzpHmAGBrujAj4Zc16x/awuatBKtDikJF2Od
 kPfD9UHpKMwjYsdkqXlc4tncP7K9cXfe/SK1UevEyVX/7a9zE8rV1Reu8gtNmPkrt0Xqjofdl7D
 eW+Tf0M+OKmLvXjh9FEpEbgmD+FNPrJv6UQMf0mYyZO5O9U2adEO0gWUFlh/0hm9gUnd8cvGCHj
 3PD2s=
X-Gm-Gg: AYBFou3YM6pgrC0ExzW8RoyKFHs+ksvQ3GglLr02SDt8NSFO5IfOJjcbxSeHPK05GCl
 s39a6MxbwCATUSl4QXxEuw1oRV/6LaRCMRnMd6CwX1yH4D/jw4DDZDmdzbuWL6rPnVktFR5IWxl
 YFzqlS2TdL56pMkrZdf66BdSvCctOgX18vmchkdPrvr5q2FXwy3huF9FB1elRSPpsvwYrKRKQpc
 qNNtFDWogvYqxsRPtxVm+jSdRw0S08tdpEbDQ1sbJeIJgH2BFWPUHEQJBrxbtzHbblB3P+veFES
 Ik+13+4MyfbzjqBQnN9COCZM+4QdIqVbno25aLCz7hiGvW+XDKQuy3ICBtiK5qp3f6DzCO43Zx9
 /M5wRgD534APcRnsfTz97CzoJBiLPQ95xEsUis3Lf48jRhbKGog==
X-Received: by 2002:a05:6a20:3c8d:b0:3e0:ba43:3d3d with SMTP id
 adf61e73a8af0-3e7af8001f7mr11738548637.9.1793114907764; 
 Tue, 27 Oct 2026 08:28:27 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c8d:b0:3e0:ba43:3d3d with SMTP id
 adf61e73a8af0-3e7af8001f7mr11738530637.9.1793114907312; 
 Tue, 27 Oct 2026 08:28:27 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6a6cf9489sm182649b3a.39.2026.10.27.08.28.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 08:28:26 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Jianfeng Liu <liujianfeng1994@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/5] drm/msm: Cleanup if pages_to_sg() fails
Date: Tue, 27 Oct 2026 08:28:15 -0700
Message-ID: <20261027152821.51144-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
References: <20261027152821.51144-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX3xLD8ZOneIRo
 KXbzGAuBrlffg82w93Wl2l+ugj5VTFAoGBCj9Z8eFMI3H1+Bl81POHZaZxDv89KmzXSlR2gHrHF
 ob66IBbvPJ3rQPRq3HYNPqW84eogPQU=
X-Proofpoint-ORIG-GUID: pHoc6Tdlg9l0eTSzG2y_38xgm22_SrHh
X-Proofpoint-GUID: pHoc6Tdlg9l0eTSzG2y_38xgm22_SrHh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA2MSBTYWx0ZWRfX7b3czWURnk2A
 jGMB9ikf336ehbQyV+LPY44Yai9X92RNYMAmhM5fs1yVC3US2z+V8A4ViFER0OEqJ/RUrw5HZNf
 RBd5kF9lJ4Is3ZmPralfCXj8JWx0f8FPFM7PezRZqHCoddO08hIn16y3JGtxl8efjIXc5MdqKx5
 lBsP5YJlb6w3TVIlDVwJeuGbl33eoYXbxyuNnZcnK6RCjzlzdtETvtZkt/pxEy1OQgbHf2JfyJ5
 S/frPDYXG1r22MzxSvJaf5uqGVHwcqqClY704IMp8bigCUvhQxCFpTl7/Gn3mQyF+fUvdyTcu9Y
 dRrzrLp83Ef93Prk2701mEVpuwyXj6v+K72Vws7fa7ZiMgXt1b9cEb/DHFFc1hoNTQZYHjLh7ag
 iJ16i6vyy1LzqwkYMDkLjNAVusHiUBzCk9loK6852edylkh513kEn/9Yz+2ossxZJY3QkbBgPXZ
 8MjKt4+fqCFNv7qvjnA==
X-Authority-Analysis: v=2.4 cv=UOFIjyfy c=1 sm=1 tr=0 ts=6ae0c31c cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=aq7xQ8hs3DLR8BDoFBQA:9 a=zc0IvFSfCIW2DFIPzwfm:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0
 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270061
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

We never really handled this.  But in practice mapping to smmu would
have failed without an sgt, which would have been pretty obvious.

Tested-by: Jianfeng Liu <liujianfeng1994@gmail.com> # x1e78100 (Acer SFA14-11), v7.3-rc5 + this series, CONFIG_DMABUF_DEBUG=y
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 41 ++++++++++++++++++++---------------
 1 file changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 130ae27ee00b..181b9ad32672 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -190,6 +190,7 @@ static void update_lru(struct drm_gem_object *obj)
 static struct page **get_pages(struct drm_gem_object *obj)
 {
 	struct msm_gem_object *msm_obj = to_msm_bo(obj);
+	int ret = 0;
 
 	msm_gem_assert_locked(obj);
 
@@ -209,19 +210,17 @@ static struct page **get_pages(struct drm_gem_object *obj)
 			return p;
 		}
 
-		update_device_mem(dev->dev_private, obj->size);
-
 		msm_obj->pages = p;
 
 		msm_obj->sgt = drm_prime_pages_to_sg(obj->dev, p, npages);
 		if (IS_ERR(msm_obj->sgt)) {
-			void *ptr = ERR_CAST(msm_obj->sgt);
-
 			DRM_DEV_ERROR(dev->dev, "failed to allocate sgt\n");
-			msm_obj->sgt = NULL;
-			return ptr;
+			ret = PTR_ERR(msm_obj->sgt);
+			goto error;
 		}
 
+		update_device_mem(dev->dev_private, obj->size);
+
 		/* For non-cached buffers, ensure the new pages are clean
 		 * because display controller, GPU, etc. are not coherent:
 		 */
@@ -232,6 +231,14 @@ static struct page **get_pages(struct drm_gem_object *obj)
 	}
 
 	return msm_obj->pages;
+
+error:
+	msm_obj->sgt = NULL;
+
+	drm_gem_put_pages(obj, msm_obj->pages, false, false);
+	msm_obj->pages = NULL;
+
+	return ERR_PTR(ret);
 }
 
 static void put_pages(struct drm_gem_object *obj)
@@ -246,18 +253,16 @@ static void put_pages(struct drm_gem_object *obj)
 		drm_gpuvm_bo_gem_evict(obj, true);
 
 	if (msm_obj->pages) {
-		if (msm_obj->sgt) {
-			/* For non-cached buffers, ensure the new
-			 * pages are clean because display controller,
-			 * GPU, etc. are not coherent:
-			 */
-			if (msm_obj->flags & MSM_BO_WC)
-				sync_for_cpu(msm_obj);
-
-			sg_free_table(msm_obj->sgt);
-			kfree(msm_obj->sgt);
-			msm_obj->sgt = NULL;
-		}
+		/* For non-cached buffers, ensure the new
+		 * pages are clean because display controller,
+		 * GPU, etc. are not coherent:
+		 */
+		if (msm_obj->flags & MSM_BO_WC)
+			sync_for_cpu(msm_obj);
+
+		sg_free_table(msm_obj->sgt);
+		kfree(msm_obj->sgt);
+		msm_obj->sgt = NULL;
 
 		update_device_mem(obj->dev->dev_private, -obj->size);
 
-- 
2.56.0

