Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA377C55176
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:19:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3D7310F313;
	Fri, 31 Jul 2026 16:19:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YbtuXWh6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB38B10F2FB
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514759;
 bh=zZekc2wO4hv/88Qt7fIQVdz7WdxIyZgalaH2L/jTaLU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=YbtuXWh6M2rS59EBp6uD5toPJfpcC2gpfkuP1MOCUSlPNR5yDYmyXg0xQUh4ecfz9
 1T6fqVztjllvq68VsDIMWAXeoFJV1+FDH9y8crvEmhse3u2L74n73qimA4xsBQU2B8
 1GsgY0ynuv7t+EBsvYgpEURHtluxoUsou15L34vGeuNUFdjkm450bcROBKbQ4SIEX1
 Va7pf0Za//tNv0IGIULDeJMrXvNj7t3ENIgPOZ+zLirE4VT7U1q/lP37dbeMWjFpa9
 cnZdwuWyzM1M4IYBQAX5P4QdLsmNzPW7TwR+Dj+ZmqHDVLwZD16fmkf2JbLedyQrNf
 jldHOD1oUtuYg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 1A91017E08EB;
 Fri, 31 Jul 2026 18:19:19 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:13 +0300
Subject: [PATCH v10 06/69] drm/probe-helper: Introduce .force_ctx()
 connector callback
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-6-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Chen-Yu Tsai <wens@kernel.org>, Samuel Holland <samuel@sholland.org>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.2
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

The .force() connector callback is invoked by
drm_helper_probe_single_connector_modes() while the modeset acquire
context it created is live, but the hook signature provides no way to
pass it down, e.g. to support implementations needing to lock further
objects.

Add a .force_ctx() variant to drm_connector_helper_funcs, taking the
acquire context and returning an error code, so that -EDEADLK propagates
into the existing retry path.  When provided, it takes precedence over
drm_connector_funcs' .force(), which is kept for existing users.

This is a prerequisite for SCDC status synchronization in the HDMI
connector framework.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/drm_probe_helper.c       | 14 +++++++++++++-
 include/drm/drm_connector.h              |  6 ++++++
 include/drm/drm_modeset_helper_vtables.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_probe_helper.c b/drivers/gpu/drm/drm_probe_helper.c
index e26ead5b5e58..918255bcfa09 100644
--- a/drivers/gpu/drm/drm_probe_helper.c
+++ b/drivers/gpu/drm/drm_probe_helper.c
@@ -559,6 +559,7 @@ static int __drm_helper_update_and_validate(struct drm_connector *connector,
 int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 					    uint32_t maxX, uint32_t maxY)
 {
+	const struct drm_connector_helper_funcs *funcs = connector->helper_private;
 	struct drm_device *dev = connector->dev;
 	struct drm_display_mode *mode;
 	int count = 0, ret;
@@ -592,8 +593,19 @@ int drm_helper_probe_single_connector_modes(struct drm_connector *connector,
 			connector->status = connector_status_connected;
 		else
 			connector->status = connector_status_disconnected;
-		if (connector->funcs->force)
+
+		if (funcs && funcs->force_ctx) {
+			ret = funcs->force_ctx(connector, &ctx);
+			if (ret == -EDEADLK) {
+				drm_modeset_backoff(&ctx);
+				goto retry;
+			} else if (ret < 0) {
+				drm_dbg_kms(dev, "[CONNECTOR:%d:%s] force_ctx failed: %d\n",
+					    connector->base.id, connector->name, ret);
+			}
+		} else if (connector->funcs->force) {
 			connector->funcs->force(connector);
+		}
 	} else {
 		ret = drm_helper_probe_detect(connector, &ctx, true);
 
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 2a49c4d55f77..a6de3e63b462 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1603,6 +1603,12 @@ struct drm_connector_funcs {
 	 * the sysfs interfaces or on the kernel cmdline. In that case the
 	 * @detect callback isn't called.
 	 *
+	 * New drivers should implement
+	 * &drm_connector_helper_funcs.force_ctx instead, which gets passed
+	 * the modeset acquire context and thus allows taking additional
+	 * locks.  It takes precedence over this callback when both are
+	 * implemented.
+	 *
 	 * FIXME:
 	 *
 	 * Note that this hook is only called by the probe helper. It's not in
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index ca6268945c28..cf5fe5ba2b18 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -921,6 +921,34 @@ struct drm_connector_helper_funcs {
 			  struct drm_modeset_acquire_ctx *ctx,
 			  bool force);
 
+	/**
+	 * @force_ctx:
+	 *
+	 * This function is called to update internal encoder state when the
+	 * connector is forced to a certain state by userspace, either through
+	 * the sysfs interfaces or on the kernel cmdline. In that case the
+	 * @detect_ctx callback isn't called.
+	 *
+	 * This is the atomic version of &drm_connector_funcs.force.  When
+	 * both are implemented, this one takes precedence and
+	 * &drm_connector_funcs.force is not called.
+	 *
+	 * To avoid races against concurrent connector state updates, the
+	 * helper libraries always call this with ctx set to a valid context,
+	 * and &drm_mode_config.connection_mutex will always be locked with
+	 * the ctx parameter set to this ctx. This allows taking additional
+	 * locks as required.
+	 *
+	 * RETURNS:
+	 *
+	 * Zero on success, or a negative error code otherwise.  This includes
+	 * -EDEADLK when a lock acquisition needs to be restarted, in which
+	 * case the helpers take care of backing off and calling this function
+	 * again.
+	 */
+	int (*force_ctx)(struct drm_connector *connector,
+			 struct drm_modeset_acquire_ctx *ctx);
+
 	/**
 	 * @mode_valid:
 	 *

-- 
2.55.0

