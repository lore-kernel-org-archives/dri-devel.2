Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D0E107BCD1
	for <dri-devel@archiver.kernel.org>; Sat, 14 Mar 2026 00:43:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6C3110EB94;
	Sat, 14 Mar 2026 00:43:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="D+bowuGW";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="G/b6MA3Z";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8846A10EB94
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:26 +0000 (UTC)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DNH35I112260
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 L8PBUH4F4MWdX4m5iEAJ6fD5ICwhHw6BnobYrVmgYwc=; b=D+bowuGW/IGPXRL4
 88s/DTwceHDxNy5AL7a8iOUCWfjWZweaYGLCafTIrS7+pnApqN+bGPURkjPhFF6D
 oD8gGBhqFwFuAr+B78ePX8OzZVzqiQ9UqVVRZAXuxhYavLJnOZDdqcojEPyuBpLi
 8svl0bal27qJr3nVP6jN2MjhcdMzXXfdceGvMy0FkD0RyQBbDMpdINxnW7QEvVUX
 3Z0edmX6ziJBuM9mZyLRPYHK8eLKDB2R6DRybUDRUAL5sMn99efoWWxPkYn/bHVa
 SAtM3omsqpWydLmXmbcPLG+70n7jB2Ghii0j2JVMiKipZD4wbjAiG8VDjtxwiFwK
 7rLd3g==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cvh5mafj8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 00:43:25 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8cd81c571a5so1594328985a.0
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Mar 2026 17:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773449005; x=1774053805;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=L8PBUH4F4MWdX4m5iEAJ6fD5ICwhHw6BnobYrVmgYwc=;
 b=G/b6MA3Zzcq9Ddq4ICOgie0Z4pZBR359/NzVvoHlB/L413OsmNuah4IiuGrBwaqb6Z
 Bc6T5t8WjOsxAaOogJ9oY5iPY6nIR+tnEEJIB8spW/6FQPduarAWFAp8EQX4qiwDE9nE
 Ow4jqbE/Ndk32KU0bHUyZwKcjjTRYu6BZWyG1FZaH9LQNI0JONw3O9Ro3NIheuj6tbyz
 aNuRtZILpWJgndK/SRCC5w/0yL5/e5g7FQ2ZOSiVrQDq3hGzSVR4CysBoyznbGZhwDiU
 lV9dE+H9SCycIW8LSFEHgqjma6mHxYrPxXVQeheHefFB8rm8oaX7rojRhwqZL6sKs/jG
 B5GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773449005; x=1774053805;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L8PBUH4F4MWdX4m5iEAJ6fD5ICwhHw6BnobYrVmgYwc=;
 b=jFvGN3xhhw2Bbl913zOjpDv/PrYMu8NQmryBD5ZwDyY+UNHYTtxz+EWwyOeomG7onT
 8yWfWnLm7vTn3waExCfjT80dWdIWaT5KkUCpf2dIvluh6s+43H9VhWSSbSgeSgJ+dEJw
 mqWPICUAUqM7a/2EFSMPOz7zO8/ZmrDjUyuLbJW/fn/qG4j9+Ar6azTWLRJjTZsgoZcN
 CskxvAUITKr+VhnzLJ9Fz4iVoxuOuNoUkh30feg8Y0LIRZk+favSJ3HboxnRUrJDlbe4
 rm3uYBzPkb2t6SFNN7HhHNCNgTx+OS1ORJAdbKCGEq6RNaTCZn/OmRkvYJ35E4eeyyPG
 DuRA==
X-Gm-Message-State: AOJu0Yy/RPRs93t86kzsLihc5Bg0yI1+OvhzcUEZGqA9YvT252QKtx3h
 pM88L3sLyFeHiLbiJmPn4mEQudDpwHuY5MCxUZyiG/Nivu2U24nvuQhLj0Tg0Zx9P9ehB5V3vKH
 2t2jcoTAMjvwbOvDh62r+QnV01+gZ+nVe/aEg5MORYAFFsck930Q2Bz21iAFfI+XW/SIRuBg=
X-Gm-Gg: ATEYQzyWJKp7ESaCkuyAteW4rUqiBzUtB/JQO6WmXvUsC/bZTKWtOKNTEiTtEh40We5
 yKSPu6xukmHHCfp7DOwt8+MueGpy54uw0ddTZgJQ3YBCHg48OTkWpmWqsK+K5kzEJziIXxy0/H9
 at9pTvlUpckIFyzrVhwU/6NHFvPYstVfxve6gdGVqa4styHVG69wXmdiI7jEFTRL7/N2bAlU08t
 HhB1BXiS/fgTUVOWINcVc6UQrcQyQIM9hQnEZVMY/jicb3jQQRMfQb47QYiVLfV9qCnFB1q45/F
 h+zU3fcZDCzO88PQXYsnny4bxFh0Cjrzd2bzhG+voB3DAEyniqmD1oK272yumUkyBwUnZ3BNbpF
 RNHl1In7Z4lzzCIJy19BvLB2JBXofTSYyoZrUpPqcWPPWMH8jKJoSurGDs1iif1l/9KupuRXZBV
 L2K0DoNFRqIIcyQCi+HFUylA7dXNWX8Zg3nng=
X-Received: by 2002:a05:620a:470c:b0:8cd:b2cd:10a2 with SMTP id
 af79cd13be357-8cdb5b4d4ebmr768666885a.49.1773449004777; 
 Fri, 13 Mar 2026 17:43:24 -0700 (PDT)
X-Received: by 2002:a05:620a:470c:b0:8cd:b2cd:10a2 with SMTP id
 af79cd13be357-8cdb5b4d4ebmr768664085a.49.1773449004354; 
 Fri, 13 Mar 2026 17:43:24 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a156366a74sm1843556e87.75.2026.03.13.17.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 17:43:22 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Sat, 14 Mar 2026 02:43:12 +0200
Subject: [PATCH 2/2] drm/bridge: display-connector: trigger initial HPD
 event for DP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260314-dp-connector-hpd-v1-2-786044cedc17@oss.qualcomm.com>
References: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
In-Reply-To: <20260314-dp-connector-hpd-v1-0-786044cedc17@oss.qualcomm.com>
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
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3065;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=PgxnkhRtNQtqZbuzP8IdK9LDhN4sUNZfDZnz3kK/igY=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBptK8gQG1FO9BH7d7RN7Ca18qGfhpdF3PBczE0c
 8Wt+SnLSKOJATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCabSvIAAKCRCLPIo+Aiko
 1ZK6B/9hp3oJVQUo+87CjN9yqGOK+CeqbAOmNSH/x/LVAR4oTzzMP6xO40JX0zDuCjZgDEhjbMe
 4ebflYz796crTzcooGO5cfdnBjLXGAN0EoY9hGvYSI78ociPMDbLoc2hCj9H0GBCea/kLPda1xo
 uHXxyesv4/OUmJZ46uxkeKx0UlIbKbzssjWHaLXAMTEEKecHV2p6/pOqSqV8CKjUx6VcRXHZZen
 WOUSRrCG13aYFqLCE1ra3SEdm6KHCWwD7ECeXXGGKwIs9flzfsOTICQ5Zckrr3x4yrW4s5q9hJm
 DUeR/N0Ue94GlONNx3ImhM+bx3WIrasfHkY8IsdTFKXo2KMJ
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Proofpoint-ORIG-GUID: tBKwTNI-YLP25OGw7e8CPBoNlq0z9n63
X-Proofpoint-GUID: tBKwTNI-YLP25OGw7e8CPBoNlq0z9n63
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAwMyBTYWx0ZWRfXwFrsltCMaSmt
 VQu40wykctemt7LRepVmKYVx3ERIZfmTdwiuAhBzXK4bSPUbzGBytCEyKLynTMYYfbgeCgBA8d7
 sgMwgO03d/zHDMFvx5UKNCqF3l5LWCN5kGminiK5gKiax/oYHriEXlk/4O7hfrLkpgSj46fWerq
 dy1598IfdExzGmy0EL+43GRd66sC/azTjVRUJOSp/HgcSuwVZ7tGrbeABRfSMsSBcZcCmvte2mS
 Y1RVwIAI8Tw7+A39HQ1ege0pIsMnXYiuJ6BG3tDafeoqOvXmSBNfdei5oCA0a29EbTr0dNJ/wCN
 Qg2VqoVb6vPVwjVjywK+Y92dEsWN0H3J+ZuYBGRcMssppHGpqa2Y7crs9HwxLnpn+PQyTyu0Hiu
 V6D88MtLZCJWZLPvPJsDmSXqMFJh8lPalZ3FD20sZginF4PAaSHM2Nc1qijyJQ6NxfpM9rly6Vl
 ZxcWOHIgPPbmg4TKOFQ==
X-Authority-Analysis: v=2.4 cv=S6TUAYsP c=1 sm=1 tr=0 ts=69b4af2d cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=yvB0wynyV-D1A3ldwWQA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_05,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603140003
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

