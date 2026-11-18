Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1889D606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=EOGcFY4V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 578AE10FB9B;
	Wed, 18 Nov 2026 12:09:14 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F035E10FB96
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:43 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso8454975e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003722; x=1795608522;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7lyFqQrXWRZ3oCiHbsJIHHcwRpj8pUcv2Zf39Z6A+T4=;
 b=EOGcFY4VEtkEioWL7es69W+G/ce7RUeHRJPn5Yu+8lQnrPf6Jxx/4eIKvxNThs2M+m
 Ux7rSrqv/b4qTnCHDk+Rv0V1IMDIGd9fKedKEdGv1vD18nGVOtnPf84b/l1Ahag4+2JZ
 mQXvI2uSorGWbL4/8dV26FHTO2wl6oxF8n/sUd8wJlIay66rIgtjGVaWUlvRcUpwI9PV
 vIk6Cs2maGkIn007P3NLr7WieVaJAD8AxFO0rLutvOkCeMGJ63FbHDcsI/4VW3aatiUn
 0tW5+rZTQzCwk0Dd6vt+P359LOWe3ABK9WsWEEptTil6CS1f2n/clcwx9fGX+g54EiAE
 kX5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003722; x=1795608522;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=7lyFqQrXWRZ3oCiHbsJIHHcwRpj8pUcv2Zf39Z6A+T4=;
 b=HoYxWJocsT1mHZ3fbac0kAfBCjqrpoT3gvpQLWTMXZier83/c+9uVTSTwN+cIRfSUK
 R18Jx2PzDl43SzEIA+aGXvGivfDIrQNJEpipoAdceL3evcUEOIFMlu5+ZTkq9QfrwZZl
 qv3UMyd1rW5a3erlFARKT+qrPLp/qfKQsYFeFSplJguDS8ncFVxr9zzRFXYsT6ZKRjnW
 TOt/prr9615TgcC6C0pjxyxmwQkFcsaGcu/JNXiEFTN9KAed0Y36+FCpG4FD2tHytzfn
 2hp5cQuSMXtb93Eae+++I5JawFDum5pNylQw3QkGTRBworklx6/LQtmux4JLNzlPuPdJ
 If7Q==
X-Forwarded-Encrypted: i=1;
 AL+hErG9zaae80qYIMq1K2u68Akg/T9Vv5Cg/5SCuQYLmejNXnNuitbVv9n6alF+WdN+k3LFu6LdUrsocy0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+jz7o0abkGXAvm3h/4VyMWxi50WTz2yRjc7l8MC8G/KSIeIJz0
 wh3ojJpHrPubaGGohX7vQTTJerNITLffLrOthkKaUE85Szn/6tDd9tWI2bUE+oVKtKk=
X-Gm-Gg: AYBFou0kIsMt2vbjmYRrEpxfBUHgUr7hoRv/KfUqaVTqGevi/lF49DWXJnOgnPOIZIG
 smePg1s3yJGd5UFxGZbYHL/EN/jrtCFBaL0uINVXtTV+pMPxQ+iRCZld8OTs1yFm/i16Pl+dGJV
 kTdBOtXR7JB64Vo51r9eq6xApOM+QtQFrRKOSmQqUxfGwoj3O8f1fbMwhu75kBzJKu0OPUU+lRa
 HXGfdwWuZB7Ub2UaDX4PMCfO3pxvll5qiMS4louVl1vxtUs5dnIdTNAmA5MES0JZ6gwUAqQ4d32
 xwdFvyUG03NLVaF1O+xISHqiaoS5BMuF6jRA2LPEHh6mdBMHKUa0vgDV4sW1NOeEoJbU1Fd/1gJ
 ak5nXwlj3dgBZH4l/QAaSSfPBLfRBRiYju31fed/lbWbdpDjFYgLWYQQpQyYheTbZEU1gPLowcn
 udPAhIR2D2Z/M4vtuxkopKqOb5zdD6dx1bMlpq/eswXuTreyWmd2fXOQ74KDxf2BGaXJKOY87F5
 mlwAUIV1LnfCGPnpAqx7Mrjbpx+npvYxGqxgjtSYpiW1BX/zEY5Lu9QHngeaup1A9O2YFr3vpVP
 PTr2UgeuUzTDn5Yb+Kublx0f7OWNRP3czYX6799fw53PdysUkfW3tu/0jGzalzv5h/2RnLBcWQw
 74kXiKQCaKD34lN0=
X-Received: by 2002:a05:600c:3b1f:b0:4a3:5a91:5f61 with SMTP id
 5b1f17b1804b1-4bb7da1c904mr44324145e9.14.1795003722316; 
 Wed, 18 Nov 2026 04:08:42 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4a655f9f4a7sm4586550f8f.34.2026.11.18.04.08.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:41 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Alex Lanzano <lanzano.alex@gmail.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 6/9] drm: Use designated initializers for of_device_id
 arrays
Date: Wed, 18 Nov 2026 13:08:13 +0100
Message-ID: <c157d2e858e783956f47862ef45986d71c72a56d.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4930;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=bbrRtyBALXG8GeCOHosUg/FB7Q1zsg8R85YwED6yNLo=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZU2wuru++dxy9EFg2Tvjzg3G90QU+4TB/j6T
 IPXy8RBUlWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VNgAKCRCPgPtYfRL+
 TvsvB/9rXcYN7y4fODqSKg/wvub5DtHZgVbnwQz4P9NfOwXVa641OIA+ZRV33ABEZTazDe1y84J
 D4zgtZI2XPm0KIEdnG6aUtDqmCq0n7DCYe1ZHW33sDEXIEmAqhlRZpE/d3/WyTZ6kI4JtO2PqBk
 LTghLEcnCogGFloCK6gqn3Fp18Q9Nt3xAS1oQF7VAU9TQmvQbBHvLrUqFj52zbb7lJHkv7kD9eC
 cFiDxQB54E8LpIUnCt+z+1zcqsAqDaVCu6d2cdcHit0n5U4ElxzISgY/NkrXPtdmqEDqtZk2A2d
 lFMHPt6vaFzboqGZuBFb4r98XvjpzwwsHy99IicM/Lbsn5ty
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Named initializers are better readable and more robust to changes of the
struct definition. This robustness is relevant for a planned change to
struct of_device_id replacing .data by an anonymous union.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/panel/panel-dsi-cm.c          |  4 ++--
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  4 ++--
 drivers/gpu/drm/tiny/sharp-memory.c           | 20 +++++++++----------
 drivers/gpu/drm/vc4/vc4_dsi.c                 |  6 +++---
 4 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index ae6e9ffc46cb..99ccf3badde7 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -628,8 +628,8 @@ static const struct dsic_panel_data droid4_data = {
 
 static const struct of_device_id dsicm_of_match[] = {
 	{ .compatible = "tpo,taal", .data = &taal_data },
-	{ .compatible = "nokia,himalaya", &himalaya_data },
-	{ .compatible = "motorola,droid4-panel", &droid4_data },
+	{ .compatible = "nokia,himalaya", .data = &himalaya_data },
+	{ .compatible = "motorola,droid4-panel", .data = &droid4_data },
 	{},
 };
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index acc560dc5ea5..bdbe1fe9c879 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2924,8 +2924,8 @@ static const struct of_device_id ili9881c_of_match[] = {
 	{ .compatible = "wanchanglong,w552946aba", .data = &w552946aba_desc },
 	{ .compatible = "waveshare,7.0-dsi-touch-a", .data = &waveshare_7inch_a_desc },
 	{ .compatible = "ampire,am8001280g", .data = &am8001280g_desc },
-	{ .compatible = "raspberrypi,dsi-5inch", &rpi_5inch_desc },
-	{ .compatible = "raspberrypi,dsi-7inch", &rpi_7inch_desc },
+	{ .compatible = "raspberrypi,dsi-5inch", .data = &rpi_5inch_desc },
+	{ .compatible = "raspberrypi,dsi-7inch", .data = &rpi_7inch_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ili9881c_of_match);
diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index 861dd81a8e5b..e3367e433a2e 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -435,16 +435,16 @@ static const struct spi_device_id sharp_memory_ids[] = {
 MODULE_DEVICE_TABLE(spi, sharp_memory_ids);
 
 static const struct of_device_id sharp_memory_of_match[] = {
-	{.compatible = "sharp,ls010b7dh04", &sharp_memory_ls010b7dh04_mode},
-	{.compatible = "sharp,ls011b7dh03", &sharp_memory_ls011b7dh03_mode},
-	{.compatible = "sharp,ls012b7dd01", &sharp_memory_ls012b7dd01_mode},
-	{.compatible = "sharp,ls013b7dh03", &sharp_memory_ls013b7dh03_mode},
-	{.compatible = "sharp,ls013b7dh05", &sharp_memory_ls013b7dh05_mode},
-	{.compatible = "sharp,ls018b7dh02", &sharp_memory_ls018b7dh02_mode},
-	{.compatible = "sharp,ls027b7dh01", &sharp_memory_ls027b7dh01_mode},
-	{.compatible = "sharp,ls027b7dh01a", &sharp_memory_ls027b7dh01_mode},
-	{.compatible = "sharp,ls032b7dd02", &sharp_memory_ls032b7dd02_mode},
-	{.compatible = "sharp,ls044q7dh01", &sharp_memory_ls044q7dh01_mode},
+	{ .compatible = "sharp,ls010b7dh04", .data = &sharp_memory_ls010b7dh04_mode },
+	{ .compatible = "sharp,ls011b7dh03", .data = &sharp_memory_ls011b7dh03_mode },
+	{ .compatible = "sharp,ls012b7dd01", .data = &sharp_memory_ls012b7dd01_mode },
+	{ .compatible = "sharp,ls013b7dh03", .data = &sharp_memory_ls013b7dh03_mode },
+	{ .compatible = "sharp,ls013b7dh05", .data = &sharp_memory_ls013b7dh05_mode },
+	{ .compatible = "sharp,ls018b7dh02", .data = &sharp_memory_ls018b7dh02_mode },
+	{ .compatible = "sharp,ls027b7dh01", .data = &sharp_memory_ls027b7dh01_mode },
+	{ .compatible = "sharp,ls027b7dh01a", .data = &sharp_memory_ls027b7dh01_mode },
+	{ .compatible = "sharp,ls032b7dd02", .data = &sharp_memory_ls032b7dd02_mode },
+	{ .compatible = "sharp,ls044q7dh01", .data = &sharp_memory_ls044q7dh01_mode },
 	{},
 };
 MODULE_DEVICE_TABLE(of, sharp_memory_of_match);
diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
index ec008f766dd5..3e231f875725 100644
--- a/drivers/gpu/drm/vc4/vc4_dsi.c
+++ b/drivers/gpu/drm/vc4/vc4_dsi.c
@@ -1450,9 +1450,9 @@ static const struct vc4_dsi_variant bcm2835_dsi1_variant = {
 };
 
 static const struct of_device_id vc4_dsi_dt_match[] = {
-	{ .compatible = "brcm,bcm2711-dsi1", &bcm2711_dsi1_variant },
-	{ .compatible = "brcm,bcm2835-dsi0", &bcm2835_dsi0_variant },
-	{ .compatible = "brcm,bcm2835-dsi1", &bcm2835_dsi1_variant },
+	{ .compatible = "brcm,bcm2711-dsi1", .data = &bcm2711_dsi1_variant },
+	{ .compatible = "brcm,bcm2835-dsi0", .data = &bcm2835_dsi0_variant },
+	{ .compatible = "brcm,bcm2835-dsi1", .data = &bcm2835_dsi1_variant },
 	{}
 };
 
-- 
2.56.0.rc1

