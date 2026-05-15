Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6F6CD4F3D
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 11:47:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 95D5510E417;
	Fri, 15 May 2026 11:47:01 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de
 (metis.whiteo.stw.pengutronix.de [185.203.201.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69F6F10E417
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 11:47:00 +0000 (UTC)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77]
 helo=ratatoskr.trumtrar.info)
 by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
 (envelope-from <s.trumtrar@pengutronix.de>)
 id 1wNr06-0000OE-DV; Fri, 15 May 2026 13:46:42 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Fri, 15 May 2026 13:46:33 +0200
Subject: [PATCH v2 2/2] drm/panel: simple: add NEC NL6448BC33-70C
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-2-74ab0baa1817@pengutronix.de>
References: <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-0-74ab0baa1817@pengutronix.de>
In-Reply-To: <20260515-v7-1-topic-panel-simple-nl6448bc33-v2-0-74ab0baa1817@pengutronix.de>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1742;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=utKVWHJWxR8OqwDdyrjQHcotmRlCHxcPocQH7Xfb/aE=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQxY7+3zL6uUbhM+8eHb1oYtb/dpYdw3OO1Gfpm3p/HTjQ
 6/v9FcTO0pZGMS4GGTFFFlUFlbwiXp88IycJsIFM4eVCWQIAxenAEykxIbhf/LLgNslm+b7PD7Y
 sPfBNp+O4pwpla4HQmcbGwfr9phyPGf4H8AepxzB7OBZ/3K2nuWGBzJ35RtjT3I5nfnu8s2n46Q
 dBwA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: s.trumtrar@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de);
 SAEximRunCond expanded to false
X-PTX-Original-Recipient: dri-devel@lists.freedesktop.org
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

Add NEC NL6448BC33-70C 10.4" 640x480 LCD module support.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 236bd56208ccf..dca6cbc41bd9f 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3659,6 +3659,32 @@ static const struct panel_desc nec_nl4827hc19_05b = {
 	.bus_flags = DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
 };
 
+static const struct drm_display_mode nec_nl6448bc33_70c_mode = {
+	.clock = 25175,
+	.hdisplay = 640,
+	.hsync_start = 640 + 16,
+	.hsync_end = 640 + 16 + 48,
+	.htotal = 640 + 16 + 48 + 96,
+	.vdisplay = 480,
+	.vsync_start = 480 + 2,
+	.vsync_end = 480 + 2 + 31,
+	.vtotal = 480 + 2 + 31 + 31,
+	.flags = DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_PHSYNC,
+};
+
+static const struct panel_desc nec_nl6448bc33_70c = {
+	.modes = &nec_nl6448bc33_70c_mode,
+	.num_modes = 1,
+	.bpc = 6,
+	.size = {
+		.width = 211,
+		.height = 158,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB666_1X18,
+	.bus_flags = DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_LVDS,
+};
+
 static const struct drm_display_mode netron_dy_e231732_mode = {
 	.clock = 66000,
 	.hdisplay = 1024,
@@ -5520,6 +5546,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "nec,nl4827hc19-05b",
 		.data = &nec_nl4827hc19_05b,
+	}, {
+		.compatible = "nec,nl6448bc33-70c",
+		.data = &nec_nl6448bc33_70c,
 	}, {
 		.compatible = "netron-dy,e231732",
 		.data = &netron_dy_e231732,

-- 
2.53.0

