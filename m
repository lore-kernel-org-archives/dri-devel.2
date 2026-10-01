Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B57CA5FD4
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 19:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDF1610F77A;
	Thu,  1 Oct 2026 19:59:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p7tk1yfb";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B42BA10F779
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 19:59:11 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-488811c9ebaso3686574f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 12:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790884750; x=1791489550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RA+5l49YL1R26v92bmYI09ptxDfVsC8dW7PotI97hnM=;
 b=p7tk1yfb4DEu8NP9IO3FI3OnvOZTL4BBNfPh3rOvz/ic+AncCX/gcWN+lhX71q5p/y
 aEZbSOhu2SmutW5vX9zERA3EeEfZbqJbZf78ySu7LgkEnMQxrA3Xj/ovWtQ8/fYKpHRP
 nf7YeHNcuwrLILp/KU5MDUgQTgGWpzADSHI50UbvftTHSpE8P48CThYwgaoJVhEEeLwv
 5Z6u5WCvaAZnN0U8BxTys31xUssvno7iPC9ySMY9dTP6V5UDAn3gvU0///9cMgTgcCAo
 whP2U7/gwZFvooCUNsb8HtMBvAsDy/rR7Qb53X4X1uqY4hnwrdDu/6nGaLc6y/1/vP46
 n7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790884750; x=1791489550;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=RA+5l49YL1R26v92bmYI09ptxDfVsC8dW7PotI97hnM=;
 b=Hxb4k8V4VMR55ybdk9OYMGIeKDdasdrXpKCRCcd22gRuSnqXrz7zTkrlDZaEGH09n9
 eOi2hCPd4zdi00i65F+8sKpXvw3MnV9Utf743zVmF1GEkKnBSc7w0kuo10iFIL1sgya4
 qFnNrq2OTBwMkiYYBeOya3Bs20wBm9hJgn8GfzWl5kIiihn2ZUBmMieVe098bICNfxy8
 I/MbFvvGQjmVcCGQEEpPYlTdAq3JGwsQc/ly/6ptTJmuKU3qP8oZN9Qcfj/dRWxlyLfM
 R3haYs6uCAxRARz5OR0X+1Xc0XfdTW8W07Cm1RjSNOQ4oCaPW8r7sRi6C41DTEUmd/Kl
 lDUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxrm+sxvHqXqQ1tulIHANMK/SjJVfcVAbaAwFNeyT1aeHESt8lkY5IrVVmB7LluHKbXfmWbnkD8+5I=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lPxIs0nyMED53d7ewTgGDqQMSDzQfX2JEk5jA4NNd3qjYVnFgl
 361AkAy2RneHDZoRwSKjFS5qOu6lYpcPLS6SyhA5ciBhLmcihp9RIMDD
X-Gm-Gg: AYBFou1sAx5vGx3GldBOMYsTa49PoK1h66LGQZqE/ogxfPFFv9k00CUa7k6pnsP6SUX
 FWFt5C+yUPybRZFjay3N/RQw2KL29QoIg+h5J5O+oZWC9x2bAKdIaFpPN4iBtluBXe2UCAuo6tR
 3ca3yHUv2HCM76v1M55lffsvrabjVPQSimNYvNHkijR4PuIecyjvxC1e28Fau0fCj9yUgMiSoZ0
 SzHYGYRfyv8/c/lf2EnCwfHofY2R2Yo0bvYBOCGaWB8CIYWzHrIraFJQXt8hpZsi0XIgZcOcbqR
 MC0gXBCFXarx/S0jFsf1ZX1hndYe6cLFhKkOVoIt2JRc2FwvRzDFqm9tUyHKjYnHomMv0hU6N2W
 3lVY1tX8vVhBfrQrU9m/HPRcF2H7wLDm4IeIFdyEfBQ/1Uxz8kMaFfH6r5VKRGDa6Zwe8XrQ5AD
 R2nqUguohKfuLvxvaxOUx/JOdu6p0KM6NRb4dtAiD9W7ym03Znczeg0Hv4MoC98p1zbZ61kboXF
 2ocDgiyKUpkOMbLHd1g6GAQA+AeNAuKOUvK
X-Received: by 2002:a05:600c:3152:b0:49e:7c8c:361d with SMTP id
 5b1f17b1804b1-4a027584bc4mr11324875e9.22.1790884749758; 
 Thu, 01 Oct 2026 12:59:09 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.112.15.218])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0276f92d9sm15031045e9.4.2026.10.01.12.59.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 12:59:09 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
Cc: Francesco Valla <francesco@valla.it>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH RFC v4 10/13] drm/client: splash: take the background colour
 from the image source
Date: Thu,  1 Oct 2026 21:58:44 +0200
Message-Id: <20261001195847.141192-11-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261001195847.141192-1-maximpedraza@gmail.com>
References: <20261001195847.141192-1-maximpedraza@gmail.com>
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
index 924bc0032d1d..30ba6573424e 100644
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
@@ -131,6 +132,8 @@ struct drm_splash {
 	s32 off_x, off_y;
 	/* One of DRM_MODE_ROTATE_*: turns the image, not the screen */
 	unsigned int rotation;
+	/* RGB888, from the same place as the image */
+	u32 bg_color;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -263,12 +266,18 @@ static struct device_node *drm_splash_dt_node(struct drm_splash *splash)
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
@@ -357,8 +366,8 @@ static inline struct device_node *drm_splash_dt_node(struct drm_splash *splash)
 	return NULL;
 }
 
-static inline void drm_splash_dt_placement(struct drm_splash *splash,
-					   struct device_node *np)
+static inline void drm_splash_dt_props(struct drm_splash *splash,
+				       struct device_node *np)
 {
 }
 
@@ -801,13 +810,22 @@ static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 
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
 
@@ -865,7 +883,7 @@ static int drm_splash_render_thread(void *data)
 
 			if (!scanout->bg_drawn) {
 				drm_dbg(client->dev, "draw background for scanout %d", i);
-				u32 color = drm_draw_color_from_xrgb8888(splash_color,
+				u32 color = drm_draw_color_from_xrgb8888(splash->bg_color,
 									 scanout->format);
 				drm_splash_fill_solid_color(scanout->buffer, color);
 				scanout->bg_drawn = true;
-- 
2.39.5

