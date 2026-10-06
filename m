Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0B51CA5FED
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 13:10:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 181D010E399;
	Tue,  6 Oct 2026 13:10:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="p1/5W5uy";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Yty70ngI";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D3E10E24D
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 13:10:12 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 696BPPup535571
 for <dri-devel@lists.freedesktop.org>; Tue, 6 Oct 2026 13:10:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=XHpXieFsXX6
 qHFJWj6txetKx05HnT6IpWTUeLEfybns=; b=p1/5W5uyBDgI05jG1sFDsqFBTr9
 5iA6VJffEobuUpQ70jKlpKhYend3vN2yG0EQxoR7k4ZsEaJ4YBat6bNOrG98q6n+
 j9pzmgg1nPv8L1XjQRVDyEV/y522cqIJS5SxRMVAXnX9++uou0uIgxNDl9L5teXB
 9pWlhxnuUwoLgOaNfG4tHShmjVXZjddXQV5HCU2eOo2XUEfTfP8t3YWRerrG3GSd
 zqNkFyrghPtjjw4fwmTk7zeQSlFXYPQJO/zm6rlDSdD/ed2F5D2nb/uM4jJpdSzN
 R12BgKTLzF7yxlyvL5c6GGJQvyasDolVR76yOVjvbI5wCiBLd9y5cX1a2yQ==
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4gr0bns0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 13:10:11 +0000 (GMT)
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-88bbc27f85cso3666150b3a.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791292210; x=1791897010;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XHpXieFsXX6qHFJWj6txetKx05HnT6IpWTUeLEfybns=;
 b=Yty70ngItZ+vWAzvupsu4+s7yY0BVO9tjJ4dqBewPsjniGZ/kb/e+zpT7nvJdc/Qk2
 /249KL+n4H0aOc1br1TT223dMCEZGZF3lF69ulcaaZR53hlbIbD6BFWlBBX4YARJwMls
 4AVsXR13ivL14WymFsrLh9peFUbbQ/fhEogD7iciiW7aCBLO3mouMtMLZaAFYCXvQwxa
 SDBwNxuDlsHiwbDu5vt6bCHNbsNocmBwEmH/l2vIc2viC2wCyVluaYcLLPfBlc+J7Qrb
 W67nhTAYQX4P/DoRh3BRLcv8feSfrtluh0mzzPdoGjKfjVUa2CqPp1PWlFlqbJTwHkyc
 xp3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791292210; x=1791897010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XHpXieFsXX6qHFJWj6txetKx05HnT6IpWTUeLEfybns=;
 b=gEMj9E97i2Gjd9y3waZ2hKI6CC0/nU4QjXqmr/nSsxaLRlWXssz6dUTq3tfglm3uRu
 tFoJjs56KdH5DfxGrudb3VgNb+Rlx8sT8QGe4YJ05AHA+wA7y8wT4ER2U38RLusbmE+0
 HkeQ4aNdYKM9UcT9lTByD9f0TOT5L7JtkCcsu8tVFNgGSakdnEXxeQYvADruENn0Fz+H
 eun2tlqAGcx4npu2E+2QjCUcpdms765Ez9aoM6EUErfojkesByZwjSotLD9yroSEgruD
 J+l9PbiD9SaCkbUT+Mw+69t9qSV1HBetIqFjtLz8tZ3dkmURaVXL+TMAJ4ZvtdS5qC4w
 qevw==
X-Gm-Message-State: AFuF++lC4j4Kx8oZncZePYjMIzbHZMUwBUdIsFd61q4csZYsmLm+Ovxi
 sWUSbQ9gs5fyGVFiICQq6RvoLQHy8Dlo9ZhVSTcoax1pHjoU9Kncvv4NYZ58U8PWOSpcbdj2tHi
 krDvWnBSHGbRBZZwLsOZv/WZoycFSqJc4tq1tnko4l331YymTewTRuEYEb0esCd6UWC/97TVu/N
 UC/64=
X-Gm-Gg: AYBFou0QsCvNVnpWHM/7awj9iV6R6TvlOK6D15weOrwfDE5TeXMK6CIA4nIdYclUfey
 NHztzIQlU36An1bLwh78OTseD23P8ebcid2RzH1surn2EIXOzgPNxYya5eQ7+hFUXQ78BgHmvR6
 A5V1jQUZIgXfNbLCtaZf2u6ubGLKs4/ji3uC8YaOuo1o9GzOTWBxiSB9AbZZk0gtkS7UGwsfcel
 Qse258yxxY6SR90R7KH+YrQ48eEaFiWvSk6OZ0osgbAu7VqjsSu5aXnLeEOthMss+85LmSd0ZAd
 EblDtQ4LKXt4UC1/KmI9VaDBJIUmFFPdGpDCoznrwtbXxw97iG5gHhMq2+yfciRbGiq+cC77J7E
 HhOWT99ND3aSQYd8j0oz4DD566CAb/oE0/vXGk9OS0qkN1g==
X-Received: by 2002:a05:6a00:4b52:b0:874:706d:856f with SMTP id
 d2e1a72fcca58-890debc9693mr1171595b3a.32.1791292209905; 
 Tue, 06 Oct 2026 06:10:09 -0700 (PDT)
X-Received: by 2002:a05:6a00:4b52:b0:874:706d:856f with SMTP id
 d2e1a72fcca58-890debc9693mr1171559b3a.32.1791292209441; 
 Tue, 06 Oct 2026 06:10:09 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-88b0c3a4498sm4744401b3a.31.2026.10.06.06.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 06:10:09 -0700 (PDT)
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
Subject: [RFT 1/5] drm/msm: Cleanup if pages_to_sg() fails
Date: Tue,  6 Oct 2026 06:09:52 -0700
Message-ID: <20261006131000.81501-2-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
References: <20261006131000.81501-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfXzffu2/zQ2B4Y
 eIBA0snwoYPHn/h1sHCcEnJvVleecbA/oBfdPsLw07xkWKN+kUJjfI0u/LmR1FRKZXz5P3WHvHF
 nRfuG7WD7yoF+Gjyf4c5oAWAGstPWJNFrrLDfZ3epf6QXbjTNHdAgbPxdjKjuD1UTVMsrS30B7A
 DQ9t2l9xCxg9cD3VYkEE6xFjpVEqbrVo9xXiwJYzQLgz0xmoZNfCBOeQYT12WZEV1dQM0UEwGVd
 nzLmbOEYCkvAR79SnsrgJP0obt0rOGkBGtCNBnUUcZUeq4bfqWZpzsxe74ofQiMv/N65wqdyNdH
 JL7gFjfyUaWKF82pOsPmH7TBLgMb6fiswbXESMJeCFP5ZEbJ/Wy+Fd66+g/sktnB9cq3JoiRU3d
 U2dPlDEBscmPH8W8DNxYxDZY5jm5TBzl72R5VY57FhgydKVWWFkixVtxWq4VqRK2QNgepdOZ31h
 ItlOqoWJ79jhyf+YSwg==
X-Proofpoint-GUID: RVeP-3G3n9015YMuOwaRXinOzzVbwK5C
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA1MiBTYWx0ZWRfX6Y7KBkS8JP5h
 wJc0zAhcGqnKB+HSoRxbVZ5KUSsSuxw70BAL+FHTKIPZXebIXgRHuKSJKu/sAAiHWfDT9GCxCjo
 WbBLsdT8lWKUUjo1hSoRu5yqcyr0d9o=
X-Proofpoint-ORIG-GUID: RVeP-3G3n9015YMuOwaRXinOzzVbwK5C
X-Authority-Analysis: v=2.4 cv=BrQIUoX5 c=1 sm=1 tr=0 ts=6ac4f333 cx=c_pps
 a=rEQLjTOiSrHUhVqRoksmgQ==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=aq7xQ8hs3DLR8BDoFBQA:9 a=2VI0MkxyNR6bbpdq8BZq:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 malwarescore=0 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060052
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

We never really handled this.  But in practice mapping to smmu would
have failed without an sgt, which would have been pretty obvious.

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
2.55.0

