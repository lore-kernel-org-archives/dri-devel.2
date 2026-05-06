Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F928CD3446
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F6BC10F008;
	Thu,  7 May 2026 10:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=2005.tr header.i=@2005.tr header.b="EMUn+NNK";
	dkim-atps=neutral
X-Greylist: delayed 323 seconds by postgrey-1.36 at gabe;
 Wed, 06 May 2026 16:59:32 UTC
Received: from forward205d.mail.yandex.net (forward205d.mail.yandex.net
 [178.154.239.216])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3871589D39
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 16:59:32 +0000 (UTC)
Received: from forward102d.mail.yandex.net (forward102d.mail.yandex.net
 [IPv6:2a02:6b8:c41:1300:1:45:d181:d102])
 by forward205d.mail.yandex.net (Yandex) with ESMTPS id 87D1E86808
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 19:54:09 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:2646:0:640:add0:0])
 by forward102d.mail.yandex.net (Yandex) with ESMTPS id 9F697C0120;
 Wed, 06 May 2026 19:54:06 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net (smtp)
 with ESMTPSA id 2skcjWGSoW20-P2IKQ00u; 
 Wed, 06 May 2026 19:54:05 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=2005.tr; s=mail;
 t=1778086446; bh=kMg+VAvJYbWrlFbwgOjXF47h84s1aNcKOZEo+xRdNek=;
 h=Message-ID:Date:Subject:To:From;
 b=EMUn+NNK9frgcpxDgm6YNPziOkFgflwHuE1bs4IAuNT5R6GufHyROF74YrVCR6i2R
 0DZOIenBeJBGlVtbAcdC3eg/OcItVNYRKZxQ9fPN9btOeXv7e0OVzjc2bXHn2oGfko
 lu1R108jAr/J+pY70L/fhuwudxQg0+ka7UYUgLXI=
Authentication-Results: mail-nwsmtp-smtp-production-main-94.klg.yp-c.yandex.net;
 dkim=pass header.i=@2005.tr
From: x@2005.tr
To: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/rockchip: Open-code drm_simple_encoder_init()
Date: Wed,  6 May 2026 19:53:45 +0300
Message-ID: <20260506165346.19819-1-x@2005.tr>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 07 May 2026 10:13:17 +0000
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

From: Favilances Noir <favilances@proton.me>

drm_simple_encoder_init() wraps drm_encoder_init().

It uses drm_encoder_cleanup() as the encoder destroy callback.

Add driver-local drm_encoder_funcs and call drm_encoder_init() directly.

This is a TODO cleanup towards removing drm_simple_encoder_init().

No functional change intended.

Signed-off-by: Favilances Noir <favilances@proton.me>
---
 drivers/gpu/drm/rockchip/rockchip_rgb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rockchip_rgb.c b/drivers/gpu/drm/rockchip/rockchip_rgb.c
index 5c0c6e2cc28d..fd93ffedad64 100644
--- a/drivers/gpu/drm/rockchip/rockchip_rgb.c
+++ b/drivers/gpu/drm/rockchip/rockchip_rgb.c
@@ -13,11 +13,11 @@
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
 #include <drm/drm_bridge_connector.h>
+#include <drm/drm_encoder.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
-#include <drm/drm_simple_kms_helper.h>
 
 #include "rockchip_drm_drv.h"
 #include "rockchip_rgb.h"
@@ -70,6 +70,10 @@ struct drm_encoder_helper_funcs rockchip_rgb_encoder_helper_funcs = {
 	.atomic_check = rockchip_rgb_encoder_atomic_check,
 };
 
+static const struct drm_encoder_funcs rockchip_rgb_encoder_funcs = {
+	.destroy = drm_encoder_cleanup,
+};
+
 struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 				       struct drm_crtc *crtc,
 				       struct drm_device *drm_dev,
@@ -127,7 +131,8 @@ struct rockchip_rgb *rockchip_rgb_init(struct device *dev,
 	encoder = &rgb->encoder.encoder;
 	encoder->possible_crtcs = drm_crtc_mask(crtc);
 
-	ret = drm_simple_encoder_init(drm_dev, encoder, DRM_MODE_ENCODER_NONE);
+	ret = drm_encoder_init(drm_dev, encoder, &rockchip_rgb_encoder_funcs,
+			       DRM_MODE_ENCODER_NONE, NULL);
 	if (ret < 0) {
 		DRM_DEV_ERROR(drm_dev->dev,
 			      "failed to initialize encoder: %d\n", ret);
-- 
2.54.0

