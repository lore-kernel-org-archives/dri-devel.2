Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74BE8C55174
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D14CF10F328;
	Fri, 31 Jul 2026 16:23:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="qzzSuHhH";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1645D10F30D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514803;
 bh=anZYZ7yEJJr+RFy3nqLwYzOV6L9Uj+UtOgmMLRpsr3o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=qzzSuHhHTqHAYGCtiCISlU2GIZoJ6K8YPdWC668t77q5yGwOqy2LPXCULADOvM2LT
 1EcbZpdSklzdzf88BLSp9Hy/3bYP4T7dEwUVMNTsAJ/WfofHkz1tAj7AxTnx2iO4tz
 aJBuWxmPH1O+QzUQEraPCMmsKnKUX2GE8arrFuXHHnoMKu6VPcIhkXM9m4pofdBGMl
 1lQCXcMgWbd/EZ63mcr0qcfxzF1fUStLfwiOKl87ZGuZXwjtYe8x8W81hs5QkIhw/B
 Ee6Suurozk8QakEpf6Ba2AyC5qJ4PTki3E/LLTPPmeTk8fAj1kRHe5UW7sCqy5anOW
 AJ2QvC9Od/waw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A72A117E0B89;
 Fri, 31 Jul 2026 18:20:03 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:20:16 +0300
Subject: [PATCH v10 69/69] drm/connector: Drop redundant max_bpc field
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-69-294364b2cf15@collabora.com>
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
 linux-sunxi@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 Diederik de Haas <diederik@cknow-tech.com>
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

Now that all users migrated to the new drmm_connector_hdmi_init()
signature, max_bpc is provided through struct drm_connector_hdmi_funcs,
a reference to which is already stored in drm_connector_hdmi.

Drop the redundant connector->max_bpc field and point its users to
hdmi.funcs->max_bpc instead.

Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 6 +++---
 drivers/gpu/drm/drm_connector.c                 | 2 --
 include/drm/drm_connector.h                     | 5 -----
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index c5496641a2f3..53057ef80e45 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -319,7 +319,7 @@
 void __drm_atomic_helper_connector_hdmi_state_init(struct drm_connector *connector,
 						   struct drm_connector_state *new_conn_state)
 {
-	unsigned int max_bpc = connector->max_bpc;
+	unsigned int max_bpc = connector->hdmi.funcs ? connector->hdmi.funcs->max_bpc : 0;
 
 	new_conn_state->max_bpc = max_bpc;
 	new_conn_state->max_requested_bpc = max_bpc;
@@ -678,7 +678,7 @@ hdmi_compute_config(const struct drm_connector *connector,
 {
 	unsigned int max_bpc = clamp_t(unsigned int,
 				       conn_state->max_bpc,
-				       8, connector->max_bpc);
+				       8, connector->hdmi.funcs->max_bpc);
 	enum drm_output_color_format fmt;
 	int ret;
 
@@ -811,7 +811,7 @@ static int hdmi_generate_hdr_infoframe(const struct drm_connector *connector,
 	if (!connector->hdmi.funcs->hdr_drm.write_infoframe)
 		return 0;
 
-	if (connector->max_bpc < 10)
+	if (connector->hdmi.funcs->max_bpc < 10)
 		return 0;
 
 	if (!conn_state->hdr_output_metadata)
diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
index 293b2823475d..38d9f977338c 100644
--- a/drivers/gpu/drm/drm_connector.c
+++ b/drivers/gpu/drm/drm_connector.c
@@ -672,8 +672,6 @@ int drmm_connector_hdmi_init(struct drm_device *dev,
 	}
 
 	drm_connector_attach_max_bpc_property(connector, 8, hdmi_funcs->max_bpc);
-	/* TODO: remove after conversion to new drmm_connector_hdmi_init() */
-	connector->max_bpc = hdmi_funcs->max_bpc;
 
 	if (hdmi_funcs->max_bpc > 8)
 		drm_connector_attach_hdr_output_metadata_property(connector);
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 75bd9ac03571..5e0d65adb244 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -2391,11 +2391,6 @@ struct drm_connector {
 	 */
 	struct drm_property_blob *path_blob_ptr;
 
-	/**
-	 * @max_bpc: Maximum bits per color channel the connector supports.
-	 */
-	unsigned int max_bpc;
-
 	/**
 	 * @max_bpc_property: Default connector property for the max bpc to be
 	 * driven out of the connector.

-- 
2.55.0

