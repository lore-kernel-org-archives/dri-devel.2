Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E86DC55180
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 16:19:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3431310F317;
	Fri, 31 Jul 2026 16:19:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="REUAeMTh";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C006710F2F9
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 16:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1785514768;
 bh=8K2UYBSnPY80dXtzmdVQyx34GOgVTImDqKMUj0/HGi8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=REUAeMThoT68dG+Q98yoiSGipFezFqECWE8iq7EJU3ol2V9enQrOT9LJZY3iLtqjs
 P0lr1v8P1r9WPY0z9wQkIj+PuDp524Fj6y+P+ETd2eVMvbcTHwMRFcKKuHGt3lw9Nm
 71TRVZS8ca6tZiX/r9QeAST+XKrTMhJauD1yWbZXQeSBu+EsCNnzA5Yl9ebcz2tZ50
 AqeXzk6NMK98y77DUAoW8HJeGA6iXtUZODt4SuYpCoAKQvfhGIjWm79R2F4bWhIbzd
 7WQqPi/WqyDenf3TkKOHusCB7nSPvF1CT+oy6wawlsejO9DiYdd2gYIWJWseMh2bMU
 m0r1QmfRVkjBw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 6801517E093E;
 Fri, 31 Jul 2026 18:19:28 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Fri, 31 Jul 2026 19:19:26 +0300
Subject: [PATCH v10 19/69] drm/display: bridge_connector: Wire up HDMI 2.0
 scrambler callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260731-dw-hdmi-qp-scramb-v10-19-294364b2cf15@collabora.com>
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
 Maud Spierings <maud_spierings@hotmail.com>, 
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

Connect the bridge connector's .scrambler_{enable|disable} callbacks to
the underlying bridge's .hdmi_scrambler_{enable|disable} funcs when
HDMI 2.0 conformance is advertised.

This completes the bridge connector plumbing so that the SCDC
scrambling helpers can control source-side scrambling through the
bridge chain.

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 40 +++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 86353a0b9758..80b33d4f6b38 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -577,6 +577,32 @@ static int drm_bridge_connector_write_spd_infoframe(struct drm_connector *connec
 	return bridge->funcs->hdmi_write_spd_infoframe(bridge, buffer, len);
 }
 
+static int drm_bridge_connector_scrambler_enable(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_scrambler_enable(bridge);
+}
+
+static int drm_bridge_connector_scrambler_disable(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_scrambler_disable(bridge);
+}
+
 static const struct drm_edid *
 drm_bridge_connector_read_edid(struct drm_connector *connector)
 {
@@ -604,7 +630,7 @@ static const struct drm_connector_hdmi_funcs drm_bridge_connector_hdmi_funcs = {
 		.clear_infoframe = drm_bridge_connector_clear_hdmi_infoframe,
 		.write_infoframe = drm_bridge_connector_write_hdmi_infoframe,
 	},
-	/* audio, hdr_drm and spd are set dynamically during init */
+	/* scrambler, audio, hdr_drm and spd are set dynamically during init */
 };
 
 static const struct drm_connector_infoframe_funcs drm_bridge_connector_hdmi_audio_infoframe = {
@@ -908,6 +934,11 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			     !bridge->funcs->hdmi_clear_spd_infoframe))
 				return ERR_PTR(-EINVAL);
 
+			if (bridge->supported_hdmi_ver >= HDMI_VERSION_2_0 &&
+			    (!bridge->funcs->hdmi_scrambler_enable ||
+			     !bridge->funcs->hdmi_scrambler_disable))
+				return ERR_PTR(-EINVAL);
+
 			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
 		}
 
@@ -1027,6 +1058,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->hdmi_funcs.spd =
 				drm_bridge_connector_hdmi_spd_infoframe;
 
+		if (bridge_connector->bridge_hdmi->supported_hdmi_ver >= HDMI_VERSION_2_0) {
+			bridge_connector->hdmi_funcs.scrambler_enable =
+				drm_bridge_connector_scrambler_enable;
+			bridge_connector->hdmi_funcs.scrambler_disable =
+				drm_bridge_connector_scrambler_disable;
+		}
+
 		ret = drmm_connector_hdmi_init(drm, connector,
 					       &drm_bridge_connector_funcs,
 					       &bridge_connector->hdmi_funcs,

-- 
2.55.0

