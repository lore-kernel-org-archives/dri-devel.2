Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441A606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=IxC4vahc;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=WnyeYWei
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E571129F4;
	Fri, 30 Oct 2026 21:33:16 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0711910E8F3
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:33:00 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69ULDxJB207299
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:32:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=IQvi+0f2Rse
 41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=; b=IxC4vahcMc1L4AZO7S3CcxoXxW6
 w03rEhRkHQDVMCIWd8IjeDnGhXzbKxisVIAYHxt24jJrcKfjIrXcDiIYdopBWaWW
 GEGjEQP2dE2hxmv58aqRtTLvzBeQ/vi5IADI/qlYDiMo4MwEMGXlgamqwplC3NHs
 AsDbsm9E+SOxvoE1mM3z55PPL831DSLxvJHrhhg22Xe63muxVXn7pnwLvJYDs6x/
 oz3fHcNyEoY3dEu203E/J6Bjr4db11DhNB3nEeddTZ2YS8YgHA5I/jRbCYFtmJ32
 2t0+O2uzjUjpBskfJxX4B8+kd/bWOIW4hphcSi9Zfc0DGkgr3Iz0TVL8hRA==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x0g39m-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 21:32:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-3ade5b3ae97so957907a91.1
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 14:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793395979; x=1794000779;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IQvi+0f2Rse41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=;
 b=WnyeYWeiTHNTMYBcixvmZoAwAcoXOS0C8XwTKYbiWvg0xWs5KZBgrYLQaPcWEWmlME
 tMpvHC03x9xwqXfAkwbG/mA79dpVPYdLJGRZegmh3Zhk2T/hZxoEOH3lSme1fvIw/NQw
 mk8KfcNEqesJxPJftTvvkIyuLA2brCcixVVK1utwdLk9IOLQjOzp6/JlXkMSrWeQ+ftV
 UXgYHFkorfTDcZJqqmhKjccDXK0/db/7yIPyb5ptqLhUfEBzuLn0Sfj+ZTy1iayMcav7
 wg43nBOc8kImkiVZ2wOsemKUWdtL4fkTOF0P7eBDHqPWH2D4NqIBp2Zv/c7pKc9CMIFp
 mh5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793395979; x=1794000779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IQvi+0f2Rse41JO3L7I3q1SbrfSk2n59JOoQHfBvPYY=;
 b=FXagrFsgq4mx6caE0UaMcFFQOBjmSzmPowqGkxSldHqkTS/SyAZ93+JKmrXZ5zmcVx
 8Z6dYLoXMQB18UFR43maID0aF3FAU/2LVO8gJhSyvf7HsmSjRf87CWT1STWUOi9vOwDR
 YViEeg0MwQ6YV4gudifdVFwX8FVGlJkJeDp2/WxBQaIS0u+rYvugGwWQqZEDaN2+g1P7
 bn/mdlBgNpvgBkZAjGDUt9l9XCGSQmvF9kvxUy0RLBDPlAUpeKqGRgLMMWi+B4kiEPRS
 xu4umF4Cku7oXTBa+p/9vQp2pcxvB+RldIo/yQoxSMufONeV7x0Wdg24N6yJqjBUsD1R
 z7cw==
X-Gm-Message-State: AFq9FYKHiqV8t52v+ERMBV7b7BPnh/qHE7z4zq8Uvarun/Gk4A9uXCTt
 slwvemaQnMRMjGKDXu2zcpFDub6fxWNCelh68SmucaFXjk53+x/ftyvzKDNuz5VnugHQQ7iN9XM
 4rF8drHPw3DNUoXXzaIYFntoBi8aJVlvyL+s+Sc9EgpmsTPEnfyPgR6aVZhNuHjSzNZ2/r97LT+
 bZufIVxQ==
X-Gm-Gg: AYBFou1JqEIhBD44kSicdYPTlUgiyNd+5+/B5t58uCz7kxbdWwrYPmx5gKfyHaHWW+Z
 kgYUJGpJ6997DN3/hj+yrwUhW95sPVu9Y5Be6zZcTHX77dCQNerm4R+SYUWvugOW9ULs7zaC8P4
 0Erk24g+tzLSJWCuo4+6pEV+O+pVjEHuagmcNNijcdidf7YFP5l2iCKPH/q6JiJETCBmbpT2fp5
 2j5mWnoHXtC39c6hHWj1p9aR9d68mX6LjiUHe2i0IuDczdMIzQdPAJIF5hkOigz56uiN/GavbF5
 qXHp8lmqvJG7PGZ6TWX/4CVVDkdu+lCWvVGdWk6RAT1r510HQAdhHOEeGAoPkXjWM1bDCGYqrud
 bT3mSfc3uI/VdDRy7x5LVO48oFPkHFZGs3HcHflJOR/b1zBY1x7U9nJwjI9dG24wdYTQqgBYCH0
 NPnPG8kJ/AnpyMKLPH1kdhQzY=
X-Received: by 2002:a17:90a:ea0c:b0:3ae:8983:4ef8 with SMTP id
 98e67ed59e1d1-3ae89834f45mr1556487a91.9.1793395978120; 
 Fri, 30 Oct 2026 14:32:58 -0700 (PDT)
X-Received: by 2002:a17:90a:ea0c:b0:3ae:8983:4ef8 with SMTP id
 98e67ed59e1d1-3ae89834f45mr1556460a91.9.1793395977628; 
 Fri, 30 Oct 2026 14:32:57 -0700 (PDT)
Received: from localhost (c-67-168-198-145.hsd1.or.comcast.net.
 [67.168.198.145]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ae845df666sm5339033a91.14.2026.10.30.14.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 14:32:57 -0700 (PDT)
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
Subject: [PATCH v4 1/6] drm/msm: Cleanup if pages_to_sg() fails
Date: Fri, 30 Oct 2026 14:32:43 -0700
Message-ID: <20261030213251.55365-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
References: <20261030213251.55365-1-robin.clark@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TbmVG5vG3HTjBL16-OJ5vN7TgoKNsFRM
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX3srddw9aeWES
 SImj16MjLqd4TwnGTKvQqD397VRaMikliJZLowJtQex48B3JJ48L0hdooeVmb4RN/1yereRZCA4
 Zxlvh9Gca0qzt/3WU3DbpDV6E6woZ2E=
X-Authority-Analysis: v=2.4 cv=IpyL47/g c=1 sm=1 tr=0 ts=6ae50d0b cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=6Rn/7xRx7Ub4NEhlm8k1cw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=aq7xQ8hs3DLR8BDoFBQA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-GUID: TbmVG5vG3HTjBL16-OJ5vN7TgoKNsFRM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4NSBTYWx0ZWRfX1A9iBYiL8/Nv
 YsiCrjS9keq1Ie1pPXzfy/ST20w6b+E/aef46N5VWyjbKv+bTz+TY6kOKozLpYAxuywYyC3g70w
 H2DsuUQH6XHVeQ1eb6FPHSF+CQv0Md3lUcPbFPlPElYltEAmfKx78fflcyiiO5HtrDJBtnt+PeB
 LUkcALU84iGECGOTmpEhcM2s7ltRF9JJbjSSoBXCjjJjuGPn1+MVZLAoeQezfXJhmZbrLdUya+V
 kEmPJjjm+UYnqqLSwgl1338lejXTjb8vy0uooG3nW6LItzPQdqhFLAMsV24xBBu4PUJ9qpn38kK
 AskeRtd6n2+L0o89R4I7jBi+JuYIIUQ6pcwqOCIvtdH8PyTROum3Gz0T+OXFfu/ZtDphTcXbh0f
 EA/AGRgWh88F2yt6KJhctj8AlYZP8OPWcVjT/VvPHxn2b7jezCN3sIooK17KemymTGZfk0GbIkf
 HWQ8cHsRR5waAdU543w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 lowpriorityscore=0 adultscore=0
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

