Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAE4DC44521
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33FCD10F60D;
	Fri, 17 Jul 2026 20:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="gfOugpkw";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j0vV13qX";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E8CA10F602
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:07 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtPCt2751703
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=4CMYyKDJ3M5
 3142fIiVcs31bCTT449JO3xTuz6WbmaE=; b=gfOugpkwMNnJ9ADd9groXhgINwx
 Ppx3Hn1x3EqK0HopesfVxLqI+3OzJsS3bdOPTlBGOlB/lYoqTmotV4zk6gcEgBfb
 nmfhqzYiNcIw85qGWWLP4hhcWPGZl/6ocLXAmaL6dCygtxN/BIbpM+3c+M9HJVv+
 58Sj4Uuu3TRRcf3xGoJaotq/ScHY4DGzWG5+XBFRFi/eAAJAQ31y5lVEFiJpZ7FF
 syd7+o2BjlwDbHutDjaJ9c/O7yQFpbQksNiFjWATerqIIvUunX3Bw411AR2wbbzS
 zm6n4WIsE6arkWT49L/zop/OTV+AtvoNuEq2IOdUGCkrORu5p0kbp3fdGNA==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ffpug1ax1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:05 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb6f6a3f4so33918645ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321345; x=1784926145;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4CMYyKDJ3M53142fIiVcs31bCTT449JO3xTuz6WbmaE=;
 b=j0vV13qXRRX5gcR1JznsmwKPLyrAxfptXH58pVTj56uItBXOgyNRVf3owdURbYp+tJ
 hNf0b8OGzdIvLWqeN2RLQifJmS0hkxCJeAng1j/ZhPB35F3b1iZlbgsFXMJRWSYsKyzt
 PDrq0sB+XfXgoSQ/MSqZsdNq1wRbhiTG2nIWqQjWVeYU678knVbrp0TP3Q3ZImI0OGBg
 tUxmqoBOHsKoMahsb9gLVJfVY/Z6I0R84nYP/oWD0VIoUmdzOUV4KnLTFCtpDelZREUo
 xNHDxtb67dyIKMLVC9xjf7Bt5jFhx/2Lb6IAkwQu9V0r6FCvHC/E+qHrQsXTfJ/TgPEG
 PuAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321345; x=1784926145;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4CMYyKDJ3M53142fIiVcs31bCTT449JO3xTuz6WbmaE=;
 b=fB7dDzTB6ZIvADRZIdxK3TFFgJTVKaS3y+54B8ckGQp2u4KbGQiSksGKby3xzMZY3E
 QPNJ6eRR65sXZiSLcGQ48KRA8Q+JFZuRXSIqGbHxZUy9LEUtlrvKQHNjMXtFAj7FEa86
 VFYk/PmrHd9678k0zNF5oulMJQL+9f6oYdS+za2FfacDHR0z7jJhJ7c/LthoIQibaOpQ
 KBaNFuLPzvbaeFnCZMm3oqU4AtyjIMMSorkQwMZWfZq9Mg9d2SuvmL9DkD3houQTnaJP
 ixM3rx2i8bv81SLG5VmPPASMo5WTyKgmigQuujF6NBQhP8KQfc8gr0ZJq+QiyUQKgfaV
 sugg==
X-Gm-Message-State: AOJu0Yy2PsKkyMOhVZGNkpk4Q/qfzmDrYipZUs8WHvZiZ6jVcUhh11qy
 Yj7bD+yx19qqKaa+OIZXh+qrNvbMtpvHlwB/ld/u9iLyiZJVqJi5WGXZ+gk8PpUerD84c/9buOC
 YhovNo6f0o8kw+m1ktelpHaPYtjDNCzU3tqTxFF9+u9bW5fBYcvbNIu6CMw1yi0jetg2WmbPrrq
 E2SrY=
X-Gm-Gg: AfdE7clwhnlcVRd4dFgkf91osFe0MTGqac/kOko/CwTkcHeoBAe4aEFfw6Qse/rms1C
 IcJ7+CyPB69z7HldWNJZKhbwG+DXhT8YBdzAJMR1wAudKjNvHpuy8GudQRSVtvKTljtVGNxgrE2
 8TPLdD10s+V953WHRo1MWqvNsXsewfLInyz3+SKpf3SEqsf80lvLmH7U8tpdRkgEdqlJuQLjzWx
 3nFrhYduEhmHDnL2Yu7OIo1yLF07RnCJerl6Zd8+wnD3JJ/3lmPNg8sc1XyX2RvQLiPxl5ZKbqc
 x7vZh5i76rdOA0pCkRp4gX4Uo0GLKRH350mUnFN8EeUbsLxML/132qoR4qpx4nztueJ+qmVd5jE
 oSA9mT632XZL32LSOc64r5tdrdI9MV5kk3gnw/oPIzdN4Khw=
X-Received: by 2002:a17:903:3810:b0:2c9:fc0d:165b with SMTP id
 d9443c01a7336-2cf1f544ef8mr91319345ad.23.1784321345043; 
 Fri, 17 Jul 2026 13:49:05 -0700 (PDT)
X-Received: by 2002:a17:903:3810:b0:2c9:fc0d:165b with SMTP id
 d9443c01a7336-2cf1f544ef8mr91319135ad.23.1784321344618; 
 Fri, 17 Jul 2026 13:49:04 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf344f12e0sm16778325ad.31.2026.07.17.13.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:04 -0700 (PDT)
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
Subject: [PATCH v6 10/16] drm/msm/gem: Extract bookkeeping init helper
Date: Fri, 17 Jul 2026 13:48:26 -0700
Message-ID: <20260717204841.26120-11-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX3wnS+VTTFq2e
 V0JS7r9jm2yezTcJ/6BYFcb78C8eSaU0W7Vvp8CnXsZbxCtn9vX2XZfiC2A3abpv7hpzUbMnuo+
 7r/uqcRT5cV2rdSLFSd8JpkBUv5830nSme7yPbfcGm1U4FaFyb4kAO2HR4v1nO5uGZJdPF4U/Ef
 pqdLVupBFFljQ4WA7Sg5TvNydfLSRzYsRB7ILNLdqZBRRxUiDPrjFLUQdRGQ4DXxuKDOlbDyvB1
 U/x55TgMOzuAKRfEtt9ADkqE4jiAq8A1SLoHL9Jnlc/xEQDQMbnIYiqxK6HCBlAW6Z8O6JYUoJB
 GDBWnnLFkF50Fkz0jQ9zy/U69kVxHoflZhJOcbNqKDeLhtvsuTGwgFU8mUZQ6Zjqg7iZLKqXCRk
 IYptx0W9T33CSyf0tEJn3jxDE37XmUsgVXQOGoD+1GMBT2wBXkMOvprOlsYZoGB2hNLwWYvpstJ
 LSLLz7aOW0oSuZO2Ajg==
X-Proofpoint-GUID: HoSrRgy0haRPiXqafx6upQhiPfwT2e5s
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX7TIXX9mIpLnE
 22lTRsd4qsVQBqf70Wv29QEgUgWLUdF9d9BAzrUs5YjmrMjVGvh3RnleTKXUiJvhm/ulrLxiBKI
 XwHTaH+hxtf6MK63GZiLL7qDA6JZjmQ=
X-Proofpoint-ORIG-GUID: HoSrRgy0haRPiXqafx6upQhiPfwT2e5s
X-Authority-Analysis: v=2.4 cv=Q63iJY2a c=1 sm=1 tr=0 ts=6a5a9541 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=UD37_32G2j58TxomCrsA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 suspectscore=0
 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607170214
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

Clean up duplicated logic between import and new paths.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 34 +++++++++++++++-------------------
 1 file changed, 15 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index 1aa844ce4f2c..59143be07428 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1232,10 +1232,21 @@ static int msm_gem_new_impl(struct drm_device *dev, uint32_t flags,
 	return 0;
 }
 
+static int msm_gem_init_bookkeeping(struct drm_gem_object *obj)
+{
+	struct msm_drm_private *priv = obj->dev->dev_private;
+
+	drm_gem_lru_move_tail(&priv->lru.unbacked, obj);
+
+	mutex_lock(&priv->obj_lock);
+	list_add_tail(&to_msm_bo(obj)->node, &priv->objects);
+	mutex_unlock(&priv->obj_lock);
+
+	return drm_gem_create_mmap_offset(obj);
+}
+
 struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t flags)
 {
-	struct msm_drm_private *priv = dev->dev_private;
-	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj = NULL;
 	int ret;
 
@@ -1251,8 +1262,6 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t
 	if (ret)
 		return ERR_PTR(ret);
 
-	msm_obj = to_msm_bo(obj);
-
 	ret = drm_gem_object_init(dev, obj, size);
 	if (ret)
 		goto fail;
@@ -1264,13 +1273,7 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t
 	 */
 	mapping_set_gfp_mask(obj->filp->f_mapping, GFP_HIGHUSER);
 
-	drm_gem_lru_move_tail(&priv->lru.unbacked, obj);
-
-	mutex_lock(&priv->obj_lock);
-	list_add_tail(&msm_obj->node, &priv->objects);
-	mutex_unlock(&priv->obj_lock);
-
-	ret = drm_gem_create_mmap_offset(obj);
+	ret = msm_gem_init_bookkeeping(obj);
 	if (ret)
 		goto fail;
 
@@ -1284,7 +1287,6 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t
 struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 		struct dma_buf *dmabuf, struct sg_table *sgt)
 {
-	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj;
 	size_t size, npages;
@@ -1313,13 +1315,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 		goto fail;
 	}
 
-	drm_gem_lru_move_tail(&priv->lru.pinned, obj);
-
-	mutex_lock(&priv->obj_lock);
-	list_add_tail(&msm_obj->node, &priv->objects);
-	mutex_unlock(&priv->obj_lock);
-
-	ret = drm_gem_create_mmap_offset(obj);
+	ret = msm_gem_init_bookkeeping(obj);
 	if (ret)
 		goto fail;
 
-- 
2.55.0

