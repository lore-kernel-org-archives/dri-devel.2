Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069E1C88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 11:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5635310E6CC;
	Thu, 17 Sep 2026 11:15:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="Cl+yCq84";
	dkim-atps=neutral
X-Greylist: delayed 603 seconds by postgrey-1.36 at gabe;
 Thu, 17 Sep 2026 11:15:25 UTC
Received: from mta-64-225.siemens.flowmailer.net
 (mta-64-225.siemens.flowmailer.net [185.136.64.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5758F10E6CC
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 11:15:25 +0000 (UTC)
Received: by mta-64-225.siemens.flowmailer.net with ESMTPSA id
 20260917110520812d0dd4e30002076a
 for <dri-devel@lists.freedesktop.org>;
 Thu, 17 Sep 2026 13:05:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=MvfE6RVo7N77d1jPZq+4yUexpW1TVNW5JhHuRAUTj6k=;
 b=Cl+yCq84xzgJwvOh7DKuyayhyAWyV3Lca8I0hMx1xhKhUMS+cugBPqqs4Id6FYQeEbGTr4
 91VN9z3PsTacSI3BXRxftiLdwsGqf3LkKzaM1A8Hs9NSqpqD7FPuzo0PF914Nb6otaIfJeuI
 3mSaITvNIs0gjXKh+ATZ9SGYXWoB15+ByGhG4bpyqEJR0vsAi5tPWGEqT5/ZmDGkWzRATegV
 SZb/ySc2vfkPR7tjkoq59meiV4HdpxjqxZfZrnt3hOLeAFdU9a7rlZ/P495eUD3YY39GNpxf
 IKcKz2agBIYW/eccWHWIJQLdpCZmNGU8UwweyU3ejP32XH5NkpdK4FeA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: Frank Bodammer <frank.bodammer@siemens.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>, Sam Ravnborg <sam@ravnborg.org>,
 linux-kernel@vger.kernel.org,
 Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: [PATCH 2/2] drm/panel: simple: Add support for Truly TFT320240-229-E
 panel
Date: Thu, 17 Sep 2026 13:05:15 +0200
Message-ID: <20260917110517.1053556-3-alexander.sverdlin@siemens.com>
In-Reply-To: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
References: <20260917110517.1053556-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Frank Bodammer <frank.bodammer@siemens.com>

Add display mode and panel descriptor for the Truly TFT320240-229-E
LCD panel.
Register the panel in the of_device_id table with the compatible
string "truly,tft320240-229-e".

Signed-off-by: Frank Bodammer <frank.bodammer@siemens.com>
Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 29 ++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c95964ba25a95..bd7f6eaeb0deb 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -5114,6 +5114,32 @@ static const struct panel_desc tpk_f10a_0102 = {
 	},
 };
 
+static const struct drm_display_mode truly_tft320240_229_e_mode = {
+	.clock = 6410,
+	.hdisplay = 320,
+	.hsync_start = 320 + 8,
+	.hsync_end = 320 + 8 + 39,
+	.htotal = 320 + 8 + 39 + 4,
+	.vdisplay = 240,
+	.vsync_start = 240 + 8,
+	.vsync_end = 240 + 8 + 8,
+	.vtotal = 240 + 8 + 8 + 4,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc truly_tft320240_229_e = {
+	.modes = &truly_tft320240_229_e_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 70,
+		.height = 53,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.bus_flags = DRM_BUS_FLAG_DE_HIGH,
+	.connector_type = DRM_MODE_CONNECTOR_DPI,
+};
+
 static const struct display_timing urt_umsh_8596md_timing = {
 	.pixelclock = { 33260000, 33260000, 33260000 },
 	.hactive = { 800, 800, 800 },
@@ -6167,6 +6193,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "tpk,f10a-0102",
 		.data = &tpk_f10a_0102,
+	}, {
+		.compatible = "truly,tft320240-229-e",
+		.data = &truly_tft320240_229_e,
 	}, {
 		.compatible = "urt,umsh-8596md-t",
 		.data = &urt_umsh_8596md_parallel,
-- 
2.55.0

