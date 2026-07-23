Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94087C531F8
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 16:32:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD62710E0AC;
	Thu, 23 Jul 2026 16:32:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="gChkYnh9";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF71510E0AC
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 16:32:21 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 4561C4E40F12;
 Thu, 23 Jul 2026 16:32:20 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 19ABD6038D;
 Thu, 23 Jul 2026 16:32:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id ACC6811C1122C; 
 Thu, 23 Jul 2026 18:32:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784824339; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=MM+M8rHkJncpiN3+he3kwjEM79mP/B+n3GQzIblaN7A=;
 b=gChkYnh9J0LfiLxbEGY8Xxig/IANeSd/Ks9jz//SBZHq5MdN96ZBzbABw8bfME0Ylzpo6T
 QTdl+oLdJK0kOiJrOckJcV/o9SsJSDcjwTyQNR3cA2fDj81edLaBNo7+K7/v4sDPerlIYI
 WHcaC40NJkCOZDXWpPYd2ozNX/KtW/1XLaBMn5ard4UH7usxllaRSk3fTnrhcbJTIMfLum
 5HYPhsh/Vkb4Y0KRtStJxFPghvMRXeEZphgzg4DaPIFDIt61Y8iUGq2nvgf6pBNjPQ3sGG
 lcelV0O847ZOCRQCe6Ei8dfcyK2RvjZ4SG0bUwLgTmTiFT+bN2VNoZj9u+fvOQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Thu, 23 Jul 2026 18:31:50 +0200
Subject: [PATCH 2/2] drm/panel: simple: Add Ampire AM-800480N3TZQW-00H
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-support-am-800480n3tzqw-00h-v1-2-6a4ae0575a19@bootlin.com>
References: <20260723-support-am-800480n3tzqw-00h-v1-0-6a4ae0575a19@bootlin.com>
In-Reply-To: <20260723-support-am-800480n3tzqw-00h-v1-0-6a4ae0575a19@bootlin.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784824328; l=2086;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=BLWdS7ls6yh2R1mNrfKWAkzXGvBmaZR8H5PKIJOEF54=;
 b=8N9W7ZGo+1WMIF8GJpr2k/q9OaBtyb1CK+eH9CEW02SjYSan9xIwLAXRLAcCDwRIDPAVDdwXs
 gqeQBW0W2RXB7oxaMPzriErVNCbZFcvCIc87AX64gGNrtdGDJfx1TF9
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
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

Add support for the Ampire AM-800480N3TZQW-00H 5" WVGA TFT LCD panel.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c09bf3db5e78..fb60d8e7f47c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -912,6 +912,36 @@ static const struct panel_desc ampire_am_800480l1tmqw_t00h = {
 	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
+static const struct display_timing ampire_am_800480n3tzqw_00h_timing = {
+	.pixelclock = {23000000, 25000000, 27000000},
+	.hactive = { 800, 800, 800 },
+	.hfront_porch = { 4, 8, 48 },
+	.hback_porch = { 4, 8, 48 },
+	.hsync_len = { 2, 8, 8 },
+	.vactive = { 480, 480, 480 },
+	.vfront_porch = { 4, 8, 12 },
+	.vback_porch = { 4, 8, 12 },
+	.vsync_len = { 2, 4, 8 },
+	.flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
+		 DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
+		 DISPLAY_FLAGS_SYNC_POSEDGE,
+};
+
+static const struct panel_desc ampire_am_800480n3tzqw_00h = {
+	.timings = &ampire_am_800480n3tzqw_00h_timing,
+	.num_timings = 1,
+	.bpc = 8,
+	.size = {
+		.width = 108,
+		.height = 65,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+		     DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
+		     DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct panel_desc ampire_am800480r3tmqwa1h = {
 	.modes = &ampire_am800480r3tmqwa1h_mode,
 	.num_modes = 1,
@@ -5648,6 +5678,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "ampire,am-800480l1tmqw-t00h",
 		.data = &ampire_am_800480l1tmqw_t00h,
+	}, {
+		.compatible = "ampire,am-800480n3tzqw-00h",
+		.data = &ampire_am_800480n3tzqw_00h,
 	}, {
 		.compatible = "ampire,am800480r3tmqwa1h",
 		.data = &ampire_am800480r3tmqwa1h,

-- 
2.55.0

