Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74F2C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 11:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 106EF10E8B3;
	Mon, 20 Jul 2026 11:26:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=baylibre.com header.i=@baylibre.com header.b="XVVjdraE";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A017310E183
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 11:26:05 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso10534535e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 04:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1784546764; x=1785151564;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=vD0OJtQist2KRCQx9nF6dqVBq7z04Tc69a2qh9Da0yQ=;
 b=XVVjdraEvEnzkb2Uo+TpnamgBhKVPQLbDiRbM/gxtpvEUXg65+btIchJsYwvaMQrqp
 Rqzd7tXX6pcQuCxME6NGMrmiCZVC3J3+EpfWLyrzW4fy82XULQTCWnsf/no5BLSh2T5p
 O8METZMyCG3orlRf1R0AguWXg3oh0qvif+AQ20R9/NkXZ6IMYWgFRZRsZsVroOzLwmRc
 yWY3Nni9+vs9BZLSpCjNjw795c7o3I8kOgcIsRvlGJg0jv0l7+c6LKM6MVEocM41jwtQ
 8Mo7v+6mJ5eiG90fyi/SL5e/+QSx3qjKHKxi3FrEh1/15kYoXgxnhKtZ9hbu8w8NMSCA
 mO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784546764; x=1785151564;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=vD0OJtQist2KRCQx9nF6dqVBq7z04Tc69a2qh9Da0yQ=;
 b=ZCQBRYh39hJcXTcuQf0S+hNdaH1gN6lUeJgJtlUx1rpRQXLc4fe/XMOW7y7Lw0vqbU
 5/A88zSwR4pBW15nHlsVxS9NvTVYOZEkYF+V4PC0ZbDQUe//mD5JbKaIXZpaU5BOp+m/
 oCIaUKwqleweFfsoOhCw04yivhmokdKgEGuVpWBdHklANjmf/y5rO/e0fMS/6DvN+EzZ
 gn+Z4SBeSpiZi665bnY6gjyEB87OmQDcYTbLrQ5abhmUpGqa+KaowVp5su1tKFjeuP5M
 N3KAnz8b/SxO0TL/0EUZo++UIjnAnNtDw6000vQVVks4IKVJeo/qQCQ6m/x0tyB5Wbjl
 0kjw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr+VWTyu3NhgV/kzPJNcJZPI2at6G3Jjzac20GE5BgS9Zga7+1/o9eNJrFtX94lWbMfirEjEHEqhts=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwNLvi7uoPVa1b8FYgD/2aL82vxfPGN/1O6mzw2C5QYGPjP/NUQ
 aoHwy9hKzfo2d9CTedWmDn5ChjUfV2PsDkY5CElR0jlXMOHEoInYESr+5k/TYFIoZyY=
X-Gm-Gg: AfdE7clPqyUtS1ZyrbCMzyI4OrX71hfvsmJltvlkswerWv2cz8Gq2f3BoFxdz+9k9yi
 1Xfe0TC2+GjVKImMpDDDpf6Y+pzVowqyJg5Fvd1Kdw6Vf3wFtEm/SAEy4N5meoP7hplzOCHlzi+
 HMxY4UH5mZpDGsr4adxK7/qz+LucL6D+07u4LFwCqKJzKOlVmf6w+u13GKCcEIJnQSmAsFO2LJy
 I9K0lflDgAjM2vcQ2YTd++V6F4+Hqqz3sZnKxFjr5YUkUT8keXUHSNfqw+/GDK6OAFAak4UR49V
 H+t+0yJ/bZQxjLm8JeJxNMOOX2ZtD5+FhTonfqkMLZWwBtDqg5MKOUXK3/qiGpnniIDA/VYbmaR
 oBj3p47G/Zps2xMRw0hV4HxmtGwNCI57l67l1tJEhXSOdM0/xU6IXlsm7bHVsLqGwdnMwKjzpQ/
 r3dEPNwBL67HQTUkaC+karj+6SlZqXaZZYWwXlNk4+ef9Oe3RF1SVQYXXsY8FqgcvebA==
X-Received: by 2002:a05:600c:548b:b0:495:4c62:9d2f with SMTP id
 5b1f17b1804b1-4954c629de4mr169143815e9.10.1784546763685; 
 Mon, 20 Jul 2026 04:26:03 -0700 (PDT)
Received: from localhost
 (p200300f65f47db048587886ecb5b26b2.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:8587:886e:cb5b:26b2])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-49549a36312sm296380835e9.2.2026.07.20.04.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2026 04:26:02 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jagan Teki <jagan@amarulasolutions.com>,
 Liu Ying <victor.liu@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
 Peter Senna Tschudin <peter.senna@gmail.com>,
 Ian Ray <ian.ray@gehealthcare.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Russell King <linux@armlinux.org.uk>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Jani Nikula <jani.nikula@intel.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Xin Ji <xji@analogixsemi.com>,
 Marco Crivellari <marco.crivellari@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] drm/bridge: Use named initializers for arrays of
 i2c_device_data
Date: Mon, 20 Jul 2026 13:25:47 +0200
Message-ID: <9fa3a8e372b7211c06ec885617051f5006227e3a.1784545092.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.55.0.11.g153666a7d9bb
In-Reply-To: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
References: <cover.1784545092.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=16583;
 i=u.kleine-koenig@baylibre.com; h=from:subject:message-id;
 bh=kB8sV9P7RHuK9TseIj0pzjQEdELtbmWaKc5U/Y3AFgk=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqXgW9wmzn+K/0rmQOuKksE5YZB0NVWX4Xi1R3q
 OTWGrp3+36JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCal4FvQAKCRCPgPtYfRL+
 TkabB/0cxhr1tKTEAQME3d1trxl0roU1r6GK6I1luO02J7McbDfDspZgH7SvuWT7qZT/cp8MlVn
 b7FXyeoP1I2tUNXqA9Hl5QGy2cmLArTp4fBjehMW0i6/pIPJy1WeG83wxGGAyN14I2GnE40cg+x
 xwS9m/mWe8ugrKRdJhk6q+ufD0Df3mRwYIxA9pBtMbPXpRGIkRurO+wb+9usY4sgvSmPWPhSFN6
 RwVZrphN7J/LZqpyx6wpU48xdZw05ho96KF42Mbm9eAdyEjXYoIyXeWUZSTlxJKEghvAHG1YXhS
 QVjt3Co/2xyH0Um2Cy/xJ+UjutBuG/+zTYrP+/auLW/wfALE
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp;
 fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
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

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

The mentioned robustness is relevant for a planned change to struct
i2c_device_id that replaces .driver_data by an anonymous union.

While touching all these arrays, unify usage of whitespace in the list
terminator and drop trailing commas there.

This patch doesn't modify the compiled arrays, only their representation
in source form benefits. The former was confirmed with x86 and arm64
builds.

Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c           | 10 +++++-----
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c     |  2 +-
 drivers/gpu/drm/bridge/analogix/anx7625.c              |  4 ++--
 drivers/gpu/drm/bridge/chipone-icn6211.c               |  4 ++--
 drivers/gpu/drm/bridge/chrontel-ch7033.c               |  2 +-
 drivers/gpu/drm/bridge/ite-it6263.c                    |  2 +-
 drivers/gpu/drm/bridge/ite-it6505.c                    |  2 +-
 drivers/gpu/drm/bridge/lontium-lt8713sx.c              |  2 +-
 drivers/gpu/drm/bridge/lontium-lt8912b.c               |  4 ++--
 drivers/gpu/drm/bridge/lontium-lt9211.c                |  4 ++--
 drivers/gpu/drm/bridge/lontium-lt9611.c                |  4 ++--
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c             |  2 +-
 .../gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |  8 ++++----
 drivers/gpu/drm/bridge/nxp-ptn3460.c                   |  4 ++--
 drivers/gpu/drm/bridge/parade-ps8622.c                 |  8 ++++----
 drivers/gpu/drm/bridge/sii902x.c                       |  2 +-
 drivers/gpu/drm/bridge/sii9234.c                       |  2 +-
 drivers/gpu/drm/bridge/sil-sii8620.c                   |  2 +-
 drivers/gpu/drm/bridge/tc358767.c                      |  2 +-
 drivers/gpu/drm/bridge/tc358768.c                      |  4 ++--
 drivers/gpu/drm/bridge/tc358775.c                      |  4 ++--
 drivers/gpu/drm/bridge/tda998x_drv.c                   |  2 +-
 drivers/gpu/drm/bridge/ti-dlpc3433.c                   |  2 +-
 drivers/gpu/drm/bridge/ti-sn65dsi83.c                  |  6 +++---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c                  |  4 ++--
 drivers/gpu/drm/bridge/ti-tfp410.c                     |  2 +-
 26 files changed, 47 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index db99e252aeeb..038b852405b5 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1471,11 +1471,11 @@ static const struct adv7511_chip_info adv7535_chip_info = {
 };
 
 static const struct i2c_device_id adv7511_i2c_ids[] = {
-	{ "adv7511", (kernel_ulong_t)&adv7511_chip_info },
-	{ "adv7511w", (kernel_ulong_t)&adv7511_chip_info },
-	{ "adv7513", (kernel_ulong_t)&adv7511_chip_info },
-	{ "adv7533", (kernel_ulong_t)&adv7533_chip_info },
-	{ "adv7535", (kernel_ulong_t)&adv7535_chip_info },
+	{ .name = "adv7511", .driver_data = (kernel_ulong_t)&adv7511_chip_info },
+	{ .name = "adv7511w", .driver_data = (kernel_ulong_t)&adv7511_chip_info },
+	{ .name = "adv7513", .driver_data = (kernel_ulong_t)&adv7511_chip_info },
+	{ .name = "adv7533", .driver_data = (kernel_ulong_t)&adv7533_chip_info },
+	{ .name = "adv7535", .driver_data = (kernel_ulong_t)&adv7535_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adv7511_i2c_ids);
diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
index eba5c6dcb5ad..21818df1a1ab 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -771,7 +771,7 @@ static void anx6345_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id anx6345_id[] = {
-	{ "anx6345" },
+	{ .name = "anx6345" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, anx6345_id);
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index ebd34657908e..c3af88e14f8b 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2993,8 +2993,8 @@ static void anx7625_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id anx7625_id[] = {
-	{ "anx7625" },
-	{}
+	{ .name = "anx7625" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, anx7625_id);
diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index eb628a0ce6ec..0f6173c61502 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -784,8 +784,8 @@ static struct mipi_dsi_driver chipone_dsi_driver = {
 };
 
 static const struct i2c_device_id chipone_i2c_id[] = {
-	{ "chipone,icn6211" },
-	{},
+	{ .name = "chipone,icn6211" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, chipone_i2c_id);
 
diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 92d464727e41..4bc64b2885f7 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -601,7 +601,7 @@ static const struct of_device_id ch7033_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ch7033_dt_ids);
 
 static const struct i2c_device_id ch7033_ids[] = {
-	{ "ch7033" },
+	{ .name = "ch7033" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ch7033_ids);
diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 4c0b670806cc..21ac8e58b9d2 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -910,7 +910,7 @@ static const struct of_device_id it6263_of_match[] = {
 MODULE_DEVICE_TABLE(of, it6263_of_match);
 
 static const struct i2c_device_id it6263_i2c_ids[] = {
-	{ "it6263" },
+	{ .name = "it6263" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, it6263_i2c_ids);
diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 8ecb43611dba..025a19c1e530 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -3652,7 +3652,7 @@ static void it6505_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id it6505_id[] = {
-	{ "it6505" },
+	{ .name = "it6505" },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt8713sx.c b/drivers/gpu/drm/bridge/lontium-lt8713sx.c
index 4a6420b876da..bfff28883280 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8713sx.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8713sx.c
@@ -572,7 +572,7 @@ static void lt8713sx_remove(struct i2c_client *client)
 }
 
 static struct i2c_device_id lt8713sx_id[] = {
-	{ "lontium,lt8713sx", 0 },
+	{ .name = "lontium,lt8713sx" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index df5d07e7644c..b3ec63728d59 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -820,8 +820,8 @@ static const struct of_device_id lt8912_dt_match[] = {
 MODULE_DEVICE_TABLE(of, lt8912_dt_match);
 
 static const struct i2c_device_id lt8912_id[] = {
-	{ "lt8912" },
-	{}
+	{ .name = "lt8912" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lt8912_id);
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index f39d83a5ae37..84cb856480ec 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -772,8 +772,8 @@ static void lt9211_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lt9211_id[] = {
-	{ "lontium,lt9211" },
-	{},
+	{ .name = "lontium,lt9211" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lt9211_id);
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index b6a368f71285..fb34f661ee0a 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1229,8 +1229,8 @@ static void lt9611_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lt9611_id[] = {
-	{ "lontium,lt9611" },
-	{}
+	{ .name = "lontium,lt9611" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lt9611_id);
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 6625ba23761c..42a6503cd0f9 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -899,7 +899,7 @@ static void lt9611uxc_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lt9611uxc_id[] = {
-	{ "lontium,lt9611uxc" },
+	{ .name = "lontium,lt9611uxc" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index 25ff0a0acc93..4d244e6d4ed9 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -317,8 +317,8 @@ static void stdp4028_ge_b850v3_fw_remove(struct i2c_client *stdp4028_i2c)
 }
 
 static const struct i2c_device_id stdp4028_ge_b850v3_fw_i2c_table[] = {
-	{ "stdp4028_ge_fw" },
-	{}
+	{ .name = "stdp4028_ge_fw" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stdp4028_ge_b850v3_fw_i2c_table);
 
@@ -364,8 +364,8 @@ static void stdp2690_ge_b850v3_fw_remove(struct i2c_client *stdp2690_i2c)
 }
 
 static const struct i2c_device_id stdp2690_ge_b850v3_fw_i2c_table[] = {
-	{ "stdp2690_ge_fw" },
-	{}
+	{ .name = "stdp2690_ge_fw" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stdp2690_ge_b850v3_fw_i2c_table);
 
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index a9b4ac2defc9..f9eff8bfceb7 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -323,8 +323,8 @@ static void ptn3460_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ptn3460_i2c_table[] = {
-	{ "ptn3460" },
-	{}
+	{ .name = "ptn3460" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ptn3460_i2c_table);
 
diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 33844db753aa..3a2ec482037d 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -534,10 +534,10 @@ static void ps8622_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ps8622_i2c_table[] = {
-	/* Device type, max_lane_count */
-	{"ps8622", 1},
-	{"ps8625", 2},
-	{},
+	/* Device type, driver_data holds the maximal lane_count */
+	{ .name = "ps8622", .driver_data = 1 },
+	{ .name = "ps8625", .driver_data = 2 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ps8622_i2c_table);
 
diff --git a/drivers/gpu/drm/bridge/sii902x.c b/drivers/gpu/drm/bridge/sii902x.c
index f575b2dbe32b..9aac44ed5b67 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1235,7 +1235,7 @@ static const struct of_device_id sii902x_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, sii902x_dt_ids);
 
 static const struct i2c_device_id sii902x_i2c_ids[] = {
-	{ "sii9022" },
+	{ .name = "sii9022" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sii902x_i2c_ids);
diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index be67642ab7d3..9fef332db248 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -944,7 +944,7 @@ static const struct of_device_id sii9234_dt_match[] = {
 MODULE_DEVICE_TABLE(of, sii9234_dt_match);
 
 static const struct i2c_device_id sii9234_id[] = {
-	{ "SII9234" },
+	{ .name = "SII9234" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sii9234_id);
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 22c81b38b41e..b452748ad9db 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2374,7 +2374,7 @@ static const struct of_device_id sii8620_dt_match[] = {
 MODULE_DEVICE_TABLE(of, sii8620_dt_match);
 
 static const struct i2c_device_id sii8620_id[] = {
-	{ "sii8620" },
+	{ .name = "sii8620" },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index ce1b73214f26..54dfad357c26 100644
--- a/drivers/gpu/drm/bridge/tc358767.c
+++ b/drivers/gpu/drm/bridge/tc358767.c
@@ -2611,7 +2611,7 @@ static void tc_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tc358767_i2c_ids[] = {
-	{ "tc358767" },
+	{ .name = "tc358767" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tc358767_i2c_ids);
diff --git a/drivers/gpu/drm/bridge/tc358768.c b/drivers/gpu/drm/bridge/tc358768.c
index 0d85120fcc7a..a492ec9ea4ad 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1361,8 +1361,8 @@ static const struct regmap_config tc358768_regmap_config = {
 };
 
 static const struct i2c_device_id tc358768_i2c_ids[] = {
-	{ "tc358768" },
-	{ "tc358778" },
+	{ .name = "tc358768" },
+	{ .name = "tc358778" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tc358768_i2c_ids);
diff --git a/drivers/gpu/drm/bridge/tc358775.c b/drivers/gpu/drm/bridge/tc358775.c
index 728938f9dcb4..203dc738ecef 100644
--- a/drivers/gpu/drm/bridge/tc358775.c
+++ b/drivers/gpu/drm/bridge/tc358775.c
@@ -727,8 +727,8 @@ static void tc_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tc358775_i2c_ids[] = {
-	{ "tc358765", TC358765, },
-	{ "tc358775", TC358775, },
+	{ .name = "tc358765", .driver_data = TC358765 },
+	{ .name = "tc358775", .driver_data = TC358775 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tc358775_i2c_ids);
diff --git a/drivers/gpu/drm/bridge/tda998x_drv.c b/drivers/gpu/drm/bridge/tda998x_drv.c
index 16c745591175..0b966c9844e7 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -2064,7 +2064,7 @@ MODULE_DEVICE_TABLE(of, tda998x_dt_ids);
 #endif
 
 static const struct i2c_device_id tda998x_ids[] = {
-	{ "tda998x" },
+	{ .name = "tda998x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tda998x_ids);
diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index c16eb3a05cfa..c9f789e30687 100644
--- a/drivers/gpu/drm/bridge/ti-dlpc3433.c
+++ b/drivers/gpu/drm/bridge/ti-dlpc3433.c
@@ -389,7 +389,7 @@ static void dlpc3433_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id dlpc3433_id[] = {
-	{ "ti,dlpc3433" },
+	{ .name = "ti,dlpc3433" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, dlpc3433_id);
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index e6dbe51d0dba..f9fdbf48c6b3 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -1072,9 +1072,9 @@ static void sn65dsi83_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id sn65dsi83_id[] = {
-	{ "ti,sn65dsi83", MODEL_SN65DSI83 },
-	{ "ti,sn65dsi84", MODEL_SN65DSI84 },
-	{},
+	{ .name = "ti,sn65dsi83", .driver_data = MODEL_SN65DSI83 },
+	{ .name = "ti,sn65dsi84", .driver_data = MODEL_SN65DSI84 },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sn65dsi83_id);
 
diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
index 1da242f17413..5590ad230624 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -2116,8 +2116,8 @@ static int ti_sn65dsi86_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ti_sn65dsi86_id[] = {
-	{ "ti,sn65dsi86" },
-	{}
+	{ .name = "ti,sn65dsi86" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ti_sn65dsi86_id);
 
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index f0a14f52aaac..629ff7095e87 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -437,7 +437,7 @@ static void tfp410_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tfp410_i2c_ids[] = {
-	{ "tfp410" },
+	{ .name = "tfp410" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tfp410_i2c_ids);
-- 
2.55.0.11.g153666a7d9bb

