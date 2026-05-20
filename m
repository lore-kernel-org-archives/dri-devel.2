Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2B6CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:38:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0FF410F134;
	Wed, 20 May 2026 18:38:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="SRzq04vZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E9BF010F119
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779302318;
 bh=d+1562epby5HWJPwkuWjca1WYAynglwGoda/Ep4Urtk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=SRzq04vZYG184OtEQIXxhhw9w2QmxCqNCGD6shcT/HwZkDx+Swsq7ZSUIlEg2mtnw
 ageVzXndWA3WhaeCsGYVZPRs3T8oAaRotslGNALtNKW1qvRK/hT7935BPQ9yMvuLWq
 wLJHP7/od/JCTu19d37aA9nTw0iE7WUOcp5Kvdp7fCpHa0xmnpWKnP3aJbRYvlwciM
 LvED0ekkdroFFpI7iMGqxxYpSPvN2FOItWFTzDYPd4je6TAwkYPS/DEJxRdPI80n9+
 F+7Y/sRiAt4jkNqKkdORnDrvJTKMBbgBK62b5TxcheIZYmhcTNfLUCpgJTb3LOQYJt
 XkZq3+/RKaL6g==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 80D6F17E1513;
 Wed, 20 May 2026 20:38:38 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Wed, 20 May 2026 21:38:21 +0300
Subject: [PATCH v6 10/22] drm/display: bridge_connector: Wire up HDMI 2.0
 scrambler callbacks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-dw-hdmi-qp-scramb-v6-10-24b74603b782@collabora.com>
References: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
In-Reply-To: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org
X-Mailer: b4 0.15.1
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

Connect the bridge connector's .scrambler_src_{enable|disable}()
callbacks to the underlying bridge's .hdmi_scrambler_{enable|disable}()
funcs when DRM_BRIDGE_OP_HDMI_SCRAMBLER is advertised.

This completes the bridge connector plumbing so that the SCDC
scrambling helpers can control source-side scrambling through the
bridge chain.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_bridge_connector.c | 40 +++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/display/drm_bridge_connector.c b/drivers/gpu/drm/display/drm_bridge_connector.c
index 47bb0dcf509f..6f65733b7dd9 100644
--- a/drivers/gpu/drm/display/drm_bridge_connector.c
+++ b/drivers/gpu/drm/display/drm_bridge_connector.c
@@ -548,6 +548,32 @@ static int drm_bridge_connector_write_spd_infoframe(struct drm_connector *connec
 	return bridge->funcs->hdmi_write_spd_infoframe(bridge, buffer, len);
 }
 
+static int drm_bridge_connector_scrambler_src_enable(struct drm_connector *connector)
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
+static int drm_bridge_connector_scrambler_src_disable(struct drm_connector *connector)
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
@@ -573,7 +599,7 @@ static const struct drm_connector_hdmi_funcs drm_bridge_connector_hdmi_funcs = {
 		.clear_infoframe = drm_bridge_connector_clear_hdmi_infoframe,
 		.write_infoframe = drm_bridge_connector_write_hdmi_infoframe,
 	},
-	/* audio, hdr_drm and spd are set dynamically during init */
+	/* scrambler, audio, hdr_drm and spd are set dynamically during init */
 };
 
 static const struct drm_connector_infoframe_funcs drm_bridge_connector_hdmi_audio_infoframe = {
@@ -879,6 +905,11 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			     !bridge->funcs->hdmi_clear_spd_infoframe))
 				return ERR_PTR(-EINVAL);
 
+			if (bridge->ops & DRM_BRIDGE_OP_HDMI_SCRAMBLER &&
+			    (!bridge->funcs->hdmi_scrambler_enable ||
+			     !bridge->funcs->hdmi_scrambler_disable))
+				return ERR_PTR(-EINVAL);
+
 			bridge_connector->bridge_hdmi = drm_bridge_get(bridge);
 
 			if (bridge->supported_formats)
@@ -983,6 +1014,13 @@ struct drm_connector *drm_bridge_connector_init(struct drm_device *drm,
 			bridge_connector->hdmi_funcs.spd =
 				drm_bridge_connector_hdmi_spd_infoframe;
 
+		if (bridge_connector->bridge_hdmi->ops & DRM_BRIDGE_OP_HDMI_SCRAMBLER) {
+			bridge_connector->hdmi_funcs.scrambler_src_enable =
+				drm_bridge_connector_scrambler_src_enable;
+			bridge_connector->hdmi_funcs.scrambler_src_disable =
+				drm_bridge_connector_scrambler_src_disable;
+		}
+
 		ret = drmm_connector_hdmi_init(drm, connector,
 					       bridge_connector->bridge_hdmi->vendor,
 					       bridge_connector->bridge_hdmi->product,

-- 
2.53.0

