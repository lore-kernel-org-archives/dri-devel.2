Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52739C55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BC9610E0AE;
	Mon,  3 Aug 2026 08:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="LuLgtJ3M";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J367rpZJ";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4B4D10E00F
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 08:43:22 +0000 (UTC)
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6736D49p3654582
 for <dri-devel@lists.freedesktop.org>; Mon, 3 Aug 2026 08:43:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=qcppdkim1; bh=acyMrvZmnRxXhaZW1QJHZD
 gWwsjcmAOZiK0i712DwhI=; b=LuLgtJ3MH7FpwEdCzbaHrsBr23rvvqFsHkGx6I
 RrOGqnlAVQ2yKn1/2mGXBf8w7Sd4MWDaj8JWYKeGvpdeG0EEi4TKv1fphBzPkrky
 PfZsslM2V/S3WqmuEFUmpaNAIUBKGG0XE/vxH+oF48WSq+ApTnOxlHueao2ir1RJ
 XXNlZeuTc7hJpJduVlTQ3tOGMooQSlvjH3ycmClqMHRpttPoqTzNhIvldgURqHcI
 B3ripayZ/oU7g9FW5XFes8JQziBaigQjw4HJ/RSur9mAlmj6C77u8dJ4MCca5nt9
 RybdA3j1vDns2H7xjdujMJtJl3BZonZjHqNl2698FLHLks/g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ftnhb0kmx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 08:43:21 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c083f1818so30655111cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 03 Aug 2026 01:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785746601; x=1786351401;
 darn=lists.freedesktop.org; 
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=acyMrvZmnRxXhaZW1QJHZDgWwsjcmAOZiK0i712DwhI=;
 b=J367rpZJIVnTkMFdC3oQJvkeV08WTgjWt9LbIMKxdA5tKhEcSPMmQmH8BsQ85I29eQ
 RwLuSvd55WGpY5xNQRLHACmsNKUou08lvGJyqYwqxELmX8xV6orQmR6OwXqoGbY64UB0
 ajvCvTyAteIGnVtXnEea4Hk1TV7n87dwklR9D6RCAke9f2gKpa/Qa9eGTmuuBbkJnBdp
 DM+BjK3fItThXrmLtUjIrAm6Xy21P7TXbbCGR4vdgCAWpqv0MmMf8xAIeBEJChUfe2+e
 Uey49PmhLKIk3jF/iZIT+geDWrUwSNcRliUZXqyAVRyU1ATUubNagoIgKvdwif5OK+bm
 IpsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785746601; x=1786351401;
 h=cc:to:message-id:content-transfer-encoding:content-type
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=acyMrvZmnRxXhaZW1QJHZDgWwsjcmAOZiK0i712DwhI=;
 b=gUHVBOM3IZ4RiFabCaEcWhZ/ky6ZNM3oVEbL7E46gJt0n4ZVOTHw38IW0hFjAHqEyK
 j+b9/mG7ceUaa31+3GO1hv4f5wu7HQL9L5KNQzhDd6XBHh9W6T/S6DO8dQ35Y7eKv0Mo
 MopPXjTKQ6s9nh1qTdYJd5mdUj2pD7izn8BfsVBl7QTysb5fBOcAvlMsubED6i5vXfdy
 NWxQGQseGyzbiz88olebkdSrRwoi9nXArG/C8llTERNv3L2Q8ADUac/e9QMFziow7r+H
 fTcRRBqLHuVkx5w26hGxP9Ntwi+KbA1IU6f3wSWXoWaKnN+qgOeh4TOj+VrnzaghBDKd
 e3aQ==
X-Gm-Message-State: AOJu0YzX0RW8YsgE2bEgPkCg3eYDCrB+cSP/IgeuT9JgplJ1DUpxvjrH
 f1rppEqjY5wjdnv70UhHTdkhvQnoHiC4FWdooqTPei60CRir3QOkixxiS+gZosWMs0FTrhjc34Y
 W5e4g3YS0ByfY4Imr8fD6Bj47Il99WX4JOPxP5/7kqOnncRb4PuUiAtvaijyCavmcFKatRZo=
X-Gm-Gg: AR+sD13bXMnCH6Fqhw84drwSIfbr37Hrrnc6iB9Ehs+8kXmpMeRZ4M680lRkrXZ/FA5
 AXmzfyiVSYDcG8f+7HTlkunNYw53HAXXLslzLnF8HWZhvxj890KQMyVQIkRTUIwjtF4IYoop1fk
 yN9IzYj2PpZAbZAKH4qT2qPyUPvIbFVwCkMR/u1bjz3fhbPLn1BorzFQKHTp4oymC5rViHzDVaX
 ZDQudKLfzRxourKdlFGM+3D8GcpOYME+hqbRheGxLDX2L7Th7gQoxBK3hEySXWMiybEA77ywk5U
 pCkJtVJ7inmo0fZqbbJ6Hup9CC+uswdXr1Ymm11Qxp0DKqV8byxAFa0DD4AsXWbLeZZrc0J1kO3
 CAaDeW2yjl29WsS6cHUjNl3Ze8hZJnP6zyl+0m591iHYgjQ3MbokEoPVYKrXJodU=
X-Received: by 2002:a05:622a:1f91:b0:517:7b6c:4465 with SMTP id
 d75a77b69052e-52b56752f3dmr202398611cf.22.1785746600879; 
 Mon, 03 Aug 2026 01:43:20 -0700 (PDT)
X-Received: by 2002:a05:622a:1f91:b0:517:7b6c:4465 with SMTP id
 d75a77b69052e-52b56752f3dmr202398261cf.22.1785746600381; 
 Mon, 03 Aug 2026 01:43:20 -0700 (PDT)
Received: from yongmou2.ap.qualcomm.com (Global_NAT1_IAD_FW.qualcomm.com.
 [129.46.232.65]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908432a0deasm70013806d6.8.2026.08.03.01.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 01:43:20 -0700 (PDT)
From: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Date: Mon, 03 Aug 2026 16:43:08 +0800
Subject: [PATCH] drm/bridge: aux-hpd-bridge: replay last HPD status on
 hpd_enable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-drm-usbdp-preboot-v1-1-2539b362be00@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIAJtUcGoC/yWMyw6DIBAAf8XsuSQgsoK/0nhgYdty8FHQponx3
 0vqcSaZOaBwTlxgaA7I/EklLXMFdWsgvPz8ZJFiZWhli9JKLWKexF4ormLNTMuyieCVI+N0q1S
 A2lX/SN//8z5enPm91/V2SSBfWIRlmtI2NJ0yKNH3xE47q00kRzIi9UpZ2xuL2KHuMMJ4nj9q0
 uHVrwAAAA==
X-Change-ID: 20260803-drm-usbdp-preboot-ca19b593211c
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785746595; l=5065;
 i=yongxing.mou@oss.qualcomm.com; s=20250910; h=from:subject:message-id;
 bh=dsumcoBHZClhzi888ELmTyHy0xGhE51qhd67sQ/Owp8=;
 b=QC8eH7/m8/CjOtyvQoatb6Tja2rL8GTB2znSnKifrPT/klVL4SRPZ28YUSJ707dC7OA/b7EYE
 m4pT66zVJrDC5RVigzoKiIA0bPVBMb8TOO8zb5Tf5q+2ajjlTz5GEOH
X-Developer-Key: i=yongxing.mou@oss.qualcomm.com; a=ed25519;
 pk=rAy5J1eP+V7OXqH5FJ7ngMCtUrnHhut30ZTldOj52UM=
X-Proofpoint-ORIG-GUID: uo0ywkgyfDVrj8Ik_herCbFpseMeB9zn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3NiBTYWx0ZWRfXyhWrDvYrdu10
 bLPZAQd06TqCb3qC36+akla083HlYJPi54PJziRJsm9xu7bQ8uN0U6edTyY3fgDaF7cPeE34QGl
 DjOFn9s+hkVj6LujBsrvn1lUKB/3A7M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3NiBTYWx0ZWRfX1QCnOIWVgK3b
 WfbrphcAmkF+F+jzOO6JQSP16/s6ARIoEFOcJrtRaXFeuIZ9Q0Fb6vN0MPzMDIJ5QaruS9vZdtL
 4HYzUR+C4AQl5P3ow+jCAxWaxPrrmimBauXeD7EwMmUCqBWgnVBXPnAxborzMWABtjMUqzIE25U
 JbI57CjmutalFg95SVt2k38YpQWrfOnhLSz+Ch6YB77h8rHGYEJ7rIITBrCzRhN1zeszTtL50WI
 itoGj++HghVxSF4sf2+MJdlJaU1a3/AzWXXDsEeApc9UxtOgTpSyjbTeBoOTKbq0d1cI7ZTjXqg
 BhmUUluvS+GjV6M+O+eK7ZtoaB0eP5N0fBq5iC6ayQzRZX/6zVjIgeUeOPa5S6+9yG1VxeNxo4k
 NJ9507mKdLeAd2uMhKQb5+jHvFDRz2tq6MbPWmVK8wbjRHDmtEgIikLegtpga+wMtM2FQHutTm5
 mLSrKc29RW54YbRArGg==
X-Proofpoint-GUID: uo0ywkgyfDVrj8Ik_herCbFpseMeB9zn
X-Authority-Analysis: v=2.4 cv=bKEm5v+Z c=1 sm=1 tr=0 ts=6a7054aa cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=C3Dk8TwHQYyIj7nOf9RCJw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=WYcXR15yDoFHwbSvud8A:9 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030076
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

If a downstream consumer (e.g. drm_bridge_connector attached by the
msm/dp driver) registers its HPD callback after an upstream driver
has already reported a HPD event through drm_aux_hpd_bridge_notify(),
the notification is dropped because bridge->hpd_cb is still NULL.
This can affect any user of drm_aux_hpd_bridge_notify() whose
downstream consumer arms HPD only after upstream events have started.

The race has been observed on Qualcomm X1E-based laptops during boot,
when pmic_glink_altmode reports the initial USB-C DP connection state
before the DP driver has finished probing and enabled HPD handling on
the bridge. The consumer then never observes the initial connected
state and the external display remains dark.

Cache the last HPD status reported through drm_aux_hpd_bridge_notify()
and replay it when HPD is enabled by the downstream consumer.

The replay is deferred to a work item so that the replayed HPD
notification is delivered outside drm_bridge_hpd_enable()'s call
context.

This follows the same pattern as display-connector, which also defers
an initial HPD notification from .hpd_enable(), but reuses the cached
status since aux-hpd-bridge cannot re-detect sink presence on its own.

Fixes: e560518a6c2e ("drm/bridge: implement generic DP HPD bridge")
Signed-off-by: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/aux-hpd-bridge.c | 53 ++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/aux-hpd-bridge.c b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
index a2e525aa5788..bb81aabf58d4 100644
--- a/drivers/gpu/drm/bridge/aux-hpd-bridge.c
+++ b/drivers/gpu/drm/bridge/aux-hpd-bridge.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/workqueue.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -18,6 +19,17 @@ static DEFINE_IDA(drm_aux_hpd_bridge_ida);
 struct drm_aux_hpd_bridge_data {
 	struct drm_bridge bridge;
 	struct device *dev;
+
+	/*
+	 * Last HPD status pushed through drm_aux_hpd_bridge_notify().
+	 * Replayed from .hpd_enable so that consumers registering their
+	 * callback after the initial notification are caught up.
+	 *
+	 * Accessed lockless from the notify path (writer) and hpd_work
+	 * (reader) - use WRITE_ONCE()/READ_ONCE().
+	 */
+	enum drm_connector_status last_status;
+	struct work_struct hpd_work;
 };
 
 static void drm_aux_hpd_bridge_release(struct device *dev)
@@ -154,6 +166,8 @@ void drm_aux_hpd_bridge_notify(struct device *dev, enum drm_connector_status sta
 	if (!data)
 		return;
 
+	WRITE_ONCE(data->last_status, status);
+
 	drm_bridge_hpd_notify(&data->bridge, status);
 }
 EXPORT_SYMBOL_GPL(drm_aux_hpd_bridge_notify);
@@ -165,11 +179,45 @@ static int drm_aux_hpd_bridge_attach(struct drm_bridge *bridge,
 	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
 }
 
+static void drm_aux_hpd_bridge_hpd_work(struct work_struct *work)
+{
+	struct drm_aux_hpd_bridge_data *data =
+		container_of(work, struct drm_aux_hpd_bridge_data, hpd_work);
+	enum drm_connector_status status = READ_ONCE(data->last_status);
+
+	if (status == connector_status_unknown)
+		return;
+
+	drm_bridge_hpd_notify(&data->bridge, status);
+}
+
+/*
+ * Deferred to a work item so that the replayed HPD notification is
+ * delivered outside drm_bridge_hpd_enable()'s call context.
+ */
+static void drm_aux_hpd_bridge_hpd_enable(struct drm_bridge *bridge)
+{
+	struct drm_aux_hpd_bridge_data *data =
+		container_of(bridge, struct drm_aux_hpd_bridge_data, bridge);
+
+	schedule_work(&data->hpd_work);
+}
+
+static void drm_aux_hpd_bridge_hpd_disable(struct drm_bridge *bridge)
+{
+	struct drm_aux_hpd_bridge_data *data =
+		container_of(bridge, struct drm_aux_hpd_bridge_data, bridge);
+
+	cancel_work_sync(&data->hpd_work);
+}
+
 static const struct drm_bridge_funcs drm_aux_hpd_bridge_funcs = {
 	.atomic_create_state = drm_atomic_helper_bridge_create_state,
 	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
 	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
-	.attach	= drm_aux_hpd_bridge_attach,
+	.attach	     = drm_aux_hpd_bridge_attach,
+	.hpd_enable  = drm_aux_hpd_bridge_hpd_enable,
+	.hpd_disable = drm_aux_hpd_bridge_hpd_disable,
 };
 
 static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
@@ -192,6 +240,9 @@ static int drm_aux_hpd_bridge_probe(struct auxiliary_device *auxdev,
 	data->bridge.interlace_allowed = true;
 	data->bridge.ycbcr_420_allowed = true;
 
+	data->last_status = connector_status_unknown;
+	INIT_WORK(&data->hpd_work, drm_aux_hpd_bridge_hpd_work);
+
 	auxiliary_set_drvdata(auxdev, data);
 
 	return devm_drm_bridge_add(data->dev, &data->bridge);

---
base-commit: 415606a7be939835db9b0d6b711887586646346d
change-id: 20260803-drm-usbdp-preboot-ca19b593211c

Best regards,
-- 
Yongxing Mou <yongxing.mou@oss.qualcomm.com>

