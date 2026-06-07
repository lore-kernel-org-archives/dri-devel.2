Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C72CCD8CAA
	for <dri-devel@archiver.kernel.org>; Sun,  7 Jun 2026 21:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44B2310E5E5;
	Sun,  7 Jun 2026 21:33:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="IfvAqeMh";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QgzxNOQC";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 289A410E4B9
 for <dri-devel@lists.freedesktop.org>; Sun,  7 Jun 2026 21:33:29 +0000 (UTC)
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 657Em7QY339112
 for <dri-devel@lists.freedesktop.org>; Sun, 7 Jun 2026 21:33:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 kiGy/JVajFIukktw5owJydRTv8D1sE7z5Bd4+V1lofM=; b=IfvAqeMhQA3w7gsk
 5Alk4DF4N0JH0KwTuB3eXWzoXmzNinLzj0ClsiwjPc+guvwtFneMRSFBh/rc0HlJ
 NvtAmvIguXP4FqYMxKAH/KhnjfxbJggLaeNf/X2q8W7elFkbyNQqoiFhDiDAqlAV
 555LxiXgU/VSbu4ZsUcN/MCLKMnwSd5q/NyBK2Xg/SUW5SVo0q6Z1ubwjivrJkOH
 r/DmXRmt3+4qzF7dtcDoSinzmEyq0TLJvKQ3AtdMjkG8IEOYmYgs37j6PG0aVNY/
 O4tfdbm5fliyVoVh99RpkMAK7MOFKgT9cUbQxL+GnuI/HThJKdGh4sEYzXs7Cgx+
 4au1BQ==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqgvhch-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 21:33:28 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8cce1c3c26bso118988196d6.2
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 14:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780868007; x=1781472807;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kiGy/JVajFIukktw5owJydRTv8D1sE7z5Bd4+V1lofM=;
 b=QgzxNOQCGbLP8THuGcqUftbbWvsg6GTe4zFDoaXkcJs83pKH4pG6fLwSEpfVO77Bi/
 28YID0sVuRwmb3znYbSWI+K9O1tZmhuNsOYIkfF/ioP7+O3IAvrKd7NYmhRpE3oLcwAK
 XNSj77fO5b7n2yDU+pbqadmYFfeLfgESHh8xnKVXPHJerFvn4qvExvJh35OMBcmBN71u
 4EN6QrmSPrYLc3s4ZBVtTi5A/tNTv590IROZU8A/XsIRAUExoOm0pLzKfdSxyQzJY2OZ
 BtFkSsE27eO60G3nP1evCUcLtCnKyQ2LUYaWcvriYJCPcsnGVasAyJqyHV5BdXA3oStI
 LwYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780868007; x=1781472807;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=kiGy/JVajFIukktw5owJydRTv8D1sE7z5Bd4+V1lofM=;
 b=qLHst5xg99NSS4VQYu6lDGqJ0fQhA+06W9I2cJLjUNCfspG4o0fyDayfbQvGmRgYmG
 nhrSrZJPZRjO32ut5PNSQDFljug980ahS0RDbDkt0rAMaNZZ0n0CSt3DXBkuFf/yweam
 GOmGPc163h7efkFGrwKryECB47+23PtDqwG/fW6bLr32nrYBXrD8yX9Roi8f3U5nA+Ut
 Zzvm7jStGLsDuODNdmbPZK+TQSWMm/n8gla9wPKNoNYo+SYo8aFrDmxrcMWkzmkY1G9n
 5oaNT/JLKjxRIAANGcmCTtzhiNBFWYYEuncxKeKKMTGh5UD48BtlH+ms/ahRSjGj11NT
 4aAA==
X-Gm-Message-State: AOJu0Yy6iDztC4k9grzBKDS4MO/qQWR3gYFHAvuyWZ9G6kjKEzcby+fS
 zVKZiSHrbwO4KxRz4LamXqr2CIJcPlMgpYdrNGiwcm5yg3wFEJMFdSsWIW6mo9nmb4C2SihXM/z
 xOtozAuq8Xzq7u6qS9H08p5+3Ss14Xac0dirF1+NcjA+9MCZBGmwTLtazGgNqqW4WoTbL4fk=
X-Gm-Gg: Acq92OHi8wtEItJ1JbHCgzTVHSGlN+rRX7yDJVyHf50TU6kWrxZPPNFG0tbtU/ASXhw
 H/mbMAeR+KBIP5zeSez9YsL9GziKH7jpvBVthIDopvnwYvxO3LStKuO4cM3E/KN0t8olNh6gFds
 6/sd+MmmPVXdkdPT8HR7A3N0eXRHe7yA8Md7seCXrceuUUUe3e8HqmmH8NMZUM7XAfqN/vhqg92
 vQvx+mKjNXCKWjvAH/gkfsqbsZdWCB7rZzcvpXQ9oD/4+CadlpIVswpkp5wawgnhYkFTfP9zoRM
 cY4XVhKtb1gBcW3tOa9jQIER/N1Q35zls0iwsjAuqZ0hHYviQ/VmGU2OPOmvzn54mNBtVs4ypJK
 5iAdkvJ5NUhQ/oqQVVZa5f34V906Od3qpp+t9p1S2dBv9G5doF0E1TfMSLjtlnM7BBq/lzFvRze
 GzfPUquF8UuNn8+RnKtzXzSQPbCT6YP25Xk1y+PUjggvrJNA==
X-Received: by 2002:ad4:53c6:0:b0:8cc:f135:52af with SMTP id
 6a1803df08f44-8cee6134a06mr166005846d6.24.1780868007539; 
 Sun, 07 Jun 2026 14:33:27 -0700 (PDT)
X-Received: by 2002:ad4:53c6:0:b0:8cc:f135:52af with SMTP id
 6a1803df08f44-8cee6134a06mr166005386d6.24.1780868007134; 
 Sun, 07 Jun 2026 14:33:27 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-396ac2d5ea9sm40374041fa.32.2026.06.07.14.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 14:33:25 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Mon, 08 Jun 2026 00:33:06 +0300
Subject: [PATCH v4 5/8] drm/bridge: pass down IRQ_HPD to the drivers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-hpd-irq-events-v4-5-30b62b335487@oss.qualcomm.com>
References: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
In-Reply-To: <20260608-hpd-irq-events-v4-0-30b62b335487@oss.qualcomm.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>,
 Pengyu Luo <mitltlatltl@gmail.com>, Nikita Travkin <nikita@trvn.ru>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Francesco Dolcini <francesco@dolcini.it>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5210;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=5ElUVbocQ0iy2D7k4OSQYGFJA4wuG0p7RdSU3WVG4AY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqJeOQyj+mOsk53KpLOI7BgWch0S1P0qlexQHVj
 QyBxAnUhaSJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCaiXjkAAKCRCLPIo+Aiko
 1bHPCACpzwkqWwBmlm3hEBRQEaLNtjJ4ixNpHz+KFuG2tLcPBqwnOTCnIWKTokmxQIPcwM6Yp2W
 FWCul8g8831IzUI986tYlkGuykff9QCUSRsIsPrCTqy+ysd2/VPkR3DdSx+f6tdj8fKuZBV4Kaf
 9slQ7JyOtsR6OGKVXoUA1eDX24qdqR0dou+URi7qC3Wb9svooTtqeJzkyq7+ZJIAm2/uA2GGUZS
 gD7AVEXZmhxRv5AxbmsrRsafVW+M+NDNDVuU9ThbFwFnopPm+INKpB6YWtHza1daXidoGdVeEbU
 C0VC3M7JQ+P81XsZRBqgXmDKlXRIeW0Qoxh5bOs3chXnxWV5
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a25e3a8 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=P5073aSicUuGdIvNCfYA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-GUID: N7aDIqTb-N1UM-dVnXPcWAfux7bRfp5R
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDIxNyBTYWx0ZWRfX1yNfSBN21E+t
 EwOAt3S7+ur2FfUObBqYNk+GLBWEbMBWd86lg8q5uO8/DEMlA1v3kcnGz2j3/f0DpIKAGIdrPR1
 ma44LpP0d5D8Tcxm7Iy2ETJho1gHPmZJrtDdFscL+gUlD1OxN4hov9KipXQSpKlJpU0eyvl8R7j
 F1Z8fLVbLdvtsOc6Sn1imS7tkNg70+G8VTHBn7RqFKVYQyrUmLaqEdT0oJfJ4UrTM35Z6Wrnjn3
 6eqbbsODGkpg2i1UEz6/lx+9XbXZYpqM3rasJlj5ztE/8qHYsAzSJmDjJ2l/z0qDfhGsR4UWbz+
 O64zPiXPK77gTaYR8lmXbClkufOcUvJTbyu1+ni5X5iZCb4sEueTGcRbfcjCC4Q4CqtOG+1U4bw
 OqJFzsDPOtuglo+EyT7WRtutBu8bleeC7pajAJn6aEohoT6vII6V8+eNfgyIBp9pQMIocy/Lafr
 Cek3IUdGp8OzOwDBQ9g==
X-Proofpoint-ORIG-GUID: N7aDIqTb-N1UM-dVnXPcWAfux7bRfp5R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_04,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070217
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

The DisplayPort standard defines a special kind of HPD events called
IRQ_HPD. These events are used to notify DP Source about the events on
the Sink side. Pass down the extra status to the bridge drivers via the
hpd_notify() callback, letting DP bridges to act accordingly.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c     | 3 ++-
 drivers/gpu/drm/display/drm_bridge_connector.c | 2 +-
 drivers/gpu/drm/meson/meson_encoder_hdmi.c     | 3 ++-
 drivers/gpu/drm/msm/dp/dp_display.c            | 3 ++-
 drivers/gpu/drm/msm/dp/dp_drm.h                | 3 ++-
 drivers/gpu/drm/omapdrm/dss/hdmi4.c            | 3 ++-
 include/drm/drm_bridge.h                       | 3 ++-
 7 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 9427cc2358ae..8cb17bd0e238 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -429,7 +429,8 @@ static const struct drm_edid *lt9611uxc_bridge_edid_read(struct drm_bridge *brid
 
 static void lt9611uxc_bridge_hpd_notify(struct drm_bridge *bridge,
 					struct drm_connector *connector,
-					enum drm_connector_status status)
+					enum drm_connector_status status,
+					enum drm_connector_status_extra extra_status)
 {
 	const struct drm_edid *drm_edid;
 
diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index a34643d3ddef..8f7075fd2aa5 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -150,7 +150,7 @@ static void drm_bridge_connector_hpd_notify(struct drm_connector *connector,
 	/* Notify all bridges in the pipeline of hotplug events. */
 	drm_for_each_bridge_in_chain_scoped(bridge_connector->encoder, bridge) {
 		if (bridge->funcs->hpd_notify)
-			bridge->funcs->hpd_notify(bridge, connector, status);
+			bridge->funcs->hpd_notify(bridge, connector, status, extra_status);
 	}
 }
 
diff --git a/drivers/gpu/drm/meson/meson_encoder_hdmi.c b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
index 55c0601df3c6..4aecf0ffcf75 100644
--- a/drivers/gpu/drm/meson/meson_encoder_hdmi.c
+++ b/drivers/gpu/drm/meson/meson_encoder_hdmi.c
@@ -323,7 +323,8 @@ static int meson_encoder_hdmi_atomic_check(struct drm_bridge *bridge,
 
 static void meson_encoder_hdmi_hpd_notify(struct drm_bridge *bridge,
 					  struct drm_connector *connector,
-					  enum drm_connector_status status)
+					  enum drm_connector_status status,
+					  enum drm_connector_status_extra extra_status)
 {
 	struct meson_encoder_hdmi *encoder_hdmi = bridge_to_meson_encoder_hdmi(bridge);
 
diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
index dc6f33809ca5..c0f6a8ff9b99 100644
--- a/drivers/gpu/drm/msm/dp/dp_display.c
+++ b/drivers/gpu/drm/msm/dp/dp_display.c
@@ -1514,7 +1514,8 @@ void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge)
 
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			      struct drm_connector *connector,
-			      enum drm_connector_status status)
+			      enum drm_connector_status status,
+			      enum drm_connector_status_extra extra_status)
 {
 	struct msm_dp_bridge *msm_dp_bridge = to_dp_bridge(bridge);
 	struct msm_dp *msm_dp_display = msm_dp_bridge->msm_dp_display;
diff --git a/drivers/gpu/drm/msm/dp/dp_drm.h b/drivers/gpu/drm/msm/dp/dp_drm.h
index 041aa026ae2e..4d98e04bb511 100644
--- a/drivers/gpu/drm/msm/dp/dp_drm.h
+++ b/drivers/gpu/drm/msm/dp/dp_drm.h
@@ -43,6 +43,7 @@ void msm_dp_bridge_hpd_enable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_disable(struct drm_bridge *bridge);
 void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
 			      struct drm_connector *connector,
-			      enum drm_connector_status status);
+			      enum drm_connector_status status,
+			      enum drm_connector_status_extra extra_status);
 
 #endif /* _DP_DRM_H_ */
diff --git a/drivers/gpu/drm/omapdrm/dss/hdmi4.c b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
index e306247ed8a0..d02d432abde4 100644
--- a/drivers/gpu/drm/omapdrm/dss/hdmi4.c
+++ b/drivers/gpu/drm/omapdrm/dss/hdmi4.c
@@ -429,7 +429,8 @@ static void hdmi4_bridge_disable(struct drm_bridge *bridge,
 
 static void hdmi4_bridge_hpd_notify(struct drm_bridge *bridge,
 				    struct drm_connector *connector,
-				    enum drm_connector_status status)
+				    enum drm_connector_status status,
+				    enum drm_connector_status_extra extra_status)
 {
 	struct omap_hdmi *hdmi = drm_bridge_to_hdmi(bridge);
 
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 6a5edfda2ddd..9c4c88024cc5 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -615,7 +615,8 @@ struct drm_bridge_funcs {
 	 */
 	void (*hpd_notify)(struct drm_bridge *bridge,
 			   struct drm_connector *connector,
-			   enum drm_connector_status status);
+			   enum drm_connector_status status,
+			   enum drm_connector_status_extra extra_status);
 
 	/**
 	 * @hpd_enable:

-- 
2.47.3

