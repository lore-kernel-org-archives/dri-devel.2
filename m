Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB63606A31B
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Cg7Bcv0V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09BF210F2CD;
	Tue, 20 Oct 2026 07:36:26 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3707310E0BD
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 14:08:49 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso7014515e9.3
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 07:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792246127; x=1792850927; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qfOl1kjHpYXnvDQ7klGKtwkq44SiCg69dIWYFZz39rU=;
 b=Cg7Bcv0VdEFrpfpUTWCnY5+N+CD7ksMC20BJgnftypXL3dQJgIyq+byHGU03eMD9FO
 iyKT2ONYZrtndrnGaCR9jqTsNxccbVDPDcc8uyj8KBkkbRFriKqkum7ev1STPugk6GTv
 PNqSjhJUlIGdspiYbnYbKlnjLfNmevHLrs1yUMtmMz2reRhbScfAtjF4yOOH8j6aE7rP
 qZJoycExjks7Vbrn3iKWeapK/3GYf1E7cMpahcDWi/n+8LGGKZZPKo4CdUARji8q+MR8
 pgrf9gSD+9iqMgCqqKq5qEWq3b8kXft+x0N9VSy+DmPyGXWrvzjkmjZcACFTfA4sYyIA
 Xw9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792246127; x=1792850927;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qfOl1kjHpYXnvDQ7klGKtwkq44SiCg69dIWYFZz39rU=;
 b=UjIvlcKJKF47bcGy7g0OXVXoHhMFXr5H1HQUJw+ejUAQlYOew4dHAIElniNthpPrKi
 WJdCF4t/TxqUB4fbb05gZr/Rk3bdea6SmDuOXVfv3MJBm5vCHduJCbOCkR3PEDFufhSo
 nxPvHA840wZMVuR1hqcMRNyaeL6eJu3PMUS23Wt56cNGyL0rymvU65SgRus/DsYF6Jl3
 1LLGIfqQL5eO5kNVaYmh0a29LatvDxXGGxlM8TorYa7ZLkIdLfXQfkCXbCtM+Bn5IwbY
 e1acn24OLt8ZbvebSWkuEPUefV2qAPUSMg2Izs53UFyHKJWRYKZb0aFLeB81H/9OUOiy
 TCQA==
X-Forwarded-Encrypted: i=1;
 AKwUvByfJMVjqVxuIWxn9nsApCos3Wa3qENH+IsKP1UBuziV1bhCMMxiqVD+5DKOk+y88ZFXnSZJdOVNiW4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK6ZEjGZ0hmQua1KUU7hAPReKUq6qAv/zQOC9iiVnBylZZKF8R6
 oJHpIb7hGFwca/4U6BaI8xhK7nvoQlFfIABl9Ry+GzMCm7x3xJb7b54r
X-Gm-Gg: AYBFou1ttB//qOygfy2ouX0QtHWkxVFgW0XUqDyCRMcLrlvOhhzFNz2/BC2BFbWsNFk
 3IJZDFvjsHlQ1uRZbY+oN4ilCO9DFZE1zYlOHUmfKfMW50YyDYJbZgjPJfc3LgHhO6gISoPSd52
 geailO+mDYkBFhWLxgsVvt3BnVFhZhSTyNMHYI8ir0Lgu2hqSVqPYUVehEFm95/NAVwBNB+J+o9
 GsLJED6uzVNPzSnsiixHkxuRB4NwjDzxfWcY9P0kz++ddh7V3IWy8fog4uiFSfOk92PyfXtjIry
 LonkDMby2wfgeNJUGPx5O0brOq/Bzzo/WZhdQB2JI56Oi8Q7QS0FpWkXqVoLSco0Z6GzYHjXLnQ
 1SRRtinIDZ2Te86u5WDIbPeYPg1XtNPh4RqXP8UkB3b3P1otKJOmSePhvlAHncu8jdWo6/fVZ5o
 fl2pQs6F9j9Pwep4xG5YdLbhwyHVUEs7Egag5+YrIbKPaTJWoggTPcF7FPqNQlt8LaUQNccAx1i
 0uLJnguo8pVtBMFO1yB42W+fG5G9wZRx/yKoSQuAkjVfu3xQjeZHdGPtDWrPZeOPcbl908be0zH
 OQ==
X-Received: by 2002:a05:600c:468e:b0:4a0:12d7:4c88 with SMTP id
 5b1f17b1804b1-4a1d7625f71mr59997585e9.30.1792246127263; 
 Sat, 17 Oct 2026 07:08:47 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:08:46 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 7/7] Input: edt-ft5x06 - support following a DRM panel
Date: Sat, 17 Oct 2026 16:07:55 +0200
Message-ID: <20261017140827.290666-8-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017140827.290666-1-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 20 Oct 2026 07:36:08 +0000
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On touch and display driver (TDDI) chips such as the FT8722 the touch
controller shares its supply and reset with the display panel, so it
can only be accessed while the panel is powered and loses its state,
and for RAM-only parts its firmware, every time the panel goes off.

When the device tree links the touchscreen to its panel, register as a
DRM panel follower, like i2c-hid does.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 drivers/input/touchscreen/Kconfig      |   1 +
 drivers/input/touchscreen/edt-ft5x06.c | 156 ++++++++++++++++++++++++-
 2 files changed, 151 insertions(+), 6 deletions(-)

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 92840ea9c65f..b4fd55028a04 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -794,6 +794,7 @@ config TOUCHSCREEN_PENMOUNT
 config TOUCHSCREEN_EDT_FT5X06
 	tristate "EDT FocalTech FT5x06 I2C Touchscreen support"
 	depends on I2C
+	depends on DRM_PANEL || !DRM_PANEL
 	select REGMAP_I2C
 	help
 	  Say Y here if you have an EDT "Polytouch" touchscreen based
diff --git a/drivers/input/touchscreen/edt-ft5x06.c b/drivers/input/touchscreen/edt-ft5x06.c
index 7bcc48e07d62..b2fca6c37205 100644
--- a/drivers/input/touchscreen/edt-ft5x06.c
+++ b/drivers/input/touchscreen/edt-ft5x06.c
@@ -4,6 +4,7 @@
  * Daniel Wagener <daniel.wagener@kernelconcepts.de> (M09 firmware support)
  * Lothar Waßmann <LW@KARO-electronics.de> (DT support)
  * Dario Binacchi <dario.binacchi@amarulasolutions.com> (regmap support)
+ * Luka Panio <lukapanio@gmail.com> (SPI and DRM panel support)
  */
 
 /*
@@ -33,6 +34,9 @@
 #include <linux/uaccess.h>
 
 #include <linux/unaligned.h>
+#include <linux/workqueue.h>
+
+#include <drm/drm_panel.h>
 
 #include "edt-ft5x06.h"
 
@@ -150,6 +154,12 @@ struct edt_ft5x06_ts_data {
 	enum edt_ver version;
 	int (*boot)(struct device *dev, struct gpio_desc *reset_gpio);
 	u8 tdata_reg;
+
+	struct drm_panel_follower panel_follower;
+	struct work_struct panel_work;
+	bool is_panel_follower;
+	bool powered_off;
+	bool hw_initialized;
 	unsigned int crc_errors;
 	unsigned int header_errors;
 };
@@ -383,7 +393,7 @@ static ssize_t edt_ft5x06_setting_show(struct device *dev,
 
 	guard(mutex)(&tsdata->mutex);
 
-	if (tsdata->factory_mode)
+	if (tsdata->factory_mode || tsdata->powered_off)
 		return -EIO;
 
 	switch (tsdata->version) {
@@ -441,7 +451,7 @@ static ssize_t edt_ft5x06_setting_store(struct device *dev,
 
 	guard(mutex)(&tsdata->mutex);
 
-	if (tsdata->factory_mode)
+	if (tsdata->factory_mode || tsdata->powered_off)
 		return -EIO;
 
 	error = kstrtouint(buf, 0, &val);
@@ -1120,7 +1130,8 @@ static void edt_ft5x06_disable_regulators(void *arg)
 
 /*
  * Take the controller out of reset, identify it and register the input
- * device.
+ * device. Called from probe, or once the panel is up for controllers
+ * following a panel.
  */
 static int edt_ft5x06_ts_init_hw(struct edt_ft5x06_ts_data *tsdata)
 {
@@ -1206,9 +1217,117 @@ static int edt_ft5x06_ts_init_hw(struct edt_ft5x06_ts_data *tsdata)
 
 	edt_ft5x06_ts_prepare_debugfs(tsdata);
 
+	tsdata->hw_initialized = true;
+
+	return 0;
+}
+
+/*
+ * TDDI controllers share their power and reset with the display panel. When
+ * following a panel, power the touch controller down before the panel goes
+ * off and bring it back once the panel is up again.
+ */
+static void edt_ft5x06_panel_work(struct work_struct *work)
+{
+	struct edt_ft5x06_ts_data *tsdata =
+		container_of(work, struct edt_ft5x06_ts_data, panel_work);
+	int error;
+
+	guard(mutex)(&tsdata->mutex);
+
+	if (!tsdata->powered_off)
+		return;
+
+	if (!tsdata->hw_initialized) {
+		error = edt_ft5x06_ts_init_hw(tsdata);
+		if (error) {
+			/* try again the next time the panel comes up */
+			gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
+			dev_err(tsdata->dev,
+				"Failed to initialize the controller: %d\n",
+				error);
+			return;
+		}
+		goto out;
+	}
+
+	gpiod_set_value_cansleep(tsdata->reset_gpio, 0);
+
+	if (tsdata->boot) {
+		error = tsdata->boot(tsdata->dev, tsdata->reset_gpio);
+		if (error) {
+			dev_err(tsdata->dev,
+				"Failed to boot the controller: %d\n", error);
+			return;
+		}
+	} else {
+		msleep(300);
+	}
+
+	edt_ft5x06_restore_reg_parameters(tsdata);
+out:
+	tsdata->powered_off = false;
+	enable_irq(tsdata->irq);
+}
+
+static int edt_ft5x06_panel_prepared(struct drm_panel_follower *follower)
+{
+	struct edt_ft5x06_ts_data *tsdata =
+		container_of(follower, struct edt_ft5x06_ts_data, panel_follower);
+
+	/* Downloading firmware takes a while, don't hold up the panel */
+	schedule_work(&tsdata->panel_work);
+
 	return 0;
 }
 
+static int edt_ft5x06_panel_unpreparing(struct drm_panel_follower *follower)
+{
+	struct edt_ft5x06_ts_data *tsdata =
+		container_of(follower, struct edt_ft5x06_ts_data, panel_follower);
+
+	cancel_work_sync(&tsdata->panel_work);
+
+	guard(mutex)(&tsdata->mutex);
+
+	if (tsdata->powered_off)
+		return 0;
+
+	disable_irq(tsdata->irq);
+	gpiod_set_value_cansleep(tsdata->reset_gpio, 1);
+	tsdata->powered_off = true;
+
+	return 0;
+}
+
+static const struct drm_panel_follower_funcs edt_ft5x06_panel_follower_funcs = {
+	.panel_prepared = edt_ft5x06_panel_prepared,
+	.panel_unpreparing = edt_ft5x06_panel_unpreparing,
+};
+
+static void edt_ft5x06_cancel_panel_work(void *data)
+{
+	struct edt_ft5x06_ts_data *tsdata = data;
+
+	cancel_work_sync(&tsdata->panel_work);
+}
+
+static int edt_ft5x06_register_panel_follower(struct edt_ft5x06_ts_data *tsdata)
+{
+	struct device *dev = tsdata->dev;
+	int error;
+
+	INIT_WORK(&tsdata->panel_work, edt_ft5x06_panel_work);
+	error = devm_add_action_or_reset(dev, edt_ft5x06_cancel_panel_work,
+					 tsdata);
+	if (error)
+		return error;
+
+	tsdata->panel_follower.funcs = &edt_ft5x06_panel_follower_funcs;
+
+	return devm_drm_panel_add_follower(dev, &tsdata->panel_follower);
+}
+
 int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 		     const struct edt_ft5x06_chip_data *chip_data, u16 bustype,
 		     struct dentry *debugfs)
@@ -1331,14 +1450,24 @@ int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 	tsdata->factory_mode = false;
 	dev_set_drvdata(dev, tsdata);
 
-	error = edt_ft5x06_ts_init_hw(tsdata);
-	if (error)
-		return error;
+	/*
+	 * A controller sharing its power with a panel can only be accessed
+	 * once the panel is up, so leave it in reset and do the rest of the
+	 * initialization from the panel follower callback.
+	 */
+	tsdata->is_panel_follower = drm_is_panel_follower(dev);
+	if (!tsdata->is_panel_follower) {
+		error = edt_ft5x06_ts_init_hw(tsdata);
+		if (error)
+			return error;
+	}
 
 	irq_flags = irq_get_trigger_type(irq);
 	if (irq_flags == IRQF_TRIGGER_NONE)
 		irq_flags = IRQF_TRIGGER_FALLING;
 	irq_flags |= IRQF_ONESHOT;
+	if (tsdata->is_panel_follower)
+		irq_flags |= IRQF_NO_AUTOEN;
 
 	error = devm_request_threaded_irq(dev, irq, NULL, edt_ft5x06_ts_isr,
 					  irq_flags, dev_name(dev), tsdata);
@@ -1347,6 +1476,14 @@ int edt_ft5x06_probe(struct device *dev, struct regmap *regmap, int irq,
 		return error;
 	}
 
+	if (tsdata->is_panel_follower) {
+		tsdata->powered_off = true;
+		error = edt_ft5x06_register_panel_follower(tsdata);
+		if (error)
+			return dev_err_probe(dev, error,
+					     "failed to follow the panel\n");
+	}
+
 	dev_dbg(dev,
 		"EDT FT5x06 initialized: IRQ %d, WAKE pin %d, Reset pin %d.\n",
 		irq,
@@ -1374,6 +1511,10 @@ static int edt_ft5x06_ts_suspend(struct device *dev)
 	if (device_may_wakeup(dev))
 		return 0;
 
+	/* The panel powers us down and up */
+	if (tsdata->is_panel_follower)
+		return 0;
+
 	if (tsdata->suspend_mode == EDT_PMODE_NOT_SUPPORTED)
 		return 0;
 
@@ -1415,6 +1556,9 @@ static int edt_ft5x06_ts_resume(struct device *dev)
 	if (device_may_wakeup(dev))
 		return 0;
 
+	if (tsdata->is_panel_follower)
+		return 0;
+
 	if (tsdata->suspend_mode == EDT_PMODE_NOT_SUPPORTED)
 		return 0;
 
-- 
2.55.0

