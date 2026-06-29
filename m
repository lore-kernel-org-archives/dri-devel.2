Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0735FC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6717010E95E;
	Mon, 29 Jun 2026 14:48:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EW68smx1";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pp5X7YRC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD7B10E957
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TATFZg2579199
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X9Wvi0l8jMqT7/U0aQTPnpvZ/UDWx6KX/hO6+hpKeMw=; b=EW68smx10BFKmiie
 Uc6Qa69muzZ00svaL3GZ8DyOhIC3AFRTjGt27zJ1utDUIR+jS3P0XNp67lSDLuRF
 GevsOXtZ598t3WpdoFUdv2YOhya55lbryzDz5qPaeuFNonWu6uPcd+49xYOz8i+8
 M2hrj8wgrVsd+zYz2l+LVF66ZRU56fNUDsIQEMghjj9Pf0aEHd+9d0Ej4zyOE6MQ
 N0rbh0aCMoC2n5+fUowhCIhT3R9xuS3Vmr+vUyxRCxfbyvHfUWNQ5w+fy0E19mlY
 Xy/sFISbVztQgjmL4HuOa64wfZJG0dGNF1D4ecAb7UmJ1ATgcLKUc9KWbelT/xB6
 46in+Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f3kp7hwda-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:48:28 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4aeea5c3so176136585a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782744507; x=1783349307;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=X9Wvi0l8jMqT7/U0aQTPnpvZ/UDWx6KX/hO6+hpKeMw=;
 b=Pp5X7YRCHbGiiEz8aDgNzQio5559iStvEoiekr36Vp/zbxLVHkC3Z7OiThQaZ29ScQ
 GAu0JcDvw0rShyorJfAAXogdFM4w8shyIpwN2JOmCjSZUGSPorqyDbMR9cPM799dT5xP
 MYCHKXFirm6wrLbz7zO81LsnWogIcml4JTYLtIlnauzyWaWFtO7MvJ8GonyzbmVWYQZH
 t5s9MQ+xWoueFPsUEl1itHrBAPQxV9wL6aGi1NS8D85T2gj6/moVFc5lEGHp7dr5ZlfC
 pcIPDbL/ktX4fdyeKVRgdrwcvipSB7OWv+d/YdbhwHbbohoovmWfKn7gnbxKKNbXrKEx
 mUIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782744507; x=1783349307;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=X9Wvi0l8jMqT7/U0aQTPnpvZ/UDWx6KX/hO6+hpKeMw=;
 b=K4WBM9SYikqsUXTqvY3WUleekww+99tI3KBiwMR/kEsXNbkwpz3L2UOLwr0gG42BDz
 CGtj6z618ekz7Q6pSktEY+SFqpw/O6plEQxmw8fkW+WDc1USBlIe5pP7eAAU0BSR18Gb
 qImlRBat5utXitENANY3dlXaqmD3zgyNY+GlfJZOMrhpuMPVMr47rVHRr5ljtcd0wRSO
 XSlSD0FECR/NbsTw9mZTiOAke5AdcRw9Og7j+Qf2hLBz5KYVWnkULLdBEbp7dcqQP5ty
 ilg2vZTcGo3fs2nAgBY9wAB4MwVFxXcTQt/RAcySJg11j4pB1Pfs0ARvXOwDKcQcNBbW
 YxVQ==
X-Gm-Message-State: AOJu0YwfCaJ4GTSDpO1CQtQj1VOwuV/nCzUY1sCzXgYqPL2E5aHVlmYs
 W+aVacc9DrSVwdkhWW9NNj9WOcDY13/4jWpin/v3hCbFAP4StwybwJeBhxf3tWG1XEDmV/e7hap
 MwD3V8pSNI81h3EAlD4VR5yixUc74PSMa2WImVRiuwj0RcZSomqh3GcSUVNxvEI001N1RAyM=
X-Gm-Gg: AfdE7cnfeTR5JUZZEYmEypAXWCfazSJEGAyr7n2o04VK8V13t4RPWlZbURj+7mHELJT
 fbSJhg1UUWdjx3xp5R1V3N+j55ZFeQ3+C7h9ZpWgaVbB+0WulyW6TMweIFItsGqP8CR94sUFEyp
 0+xKMktf1l7rFB2BUhCKjCyN5wWyfn/waGJ2rp7zHwVaKt2/9CiKkBvaY2CVAR0isbwBMuH0mlY
 fy2t2M7684sdaV9RVXDxfdO/lSiWLw4liy6XE4hNLoz2ihfJ689WRMeHrHqkDsTUFUVGk8jPE7S
 Hh1WEYrXZJXJoUJ6Le2M9meA+KjeI5Q4Qr1xvYwdTvS39gvzwFgr5Jwp8mo8gb+bDJA2xQisRWP
 7gLEbSm1utgC1IMSKMpur7B8J8N41ijxwnKJ3wtktBtyyAzewjGq2PCZhlnfIf9q4VE0uaalDhQ
 ==
X-Received: by 2002:a05:620a:269f:b0:910:c308:159f with SMTP id
 af79cd13be357-92927eac1a7mr2441206685a.28.1782744507228; 
 Mon, 29 Jun 2026 07:48:27 -0700 (PDT)
X-Received: by 2002:a05:620a:269f:b0:910:c308:159f with SMTP id
 af79cd13be357-92927eac1a7mr2441197485a.28.1782744506554; 
 Mon, 29 Jun 2026 07:48:26 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-926004ab49csm2087974385a.34.2026.06.29.07.48.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:48:26 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 29 Jun 2026 22:48:03 +0800
Subject: [PATCH 1/5] drm/bridge: allow hpd_notify() to suppress connector
 hotplug events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260629-msm-dp-msttypec-v1-1-646a10256233@oss.qualcomm.com>
References: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
In-Reply-To: <20260629-msm-dp-msttypec-v1-0-646a10256233@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Kevin Hilman <khilman@baylibre.com>, Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782744487; l=7698;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=PZfP5zuUOw1cQ4+LbkkW+tP+uE6tAqqOHKM8isRi0iE=;
 b=PvOG0vzHfOEMpn6Uc9ILDR0y6vdBC7zisS8HN4guZduHppi/Eca5NIGvMGyXQQ7++RkaWSBX4
 xjf96he6N3RBpVPKPXR/VP/AEMmjfUrD/o/s9muDMP+aPYaMRfJzPQT
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfX9NAziQCso+Gt
 2m/XF6nqgICqXjwmdhBsGXiMxCOnd09jY89lfsHRfvLe3X6qB2L1yVOWqodh5V2npPQznYznt9F
 9wKXy7Stm08nz9zfAfAxo7cOEGZmWDA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDEyMyBTYWx0ZWRfX8D6hgZ5zjmnF
 QUQy6/QCEJTYIqkAadCx/4J/zRTz1i8NtDmxfAOgQldC3QWi3ibZeoedaFpeOmettCRcFpZyC/i
 WTeEv4fhUzpsCGNg/sfhDxs+88aUD2APWEK0JAj9wqxOLJchUUX890l4HWFwMr3mcw9PaZIbKIs
 QL94wrc+G2jzOgP+r2xh8oVQ4duPP/oONZk85X2+M/kRS8HN6Zp0V/Ljr6FwoXMTNvfwpovXmYX
 ApK+ssVnD0xzdos/PTGexfcUwH7s7KjbEA5Pa+3/nsrjBawDudWn+qoAIGz8jropbihnFo8xWbc
 y5E7H1nanql2kNdJ4KFZIlNG+H7s4RPAuKMHH0qnwo5h4r2kfi9IDh+cuEx1anJZ40axlhR1zcJ
 MoJTCBHSO+ju6nmCz6s6KafalFDCGAtbKa04VvK9novOBHj939lyMDGj9SNCvW2VkfJpRYp45+B
 caxFXojKPxb2ol/9ygQ==
X-Proofpoint-ORIG-GUID: cZZFUZINcHEH7-mS1JKAFYTVZS-3qcEk
X-Authority-Analysis: v=2.4 cv=MZJcfZ/f c=1 sm=1 tr=0 ts=6a4285bc cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=dveiew7hPdaQvXAhsgwA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: cZZFUZINcHEH7-mS1JKAFYTVZS-3qcEk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 clxscore=1015 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290123
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

The bridge connector framework currently invokes all bridge
hpd_notify() callbacks and unconditionally emits a connector hotplug
event afterwards.

However, not every HPD notification requires a userspace hotplug event.

In particular, DP MST bridges may use hpd_notify() to propagate HPD and
IRQ notifications through the bridge chain while the actual hotplug
handling is performed by the DRM DP MST core. Connector creation,
removal and userspace hotplug events are already managed by the MST
topology framework.

Allow hpd_notify() implementations to suppress the bridge connector
hotplug event by introducing a bool *send_hotplug parameter. Drivers
can clear this flag when HPD processing should not result in a
connector hotplug notification.

A NULL pointer indicates that hotplug suppression is not supported by
the caller, such as the connector detect polling path.

Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     |  3 ++-
 drivers/gpu/drm/display/drm_bridge_connector.c | 15 +++++++++------
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     |  3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c            |  3 ++-
 drivers/gpu/drm/msm/dp/dp_drm.h                |  3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            |  3 ++-
 include/drm/drm_bridge.h                       |  3 ++-
 7 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 8cb17bd0e238..42e1cadcd3fb 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -430,7 +430,8 @@ static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *brid
 static void lt9611uxc_bridge_hpd_notify(struct drm_bridge *bridge,
 					struct drm_connector *connector,
 					enum drm_connector_status status,
-					enum drm_connector_status_extra extra_status)
+					enum drm_connector_status_extra extra_status,
+					bool *send_hotplug)
 {
 	const struct drm_edid *drm_edid;
 
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 8f7075fd2aa5..5edca47a025f 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -142,7 +142,8 @@ struct drm_bridge_connector {
 
 static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
 					    enum drm_connector_status status,
-					    enum drm_connector_status_extra extra_status)
+					    enum drm_connector_status_extra extra_status,
+					    bool *send_hotplug)
 {
 	struct drm_bridge_connector *bridge_connector =
 		to_drm_bridge_connector(connector);
@@ -150,13 +151,14 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
 	/* Notify all bridges in the pipeline of hotplug events. */
 	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
 		if (bridge->funcs->hpd_notify)
-			bridge->funcs->hpd_notify(bridge, connector, status, extra_status);
+			bridge->funcs->hpd_notify(bridge, connector, status,
+						  extra_status, send_hotplug);
 	}
 }
 
 static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bridge_connector,
-					    enum drm_connector_status status,
-					    enum drm_connector_status_extra extra_status)
+	enum drm_connector_status status,
+	enum drm_connector_status_extra extra_status)
 {
 	struct drm_connector *connector = &drm_bridge_connector->base;
 	struct drm_device *dev = connector->dev;
@@ -165,7 +167,7 @@ static void drm_bridge_connector_handle_hpd(struct drm_bridge_connector *drm_bri
 	connector->status = status;
 	mutex_unlock(&dev->mode_config.mutex);
 
-	drm_bridge_connector_hpd_notify(connector, status, extra_status);
+	drm_bridge_connector_hpd_notify(connector, status, extra_status, NULL);
 
 	drm_kms_helper_connector_hotplug_event(connector);
 }
@@ -227,7 +229,8 @@ drm_bridge_connector_detect(struct drm_connector *connector, bool force)
 		if (hdmi)
 			drm_atomic_helper_connector_hdmi_hotplug(connector, status);
 
-		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA_STATUS);
+		drm_bridge_connector_hpd_notify(connector, status,
+						DRM_CONNECTOR_NO_EXTRA_STATUS, NULL);
 	} else {
 		switch (connector->connector_type) {
 		case DRM_MODE_CONNECTOR_DPI:
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 4aecf0ffcf75..a67e7b365c5b 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -324,7 +324,8 @@ static int meson_encoder_hdmi_atomic_check(struct drm_bridge *bridge,
 static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
 					  struct drm_connector *connector,
 					  enum drm_connector_status status,
-					  enum drm_connector_status_extra extra_status)
+					  enum drm_connector_status_extra extra_status,
+					  bool *send_hotplug)
 {
 	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index fcfee26f0078..6835c68fe510 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1763,7 +1763,8 @@ void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge)
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			      struct drm_connector *connector,
 			      enum drm_connector_status status,
-			      enum drm_connector_status_extra extra_status)
+			      enum drm_connector_status_extra extra_status,
+			      bool *send_hotplug)
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
 	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index f6b96c27408a..07ddcd055962 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -32,6 +32,7 @@ void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			      struct drm_connector *connector,
 			      enum drm_connector_status status,
-			      enum drm_connector_status_extra extra_status);
+			      enum drm_connector_status_extra extra_status,
+			      bool *send_hotplug);
 
 #endif /* _DP_DRM_H_ */
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index d02d432abde4..ad659cef16f5 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -430,7 +430,8 @@ static void hdmi4_bridge_disable(struct drm_bridge *bridge,
 static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
 				    struct drm_connector *connector,
 				    enum drm_connector_status status,
-				    enum drm_connector_status_extra extra_status)
+				    enum drm_connector_status_extra extra_status,
+				    bool *send_hotplug)
 {
 	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 9c4c88024cc5..e6de665ce8f6 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -616,7 +616,8 @@ struct drm_bridge_funcs {
 	void (*hpd_notify)(struct drm_bridge *bridge,
 			   struct drm_connector *connector,
 			   enum drm_connector_status status,
-			   enum drm_connector_status_extra extra_status);
+			   enum drm_connector_status_extra extra_status,
+			   bool *send_hotplug);
 
 	/**
 	 * @hpd_enable:

-- 
2.43.0

