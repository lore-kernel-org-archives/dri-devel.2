Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDDFC4452D
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 06:37:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8475010EC70;
	Wed, 22 Jul 2026 06:37:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="Xal8yxiR";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Z9925UX8";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5D4910EC6E
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:02 +0000 (UTC)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66M53uRW3996123
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bu7eRwc4ThvRAi2plwmdFoPFrPMRFwSAWWRJNUn4iXs=; b=Xal8yxiRF3YwO/jy
 SmWVze4QAW16aYwtowEsdIxb16iDe9JUtwFXa43WLPQHAqatyHnQm5lymADYYjKq
 cxGjp7ctX+c56LJ93owMAnd8biX6IRg8L5eDtHzEgifPxJ54i7iio/euKbdT3BFo
 3eJD7trz2QQaOlR9M4wH+hq5qfn3BKrZBmiPpLgVJeTFckGYqwp8/K2MTxueiqM2
 Kr9tsVLsHCx66wIXAAKyyTujvCbdR7aw0OdbtcrY7eZJL1WhgbghUPImiWCDtftP
 Eo/LZ8tWI38ljjsRyvA5YG7QYS39I7spQL64eNcI0LVONtZ8hqqVMoALR6xuUosX
 NJ6YIw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fjd6d2k5u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 06:37:01 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c1a9764f0so250832131cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 23:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784702221; x=1785307021;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bu7eRwc4ThvRAi2plwmdFoPFrPMRFwSAWWRJNUn4iXs=;
 b=Z9925UX8Z8wcd30TWZcem4HCE9OK6wrYel+B62pF8ezszNCaOCmSgii2QNDWXVrYt/
 HE2zwL6eKTqR+naIaiMw7UbcYoF4Fv5arGH7B1qdvx+cKxk3AQln6Ukh/r174lWDVy9Q
 yIC4qyz5HMBXAf14LiCCYEchshshPpMAY3V31Z51LCaYm6pz0PD2c+SV4ajx8Vh9QcGU
 j43/bs/0aUm6feoRcoIFRVYX3bUmxTMjeC+eAxacxeE4Sf0845pCu5bf6R4E6YC7Fd33
 YzXVl1se+FctswStze7/uzNI12jSdZajAgYP9bGGA6QLMcWwvZq0Q+ejnECLNfAcyDDV
 aCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784702221; x=1785307021;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bu7eRwc4ThvRAi2plwmdFoPFrPMRFwSAWWRJNUn4iXs=;
 b=TxoLjNs5QXnCW6SKkYj5zNitWnDa8BvMjL7j98GCYsn5rE25E2GQqbOFQ+ePLEBHt0
 aO89sSE0HmMUVIX9esGYp7jxW948B7i6TvxbiKIlSG/UO4D2iIww7WcVAttwqM6noZaU
 JdgtGomkF4JJXAXz9R7HdJ4rDJnWraLUcSeTu6F95ttU3s3ylnJi5jAhKEKw4O98dKsB
 i2f7mvAinX+iI4UWs5b21S/KHaJjOIamFDiq83Fa5dnOYTZ1KAd58RErDx64uExYOWki
 YKrZOLh4QkZqzHyzTbt/ir9nWS1UDh+Pskkan9imUf7k/PtdM2LhQRs/ivCcT5IYhAmm
 a3Rg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqwQu8uLoQEO5lCzcBjxp1AYh0drj660PkprSID+CJb+oAE+7L0bSN1g3x0rD6XyQVndBZlOK9KmRw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwE527CRysA7nxRe4Jba3YBGEyk0yRhXaFR7qr2gJcTMoVAkNom
 zk72MvShJ97lcNS6o0QTK3UxcuKe987DkxzEj+kgwF4a0Ac6OqXaDpfSZ40ade1RYKA4dttqaim
 T5sWo0nrxE/vRRZfeU3/tihPCFGfsuCr7d42f4mUKyC+ggsJnyd6WQu3dN1XeDKGAK+EAeQI=
X-Gm-Gg: AR+sD11fm+3qMWOW9O9dYkzG+tNBxnztflmP7oMxr5oKs6hc+eOarp2SidrGX/u3p+G
 2tINh5B3LKqOFt+CZ1Cd1XShO19d83EDDSx7GDVyKlJToxysp1A1mZQBPgup5R7SJKVrLB9JOHt
 PqxYpkz0RA5H2ZIVii3Echpxc6BFgxYIBUJH0t87icSC1eZTrOS26L1tcoVorHwM0z9jx/WKGTr
 aTFLG8ShyyOw/LFPkHJa9oFKb/rZ2g76/rN8qcBxMizXh/WTX5xTjza6pbLjoozR1iRRU5O7HmF
 +irfXEhHqfMJmwwZKkrRdOGx/ljFJRry7Oa8EzIqvtcAmKEJiW/dCdxhhFd7g3cD1WFBZ33J4ym
 q7YYxryerOOT0chMTKJ8CNf4GKGIp/QuPEdNq6tSVAIf14QCUukeKLkSN94cT6m5JECR8AaNbPv
 WAdNMdNt5TFEXKbA==
X-Received: by 2002:a05:622a:2595:b0:51c:844f:28da with SMTP id
 d75a77b69052e-5213aa6e34amr200542271cf.5.1784702220953; 
 Tue, 21 Jul 2026 23:37:00 -0700 (PDT)
X-Received: by 2002:a05:622a:2595:b0:51c:844f:28da with SMTP id
 d75a77b69052e-5213aa6e34amr200542081cf.5.1784702220527; 
 Tue, 21 Jul 2026 23:37:00 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5b2a9b8c6f6sm309696e87.4.2026.07.21.23.36.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 23:36:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 22 Jul 2026 09:36:25 +0300
Subject: [PATCH 10/24] drm/msm: add the get_dsc_config callback to msm_display
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-drm-msm-display-interface-v1-10-368c10fe62fd@oss.qualcomm.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6149;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=mic+nEGujiZA8skeNgXqs73Yz1UH5vF0sRWJb295FiA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqYGTnGBoAGG/QDQJd06aG3s1xGr+xz59NKFvji
 FbUT2sc6+mJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCamBk5wAKCRCLPIo+Aiko
 1QwtB/9MUZd7vpnKI3x8owNAN1eIDN7gdRv4WAb4zGN8bbEDTgO4s11JkzWdzWYx9Ch/8y4nR5R
 sTHWH7GMxNpDijjNylxwv6bO4Qq2iOazuF1Qfs0Ygc7cAUSy6iW06aAMJfg4gzOSSXf10RHlwn8
 C33CCroFRlbciRDxJB4oAn/8DxpK15cJ0f/Qh1JAmR+1PnB8Hb0wA9ZoBk1db9xo39vEnMphP47
 qDv2SGEtFFLxOJKE+Ie2/U0J2yCxmTQSaUb3oD2L4ZwLvlXF7ZYf1nGblxv2+MWcgNMakZrUETv
 JebETE7954mpiPl1TY53WOKw5Klf0onUXwkKDYHuIs/A6rYf
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-GUID: zHpzJPzna0RAabJi7YBIB-lzh2nB72os
X-Proofpoint-ORIG-GUID: zHpzJPzna0RAabJi7YBIB-lzh2nB72os
X-Authority-Analysis: v=2.4 cv=XaG5Co55 c=1 sm=1 tr=0 ts=6a60650d cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=zUt5drCBtZ0E8LnXtbIA:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX1NpHxwrSV+oY
 bKcAAb+wKEzRWauJLAWY2o7t8xj9l5/zFTJTsi99V/f4wvLjogYo27gstZwS8Lyn/rtdo5P7696
 z+yLILxz/Yf1YW2WY3EohEExlL0OpUPPgfIe1Qyvhfm20anHyLPMDaXrnEYIQ71Z+9Xa4sC3JGX
 oXlCD7MNrufO3G5WLXgrVqLXXZhO7rHdovHAHRYb2BuKd8dj4Tf6JZ0D1z6icbxsMNwjVGhBZoR
 m/AbZv1tOUj4cbGp3NXpdCr3SwO188wojIkeA1mRCgDDrIl3oBRHNeh7c2k9+o3YnyUdGq/HXS9
 C/RHzZ2DEvCaD3vahnwJGqoM3CF8Jp450YCyNaewS9P1y3WL3PjNdEwP26gIhJ9inLPsgVt+fyW
 kM+qBaou74t763T5uC1g0IMHreIeykLF0cBu8EZtDHucBQ3FuCqs+c8/gVUh66s3DkbIsBIkwDL
 sXNYADjDg0dJRTqWoNA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIyMDA2MCBTYWx0ZWRfX/3mu/EoWLt/l
 yRbDhTWL9hhU550VEqEMh89BmXzM3zLwpiHBmBJ3dsL9pObaGwk6k6fjZQGWF9pfeb36muPwjrO
 4hcewE+G6TDYVH57opQ8TAL/sgahbyU=
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

dpu_encoder_get_dsc_config() special-cases INTF_DSI to fetch the DSC
config from the concrete DSI sub-block via msm_dsi_get_dsc_config().

Add a mandatory get_dsc_config() callback to struct msm_display_funcs; DSI
returns its host DSC config, DP and HDMI return NULL. The DPU encoder now
uses the generic display lookup and the callback, dropping the
interface-type special case.

No functional change intended.

Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c | 8 ++++----
 drivers/gpu/drm/msm/dp/dp_display.c         | 6 ++++++
 drivers/gpu/drm/msm/dsi/dsi.c               | 5 ++++-
 drivers/gpu/drm/msm/hdmi/hdmi.c             | 6 ++++++
 drivers/gpu/drm/msm/msm_drv.h               | 8 ++------
 5 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 09bf959b2ca7..569f3759d02c 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -666,12 +666,12 @@ bool dpu_encoder_use_dsc_merge(struct drm_encoder *drm_enc)
  */
 struct drm_dsc_config *dpu_encoder_get_dsc_config(struct drm_encoder *drm_enc)
 {
-	struct msm_drm_private *priv = drm_enc->dev->dev_private;
 	struct dpu_encoder_virt *dpu_enc = to_dpu_encoder_virt(drm_enc);
-	int index = dpu_enc->disp_info.h_tile_instance[0];
+	struct msm_display *display = dpu_encoder_get_display(drm_enc->dev,
+							     &dpu_enc->disp_info);
 
-	if (dpu_enc->disp_info.intf_type == INTF_DSI)
-		return msm_dsi_get_dsc_config(priv->kms->dsi[index]);
+	if (display)
+		return display->funcs->get_dsc_config(display);
 
 	return NULL;
 }
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index 425526db7ef9..047295d46c02 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1374,12 +1374,18 @@ static bool msm_dp_display_is_cmd_mode(struct msm_display *display)
 	return false;
 }
 
+static struct drm_dsc_config *msm_dp_display_get_dsc_config(struct msm_display *display)
+{
+	return NULL;
+}
+
 static const struct msm_display_funcs msm_dp_display_funcs = {
 	.modeset_init = msm_dp_modeset_init,
 	.snapshot = msm_dp_snapshot,
 	.wide_bus_enabled = msm_dp_display_wide_bus_enabled,
 	.needs_periph_flush = msm_dp_display_needs_periph_flush,
 	.is_cmd_mode = msm_dp_display_is_cmd_mode,
+	.get_dsc_config = msm_dp_display_get_dsc_config,
 };
 
 struct msm_display *msm_dp_get_display(struct msm_dp *msm_dp_display)
diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
index bda778dbcc5b..e42f5b929b84 100644
--- a/drivers/gpu/drm/msm/dsi/dsi.c
+++ b/drivers/gpu/drm/msm/dsi/dsi.c
@@ -13,8 +13,10 @@ static bool msm_dsi_is_cmd_mode(struct msm_display *display)
 	return !(host_flags & MIPI_DSI_MODE_VIDEO);
 }
 
-struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
+static struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_display *display)
 {
+	struct msm_dsi *msm_dsi = container_of(display, struct msm_dsi, display);
+
 	return msm_dsi_host_get_dsc_config(msm_dsi->host);
 }
 
@@ -291,6 +293,7 @@ static const struct msm_display_funcs msm_dsi_display_funcs = {
 	.wide_bus_enabled = msm_dsi_wide_bus_enabled,
 	.needs_periph_flush = msm_dsi_needs_periph_flush,
 	.is_cmd_mode = msm_dsi_is_cmd_mode,
+	.get_dsc_config = msm_dsi_get_dsc_config,
 };
 
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi)
diff --git a/drivers/gpu/drm/msm/hdmi/hdmi.c b/drivers/gpu/drm/msm/hdmi/hdmi.c
index 828cb89ebf9a..918fc9c88a19 100644
--- a/drivers/gpu/drm/msm/hdmi/hdmi.c
+++ b/drivers/gpu/drm/msm/hdmi/hdmi.c
@@ -244,12 +244,18 @@ static bool msm_hdmi_is_cmd_mode(struct msm_display *display)
 	return false;
 }
 
+static struct drm_dsc_config *msm_hdmi_get_dsc_config(struct msm_display *display)
+{
+	return NULL;
+}
+
 static const struct msm_display_funcs msm_hdmi_display_funcs = {
 	.modeset_init = msm_hdmi_modeset_init,
 	.snapshot = msm_hdmi_snapshot,
 	.wide_bus_enabled = msm_hdmi_wide_bus_enabled,
 	.needs_periph_flush = msm_hdmi_needs_periph_flush,
 	.is_cmd_mode = msm_hdmi_is_cmd_mode,
+	.get_dsc_config = msm_hdmi_get_dsc_config,
 };
 
 struct msm_display *msm_hdmi_get_display(struct hdmi *hdmi)
diff --git a/drivers/gpu/drm/msm/msm_drv.h b/drivers/gpu/drm/msm/msm_drv.h
index 5320e4977af9..cda9849811b1 100644
--- a/drivers/gpu/drm/msm/msm_drv.h
+++ b/drivers/gpu/drm/msm/msm_drv.h
@@ -287,6 +287,7 @@ struct msm_disp_state;
  *                    mandatory.
  * @needs_periph_flush: whether @mode requires a peripheral flush; mandatory.
  * @is_cmd_mode:  whether the sub-block runs in command mode; mandatory.
+ * @get_dsc_config: return the DSC config for the sub-block, or NULL; mandatory.
  */
 struct msm_display_funcs {
 	int (*modeset_init)(struct msm_display *display, struct drm_device *dev,
@@ -297,6 +298,7 @@ struct msm_display_funcs {
 	bool (*needs_periph_flush)(struct msm_display *display,
 				   const struct drm_display_mode *mode);
 	bool (*is_cmd_mode)(struct msm_display *display);
+	struct drm_dsc_config *(*get_dsc_config)(struct msm_display *display);
 };
 
 /**
@@ -334,7 +336,6 @@ void __exit msm_dsi_unregister(void);
 struct msm_display *msm_dsi_get_display(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_bonded_dsi(struct msm_dsi *msm_dsi);
 bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi);
-struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi);
 const char *msm_dsi_get_te_source(struct msm_dsi *msm_dsi);
 #else
 static inline void __init msm_dsi_register(void)
@@ -356,11 +357,6 @@ static inline bool msm_dsi_is_master_dsi(struct msm_dsi *msm_dsi)
 	return false;
 }
 
-static inline struct drm_dsc_config *msm_dsi_get_dsc_config(struct msm_dsi *msm_dsi)
-{
-	return NULL;
-}
-
 static inline const char *msm_dsi_get_te_source(struct msm_dsi *msm_dsi)
 {
 	return NULL;

-- 
2.47.3

