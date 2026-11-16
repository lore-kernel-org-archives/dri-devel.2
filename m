Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 041F3606A31F
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FOoKQ47I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 126DE10E33C;
	Sun, 15 Nov 2026 23:22:32 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9872710E1A4
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 23:22:16 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so17861795e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 15:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794784935; x=1795389735; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Erdyei72788KVv8pLaqul7iSgCQZTDqlNCfVWoF2cUc=;
 b=FOoKQ47IP4EYC5LlWqGndW3VhqXeLy8tFs42YhipS534nlhqK4op1RS74q9BfeCTz7
 ocBgkzhZif1y1JwBDTA9Nzj+fFcsDPqrEkR2b7tFzypjxvv7BvuGxQVZY6Gjl30BJ7O5
 vfI3+0INhKdcbq637H/djfc87geTw0ha+fIxLe9SqsShX3z7nF5I0SFh+tUMqUxWkIVY
 1ZZuKBAPmCbjfcH9u4SZcEI5VJ4sBHcELKARSnMRa8UgvEZUVOeKvfldJMTmuA5165wj
 cfO7cR9VKPFPJfr+S3kEr4Yav+gBU/vP1Y6z0YEW3kO8wWiR5By5CCSJSH1PmA2YG42a
 FOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794784935; x=1795389735;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Erdyei72788KVv8pLaqul7iSgCQZTDqlNCfVWoF2cUc=;
 b=nH2EGtBhZnTUdsmnNIWISD1XMNwueNRHfWXopcVzMyCkHZoIL03G98NR4MB9Rsb5IB
 6gn+0IGF5aTMkvYMmcaPdY/xB++Y6QINUGFLLjY4FlBlCBzIDffFFl/EhjZbsA3/FvI3
 veBQRuua3lPxVN3qIvu2tdNm5MukXrort1IBl0Bhs8n7CgqJT19+jkxcr3AIW2aUxdLu
 JS3NNkBg8y4Xl1bUOfdRcnj1vwBmHxaM2H+bPxv4iFUg1Z6dcZPw7Fk7HRSKukPlCVTl
 Lf7ciVkGf4vdY7QM1PMmHpsFw5Hbo6KXIfWIiN+Fg9RXZaOy/Hl1VOmsbDjYhXusuhJu
 Lf/A==
X-Forwarded-Encrypted: i=1;
 AL+hErGDNR0ya6zL55x8V48MVf/yKjNq31RTfNBzMrvIR2lJL34HnsYitE6omJzfVAGmpKX2ndcIV8HA25o=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9svAF/do0Mk4CtKuSRG0+s+sUiZTQwKDjtDg3bQ06UMKmnKEiC
 63+2uxDHgQdqV3Zp4qCueWmU4rt7dyYmvae6lEL/pBRSE9m2czoB3QJu
X-Gm-Gg: AYBFou1q43Dogi9iMvdcJtCMDT2bkcvrbg74sFpp5kbzONYI+mFmbuA4ybb6ZBYsTZY
 umaS75h6QsMcZ/mZB4siz1pu93cn8OJI+8h89C1q48wCg0dqh0CX3bGHnVCE/lspCFrOsAdunLn
 WhShwM0/gqqLahMvldiQuD09N10wDbuZAbq6S1ljpFpsC5IKOicP2jA456Fb7L0MHKrilmgRIgb
 K9zNzVlsUqU/K643ecH/LdOWQqpKsKDJB7Ex7mbNjDG4d2zRVx1PeSrJxJmi/SckkOURCWnMCdJ
 Oxb4Gx5oMkj3X3zE2T9Fhs/m8WZhKnSZRypAmSvqeemrKeHVdz/xfV3d8Ka1dAloSCVD8N1Rb+R
 AyVOFq9wOOKxPGsUBE3Ogj1yvdxT25Q4Wf1Lp/bDdJ2gzM01cAapVNITo1oP6seKyNURSwq6fdE
 OKlRuEaVZZYRc7idl9PseiN/da7KqrrKie+CFbk246ht6dhEofSm4Ywye56vZklMGK4S42krRIh
 gn2N6jorWh3giRN/krY3MpT1XlKUErpzY1d8JzxMW5RZtiDPtOiDVK7tx7Z/UQIBD3FTFZDZDzv
 Kmqfee91VniVzt8mgKK875qJDURVjKvlxODfIFXbzM7PJ5aVokssDBA=
X-Received: by 2002:a05:600c:3509:b0:4a1:dbdf:17a8 with SMTP id
 5b1f17b1804b1-4bb559f2cc3mr183275325e9.2.1794784934909; 
 Sun, 15 Nov 2026 15:22:14 -0800 (PST)
Received: from ingenieria31.oficinasStQ.local ([79.117.0.220])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb571f976esm127920955e9.3.2026.11.15.15.22.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 15:22:14 -0800 (PST)
From: =?UTF-8?q?M=C3=A0xim=20Pedraza=20Padilla?= <maximpedraza@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ard Biesheuvel <ardb@kernel.org>,
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
 linux-efi@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-embedded@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v7 6/6] drm/client: splash: pick the image source in one place
Date: Mon, 16 Nov 2026 01:21:56 +0100
Message-Id: <20261116002156.1027726-7-maximpedraza@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261116002156.1027726-1-maximpedraza@gmail.com>
References: <20261116002156.1027726-1-maximpedraza@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The client chooses between two sources with a boolean: the BGRT if the
firmware left one, otherwise the BMP loaded as firmware. A third one is
coming, and with it an order of preference that a boolean cannot hold.

Name the source in use with an enum, picked once by
drm_splash_pick_source(), and have drm_splash_image_load() switch on
it. No functional change.

v7:
- DRM_SPLASH_SRC_FW for DRM_SPLASH_SRC_BMP: the BGRT is a BMP too

Suggested-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Màxim Pedraza Padilla <maximpedraza@gmail.com>
---
 drivers/gpu/drm/clients/drm_splash.c | 46 ++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_splash.c b/drivers/gpu/drm/clients/drm_splash.c
index d54cf628cf17..fbbdc034e417 100644
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
+	DRM_SPLASH_SRC_FW,
+};
+
 struct drm_splash_scanout {
 	int id;
 	/* Modesets scanning this buffer out, by position in the list */
@@ -91,7 +101,7 @@ struct drm_splash {
 	const struct firmware *fw;
 	void *map_data;
 
-	bool use_bgrt;
+	enum drm_splash_source src;
 };
 
 static struct drm_splash *client_to_drm_splash(struct drm_client_dev *client)
@@ -439,7 +449,7 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 		return -EINVAL;
 	}
 
-	if (splash->use_bgrt) {
+	if (splash->src == DRM_SPLASH_SRC_BGRT) {
 		x_pad = efi_bgrt_image_offset_x();
 		y_pad = efi_bgrt_image_offset_y();
 
@@ -509,13 +519,31 @@ static int drm_splash_bmp_to_scanout(struct drm_splash *splash,
 static int drm_splash_image_load(struct drm_splash *splash, const u8 **img_data,
 				 size_t *img_data_len)
 {
-	if (splash->use_bgrt)
+	switch (splash->src) {
+	case DRM_SPLASH_SRC_BGRT:
 		return drm_splash_bgrt_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_FW:
+		return drm_splash_fw_load(splash, img_data, img_data_len);
+	case DRM_SPLASH_SRC_NONE:
+		break;
+	}
 
-	if (!IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_FW))
-		return -ENOENT;
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
+	if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_FW))
+		return DRM_SPLASH_SRC_FW;
 
-	return drm_splash_fw_load(splash, img_data, img_data_len);
+	return DRM_SPLASH_SRC_NONE;
 }
 
 /* At unregister, once nothing else can use the image */
@@ -858,10 +886,10 @@ static void drm_splash_rebuild(struct drm_splash *splash)
 
 	if (!splash->source_picked) {
 		splash->source_picked = true;
-		splash->use_bgrt = drm_splash_bgrt_available(splash);
+		splash->src = drm_splash_pick_source(splash);
 
-		/* If no other image has been loaded, try to load a BMP as firmware */
-		if (IS_ENABLED(CONFIG_DRM_CLIENT_SPLASH_SRC_FW) && !splash->use_bgrt) {
+		/* The BMP loaded as firmware is the only source that arrives later */
+		if (splash->src == DRM_SPLASH_SRC_FW) {
 			ret = drm_splash_fw_request(splash);
 			splash->fw_requested = !ret;
 			if (ret)
-- 
2.39.5

