Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F11D60A263F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 23:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=g84j1q7U;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ts7/gV2Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F73210F883;
	Tue, 27 Oct 2026 23:05:44 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 047B610F884
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:13 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RKtLX62253770
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IQvi+0f2Rse
 41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=; b=g84j1q7UbFXHHUG11BRHlyQpkns
 7og453rDFUjZdav6DgbeW6bCmx35YK424PKxMKoYGuPWWr/YdG7UixYLG7rKCybU
 TdxqzkEYPi0t8ypbtQ2pHocr0wrmuW6HNjLUtZTKWbGA9xi1OJTOzdK1YlZTLP5w
 brJLuKlyVO9MJcNN3IFWfPp9bOfuC6sEbUKdXYjLIz1kIVjGfNYncSWNrU8jYTJe
 PibJA4iFu7xaCkJk7zaz0D4AAo3DA6cJ+INAufqM2YzwSpZvcxrklVp71dVYUm2Z
 eADnFNFWUFt+g4S6ZDaVXGbiwPCM6qsYxHK8qilArhuqQj1i5EqjwwBt3mw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjux9ah1t-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 23:05:12 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-8a0589ff620so302229b3a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 16:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793142312; x=1793747112;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IQvi+0f2Rse41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=;
 b=Ts7/gV2ZlS5WASBTUWnOaUYtzjfvPYyHNKuf2rnSnLhYrlRJK0FZtkzPKWX8d1aKrr
 IWnI4kqoU/EqySeWAKAS8zKQp++Bn0Gk1QTtCTpqs4sTsx4+n9isuE3MFUg47X/7g2aj
 wS971n4V93rVTDBCC16zlyM0Od2wvHoWGogGsVNKEdzucv+QFepopKUDvvWVRNWQODOX
 KSyT3XuUboRD/06TFZnQzGZgwP2R/AaD/ge92N/ECu6VapHN8lb0d77RpA+R9cCweKYT
 9FjzM0/0rls22PEL+g3wB8aWyDt2y/3CaJ1hbEcWm7gGJYDZPwhm0TsYo5wNrwhJiHuJ
 SZxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793142312; x=1793747112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IQvi+0f2Rse41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=;
 b=fCILPxaCm9aqCsDp23/8Ytkki8zZ5PQax2/cllckqKfZAb8KvRsk/ccnJk5o+crJ3L
 F5E+Gu2TJAyzGBf6Yxw4UybUa2OZYDBrPVnpGOKqgq75meY7zDe59rO5lR4bonIo59aB
 XCGdh+hjF6Jf3Uj2OXgjvivqbZVVLc1HQwPzep/DoPEYzYDHWoUB5cDqTW9dRK4pUkz/
 5ZhHX9D7fci7aBCJPEmoIhMieZnE7h34yQMTAS+GZsbQylrcYAR3jS5kJ9lQSiftQWaq
 TzdX9S1KXBOJpMgtiLI4/kO2YRsRJnQFpyBaBVvbUNznnA5/UNvSMYqvBIBIzbHDfYuQ
 TKqg==
X-Gm-Message-State: AFq9FYKSXEcA/mARAbg2CHts96PH/PkNXQ4ocPdz7ATEOeAF+5Yy8sjy
 jAX5j8Ok0h9fME8A8PEoOE/6FYvX1wKtqpB/4NF8PD0RwI3N7LYKeWCf+MroH4JJgUsR7VlnaHq
 I29BRnciR3C/HzyCoQomEejPxC0MbFzJTqnuWHBrjmf66ms9cOUFgmns6M/u27o/ufIePHJGgH+
 OQBg0=
X-Gm-Gg: AYBFou0WT3BbTpYu19l8iRdfGCY0s09evutmEYe/VKbMHjg836Kn/wRg0dKPQk9Pln1
 cseuCPmbyin61VBqzO4CGYjhaqNE1jqAmTkQYRw8pXyvhaXd9axXmG/J/QgTQKVzhMPnQfUSfTj
 tuBvlsIyll05PoCskFfKmhnkHPT86UjZ3dLf/sEM9uWHaVvNW+srWcNkH2nkDVZUi94HpZWOVR/
 OO+VjJyfaX0tHviSzGcAkT8r5stL9QEAaT4aC+m9IkhISgsnTJdbz+kIXmGIAM8/J/NJmx8En+r
 ZDbdNY1F4Ab+G4X8QfsvNgUhWTpKANCfuxotzDqSwybhX6RVHV2QXE9FYQHuMCuC6igCxCwNmWi
 +EKfIZlaMK1ifTW9Bjvx0JacX7sOAILzUR9/+GpsR3P521hjf
X-Received: by 2002:a05:6a00:2302:b0:89c:967a:a74a with SMTP id
 d2e1a72fcca58-8a6e6ff32admr458744b3a.22.1793142311707; 
 Tue, 27 Oct 2026 16:05:11 -0700 (PDT)
X-Received: by 2002:a05:6a00:2302:b0:89c:967a:a74a with SMTP id
 d2e1a72fcca58-8a6e6ff32admr458726b3a.22.1793142311228; 
 Tue, 27 Oct 2026 16:05:11 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8a6e634ae83sm187198b3a.20.2026.10.27.16.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 16:05:10 -0700 (PDT)
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
Subject: [PATCH v3 1/6] drm/msm: Cleanup if pages_to_sg() fails
Date: Tue, 27 Oct 2026 16:04:44 -0700
Message-ID: <20261027230452.130031-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
References: <20261027230452.130031-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=GYyCDgXL c=1 sm=1 tr=0 ts=6ae12e28 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=aq7xQ8hs3DLR8BDoFBQA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: rhjWMRIsAuDlwTJnOsRdBIi6_e-Npz9T
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX9XV1ehjDDZtS
 BgqsJiKtgvIuQVPHf0EevERc/KSBQ6YSzbPrgLccr5uEjA8PSUiNZ8Hi3A1fpxS4vQAXY+/AIge
 W/6Mj2c4XBfT7hujCtC6xgS6eeUhgS64/N5ZcdtUEZejYooH3f+Up/YRJJfnX/FLtha6qLaw3Rk
 tKcvkjVJLytAx4Hpxxpe+QLNSOAEWMCQyDer6qV3B+n57tMp7KU8VRtrGb4oPj+UfzOD08qFrJk
 PHc4qG1klClwNCTM3DRGgjvS6PHh8feakuthC0GTxK7itdFS9074Xfh9dzAQ8oRXUfE1j2bWgDr
 uIklJq7k/AczJY6b+WYlLmkeWurJ5IDHUuXEjGlF6DHjY69IIQd7V4VRGqgbPxyQOpP1xzv9I3s
 KixkLKh7rjYhBtYWhmw2PUCO40udwqBTa7s1fP7gStgKMv8Fj6cxvgbH6ba+m4SbdF3WedskRSw
 buoExEXndeiM5km+DAg==
X-Proofpoint-GUID: rhjWMRIsAuDlwTJnOsRdBIi6_e-Npz9T
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA5MyBTYWx0ZWRfX337OTuvKRAmp
 ES1KLcwh9Z3dLuxOL2EMqy5sZeAKDlfrRuA7RckkSxM7RJqScGiADNTc5mqvtno4Fb1BBjgIwh/
 PQcLYwu1jWgNpEk4AZejqyaTY686MdA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270093
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

