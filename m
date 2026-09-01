Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889F0C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:51:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFD7110EE4C;
	Tue,  1 Sep 2026 18:51:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="o0Fmo9JU";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDE9710EE47
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:50:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288657;
 bh=s7nfXrufCSMgabRiLlCwtS5BY0Y5rXZc77iLgoU2ACk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=o0Fmo9JU/JHC/s3aTSbVAAFV2mAg12KyJpFmlQQE0iu+VggsX+WT3eK4Z72zJujOJ
 5Qd4v14DiYBQa8/GXRnZK14qcClbR8zkvrMtXVSClLtV6uCfqKfXycVfW4o+m6s0gs
 Mdwy+kr67mATafCZGV54ZX2fCQcOKaEWNQ97SvRy1r7ntrvFYItwO8eniwgoYU60mG
 k5gCtoNCWuZeizG8+pJ5a/nqRrKrR33nR1fhyw2KWerJMbcT7pwIdHrnqPqX4f1T3x
 HHPvWB5OQfO8JkNwo+GjS7+jzUPi4K7oz/06iVFjKMTP7j3CdsW+cuqNZm+Mz6h/Gu
 dsrFvAs7xnWgw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BC0317E38D2;
 Tue, 01 Sep 2026 20:50:57 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:46 +0300
Subject: [PATCH v11 22/74] drm/display: hdmi-state-helper: Add
 drm_atomic_helper_connector_hdmi_force_ctx()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-22-bc12954a0688@collabora.com>
References: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
In-Reply-To: <20260901-dw-hdmi-qp-scramb-v11-0-bc12954a0688@collabora.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Chen-Yu Tsai <wens@kernel.org>, 
 Samuel Holland <samuel@sholland.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>, 
 Raphael Gallais-Pou <rgallaispou@gmail.com>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, Algea Cao <algea.cao@rock-chips.com>, 
 Daniel Stone <daniels@collabora.com>, Liu Ying <victor.liu@nxp.com>, 
 Phong LE <ple@baylibre.com>, Helge Deller <deller@gmx.de>
Cc: kernel@collabora.com, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 linux-fbdev@vger.kernel.org
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

Introduce drm_atomic_helper_connector_hdmi_force_ctx() as the HDMI
connector implementation of the .force_ctx() callback.  It receives the
modeset acquire context, allowing it to take additional locks, e.g. to
support SCDC status synchronization.

Since migrating from the .force() callback is somewhat more involved,
its users will be migrated incrementally, after which
drm_atomic_helper_connector_hdmi_force() will be removed.

Reviewed-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 21 +++++++++++++++++++++
 include/drm/display/drm_hdmi_state_helper.h     |  2 ++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 485fcca2de4b..8045b1d17d6e 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1424,3 +1424,24 @@ void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector)
 	drm_atomic_helper_connector_hdmi_update(connector, NULL, connector->status);
 }
 EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force);
+
+/**
+ * drm_atomic_helper_connector_hdmi_force_ctx - HDMI Connector implementation
+ * of the force_ctx callback
+ * @connector: A pointer to the HDMI connector
+ * @ctx: Lock acquisition context to be used for resetting CRTC
+ *
+ * This function implements the .force_ctx() callback for the HDMI connectors.
+ * It can either be used directly as the callback or should be called from
+ * within the .force_ctx() callback implementation to maintain the HDMI-specific
+ * connector's data.
+ *
+ * Returns:
+ * Zero on success, error code on failure, including -EDEADLK.
+ */
+int drm_atomic_helper_connector_hdmi_force_ctx(struct drm_connector *connector,
+					       struct drm_modeset_acquire_ctx *ctx)
+{
+	return drm_atomic_helper_connector_hdmi_update(connector, ctx, connector->status);
+}
+EXPORT_SYMBOL(drm_atomic_helper_connector_hdmi_force_ctx);
diff --git a/include/drm/display/drm_hdmi_state_helper.h b/include/drm/display/drm_hdmi_state_helper.h
index 2439bad15c4b..965342f6bbc9 100644
--- a/include/drm/display/drm_hdmi_state_helper.h
+++ b/include/drm/display/drm_hdmi_state_helper.h
@@ -28,6 +28,8 @@ int drm_atomic_helper_connector_hdmi_hotplug(struct drm_connector *connector,
 					     struct drm_modeset_acquire_ctx *ctx,
 					     enum drm_connector_status status);
 void drm_atomic_helper_connector_hdmi_force(struct drm_connector *connector);
+int drm_atomic_helper_connector_hdmi_force_ctx(struct drm_connector *connector,
+					       struct drm_modeset_acquire_ctx *ctx);
 
 enum drm_mode_status
 drm_hdmi_connector_mode_valid(struct drm_connector *connector,

-- 
2.55.0

