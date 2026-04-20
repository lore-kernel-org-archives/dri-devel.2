Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E05C1F588C7
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:14:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B568A10E5D0;
	Mon, 20 Apr 2026 13:13:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="IwAdTYXJ";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 026D910E5CD
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:13:55 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 50D232769;
 Mon, 20 Apr 2026 15:12:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776690737;
 bh=OTOH3ZeYgVnJs6tLI3x0KEqkmqaY31h1b+sNXzjNFkw=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=IwAdTYXJYgS9VgKEB9/qQOityYtSAJBHz+PB8BqctLnSVCHve8GZ6z/9SuIL+r8Oz
 siDC4k4KxeRjC/duM000T2Z0bi8QFyTneE8fc7sha80ZrZB+i5rmO034c0IxFoFOfZ
 zG/hQfjra/7sYMpm0NF4umC0Ce2LO058IzjMaSl0=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 20 Apr 2026 16:13:36 +0300
Subject: [PATCH 2/2] drm/panel: simple: Add timings for Raspberry Pi 7" panel
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-rpi-7inch-v1-2-e68d5c9c44bc@ideasonboard.com>
References: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
In-Reply-To: <20260420-rpi-7inch-v1-0-e68d5c9c44bc@ideasonboard.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3166;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=OTOH3ZeYgVnJs6tLI3x0KEqkmqaY31h1b+sNXzjNFkw=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iaOmWf+RtmzIrZdcehacyVvlq8B78OVw8Kwd
 /vh+tW8g+iJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYmjgAKCRD6PaqMvJYe
 9ZlPD/sG4leh9VTCLgKyRnJb3Dr+6Xbd8kUOqNk/EqAGepcuCEN/aNl9QtYYn4o7qqKnyPwfSzX
 K05EZO9ZgMriVVKzx2xGbd6H8I9jsrXCf6IQV/ZC2TY7DixPUyPAx5N/Xvid0qGpCttCjFs41jd
 9bYiOMQyrUIoPLY/vueOIM3mR+eAjiweaqZF2p3ws4QRCc3NJpguTP6y02G4AgmrBvc1dgiaIYu
 zuhPG2JkY2w9tiy7ACr4iPoPw465UBhm623VDRaeLehpgA83JRkypOVYMkTHHuZSMzy8AP2OR9m
 1iNa/Ao5pu0Bb8x8hsa/KH6A6OIBBytr6fPQ4u14DU3JyKpcs5G3Ahfm35nWsD83cGm6Ibpw+93
 B5eoVp8io6gQNyvRSmUb8DfxlgRrE1aCkE254C1O6pVgilidoDGsqrfetVVjRziTEU9xLC1Qzcb
 3qGP5TyWa1xiSd0J7W0/Gihr21cegLdw+OYNdU/EhMi+j6RdVOHqlxUfFsXvGqqG+V23GGERfQ2
 hW5CqHvkjLmQY/Zt6hKuqvIIOFcmaS/FKZl3XjoNEfNTRl3ve/PhSjD3Ij6wAmpuBp4ggAngKcF
 z34/ze9GFAYPC0PD85Vtz9A2V0wwylVMbpz7w0q47c7TODjZpgDhzYDPtR+EVOVcPUTS/KEmAEJ
 dJMFNwVUXC5BzZw==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Add timings for the panel used in Raspberry Pi 7" DSI Display module:
https://www.raspberrypi.com/products/raspberry-pi-touch-display/

This has been tested with version v1.1 of the display module.

The panel is very strict about the back-porch values, they must be
exactly 46 for hbp and 23 for vbp. Other timings can be defined quite
freely.

The panel is exclusive to Raspberry Pi, and different versions of the
display module can have panels from different vendors which are fully
compatible. Also, as the panel vendors are not public, the compatible
string used is "raspberrypi,7inch-dsi".

Note that while the display module has a DSI connector, and the
compatible has "dsi" in it, we use DRM_MODE_CONNECTOR_DPI as the panel
itself is a parallel video panel. The display module (as of v1.1) uses
TC358762 DSI-to-DPI bridge to do the conversion.

We could use DRM_MODE_CONNECTOR_DSI here, which would have the benefit
of showing a "DSI-1" connector to the userspace. However, the panel IS a
DPI panel, and gets its input from a DSI-to-DPI bridge, and the
panel-simple.c behaves differently depending on the connector type used,
so, DRM_MODE_CONNECTOR_DPI it is.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 91ab280869ba..e75eb20301f2 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -4208,6 +4208,35 @@ static const struct panel_desc rocktech_rk043fn48h = {
 	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
+static const struct display_timing raspberrypi_7inch_timing = {
+	.pixelclock = { 10000000, 30000000, 50000000 },
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 16, 72, 354 },
+	.hsync_len = { 1, 32, 40 },
+	.hback_porch = { 46, 46, 46 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 7, 21, 147 },
+	.vsync_len = { 1, 2, 20 },
+	.vback_porch = { 23, 23, 23 },
+	.flags = DISPLAY_FLAGS_VSYNC_HIGH | DISPLAY_FLAGS_HSYNC_HIGH,
+	/* Note: the rest of the flags are defined below in bus_flags */
+};
+
+static const struct panel_desc raspberrypi_7inch = {
+	.timings = &raspberrypi_7inch_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+		DRM_BUS_FLAG_SYNC_DRIVE_POSEDGE |
+		DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
+};
+
 static const struct display_timing rocktech_rk070er9427_timing = {
 	.pixelclock = { 26400000, 33300000, 46800000 },
 	.hactive = { 800, 800, 800 },
@@ -5490,6 +5519,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "qishenglong,gopher2b-lcd",
 		.data = &qishenglong_gopher2b_lcd,
+	}, {
+		.compatible = "raspberrypi,7inch-dsi",
+		.data = &raspberrypi_7inch,
 	}, {
 		.compatible = "raystar,rff500f-awh-dnn",
 		.data = &raystar_rff500f_awh_dnn,

-- 
2.43.0

