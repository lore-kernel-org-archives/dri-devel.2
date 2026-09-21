Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5110C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 15:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AEFC10E935;
	Mon, 21 Sep 2026 15:52:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="GB3YC3I9";
	dkim-atps=neutral
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com
 [136.143.188.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF82A10E90A;
 Mon, 21 Sep 2026 15:52:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1790005951; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=hJuEk/WXya3YSJ7LhRNDAFC1MHk9GtJeimnQ9ZLklDsPCi5INcsGyqoU7YgcuhI7RBUxaXaqlJ3LHlPHmnGCWeM2uwgW/mECm/ln4HEUwduM+kC1fbuy3Pgn+oLskBhtNTPSeuARsQ4ndvdFDYRHoaTWOPPgYBNmob8yO5dSGt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1790005951;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=CnFGpLHNPi3LH+koDqB85QbgcIXof8AnqDGa7CUOj4Y=; 
 b=XRyI1gaI3qZ5mlYUnApgcWa77UECg29xCk/fMKtOFf6Rhhb/vnzuer+HUkTMk/PBB8cKMd6bKYvZ61ymabJ6HDBQ6XP9XiuTEhHUDkkfAvxgll9m1KxpH8Nm4TNRAiKCU2MjH9KDlinUTxB0Wp9QJJz6Z6le5U3fpUz3uiFuZxk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
 dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790005951; 
 s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=CnFGpLHNPi3LH+koDqB85QbgcIXof8AnqDGa7CUOj4Y=;
 b=GB3YC3I9oUKWLc+A3JSbQ48WwIo5d3RbvksvfstgfXM1HSWAKqCwNK0rCMBOL4Gw
 TsY1K2CHvLXJ3mb9hg3MUwGK9dxRvZDh630zLevo5MT5M2VAWLhqC7YpdNH3V4G/5GJ
 0DwfxoFydSyH/9Jwtr5kFfxj/gSbxl5zTPT1LNqA=
Received: by smtp.zohomail.com with SMTPS id 1790005949614805.1464665003713;
 Mon, 21 Sep 2026 08:52:29 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date: Mon, 21 Sep 2026 17:51:31 +0200
Subject: [PATCH RFC 05/25] drm/bridge: Add VTEM EMP support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260921-vrr-limiter-uapi-v1-5-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
In-Reply-To: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>, 
 Leo Li <sunpeng.li@amd.com>, Daniel Stone <daniels@collabora.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Helge Deller <deller@gmx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-fbdev@vger.kernel.org, linux-rockchip@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com, 
 Derek Foreman <derek.foreman@collabora.com>, 
 wayland-devel@lists.freedesktop.org, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
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

From: Derek Foreman <derek.foreman@collabora.com>

Add setters and support bit for VTEM emp to the bridge.

Signed-off-by: Derek Foreman <derek.foreman@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 41 ++++++++++++++++++++++++++
 include/drm/drm_bridge.h                       | 29 ++++++++++++++++++
 include/drm/drm_connector.h                    |  8 +++++
 3 files changed, 78 insertions(+)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 707d7143e475..dc814dbb5120 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -610,6 +610,33 @@ static int drm_bridge_connector_scrambler_disable(struct drm_connector *connecto
 	return bridge->funcs->hdmi_scrambler_disable(bridge);
 }
 
+static int drm_bridge_connector_clear_vtem_emp(struct drm_connector *connector)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_clear_vtem_emp(bridge);
+}
+
+static int drm_bridge_connector_write_vtem_emp(struct drm_connector *connector,
+					       const u8 *buffer, size_t len)
+{
+	struct drm_bridge_connector *bridge_connector =
+		to_drm_bridge_connector(connector);
+	struct drm_bridge *bridge;
+
+	bridge = bridge_connector->bridge_hdmi;
+	if (!bridge)
+		return -EINVAL;
+
+	return bridge->funcs->hdmi_write_vtem_emp(bridge, buffer, len);
+}
+
 static const struct drm_edid *
 drm_bridge_connector_read_edid(struct drm_connector *connector)
 {
@@ -655,6 +682,11 @@ static const struct drm_connector_infoframe_funcs drm_bridge_connector_hdmi_spd_
 	.write_infoframe = drm_bridge_connector_write_spd_infoframe,
 };
 
+static const struct drm_connector_infoframe_funcs drm_bridge_connector_hdmi_vtem_emp = {
+	.clear_infoframe = drm_bridge_connector_clear_vtem_emp,
+	.write_infoframe = drm_bridge_connector_write_vtem_emp,
+};
+
 static int drm_bridge_connector_audio_startup(struct drm_connector *connector)
 {
 	struct drm_bridge_connector *bridge_connector =
@@ -946,6 +978,11 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			     !bridge->funcs->hdmi_scrambler_disable))
 				return ERR_PTR(-EINVAL);
 
+			if (bridge->ops & DRM_BRIDGE_OP_HDMI_VTEM_EMP &&
+			    (!bridge->funcs->hdmi_write_vtem_emp ||
+			     !bridge->funcs->hdmi_clear_vtem_emp))
+				return ERR_PTR(-EINVAL);
+
 			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
 		}
 
@@ -1072,6 +1109,10 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 				drm_bridge_connector_scrambler_disable;
 		}
 
+		if (bridge_connector->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_VTEM_EMP)
+			bridge_connector->hdmi_funcs.vtem =
+				drm_bridge_connector_hdmi_vtem_emp;
+
 		ret = drmm_connector_hdmi_init(drm, connector,
 					       &drm_bridge_connector_funcs,
 					       &bridge_connector->hdmi_funcs,
diff --git a/include/drm/drm_bridge.h b/include/drm/drm_bridge.h
index 77b3ffe69230..9dbd1bfa39af 100644
--- a/include/drm/drm_bridge.h
+++ b/include/drm/drm_bridge.h
@@ -684,6 +684,29 @@ struct drm_bridge_funcs {
 	int (*hdmi_write_spd_infoframe)(struct drm_bridge *bridge,
 					const u8 *buffer, size_t len);
 
+	/**
+	 * @hdmi_clear_vtem_emp:
+	 *
+	 * This callback clears the emp in the hardware during commit.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the DRM_BRIDGE_OP_HDMI_VTEM_EMP flag in their
+	 * &drm_bridge->ops.
+	 */
+	int (*hdmi_clear_vtem_emp)(struct drm_bridge *bridge);
+
+	/**
+	 * @hdmi_write_spd_infoframe:
+	 *
+	 * Program the emp into the hardware.
+	 *
+	 * This callback is optional but it must be implemented by bridges that
+	 * set the DRM_BRIDGE_OP_HDMI_VTEM_EMP flag in their
+	 * &drm_bridge->ops.
+	 */
+	int (*hdmi_write_vtem_emp)(struct drm_bridge *bridge,
+				   const u8 *buffer, size_t len);
+
 	/**
 	 * @hdmi_clear_audio_infoframe:
 	 *
@@ -1021,6 +1044,12 @@ enum drm_bridge_ops {
 	 * &drm_bridge_funcs->hdmi_clear_spd_infoframe callbacks.
 	 */
 	DRM_BRIDGE_OP_HDMI_SPD_INFOFRAME = BIT(10),
+	/**
+	 * @DRM_BRIDGE_OP_HDMI_VTEM_EMP: The bridge supports
+	 * &drm_bridge_funcs->hdmi_write_vtem_emp and
+	 * &drm_bridge_funcs->hdmi_clear_vtem_emp callbacks.
+	 */
+	DRM_BRIDGE_OP_HDMI_VTEM_EMP = BIT(11),
 };
 
 /**
diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
index 593fbeaffa16..e561a444515f 100644
--- a/include/drm/drm_connector.h
+++ b/include/drm/drm_connector.h
@@ -1633,6 +1633,14 @@ struct drm_connector_hdmi_funcs {
 	 * optional.
 	 */
 	struct drm_connector_infoframe_funcs spd;
+
+	/**
+	 * @vtem:
+	 *
+	 * Set of callbacks for handling the VTEM EMP. These callbacks are
+	 * optional.
+	 */
+	struct drm_connector_infoframe_funcs vtem;
 };
 
 /**

-- 
2.55.0

