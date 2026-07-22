Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E21FC44512
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B0610EC67;
	Wed, 22 Jul 2026 06:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="PMuIjw10";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N2IafnKZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 697BE10EC50
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:42 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53vAp3996205
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 s2WFosEjx5mL1fry95UZtUlBXhZEDC7Nphcd8IbkOew=; b=PMuIjw10/fpWE+i9
 tpIxgw0iQSglHKshT/xWjSqtPxEeYJVB/mNAl05LT5Sj4syrdAZAjc6KXWOWX1qi
 NxEI6Mwm+NBXqygZsRq/79j9dAqxij8fLsioraC6J29UPdW0xXsD8lagH8Ngli6t
 wQwiNnIYwcWotFhI5eyIpTe71nGdO2A5UsaEFmZLP/Jk1ma8zv22tiD10Qg4smPO
 llbkPvmBGcBjFTfnEt52CWz+Aw7AF1AIAI0aJi0W+uht3DQBubvFdXfyoT0ct6Y9
 ZHfQV2YLA6DNOY1VgFH+/quTDdAnI6FgbVmchtIrZrek3yqgpQN7BQ7f45xoBS0I
 sanr/w==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d2k4h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:36:40 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e97889ac8aso209813606d6.3
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702200; x=1785307000;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=s2WFosEjx5mL1fry95UZtUlBXhZEDC7Nphcd8IbkOew=;
 b=N2IafnKZnyqFpeWtsL25UaTl8ZI0LoNIgZB5Fh17jLsI4vRZ9h5nLHj2aqKelNvIWA
 mYws/WFCcvcL3VWcj3okSHHOaZVH2RTnKp1Doc7ygF/PBgDFFtu4x4jFPpmYRmxlGx89
 HFYwrzSjIF55EEVm9y+EpS4htvBbamiF28hiUsf4DlNC4XI8m2SwRtYC2RIiOULf9gxC
 R/3HrZZJ/yk1KaiNjCS9flXHYyi+4+4ae//ji8uzY1u80YzV+YGjFqGDwzrOz+3rK6pj
 cBQHSp+KYc0WxKi6p7h0JelyQL4mfQEI0Zi0E0X0v5xj2gXgsBH2AmDJWMzbUNHPAPdF
 SKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702200; x=1785307000;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s2WFosEjx5mL1fry95UZtUlBXhZEDC7Nphcd8IbkOew=;
 b=F8UHn8UJjlkSnnN8fXuT1YqWGzuroNoBD+Yd46Fa5q6/I6nnD0pabQ0fZgQDceUAEf
 FWvHghWBamFVMdQJeWHWA1ms4Lv8VqBcRAGCZlvjuFEAQ+ADR78z7q/pT3o07K4eKL04
 Tb7kVG/0CNEu1tEVFBXWHxn8s6khuJJwTDaX/Cc6cpNW3PkwYD+O9jZ7CQ0ylzCFWLBU
 APISyVXrpEk4Apom11xXOoACwHwpfRvj4mrUCLcdor45VHK2tXohHdu1ipWhr65QnNfT
 6A7K4llRzcwHQiPBD/fM5387VOf5C6sNZqkZAzGS7shUkmL66U5CxHT/XxcVeDCv+0j/
 yHoQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUlgiamblj7iTCsRBGreTr4ze3PE6pAlqrowDn06G34/ffgkjvHDpFoZ9+5R9/P6BR+oA9dhWfsBY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxtKtdxG40U+neYzpmmtc/yC0i5gnsI7R/etGpqF3MfMZgQ/d6B
 aD7cjnPHNTzdlRL+FyOU/q2ljaCv/x0N6Zhq903ywq31npC+OttL/EpQtn9BfzcsgNKjGnLvsZ8
 3RXEAttV/uIUnLRmIAj3l7Q0X9GRRu28EQnAUm8edHss4NHqnu0k+/qKs4vdES3Lja/Agg/s=
X-Gm-Gg: AR+sD13VklxeH4EXDweYZVZT9PAx00nu6C2hJo+JGmDhHPJqjUcN3kKyc/2ys39CjNN
 QUodKdA8EuSNp7iYELFOL4xdtQHKSh3CXhT0jv0RytIdY2P1X3NL+2Zd78uh2W5r+gV14US6qYM
 juhVCfvjXUbhJ9R85Yg1as8emozMAsu/dsTDLeCNElXP4H8vzTKZRonid2xZ97AwFYs30zAOiLK
 KIXLE67aTKfip06ndETlkeOVOtJjMopdabNPo/uQOEZfk+uKkcxiOCcI0WGEemx5uaBhHmnBu1T
 05GMLuzmbkNlmR4W5DBs39lJOqWqUMq4vHQ++zHAYFsFZ/snofq8dsXxrGu7G6boE680gaDanOX
 DERkecwVZt5w6s13+uJ6gfrrbxt35KEJj3asBK+3Ft3Q6mk8Xg4uJN6oCkTVOxJq9pAreSH811Q
 DGpvF+2UuEhAEj2g==
X-Received: by 2002:ac8:5705:0:b0:51c:7b12:5fe9 with SMTP id
 d75a77b69052e-5213f46eecemr203114821cf.85.1784702199985; 
 Tue, 21 Jul 2026 23:36:39 -0700 (PDT)
X-Received: by 2002:ac8:5705:0:b0:51c:7b12:5fe9 with SMTP id
 d75a77b69052e-5213f46eecemr203114571cf.85.1784702199446; 
 Tue, 21 Jul 2026 23:36:39 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:37 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:19 +0300
Subject: [PATCH 04/24] drm/msm: introduce the struct msm_display interface
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-4-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14063;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=dQq1YP1Zgxo5wlRNn1ky+tfmQFYD+CU0qqdX3e33yF4=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTm32+s5Aq9TFVw6J/Dt04/OahxDzQYoqv8o
 tY4vg/1PKmJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk5gAKCRCLPIo+Aiko
 1WBlB/4wkfgDeTfXALuLn/xPGBejzMsFa67zv5YfgYdek89ujIIdXd0e8IupplKTUBCEbNMVIm/
 CEF5eDGd9WxHV8EPuFMMSSNIPNwMVazIPKKxovYCKJ1ZRdnU5emr+2gCRRG8ZB3goP1nkyWlgUx
 z1xWey+KzJYzAnpy3zHBKpA8ukvokdKgQkO8NKKhAdSKs4cXrjiqBcdjlRUBoFPg5Gfkn/omVrz
 Xvd2MtQlqEI6UFCorBgZN/Rj27GvPV7dZvUo/4F8yWTU9GVE2+FqbgygD/ztYGzF5yecE9RfbOG
 8PY773N7dApmhULTSbuoqhPnlLiNLqzULB4XGaDnFSfV2izv
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: LnjH3x7KycewtBiodDtL4mvCRMqU2-yD
X-Proofpoint-ORIG-GUID: LnjH3x7KycewtBiodDtL4mvCRMqU2-yD
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a6064f8 cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=KkC0EXddP0L80uirutwA:9 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfXzAvYGnT1Vg2F
 Drczk4g0OPE3Q/R4tizWSNnw4JQt3SvOvdF6taAd3Sf5cdvDHfzRNcuyhy3STVRu7i4bOw2nwW9
 JMsGOE9vjTc8PYUfsfy7orT18WUUAJLS8swPzXascjX/P4ZvEUwvzXx+bZ4ue3ZH4nYENyNy3Rb
 R4TFfLqtHJ3uM6ooVNFYd5ZZM6hGGxjGjWn61yoXcbWXiYA1+nHe5NFMU7oWQJDNpUC5YKLYY56
 cdTK1iUt4qUNIYRT3UIknKkgnSERObCzgagbycnGhy2JP0FqHOsvpmtj93EJ3y3dd+SmCFefkhC
 UXREaMRQdO3I+We7UatDSGPbB91O2l9xi0Dgo2g/Riq6veNadvc3x1numFtN+PyLOJUuaF/NmTQ
 PeElGxhY8mARnfNHhBd+GfiAFxjcmc9wOp3HlfOcxl2FwiNPZL5VpTkw0ig72XuMOyzGOa9skGM
 WLxmws02esHBTf5dnDA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX8XEVgcUtBCmz
 tpdvtq9EqV57jqKwseuGww7yRl59WPJ7nnrYighurWpLhVy5M73/C8B632+rzKmCyB1fS8u0O4b
 wCJy9mjVfxKLJAQN80EsBqza9j9uPk4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-22_02,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 lowpriorityscore=0 suspectscore=0
 bulkscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
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

The common connector setup in msm_kms_init_connectors() calls the
type-specific msm_dsi_modeset_init(), msm_dp_modeset_init() and
msm_hdmi_modeset_init() functions, so it has to know about each concrete
sub-block type.

Introduce a small struct msm_display interface with a modeset_init()
callback, embedded in struct hdmi, struct msm_dsi and struct msm_dp. Each
sub-block registers its ops and provides a msm_*_get_display() accessor;
the common code then dispatches through display->funcs->modeset_init()
without knowing the concrete type. Further per-sub-block operations will
be folded into this interface in following patches.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/dp/dp_display.c | 17 ++++++++--
 drivers/gpu/drm/msm/dp/dp_display.h |  2 ++
 drivers/gpu/drm/msm/dsi/dsi.c       | 18 ++++++++--
 drivers/gpu/drm/msm/dsi/dsi.h       |  2 ++
 drivers/gpu/drm/msm/hdmi/hdmi.c     | 13 +++++++-
 drivers/gpu/drm/msm/hdmi/hdmi.h     |  2 ++
 drivers/gpu/drm/msm/msm_drv.h       | 50 ++++++++++++++++++----------
 drivers/gpu/drm/msm/msm_kms.c       | 66 ++++++++++++++++++-------------------
 8 files changed, 115 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 5ae5eed7e010..79dd556e96c2 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -203,6 +203,8 @@ void msm_dp_display_signal_audio_complete(struct msm_dp *msm_dp_display)
 	complete_all(&dp->audio_comp);
 }
 
+static const struct msm_display_funcs msm_dp_display_funcs;
+
 static int msm_dp_display_bind(struct device *dev, struct device *master,
 			   void *data)
 {
@@ -212,6 +214,7 @@ static int msm_dp_display_bind(struct device *dev, struct device *master,
 	struct drm_device *drm = priv->dev;
 
 	dp->msm_dp_display.drm_dev = drm;
+	dp->msm_dp_display.display.funcs = &msm_dp_display_funcs;
 	priv->kms->dp[dp->id] = &dp->msm_dp_display;
 
 	dp->drm_dev = drm;
@@ -1317,9 +1320,10 @@ void msm_dp_display_debugfs_init(struct msm_dp *msm_dp_display, struct dentry *r
 		DRM_ERROR("failed to initialize debug, rc = %d\n", rc);
 }
 
-int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
-			struct drm_encoder *encoder)
+static int msm_dp_modeset_init(struct msm_display *display,
+			       struct drm_device *dev, struct drm_encoder *encoder)
 {
+	struct msm_dp *msm_dp_display = container_of(display, struct msm_dp, display);
 	struct msm_dp_display_private *msm_dp_priv;
 	int ret;
 
@@ -1348,6 +1352,15 @@ int msm_dp_modeset_init(struct msm_dp *msm_dp_display, struct drm_device *dev,
 	return 0;
 }
 
+static const struct msm_display_funcs msm_dp_display_funcs = {
+	.modeset_init = msm_dp_modeset_init,
+};
+
+struct msm_display *msm_dp_get_display(struct msm_dp *msm_dp_display)
+{
+	return msm_dp_display ? &msm_dp_display->display : NULL;
+}
+
 void msm_dp_bridge_atomic_enable(struct drm_bridge *drm_bridge,
 				 struct drm_atomic_commit *state)
 {
diff --git a/drivers/gpu/drm/msm/dp/dp_display.h b/drivers/gpu/drm/msm/dp/dp_display.h
index 0b65e16c790d..20a71afb1f90 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.h
+++ b/drivers/gpu/drm/msm/dp/dp_display.h
@@ -12,6 +12,8 @@
 #define DP_MAX_PIXEL_CLK_KHZ	675000
 
 struct msm_dp {
+	struct msm_display display;
+
 	struct drm_device *drm_dev;
 	struct platform_device *pdev;
 	struct drm_connector *connector;
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index 3c9f01ed6271..6cd844d08733 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -115,6 +115,8 @@ static struct msm_dsi *dsi_init(struct platform_device *pdev)
 	return ERR_PTR(ret);
 }
 
+static const struct msm_display_funcs msm_dsi_display_funcs;
+
 static int dsi_bind(struct device *dev, struct device *master, void *data)
 {
 	struct msm_drm_private *priv = dev_get_drvdata(master);
@@ -136,6 +138,7 @@ static int dsi_bind(struct device *dev, struct device *master, void *data)
 		msm_dsi->next_bridge = ext_bridge;
 	}
 
+	msm_dsi->display.funcs = &msm_dsi_display_funcs;
 	priv->kms->dsi[msm_dsi->id] = msm_dsi;
 
 	return 0;
@@ -230,9 +233,11 @@ void __exit msm_dsi_unregister(void)
 	platform_driver_unregister(&dsi_driver);
 }
 
-int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
-			 struct drm_encoder *encoder)
+static int msm_dsi_modeset_init(struct msm_display *display,
+				struct drm_device *dev,
+				struct drm_encoder *encoder)
 {
+	struct msm_dsi *msm_dsi = container_of(display, struct msm_dsi, display);
 	int ret;
 
 	msm_dsi->dev = dev;
@@ -262,6 +267,15 @@ int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
 	return 0;
 }
 
+static const struct msm_display_funcs msm_dsi_display_funcs = {
+	.modeset_init = msm_dsi_modeset_init,
+};
+
+struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
+{
+	return msm_dsi ? &msm_dsi->display : NULL;
+}
+
 void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi)
 {
 	msm_dsi_host_snapshot(disp_state, msm_dsi->host);
diff --git a/drivers/gpu/drm/msm/dsi/dsi.h b/drivers/gpu/drm/msm/dsi/dsi.h
index 93c028a122f3..1d1bda0682db 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.h
+++ b/drivers/gpu/drm/msm/dsi/dsi.h
@@ -32,6 +32,8 @@ enum msm_dsi_phy_usecase {
 #define DSI_BUS_CLK_MAX		4
 
 struct msm_dsi {
+	struct msm_display display;
+
 	struct drm_device *dev;
 	struct platform_device *pdev;
 
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 474006084633..03367c6ba428 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -159,9 +159,10 @@ static int msm_hdmi_init(struct hdmi *hdmi)
  * should be handled in msm_hdmi_init() so that failure happens from
  * hdmi sub-device's probe.
  */
-int msm_hdmi_modeset_init(struct hdmi *hdmi,
+static int msm_hdmi_modeset_init(struct msm_display *display,
 		struct drm_device *dev, struct drm_encoder *encoder)
 {
+	struct hdmi *hdmi = container_of(display, struct hdmi, display);
 	int ret;
 
 	hdmi->dev = dev;
@@ -210,6 +211,15 @@ int msm_hdmi_modeset_init(struct hdmi *hdmi,
 	return ret;
 }
 
+static const struct msm_display_funcs msm_hdmi_display_funcs = {
+	.modeset_init = msm_hdmi_modeset_init,
+};
+
+struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
+{
+	return hdmi ? &hdmi->display : NULL;
+}
+
 /*
  * The hdmi device:
  */
@@ -243,6 +253,7 @@ static int msm_hdmi_bind(struct device *dev, struct device *master, void *data)
 	err = msm_hdmi_init(hdmi);
 	if (err)
 		return err;
+	hdmi->display.funcs = &msm_hdmi_display_funcs;
 	priv->kms->hdmi = hdmi;
 
 	return 0;
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.h b/drivers/gpu/drm/msm/hdmi/hdmi.h
index 49433f7727c3..f24444610fe1 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.h
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.h
@@ -31,6 +31,8 @@ struct hdmi_audio {
 struct hdmi_hdcp_ctrl;
 
 struct hdmi {
+	struct msm_display display;
+
 	struct drm_device *dev;
 	struct platform_device *pdev;
 
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 0ec0622d9217..dbd955091ce7 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -274,17 +274,39 @@ int msm_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	.fbdev_probe = NULL
 #endif
 
+struct msm_display;
+
+/**
+ * struct msm_display_funcs - ops provided by a display sub-block (DSI/DP/HDMI)
+ * @modeset_init: create the bridge and connector for the sub-block, attaching
+ *                to @encoder.
+ */
+struct msm_display_funcs {
+	int (*modeset_init)(struct msm_display *display, struct drm_device *dev,
+			    struct drm_encoder *encoder);
+};
+
+/**
+ * struct msm_display - common interface to a display sub-block
+ * @funcs: sub-block provided ops
+ *
+ * Embedded in each sub-block (&struct hdmi, &struct msm_dsi, &struct msm_dp)
+ * so that common KMS code can set up their connectors without knowing the
+ * concrete type.
+ */
+struct msm_display {
+	const struct msm_display_funcs *funcs;
+};
+
 struct hdmi;
 #ifdef CONFIG_DRM_MSM_HDMI
-int msm_hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
-		struct drm_encoder *encoder);
+struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi);
 void __init msm_hdmi_register(void);
 void __exit msm_hdmi_unregister(void);
 #else
-static inline int msm_hdmi_modeset_init(struct hdmi *hdmi, struct drm_device *dev,
-		struct drm_encoder *encoder)
+static inline struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
 {
-	return -EINVAL;
+	return NULL;
 }
 static inline void __init msm_hdmi_register(void) {}
 static inline void __exit msm_hdmi_unregister(void) {}
@@ -296,8 +318,7 @@ int dsi_dev_attach(struct platform_device *pdev);
 void dsi_dev_detach(struct platform_device *pdev);
 void __init msm_dsi_register(void);
 void __exit msm_dsi_unregister(void);
-int msm_dsi_modeset_init(struct msm_dsi *msm_dsi, struct drm_device *dev,
-			 struct drm_encoder *encoder);
+struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi);
 void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi);
 bool msm_dsi_is_cmd_mode(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
@@ -312,11 +333,9 @@ static inline void __init msm_dsi_register(void)
 static inline void __exit msm_dsi_unregister(void)
 {
 }
-static inline int msm_dsi_modeset_init(struct msm_dsi *msm_dsi,
-				       struct drm_device *dev,
-				       struct drm_encoder *encoder)
+static inline struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
 {
-	return -EINVAL;
+	return NULL;
 }
 static inline void msm_dsi_snapshot(struct msm_disp_state *disp_state, struct msm_dsi *msm_dsi)
 {
@@ -353,8 +372,7 @@ struct msm_dp;
 #ifdef CONFIG_DRM_MSM_DP
 int __init msm_dp_register(void);
 void __exit msm_dp_unregister(void);
-int msm_dp_modeset_init(struct msm_dp *dp_display, struct drm_device *dev,
-			 struct drm_encoder *encoder);
+struct msm_display *msm_dp_get_display(struct msm_dp *dp_display);
 void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display);
 bool msm_dp_needs_periph_flush(const struct msm_dp *dp_display,
 			       const struct drm_display_mode *mode);
@@ -368,11 +386,9 @@ static inline int __init msm_dp_register(void)
 static inline void __exit msm_dp_unregister(void)
 {
 }
-static inline int msm_dp_modeset_init(struct msm_dp *dp_display,
-				       struct drm_device *dev,
-				       struct drm_encoder *encoder)
+static inline struct msm_display *msm_dp_get_display(struct msm_dp *dp_display)
 {
-	return -EINVAL;
+	return NULL;
 }
 
 static inline void msm_dp_snapshot(struct msm_disp_state *disp_state, struct msm_dp *dp_display)
diff --git a/drivers/gpu/drm/msm/msm_kms.c b/drivers/gpu/drm/msm/msm_kms.c
index 87530145e82b..3f855f9b3d06 100644
--- a/drivers/gpu/drm/msm/msm_kms.c
+++ b/drivers/gpu/drm/msm/msm_kms.c
@@ -260,9 +260,24 @@ void msm_drm_kms_uninit(struct device *dev)
 		kms->funcs->destroy(kms);
 }
 
+static int msm_display_modeset_init(struct msm_display *display,
+				    struct drm_device *ddev,
+				    struct drm_encoder *encoder)
+{
+	if (!display)
+		return 0;
+
+	return display->funcs->modeset_init(display, ddev, encoder);
+}
+
 /*
- * Set up the bridges and connectors for the display sub-blocks, using the
- * encoders the backend created in ->kms_init().
+ * Set up the bridges and connectors for the display sub-blocks, dispatching
+ * through the common display interface using the encoders the backend created
+ * in ->kms_init().
+ *
+ * The slave link of a bonded DSI pair shares its master's encoder and creates
+ * no connector of its own; its ->modeset_init() handles that internally, so it
+ * needs no special-casing here.
  */
 static int msm_kms_init_connectors(struct drm_device *ddev)
 {
@@ -270,45 +285,30 @@ static int msm_kms_init_connectors(struct drm_device *ddev)
 	struct msm_kms *kms = priv->kms;
 	int i, ret;
 
-	/*
-	 * The slave link of a bonded DSI pair shares its master's encoder and
-	 * creates no connector of its own; msm_dsi_modeset_init() handles that
-	 * internally, so it needs no special-casing here.
-	 */
 	for (i = 0; i < ARRAY_SIZE(kms->dsi); i++) {
-		if (!kms->dsi[i])
-			continue;
-
-		ret = msm_dsi_modeset_init(kms->dsi[i], ddev, kms->dsi_encoder[i]);
-		if (ret) {
-			DRM_DEV_ERROR(ddev->dev,
-				      "modeset_init failed for dsi[%d]: %d\n", i, ret);
-			return ret;
-		}
+		ret = msm_display_modeset_init(msm_dsi_get_display(kms->dsi[i]),
+					       ddev, kms->dsi_encoder[i]);
+		if (ret)
+			goto fail;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(kms->dp); i++) {
-		if (!kms->dp[i])
-			continue;
-
-		ret = msm_dp_modeset_init(kms->dp[i], ddev, kms->dp_encoder[i]);
-		if (ret) {
-			DRM_DEV_ERROR(ddev->dev,
-				      "modeset_init failed for dp[%d]: %d\n", i, ret);
-			return ret;
-		}
+		ret = msm_display_modeset_init(msm_dp_get_display(kms->dp[i]),
+					       ddev, kms->dp_encoder[i]);
+		if (ret)
+			goto fail;
 	}
 
-	if (kms->hdmi) {
-		ret = msm_hdmi_modeset_init(kms->hdmi, ddev, kms->hdmi_encoder);
-		if (ret) {
-			DRM_DEV_ERROR(ddev->dev,
-				      "modeset_init failed for HDMI: %d\n", ret);
-			return ret;
-		}
-	}
+	ret = msm_display_modeset_init(msm_hdmi_get_display(kms->hdmi),
+				       ddev, kms->hdmi_encoder);
+	if (ret)
+		goto fail;
 
 	return 0;
+
+fail:
+	DRM_DEV_ERROR(ddev->dev, "modeset_init failed: %d\n", ret);
+	return ret;
 }
 
 int msm_drm_kms_init(struct device *dev, const struct drm_driver *drv)

-- 
2.47.3

