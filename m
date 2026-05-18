Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58EBCD4F52
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 11:12:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CF8810E142;
	Mon, 18 May 2026 11:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="LaRyfW9t";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BBE9210E142
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 11:12:18 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso1196698f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 04:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1779102737; x=1779707537;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=U4/++U9j8mYC/3Jzj1PcVr50bYvBfT6iMwOvy7pBLPM=;
 b=LaRyfW9tRFYQyWniSZusjs2n3xFSWuD0paFflWk7ZdX9CgMvMeroig/3tJ2ppxb8fR
 eKHFt19Ihh2jSRGFBNC3edGYDPO3QiP2vu7mKZE5QUeCqH2TdQp8dAJF6/leIsNN7Q/l
 1G8ZoGZhmRZtX6mZioYJqfq3upNYH/ZeYaR9lGtnxelKRlFg5nX7H20/lvosYVhn33FA
 hrYWMC+XKgN1aq9fNL3Rx3lWH/dt0dxBp8k2IVKvkYSf/XuwYcRXrLYu4gWJ7MiFs0ov
 UkW1XiqYwxLl4e/EX7OFjxlvBnw5xPFAffAT7sKqC3qFm0YH/ncReTRBeeaMA0OfG0ro
 Neng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779102737; x=1779707537;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U4/++U9j8mYC/3Jzj1PcVr50bYvBfT6iMwOvy7pBLPM=;
 b=keVHs4u6queF2C+OtftAlwkZ231RxP80tdcXzOdwDwig3nYiofZeXnqIHa7jQZnHGU
 2S5GmFz2KLCcLdO9m0Vu0c8YVp7fq7dPwiMLg0juAFD/aPRDxJvRW/OyZc4r3nD0sNcC
 +jUxwslyGf71TiQhqLSrdhLzaC37Jbhw+3QN9fk/VZCgBGkt1rlrr7r38uTE8R0yty2e
 oCOcC0U2YCumWCZ7zYnvnTn9rgaWDKYNDzRftDY1bzMn3RDGeBmEVJcapuBlmnvwtgmC
 w+KpWfoOjBB338mdOC7C0YB61InK8Ufm9g5CRAR9e/1LiylkblOnXT1xSBbMqtG0XlxW
 V18w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/KBxrSrdPWUIo0qu8IMIPUY+6M2aQNiVCyK7+KuXxL7OtQ2MqwO/8b1jiYv2JzZTpRD07gSweckYI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjA0Bs505B03YDl+FAyuGsWfb+z4QrvBV2BWWTd5t6GXxL16qz
 NNgWNWGluxiJom8E91mWfxjTDoZijKA5N2QsQiuasjTLKkdgrEbkifU16AKPGmBbj8M=
X-Gm-Gg: Acq92OFPf2EY1TQ1SvA8qHVoI8giqTZCdS7cymBU+pDrROe6hCiRyG0vNQAg3meq1ia
 VHYSp17kJLNcihQZDflw/yVr5Ua74Tmsn4rKQa2C9e/dZBbfzJ3VhjDRgv4MGIYrfXFgqHj6H83
 Ud1nUcKwAR6xu1rEEFiGUj/FSkvYLJRnWNL0lcz1S7xqhsBxh0XmwzV4DtHZDjTomrW6OmK7ceZ
 J5B2eN+3roXmbKp2ozmPOArUgZB/94G/1jp79krmuErlXZEwYGCNan5HASZjHFHdJOMfBy5DbdI
 RVCjVn64+O8mFPs0JBHeL1xWbly2h3VTGIoO/j95ksuLrlO6v+FUrBXrzA9hwpzpcXDzZUfHlnr
 gzn8FWRk54Sm8GGUeJNnhB42KTR2EmNAtu/VXPzh67oExWqkTydU5lfM494yKEluc5sBgdScY91
 1fssG7eG09JohY+9x7uXTMX1JfrCRpAUOf9Rn6hMa4QIGsUx7TjCZbYArJ3G72YgS/8Pzy+A07g
 2itjHQP8auw92+KRYIeiZW5ww==
X-Received: by 2002:a05:6000:1aca:b0:451:bbe4:b48e with SMTP id
 ffacd0b85a97d-45e5c57d380mr21724462f8f.5.1779102736933; 
 Mon, 18 May 2026 04:12:16 -0700 (PDT)
Received: from localhost
 (p200300f65f47db049367b55fc4056f2b.dip0.t-ipconnect.de.
 [2003:f6:5f47:db04:9367:b55f:c405:6f2b])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-45d9ed30110sm40072081f8f.13.2026.05.18.04.12.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 04:12:16 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?=
 <u.kleine-koenig@baylibre.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>,
 Helge Deller <deller@gmx.de>, Junjie Cao <caojunjie650@gmail.com>,
 Jianhua Lu <lujianhua000@gmail.com>, Flavio Suligoi <f.suligoi@asem.it>,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] backlight: Use named initializers for arrays of
 i2c_device_data
Date: Mon, 18 May 2026 13:12:03 +0200
Message-ID: <20260518111203.639603-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=10444;
 i=u.kleine-koenig@baylibre.com; h=from:subject;
 bh=K3nI7LF5tAwngbkcN/5y5N1EdW2D0ZhyMSO4iSSKwwc=;
 b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqCvQDGhiz+NaNyCL/bt09zi+ljomP6xQyEK03D
 Jw9Z6v71dyJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCagr0AwAKCRCPgPtYfRL+
 TuwGCACQmNoq+xBBztZ4JjEvMXVaDKp024W7I5M0OdibuvGqottuSIMsO6nKHTUe96WHjqNd8Na
 sVYXq+Ulvsx/qnzZ0eCVG8vZK0ADa8e3FANK8W9OKZo42Btyv5Zx8MehVXX/6chtHrH15023LE4
 4cvYYo5nDsZqsms8W37SGSj2x7R02rkHlHwblWeBbbBEKdRrm1t87X96cMfIW9sS/BypNQ4itz5
 ndCoRNt4tAZ+ARN4zDPJMAGfn05Gf7+i28Ro9jPoqv0ku7yEJbjKCbVuh+6u9VAsgyzAJzTfUSG
 Y3V6+zBFM3Fn0z1Ywn5IYB3gZG2RJHslickgak1do1X/WlBR
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
terminator.

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
	index 0123ca8157a8..dfb0b07500a7 100644
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
	-	                (struct ad5398_current_data_format *)id->driver_data;
	+	const struct ad5398_current_data_format *df = id->driver_data;

	 	chip = devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
	 	if (!chip)

that are an improvement for readability (again!) and it keeps some
properties of the pointers (here: being const) without having to pay
attention for that. (I didn't find a backlight driver that benefits, so
this is "only" a regulator driver example.)

My additional motivation for this effort is CHERI[1]. This is a hardware
extension that uses 128 bit pointers but unsigned long is still 64 bit.
So with CHERI you cannot store pointers in unsigned long variables.

Best regards
Uwe

[1] https://cheri-alliance.org/discover-cheri/
    https://lwn.net/Articles/1037974/
---
 drivers/video/backlight/adp8860_bl.c |  6 +++---
 drivers/video/backlight/adp8870_bl.c |  2 +-
 drivers/video/backlight/arcxcnn_bl.c |  2 +-
 drivers/video/backlight/aw99706.c    |  2 +-
 drivers/video/backlight/bd6107.c     |  2 +-
 drivers/video/backlight/ktz8866.c    |  4 ++--
 drivers/video/backlight/lm3509_bl.c  |  4 ++--
 drivers/video/backlight/lm3630a_bl.c |  4 ++--
 drivers/video/backlight/lm3639_bl.c  |  4 ++--
 drivers/video/backlight/lp855x_bl.c  | 14 +++++++-------
 drivers/video/backlight/lv5207lp.c   |  2 +-
 drivers/video/backlight/mp3309c.c    |  2 +-
 12 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/adp8860_bl.c b/drivers/video/backlight/adp8860_bl.c
index d4bbd7a7406b..09dd67702431 100644
--- a/drivers/video/backlight/adp8860_bl.c
+++ b/drivers/video/backlight/adp8860_bl.c
@@ -790,9 +790,9 @@ static SIMPLE_DEV_PM_OPS(adp8860_i2c_pm_ops, adp8860_i2c_suspend,
 			adp8860_i2c_resume);
 
 static const struct i2c_device_id adp8860_id[] = {
-	{ "adp8860", adp8860 },
-	{ "adp8861", adp8861 },
-	{ "adp8863", adp8863 },
+	{ .name = "adp8860", .driver_data = adp8860 },
+	{ .name = "adp8861", .driver_data = adp8861 },
+	{ .name = "adp8863", .driver_data = adp8863 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp8860_id);
diff --git a/drivers/video/backlight/adp8870_bl.c b/drivers/video/backlight/adp8870_bl.c
index e09e20492e7c..d009f2c8a11d 100644
--- a/drivers/video/backlight/adp8870_bl.c
+++ b/drivers/video/backlight/adp8870_bl.c
@@ -962,7 +962,7 @@ static SIMPLE_DEV_PM_OPS(adp8870_i2c_pm_ops, adp8870_i2c_suspend,
 			adp8870_i2c_resume);
 
 static const struct i2c_device_id adp8870_id[] = {
-	{ "adp8870" },
+	{ .name = "adp8870" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, adp8870_id);
diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlight/arcxcnn_bl.c
index 1d5a570cfe02..f46eeab02e90 100644
--- a/drivers/video/backlight/arcxcnn_bl.c
+++ b/drivers/video/backlight/arcxcnn_bl.c
@@ -382,7 +382,7 @@ static const struct of_device_id arcxcnn_dt_ids[] = {
 MODULE_DEVICE_TABLE(of, arcxcnn_dt_ids);
 
 static const struct i2c_device_id arcxcnn_ids[] = {
-	{"arc2c0608", ARC2C0608},
+	{ .name = "arc2c0608", .driver_data = ARC2C0608 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, arcxcnn_ids);
diff --git a/drivers/video/backlight/aw99706.c b/drivers/video/backlight/aw99706.c
index 938f352aaab7..18299faf06ad 100644
--- a/drivers/video/backlight/aw99706.c
+++ b/drivers/video/backlight/aw99706.c
@@ -443,7 +443,7 @@ static int aw99706_resume(struct device *dev)
 static DEFINE_SIMPLE_DEV_PM_OPS(aw99706_pm_ops, aw99706_suspend, aw99706_resume);
 
 static const struct i2c_device_id aw99706_ids[] = {
-	{ "aw99706" },
+	{ .name = "aw99706" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, aw99706_ids);
diff --git a/drivers/video/backlight/bd6107.c b/drivers/video/backlight/bd6107.c
index 74567af84e97..6778b4030b02 100644
--- a/drivers/video/backlight/bd6107.c
+++ b/drivers/video/backlight/bd6107.c
@@ -179,7 +179,7 @@ static void bd6107_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id bd6107_ids[] = {
-	{ "bd6107" },
+	{ .name = "bd6107" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, bd6107_ids);
diff --git a/drivers/video/backlight/ktz8866.c b/drivers/video/backlight/ktz8866.c
index 351c2b4d63ed..53c1301dbb8c 100644
--- a/drivers/video/backlight/ktz8866.c
+++ b/drivers/video/backlight/ktz8866.c
@@ -179,8 +179,8 @@ static void ktz8866_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id ktz8866_ids[] = {
-	{ "ktz8866" },
-	{}
+	{ .name = "ktz8866" },
+	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ktz8866_ids);
 
diff --git a/drivers/video/backlight/lm3509_bl.c b/drivers/video/backlight/lm3509_bl.c
index 24e1a19ff72d..53136c5e1460 100644
--- a/drivers/video/backlight/lm3509_bl.c
+++ b/drivers/video/backlight/lm3509_bl.c
@@ -311,8 +311,8 @@ static void lm3509_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3509_id[] = {
-	{ LM3509_NAME },
-	{}
+	{ .name = LM3509_NAME },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, lm3509_id);
diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backlight/lm3630a_bl.c
index 37651c2b9393..8f49e59ce374 100644
--- a/drivers/video/backlight/lm3630a_bl.c
+++ b/drivers/video/backlight/lm3630a_bl.c
@@ -596,8 +596,8 @@ static void lm3630a_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3630a_id[] = {
-	{ LM3630A_NAME },
-	{}
+	{ .name = LM3630A_NAME },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, lm3630a_id);
diff --git a/drivers/video/backlight/lm3639_bl.c b/drivers/video/backlight/lm3639_bl.c
index 37ccc631c498..ea748b80b737 100644
--- a/drivers/video/backlight/lm3639_bl.c
+++ b/drivers/video/backlight/lm3639_bl.c
@@ -403,8 +403,8 @@ static void lm3639_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lm3639_id[] = {
-	{ LM3639_NAME },
-	{}
+	{ .name = LM3639_NAME },
+	{ }
 };
 
 MODULE_DEVICE_TABLE(i2c, lm3639_id);
diff --git a/drivers/video/backlight/lp855x_bl.c b/drivers/video/backlight/lp855x_bl.c
index d191560ce285..43a2123d3a4d 100644
--- a/drivers/video/backlight/lp855x_bl.c
+++ b/drivers/video/backlight/lp855x_bl.c
@@ -570,13 +570,13 @@ static const struct of_device_id lp855x_dt_ids[] __maybe_unused = {
 MODULE_DEVICE_TABLE(of, lp855x_dt_ids);
 
 static const struct i2c_device_id lp855x_ids[] = {
-	{"lp8550", LP8550},
-	{"lp8551", LP8551},
-	{"lp8552", LP8552},
-	{"lp8553", LP8553},
-	{"lp8555", LP8555},
-	{"lp8556", LP8556},
-	{"lp8557", LP8557},
+	{ .name = "lp8550", .driver_data = LP8550 },
+	{ .name = "lp8551", .driver_data = LP8551 },
+	{ .name = "lp8552", .driver_data = LP8552 },
+	{ .name = "lp8553", .driver_data = LP8553 },
+	{ .name = "lp8555", .driver_data = LP8555 },
+	{ .name = "lp8556", .driver_data = LP8556 },
+	{ .name = "lp8557", .driver_data = LP8557 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lp855x_ids);
diff --git a/drivers/video/backlight/lv5207lp.c b/drivers/video/backlight/lv5207lp.c
index a205f004eab2..e643ab9c3536 100644
--- a/drivers/video/backlight/lv5207lp.c
+++ b/drivers/video/backlight/lv5207lp.c
@@ -131,7 +131,7 @@ static void lv5207lp_remove(struct i2c_client *client)
 }
 
 static const struct i2c_device_id lv5207lp_ids[] = {
-	{ "lv5207lp" },
+	{ .name = "lv5207lp" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lv5207lp_ids);
diff --git a/drivers/video/backlight/mp3309c.c b/drivers/video/backlight/mp3309c.c
index 9337110ce6e5..413cfe27dfd9 100644
--- a/drivers/video/backlight/mp3309c.c
+++ b/drivers/video/backlight/mp3309c.c
@@ -400,7 +400,7 @@ static const struct of_device_id mp3309c_match_table[] = {
 MODULE_DEVICE_TABLE(of, mp3309c_match_table);
 
 static const struct i2c_device_id mp3309c_id[] = {
-	{ "mp3309c" },
+	{ .name = "mp3309c" },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, mp3309c_id);

base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
-- 
2.47.3

