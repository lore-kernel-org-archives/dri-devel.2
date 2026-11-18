Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884B9606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 12:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=QfcJH3yC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C617610FB96;
	Wed, 18 Nov 2026 12:09:02 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61E1A10FB85
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 12:08:40 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48b001cd92bso474824f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 04:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795003719; x=1795608519;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Qb0DhuOeuIYbCPnn1NnZBgGt3rjV9F8ddv0EZNRAQzk=;
 b=QfcJH3yCaDnylhDFm9CHdnl+zV63rq83FK69RiZf/Yfrp0ctUt4NzYfC9Xqf/VDF7m
 tbRF7mTpcXQumyGs3p8fjpsVj3+RTUNfNyy6vpFBUf78sKvQfuJ8Xreqtd4wVjEkfMPH
 ZZQWHv8OiHDLDXhkU8NC3k6PbA95DXZ1Io1tV4ibkfbe+HfRgFi3ybgFF8wU7b3IWG7w
 OKdZYhsZ55K9wMc25La+lQuTIs/Z7FT3DBU71FQx/ZEaAf0aSqV66gk6Gsw6bhbei98x
 2tISY4y941q0SLoopxhqoyz5b0OBNHj9svf4muCyGL9iyLTjPbk0OS2Ckt18KnT0+OsN
 FdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795003719; x=1795608519;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Qb0DhuOeuIYbCPnn1NnZBgGt3rjV9F8ddv0EZNRAQzk=;
 b=KRPkuiABDXxqjyC+C7QuiszzpXskelozMzcfU6Otfa9vCak+NCxqUaXn6GdNZmVvy9
 qSXLjMoEmvZQguNjaj54RM9kYbAgn84Vjr9U+W8Y8EV4pCzFh273QmI1HCGrekuDcTKP
 A4dQgdrQD6Q4F4tepVAsw84FEGoikWS39S6kztKYq/kQYtgStgTHUIfIJ+1ojZ/lHWLD
 ZeUM7CGPXisRuLG7p0VA5nlUx3Jl9s1c1zB292NHhyCGL1FI3NCWdad2aKzUIwalavWM
 9VEfsaW53rh2N6+Ul7IgUQQYRGVLu/yY8jBSMmJIk4/Mpz2qfXVpxP14FP0nGiMKsWRC
 VWjA==
X-Forwarded-Encrypted: i=1;
 AL+hErEqeT7ux9OJ2cBSpv4u8BvL9Z2DK7QunKxuXUlGK34YYv06bnLwoaITRsZMKVSVdlrXRil8199qs+Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/PDEWvD4vjOr0EaLLBFMKgx8kas0hdPndfQF6HVhhEBoFAvJUR
 kasD+TMVF5BKhUV9XGXohobr8ORCMM3963jla1p2paJjXK77ctQHFNY03r4AQ0oJ5mc=
X-Gm-Gg: AZFdTZd+Uxpn95AVv+eRFYCEknOzzQtWljPb1j7Q/9/IABVXcH4eLZiKIMgTJHEuKLM
 oWHXLEElnfpHRbTDyI12/6Hwu7AL2XuTNNiXO4pHUh4b6sAGDYdHhparOfpPBjhTSjn+wmnDUot
 GiuSdKwDb7fk+ptx832yi1J6wL+KLMmmGKMSopa8sdckfUklhmZi9/j2inPiZe4U2n0UCGWIlhv
 S+w7X68B+k48UoA5BeYmbDAYDbfgBOpHOxGVfGR9ccHdYA++7ealZ12ojFq45/Wk2QBYODawXMm
 zQYJ+T2vxYj8S54SdRBdDA8UENoHlA8a0uIfyua+54447JDTL+ypR3lutlItX3qv76Pb1Em5p4J
 iGEj5uKkcwPB0QXGfZQsDvn1YdZv+xBhJ68CUme2LCD+3Y74t7pK7Mz1n6G7u5v7DMXGENmGczM
 lkh/KPgwQWTEBBtLZN5fK98s6ZMrMiD/YpjS0tiw5KO6tGEqPzZGT4/9X37mVBYKfVN0UHKIutc
 XC6ipq7IU6KrH4FLWzlKhruFts5MmiT5iXG2axrhVyb9rvTZTpA6MW/3ERdGBLdWcF6IoRKYR5U
 X7tdDZs/8wJ3Mj23yrjojiK2M92DW+A6JqGFLdcBFZrJbc60wPEBIvIbrruC/uDDp3lObXFrztk
 mUOOODjPPRUiwHTw=
X-Received: by 2002:a05:6000:15e4:b0:48e:69ff:ba36 with SMTP id
 ffacd0b85a97d-4a639d17154mr2861347f8f.28.1795003718597; 
 Wed, 18 Nov 2026 04:08:38 -0800 (PST)
Received: from localhost
 (p200300f65f19a904dea20c2220232395.dip0.t-ipconnect.de.
 [2003:f6:5f19:a904:dea2:c22:2023:2395])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4a654a8c411sm4553318f8f.16.2026.11.18.04.08.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Nov 2026 04:08:38 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Marcus Folkesson <marcus.folkesson@gmail.com>,
 David Lechner <david@lechnology.com>,
 Kamlesh Gurudasani <kamlesh.gurudasani@gmail.com>,
 Alex Lanzano <lanzano.alex@gmail.com>,
 LiangCheng Wang <zaq14760@gmail.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Dave Airlie <airlied@redhat.com>, Jani Nikula <jani.nikula@intel.com>,
 Kees Cook <kees+treewide@kernel.org>, dri-devel@lists.freedesktop.org,
 Pawel Zalewski <pzalewski@thegoodpenguin.co.uk>
Subject: [PATCH v1 3/9] drm: Drop unused assignment of spi_device_id
 driver_data
Date: Wed, 18 Nov 2026 13:08:10 +0100
Message-ID: <7165f1383f5f195696fc99a0153241c2b7cb5ab0.1795002467.git.ukleinek@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1795002467.git.ukleinek@kernel.org>
References: <cover.1795002467.git.ukleinek@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10219;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=S0hwGGp6w6p91N0QascAuQAryt4p7NZS7/tEvQ61ysE=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq/ZUv8JCOfTHDGiQzJPDuFtFhilIU+HfUcBQBY
 DzIvlSAwqGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCav2VLwAKCRCPgPtYfRL+
 Tp/cB/4o8P2ZEuAaMZwxVK8vApLD7h+2lEuuhKcU/E+vOkQysbFmYdsIoTzgxB8O/BUCHq/dboC
 SnW+p5xo9Sk67f5CHhDv3V4+TSF8T7zl+BCeX6LPqfQnNjkDt1xj7NR4hJtOLxXeGTd2fdYhjLD
 B9DdCvceaWwPr1f7Rug2qUG5shVYuLUAM+My7QH9IwotbcnwThQMLvr3DoBe0Ikqou+HS2fAHbw
 JSIXfBzXuK0s6QBPKZxmQf5k0zxrJk3VmwMrX4f+I9HvViOqK4yTOKVLNyw9aCsM2fNnNLEJxII
 Mx1XZT08BoGlyhKK/dHGkhT0B2x6fKCSWbFfHjERy629CgEL
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

The driver explicitly sets the .driver_data member of struct
spi_device_id to zero without relying on that value. Drop this unused
assignment.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9341.c        | 2 +-
 drivers/gpu/drm/panel/panel-lg-lb035q02.c           | 2 +-
 drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c | 2 +-
 drivers/gpu/drm/panel/panel-nec-nl8048hl11.c        | 2 +-
 drivers/gpu/drm/panel/panel-sony-acx565akm.c        | 2 +-
 drivers/gpu/drm/panel/panel-tpo-td028ttec1.c        | 2 +-
 drivers/gpu/drm/panel/panel-tpo-td043mtea1.c        | 2 +-
 drivers/gpu/drm/sitronix/st7571-spi.c               | 4 ++--
 drivers/gpu/drm/sitronix/st7586.c                   | 2 +-
 drivers/gpu/drm/tiny/hx8357d.c                      | 2 +-
 drivers/gpu/drm/tiny/ili9163.c                      | 2 +-
 drivers/gpu/drm/tiny/ili9225.c                      | 2 +-
 drivers/gpu/drm/tiny/ili9341.c                      | 2 +-
 drivers/gpu/drm/tiny/ili9486.c                      | 6 +++---
 drivers/gpu/drm/tiny/mi0283qt.c                     | 2 +-
 drivers/gpu/drm/tiny/panel-mipi-dbi.c               | 2 +-
 drivers/gpu/drm/tiny/pixpaper.c                     | 5 ++++-
 17 files changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
index 0bab6f086717..babbf65ac38b 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9341.c
@@ -565,7 +565,7 @@ static const struct of_device_id ili9341_of_match[] = {
 MODULE_DEVICE_TABLE(of, ili9341_of_match);
 
 static const struct spi_device_id ili9341_id[] = {
-	{ "sf-tc240t-9370-t", 0 },
+	{ .name = "sf-tc240t-9370-t" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ili9341_id);
diff --git a/drivers/gpu/drm/panel/panel-lg-lb035q02.c b/drivers/gpu/drm/panel/panel-lg-lb035q02.c
index b2be6727bf73..30590aabd9d3 100644
--- a/drivers/gpu/drm/panel/panel-lg-lb035q02.c
+++ b/drivers/gpu/drm/panel/panel-lg-lb035q02.c
@@ -217,7 +217,7 @@ static const struct of_device_id lb035q02_of_match[] = {
 MODULE_DEVICE_TABLE(of, lb035q02_of_match);
 
 static const struct spi_device_id lb035q02_ids[] = {
-	{ "lb035q02", 0 },
+	{ .name = "lb035q02" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c b/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
index cde168ec631c..e332ec685484 100644
--- a/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
+++ b/drivers/gpu/drm/panel/panel-magnachip-d53e6ea8966.c
@@ -499,7 +499,7 @@ static const struct of_device_id d53e6ea8966_match[] = {
 MODULE_DEVICE_TABLE(of, d53e6ea8966_match);
 
 static const struct spi_device_id d53e6ea8966_ids[] = {
-	{ "ams495qa01", 0 },
+	{ .name = "ams495qa01" },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(spi, d53e6ea8966_ids);
diff --git a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
index d5c7210de4af..bbd70572fe0c 100644
--- a/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
+++ b/drivers/gpu/drm/panel/panel-nec-nl8048hl11.c
@@ -227,7 +227,7 @@ static const struct of_device_id nl8048_of_match[] = {
 MODULE_DEVICE_TABLE(of, nl8048_of_match);
 
 static const struct spi_device_id nl8048_ids[] = {
-	{ "nl8048hl11", 0 },
+	{ .name = "nl8048hl11" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index fe043de791b0..7e5e69cc9f6e 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -659,7 +659,7 @@ static const struct of_device_id acx565akm_of_match[] = {
 MODULE_DEVICE_TABLE(of, acx565akm_of_match);
 
 static const struct spi_device_id acx565akm_ids[] = {
-	{ "acx565akm", 0 },
+	{ .name = "acx565akm" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
index ee86ff20c1bd..48c4cb68da44 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td028ttec1.c
@@ -364,7 +364,7 @@ static const struct of_device_id td028ttec1_of_match[] = {
 MODULE_DEVICE_TABLE(of, td028ttec1_of_match);
 
 static const struct spi_device_id td028ttec1_ids[] = {
-	{ "td028ttec1", 0 },
+	{ .name = "td028ttec1" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
index b18af526b54c..77c5ea2954b8 100644
--- a/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
+++ b/drivers/gpu/drm/panel/panel-tpo-td043mtea1.c
@@ -480,7 +480,7 @@ static const struct of_device_id td043mtea1_of_match[] = {
 MODULE_DEVICE_TABLE(of, td043mtea1_of_match);
 
 static const struct spi_device_id td043mtea1_ids[] = {
-	{ "td043mtea1", 0 },
+	{ .name = "td043mtea1" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/sitronix/st7571-spi.c b/drivers/gpu/drm/sitronix/st7571-spi.c
index 0206e9162f1c..2db85ad78721 100644
--- a/drivers/gpu/drm/sitronix/st7571-spi.c
+++ b/drivers/gpu/drm/sitronix/st7571-spi.c
@@ -52,8 +52,8 @@ static const struct of_device_id st7571_of_match[] = {
 MODULE_DEVICE_TABLE(of, st7571_of_match);
 
 static const struct spi_device_id st7571_spi_id[] = {
-	{ "st7567", 0 },
-	{ "st7571", 0 },
+	{ .name = "st7567" },
+	{ .name = "st7571" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, st7571_spi_id);
diff --git a/drivers/gpu/drm/sitronix/st7586.c b/drivers/gpu/drm/sitronix/st7586.c
index 28b2245f6b79..0760f771163a 100644
--- a/drivers/gpu/drm/sitronix/st7586.c
+++ b/drivers/gpu/drm/sitronix/st7586.c
@@ -352,7 +352,7 @@ static const struct of_device_id st7586_of_match[] = {
 MODULE_DEVICE_TABLE(of, st7586_of_match);
 
 static const struct spi_device_id st7586_id[] = {
-	{ "ev3-lcd", 0 },
+	{ .name = "ev3-lcd" },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, st7586_id);
diff --git a/drivers/gpu/drm/tiny/hx8357d.c b/drivers/gpu/drm/tiny/hx8357d.c
index f942a8d09ff2..9ac21aec01e1 100644
--- a/drivers/gpu/drm/tiny/hx8357d.c
+++ b/drivers/gpu/drm/tiny/hx8357d.c
@@ -271,7 +271,7 @@ static const struct of_device_id hx8357d_of_match[] = {
 MODULE_DEVICE_TABLE(of, hx8357d_of_match);
 
 static const struct spi_device_id hx8357d_id[] = {
-	{ "yx350hv15", 0 },
+	{ .name = "yx350hv15" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, hx8357d_id);
diff --git a/drivers/gpu/drm/tiny/ili9163.c b/drivers/gpu/drm/tiny/ili9163.c
index 8842424504e3..97262ca45734 100644
--- a/drivers/gpu/drm/tiny/ili9163.c
+++ b/drivers/gpu/drm/tiny/ili9163.c
@@ -190,7 +190,7 @@ static const struct of_device_id ili9163_of_match[] = {
 MODULE_DEVICE_TABLE(of, ili9163_of_match);
 
 static const struct spi_device_id ili9163_id[] = {
-	{ "nhd-1.8-128160EF", 0 },
+	{ .name = "nhd-1.8-128160EF" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ili9163_id);
diff --git a/drivers/gpu/drm/tiny/ili9225.c b/drivers/gpu/drm/tiny/ili9225.c
index 5bf52a8fd75b..970abe1e9096 100644
--- a/drivers/gpu/drm/tiny/ili9225.c
+++ b/drivers/gpu/drm/tiny/ili9225.c
@@ -424,7 +424,7 @@ static const struct of_device_id ili9225_of_match[] = {
 MODULE_DEVICE_TABLE(of, ili9225_of_match);
 
 static const struct spi_device_id ili9225_id[] = {
-	{ "v220hf01a-t", 0 },
+	{ .name = "v220hf01a-t" },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, ili9225_id);
diff --git a/drivers/gpu/drm/tiny/ili9341.c b/drivers/gpu/drm/tiny/ili9341.c
index 003381aa22ea..38d5ed9bc0e9 100644
--- a/drivers/gpu/drm/tiny/ili9341.c
+++ b/drivers/gpu/drm/tiny/ili9341.c
@@ -227,7 +227,7 @@ static const struct of_device_id ili9341_of_match[] = {
 MODULE_DEVICE_TABLE(of, ili9341_of_match);
 
 static const struct spi_device_id ili9341_id[] = {
-	{ "yx240qv29", 0 },
+	{ .name = "yx240qv29" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ili9341_id);
diff --git a/drivers/gpu/drm/tiny/ili9486.c b/drivers/gpu/drm/tiny/ili9486.c
index c945a9144315..a4b82bbf98f8 100644
--- a/drivers/gpu/drm/tiny/ili9486.c
+++ b/drivers/gpu/drm/tiny/ili9486.c
@@ -250,9 +250,9 @@ static const struct of_device_id ili9486_of_match[] = {
 MODULE_DEVICE_TABLE(of, ili9486_of_match);
 
 static const struct spi_device_id ili9486_id[] = {
-	{ "ili9486", 0 },
-	{ "rpi-lcd-35", 0 },
-	{ "piscreen", 0 },
+	{ .name = "ili9486" },
+	{ .name = "rpi-lcd-35" },
+	{ .name = "piscreen" },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ili9486_id);
diff --git a/drivers/gpu/drm/tiny/mi0283qt.c b/drivers/gpu/drm/tiny/mi0283qt.c
index b0121e89e2dc..072326ef2e1e 100644
--- a/drivers/gpu/drm/tiny/mi0283qt.c
+++ b/drivers/gpu/drm/tiny/mi0283qt.c
@@ -231,7 +231,7 @@ static const struct of_device_id mi0283qt_of_match[] = {
 MODULE_DEVICE_TABLE(of, mi0283qt_of_match);
 
 static const struct spi_device_id mi0283qt_id[] = {
-	{ "mi0283qt", 0 },
+	{ .name = "mi0283qt" },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, mi0283qt_id);
diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
index 3f462d79a6d3..ffff6acf7dea 100644
--- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
+++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
@@ -542,7 +542,7 @@ static const struct of_device_id panel_mipi_dbi_spi_of_match[] = {
 MODULE_DEVICE_TABLE(of, panel_mipi_dbi_spi_of_match);
 
 static const struct spi_device_id panel_mipi_dbi_spi_id[] = {
-	{ "panel-mipi-dbi-spi", 0 },
+	{ .name = "panel-mipi-dbi-spi" },
 	{ },
 };
 MODULE_DEVICE_TABLE(spi, panel_mipi_dbi_spi_id);
diff --git a/drivers/gpu/drm/tiny/pixpaper.c b/drivers/gpu/drm/tiny/pixpaper.c
index 2a92a28b40f6..456887546034 100644
--- a/drivers/gpu/drm/tiny/pixpaper.c
+++ b/drivers/gpu/drm/tiny/pixpaper.c
@@ -1140,7 +1140,10 @@ static void pixpaper_remove(struct spi_device *spi)
 	drm_atomic_helper_shutdown(&panel->drm);
 }
 
-static const struct spi_device_id pixpaper_ids[] = { { "pixpaper", 0 }, {} };
+static const struct spi_device_id pixpaper_ids[] = {
+	{ .name = "pixpaper" },
+	{ }
+};
 MODULE_DEVICE_TABLE(spi, pixpaper_ids);
 
 static const struct of_device_id pixpaper_dt_ids[] = {
-- 
2.56.0.rc1

