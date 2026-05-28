Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E407CCD5BD1
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:11:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 541A510ECE3;
	Thu, 28 May 2026 07:11:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="R3gniVIY";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="FfDo+Hyt";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81C9F10ECE3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:11:01 +0000 (UTC)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64S79oVg4188409
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:11:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 lteX2KHrPi0Rqr6OUVWRnH5AyAUAaRSxr8uhMk11Hlg=; b=R3gniVIY8gKB2/xl
 kaThstLE+hIldtvqqoof69I2jojduDc3KQLNDd1pi2zMJXNAzSynV6DUYcH7ZuTx
 fjMHvRRNMUFr1QL4t+sfLdomiIyhcXSUm8wkIWZVDQRl7PzvrR6qP+Gv9wsiTYgE
 d7kVmcZhPWYbmf83GI1Sdq72Fzmi5veaZSgugRGeMo3tggarnVf59tYpc1No1nrK
 JOFgtAgVCqOyQvcjbOEjddqhipF3cwMRItTZPpWTQslHl57jGJKpxSl7jboZA+VS
 Jt2xTVGePA+I0s16W8EmTJYryR1Ebgd1vV+o8obmfLnL+XMpiwqdDkjYICXLjZ/0
 ja9XVA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ee7y2spyn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:11:00 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5165d10e036so221122681cf.3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 00:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779952260; x=1780557060;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lteX2KHrPi0Rqr6OUVWRnH5AyAUAaRSxr8uhMk11Hlg=;
 b=FfDo+Hyt6+TjgQH/vb14jSrze4pbvXp9HUeoOUGZ2xG14qJdeS5vP7G0xU08JYLLmu
 Nn4y+wWRgO1UguC884NjtBoOE+lT/LFGz1CTa45Z+vfZoK2Zy4A3H6iSpDE2DvYiX8jE
 jb/gT9Igs62ET/JmfRnz34SvJDpfNFgBRFKRj/2pw1qCMkfhWqhp2IznbLBcrtiB73P+
 P3Nwo+q2f2q5jiM4oaoRZSnhIPzt3Fl7OHK+IFs13nL2swJvL0a505n6QBxbYjch2qlQ
 eyDMxp19eb95iJ0KGUCaqJ9Kfb5x3f0ccqHtsKa/6kUe7pVsKd5W7PW0S69BEAlM5p+h
 YmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779952260; x=1780557060;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=lteX2KHrPi0Rqr6OUVWRnH5AyAUAaRSxr8uhMk11Hlg=;
 b=ByaeANqOOnoVVPhKBc0kWp+DuR/jzRXh+17ynAKIngx4HLEAIEmWb3sBK8YZWB8oKj
 M+Soji0ek24FlLvDYp4QlCyTel/rsCqTnsEXXKjsHPh/19qkU2N64kcwHxvy5yg3eZyL
 Dx5sKX42/qgDfiZ5jAmJCDppRPMTQsSp7NH5HNEHQ9eNb2Q2+PFmCgmfHGdw2zfICs6J
 /bvG/qb8W13EO9n9aJiE0/dVWDrbVbKBtcGQNi5VIKE3o0hCHKrk/1VpbQDCui3rJ723
 RPbFO1qXomRm3E7Rv8ZQiHfT01syld9lmcX4HGGslOEVqY08DX9eb6Qzh5cfhSx2zQqT
 p+eg==
X-Gm-Message-State: AOJu0YyuLhUE0fI5pdRsnSmq0JQ4kA9/0OAYwd26xdFmjRdC9DGIdXjM
 0FOR1oremCP/YCIX5WxT2cYUh/l5fHm9ass0nZsTUnaO1sLPmWrPeLgTSflwEBvsCKxmx0H2RUR
 MeGq+9DuYbmOIe21Uhc/BwQOBurnxUagPmhfETAlSjpY9XeUPyJzWhk/6bVDSbahYeiyi5WI=
X-Gm-Gg: Acq92OE4SJD+8dXbN9qh559N6rMO9X+kdN3Jcw4Dn5CLsJG9SRfs0VsoHNM93JnYG/v
 CgLTv/JAJuNfXGgucHWICxcEPYrqD8bJyV1+n8OrJQB1QfmaW6Bo2JdonhhQ/CWHhZNur4f50hz
 qT50bWjl3TyAgtDYrjG/aidOhSB25ghVxM04+Ed0jh6+k8pZovj1QySNxaeyfPRBBSJ4NMBt9Qk
 a5bammnuy2RfaFk5gs98y4UNU4+wKT7w22MDsAUD207Sax0yn2j2mH2+l4nDQ+vSmASnT6+kObF
 sJBtu0qmzDI5j0R2CMG3phEHhQbIuHkSNJbO+oUztuWC9gfq2O5X6OvEAPR4wT1yw44blmNqBX2
 /RNiKBKs+vH2zh/qTLJUXQvdPrr/OLGVkdvsQ1KExGaIuWyooV3OPG8lS23F2qNdKA3PlVIFtVD
 PpO+fBNv5k9pLoFNtR2sOEwnwO5oX/c29b2UJyWHtam2+4Iw==
X-Received: by 2002:a05:622a:1a81:b0:516:3183:c1fc with SMTP id
 d75a77b69052e-516d43b30camr367362741cf.50.1779952259912; 
 Thu, 28 May 2026 00:10:59 -0700 (PDT)
X-Received: by 2002:a05:622a:1a81:b0:516:3183:c1fc with SMTP id
 d75a77b69052e-516d43b30camr367362441cf.50.1779952259241; 
 Thu, 28 May 2026 00:10:59 -0700 (PDT)
Received: from umbar.lan
 (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi.
 [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-395dcc0a54fsm37416161fa.20.2026.05.28.00.10.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 00:10:57 -0700 (PDT)
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Date: Thu, 28 May 2026 10:10:50 +0300
Subject: [PATCH v3 3/3] drm/bridge: display-connector: trigger initial HPD
 event for DP
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260528-dp-connector-hpd-v3-3-d656eb1079b7@oss.qualcomm.com>
References: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
In-Reply-To: <20260528-dp-connector-hpd-v3-0-d656eb1079b7@oss.qualcomm.com>
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
 Yongxing Mou <yongxing.mou@oss.qualcomm.com>,
 Jonas Karlman <jonas@kwiboo.se>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3380;
 i=dmitry.baryshkov@oss.qualcomm.com; h=from:subject:message-id;
 bh=gXYnVv+et9mKSsRcfzytd7/BMq8iX3aPDHuiutk/ozU=;
 b=owEBbQGS/pANAwAKAYs8ij4CKSjVAcsmYgBqF+p5eciFkm/4ibcN/flXWH7mQ7FqQW0gmpGCE
 nhQAHBs172JATMEAAEKAB0WIQRMcISVXLJjVvC4lX+LPIo+Aiko1QUCahfqeQAKCRCLPIo+Aiko
 1dDSB/9slePnf8zuZRcb+x7QodsYuVQoLGfur6bPOuuwfYYOt7kcKa3FHM5vx41MXzjhWQmIYtv
 IXwQvWfxDqnUCZpCulPxGk7PHFYnWW7r0L/EXDic32bPZ00I5VYt8Zdg7nGmKTn0x2DQKclXCMm
 E/N55aA1v6HwQStpGIFig4PySb9s8QNSiA2TEifJwuf7pxcZE18QOAjge1CeWXimV/psTU84V2Z
 1JwU0VMxmEKzjCXc5X5HOaQhAEA+pNsn9EC00nhsJN1lPssWHq1vTrF52mfOCg6U0uuf87D1w/s
 sp4BcHpqHore9t3QDoJEbamPsjBf6RGIN6i3KJILwbW1Vryy
X-Developer-Key: i=dmitry.baryshkov@oss.qualcomm.com; a=openpgp;
 fpr=8F88381DD5C873E4AE487DA5199BF1243632046A
X-Authority-Analysis: v=2.4 cv=VeXH+lp9 c=1 sm=1 tr=0 ts=6a17ea84 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=vFO7MoRB4rWv4-WZv6sA:9 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI4MDA2OSBTYWx0ZWRfX6RmwZwMsJ5SC
 By7C0zbvRNab6RbUGcDATUoU6oPB/iPh9jq7ne30BSNI8eZUpA0huSN8dgISh4ax7HGU6jaK1HL
 MhP4dHJZ45IC+5sqKnLlrhT3vZvm4f2D3WTRiDZuHAQ55Kl5NZwlyrYHf1+qe0oMWj01Qd3FjVW
 I0zkJ9NqXfcHz1+uGhOLZhgxjxU0yuHAjM3drFrzWP7XXMopmI1pPBjPrO4EKG3AQLh0Kv6y31X
 v9p2orIda13nfnjvTH/rlM+t1loeRANt62GH/8CVpeesT0ngZmlgipBdeEvGrxIu0pVqexmE6eV
 uaYLDnIefBdshNztFZxmOr8bbPdSJ/lsqD4sdAjkVeiZJSNDKVbYYDUSgMvuzWwVVLrFhyzfj5T
 EWYYmiVLXJcPsoQQ85zTvBiqM60POJi2s3f01lf8xqgmUmfeD3Hl2JU3Haq8FYBVu0h29vmiph1
 xheQOHuQ7bK5SAnFUNQ==
X-Proofpoint-GUID: SaHL-vYtFKo9We6yH81zJEKP1TZA8shv
X-Proofpoint-ORIG-GUID: SaHL-vYtFKo9We6yH81zJEKP1TZA8shv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-28_02,2026-05-26_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605280069
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
depend on the external HPD notifications to set the cable state,
bypassing the internal HPD state machine (for example this is the case
for the msm DP driver).

However if the cable has been plugged before the HPD IRQ has been
enabled, there will be no HPD event coming. The drivers might fail
detection in such a case. Trigger the HPD notification after enabling
the HPD IRQ, propagating the cable insertion state.

Note, this issue only affects drivers which set OP_HPD but not OP_DETECT
(like dp-connector). Here DP differs from HDMI. For HDMI there is no
additional state or extra "bridge with no sinks plugged" cases. The HPD
pin state is equal to the display plugged state. Nor do we have an AUX
bus with timeouts, etc.

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

