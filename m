Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACC17C53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B28810ECB6;
	Wed, 29 Jul 2026 15:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="YUurCzJf";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I/sHTnRm";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39A6C10ECB6
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:08 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF2Uhb3341274
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=+vxaHAH1d7u
 WRj+vRMqPMMyCu77C7ZHnpa7ie4VJLtE=; b=YUurCzJfQJ8tzbHZopcXBmX6lbf
 dZPtHQzqOSAEwf7UKQC6EpeOh088W/UDcX55S92F2CulQ7n9RZ/tF51az0Cand1c
 qeZB0VW88mcPI7Me4W3/qMtLwalr6KuM1y16kEdlju7uxD8/tnofAAzF1J3PDnI6
 C8MGGfSsPpI48F/32JbTWpcUOqMsNAuhkG+213Nnvg2Bo/PbphkqjtHzgACVSRQ6
 Om+DNvSpyGTdHUPKH82AgOBLtIctGa6Yt8bMOMAnVCFT14+kVl+MtiKipo+o50l0
 GITBd5HiQVoZesvHDY7heYV01AmcDuYX8nSezk2DihzkiU3jGXhgJ9N8sRA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3ms6t2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:07 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so108035ad.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340627; x=1785945427;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+vxaHAH1d7uWRj+vRMqPMMyCu77C7ZHnpa7ie4VJLtE=;
 b=I/sHTnRm2fX07gVSWLYv+WHMqMbWD+MceZRJt3cg01Tfh34tO91+2/PNA0RpkPYqJd
 Jmg2FfLHoLs9RXhwGQ13RDjjpbh3c/2yOtr7umWcridL7cS0dSqHAQ5OmhimXI1E/73v
 HUVgDC9c3Eadfoip48rySYkOXhUQFSFsOWZbeq4J2gnx8nMHggGuOw3HM6pM5rqRl4KV
 caK9WeSvLbPc2FmveCz0sjq73V2YAyyvkcJi4pjkKo3Xtz3iOXropm+MFqGgf7nZpwTk
 0XayYuKSWYrmeoENmey9P2fNEHdL1eEOl3Sqaem18LkaXEZMYnvrSU/2+w/9G62Bh7hJ
 CVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340627; x=1785945427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+vxaHAH1d7uWRj+vRMqPMMyCu77C7ZHnpa7ie4VJLtE=;
 b=tIPdr6rvX+FxwWAH/ohXawzz1VqR3sRZ/YQaBxIdGZ2t1dUyERlJ88jgW77RB/Tr8U
 rlQkd2g+9eD82TjW6S7TdtSENksDlrhjsMPthUUduYA3vdQgd2PBunQtMrG4FEyfe9vl
 GT2wkTIYZNe/7V0DQA4QjCpurKCluLzEB5XIdEERDWxNV6djHUpd2TuicgGGtf9IQnIq
 kBgUidg0il+jMRA/BcBHrvHnIhrTUKb8a2nELPGxpGxRedFvzG9cWkEJAiwtKgrntF5/
 WyOs5XJQoRe2z7PuAnaNlj/BPMSGgrKbQkgFmb3Xp3WA3U1cScxNa6+Rptgx5jJYIEE1
 i0PQ==
X-Gm-Message-State: AOJu0YxIo3C5y45Dc7XEw2U9/s09rJM2O+LuOFCceOlkK4WhHksbJAnW
 CQEEwCHRmi9uf9ZB/EBQUB7eCZX0BVxv1pYjKmL9PH/SFcz6xq8nwxZvrsBn3YFiqVXAq14mlRU
 ev8LmYTizclUyBulBBJ+RPEXveu+D6v3EwQPhWgNt2XnjYmri1QvgBawS3H8uH0Ktxd1HptSrR4
 ZHtus=
X-Gm-Gg: AR+sD11n+kIrrba11sSkfHT+PPC1ujiAa4XP588OgkNbtX8XsnEDsDOvZaJwC6OGXjy
 MCJ51/Clhz7OQyyvT4PWppecvGqoBNoZ5LOlNtorJrSAlrCFaB9lWczKLVIiQinbe/2biXg/hvX
 bHLJBcuH3VqG+xoFC/4gxj9p6jaObgJmOgrqG7b8qP8wjbLcSZVPCaWaXiqxqx90JzcoUD6PVU+
 ufkdNHUN2FLjzE5TWbM0HNQ8BPq0JPgznVDf8YylTUW2n2lzsCl+xQdNOPmyEaxqQNFwAzX/jT/
 KNmsMVRxWlpu1jXVOFNqKpLUBMUb1+V8CjVhlfwYwDtL69nVNrJ3QwOsrUB4/8JjM86mGn4Bfhz
 hSr24guJPFt4xLFaIxtEgNIXMv9bxCBlM1QBUgyPPOKGoeYU=
X-Received: by 2002:a17:903:26c8:b0:2cf:461a:3863 with SMTP id
 d9443c01a7336-2d02676518dmr31347295ad.22.1785340627078; 
 Wed, 29 Jul 2026 08:57:07 -0700 (PDT)
X-Received: by 2002:a17:903:26c8:b0:2cf:461a:3863 with SMTP id
 d9443c01a7336-2d02676518dmr31346935ad.22.1785340626645; 
 Wed, 29 Jul 2026 08:57:06 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022c2dfb1sm13546035ad.72.2026.07.29.08.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:06 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 10/17] drm/msm/gem: Remove useless locking in GEM import
Date: Wed, 29 Jul 2026 08:55:47 -0700
Message-ID: <20260729155609.20190-11-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXx83KZjgibzGQ
 /eZjXebZacACygIRToGylDLkVYZiw8T0eL9Ycpozy0VVU6hWeu1HWGelM1MU2agwFAr+TdHjldO
 YoWCA/xXWficVCZFT5uNmnOMgPwGLbspwr611zoZX43DPj5sIJuKeFh1RPPQT5EhuoZef6eN9Ly
 E7s0niM0FegvqHxymghBxhxLdEy4JvGZeCUSncPfpgx07ULne3r3UNy/LTNFBnq6Clsjz1ueae/
 Id2W0SeLgM2yod3JFqI3DrWwvZP23J8gaTp4bT3Fp1CUgyCjna2dmgBjwGsaa4JSRUfgKDu+/4w
 9mh+ta0hRIAAKNLG6cCoN6nxUKYYhGtDDVJdH+EjXbcKTyk9Z0RKOfZmdaej4/NIIjnMYS13znE
 1siMSABNiwBxtcgHVHmKpg5KAEMyMODHWVK4MkXDL2+9wRf1BaYgMX7IX/lBOrrp19nQjksKamt
 EoE0sdiOPFILTH5BeGw==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a6a22d3 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=eWlSUfSnBrBg5eVjM6UA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-GUID: IbML_9N8rIy1S6i01slEFIIJyyDKLB7L
X-Proofpoint-ORIG-GUID: IbML_9N8rIy1S6i01slEFIIJyyDKLB7L
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfXzTyQZSrAmEyD
 6EcR7hXLHMm/8LxXYlfOI0RSm1jc+ClV6+673ZOltORych8eT3XfDkSUJx5tPjHUHhWgAIgLNNF
 QBmeE8Eo10ddJ8e9L9+VXkPowaqOfeI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0 adultscore=0
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

The locking has changed a few times over the years, and this extra
locking was the mistake of evolution.  Harmless but useless.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 74c3728f45bd..cc45392691e5 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1310,22 +1310,17 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 	npages = size / PAGE_SIZE;
 
 	msm_obj = to_msm_bo(obj);
-	msm_gem_lock(obj);
 	msm_obj->pages = kvmalloc_objs(struct page *, npages);
 	if (!msm_obj->pages) {
-		msm_gem_unlock(obj);
 		ret = -ENOMEM;
 		goto fail;
 	}
 
 	ret = drm_prime_sg_to_page_array(sgt, msm_obj->pages, npages);
 	if (ret) {
-		msm_gem_unlock(obj);
 		goto fail;
 	}
 
-	msm_gem_unlock(obj);
-
 	drm_gem_lru_move_tail(&priv->lru.pinned, obj);
 
 	mutex_lock(&priv->obj_lock);
-- 
2.55.0

