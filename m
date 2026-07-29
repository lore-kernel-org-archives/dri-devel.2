Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3585FC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 15:57:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B73210ECDA;
	Wed, 29 Jul 2026 15:57:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="oyeZdbWZ";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="AadPRebL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BF210ECD0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:09 +0000 (UTC)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66TF35GD3343162
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=kuFeynn3gfk
 Q8AIVqyOcrg1EBWzVbObvEO2dO/Quafw=; b=oyeZdbWZIruIlKmx8I74nGLhjmH
 b1iZwePHP3IfQpUTdJiz7PT8A+1HV+q/s3ASVKuBzfLbIP60ton30Q5aQisboOPO
 o+ECmZpEMoveH1cUMEfejnspIFB0GrCOPCi2dQ6HaU5CFv7ChLWURfpWg03giMPY
 nZlwEPT1i/hBqR9flMGrHbSAGJzogtZaYnFlNAcpeXybs+Jga9SO2LfJY9dK5VgQ
 pX7nQfUSgfE/oeWP8A8SLCcjBRhbhep2ScigQkEHeSJ6zZmcnXJcD1BX2fE51bzD
 Nl5dWkTkMWxi4P7Ed8Qfk+Bz1EBZdl4W+74Dp4pTw8EYc2VbNbxxzDlJsBA==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fqh3ms6t8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 15:57:09 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38ec0f510a9so2376910a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 08:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785340628; x=1785945428;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kuFeynn3gfkQ8AIVqyOcrg1EBWzVbObvEO2dO/Quafw=;
 b=AadPRebL83xCmsO02Iq0JpU5RkfgLqbMMkkB6C72Mp0Z1zKLo+4bb2Msl7irsYvQAM
 EsNAFrKNlLc3V6FEu3RCAjU+1oeGtVH3mvgkvbkYRLG1HcL2EbfrxSRIzxp/SdoFD96e
 U+3lqTHjua4V0RsrasUBpLolBrI/g6ollCpzs8JkSZ8VJZ+tLyHdEbJl0b9yZwMVLuQg
 XjxfALiMXf19TFojboxXhc4K3sq1btCma2UvwT3hmUt4bU8OqSZCrB8BDlFBJwMahHs3
 LNM7yvM4air0LoD7ra0buL1Os1WmKJ1CMIXRVnJ70zZhpE2XqvpTmHQDUV9+r02Atm98
 TONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785340628; x=1785945428;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kuFeynn3gfkQ8AIVqyOcrg1EBWzVbObvEO2dO/Quafw=;
 b=E4D4I+X+CVPMY7i/l976NQSbicISbxCbfIDITgGS+fcGFhKKWHR5i9k5+WylW/oqWR
 jcHZ69bWJwOlu/2J9aVP5/rFLE5Qw7XsLfm2Qr4VxW4SX8mW0jrgRZFaNAG4FxJOCa1p
 TelZ7EbhaL4/xkTiWLTG3w6EYtH/1qELPZgHdgg8vN74eKJKrolY6FzMa8tSAX63WHjv
 ZztCf1HUwf2ZGr6+zOz17dVH/MvvtmfUQK5vDZn/v52JFUFnbtLjqY+I3j+eU1ad4rZS
 wMPFC3lKaLH1P+98Gei4tvEKcA9VkNJ5o9KusVKrkQR17DS5UyUys5FEpVvOFTAuIIwX
 My7Q==
X-Gm-Message-State: AOJu0YzSZP0w7jurKfmCogtHHis/Ss6RfsPPmUjIoorqmAe1BBuUUQVN
 vc1aAl4ZQ0oBP3FDLRsl3fFUcL2h49lqtcdN7pUP687jVkioHI4eSITdv6zQaOkE5PiudJHKN62
 5bvSLASUbZqMSDmpUj/Xp1ILK8/0CbQk7am5wDdMrKSnCMwftiBAcQ4wQu8wEFgO+H7dZ+NYNJn
 kj3gc=
X-Gm-Gg: AR+sD13AkONL9GMn0MFhYe3uTC+2aphZham47dxw0nTKAnZ3bXaJbSaGqqEZkZWnwAe
 GQ9ebtFB8AMPcrucEeth6E9uuOFX0Pq6kQo2RvSnHYF3XetX2lYDF1ONUKNUMiAYLzW5ccu7PMk
 46hCs4MID/vFqbrhty7grKuIJX/g+upS0vQvPBlh2ozmWQPrYnRXDTedvy5UpaUGh77ZJTnOoZG
 UxOBmxuYCGze3BcQW41w9UCDJufDm+v/h5TXEUfxN59EZ0hyp24NaA9INuM35ay4Bc5Mt3r5NyH
 J/anq/Gk/y1U4S3Srq5Ra/Qyq5ntYIxdHmmJHUdoyTA+6bVcgG2oVkrKBsfxgv8+i+tT0J0Ms1E
 0H1Eq9Zg5lDM5UndvmbptJdMZr4wySZakC1N4vTyxBjrSxz8=
X-Received: by 2002:a17:90b:3ccf:b0:387:e0db:3faf with SMTP id
 98e67ed59e1d1-38f6a53f749mr7381890a91.40.1785340628458; 
 Wed, 29 Jul 2026 08:57:08 -0700 (PDT)
X-Received: by 2002:a17:90b:3ccf:b0:387:e0db:3faf with SMTP id
 98e67ed59e1d1-38f6a53f749mr7381852a91.40.1785340628018; 
 Wed, 29 Jul 2026 08:57:08 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f642bfc66sm2974517a91.10.2026.07.29.08.57.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 08:57:07 -0700 (PDT)
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
Subject: [PATCH v7 11/17] drm/msm/gem: Extract bookkeeping init helper
Date: Wed, 29 Jul 2026 08:55:48 -0700
Message-ID: <20260729155609.20190-12-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
References: <20260729155609.20190-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX4ZGpCloFho7D
 jhPzTSAq7tywIp51VK1/rbUxPPlH6n18P0otANCwrV1c2Zo9xGzYO3PXPyOAbl1ueXj6TQz6xB2
 IszhiGHGMZs0n30d8DdA3Lmpjw0A2JxSvK9xNKRULs8W+s+I8TXMwqdh1K/otIl/N6ZHEnHyI8w
 lOIfNRW50Txzd6wigz54VlHE0jgRWb92eWg4rBcDDtcniVSVxX67cE25pADJZbdKlPBRTaj1P3r
 HyQrO/2srKjKt2UO4tajg8NJuH4camVHeuxYzwZG1iQiNnlYeszXlgvPw0Gpas7WlPAGkEZ7nHO
 4x775ehH1lLLj50UGqmqRJhVgp/flUt1WlX/6z9FP1PlebtLhBTtLY00JEX15YX7ykGti4bYBgx
 XzUDd5friLVUBcNC+H7kme2kLY+RyUfcpGh8JTp9yMOhe1BWW6MO+x4Z8m3oGQ8PhfuGhljq0ms
 Qz4ZDx2Dt5xnaohkybQ==
X-Authority-Analysis: v=2.4 cv=F49nsKhN c=1 sm=1 tr=0 ts=6a6a22d5 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=EUspDBNiAAAA:8
 a=FQYndL8g-KLy3NOJUqEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: I-1bGwnoti08ymqSRxcPQSzGDN0i4dfG
X-Proofpoint-ORIG-GUID: I-1bGwnoti08ymqSRxcPQSzGDN0i4dfG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyNyBTYWx0ZWRfX5FPryTWUOy/s
 +zCmfbZM2YI8DFF1aeGxr52T/pStDr1tqOVBMMlsKJVMLeDbGCN8D9DBEPpm1aFOQAT7nKJcHJe
 BnbHRexXxmdo9w7csRQSWREgm26CY3Y=
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

Clean up duplicated logic between import and new paths.

Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 38 +++++++++++++++++------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index cc45392691e5..3c36b1c4a4d5 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1234,10 +1234,25 @@ static int msm_gem_new_impl(struct drm_device *dev, uint32_t flags,
 	return 0;
 }
 
+static int msm_gem_init_bookkeeping(struct drm_gem_object *obj)
+{
+	struct msm_drm_private *priv = obj->dev->dev_private;
+
+	if (drm_gem_is_imported(obj)) {
+		drm_gem_lru_move_tail(&priv->lru.pinned, obj);
+	} else {
+		drm_gem_lru_move_tail(&priv->lru.unbacked, obj);
+	}
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
 
@@ -1253,8 +1268,6 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t
 	if (ret)
 		return ERR_PTR(ret);
 
-	msm_obj = to_msm_bo(obj);
-
 	ret = drm_gem_object_init(dev, obj, size);
 	if (ret)
 		goto fail;
@@ -1266,13 +1279,7 @@ struct drm_gem_object *msm_gem_new(struct drm_device *dev, size_t size, uint32_t
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
 
@@ -1287,7 +1294,6 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
 				      struct dma_buf_attachment *attach,
 				      struct sg_table *sgt)
 {
-	struct msm_drm_private *priv = dev->dev_private;
 	struct msm_gem_object *msm_obj;
 	struct drm_gem_object *obj;
 	struct dma_buf *dmabuf = attach->dmabuf;
@@ -1321,13 +1327,7 @@ struct drm_gem_object *msm_gem_import(struct drm_device *dev,
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

