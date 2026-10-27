Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9905A606A31D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=j1LJPeJO
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 009F110F583;
	Tue, 27 Oct 2026 13:54:58 +0000 (UTC)
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8033410F570
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 13:54:06 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-48df4f540ebso2078854f8f.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 06:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793109245; x=1793714045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x3TRWoAym08EDkUmxJbEElxgHRIsBB4gzy6Y/BELf6M=;
 b=j1LJPeJOYAVI3oi8YBF+kp7heDcTl6v70dRtjEarkJQU7354iSf5hQYLXenDIxu7Nz
 OC7zWvmNV5GUU9M7aNaB/ZwXZuYmPwVXRx5zlFvPq2ae5OeaSR+Nj7xpoATYnJ4ZN2+Q
 ocpEG1cgiICI/jIZZGP4k+clGTQ28CmCE0iCEs8JKldDdrB03HC+9Xd9JFnw3rQX8wON
 K0sqyD9JpPyfmk8kr4CbcRPeWwnjt+DeRgcUzUygA3JUPZGDC7gqkCl8Us+L+TlTfjTN
 YZzwSFgNugjyCwlXsN4ZXQsF8eMqdzCQX0KHdjt5SH+3QzvqVteGHI5PclvVI4OKS8Z4
 hHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793109245; x=1793714045;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x3TRWoAym08EDkUmxJbEElxgHRIsBB4gzy6Y/BELf6M=;
 b=j27D4COf+dqxa+tpJX4KpeOTXS/WxCIA8l4PzAAxP5TCL22oUxdHJ6t8Sp/KAeEZr7
 8S3KKYZZj5iqpMLIZ+kEljQWpcQ/9UtvMilE4r7nK1CztC4OsoCHYJRr09gtRid11M+2
 soa99G07BRG6GO1EfGCP/bZ1dMh6k/l0CrsiL2waMJ+WZ5wf8V4+VE/YVW3bKLcR6/If
 bDklApQe3pDpiLAFcMHmIqDjfNU2U9GJMziUplGtcwmjPZTxuftrtdJaL5yydDu1To5x
 PaRNnhq4pg0FhXvGbZWMlcqNz+7UfpMYozcpuVmCWms92EnvVLKM2D0NcysIgik98Emz
 /7tA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxx+Kl01JOG6etNVpRJFEqq7n4IBvN6pYihapNqsLaWEV/ckhtyrdYtc9vj3I9Z3yybDjOAdZRPjP4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKIRtnJzvdZ6CE2psf436CheHk3YGOO0WKa/hJh8Y8NBJLRbGKQ
 6WLWyqoQGkeY10APDtqLsBqghiZj8+HawzRKhIi9OGpvVSt+lkqUrK7U
X-Gm-Gg: AYBFou3IwAI41V3ZgZ5n58/C4Ssj+ZTHLiNe8DtY3Np1W9EqhREq4w44LR2w3HaXFC5
 hB8fN4ojWpq5JriGM8RcbfJCMFbxXY0kHYSXL9Dm7CDySM9eaJlq+11FYvMaARv4cPG1m9bi1Zs
 23cyoGjxJ21Zs1zt6QFXLW1aaXVdUsk5GrS7I7qc+UcJuhJSk4JRCXh6+EHwXrT2QHQ/dGJUqjW
 jC/nwnjH/klHG0nHDnQ927t1D4ThnoPTGLqaNDnUkaRj/YrSpDrqtwTC7NEQ+RZ0PujWpHkGIvn
 FWrJevFITefaqlRsK4aT3FGhCqgV+xIdiClX6nPpoV5E5H3YUmqh3hNeHkknP8GqMfotcT26VRo
 CtybtkcZRy0DMd1wVGusjPieTCenzARRhqfjBvkHCFFfIiL60ojK+XNZ+YoVgFOZdZZjMXAwlKZ
 Ci2GWn5l99cVCqNaBIPmr5Q/6zqXM2MJjnGEoKb/+gLOlDeoC8L3H/na5shI/o2IsyotZxIUTRz
 U3YbLf6ZP0dLSxKAXlFvsEO+dBsZuDQphSpMW7uRZDtQbd1Z0QzSvzamYyWsQ0BpFblSeFjGgiM
 R0NdzayvSqBa18HbPC8by+ObuX9F
X-Received: by 2002:a5d:5d10:0:b0:48e:1c72:abc with SMTP id
 ffacd0b85a97d-48e3eb9890amr18924302f8f.35.1793109244645; 
 Tue, 27 Oct 2026 06:54:04 -0700 (PDT)
Received: from ingenieria31.oficinasStQ.local ([79.117.46.175])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebcb846sm23128058f8f.25.2026.10.27.06.54.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 06:54:04 -0700 (PDT)
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
Subject: [PATCH v6 08/15] drm/client: splash: pick the image source in one
 place
Date: Tue, 27 Oct 2026 14:53:35 +0100
Message-Id: <20261027135342.2003632-9-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The client chooses between two sources with a boolean: the BGRT if the
firmware left one, otherwise the BMP loaded as firmware. A third one is
coming, and with it an order of preference that a boolean cannot hold.

Name the source in use with an enum, picked once by
drm_splash_pick_source(), and have drm_splash_image_load() switch on
it. No functional change.

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 45 +++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index 337c7160c4a1..911149b92a52 100644
--- a/drivers/gpu/drm/clients/drm_splash.c
+++ b/drivers/gpu/drm/clients/drm_splash.c
@@ -39,6 +39,16 @@
  * a static image.
  */
 
+/*
+ * Where the image comes from. drm_splash_pick_source() sets the order of
+ * preference; NONE is zero, so that a new splash starts without a source.
+ */
+enum drm_splash_source {
+	DRM_SPLASH_SRC_NONE,
+	DRM_SPLASH_SRC_BGRT,
+	DRM_SPLASH_SRC_BMP,
+};
+
 struct drm_splash_scanout {
 	int id;
 	/* Modesets scanning this buffer out, by position in the list */
@@ -87,7 +97,7 @@ struct drm_splash {
 	const struct firmware *fw;
 	void *map_data;
 
-	bool use_bgrt;
+	enum drm_splash_source src;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -429,7 +439,7 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		return -EINVAL;
 	}
 
-	if (splash->use_bgrt) {
+	if (splash->src == DRM_SPLASH_SRC_BGRT) {
 		x_pad = efi_bgrt_image_offset_x();
 		y_pad = efi_bgrt_image_offset_y();
 
@@ -498,10 +508,31 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
 				 size_t *img_data_len)
 {
-	if (splash->use_bgrt)
+	switch (splash->src) {
+	case DRM_SPLASH_SRC_BGRT:
 		return drm_splash_bgrt_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_BMP:
+		return drm_splash_fw_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_NONE:
+		break;
+	}
+
+	return -ENOENT;
+}
+
+/*
+ * Pick the one source the image will come from: the BGRT is whatever the
+ * firmware shows, and the BMP loaded as firmware is the fallback. With
+ * neither, only the background colour is drawn.
+ */
+static enum drm_splash_source drm_splash_pick_source(struct drm_splash *splash)
+{
+	if (drm_splash_bgrt_available(splash))
+		return DRM_SPLASH_SRC_BGRT;
+	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP))
+		return DRM_SPLASH_SRC_BMP;
 
-	return drm_splash_fw_load(splash, img_data, img_data_len);
+	return DRM_SPLASH_SRC_NONE;
 }
 
 /* At unregister, once nothing else can use the image */
@@ -818,10 +849,10 @@ static int drm_splash_client_hotplug(struct drm_client_dev *client)
 
 	if (!splash->source_picked) {
 		splash->source_picked = true;
-		splash->use_bgrt = drm_splash_bgrt_available(splash);
+		splash->src = drm_splash_pick_source(splash);
 
-		/* If no other image has been loaded, try to load a BMP as firmware */
-		if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_BMP) && !splash->use_bgrt) {
+		/* The BMP loaded as firmware is the only source that arrives later */
+		if (splash->src == DRM_SPLASH_SRC_BMP) {
 			ret = drm_splash_fw_request_bmp(splash);
 			splash->fw_requested = !ret;
 			if (ret)
-- 
2.39.5

