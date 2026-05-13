Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 917A7CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 18:20:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C731910EFE2;
	Wed, 13 May 2026 18:20:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="EBSP8oyB";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Pv0dubx4";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A060A10EFDB
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:20:01 +0000 (UTC)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DG1iL53008285
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:20:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UyG6EhuE23RI8zVNC8Jla9EWC4Gg5g3Tbxtaid9LPMQ=; b=EBSP8oyBKNFEHPKh
 XrpTe65942I7vGSbU9Q1LgbMZq+RHmOeW5b57m5jUHei4O/aGEwZ/1QeuwF1L9V5
 Z4Cn4YSExlpbY6HjSvxm5ednwOgizJuK1EPNZckJVjTROorAchmfyQZ6f8t4tASg
 bU01lpL9mGdCtdZEICz3yxWUWsFRWcEb/aV0jyk8etd7op/pr+F+YT852u71RQjz
 nx4VPeVi61vpLkGAo8Zed/w5iTNEpmIKhqbkYLsNRQkFx2A+2T/As0hB95/MWs3t
 kKdcP+RMdGNJRL3BZVd5JehIQyHvDV83yOyazkvuMYuxDD13Xx3+4O3MMcT7EfH4
 z8ARLw==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4py0hyw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 18:20:00 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-6333021c63fso4991257137.2
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 11:20:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778696400; x=1779301200;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=UyG6EhuE23RI8zVNC8Jla9EWC4Gg5g3Tbxtaid9LPMQ=;
 b=Pv0dubx4qLQhS1fyt5ZRtGYBbu3vO2/icidGhnGUYkfz4wPiatDE2IEZxBwMTQRJjU
 TDLzFV5I6FDX2R4duOFiQcFyeflbbOkG3Nr3mCGoHVquwzyBB5RaDxQXix8yNQIrEs2c
 xqz36yrx+dYODk6toQx3290fbIzrKFXwKVQefyhuMCSpmKaiK1+JL1bAojhCDs757VqC
 6SbJwx2qZIWNXzvS6TsYkYajzLg9vlHuj/0dkfvofLwJhrhXHmFpF1gn7HmX8lMdHBxu
 bJu5CWF1HU5DJH7KAHh+gDYb+swkT/4YejpxlJ8451ayhYPGN64sx1Vu277lKDabf8ig
 SA+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778696400; x=1779301200;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=UyG6EhuE23RI8zVNC8Jla9EWC4Gg5g3Tbxtaid9LPMQ=;
 b=WNttWDeuDkdZPsBpuObf6DyKUQgwOsvGsAN3bhAuUBmlcSHSMD8lXdEMEg87xKS/HP
 mJLpnvobY8GpISMfH5776fT+XMrYY2aKEacJ5A4r9U1i5ly1yafr0nooZ7XkjcQEFo1G
 O7Yu9JY0CAZLVweRiXQxrJn54nU248IT829Aqh5pV0d1bqM89N4FodlwNlt81B2j0zAh
 Nwet1v/yHrTQ6v0hHbABpW/VF7SfhtyclDj8IckjQfhlPhsimYG/90TXRkGV2sFzty1v
 N8Dy1P5CO30nhwzK2SWGw6MoUUFVTEF7mYqt+fVQTyOSoA+0hayG0011hr66z1UFF5Sz
 Xq6A==
X-Gm-Message-State: AOJu0Yy82hGvPA7dsBtoyWZPoFRauW+QNMMVcqF7QCCOmQKc0Vfw7xZy
 skidQK0GS71ajulSJft5+016XcB7dFQqCN863tGbUNAxeux7DmeeJFgMhoNZ72xnbO1MyZ6XwHX
 lW2zoGAOE5t2zSGu9VKt7xerrm08eURByb8omB3h8bgt1fqJB0KvODJXHMywoYDcY6Zmok0s=
X-Gm-Gg: Acq92OEDaDm6ZLky2QCXge2Wt6S3NvjzMETlJh5hHTOckbq83Pdb1OkxpGJfhosDttt
 8OVN3vKazQhiK9x7l6dTFLL+6kGnq2xmtifG4K9PSQ0l5qDpwhJ8oemJDTB3GUtmoPJr9CpYIX/
 T/vC3mg/cq3OIV98SkwB7oIHxvon86XirUI2bO/Hm2RyyDlxuvN82i39+WAq+9/Ws8k9RH3bLmV
 KLGFUX2GNCAnoRv39b0R1Y7FoxQs3u36n1n1UfuhLqaQs+ui+eRbbZncjlWKa1IZkfZw0YtVGy/
 T1Rovbj37h/6lZlRKwWwUORPUzh20U5xDmWnVYMAe2/rs6EHck9FblHz8ImBy5mOGXL402caXuc
 LEKo5nSBuQw0REQWqu0/COWVUx+Fa6fknZpCirQbPp5yfRLKmmO72uOhYuVtRH8a75XYJ3N58ad
 nSn+6cKYQc0gUO6dEf43D26SRV+YPWTfRdWqw=
X-Received: by 2002:a05:6102:84c6:20b0:638:944a:49a3 with SMTP id
 ada2fe7eead31-638944a4b17mr827165137.11.1778696399997; 
 Wed, 13 May 2026 11:19:59 -0700 (PDT)
X-Received: by 2002:a05:6102:84c6:20b0:638:944a:49a3 with SMTP id
 ada2fe7eead31-638944a4b17mr827140137.11.1778696399485; 
 Wed, 13 May 2026 11:19:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8c6f78bd7sm2685271e87.74.2026.05.13.11.19.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 11:19:58 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Wed, 13 May 2026 21:19:52 +0300
Subject: [PATCH v2 2/2] drm/bridge: display-connector: trigger initial HPD
 event for DP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-dp-connector-hpd-v2-2-42f757bfcbf9@oss.qualcomm.com>
References: <20260513-dp-connector-hpd-v2-0-42f757bfcbf9@oss.qualcomm.com>
In-Reply-To: <20260513-dp-connector-hpd-v2-0-42f757bfcbf9@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Sam Ravnborg <sam@ravnborg.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3384;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=toLROjSKKdBqupS5QXzQCe21kJo2RUgyLUKU8FAsdmA=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqBMDJRO5MReIwowEHexUURSvykIpP2hmAxIKG6
 loKVXrQgY6JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCagTAyQAKCRCLPIo+Aiko
 1c6LB/9mxfY+EYzbFLDR03XIBwrzQYPO+xuzo6z+9qtE9+BWipovXVcL+LvzZDqYBNVWf5UTHBb
 s45YPuy0txonhL9FT6biQOg8Amm4PRQV6fMNUT77mDHQutgkBTxgYHduqxpMZFYRRGD108cpiIG
 QvU44qQyqXA2yGiVF+K2l8iyvvwZVmHPtVV6H9huEMixN7pBHWUyL/KNIDJ/Xq+lG45CQ+Xb+I7
 20evr39QbCudGBYLGfEwTMPZHrq/7F25VIx3Wn+6VrGStLUfOgu59VW7UrA9czimpd1BEi+C7Ih
 +na5M6v3p+LLa9xaz+paUM9ucQVuCZ0CHS5vYg3SJLVhYkrO
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE4MiBTYWx0ZWRfX/5bKtYQpGHM8
 jaIcixntGhrLhWsxlUBddi8dKheNAIm50pfLsguHGhCwqTLnH/OgrYdUwFFCs6Uyo3TZdddDVO6
 yXY/pcs14y3qRAv6bROGYKz6/bRMcd910nxRIWOZ85n914jTV0zUA9ZFkjR7qctizJ5HoG7z4fe
 IwJfmjgleWfCzY6DVrx952oTx15eefC8Dt8dkTZxmpZ98s3IV3gqENspDZplVIN2PfIT+U3uiq5
 8Xi+6vr2rWt8ZoR2dY43H76qo4whvyOqLq/g5pc2AgY38hagHcOvsXsJhPSgfiGF9VMhdbOwqEi
 AKTW9CKGeh39eFQBocYOp2pgFZmQir9kIJ0So6Mc3CQfe4zNFKNCtEgQPrfRWk3p2CRRLBz/hFO
 l5nDE9wRjA7rgcqBPXywLhdFfLvb+g1FPXxFW5Zg3KdgOjPUBs3eQ7GygGdLbkoxTYtv/KZQkyn
 /KGVUsY8I5fbawJAXMQ==
X-Authority-Analysis: v=2.4 cv=XqXK/1F9 c=1 sm=1 tr=0 ts=6a04c0d0 cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=BowoK5OvW5_YQLCZRRwA:9 a=QEXdDO2ut3YA:10 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-ORIG-GUID: K-zahd3jjrujdqaJQSsN0SnqrLkSGvOo
X-Proofpoint-GUID: K-zahd3jjrujdqaJQSsN0SnqrLkSGvOo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130182
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

If the DisplayPort drivers use display-connector for the HPD detection,
the internal HPD state machine might be not active and thus the hardware
might be not able to handle cable detection correctly. Instead it will
depend on the externall HPD notifications to set the cable state,
bypassing the internal HPD state machine (for example this is the case
for the msm DP driver).

However if the cable has been plugged before the HPD IRQ has been
enabled, there will be no HPD event coming. The drivers might fail
detection in such a case. Trigger the HPD notification after enabling
the HPD IRQ, propagating the cable insertion state.

Note, thia issue only affects drivers which set OP_HPD but not OP_DETECT
(like dp-connector). Here DP differs from HDMI. For HDMI there is no
additional state or extra "bridge with no sinks plugged" cases. The HPD
pin state is equalc to the display plugged state. Nor do we have a an
AUX bus with timeouts, etc.

Fixes: 2e2bf3a5584d ("drm/bridge: display-connector: add DP support")
Reported-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/display-connector.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/bridge/display-connector.c b/drivers/gpu/drm/bridge/display-connector.c
index 6bb1134f75c3..f7a5bfd9c075 100644
--- a/drivers/gpu/drm/bridge/display-connector.c
+++ b/drivers/gpu/drm/bridge/display-connector.c
@@ -12,6 +12,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -25,6 +26,8 @@ struct display_connector {
 
 	struct regulator	*supply;
 	struct gpio_desc	*ddc_en;
+
+	struct work_struct	hpd_work;
 };
 
 static inline struct display_connector *
@@ -92,15 +95,29 @@ static void display_connector_hpd_enable(struct drm_bridge *bridge)
 	struct display_connector *conn = to_display_connector(bridge);
 
 	enable_irq(conn->hpd_irq);
+
+	if (conn->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
+		schedule_work(&conn->hpd_work);
 }
 
 static void display_connector_hpd_disable(struct drm_bridge *bridge)
 {
 	struct display_connector *conn = to_display_connector(bridge);
 
+	if (conn->bridge.type == DRM_MODE_CONNECTOR_DisplayPort)
+		cancel_work_sync(&conn->hpd_work);
+
 	disable_irq(conn->hpd_irq);
 }
 
+static void display_connector_hpd_work(struct work_struct *work)
+{
+	struct display_connector *conn = container_of(work, struct display_connector, hpd_work);
+	struct drm_bridge *bridge = &conn->bridge;
+
+	drm_bridge_hpd_notify(bridge, display_connector_detect(bridge));
+}
+
 static const struct drm_edid *display_connector_edid_read(struct drm_bridge *bridge,
 							  struct drm_connector *connector)
 {
@@ -395,6 +412,8 @@ static int display_connector_probe(struct platform_device *pdev)
 		conn->bridge.ops |= DRM_BRIDGE_OP_DETECT;
 	if (conn->hpd_irq >= 0)
 		conn->bridge.ops |= DRM_BRIDGE_OP_HPD;
+	if (conn->hpd_irq >= 0 && type == DRM_MODE_CONNECTOR_DisplayPort)
+		INIT_WORK(&conn->hpd_work, display_connector_hpd_work);
 
 	dev_dbg(&pdev->dev,
 		"Found %s display connector '%s' %s DDC bus and %s HPD GPIO (ops 0x%x)\n",

-- 
2.47.3

