Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7ECC4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E2B410EC83;
	Wed, 22 Jul 2026 06:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="T2jdroEs";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ql2b5jHg";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C64710EC79
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:41 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53lgg3767875
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XnRrKHywGDxOUzWeTEWzWWRjTrZo78jT5PLWnVtgFyM=; b=T2jdroEsepbJfOw/
 xp6sT6YcsThvbp/BgihiRth+xsuYICbmhr63PpyVhG/9I1c1zmD6pBbP+2WqvEgL
 akfHuShxAAJ/4Tigbpg+FGqGAdW/6wVc11REJde2D5u7AivZenjssjxQqqd91W2w
 EFWSBQm7kHexNOaq9VaZW8T/gGqCKv8e7xUNbh//WACaTBXYFAxYu9kWISY+en15
 wAsPC8Kg8zqAW8rovtiLnSltuWx9Cit/oO1ueoOPvdOLocbNve35iX9VyfrVZoRP
 E4p4lcN7u4PLh0gluG8J6L5pyqsYQzsYmc47t5wjI1YvCoYJ/amLokgUxSnZSDQI
 jBA8pg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjnu4rnc6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:40 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a8db414c7so212193601cf.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702260; x=1785307060;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XnRrKHywGDxOUzWeTEWzWWRjTrZo78jT5PLWnVtgFyM=;
 b=Ql2b5jHgMyK1f0uQd12hOU262fu820dv4QBoYLLoNo5y7GGn4/C4Rm5/65p/mUvGhT
 c3AI4EUaS6Stx9WHLhevwrQoE8JaZ3C+S0gxVEJEpd6/Yy9Q/Zt4FXWm1l+726+qSpo2
 CYLKerujHIUCF2LVZYKLTrGxwgK0AWqne+37j5Y2f7TWBUvfL6Cz3mCgcLJqiJg0ygOt
 lsX+etM/R5iNtOrwfOI5Tx6tE+f0Y6SCXv/ZJj5+2K/1DJNEcGEkdC6FhOPVO6WULXDB
 DGU83bzBS2gJceDQrhjWoAzjR19TvKenc3p9ZMg14xV7VH3t3pAkMyXIO4x4lOBQpwH2
 JcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702260; x=1785307060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=XnRrKHywGDxOUzWeTEWzWWRjTrZo78jT5PLWnVtgFyM=;
 b=Ja+TX6hHYN7ZSb0SYpXFYKdpTA5LtiXaDtY5lftZL3PUWGOjdQgZXvOseFTqf03eUO
 iZVavvJhPOmSNwmRnusowuaBZkQql8D7fgt67m6bmx6jkuNPMfprYTvId9vHGH0KpZ+o
 FF9At/SJJApooGtsOJahO04LLAEstG3sCWfGUs1d6oNxDI8Rl5Vxp8wy0O5WJmYxaQK2
 aw4MC9CPvAYf1EWAjxzQp+SQN/jk/ElIf9yupfq2k0A23jYQ92jRtHcD8H/WwkPH/Wxl
 9FqGlyrDMzTEwbpC+6HrSxtWPiqWkpNeoKkCTKXkRNvc6m/ygO08aMyBhVExuJjcqACl
 vhTw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqjCgA8obtAFifiu8OAmXqSGerXLTa+qQTHhzhRWhSr/APqL/rwcMBaUh7iBuJVAdTxq5bMvAzBQ/I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxltPG1vHeKFY3k1mEls+/k96e8WKAb87hRuiFH2I0w2KAtIr1a
 vAD3ISOL0ddddtDEDfo7uooCxK6gncPe955l2H9EYHda68BQbWNN5rkdcWhvJ0FF2/PrCP3AWgw
 ARveojvqEt8R7Meu2mOhilLYnPfKRGkIYk1jYPfuWlFG8sWmtn3/8NaQ0MlMb23ARGvfipu4=
X-Gm-Gg: AR+sD10100vIMqVcn15ujWVKAsRCgX7/Ylmt9Iqk3s6XdgTQX/sWNe8fo+1jYtVyfZ+
 S70guMRKwTKENI48HPz1chYV+V2ubq28QLB0O39a4mokas5rKE3Xz201tcOimb3NNCF0X5rmawV
 tpaA/PqroYcgb6TE0HzHFL6imE6GUoG27w6Xj8v3DFWx646SIS145sN6hecocu3OR/1ujixczYI
 Y+xsvw/EAu823JmeltcXZ8dJ35SSZ6e30s2lRRneKl4Hqe5DiPOLV/rGPYeFJadNx9qLRYtln5I
 a36cF8dF0gBr5ivMEQFL36QfhGKcIfC2RAn0Hei/wsCIsVp+clVpkmH+bIRQaYJLEPLzga+8Y6O
 eky422VmNqA/HsKZiuQEt37QCnaticYQKzOv6NJq1P431XR8loxtmzOVBrbR4546Xobcn63gDDd
 AY6wQMc5RTN7uEPA==
X-Received: by 2002:a05:622a:4108:b0:51b:fa52:807b with SMTP id
 d75a77b69052e-5213e77dc72mr218367211cf.47.1784702259610; 
 Tue, 21 Jul 2026 23:37:39 -0700 (PDT)
X-Received: by 2002:a05:622a:4108:b0:51b:fa52:807b with SMTP id
 d75a77b69052e-5213e77dc72mr218366961cf.47.1784702259068; 
 Tue, 21 Jul 2026 23:37:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.37.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:37:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:39 +0300
Subject: [PATCH 24/24] drm/bridge-connector: attach the DP subconnector
 property
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-24-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2406;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=oODRCXTyFFCwRZ0Sv7FS2y/hkfGA+35WKYSGZcOEml0=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTq0i//7pQq5pWgVJJSpoN7VfhV6Bjv6skYl
 NtppAvB7VCJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk6gAKCRCLPIo+Aiko
 1VmsCACifTf6rchkhuEjQrSuhh1LqItb5kRl4fyZdnHEsMSloGVzlQYWwHNMev4dNiVo8g5oFjh
 IrGWNPyfQOZRFchjDhqhkJZ85oMoSnP4JPdjSFZ/5qDZkjZE00xZtUOrsG5fjJTnlSc+6mC2qH0
 9GF3NvkhY9NPZ/Dskc8WQXKdeBgdakU00j5+PvKx1yeYRGjMRKXZotxhK7LIHGUCkBQATaBgmRm
 zmAtrdw6SX7iimV2sLl15TnjwUgP3/kpt6DFTdAdZF0tvULaGjlHsRcPDZSoSjNfDxLzVzczr7P
 y8mM1KPwa7BnoCnQKkncZ228nEC0Y0Jh6QRGh4rRzGKph1aP
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: j2mrebL2OyVJBTKIu767uW0iSAWEGg8v
X-Authority-Analysis: v=2.4 cv=KLhqylFo c=1 sm=1 tr=0 ts=6a606534 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=3i-1COqLn-c5cVpzcnsA:9 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX7Cbg2iYdxN6I
 TVAEaYApbosMAKGbl4/gyE4PHGDKEadfSi8kVM5K9DoqFdyTc8x67eQVMn5G1qUbM4Rs0Cqh92I
 vjP1IJeCAaHajozdZiQDdwQlACODjk6S5JDec3IhxwdeVPnJy5/ftN7NNKyIj3+wfJ0RTP2Klc6
 vdQlKb4QnJT3p1pCxjsrxpFuFKh2+ojlgH8xfYFOe1WHAHxqCFRCM3YQpPaNk8KqS48Nr6MGwSu
 mZeGLnCqwpSacY3OXwtqxXmSIWcJG5gy+b7NXWsCtI8CtPqHLbp9k8F6UQmHObmD3scpEIpVfkU
 LuxYbd2RqlX3MzwS+0nPffhtjMuSawRUNv1nWsPpiV3XnGyzXeBdMjDMlaSLe0YB/J+XHJijPdU
 N/GVBMaeRalD9zATyTvwoKulUyjhUV8Z0CWXmgclJVZzcrbg2HON78SiMKVZiK6Kv1iW9Qovq/4
 z6BNVze53fFhAdjkTyw==
X-Proofpoint-ORIG-GUID: j2mrebL2OyVJBTKIu767uW0iSAWEGg8v
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX3Fwcop0DSRsj
 G04AwNrpe+P3nQckmYZbTDikt1gVrGskNJapZSmlIKl+ucLeJzoMlFU12LR1Oz5BZclxj0BCnOY
 mtYaGykTt0GgrYbb3JsbcHxNLovI1Uk=
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

DisplayPort connectors can expose the subconnector property, describing
the attached dongle. While i915 and amdgpu drivers already provide this
property, bridge-based DisplayPort connectors don't expose it.

Attach the DP subconnector property from drm_bridge_connector_init()
whenever the resolved connector type is DisplayPort, and drop the
open-coded attachment from the msm code, pushing other DP drivers
towards adding support for the property.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 4 ++++
 drivers/gpu/drm/msm/msm_kms.c                  | 5 -----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8b54069fa53a..f83d5f52ab14 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -1089,6 +1089,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 	    IS_ENABLED(CONFIG_DRM_DISPLAY_HDCP_HELPER))
 		drm_connector_attach_content_protection_property(connector, true);
 
+	/* The DP subconnector property applies to DisplayPort only. */
+	if (connector_type == DRM_MODE_CONNECTOR_DisplayPort)
+		drm_connector_attach_dp_subconnector_property(connector);
+
 	ret = drm_connector_attach_encoder(connector, encoder);
 	if (ret)
 		return ERR_PTR(ret);
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 71af3780b7b1..cf602be09ff8 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -320,7 +320,6 @@ static int msm_kms_init_connectors(struct drm_device *ddev)
 
 	drm_for_each_encoder(encoder, ddev) {
 		struct drm_connector *connector;
-		int ret;
 
 		/* the virtual writeback encoder brings its own connector */
 		if (encoder->encoder_type == DRM_MODE_ENCODER_VIRTUAL)
@@ -333,10 +332,6 @@ static int msm_kms_init_connectors(struct drm_device *ddev)
 				      encoder->name, PTR_ERR(connector));
 			return PTR_ERR(connector);
 		}
-
-		/* The DP subconnector property applies to DisplayPort only. */
-		if (connector->connector_type == DRM_MODE_CONNECTOR_DisplayPort)
-			drm_connector_attach_dp_subconnector_property(connector);
 	}
 
 	return 0;

-- 
2.47.3

