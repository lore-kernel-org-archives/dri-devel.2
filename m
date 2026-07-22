Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF95C44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A618E10EC80;
	Wed, 22 Jul 2026 06:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="m0ICkFax";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="bm+3uieh";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72E7F10EC79
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:39 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53daS3767640
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HlaLffvRFgtDe04aRsNqDRbq77UC4UumkcOWgBKKBSQ=; b=m0ICkFax9rFp44St
 ZUEgJf5C9ZRA441Co9MMkqIRhMj8yRRX0X2JaXybZ8twOMuyuGnXtOhcW7w1Tr8k
 qJP80PWXbYmpK3uUYju3Sh1L+T/efRWmbRI7jxv8UeLGT1q0XqEU4kmYb8hyVnU6
 dofwCvn5scvvenojwtsbZnn9mOCJLTCNai5OVlnWEySUAiCNR1kIDOMpawV+x65q
 +bQivuaifQk75fA6pdHCK2xfGDQA/mZFE2hHGlqIj1FgJ12b+fOnhZ+pK6ZXNMMj
 FUq4ECxypuCdmX1DX1yg3VkyZTw7tAMzPUpMvXAGJnLefjYdfLluLTTydIq6JrB0
 ElqMeQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rnbq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:38 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c12e43b98so235809081cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702258; x=1785307058;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HlaLffvRFgtDe04aRsNqDRbq77UC4UumkcOWgBKKBSQ=;
 b=bm+3uiehzGBtes7sRIkBFeSJjaDTymeW9hPsx6nbAQPlOaRuZKC1Pob4bAXY+nDrNy
 mjChbaoMx6Zkl9T+HotV9ofHzUziPdiT9P2/HsFizpLy6pMaTfjMz80oeI9RGyRpjtYr
 QEBvZU05wjJAPCYKoGMSc89sUL3qVek22GThBOhhTAS2soYb3fp0ySv86nVfNF5QOkJf
 8B1oBihdNxnbBF7wAoBoRPwpbmrK3dzMeas7DLM3WhQLPpkq9rjigu5RvXrOHmyDuQC4
 I0d+DPoKE8wera2oxT78vGSgbpAq93ezL7JcAIOwMrjcfOAuE3iA1j4iTMdL0uRe9Ytt
 swwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702258; x=1785307058;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HlaLffvRFgtDe04aRsNqDRbq77UC4UumkcOWgBKKBSQ=;
 b=ly7Ess56RKoFWhIGixuLO8Ht/e7iKQSJ8+8QXSVNMBkIvxnEjNH7YHSK9LuZZ8zefl
 xEKzlCG0vWLF9vfjZQTy6DDqxyIYBshtgMxkTnuy06G0IkryPo+TEYEQUKoy2AvIqM6j
 399MG7xvnEQMENLZPjod8AMv4sRpXeRFyI3dXqhWfsA1aOQfrmGt7ibeGfAu0dLFsABi
 k7XC9mjBRwMR5zXCJ69EpjQaFyU9UUlHZr75oq3k2ESbRTDbl6s3YK6UESS/4n4BHOcQ
 rhH6ryiHgHEfGvUC363O1BuzaMbETzkWEVkF/I+MWm+pGCe7x/OhBvN7N/5GjMwhcQMC
 7F0w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqEQGTI201c9+eGrkr9StkxsyZC1gV29/GyjBln/OjOQiTSyTNPlq/XWn6fW6VAJN+KTHD/UIYU5Uw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGj90grtj9LHZqlABMkX9JaM0BsjdQytdwxCXTKZq17ctp1kIE
 hjytaaqD0RravXaT9UZakS6HXORuuKeKTUp3RuTUbERhzvtDJ5ia5XXwzipBTsW81hHf0o2v95G
 vs7NInOxaE2et/A5AbWpUwPEhPaSrbyf4vXyv39idEUoy8Pk9Hj6o3iGxetmLEuhpT3lj21c=
X-Gm-Gg: AR+sD10j+AY05X0VgbuMcKPsLBzsJ31YFm+iLBmRrRmk+KU62L1Dd9U4kP+4XyVmvbo
 sfxvWk2BtazLO3R+/bsduwWs/1VNLBAnhSFJdf07hqWwl/egD6USyIv+B9Xuj8hNKMlH0175p8B
 ImnEocrvwo5vzfVeB3Hfn1aW111UGVTUKUML9iNYoi7i3XDeYniX61yfbUeCQZKMh3cti6LRmn0
 BX9w+SxekNW5dOrEWMjWUe6R5MU+W4EqHQotM/DOh0LDdQktqMrrlWD/e6I7YyaeWWnt8DyVgup
 IIM5tvqF6acmZqZt4LjH0p9JBgyUoDru2/XPpnvATp0lUz5ACk75XE37GS/ROxjtwr/ysxptXyn
 kEkKD4or1f97sAF79uaBincL+LmxD7ZP1KUFyqcBQOOler7VnACHlSI3xVAR1Ko8x/NIQtYrEc/
 0/zxLCyL+LSFVM7w==
X-Received: by 2002:a05:622a:94:b0:51c:7b13:62fb with SMTP id
 d75a77b69052e-5213ec7a596mr202119241cf.81.1784702257680; 
 Tue, 21 Jul 2026 23:37:37 -0700 (PDT)
X-Received: by 2002:a05:622a:94:b0:51c:7b13:62fb with SMTP id
 d75a77b69052e-5213ec7a596mr202118901cf.81.1784702257186; 
 Tue, 21 Jul 2026 23:37:37 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:35 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:38 +0300
Subject: [PATCH 23/24] drm/msm: create the bridge connectors from common code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-23-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=13003;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=Tme5+V8njkTEiDYfOB80xRBBVWt+hpUlceeAHfw1TcI=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTptSUJH8vJOao3qk/dnomQ0VkPClVNcZJMt
 gFNlJvPwf+JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6QAKCRCLPIo+Aiko
 1dLEB/kBC7xFBaSeFSz10X4A6Ooz6YG4omMwsxe8wCQLJOiGapcvBnV1qaT6AMMcglErsmlmwAZ
 Vw+r3YdTeLpWzECeIWshW3C8WbPrZzaAg83/wmqiconMxjGBSSmoWzJ1vq7yfvJOEUPQb7AkCfv
 GWUoXTB3M7TIOzypa5XnmjwVA+dOMT30rpsEcrOGTskbSOu6Nu5pbvR4xz9kTyGFCj3AQgAdX1Q
 BFPJuszGdvl1y/C79Wh2tF1IRNjnqyYtawYHPMvVUUMT9NrYchHs9UqxCzImpDepx9U5/J8gXw4
 gDJ/EpdIreLC6fXSyo8ht7RFovrOKxu3vN8B9VfjMaQbjUUf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: 9iQmn8C9LPfMDU85IqeUM_1P2jzFGGlz
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a606532 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=FlskwPPIur0Mnapaa8AA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXz+zKwt/ra+CY
 id/7bskFx9xL9pWiy62ZFm1d/Ick0SDBNX1XQKFOwggYaK7jWs8UMhQqDO0k1PvElrmGjc4zCoK
 5Jjuwu+jv+FesWeZqaXSx0hcu8XLVv9oic3Tq87ru4HURZ9Jzq5IFjsm1gV/sf5I2iVgRMRe9K+
 T7695aSmIEY+pA4m74jGC3yEhseQajmHJB36swM3Y4adN6qjaHMkFJytpBfv5iioQEyDxHUEY7r
 QSkq60d1gE+b04L+hjHyVtnBjHuhlnqmM/eMODe9TS6jp1bdOc4ZszRzWMSRuc4KsNS6oTG0QHN
 LgrV9fxOupBxIS+4bkn4JTj2XkSfWi1GdWtEswhgAqwEFxTxoLAQqbOe6IFuF5H3Pq/uISvEQlb
 jU0T9viXC+UnBh24V/CYTb6dvsMXqBpE60E/UpdcUISFzJWg+RAZ++HemouphXEc4HnoLlAoiPw
 94IHWjpyAiuxHZGN6NA==
X-Proofpoint-ORIG-GUID: 9iQmn8C9LPfMDU85IqeUM_1P2jzFGGlz
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX/jtsWQ5XNxfU
 rshVQiMzK0HXK2zlffShmqDaMjj1Jm4u1utMs/VtDucRkdFwgiiPCZuuYGbrDeT/nYYhT3d4ZBG
 AGXM5rxErMFkBDRhNgVBdJikDzjFNlU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0
 priorityscore=1501 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607220060
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

Each display sub-block (DSI, DP, HDMI) and the MDP4 LVDS path open-coded
the same drm_bridge_connector_init() call in its own modeset path,
scattering connector creation across the backends and duplicating the
boilerplate.

Now that every sub-block attaches its bridge chain to the encoder created
by the backend, and no sub-block keeps its own reference to the resulting
connector, the connectors can be built entirely from common code. Have
each ->modeset_init() only set up the bridge chain, and add a new
msm_kms_init_connectors() that walks every encoder once the bridges are
in place and creates a bridge connector for each. Encoders without a
bridge chain - such as the virtual writeback encoder, which brings its
own drm_writeback_connector - are skipped.

The only sub-block specific step left is attaching the DP subconnector
property, which is keyed off the connector type and so is applied
generically in the loop; no per-sub-block callback is needed.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c |  8 ------
 drivers/gpu/drm/msm/dp/dp_display.c      |  9 ------
 drivers/gpu/drm/msm/dp/dp_drm.c          | 17 -----------
 drivers/gpu/drm/msm/dp/dp_drm.h          |  2 --
 drivers/gpu/drm/msm/dsi/dsi.c            |  6 ++--
 drivers/gpu/drm/msm/dsi/dsi.h            |  4 +--
 drivers/gpu/drm/msm/dsi/dsi_manager.c    | 13 ++-------
 drivers/gpu/drm/msm/hdmi/hdmi.c          | 22 ++-------------
 drivers/gpu/drm/msm/msm_kms.c            | 48 ++++++++++++++++++++++++++++----
 9 files changed, 52 insertions(+), 77 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
index cd566a287f6f..93f1f0e81ac4 100644
--- a/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
+++ b/drivers/gpu/drm/msm/disp/mdp4/mdp4_kms.c
@@ -7,7 +7,6 @@
 #include <linux/delay.h>
 
 #include <drm/drm_bridge.h>
-#include <drm/drm_bridge_connector.h>
 #include <drm/drm_vblank.h>
 
 #include "msm_drv.h"
@@ -191,7 +190,6 @@ static int mdp4_modeset_init_intf(struct mdp4_kms *mdp4_kms,
 	struct drm_device *dev = mdp4_kms->dev;
 	struct msm_drm_private *priv = dev->dev_private;
 	struct drm_encoder *encoder;
-	struct drm_connector *connector;
 	struct drm_bridge *next_bridge;
 	int dsi_id;
 	int ret;
@@ -226,12 +224,6 @@ static int mdp4_modeset_init_intf(struct mdp4_kms *mdp4_kms,
 			return ret;
 		}
 
-		connector = drm_bridge_connector_init(dev, encoder);
-		if (IS_ERR(connector)) {
-			DRM_DEV_ERROR(dev->dev, "failed to initialize LVDS connector\n");
-			return PTR_ERR(connector);
-		}
-
 		break;
 	case DRM_MODE_ENCODER_TMDS:
 		encoder = mdp4_dtv_encoder_init(dev);
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 44503789d454..c03878183b9a 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1380,7 +1380,6 @@ static int msm_dp_modeset_init(struct msm_display *display,
 			       struct drm_device *dev, struct drm_encoder *encoder)
 {
 	struct msm_dp *msm_dp_display = container_of(display, struct msm_dp, display);
-	struct drm_connector *connector;
 	int ret;
 
 	msm_dp_display->drm_dev = dev;
@@ -1392,14 +1391,6 @@ static int msm_dp_modeset_init(struct msm_display *display,
 		return ret;
 	}
 
-	connector = msm_dp_drm_connector_init(msm_dp_display, encoder);
-	if (IS_ERR(connector)) {
-		ret = PTR_ERR(connector);
-		DRM_DEV_ERROR(dev->dev,
-			"failed to create dp connector: %d\n", ret);
-		return ret;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_drm.c
index 00653b0364dc..01f8320f9c32 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.c
+++ b/drivers/gpu/drm/msm/dp/dp_drm.c
@@ -7,7 +7,6 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_atomic.h>
 #include <drm/drm_bridge.h>
-#include <drm/drm_bridge_connector.h>
 #include <drm/drm_crtc.h>
 
 #include "msm_drv.h"
@@ -312,19 +311,3 @@ int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 
 	return 0;
 }
-
-/* connector initialization */
-struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
-					    struct drm_encoder *encoder)
-{
-	struct drm_connector *connector = NULL;
-
-	connector = drm_bridge_connector_init(msm_dp_display->drm_dev, encoder);
-	if (IS_ERR(connector))
-		return connector;
-
-	if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
-		drm_connector_attach_dp_subconnector_property(connector);
-
-	return connector;
-}
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 4c6b14dd52ac..4d642de4a50b 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -19,8 +19,6 @@ struct msm_dp_bridge {
 
 #define to_dp_bridge(x)     container_of((x), struct msm_dp_bridge, bridge)
 
-struct drm_connector *msm_dp_drm_connector_init(struct msm_dp *msm_dp_display,
-					    struct drm_encoder *encoder);
 int msm_dp_bridge_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 		   struct drm_encoder *encoder);
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 3bcea5f5b5a3..19a3ff0d27ba 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -283,15 +283,15 @@ static int msm_dsi_modeset_init(struct msm_display *display,
 	    !msm_dsi_is_master_dsi(msm_dsi)) {
 		/*
 		 * Do not return an eror here,
-		 * Just skip creating encoder/connector for the slave-DSI.
+		 * Just skip creating the bridge for the slave-DSI.
 		 */
 		return 0;
 	}
 
-	ret = msm_dsi_manager_connector_init(msm_dsi, encoder);
+	ret = msm_dsi_manager_bridge_init(msm_dsi, encoder);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev,
-			"failed to create dsi connector: %d\n", ret);
+			"failed to create dsi bridge: %d\n", ret);
 		return ret;
 	}
 
diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index d594a7399f54..87a7be955c5f 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -52,8 +52,8 @@ struct msm_dsi {
 /* dsi manager */
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
-int msm_dsi_manager_connector_init(struct msm_dsi *msm_dsi,
-				   struct drm_encoder *encoder);
+int msm_dsi_manager_bridge_init(struct msm_dsi *msm_dsi,
+				struct drm_encoder *encoder);
 int msm_dsi_manager_cmd_xfer(int id, const struct mipi_dsi_msg *msg);
 bool msm_dsi_manager_cmd_xfer_trigger(int id, u32 dma_base, u32 len);
 int msm_dsi_manager_register(struct msm_dsi *msm_dsi);
diff --git a/drivers/gpu/drm/msm/dsi/dsi_manager.c b/drivers/gpu/drm/msm/dsi/dsi_manager.c
index 2a5326f1fa8b..9edace2b396d 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_manager.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_manager.c
@@ -3,7 +3,6 @@
  * Copyright (c) 2015, The Linux Foundation. All rights reserved.
  */
 
-#include "drm/drm_bridge_connector.h"
 
 #include "msm_kms.h"
 #include "dsi.h"
@@ -458,13 +457,11 @@ static const struct drm_bridge_funcs dsi_mgr_bridge_funcs = {
 };
 
 /* initialize bridge */
-int msm_dsi_manager_connector_init(struct msm_dsi *msm_dsi,
-				   struct drm_encoder *encoder)
+int msm_dsi_manager_bridge_init(struct msm_dsi *msm_dsi,
+				struct drm_encoder *encoder)
 {
-	struct drm_device *dev = msm_dsi->dev;
 	struct drm_bridge *bridge;
 	struct dsi_bridge *dsi_bridge;
-	struct drm_connector *connector;
 	int ret;
 
 	dsi_bridge = devm_drm_bridge_alloc(msm_dsi->dev->dev, struct dsi_bridge, base,
@@ -484,12 +481,6 @@ int msm_dsi_manager_connector_init(struct msm_dsi *msm_dsi,
 	if (ret)
 		return ret;
 
-	connector = drm_bridge_connector_init(dev, encoder);
-	if (IS_ERR(connector)) {
-		DRM_ERROR("Unable to create bridge connector\n");
-		return PTR_ERR(connector);
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 62961dddd8f5..33474e90af53 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -11,7 +11,6 @@
 #include <linux/pinctrl/consumer.h>
 #include <linux/platform_device.h>
 
-#include <drm/drm_bridge_connector.h>
 #include <drm/drm_of.h>
 #include <drm/display/drm_hdmi_state_helper.h>
 
@@ -164,7 +163,6 @@ static int msm_hdmi_modeset_init(struct msm_display *display,
 		struct drm_device *dev, struct drm_encoder *encoder)
 {
 	struct hdmi *hdmi = container_of(display, struct hdmi, display);
-	struct drm_connector *connector = NULL;
 	int ret;
 
 	hdmi->dev = dev;
@@ -173,7 +171,7 @@ static int msm_hdmi_modeset_init(struct msm_display *display,
 	ret = msm_hdmi_bridge_init(hdmi);
 	if (ret) {
 		DRM_DEV_ERROR(dev->dev, "failed to create HDMI bridge: %d\n", ret);
-		goto fail;
+		return ret;
 	}
 
 	if (hdmi->next_bridge) {
@@ -181,34 +179,20 @@ static int msm_hdmi_modeset_init(struct msm_display *display,
 					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
 		if (ret) {
 			DRM_DEV_ERROR(dev->dev, "failed to attach next HDMI bridge: %d\n", ret);
-			goto fail;
+			return ret;
 		}
 	}
 
-	connector = drm_bridge_connector_init(hdmi->dev, encoder);
-	if (IS_ERR(connector)) {
-		ret = PTR_ERR(connector);
-		DRM_DEV_ERROR(dev->dev, "failed to create HDMI connector: %d\n", ret);
-		connector = NULL;
-		goto fail;
-	}
-
 	ret = devm_request_irq(dev->dev, hdmi->irq,
 			msm_hdmi_irq, IRQF_TRIGGER_HIGH,
 			"hdmi_isr", hdmi);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev->dev, "failed to request IRQ%u: %d\n",
 				hdmi->irq, ret);
-		goto fail;
+		return ret;
 	}
 
 	return 0;
-
-fail:
-	if (connector)
-		connector->funcs->destroy(connector);
-
-	return ret;
 }
 
 static void msm_hdmi_snapshot(struct msm_display *display,
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 1a081e15a0a8..71af3780b7b1 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -10,7 +10,10 @@
 #include <linux/sched/mm.h>
 #include <uapi/linux/sched/types.h>
 
+#include <drm/drm_bridge_connector.h>
+#include <drm/drm_connector.h>
 #include <drm/drm_drv.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_mode_config.h>
 #include <drm/drm_vblank.h>
 #include <drm/clients/drm_client_setup.h>
@@ -271,15 +274,15 @@ static int msm_display_modeset_init(struct msm_display *display,
 }
 
 /*
- * Set up the bridges and connectors for the display sub-blocks, dispatching
- * through the common display interface using the encoders the backend created
- * in ->kms_init().
+ * Set up the bridge chains for the display sub-blocks, dispatching through the
+ * common display interface using the encoders the backend created in
+ * ->kms_init().
  *
- * The slave link of a bonded DSI pair shares its master's encoder and creates
- * no connector of its own; its ->modeset_init() handles that internally, so it
+ * The slave link of a bonded DSI pair shares its master's encoder and sets up
+ * no bridge of its own; its ->modeset_init() handles that internally, so it
  * needs no special-casing here.
  */
-static int msm_kms_init_connectors(struct drm_device *ddev)
+static int msm_kms_modeset_init(struct drm_device *ddev)
 {
 	struct msm_drm_private *priv = ddev->dev_private;
 	struct msm_kms *kms = priv->kms;
@@ -310,6 +313,35 @@ static int msm_kms_init_connectors(struct drm_device *ddev)
 	return ret;
 }
 
+/* Build a bridge connector for each encoder. */
+static int msm_kms_init_connectors(struct drm_device *ddev)
+{
+	struct drm_encoder *encoder;
+
+	drm_for_each_encoder(encoder, ddev) {
+		struct drm_connector *connector;
+		int ret;
+
+		/* the virtual writeback encoder brings its own connector */
+		if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
+			continue;
+
+		connector = drm_bridge_connector_init(ddev, encoder);
+		if (IS_ERR(connector)) {
+			DRM_DEV_ERROR(ddev->dev,
+				      "failed to init connector for %s: %ld\n",
+				      encoder->name, PTR_ERR(connector));
+			return PTR_ERR(connector);
+		}
+
+		/* The DP subconnector property applies to DisplayPort only. */
+		if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
+			drm_connector_attach_dp_subconnector_property(connector);
+	}
+
+	return 0;
+}
+
 int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(dev);
@@ -353,6 +385,10 @@ int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)
 	 * ->hw_init(); now set up the bridges and connectors for them from
 	 * common code.
 	 */
+	ret = msm_kms_modeset_init(ddev);
+	if (ret)
+		goto err_msm_uninit;
+
 	ret = msm_kms_init_connectors(ddev);
 	if (ret)
 		goto err_msm_uninit;

-- 
2.47.3

