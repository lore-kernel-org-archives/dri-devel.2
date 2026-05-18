Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6E7DCD4F3C
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 10:04:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3774510E779;
	Mon, 18 May 2026 10:04:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="dWl86r6D";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2311010E779
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 10:04:14 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-44509921fbcso1141292f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 03:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779098653; x=1779703453;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=jOSXkeYhWWRVxKTxIVGG46JYBEYcgVxXyEaywCvddtQ=;
 b=dWl86r6DwTOeNjkvGDaM247MR99v4UQ/DErL2K48ppkD3QdtyQRS6f2CtLS3u0ig+4
 yxDApM/poSY1W4BL9eioWanMC6avGfZ62sZtBcnDOUhiDmILTqX1hpw8LTtfmXZHm3sh
 82srcOHsrtE4eeenE5VoGf0iMMksz5q5PBm41F+q6q4Q2NRmMC3v5m8W1kYipk7pfhOT
 a89FgyNQfHMJMLtqtDQiW/QL99YYCeuAgCuv1F20oS23RsYxvbHJr/DQKG+60tzkc4lh
 kTFDiylfzxDZG/RBXNzoQyVb46xRGCF3BIiumB5QWAn/N6ZKC2voxy+wmgoOOap3D2rJ
 YVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779098653; x=1779703453;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jOSXkeYhWWRVxKTxIVGG46JYBEYcgVxXyEaywCvddtQ=;
 b=qquVvdHWy59TFkgaEoxAN5SVMy++0lN1Yx3g08q4jVtf5JY2bhUOAc3bxLp/8N4AHQ
 cpaHfHjtXua88EAcXRP2UEbUiclbCfJGBUkdI8iORwb5IzP517BPgw8AKUCl6gM0Er2f
 0P1z4F/CzVMEg0hr8hOcXZ7fO46IkZWtYc1MFsfjco2CornZyJwSVfZN6xV7dcYkUdyq
 12NCL+Jm6m702Iuh4mz5ioOnVCcGqRcRWAlj/utDdTWJG1YNh3hv0k1SdpYmpI/5XTBU
 MBs6Dm8AaE6WZxgCMGLh7zzWwOdno6Q/9DBUSN/1P5WlwyGEOHxzEmwir86G1p6eWCGX
 sBFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ92ZMvdFqTNKPFW1QTDVFh5GEgTzhJfSjpYx9aNC6Sl4llLA9Ki8esN0m5srPDLxsRHW6+EFu7aYoE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzmIRUVc8nctvI0mM+2xTbysHGuJIYYLZAC1rh6vjbCMEKReIAt
 GoKSrsTk46LkLr2gTPNiiMmfaxSkOAx+29eBgZaptCcvePaCAzjywkxx8IU12rIcjAw=
X-Gm-Gg: Acq92OFFsLvwlVJM3bxlf67yXX//NVWrhAbr0J7dpK2ZTMu+WZ1KJRd2Zw2vKrLD98v
 nlbDKCa9YXgRuzZs3RjoF6QG0ioK41QhmBZq/74VF9hQH78LbmUnZttzQ00ngawDkOuBafi+ZFV
 vqVUciO53TlVxC3QISN1xnWe7cuEeUMYvotEWfoflLX01GvBY0PVm/XdqQACLwCajg+9Ht/OfR5
 gT8ww4+y34eWYxppi8irDeXhswRR+txPkLu2q1t4RWUrhsA0KpFZItNcjQVCCgu5WtQZnQ1Uhve
 AelMLKyziVGunFwnGGn8S+Fa8PHzHO49TAQ0Vo6ddfCLAWnPxt5NlnSehM+T2qXIvDkB4TEQWpN
 L5C9ZhAyeoP01z+ahRIoP63pM33Hh3lCF6tM88ST0eVsp1A5zaqrcUMg5bsh2bY7vb87m7f4m8f
 YRynxyVqBhkjrdv4+OzITAKEkmkhypBLODipUzACFnQGr1I70nv8WbRFahOkxQmNCh88R3fJvxw
 MUkYjtirQZWk3s=
X-Received: by 2002:a5d:5d01:0:b0:43d:73d4:b34 with SMTP id
 ffacd0b85a97d-45e5c5a10b0mr22140858f8f.16.1779098653156; 
 Mon, 18 May 2026 03:04:13 -0700 (PDT)
Received: from localhost
 (p200300f65f47db049367b55fc4056f2b.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:9367:b55f:c405:6f2b])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45d9ec3ac86sm35770829f8f.14.2026.05.18.03.04.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 03:04:12 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jagan Teki <jagan@amarulasolutions.com>, Liu Ying <victor.liu@nxp.com>,
 Adrien Grassein <adrien.grassein@gmail.com>,
 Peter Senna Tschudin <peter.senna@gmail.com>, Ian Ray <ian.ray@ge.com>,
 Martyn Welch <martyn.welch@collabora.co.uk>,
 Russell King <linux@armlinux.org.uk>,
 Douglas Anderson <dianders@chromium.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 Biju Das <biju.das.jz@bp.renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Manikandan Muralidharan <manikandan.m@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Andy Yan <andy.yan@rock-chips.com>, Xin Ji <xji@analogixsemi.com>,
 Loic Poulain <loic.poulain@oss.qualcomm.com>,
 Fei Shao <fshao@chromium.org>, Arnd Bergmann <arnd@arndb.de>,
 Kees Cook <kees@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org
Subject: [PATCH] drm: Use named initializers for arrays of i2c_device_data
Date: Mon, 18 May 2026 12:04:01 +0200
Message-ID: <20260518100401.631351-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=23309;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=NY8BtdzWvpADO08ryEhEVi8TgPk46fqDG0pSvXht6Bs=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqCuQRjr1LDtFZl58pChAmvPbH1e2DQ2fTHj+Rj
 YT7+EA7h4aJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagrkEQAKCRCPgPtYfRL+
 TrtyCACMmvVqsuXGqHg+z9/jVGE3HJ9fezC+zt8Ev7dbvXPPt9by/M4INs61JsORt4A9D72UsyZ
 k6peo3khnMZid6eUCW8IY5TL0A4IsnLANZRHEta2oStz8KeHzQshrrencMMqjNKKXUiniOW7jnC
 YnbA2JGvJaScLikmPuNNzHxQdIaNB25AMYEG5VWmAq65s8J3MUTJ28Vc4bXn12tByPKnuWQjYXW
 Yns5dTu4lYv5/au4tnt5SG4APjw51ypWHFmZW3/QyBJKlnJeojPXPy7USguPzIGySB8KWuwmmeh
 5fuVJNs1aw+4oHZ0SRhg0bhtsO9rsY/rgvZUhMmipd2L/83l
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

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
Hello,

the mentioned change to i2c_device_id is the following:

	diff --git a/include/linux/mod_devicetable.h b/include/linux/mod_devicetable.h
	index 23ff24080dfd..aebd3a5e90af 100644
	--- a/include/linux/mod_devicetable.h
	+++ b/include/linux/mod_devicetable.h
	@@ -477,7 +477,11 @@ struct rpmsg_device_id {
	 
	 struct i2c_device_id {
		char name[I2C_NAME_SIZE];
	-	kernel_ulong_t driver_data;	/* Data private to the driver */
	+	union {
	+		/* Data private to the driver */
	+		kernel_ulong_t driver_data;
	+		const void *driver_data_ptr;
	+	};
	 };
	 
	 /* pci_epf */

and this requires that .driver_data is assigned via a named initializer
for static data. This requirement isn't a bad one because named
initializers are also much better readable than list initializers.

The union added to struct i2c_device_id enables further cleanups like:

	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
	index 0123ca8157a8..84272ba65d08 100644
	--- a/drivers/regulator/ad5398.c
	+++ b/drivers/regulator/ad5398.c
	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
	 static const struct ad5398_current_data_format df_10_4_120 = {10, 4, 0, 120000};
	 
	 static const struct i2c_device_id ad5398_id[] = {
	-	{ .name = "ad5398", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	-	{ .name = "ad5821", .driver_data = (kernel_ulong_t)&df_10_4_120 },
	+	{ .name = "ad5398", .driver_data_ptr = &df_10_4_120 },
	+	{ .name = "ad5821", .driver_data_ptr = &df_10_4_120 },
		{ }
	 };
	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
		struct regulator_init_data *init_data = dev_get_platdata(&client->dev);
		struct regulator_config config = { };
		struct ad5398_chip_info *chip;
	-	const struct ad5398_current_data_format *df =
	-			(struct ad5398_current_data_format *)id->driver_data;
	+	const struct ad5398_current_data_format *df = id->driver_data_ptr;
	 
		chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
		if (!chip)

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find a nice driver below drivers/gpu that
benefits, so this is "only" a regulator driver example.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

I was unsure if I should split the patch. I guess doing all of
drivers/gpu/drm/bridge together is fine, please tell if I should split
off drivers/gpu/drm/nouveau/ and/or drivers/gpu/drm/sitronix/.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/

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
 drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c      |  2 +-
 drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c      |  2 +-
 drivers/gpu/drm/sitronix/st7571-i2c.c                  |  4 ++--
 29 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
index 6bd76c1fb007..e960ddd96ac4 100644
--- a/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
+++ b/drivers/gpu/drm/bridge/adv7511/adv7511_drv.c
@@ -1470,11 +1470,11 @@ static const struct adv7511_chip_info adv7535_chip_info = {
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
index f3fe47b12edc..f0040b124b8f 100644
--- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
+++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
@@ -766,7 +766,7 @@ static void anx6345_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id anx6345_id[] = {
-	{ "anx6345" },
+	{ .name = "anx6345" },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(i2c, anx6345_id);
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 54b02242d6db..8b5748af8c55 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -2992,8 +2992,8 @@ static void anx7625_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id anx7625_id[] = {
-	{ "anx7625" },
-	{}
+	{ .name = "anx7625" },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, anx7625_id);
diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 814713c5bea9..d389270f5463 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -787,8 +787,8 @@ static struct mipi_dsi_driver chipone_dsi_driver = {
 };
 
 static const struct i2c_device_id chipone_i2c_id[] = {
-	{ "chipone,icn6211" },
-	{},
+	{ .name = "chipone,icn6211" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, chipone_i2c_id);
 
diff --git a/drivers/gpu/drm/bridge/chrontel-ch7033.c b/drivers/gpu/drm/bridge/chrontel-ch7033.c
index 54d49d4882c8..c036337e3064 100644
--- a/drivers/gpu/drm/bridge/chrontel-ch7033.c
+++ b/drivers/gpu/drm/bridge/chrontel-ch7033.c
@@ -598,7 +598,7 @@ static const struct of_device_id ch7033_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, ch7033_dt_ids);
 
 static const struct i2c_device_id ch7033_ids[] = {
-	{ "ch7033" },
+	{ .name = "ch7033" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ch7033_ids);
diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 4f3ebb7af4d4..49af808e4862 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -913,7 +913,7 @@ static const struct of_device_id it6263_of_match[] = {
 MODULE_DEVICE_TABLE(of, it6263_of_match);
 
 static const struct i2c_device_id it6263_i2c_ids[] = {
-	{ "it6263" },
+	{ .name = "it6263" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, it6263_i2c_ids);
diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index a094803ba7aa..f6c3d4257e3c 100644
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
index 18fac6a46db4..3b13b28eab6e 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8713sx.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8713sx.c
@@ -570,7 +570,7 @@ static void lt8713sx_remove(struct i2c_client *client)
 }
 
 static struct i2c_device_id lt8713sx_id[] = {
-	{ "lontium,lt8713sx", 0 },
+	{ .name = "lontium,lt8713sx" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt8912b.c b/drivers/gpu/drm/bridge/lontium-lt8912b.c
index 8a0b48efca58..d22e4ec8f644 100644
--- a/drivers/gpu/drm/bridge/lontium-lt8912b.c
+++ b/drivers/gpu/drm/bridge/lontium-lt8912b.c
@@ -815,8 +815,8 @@ static const struct of_device_id lt8912_dt_match[] = {
 MODULE_DEVICE_TABLE(of, lt8912_dt_match);
 
 static const struct i2c_device_id lt8912_id[] = {
-	{ "lt8912" },
-	{}
+	{ .name = "lt8912" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lt8912_id);
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 03fc8fd10f20..df9ad691d2cf 100644
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
index 4517aee83332..ea393207060c 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -1226,8 +1226,8 @@ static void lt9611_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lt9611_id[] = {
-	{ "lontium,lt9611" },
-	{}
+	{ .name = "lontium,lt9611" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lt9611_id);
 
diff --git a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
index 11aab07d88df..a08132fe1b50 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611uxc.c
@@ -893,7 +893,7 @@ static void lt9611uxc_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lt9611uxc_id[] = {
-	{ "lontium,lt9611uxc" },
+	{ .name = "lontium,lt9611uxc" },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
index c9e6505cbd88..89d1c0796f19 100644
--- a/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
+++ b/drivers/gpu/drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c
@@ -310,8 +310,8 @@ static void stdp4028_ge_b850v3_fw_remove(struct i2c_client *stdp4028_i2c)
 }
 
 static const struct i2c_device_id stdp4028_ge_b850v3_fw_i2c_table[] = {
-	{ "stdp4028_ge_fw" },
-	{}
+	{ .name = "stdp4028_ge_fw" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stdp4028_ge_b850v3_fw_i2c_table);
 
@@ -357,8 +357,8 @@ static void stdp2690_ge_b850v3_fw_remove(struct i2c_client *stdp2690_i2c)
 }
 
 static const struct i2c_device_id stdp2690_ge_b850v3_fw_i2c_table[] = {
-	{ "stdp2690_ge_fw" },
-	{}
+	{ .name = "stdp2690_ge_fw" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, stdp2690_ge_b850v3_fw_i2c_table);
 
diff --git a/drivers/gpu/drm/bridge/nxp-ptn3460.c b/drivers/gpu/drm/bridge/nxp-ptn3460.c
index 7acb11f16dc1..ae0becdc388a 100644
--- a/drivers/gpu/drm/bridge/nxp-ptn3460.c
+++ b/drivers/gpu/drm/bridge/nxp-ptn3460.c
@@ -318,8 +318,8 @@ static void ptn3460_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ptn3460_i2c_table[] = {
-	{ "ptn3460" },
-	{}
+	{ .name = "ptn3460" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ptn3460_i2c_table);
 
diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index f879a1df077d..b3fc2b3cf93b 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -528,10 +528,10 @@ static void ps8622_remove(struct i2c_client *client)
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
index 12497f5ce4ff..938f245a2fda 100644
--- a/drivers/gpu/drm/bridge/sii902x.c
+++ b/drivers/gpu/drm/bridge/sii902x.c
@@ -1237,7 +1237,7 @@ static const struct of_device_id sii902x_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, sii902x_dt_ids);
 
 static const struct i2c_device_id sii902x_i2c_ids[] = {
-	{ "sii9022" },
+	{ .name = "sii9022" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sii902x_i2c_ids);
diff --git a/drivers/gpu/drm/bridge/sii9234.c b/drivers/gpu/drm/bridge/sii9234.c
index bb1bed03eb5b..a9dce523a9c6 100644
--- a/drivers/gpu/drm/bridge/sii9234.c
+++ b/drivers/gpu/drm/bridge/sii9234.c
@@ -945,7 +945,7 @@ static const struct of_device_id sii9234_dt_match[] = {
 MODULE_DEVICE_TABLE(of, sii9234_dt_match);
 
 static const struct i2c_device_id sii9234_id[] = {
-	{ "SII9234" },
+	{ .name = "SII9234" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sii9234_id);
diff --git a/drivers/gpu/drm/bridge/sil-sii8620.c b/drivers/gpu/drm/bridge/sil-sii8620.c
index 982306eb4f0a..6daf745fc608 100644
--- a/drivers/gpu/drm/bridge/sil-sii8620.c
+++ b/drivers/gpu/drm/bridge/sil-sii8620.c
@@ -2370,7 +2370,7 @@ static const struct of_device_id sii8620_dt_match[] = {
 MODULE_DEVICE_TABLE(of, sii8620_dt_match);
 
 static const struct i2c_device_id sii8620_id[] = {
-	{ "sii8620" },
+	{ .name = "sii8620" },
 	{ }
 };
 
diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/tc358767.c
index 4097fef4b86b..1158ae151da0 100644
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
index fbdc44e16229..aef0c7de21e1 100644
--- a/drivers/gpu/drm/bridge/tc358768.c
+++ b/drivers/gpu/drm/bridge/tc358768.c
@@ -1249,8 +1249,8 @@ static const struct regmap_config tc358768_regmap_config = {
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
index 366b12db0e7c..ea3e9b693c04 100644
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
index d9b388165de1..9471c0208fea 100644
--- a/drivers/gpu/drm/bridge/tda998x_drv.c
+++ b/drivers/gpu/drm/bridge/tda998x_drv.c
@@ -2059,7 +2059,7 @@ MODULE_DEVICE_TABLE(of, tda998x_dt_ids);
 #endif
 
 static const struct i2c_device_id tda998x_ids[] = {
-	{ "tda998x" },
+	{ .name = "tda998x" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tda998x_ids);
diff --git a/drivers/gpu/drm/bridge/ti-dlpc3433.c b/drivers/gpu/drm/bridge/ti-dlpc3433.c
index b07f7c9d5890..e61548d122e4 100644
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
index 17a885244e1e..9eb8ea5c164b 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -1063,9 +1063,9 @@ static void sn65dsi83_remove(struct i2c_client *client)
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
index 98d64ad791d0..d64c4c0bcbaf 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
@@ -2118,8 +2118,8 @@ static int ti_sn65dsi86_probe(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ti_sn65dsi86_id[] = {
-	{ "ti,sn65dsi86" },
-	{}
+	{ .name = "ti,sn65dsi86" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ti_sn65dsi86_id);
 
diff --git a/drivers/gpu/drm/bridge/ti-tfp410.c b/drivers/gpu/drm/bridge/ti-tfp410.c
index 3b6b0e92cf89..85dc5e77b712 100644
--- a/drivers/gpu/drm/bridge/ti-tfp410.c
+++ b/drivers/gpu/drm/bridge/ti-tfp410.c
@@ -435,7 +435,7 @@ static void tfp410_i2c_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id tfp410_i2c_ids[] = {
-	{ "tfp410" },
+	{ .name = "tfp410" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, tfp410_i2c_ids);
diff --git a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
index 976ed59a86e4..96dabdb38c4b 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/ch7006_drv.c
@@ -486,7 +486,7 @@ static int ch7006_encoder_init(struct i2c_client *client,
 }
 
 static const struct i2c_device_id ch7006_ids[] = {
-	{ "ch7006" },
+	{ .name = "ch7006" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ch7006_ids);
diff --git a/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c b/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
index 7f402b901977..2324507eb5f3 100644
--- a/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
+++ b/drivers/gpu/drm/nouveau/dispnv04/i2c/sil164_drv.c
@@ -414,7 +414,7 @@ sil164_encoder_init(struct i2c_client *client,
 }
 
 static const struct i2c_device_id sil164_ids[] = {
-	{ "sil164" },
+	{ .name = "sil164" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, sil164_ids);
diff --git a/drivers/gpu/drm/sitronix/st7571-i2c.c b/drivers/gpu/drm/sitronix/st7571-i2c.c
index 44bc94be33d6..be6fbed8adaa 100644
--- a/drivers/gpu/drm/sitronix/st7571-i2c.c
+++ b/drivers/gpu/drm/sitronix/st7571-i2c.c
@@ -134,8 +134,8 @@ static const struct of_device_id st7571_of_match[] = {
 MODULE_DEVICE_TABLE(of, st7571_of_match);
 
 static const struct i2c_device_id st7571_id[] = {
-	{ "st7567", 0 },
-	{ "st7571", 0 },
+	{ .name = "st7567" },
+	{ .name = "st7571" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, st7571_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
prerequisite-patch-id: 7779c63f16ef6f7247cdb71c89e66b27e299eb74
prerequisite-patch-id: 6f920b6f8c31dc0ad1689200c37680755c20ce8b
prerequisite-patch-id: 1fd68e883664147052540eea19769ea9e92d0138
prerequisite-patch-id: fff07090df18a39a361bbb091a3f17223b4606b4
prerequisite-patch-id: a935aab66aa9896437ab9d757ef9fdc859d22495
prerequisite-patch-id: d0d54f7acecd560cdeb6ea0c0e5ae77a50695d68
prerequisite-patch-id: d7876560b3bb9b05ac462d0a9b09b50efeb9b5e1
prerequisite-patch-id: 65531f0504ac1885c6c4ed6be0e6a206a9795d5b
prerequisite-patch-id: ec83e7e18d66da9ca677b5c8180a22bf3717c8fb
prerequisite-patch-id: e33193d1a91f5819128db924c080caf1c5198667
prerequisite-patch-id: c8862be402a445f30b9f5c91b07afdc840e7e21f
prerequisite-patch-id: 33c001d1b8ecaf57ebe53c321d82d671bc82b647
prerequisite-patch-id: a59a578f49eb5147623aab9fdcacba405b9c8353
prerequisite-patch-id: 5eef512b8a5a1ec1848a939928168dbb719ca72e
prerequisite-patch-id: 04746bfdfe146af71d0c41e225978fb42ce977f5
prerequisite-patch-id: f8aeb0b768ae718aa0dab188fbad671aa4c76501
prerequisite-patch-id: 8e0b48a5d5f8bb91933d440eda8f065590e5ca97
prerequisite-patch-id: 5ca261e980415013434edc099b6f741b7a96c7a8
prerequisite-patch-id: 912c3a7f7fa847c59d499e004965b805a63c8836
prerequisite-patch-id: acf784c7c03d3cd14a8a19610a6d8995e2b5da6d
prerequisite-patch-id: 09a95efff7875781ceed199c60204a2603960f4f
prerequisite-patch-id: 8051fbf0a60e5e9d34f5e7623a5159d32fbc511d
prerequisite-patch-id: c4897ca0762d01cd5e8cb6e761e5ad95eb9de918
prerequisite-patch-id: eb0120090b9fd1e1f668919cf1d81cdf1b684b20
prerequisite-patch-id: 239c0e25dae78755bb553eb9049190f6ed6c056a
prerequisite-patch-id: d988f27ca0fac3a2b06cc8e465aef5e0a4f09bd3
prerequisite-patch-id: 8fceffb98fa11bf1e709a51022afa05eb12236bc
prerequisite-patch-id: 3575869dc475ff7191d314632d496cc67aabed53
prerequisite-patch-id: 8916058071bcbde1a4d06c6a8981c443132168f7
prerequisite-patch-id: 7f29acd91e1c8b8d4f21152cbcb8a8b0bdb6f963
prerequisite-patch-id: 65cf39c97cc086b6a89965079cccb896f089a0cb
prerequisite-patch-id: 915b7a2276c5a38944107c84bb282271d0bf28f4
prerequisite-patch-id: 76d499a624150588f7ef07dc087e70eca6f33419
-- 
2.47.3

