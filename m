Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E921C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:36:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3BBA10EC5A;
	Wed, 22 Jul 2026 06:36:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="n7HSxYmR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WgAhWwYc";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAE2C10EC52
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:34 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53g933473526
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q3fc9Te4dKFk2JaGmRMxsej67CBbIGs9m76jWKgHR1g=; b=n7HSxYmRty0vw2QN
 LYI/22+5XXVmJlrhWIJUD8pPw1zDloEnRbZmBMC+GXQNwEwTOSQUmZ8Aw+b/3JCW
 x1eLDiYdstc3oEAKvdiaccfd9kUv1aXHXqypMjbxjceHOGKdftGgVTYHMjjFN70x
 ShkQEpFPCQQxZIXqjkJGpx07D/NUG7rBkc08C02obWT3rmlLu4Gzlv3gWsAgJyB3
 6+bnTobeUMkRREC+htRkK/KveIvYpQjf1mzKPmMvOk18EHCMpR2ckMH5R7mOG3U6
 9GY/gO+ZU59oQFJ/z0aTAG3BZuLkYpOm1488O2GKR7TPWJBUHkE6Fq+wS4Ujird/
 ilh0dQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6ftm6u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:33 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c21c01cf3so193862561cf.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702193; x=1785306993;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q3fc9Te4dKFk2JaGmRMxsej67CBbIGs9m76jWKgHR1g=;
 b=WgAhWwYce8ywtvklyq01Akliu0u55g4f/mr+KdPawlakjyugVSDgkJRDPEUFfbRZf5
 Sqd7jQ2GTx5Jawt1fFfSNsHMVdT1s3A2Qr+pcB8QjV9BDv+xDUQbv876ppyOofXIUm31
 kieYzD561fNR1pIgW3xjQ541GsEjKzCEVdl6klAa/W2rIRlbWKMLRppZ3IFJddrYkTWw
 WYSOfsA1Sc//bufoqsb8GaYBPlebuz1qJwVjZ4BgN9Cv/LbP2M4/RvMpNRWSH2rEtKvh
 o3QKhS22d4zdYUEebfKVTxmn+bOZHrvVX6PyfDNuNUSjnToN520jO/bLxv2KmeXaViJG
 OgYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702193; x=1785306993;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Q3fc9Te4dKFk2JaGmRMxsej67CBbIGs9m76jWKgHR1g=;
 b=FFoW0DX3I5y7MujOzCjN3l4mC2SUikS3p+HzcFuI71wKLWM1r+gC9GbXZjvctjhKce
 CosEhUXVSTBf76bYoDYtbJ5mcLbFSy9kRT/ENnWTJGzvdOkiIbx/Sn7bRBruW6/JMlvj
 nO3xBbogYbe3Qs9Y7AmAD2bqlcNEjOaBlKz0P1rj90rsGJLL0LtV9loksFy9TXUSBzay
 pxI+5LGvXu19H0NPakBWLokNQ1VPlPahEn4qhaprnOw+Tm4RK0Tl1+/gpfTRwZY2NaKz
 0zkHoQK5umCtPRJRQjaUKu279sG5E9eEDg1Fkd28q1e+CJQqm9uosWmwx8ELRMAOZJ55
 XFxg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqo+ULGZ65A8jZWk2tF4fqpdiglf8XiVFOAAyeJ/4Zg4ArqcwZDRSldymdCQXNsvu5tRuB+OtBIfC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJ9TygMqHdU8djqEV9BXKJeKaVTTZSTSPPK8YPmX08Gr6E5zMf
 qUi+bRdPMuW2HkTC5lAfVEyCU8RpeIjQUzt1+aWZGCKXdbB1IVLOOnintBwoMScoLToWqNsqsN9
 TYPThtjtIBiQLSs3VN9T3Qo6DSg1U2ghtuk5reo5KZzPA8h5lPfugSSrdyO7CjTExZkLXfwA=
X-Gm-Gg: AR+sD125UnWKEGrw5i5JBSiLtlq95UHlbAlt1O1waZSM3AqV5Yz1qXfIB8B1IFMBX7e
 /bXAcAuw4RcXHPSEzmBjNGnPYsFzMbjCpHQxnpelZMEz6NuOHKQ32SLzWde3+K8eyQ3QeG788Ku
 zgn5mKub2oe95l+M2tarlJfOufsbQgnhiNfb8g/fI9wHaj7Aoks4kbmVkRydVn2716yORiPrpQV
 I6/TCt8/2tGVYojyW8+ljJGJvNTJNnXQ/VU8LSGg2zaTKGPbH0bKplPoEkDVkU20wJhHqwjRvB3
 jx5z7l53KuH6hOOaoLw/oMPqw4YYAGuI0Fiqsuh/4gm6tWlsBUN7D8SIpFqi3CgRXOsu/+Ea5Fy
 W2VDsLsE7RDtG8ZXMf/At5Hay/+7pV0Pkv0Y7tfXV9hlj84XySjiHwATXLWFHmWsxpMCfjZ1ipA
 +ALkR7KPH92vO07g==
X-Received: by 2002:a05:622a:13c9:b0:51c:7b12:1213 with SMTP id
 d75a77b69052e-521403455d1mr205562271cf.81.1784702192873; 
 Tue, 21 Jul 2026 23:36:32 -0700 (PDT)
X-Received: by 2002:a05:622a:13c9:b0:51c:7b12:1213 with SMTP id
 d75a77b69052e-521403455d1mr205562131cf.81.1784702192459; 
 Tue, 21 Jul 2026 23:36:32 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:31 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:17 +0300
Subject: [PATCH 02/24] drm/msm/dp: drop the always-true yuv_supported argument
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-2-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
In-Reply-To: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5212;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=BzOvnMI5yT23J0skjUtVdX/YbK2+8ydFXE2ObmImkrQ=;
 b=owGbwMvMwMXYbdNlx6SpcZXxtFoSQ1ZCyjNde7nU/Swzl0bM98xeFeMw7/ePXNP4tkuBr99ee
 FB72Tmsk9GYhYGRi0FWTJHFp6Blasym5LAPO6bWwwxiZQKZwsDFKQATiedi/8Vsk6vvmbc6vDop
 7GXQSUm1GhEL0QCWtVqZurIfKzRf9jtliDMKum0Qnvju29oURoMXcpVyP7zftfZcWjt7Zkuham/
 k29AtSx1swy+encJx0k1y+lfb6b0lXjl3Undp6dX/nHVj57m4ucc9a5SnnZxUPv/pUpF2Mbn3by
 rzSzbee6Dj0sW0+vynrZMyLE+YTGX2W6HyMNG1rLOfT/fznvPFJjO81FnzQzncw+V+PvgYkKBfI
 fu3r2JrX+0/py8vVXprBf7ocf6uqjB0UvE5yxXUs+v+/tjISrFTKQwylQKXxKaxtna/YppgKqy4
 f87i8mclGpoPfKW9Fcu9Z53ST1fyeBOWP/NiO7dq8B4A
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: zmS-UYDMI2zKBex1u-RTAheFbNgr2P0l
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA1OSBTYWx0ZWRfX54qhiMnQqbvq
 OTNub4eqaPkED9oIpgSHSjRol2re5qUEql+4gh/p+NJ0o+gm3/PF+FpnKL+HDDwCEEEXI9N+AOd
 3nK50AM55KPkK4TG6qd8BoHKuRp9Jlyb6cVIof0p258hIAZaBCB+AZkXmp2iT9+EP1+S/4OU0vQ
 ipc1h0oqznZ+pqjbrF92LPN31+PGSRKVNNS1wClAjSSFSLHhWrfpnWI07bwuQfXrzC4fKtVE+ua
 TyceRX1tiaqU79avC/+G+frQ7J7o297PqXsmJjuRUO9hh25NAaFlACnxi8jMLJA6F3pCdUNY8Qv
 i9crJ1t8lwbv13+ff1qLSXEvtGmj9WAip6O/EYO05/J6jA9z24orevLIhkVolF4yWEPUypJ0M97
 TGQoUKPI84BHaJeSCURM6Zg++7oHSXjEvmA9qHONasqtu3trBONT8g62OWjBi8QdF/KGEIeBNtb
 ut3K8Yj94UVdZdpnCGw==
X-Authority-Analysis: v=2.4 cv=e/o2j6p/ c=1 sm=1 tr=0 ts=6a6064f1 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=nfG2dtz5EEHLLqw77CsA:9 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: zmS-UYDMI2zKBex1u-RTAheFbNgr2P0l
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA1OSBTYWx0ZWRfX9kxef17KvO5s
 oE4h2c3MJKe8ky2RzErhthskd03mOD4WKKhz0BnsUDXZN9L69zceVRmZOmioChj3PocMUmqZN7r
 gSzq17PrNJkXh/tkUESJKr5QFlAqD1Q=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 spamscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220059
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

msm_dp_modeset_init() and msm_dp_bridge_init() take a yuv_supported
argument, which the DPU driver fills in from the presence of a CDM block
in the hardware catalog. All platforms that support DisplayPort have a
CDM block, so this argument is always true and only obscures the code.

Drop the argument and set the bridge's ycbcr_420_allowed flag
unconditionally.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c | 4 +---
 drivers/gpu/drm/msm/dp/dp_display.c     | 4 ++--
 drivers/gpu/drm/msm/dp/dp_drm.c         | 5 +++--
 drivers/gpu/drm/msm/dp/dp_drm.h         | 3 +--
 drivers/gpu/drm/msm/msm_drv.h           | 5 ++---
 5 files changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
index da3556eb6ecc..ede935a426d1 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c
@@ -653,7 +653,6 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 {
 	struct drm_encoder *encoder = NULL;
 	struct msm_display_info info;
-	bool yuv_supported;
 	int rc;
 	int i;
 
@@ -672,8 +671,7 @@ static int _dpu_kms_initialize_displayport(struct drm_device *dev,
 			return PTR_ERR(encoder);
 		}
 
-		yuv_supported = !!dpu_kms->catalog->cdm;
-		rc = msm_dp_modeset_init(priv->kms->dp[i], dev, encoder, yuv_supported);
+		rc = msm_dp_modeset_init(priv->kms->dp[i], dev, encoder);
 		if (rc) {
 			DPU_ERROR("modeset_init failed for DP, rc = %d\n", rc);
 			return rc;
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index e0c44eef3aba..5ae5eed7e010 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1318,7 +1318,7 @@ void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *r
 }
 
 int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
-			struct drm_encoder *encoder, bool yuv_supported)
+			struct drm_encoder *encoder)
 {
 	struct msm_dp_display_private *msm_dp_priv;
 	int ret;
@@ -1327,7 +1327,7 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 
 	msm_dp_priv = container_of(msm_dp_display, struct msm_dp_display_private, msm_dp_display);
 
-	ret = msm_dp_bridge_init(msm_dp_display, dev, encoder, yuv_supported);
+	ret = msm_dp_bridge_init(msm_dp_display, dev, encoder);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev,
 			"failed to create dp bridge: %d\n", ret);
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 06881bfd6181..4f615b45fff7 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -243,7 +243,7 @@ static const struct drm_bridge_funcs msm_edp_bridge_ops = {
 };
 
 int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
-		   struct drm_encoder *encoder, bool yuv_supported)
+		   struct drm_encoder *encoder)
 {
 	int rc;
 	struct msm_dp_bridge *msm_dp_bridge;
@@ -259,7 +259,8 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 
 	bridge = &msm_dp_bridge->bridge;
 	bridge->type = msm_dp_display->connector_type;
-	bridge->ycbcr_420_allowed = yuv_supported;
+	/* all platforms which support DP have a CDM block for YUV output */
+	bridge->ycbcr_420_allowed = true;
 
 	/*
 	 * Many ops only make sense for DP. Why?
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 041aa026ae2e..3b046822f05e 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -22,8 +22,7 @@ struct msm_dp_bridge {
 struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
 					    struct drm_encoder *encoder);
 int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
-		   struct drm_encoder *encoder,
-		   bool yuv_supported);
+		   struct drm_encoder *encoder);
 
 enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
 					       struct drm_connector *connector);
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 3d5679be488e..0ec0622d9217 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -354,7 +354,7 @@ struct msm_dp;
 int __init msm_dp_register(void);
 void __exit msm_dp_unregister(void);
 int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
-			 struct drm_encoder *encoder, bool yuv_supported);
+			 struct drm_encoder *encoder);
 void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
@@ -370,8 +370,7 @@ static inline void __exit msm_dp_unregister(void)
 }
 static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
 				       struct drm_device *dev,
-				       struct drm_encoder *encoder,
-				       bool yuv_supported)
+				       struct drm_encoder *encoder)
 {
 	return -EINVAL;
 }

-- 
2.47.3

