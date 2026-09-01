Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E07C624DB
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 18:51:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB3B310EE5B;
	Tue,  1 Sep 2026 18:51:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ACW+ziuW";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89F6610EE47
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 18:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1788288658;
 bh=dHIKdEC5RHVqcHq82GjtYHGUUOJHjjeCBOpp724uoac=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=ACW+ziuWAPd7zQm+209nems4I5iTQK8DxQhfTlIXHAZiHsFxLg+JqCna8mjW0HOHN
 9oRrZAu3JtYTlX3chmx8L5lRyVfKDJ4tedh4UDnomz7Z4HGRGJKJa5A43vFlyVsXv/
 vycrj6aiyTRjt+Ma0ToXjajA6HX6rGIme9LyvDu8Kp5+VSNbCpQIN5a4zfiNV5mZ6q
 zFpBFLN1tNBMGnKm9AN+7aAcRv3xpxFheSMR+zKCIZQw6bAdCULapugytg0YfuNyk2
 bFL3CtQHBlrTx1c1/d+SLHBsR7Dau2rqZ/MIlk75FrSmfC3ud9//gOm2Gq9OhGh1zs
 zN5/R+JjtaJGA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3137C17E38DC;
 Tue, 01 Sep 2026 20:50:58 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Date: Tue, 01 Sep 2026 21:50:47 +0300
Subject: [PATCH v11 23/74] drm/display: hdmi-state-helper: Sync SCDC state
 on hotplug
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260901-dw-hdmi-qp-scramb-v11-23-bc12954a0688@collabora.com>
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
 linux-fbdev@vger.kernel.org, Maud Spierings <maud_spierings@hotmail.com>, 
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

drm_atomic_helper_connector_hdmi_hotplug() does not currently
synchronize SCDC status on hotplug events, leaving the scrambler state
potentially inconsistent after (re)connect.

Hook drm_connector_hdmi_sync_scdc() into both the connect and disconnect
paths, replacing the existing TODOs around missing scrambler handling.
Note that per .detect_ctx() contract, implementations shall return a
drm_connector_status value or -EDEADLK, nothing else.  Therefore, handle
deadlocks and just report any other errors.  For consistency, also
report the errors from drm_edid_connector_update().

Tested-by: Maud Spierings <maud_spierings@hotmail.com>
Tested-by: Diederik de Haas <diederik@cknow-tech.com>  # NanoPC-T6 LTS, Rock 5B
Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
 drivers/gpu/drm/display/drm_hdmi_state_helper.c | 34 ++++++++++++++++++++++---
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
index 8045b1d17d6e..1e269b203b98 100644
--- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
+++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
@@ -1362,12 +1362,29 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 					enum drm_connector_status status)
 {
 	const struct drm_edid *drm_edid;
+	int ret;
 
 	if (status == connector_status_disconnected) {
-		// TODO: also handle scramber, HDMI sink disconnected.
+		/*
+		 * .detect_ctx() can only ever return a drm_connector_status or
+		 * -EDEADLK. Handle deadlocks, and report any !EDEADLK error.
+		 */
+		ret = drm_connector_hdmi_sync_scdc(connector, false, ctx);
+		if (ret) {
+			if (ret == -EDEADLK)
+				return ret;
+
+			drm_warn(connector->dev, "Ignored SCDC sync error: %d\n", ret);
+		}
+
 		drm_connector_hdmi_audio_plugged_notify(connector, false);
-		drm_edid_connector_update(connector, NULL);
+
+		ret = drm_edid_connector_update(connector, NULL);
+		if (ret)
+			drm_warn(connector->dev, "Ignored EDID update error: %d\n", ret);
+
 		drm_connector_cec_phys_addr_invalidate(connector);
+
 		return 0;
 	}
 
@@ -1381,7 +1398,18 @@ drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
 	drm_edid_free(drm_edid);
 
 	if (status == connector_status_connected) {
-		// TODO: also handle scramber, HDMI sink is now connected.
+		/*
+		 * .detect_ctx() can only ever return a drm_connector_status or
+		 * -EDEADLK. Handle deadlocks, and report any !EDEADLK error.
+		 */
+		ret = drm_connector_hdmi_sync_scdc(connector, true, ctx);
+		if (ret) {
+			if (ret == -EDEADLK)
+				return ret;
+
+			drm_warn(connector->dev, "Ignored SCDC sync error: %d\n", ret);
+		}
+
 		drm_connector_hdmi_audio_plugged_notify(connector, true);
 		drm_connector_cec_phys_addr_set(connector);
 	}

-- 
2.55.0

