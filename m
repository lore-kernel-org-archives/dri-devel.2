Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A46CD4F58
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 19:38:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C2C10E7EB;
	Mon, 18 May 2026 19:38:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=kwiboo.se header.i=@kwiboo.se header.b="syCMpMd7";
	dkim-atps=neutral
Received: from smtp.forwardemail.net (smtp.forwardemail.net [121.127.44.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D5CB10E7EB
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kwiboo.se;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: Cc: To: From; q=dns/txt; s=fe-e1b5cab7be;
 t=1779133089; bh=ThbLfdSHfpoHWBkpdG7GEcedzyok/O/FgpfO8mmac0M=;
 b=syCMpMd7V4ZeV3x3PiezY27IHLCLmLWb3TQ6KyeE1qY96YqdtLf2Lye6c+DrdpD8RWn0xjy1m
 l3ScYlTS9nmzZ5lweHs7nhrnpyvNkcJOrcDNmL92W11ofY4PBj0/csaF2lQjHmulyt4Wb+xfnIW
 H4N+DVTCGKxHEEIdr0OdaPGsLbJ/bLQKGarpbK5c/xZs6YLmRJ/ygSfKNvSMT9WqJaVplda3djE
 aBp0I/R8bOqsgiYfkumGGyDnhFVMn1MmKGmhYc2KvmE21mkMsc/llmUrJUgdMQakfSGCWagWaes
 h6PutMeMQD/Ay48RqZ4hLMw+DaARhveihC+tdMLhI5jg==
X-Forward-Email-ID: 6a0b6a9e486b4b38b826f9f0
X-Forward-Email-Sender: rfc822; jonas@kwiboo.se, smtp.forwardemail.net,
 121.127.44.66
X-Forward-Email-Version: 2.8.12
X-Forward-Email-Website: https://forwardemail.net
X-Complaints-To: abuse@forwardemail.net
X-Report-Abuse: abuse@forwardemail.net
X-Report-Abuse-To: abuse@forwardemail.net
From: Jonas Karlman <jonas@kwiboo.se>
To: =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jonas Karlman <jonas@kwiboo.se>
Subject: [PATCH v2 03/11] drm/rockchip: dw_hdmi: Use drmres helpers for
 encoder resources
Date: Mon, 18 May 2026 19:37:37 +0000
Message-ID: <20260518193748.2482823-4-jonas@kwiboo.se>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518193748.2482823-1-jonas@kwiboo.se>
References: <20260518193748.2482823-1-jonas@kwiboo.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Change to use drmres helpers drmm_kzalloc() to allocate driver data
and drmm_encoder_init() to initialize the encoder. With use of drmres
the manual encoder cleanup in failure path and unbind is also removed.

Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
---
v2: Adjust error message related to dw-hdmi bridge
---
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 29 ++++++++-------------
 1 file changed, 11 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
index 0d5d60c315c6..12a7c989c4ee 100644
--- a/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
+++ b/drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c
@@ -14,6 +14,7 @@
 
 #include <drm/bridge/dw_hdmi.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_managed.h>
 #include <drm/drm_of.h>
 #include <drm/drm_probe_helper.h>
 #include <drm/drm_simple_kms_helper.h>
@@ -550,13 +551,14 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 	if (!drv_data)
 		return -ENODEV;
 
-	hdmi = devm_kzalloc(dev, sizeof(*hdmi), GFP_KERNEL);
+	hdmi = drmm_kzalloc(drm, sizeof(*hdmi), GFP_KERNEL);
 	if (!hdmi)
 		return -ENOMEM;
 
-	plat_data = devm_kmemdup(dev, drv_data, sizeof(*drv_data), GFP_KERNEL);
+	plat_data = drmm_kzalloc(drm, sizeof(*drv_data), GFP_KERNEL);
 	if (!plat_data)
 		return -ENOMEM;
+	memcpy(plat_data, drv_data, sizeof(*drv_data));
 
 	hdmi->dev = dev;
 	hdmi->plat_data = plat_data;
@@ -608,28 +610,20 @@ static int dw_hdmi_rockchip_bind(struct device *dev, struct device *master,
 			     FIELD_PREP_WM16(RK3568_HDMI_SCLIN_MSK, 1));
 	}
 
+	ret = drmm_encoder_init(drm, encoder, NULL, DRM_MODE_ENCODER_TMDS, NULL);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init encoder\n");
+
 	drm_encoder_helper_add(encoder, &dw_hdmi_rockchip_encoder_helper_funcs);
-	drm_simple_encoder_init(drm, encoder, DRM_MODE_ENCODER_TMDS);
 
 	platform_set_drvdata(pdev, hdmi);
 
 	hdmi->hdmi = dw_hdmi_bind(pdev, encoder, plat_data);
-
-	/*
-	 * If dw_hdmi_bind() fails we'll never call dw_hdmi_unbind(),
-	 * which would have called the encoder cleanup.  Do it manually.
-	 */
-	if (IS_ERR(hdmi->hdmi)) {
-		ret = PTR_ERR(hdmi->hdmi);
-		goto err_bind;
-	}
+	if (IS_ERR(hdmi->hdmi))
+		return dev_err_probe(dev, PTR_ERR(hdmi->hdmi),
+				     "failed to probe dw-hdmi bridge\n");
 
 	return 0;
-
-err_bind:
-	drm_encoder_cleanup(encoder);
-
-	return ret;
 }
 
 static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
@@ -638,7 +632,6 @@ static void dw_hdmi_rockchip_unbind(struct device *dev, struct device *master,
 	struct rockchip_hdmi *hdmi = dev_get_drvdata(dev);
 
 	dw_hdmi_unbind(hdmi->hdmi);
-	drm_encoder_cleanup(&hdmi->encoder.encoder);
 }
 
 static const struct component_ops dw_hdmi_rockchip_ops = {
-- 
2.54.0

