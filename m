Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812FA606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=F9JfZizZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE31310FB98;
	Wed, 18 Nov 2026 12:09:01 +0000 (UTC)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84D3E10FB9F
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:41 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a00so6254045e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003720; x=1795608520;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/+YSoU/K5/LTKDH6y6all87vBSBOSKAQSyBbuzFGHbU=;
 b=F9JfZizZX+E/II4jHAtorlT9k3PPsG9ZRLP0HrS+F+GuF74Vk157CJe65XBp/CNkfl
 4ErB++YIV57z6fKjf+krUkAnMB0wZXBNAO3NbTWBYopIQ2eVWr0GXmH0j52hZq3EOcMA
 tvLwizvCFBf83GEdIICEKaq9ALPe/s2LzC8HPVW0TCw7R9Ndnv06hqr0N0HubGVUpI2y
 6J+fqW6tHpgsv5VMGYQiCZNZSsbWQnKXdL7HgDOVJsFlGkcK+HTn4DGrqi14n0qKdMS5
 nClnbSrhuGGeD/Hsde/ugeoRs6sAM371UsSQTJD+OS20h0pQMH7C7cenATqbVWxG2934
 Y6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003720; x=1795608520;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/+YSoU/K5/LTKDH6y6all87vBSBOSKAQSyBbuzFGHbU=;
 b=KVzYvArQbcJ2S5oh+29rpf9RWM80xNmpVzakdYsq5hzDPpoHA6OveJMJe/iSoywWsb
 w/cwSKQ0ByyoGO/DbKfS1gQnmuB8B9yM43eFu/KMWjlRxaIsX2NpSJqA+4VCrq8Aj8m0
 mxfshqy0Jpw4DH/oSnmOabGyOZNFFqFmCwwK2Emf8hdLhoyfw7Fn1rRAt4j3jon0N6Zg
 7b0MmCp61FRQiXLSLlM8V/El9veIjEX5x5l4fDg+Hjw3Lz3RHNZCsev34e4VYplkydXA
 v9tHjTOGwI2NMFne414djamTjMmW7F4AjwHEgOyMTYyz898pMr0rJHw+HrvScshxSPDt
 l6Pg==
X-Forwarded-Encrypted: i=1;
 AL+hErEdNz36zV2uC3IzNzuX1vmNrngIcv81UWxt78CkZ0eWU2i4eFC8F8MYcc62KzAs6W0HBzwBGNDxr44=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8k/VlSeR/pTVTwukkmfTFAp/0f6bwKoEYUg+XUoFaZeazNYUcb
 53zCeAFREYCTGa1FkrrTNyxbmgfdXsspO/uHEnKprXrXM0szTkbN/qLX0n5Ty47Uyac=
X-Gm-Gg: AYBFou1eAGrQ7pP94dFbx5AhESbTUU4dbEGPvNp8sc/0oywxWkozqdYjCJpk91FwZPp
 JFPfJaQAVRfoTnW49phHbfyL3ZXDHtZtWqlKh9iLETy6EsH1LHdJZKxPa3ugBVv5F3+9VmkYAFz
 IC207LTPu1Y9aJSWQ6YDIJKT5zsTxbBhHARJF0e4kwt4MljBiypgHJZCzldSP8eKH5Ji2EbKDQv
 PW9+J/hjWagT6H1cRDbSmbQx+ycdZa6M9iq0L/8LPDHN3GVvdZqZin0uWevvwnX3z8bm88sQZBc
 USFr+cejVeSSJIbsdVkVM2r1Io0Kod+awZFNDLH2ZebUrmac3nw4rrCR7A28NHDLQC95hKnaOxj
 G+gIRUxFcs24kWLAq43117Ljv2Ljw1YLNgtoyQ5vpPWi6FBuZrTroOD0tQndTgAhZFnRH4PpoXE
 vxSYO4lL8Cwr4u5U+NlJbORHf/K1vGfHCy110jjomN1OKfAR5ExCQ15e93G/BfV7RFcOeRpD55S
 fD2L3OqfU2bsERznbNpNkr5TvuW0IDXG6J0ldWs2JpCBI8uOPOwZ/AR9FWgbD027RjpPoOLJZmD
 hjBR9TG8EUQmmZiSUTN6ZQHMpGfQ70u9o3zYo3coBRqpV2nDTelTla8MkVpV2IXIeaaca2Qs6uo
 KqP2QhVD1thhAvLNCVFXVrvV1Ca2pxu6g4jhX
X-Received: by 2002:a05:600c:8184:b0:4b7:dc0:89c with SMTP id
 5b1f17b1804b1-4bb7da51024mr42923945e9.32.1795003719893; 
 Wed, 18 Nov 2026 04:08:39 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb7d2c3c93sm90462525e9.13.2026.11.18.04.08.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:39 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Linus Walleij <linusw@kernel.org>, Jagan Teki <jagan@amarulasolutions.com>,
 David Lechner <david@lechnology.com>,
 Iker Pedrosa <ikerpedrosam@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>, dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 4/9] drm: Use designated initializers for spi_device_id
 arrays
Date: Wed, 18 Nov 2026 13:08:11 +0100
Message-ID: <5486432120db4d9081d1586ac528c41ce16f3cc5.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11296;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=5wz6xkSYmr3S0ILgFpUBJJZUitxy7fXd1UUcNadJV5I=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZUx2wcqQxEWNz08T4rqJ0mloMAOYEbee/uF5
 rXUH1GWLYSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VMQAKCRCPgPtYfRL+
 TughB/9KEvzwz4GDZ7LuIR34ijVfWxsb0jfQ/73qo+wEZrZtOskrtjAfylsYAWp+4DtqSHA9FBH
 JJhM+RwGQsQ1Id4uIvr20SPrkDiqqonP9OiOGKmnqKGcuMNLx1Ldhr+MN8uV2ru79Rp9r5dfcoD
 /jtcyQ+ZU+EC/he3nEfSBqNqYl1J0+J6cUk/mDEfBzf6MfKKadewwECorwyHqHHCnXCfVetYHzS
 KNhwq7aDn0+c3vMDrgN0olLt2gbtYjZFgLxjsqT6nTHaQGJs26Ki9EgohI/66+pasaB/P1DTiLc
 NFZDEylMwROAka9tWjRWnr5gGVInEFnDy3v3AjCRDZuCaanG
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
struct spi_device_id replacing .driver_data by an anonymous union.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/panel/panel-auo-a030jtn01.c   |  5 ++++-
 .../gpu/drm/panel/panel-ilitek-ili9806e-spi.c |  2 +-
 .../gpu/drm/panel/panel-newvision-nv3052c.c   |  6 +++---
 .../gpu/drm/panel/panel-orisetech-ota5601a.c  |  2 +-
 drivers/gpu/drm/panel/panel-samsung-db7430.c  |  2 +-
 drivers/gpu/drm/panel/panel-samsung-ld9040.c  |  2 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c |  2 +-
 .../gpu/drm/panel/panel-sitronix-st7789v.c    |  8 ++++----
 drivers/gpu/drm/panel/panel-tpo-tpg110.c      |  2 +-
 .../gpu/drm/panel/panel-widechips-ws2401.c    |  2 +-
 drivers/gpu/drm/sitronix/st7735r.c            |  4 ++--
 drivers/gpu/drm/sitronix/st7920.c             |  2 +-
 drivers/gpu/drm/tiny/repaper.c                |  8 ++++----
 drivers/gpu/drm/tiny/sharp-memory.c           | 20 +++++++++----------
 14 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
index d71850b24ffa..defbb49240c2 100644
--- a/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
+++ b/drivers/gpu/drm/panel/panel-auo-a030jtn01.c
@@ -278,7 +278,10 @@ static const struct a030jtn01_info a030jtn01_info = {
 };
 
 static const struct spi_device_id a030jtn01_id[] = {
-	{ "a030jtn01", (kernel_ulong_t) &a030jtn01_info },
+	{
+		.name = "a030jtn01",
+		.driver_data = (kernel_ulong_t) &a030jtn01_info,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, a030jtn01_id);
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
index 9271c3c89a7f..86da169431f2 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-spi.c
@@ -297,7 +297,7 @@ static const struct of_device_id ili9806e_spi_of_match[] = {
 MODULE_DEVICE_TABLE(of, ili9806e_spi_of_match);
 
 static const struct spi_device_id ili9806e_spi_ids[] = {
-	{ "rk050hr345-ct106a", },
+	{ .name = "rk050hr345-ct106a" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, ili9806e_spi_ids);
diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
index 18130bc14201..40a0aa35da53 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3052c.c
@@ -653,9 +653,9 @@ static const struct nv3052c_panel_info wl_355608_a8_panel_info = {
 };
 
 static const struct spi_device_id nv3052c_ids[] = {
-	{ "ltk035c5444t", },
-	{ "fs035vg158", },
-	{ "rg35xx-plus-panel", },
+	{ .name = "ltk035c5444t" },
+	{ .name = "fs035vg158" },
+	{ .name = "rg35xx-plus-panel" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, nv3052c_ids);
diff --git a/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c b/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
index 8a608972fc41..3e147fe6f272 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-ota5601a.c
@@ -332,7 +332,7 @@ static const struct ota5601a_panel_info gpt3_info = {
 };
 
 static const struct spi_device_id gpt3_id[] = {
-	{ "gpt3", (kernel_ulong_t)&gpt3_info },
+	{ .name = "gpt3", .driver_data = (kernel_ulong_t)&gpt3_info },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, gpt3_id);
diff --git a/drivers/gpu/drm/panel/panel-samsung-db7430.c b/drivers/gpu/drm/panel/panel-samsung-db7430.c
index a97182f3c990..2a1fd9eb4698 100644
--- a/drivers/gpu/drm/panel/panel-samsung-db7430.c
+++ b/drivers/gpu/drm/panel/panel-samsung-db7430.c
@@ -327,7 +327,7 @@ static const struct of_device_id db7430_match[] = {
 MODULE_DEVICE_TABLE(of, db7430_match);
 
 static const struct spi_device_id db7430_ids[] = {
-	{ "lms397kf04" },
+	{ .name = "lms397kf04" },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, db7430_ids);
diff --git a/drivers/gpu/drm/panel/panel-samsung-ld9040.c b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
index c7f2241523a0..8589ecb6be86 100644
--- a/drivers/gpu/drm/panel/panel-samsung-ld9040.c
+++ b/drivers/gpu/drm/panel/panel-samsung-ld9040.c
@@ -401,7 +401,7 @@ static const struct of_device_id ld9040_of_match[] = {
 MODULE_DEVICE_TABLE(of, ld9040_of_match);
 
 static const struct spi_device_id ld9040_ids[] = {
-	{ "ld9040", },
+	{ .name = "ld9040" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, ld9040_ids);
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 31c56eadda12..0db2018a8018 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -1397,7 +1397,7 @@ static const struct of_device_id st7701_spi_of_match[] = {
 MODULE_DEVICE_TABLE(of, st7701_spi_of_match);
 
 static const struct spi_device_id st7701_spi_ids[] = {
-	{ "rg28xx-panel" },
+	{ .name = "rg28xx-panel" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, st7701_spi_ids);
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index da6ed31d151e..fb6cd9081d3c 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -664,10 +664,10 @@ static void st7789v_remove(struct spi_device *spi)
 }
 
 static const struct spi_device_id st7789v_spi_id[] = {
-	{ "st7789v", (unsigned long) &default_panel },
-	{ "t28cp45tn89-v17", (unsigned long) &t28cp45tn89_panel },
-	{ "et028013dma", (unsigned long) &et028013dma_panel },
-	{ "jt240mhqs-hwt-ek-e3", (unsigned long) &jt240mhqs_hwt_ek_e3_panel },
+	{ .name = "st7789v", .driver_data = (unsigned long) &default_panel },
+	{ .name = "t28cp45tn89-v17", .driver_data = (unsigned long) &t28cp45tn89_panel },
+	{ .name = "et028013dma", .driver_data = (unsigned long) &et028013dma_panel },
+	{ .name = "jt240mhqs-hwt-ek-e3", .driver_data = (unsigned long) &jt240mhqs_hwt_ek_e3_panel },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, st7789v_spi_id);
diff --git a/drivers/gpu/drm/panel/panel-tpo-tpg110.c b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
index 0beba5c08956..8fb3a94f6cd9 100644
--- a/drivers/gpu/drm/panel/panel-tpo-tpg110.c
+++ b/drivers/gpu/drm/panel/panel-tpo-tpg110.c
@@ -465,7 +465,7 @@ static const struct of_device_id tpg110_match[] = {
 MODULE_DEVICE_TABLE(of, tpg110_match);
 
 static const struct spi_device_id tpg110_ids[] = {
-	{ "tpg110" },
+	{ .name = "tpg110" },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, tpg110_ids);
diff --git a/drivers/gpu/drm/panel/panel-widechips-ws2401.c b/drivers/gpu/drm/panel/panel-widechips-ws2401.c
index dd74610bd2eb..4430c71feb88 100644
--- a/drivers/gpu/drm/panel/panel-widechips-ws2401.c
+++ b/drivers/gpu/drm/panel/panel-widechips-ws2401.c
@@ -425,7 +425,7 @@ static const struct of_device_id ws2401_match[] = {
 MODULE_DEVICE_TABLE(of, ws2401_match);
 
 static const struct spi_device_id ws2401_ids[] = {
-	{ "lms380kf01" },
+	{ .name = "lms380kf01" },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, ws2401_ids);
diff --git a/drivers/gpu/drm/sitronix/st7735r.c b/drivers/gpu/drm/sitronix/st7735r.c
index bd763871dca0..f45bca9f3bc2 100644
--- a/drivers/gpu/drm/sitronix/st7735r.c
+++ b/drivers/gpu/drm/sitronix/st7735r.c
@@ -226,8 +226,8 @@ static const struct of_device_id st7735r_of_match[] = {
 MODULE_DEVICE_TABLE(of, st7735r_of_match);
 
 static const struct spi_device_id st7735r_id[] = {
-	{ "jd-t18003-t01", (uintptr_t)&jd_t18003_t01_cfg },
-	{ "rh128128t", (uintptr_t)&rh128128t_cfg },
+	{ .name = "jd-t18003-t01", .driver_data = (uintptr_t)&jd_t18003_t01_cfg },
+	{ .name = "rh128128t", .driver_data = (uintptr_t)&rh128128t_cfg },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, st7735r_id);
diff --git a/drivers/gpu/drm/sitronix/st7920.c b/drivers/gpu/drm/sitronix/st7920.c
index 2f2c808e783b..1a5250ce45e2 100644
--- a/drivers/gpu/drm/sitronix/st7920.c
+++ b/drivers/gpu/drm/sitronix/st7920.c
@@ -224,7 +224,7 @@ MODULE_DEVICE_TABLE(of, st7920_of_match);
  */
 static const struct spi_device_id st7920_spi_id[] = {
 	/* st7920 family */
-	{ "st7920",  0 },
+	{ .name = "st7920" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(spi, st7920_spi_id);
diff --git a/drivers/gpu/drm/tiny/repaper.c b/drivers/gpu/drm/tiny/repaper.c
index 25e6a7a4affc..cebd48addc40 100644
--- a/drivers/gpu/drm/tiny/repaper.c
+++ b/drivers/gpu/drm/tiny/repaper.c
@@ -994,10 +994,10 @@ static const struct of_device_id repaper_of_match[] = {
 MODULE_DEVICE_TABLE(of, repaper_of_match);
 
 static const struct spi_device_id repaper_id[] = {
-	{ "e1144cs021", E1144CS021 },
-	{ "e1190cs021", E1190CS021 },
-	{ "e2200cs021", E2200CS021 },
-	{ "e2271cs021", E2271CS021 },
+	{ .name = "e1144cs021", .driver_data = E1144CS021 },
+	{ .name = "e1190cs021", .driver_data = E1190CS021 },
+	{ .name = "e2200cs021", .driver_data = E2200CS021 },
+	{ .name = "e2271cs021", .driver_data = E2271CS021 },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, repaper_id);
diff --git a/drivers/gpu/drm/tiny/sharp-memory.c b/drivers/gpu/drm/tiny/sharp-memory.c
index b948e44544d6..861dd81a8e5b 100644
--- a/drivers/gpu/drm/tiny/sharp-memory.c
+++ b/drivers/gpu/drm/tiny/sharp-memory.c
@@ -420,16 +420,16 @@ static const struct drm_display_mode sharp_memory_ls044q7dh01_mode = {
 };
 
 static const struct spi_device_id sharp_memory_ids[] = {
-	{"ls010b7dh04", (kernel_ulong_t)&sharp_memory_ls010b7dh04_mode},
-	{"ls011b7dh03", (kernel_ulong_t)&sharp_memory_ls011b7dh03_mode},
-	{"ls012b7dd01", (kernel_ulong_t)&sharp_memory_ls012b7dd01_mode},
-	{"ls013b7dh03", (kernel_ulong_t)&sharp_memory_ls013b7dh03_mode},
-	{"ls013b7dh05", (kernel_ulong_t)&sharp_memory_ls013b7dh05_mode},
-	{"ls018b7dh02", (kernel_ulong_t)&sharp_memory_ls018b7dh02_mode},
-	{"ls027b7dh01", (kernel_ulong_t)&sharp_memory_ls027b7dh01_mode},
-	{"ls027b7dh01a", (kernel_ulong_t)&sharp_memory_ls027b7dh01_mode},
-	{"ls032b7dd02", (kernel_ulong_t)&sharp_memory_ls032b7dd02_mode},
-	{"ls044q7dh01", (kernel_ulong_t)&sharp_memory_ls044q7dh01_mode},
+	{ .name = "ls010b7dh04", .driver_data = (kernel_ulong_t)&sharp_memory_ls010b7dh04_mode },
+	{ .name = "ls011b7dh03", .driver_data = (kernel_ulong_t)&sharp_memory_ls011b7dh03_mode },
+	{ .name = "ls012b7dd01", .driver_data = (kernel_ulong_t)&sharp_memory_ls012b7dd01_mode },
+	{ .name = "ls013b7dh03", .driver_data = (kernel_ulong_t)&sharp_memory_ls013b7dh03_mode },
+	{ .name = "ls013b7dh05", .driver_data = (kernel_ulong_t)&sharp_memory_ls013b7dh05_mode },
+	{ .name = "ls018b7dh02", .driver_data = (kernel_ulong_t)&sharp_memory_ls018b7dh02_mode },
+	{ .name = "ls027b7dh01", .driver_data = (kernel_ulong_t)&sharp_memory_ls027b7dh01_mode },
+	{ .name = "ls027b7dh01a", .driver_data = (kernel_ulong_t)&sharp_memory_ls027b7dh01_mode },
+	{ .name = "ls032b7dd02", .driver_data = (kernel_ulong_t)&sharp_memory_ls032b7dd02_mode },
+	{ .name = "ls044q7dh01", .driver_data = (kernel_ulong_t)&sharp_memory_ls044q7dh01_mode },
 	{},
 };
 MODULE_DEVICE_TABLE(spi, sharp_memory_ids);
-- 
2.56.0.rc1

