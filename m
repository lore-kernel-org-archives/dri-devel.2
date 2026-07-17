Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908F4C44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 20:49:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0CD10F612;
	Fri, 17 Jul 2026 20:49:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="iXFU0Md6";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hvWy45v0";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5742110F60A
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:10 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66HJtTuE2652971
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=DA8G+ZNQJ0z
 SGZowFGnb3Omh257suiDVTqWi0Dh6qc0=; b=iXFU0Md6AWKczwyfoJ68sdt19ip
 tD9k8pVmC86cWT1lbsw5xmX+LvyUPHYbmFO9LGx4NsqEtvkFuHWoGaY8lblbBxQn
 AJlJck5MWs3FuenDV10Rjp14Z0mEUUuymcQCxuUnowcHeUTbzcDtRW2Ujyf98WxL
 wryhSSbGJ/gkq8A61Vp3gEWyiTgtsIeh3i1ZOj4s/70/M+auSrk9Vc5ZJkXsYEtk
 PVDGInK3cF8dx4/QNfMYS6Tt65uvUc4Mh9GVSz6mVLtrK6nh8cmu2bCybFBo+imP
 j00i+tvWx9HxLAeRIJlYUzH4PF/m1smTuTumTapsVEyNZJn0fqII59+2mFg==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fff9pb9dg-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 20:49:09 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c890bac374eso19353120a12.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 13:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784321348; x=1784926148;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DA8G+ZNQJ0zSGZowFGnb3Omh257suiDVTqWi0Dh6qc0=;
 b=hvWy45v0hnFyG8ktd76dPFtquR0zbC0EyTxrxpPriimUg7LYKstMpm/y3fYixtbAU5
 2Ms6XC5ugCgPFHy6eciI9Y60IoGSm2trPN9+Ytq30z4tlKyPhDRn+qFk6EN+YD/AkKKw
 CTLOhhXR0ERTjAliF91Uabt1yJdA6CtSGWP6niM99COBGYWfVobkgzQBVl75a7TrtAMD
 p2eeEkdNaMIu3EdZgTYKDypD7eAbqMlFlTGylWADDpASa9DlzFDBuRi7AR00cAc7Fe3T
 +M5hwBp87gViV1M8AgqFuZ6Vv2tZOdOZRoLbPOSXy1wSXZQCIXFdUdnzFFo5kc7RY+OO
 RuhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784321348; x=1784926148;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DA8G+ZNQJ0zSGZowFGnb3Omh257suiDVTqWi0Dh6qc0=;
 b=RscpV/HVnI3EY3SOezI64IPEalbSZHs/0X/y71FggFoxb+Jg5j8EpLu3Eqhaoqs4MK
 bvcyucKKW59iQ13jo/2DtqTj/gfp1/6KR5kdUmDTcbgLE0Z2bGEwHNDf11FQ13gfoaG4
 okKlKLq8duxBbkyi4oXJi4f7oVWXCmAC5hyIuiGSgFEvahJ76MsqmEnQ8OcIrB/1hWO9
 ff+K0vdxlmXa8gQdb1jiFqFe5YwdYyH7+k+Ae86aKqmbnq7XU1KoxcWVQ+GU6zpHZvM0
 huvigvexY8FL0ncJz96eO4B1p5GEfBkqCzQhkjhtYPyYekBo/xoTYSIS/cneKIfNrfec
 qdAQ==
X-Gm-Message-State: AOJu0Yyotpiw4f/WBlCR9Wap8Ca0GWltU2Sgpwo9L84fl+5w1Ot7Xg1p
 acAEdHnxAH/DV24t03GtsjCeHULSkdFyXJiBZ0VOKGyJDD8bJMv8s9OTbubtnAEj6DPHb9BNFqL
 zo53+Y1nJl6ma0qPdqE9TCheudnOWOoIKDwvuAmozIlsImy2Nuzq3m+L4xdS/EiPfU+WLpHxzuj
 FDh44=
X-Gm-Gg: AfdE7cmVX2tj/mLVtDO4V5zWcohseesA3LivvEPJQrvB/xD4LNxiz4Am6IpAvqamVg9
 YGteuDYR54Djh5atSXxyql90ddARyM9rKt6BC8gkYRnosenc5o73+oWeavMG7tIGI+Kh3KM9vU4
 +n5jSOrBIlhW2ylGUeUVnnXFUd5bhvD/ZLhibJotAETjAMvNnKNicIBV+/OthDO8nrvqphOF5C0
 tlUFpwuxHGRntPmF/BwBYWHlHEWmRkw5zOswXAyTAhJ2ZrktgFHFo2xGYai1yZ7s+X+EIoNomVU
 TRANUfHR70QacvzHDcWl6lG7sJxHyVVv2nYuFtua0FdjjoSH9/rPTqVoMFVtZk1HyjUyPnXpMlc
 duX2uTCRwWj0gihMuSD/xAMboilRFW/KzW+0rg28RSOuRJZg=
X-Received: by 2002:a05:6a20:258d:b0:3c0:9c19:65bd with SMTP id
 adf61e73a8af0-3c3adab057cmr4905233637.69.1784321348250; 
 Fri, 17 Jul 2026 13:49:08 -0700 (PDT)
X-Received: by 2002:a05:6a20:258d:b0:3c0:9c19:65bd with SMTP id
 adf61e73a8af0-3c3adab057cmr4905196637.69.1784321347805; 
 Fri, 17 Jul 2026 13:49:07 -0700 (PDT)
Received: from localhost (c-73-37-105-206.hsd1.or.comcast.net. [73.37.105.206])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cb51a2c2a13sm1338524a12.31.2026.07.17.13.49.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 13:49:07 -0700 (PDT)
From: Rob Clark <robin.clark@oss.qualcomm.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Sashiko <sashiko-bot@kernel.org>, Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v6 12/16] drm/msm/gem: Validate lazy VM in GEM_NEW
Date: Fri, 17 Jul 2026 13:48:28 -0700
Message-ID: <20260717204841.26120-13-robin.clark@oss.qualcomm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
References: <20260717204841.26120-1-robin.clark@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DmqdizF7CmjHLWAuzkkjeOVX3sHeRnsy
X-Proofpoint-ORIG-GUID: DmqdizF7CmjHLWAuzkkjeOVX3sHeRnsy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfXx3U189hpGNiz
 LE6a828BppnHdw+xjpr0Fj0gASI+PuPIXEvpopZU9wXVU4wvUHi4PuvpaUwo9AJk3ck7346ykjY
 tLnuR2kL7ZY3gFrGs3WbmwIHNNKd1AqibPhjefjf3SOGBTZMspJIZbp799AGHZ/vOoVn4edJ+mj
 Ul/WvZwafAXWBzw8Ikqh7G5KdLbcpPeR+fW8XGVXQ7cLqNVQzT09JPtfibGpxYnKFRrAlqoYOEl
 fh3SMpbKXyV4NTAylKtPr8j8sqNoOofvZvsGWlPGf5TK9Rq5Ulw62nFiMu+IunHzjEMZ4+PjRSV
 2w9a104x+RCihIpM1oTf0VlzIdxhto66EzD0lZGnmkCg4v+aTZd4SmzW4mrGmxbQfXZb+PZUWWY
 tqdQd0TyzIPdc4pmMCeLV21LOSw0QifvigZifhL8+8kL3EEkK5GLdNfS4PoivK4xmhuVNHrjPyb
 tQedD6WR+rIjFrXMZdQ==
X-Authority-Analysis: v=2.4 cv=TaqmcxQh c=1 sm=1 tr=0 ts=6a5a9545 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=19Wyn7e3V/0aNffMjNCMQw==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=VGCgC6sU4evaG-_1UnEA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDIxNCBTYWx0ZWRfX0PJlfDGU+HwA
 TeHJf9rhTSHiTCCC7wUQ+UV5nV3lKIKie+8x2tpQG18Qh4ZOQQd25h0D3tlXPRX+R8sA5fsOkQh
 WA7G4wGfcQbwJBI5wvWmDXUJqudgkZ4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_06,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 adultscore=0 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170214
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

Otherwise creating a _NO_SHARE BO before any BOs are mapped could cause
a NPE.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Rob Clark <robin.clark@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/msm_gem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
index cb00bdf21ef6..153a4e4a916c 100644
--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -1138,9 +1138,13 @@ int msm_gem_new_handle(struct drm_device *dev, struct drm_file *file,
 	int ret;
 
 	if (flags & MSM_BO_NO_SHARE) {
+		struct msm_drm_private *priv = dev->dev_private;
 		struct msm_context *ctx = file->driver_priv;
 		struct drm_gpuvm *vm = msm_context_vm(dev, ctx);
 
+		if (!priv->gpu || !vm)
+			return UERR(EINVAL, dev, "not supported with shared VM");
+
 		r_obj = drm_gpuvm_resv_obj(vm);
 	}
 
-- 
2.55.0

