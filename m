Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63AEFCC6B14
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 09:33:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E19F10F67E;
	Tue, 13 Oct 2026 09:33:23 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE3D10F683
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 09:33:13 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48b03f23305so2298612f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791883992; x=1792488792; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m2zoYDz7tkLEOcidCJHUPELWMh9Gsou7ImUMY6ioATo=;
 b=c4yQ0vZhrAn8Q90TlbzCd2pcI9vYdUtUz1X/uZkVhuzhfq7Bs9LvvasxUpP6eYges2
 aHWOqqdedL04V7Ih2e9DmfK54w9mn7S59qR3JuMMTJrkAfCyKqr5sygNyxElqtw99+kH
 8hArA/u45liHj5KwjDoDXU7WiNM3w9BYBjBOuXxQvuK60uViXAQ1Yfm+G4Hiwye7LQKS
 EMOzKti5OuoCm8UblhOkjh+ZswIYoBEKkEDnLfRJIrut7nnXhGzLUjakAhZNdO6aB3fd
 a1bHWlD4ybPOHnojBAZwGr9EMFrHXwJj1T2PhrB1HVF3ZnwnaCXFLuYXmDV24ZUKPe60
 /5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791883992; x=1792488792;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=m2zoYDz7tkLEOcidCJHUPELWMh9Gsou7ImUMY6ioATo=;
 b=gMP0MIqS/qosIn2Rbv80y25d9x/eb/Kfbhap0EiMKsseUF+w/2H1/S1AwK5K7VKQsh
 l8Z4ekaUU2NoH67Zh2a6YUUmyqg0K/Cdm2YlFhHHy2F+/asiBlahUzyg61hO7dF0yXUs
 o7XkveZAM6Lmjh7oA1S8fA+fcJ6m4cnlxi3Iy3AdqVSK3YP7usEXQiw2SMINfUdpUQku
 oQ4ldfsFW2vgb1MsAzDUW5qAVZCoHqNsH6q6Ee3tL5cowFMHAsBRgVscsEhNuA8dTB0f
 cUi0xg6a+v0BrKw9HiRHDNOnJftjpJLMYTaLlBYpJVVsPzwoIwawUjh1w2YylQY1Uu5f
 tx9w==
X-Forwarded-Encrypted: i=1;
 AKwUvBzw4llMtIQIymQ/KFvoMseQ+8EA3YtV3RWX+B0gtSB+uYg7tHObhvwlcgEUQCTFRIz2eHmAnF8MEUE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLKrottvSzJlRjGSIbtWLMKmd9BZNzR5WLM/xZZOlQFjuWKfXch
 PDeaQ0xB/VNBNXfi3mVNWnWW80YprMT/XFVqbbZqx7JU/IzsnulUvo9X
X-Gm-Gg: AYBFou3UoPuBAOI0Tk09dV2Y9EerTltBladT+geOwnfsIRWIA6q4PlcHgw7lQyxzTPK
 8xHgVwJzZXx/Tksarqs7whtu/45MQi0JkpMRbcJB/290mxfJ8ld32e1fuQzIuva4AZH5EzctXnm
 QZKCLJmpiWmStollWnylKh5yDZkPU1EgViNUofdbAONbwYTF+QVl1FJDFvShAC9cQxyJaOts9xm
 DDcZiv+5yhGvaqoJKqmirvuIsmXdTz4i1TkqovQm8Q0qGdnFmwpRF8VePNQf2W3vrFGlDpngYoB
 FHA9skGilt72zYQh7RFKm4RHKSoP2x/j4V3AiKZ66imVlYZwWslpb34jhezoQv7YkJ4+47wWkeK
 S3j5HSHEOiBfrrc/8jLlR3Bn/D0zW36wXPbRu9lHBls4/2e0vMltu/0835TWWRmlsGXmiJ9s2J9
 wTP48Kn3bOZsBTUoBIWxJHNZYvbpQ76npeqPmlSgEfKP2xIkwcSg8kMw28azG17ZIptBOYEFbhO
 mFqs7v6Mswuo6ogv3VZFCyE
X-Received: by 2002:a05:6000:4310:b0:48a:f1fb:e165 with SMTP id
 ffacd0b85a97d-48dbaae39e0mr21823017f8f.21.1791883992057; 
 Tue, 13 Oct 2026 02:33:12 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0bc4ec6sm3986774f8f.48.2026.10.13.02.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 02:33:11 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v5 10/13] drm/client: splash: take the background colour from
 the image source
Date: Tue, 13 Oct 2026 11:32:40 +0200
Message-Id: <20261013093243.505776-11-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261013093243.505776-1-maximpedraza@gmail.com>
References: <20261013093243.505776-1-maximpedraza@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

A logo designed for a light background looks wrong framed in black, and
products that share a board support package differ in their colours as
much as in their logos. The background colour belongs with the image,
so take it from the same place:

- a device tree image uses the optional "background-color" of its node;
- the BGRT carries no colour, and firmware splashes sit on black, so it
  uses the kernel's default;
- the BMP loaded as firmware is named on the command line, and so is its
  colour, through drm_client_lib.splash_color, which also covers the
  screen when there is no image at all.

CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR remains the default wherever
the source says nothing. The command line no longer overrides a device
tree image: a bootloader that wants another colour for a given boot,
say to flag a failed test on a production line, changes the node.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/Kconfig      |  7 ++++--
 drivers/gpu/drm/clients/drm_splash.c | 36 +++++++++++++++++++++-------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index aef3781cc110..f471019bab87 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -105,8 +105,11 @@ config DRM_CLIENT_SPLASH_BACKGROUND_COLOR
 	help
 	  The default splash background color, in RGB888 format.
 
-	  The color can be overridden through the drm_client_lib.splash_color
-	  kernel command line parameter.
+	  The background color comes from the same place as the image. A
+	  device tree image can carry its own, and the drm_client_lib.splash_color
+	  kernel command line parameter sets it for a BMP loaded as firmware,
+	  or for the whole screen when there is no image. This color is used
+	  otherwise, and always with the BGRT image, which carries none.
 
 config DRM_CLIENT_SPLASH_SRC_DT
 	bool "Device tree as splash source"
diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index fdf398987007..463aff27c747 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -42,7 +42,8 @@
 
 static unsigned int splash_color = CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR;
 module_param(splash_color, uint, 0400);
-MODULE_PARM_DESC(splash_color, "Splash background color (RGB888)");
+MODULE_PARM_DESC(splash_color,
+		 "Background color (RGB888) around the BMP loaded as firmware, or of the whole screen with no image");
 
 #if IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP)
 #define DEFAULT_SPLASH_BMP "drm_splash.bmp"
@@ -133,6 +134,8 @@ struct drm_splash {
 	s32 off_x, off_y;
 	/* One of DRM_MODE_ROTATE_*: turns the image, not the screen */
 	unsigned int rotation;
+	/* RGB888, from the same place as the image */
+	u32 bg_color;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -271,12 +274,18 @@ static struct device_node *drm_splash_dt_node(struct drm_splash *splash)
 	return NULL;
 }
 
-/* The optional placement properties of the node, read once */
-static void drm_splash_dt_placement(struct drm_splash *splash,
-				    struct device_node *np)
+/* The optional properties of the node, read once */
+static void drm_splash_dt_props(struct drm_splash *splash,
+				struct device_node *np)
 {
 	u32 val[2];
 
+	/* The colour travels with the image, or it is the kernel's default */
+	if (!of_property_read_u32(np, "background-color", &val[0]))
+		splash->bg_color = val[0] & 0xffffff;
+	else
+		splash->bg_color = CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR;
+
 	if (!of_property_read_u32_array(np, "logo-position", val, 2)) {
 		splash->pos_x = (s32)val[0];
 		splash->pos_y = (s32)val[1];
@@ -365,8 +374,8 @@ static struct device_node *drm_splash_dt_node(struct drm_splash *splash)
 	return NULL;
 }
 
-static void drm_splash_dt_placement(struct drm_splash *splash,
-				    struct device_node *np)
+static void drm_splash_dt_props(struct drm_splash *splash,
+				struct device_node *np)
 {
 }
 
@@ -780,13 +789,22 @@ static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 
 	np = drm_splash_dt_node(splash);
 	if (np) {
-		drm_splash_dt_placement(splash, np);
+		drm_splash_dt_props(splash, np);
 		of_node_put(np);
 		return DRM_SPLASH_SRC_DT;
 	}
 
-	if (drm_splash_bgrt_available(splash))
+	/* The BGRT carries no colour: firmware splashes sit on black */
+	if (drm_splash_bgrt_available(splash)) {
+		splash->bg_color = CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR;
 		return DRM_SPLASH_SRC_BGRT;
+	}
+
+	/*
+	 * The BMP loaded as firmware is named on the command line, and so is
+	 * its colour, which also covers the screen when there is no image.
+	 */
+	splash->bg_color = splash_color & 0xffffff;
 	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
 		return DRM_SPLASH_SRC_BMP;
 
@@ -844,7 +862,7 @@ static int drm_splash_render_thread(void *data)
 
 			if (!scanout->bg_drawn) {
 				drm_dbg(client->dev, "draw background for scanout %d", i);
-				u32 color = drm_draw_color_from_xrgb8888(splash_color,
+				u32 color = drm_draw_color_from_xrgb8888(splash->bg_color,
 									 scanout->format);
 				drm_splash_fill_solid_color(scanout->buffer, color);
 				scanout->bg_drawn = true;
-- 
2.39.5

