Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F374606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AGPMxSsD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F74210F57F;
	Tue, 27 Oct 2026 13:55:02 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0265710F572
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:15 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so20101585e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793109253; x=1793714053; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IMpToc8GUbpePaS/6DB+RjKW/EgdDLHWVJxbsQxIDG0=;
 b=AGPMxSsDjjKnJS/Ja/uPE44QaCbc7MWKSZfn4d0s4P3OUzJWqMUEW5YS9yRcI7MKZh
 LjHhIKwIxsQko+1s2OGZ7yCLjLyiFTB7XaobNlIgFFDenXgXpZes6rS9G7GkKaBaMuUJ
 a1UYkUmyxokS0SUYn4Svms/UCILcz71gXbPagJPF+S48PHbo78/PoEw7f6sU16RzWJV5
 bLvhE6ZNZCGYA/nJQQe9kDQj4cW4AZZSjtyn2UZNVYZQYCbLjMkJI05er2FWlT4YwZhC
 vzmX90kf6tkd38zqh2JagsWOxeTd75ZodP48AvtwHfiMlI1tukzP0icoslzFBb98tb0o
 P/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109253; x=1793714053;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IMpToc8GUbpePaS/6DB+RjKW/EgdDLHWVJxbsQxIDG0=;
 b=mxdjNxkOs7OmZLh9djVfD/POCdrEsqVqVzp1QdKfceo1d9/kPJbhNzz64z2dlVnnJt
 pD2S9T0l8gL9rWBjQKSQ43BOuMVaqJU9r0a5xVl7y8kmHCjSQFwINBBCG4b7RktH7hhm
 nOoTWHb3DRMJP6ThIJQq5cBLcb9uHx6ZcQoVMTt0e19q03hQlV0Vchbog9IJQFl+HqpT
 g0AQZJScE8OiTeTr5DHe8EgoPImtjhxVVt7FFYswxpo9dRNVA0Ujk5eTguFSRcElTC5+
 Qig4Af3QsZSXO3e+81fVPldYS/MXUVohCvSlcPtfjeXH98XuTShzxuGNohu5i/q5JNpK
 0hQw==
X-Forwarded-Encrypted: i=1;
 AKwUvBweOSnmLRlpZNFCxDJg93sjpx/LvPxU1qcLJbWcMB6x8NvGT7g+lk8TQ7RxchaiVYR6C7cZ9cQAPKw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIyRv8Dz5vChDvcOxia2iz9Blg5vsKx9fxhDU7yb5eaqGI5JHn/
 CkTqKp7hTmgWKAUVfRCZKfZH4zb8k3PJZ7XsNeqANGOEUGRtTz8Anx9EylEdYmau
X-Gm-Gg: AYBFou2pPdUVBQys2wPSwAiq3K7icCpsMpdSm5j7p2ES5RIjiKu+KBvWPFoN+qIDeHx
 R8kP8QKdZdC9Zkfux90ZfXXs809+5vSyUGPFFoqsHFCIiHY1z4VrwopAVP5vkYOgLXAiv1nkh/i
 4lqthemrFQVY43e9NRbxOV87yqmcwzxK65CjELne1KuP8m1OQyHe/ZnxTRghc1uBt79DoCdyJXk
 VSBlqFNKn0wrN+Bx5CfrHbrXnKVFlOZCAYAt7ZIXqq0xH6OhrzC1EfoDV3wd/jTPR2Qp5Il23fs
 Mb8Ez8vJa8bHpfAaFmMYvSCOFQvLO+4aYINrvtYTjmWxcepsO/5mh+AjS++36+0z/C0fF/KMc4M
 JKspQp0h0VzBCZEpVid25JFo9BOhTFGMkEhYinpR55BhSpV2roeUw8VKxChLIJHC6TbIV6aXByj
 8z3xR9nTAElggDw/TO4hNZjYpFA2zKd/cBW9C7dtahQrviFvw6HXvm/ddQkdQ8CfFeRE+bvi5IC
 QOYyWJRBLaZwNZJavzxwZ4q86vv8iQO7b0BNQ1DymjYJs/h6+QrL1DLJPp5kF8Jwvsh2xv/Qt9M
 QBHnbwU=
X-Received: by 2002:a05:600c:6219:b0:4a1:de8a:603a with SMTP id
 5b1f17b1804b1-4a35ac80a9emr181345205e9.6.1793109253262; 
 Tue, 27 Oct 2026 06:54:13 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:54:12 -0700 (PDT)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Helge Deller <deller@gmx.de>,
 Peter Jones <pjones@redhat.com>
Cc: Francesco Valla <francesco@valla.it>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Jocelyn Falempe <jfalempe@redhat.com>, Sam Ravnborg <sam@ravnborg.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-efi@vger.kernel.org,
 linux-fbdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-embedded@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 12/15] drm/client: splash: take the background colour from
 the image source
Date: Tue, 27 Oct 2026 14:53:39 +0100
Message-Id: <20261027135342.2003632-13-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261027135342.2003632-1-maximpedraza@gmail.com>
References: <20261027135342.2003632-1-maximpedraza@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A logo designed for a light background looks wrong framed in black, and
products that share a board support package differ in their colours as
much as in their logos. The background colour belongs with the image,
so a device tree image takes it from the optional "background-color" of
its node. A value that is not one cell of RGB888 is reported and left
out.

CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR remains the colour wherever
the source says nothing, as with the BGRT, which carries no colour, and
the BMP loaded as firmware.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/Kconfig      |  3 ++-
 drivers/gpu/drm/clients/drm_splash.c | 33 +++++++++++++++++++++-------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/clients/Kconfig b/drivers/gpu/drm/clients/Kconfig
index 172781bbc2d7..bb5fe5019756 100644
--- a/drivers/gpu/drm/clients/Kconfig
+++ b/drivers/gpu/drm/clients/Kconfig
@@ -104,7 +104,8 @@ config DRM_CLIENT_SPLASH_BACKGROUND_COLOR
 	default 0x000000
 	range 0x000000 0xffffff
 	help
-	  The splash background color, in RGB888 format.
+	  The splash background color, in RGB888 format, unless the image
+	  source has its own: a device tree image can carry its color.
 
 config DRM_CLIENT_SPLASH_SRC_DT
 	bool "Device tree as splash source"
diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index a50036155763..3f54bec87413 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -117,6 +117,8 @@ struct drm_splash {
 	s32 off_x, off_y;
 	/* One of DRM_MODE_ROTATE_*: turns the image, not the screen */
 	unsigned int rotation;
+	/* RGB888, from the image source or the kernel's default */
+	u32 bg_color;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -272,12 +274,23 @@ static void drm_splash_dt_pair(struct drm_splash *splash,
 	*y = val[1];
 }
 
-/* The optional placement properties of the node, read once */
-static void drm_splash_dt_placement(struct drm_splash *splash,
-				    struct device_node *np)
+/* The optional properties of the node, read once */
+static void drm_splash_dt_props(struct drm_splash *splash,
+				struct device_node *np)
 {
 	u32 val;
 
+	/* The colour travels with the image; a bad one is reported */
+	if (of_property_present(np, "background-color")) {
+		if (of_property_count_u32_elems(np, "background-color") != 1 ||
+		    of_property_read_u32(np, "background-color", &val) ||
+		    val > 0xffffff)
+			drm_warn(splash->client.dev, "splash: %pOF: invalid %s\n",
+				 np, "background-color");
+		else
+			splash->bg_color = val;
+	}
+
 	drm_splash_dt_pair(splash, np, "logo-position", -1, 65535,
 			   &splash->pos_x, &splash->pos_y);
 	drm_splash_dt_pair(splash, np, "logo-offset", -65535, 65535,
@@ -375,8 +388,8 @@ static bool drm_splash_dt_open(struct drm_splash *splash)
 	return false;
 }
 
-static void drm_splash_dt_placement(struct drm_splash *splash,
-				    struct device_node *np)
+static void drm_splash_dt_props(struct drm_splash *splash,
+				struct device_node *np)
 {
 }
 
@@ -802,13 +815,17 @@ static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
  */
 static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
 {
+	/* Unless the source says otherwise, the kernel's default colour */
+	splash->bg_color = CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR;
+
 	if (drm_splash_dt_open(splash)) {
-		drm_splash_dt_placement(splash, splash->dt_np);
+		drm_splash_dt_props(splash, splash->dt_np);
 		return DRM_SPLASH_SRC_DT;
 	}
 
 	if (drm_splash_bgrt_available(splash))
 		return DRM_SPLASH_SRC_BGRT;
+
 	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
 		return DRM_SPLASH_SRC_BMP;
 
@@ -875,8 +892,8 @@ static void drm_splash_work(struct work_struct *work)
 			continue;
 
 		if (!scanout->bg_drawn) {
-			u32 rgb = CONFIG_DRM_CLIENT_SPLASH_BACKGROUND_COLOR;
-			u32 color = drm_draw_color_from_xrgb8888(rgb, scanout->format);
+			u32 color = drm_draw_color_from_xrgb8888(splash->bg_color,
+								 scanout->format);
 
 			/* Only success marks it done: a later pass retries */
 			ret = drm_splash_fill_solid_color(scanout->buffer, color);
-- 
2.39.5

