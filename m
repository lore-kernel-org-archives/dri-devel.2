Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C046606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 08:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yJBeKBPU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 918DC10E3E3;
	Wed, 18 Nov 2026 08:23:06 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 009E110E5C9
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 12:39:57 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a5b2be99a8so32235505e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 04:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794919196; x=1795523996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aJFaa+PuDhZz0tEI6GPK/mgT16WcMW99XS64dcpzMzA=;
 b=yJBeKBPU4rakCUCeQ7VrIJ/dTRKDz2LEV2M5yPPwvE3YlzRcMcQXJzNwf+45rpo+H9
 CV4d2vZxH3xhT5OBbGoDvG6tjNshr9NE1mIvdcnaKSn9+pBFdyCiZT/T8rhzgQli4BwB
 FcT6exVEzFQlPPSz//LOacOdsE7Ve/WEWIeRCknmPsoB1RWJEw3kQIa+UzEph3rOxsd8
 Mqr3l8jfhhzdgkTkBF0PQ6NojpHUtZ0ZUDqZVLUFNvk4rj98s5tSzOFCrmQJeMULqBem
 2XXYgfTtRw7ei9nNDPpJpdvPR3I36LmWs0A60OSOwfLvD0Pg/2rZRRxzoiEyexUdzkvx
 WZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794919196; x=1795523996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aJFaa+PuDhZz0tEI6GPK/mgT16WcMW99XS64dcpzMzA=;
 b=gbWfvrVj0a+iVhWWRt5SZ3CrBoUwXetII8qq9oRFqPEiid6UlXyfIRY7YTlOd3IgcS
 zr7t8PgeZDEOJIPjs4sT57vXBDWITeAZQ1aMYf+QWQzuiYfVfs9pYDFaeAQK0sJxZ7x4
 jbS7Wi9mOip754L2L1IYjx9ncfN7hdEEK265pUFo5hAlIgONndYj+CqniN9+oMFK04DI
 NXbqewTXVYbNbJ7qY7nd4BuJS0wG/fMwAIDj/Mfz8EKwKyYK4c7oc1nRRaH3l/tLlzwe
 dwzogpdrrOuwe+uxYaTfrV/v2DAsSeuIkZueGAk7gjsBBfD9ZECmTq0TBxlMQazNJAMM
 Wzig==
X-Forwarded-Encrypted: i=1;
 AL+hErHmim/rO+n9UHV5jzqdSKB9AJPptBjoIzdFTFGawaQ+LLdcJJTiTUx1D9urDIp2oeEF8fbBal2jvWs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+LxkXv2W0M09deNgW5X7xa+vxfv3ugxetl8yGjkVCEfKIeuNdq
 hiDtnMvn+Z9/QZVqMuCKj28/28keJ2LGB//SFI40CR3YEr7KlZUmikxD
X-Gm-Gg: AYBFou0OcYMyhZ5fdjX7KjXhhMNCZctITG6Sl1zpnizeiQb3BH6WOqOTsxlGqH8Y+Mf
 tpdD0AY6QviDZv2cczOccsELXinkw9Zax6MxYTcNJAVj3LRGqB0C6FtRp3Bv65aRSH63C0THfjp
 PCwt9PFJHwoO4fmxp4yaz7QOGuN5RoKwg3mtCnK4qeRPDCasK3D1vaMF02YrOaUbPwdhJaDyVKy
 aJqNwh4t8JAPAH7MAZh8PYsI5yHhIKaQvwpBlLj528pZa5Au3wezPwW8BSsHLhsteHrU+hKggO7
 fecgR58iGNAltOEkC6HvWnO7llfbauWHIg1XvulWH9qKLqlofrM/Ubs5uawMdDJU1Nrpmqzd5ho
 3Ilf8BQSzB4PpIB0MoH1IDsMufzvEkjavhtAf009BywLUyFMXjuBz/d4hf3ZkKTwpJCdh4UTrTi
 5LXla83rgtXaWlHzIM4DpFhUDF7JUG2Yq75Wr8Gy0GNTLxbQJwACSmtMwwp91A9hFfhCyVEwTgG
 yWw1hFgheuhB7qy/rjV/c8cGsSMXZQnUwqbR2/j+9hKfax3LeXUUE2QMNDWuDgMI+/aQCmlD4oX
 r5T/zavc7tg5SYXJz0G1IQiKiel3MIQzPe5UAx9UnxDaQPUmhoA/v09ksMhhPKMJ/GNvzA==
X-Received: by 2002:a05:600c:4e43:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4bb559f24ffmr285704105e9.1.1794919196241; 
 Tue, 17 Nov 2026 04:39:56 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (94-21-223-203.pool.digikabel.hu.
 [94.21.223.203]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f8154sm71474905e9.4.2026.11.17.04.39.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 04:39:55 -0800 (PST)
From: rofikkerneldev <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 rofikkerneldev <rofikcoga@gmail.com>
Subject: [PATCH v1 07/11] Input: touchscreen: add Silicon Works SW42902 support
Date: Tue, 17 Nov 2026 13:39:42 +0100
Message-Id: <20261117123946.668557-8-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261117123946.668557-1-rofikcoga@gmail.com>
References: <20261117123946.668557-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 18 Nov 2026 08:23:05 +0000
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

Add basic multitouch support for the SW42902 controller. Implement the
GPIO power and reset sequence and use the firmware already present in
controller flash; no firmware update is performed.

Signed-off-by: rofikkerneldev <rofikcoga@gmail.com>
---
 MAINTAINERS                         |   1 +
 drivers/input/touchscreen/Kconfig   |  11 +
 drivers/input/touchscreen/Makefile  |   1 +
 drivers/input/touchscreen/sw42902.c | 315 ++++++++++++++++++++++++++++
 4 files changed, 328 insertions(+)
 create mode 100644 drivers/input/touchscreen/sw42902.c

diff --git a/MAINTAINERS b/MAINTAINERS
index f4c54d7d86bd8..83bbedde94533 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25840,6 +25840,7 @@ M:	rofikkerneldev <rofikcoga@gmail.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+F:	drivers/input/touchscreen/sw42902.c
 
 SILVACO I3C DUAL-ROLE MASTER
 M:	Miquel Raynal <miquel.raynal@bootlin.com>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7fd..eadba5125a225 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1402,6 +1402,17 @@ config TOUCHSCREEN_ZINITIX
 	  To compile this driver as a module, choose M here: the
 	  module will be called zinitix.
 
+config TOUCHSCREEN_SW42902
+	tristate "Silicon Works SW42902 touchscreen"
+	depends on I2C
+	depends on GPIOLIB
+	help
+	  Say Y here for the SW42902 I2C touchscreen used in the LG V60.
+	  Basic multitouch uses the controller's existing flash firmware.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called sw42902.
+
 config TOUCHSCREEN_HIMAX_HX83112B
 	tristate "Himax hx83112b touchscreen driver"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bfd9de83389d8..ee312c2d1529c 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -119,3 +119,4 @@ obj-$(CONFIG_TOUCHSCREEN_IQS5XX)	+= iqs5xx.o
 obj-$(CONFIG_TOUCHSCREEN_IQS7211)	+= iqs7211.o
 obj-$(CONFIG_TOUCHSCREEN_ZINITIX)	+= zinitix.o
 obj-$(CONFIG_TOUCHSCREEN_HIMAX_HX83112B)	+= himax_hx83112b.o
+obj-$(CONFIG_TOUCHSCREEN_SW42902)		+= sw42902.o
diff --git a/drivers/input/touchscreen/sw42902.c b/drivers/input/touchscreen/sw42902.c
new file mode 100644
index 0000000000000..7b39a97053c63
--- /dev/null
+++ b/drivers/input/touchscreen/sw42902.c
@@ -0,0 +1,315 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Silicon Works SW42902 touchscreen, as used by LG V60 (timelm).
+ * Register protocol and report layout derived from the LGE vendor driver
+ * (Copyright (C) 2015 LGE, author hoyeon.jang@lge.com).
+ * This driver uses the controller's existing flash firmware.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/pm.h>
+#include <linux/slab.h>
+#include <linux/unaligned.h>
+
+#define SW42902_MAX_CONTACTS	10
+#define SW42902_REPORT_SIZE	(12 + 24 + 12 * SW42902_MAX_CONTACTS)
+#define SW42902_IC_STATUS	0x600
+#define SW42902_VERSION		0x642
+#define SW42902_DEVICE_CTL	0xc00
+#define SW42902_INTERRUPT_CTL	0xc01
+#define SW42902_DRIVING_CTL	0xc03
+#define SW42902_SERIAL_SPI_EN	0xfe4
+#define SW42902_DRIVING_STOP	0x04
+#define SW42902_DRIVING_U3	0x8303
+
+struct sw42902 {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+	struct gpio_desc *reset;
+	struct gpio_desc *vcl;
+	struct gpio_desc *vdd;
+	u8 report[SW42902_REPORT_SIZE];
+};
+
+static int sw42902_read(struct sw42902 *ts, u16 reg, void *data, u16 len)
+{
+	u8 command[] = { (reg >> 8) | (len > 4 ? 0x20 : 0), reg & 0xff };
+	struct i2c_msg msgs[] = {
+		{ .addr = ts->client->addr, .len = sizeof(command),
+		  .buf = command },
+		{ .addr = ts->client->addr, .flags = I2C_M_RD,
+		  .len = len, .buf = data },
+	};
+	int ret;
+
+	ret = i2c_transfer(ts->client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (ret < 0)
+		return ret;
+	return ret == ARRAY_SIZE(msgs) ? 0 : -EIO;
+}
+
+static int sw42902_write(struct sw42902 *ts, u16 reg, u32 value)
+{
+	u8 command[6] = { 0x40 | (reg >> 8), reg & 0xff };
+	int ret;
+
+	put_unaligned_le32(value, command + 2);
+	ret = i2c_master_send(ts->client, command, sizeof(command));
+	if (ret < 0)
+		return ret;
+	return ret == sizeof(command) ? 0 : -EIO;
+}
+
+static void sw42902_release_contacts(struct sw42902 *ts)
+{
+	int i;
+
+	for (i = 0; i < SW42902_MAX_CONTACTS; i++) {
+		input_mt_slot(ts->input, i);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, false);
+	}
+	input_mt_sync_frame(ts->input);
+	input_sync(ts->input);
+}
+
+static irqreturn_t sw42902_irq(int irq, void *data)
+{
+	struct sw42902 *ts = data;
+	struct input_dev *input = ts->input;
+	u32 status, header;
+	unsigned int count, i;
+	int ret;
+
+	ret = sw42902_read(ts, SW42902_IC_STATUS, ts->report,
+			   sizeof(ts->report));
+	if (ret) {
+		dev_err_ratelimited(&ts->client->dev, "report read failed: %d\n", ret);
+		sw42902_release_contacts(ts);
+		return IRQ_HANDLED;
+	}
+
+	status = get_unaligned_le32(ts->report + 4);
+	header = get_unaligned_le32(ts->report + 8);
+	/* Only normal absolute-touch reports; ignore pen/gesture/debug IRQs. */
+	if (((status >> 16) & 0xf) != 5 || (header & 0xff))
+		return IRQ_HANDLED;
+
+	count = (header >> 8) & 0x1f;
+	if (count > SW42902_MAX_CONTACTS) {
+		dev_warn_ratelimited(&ts->client->dev, "invalid contact count: %u\n", count);
+		sw42902_release_contacts(ts);
+		return IRQ_HANDLED;
+	}
+
+	/* A palm report cancels all active fingers. */
+	if (header & BIT(31)) {
+		sw42902_release_contacts(ts);
+		return IRQ_HANDLED;
+	}
+
+	for (i = 0; i < count; i++) {
+		const u8 *contact = ts->report + 36 + 12 * i;
+		u32 a = get_unaligned_le32(contact);
+		u32 b = get_unaligned_le32(contact + 4);
+		u32 c = get_unaligned_le32(contact + 8);
+		unsigned int id = a & 0x1f;
+		unsigned int event = (a >> 16) & 3;
+
+		if (id == 15) {
+			sw42902_release_contacts(ts);
+			return IRQ_HANDLED;
+		}
+		if (id >= SW42902_MAX_CONTACTS || (event != 1 && event != 2))
+			continue;
+
+		input_mt_slot(input, id);
+		input_mt_report_slot_state(input, MT_TOOL_FINGER, true);
+		touchscreen_report_pos(input, &ts->prop, a >> 18, b & 0x3fff, true);
+		input_report_abs(input, ABS_MT_PRESSURE, (b >> 14) & 0xff);
+		input_report_abs(input, ABS_MT_TOUCH_MAJOR, (c >> 4) & 0x3fff);
+		input_report_abs(input, ABS_MT_TOUCH_MINOR, c >> 18);
+	}
+
+	input_mt_sync_frame(input);
+	input_sync(input);
+	return IRQ_HANDLED;
+}
+
+static void sw42902_power_off(void *data)
+{
+	struct sw42902 *ts = data;
+
+	gpiod_set_value_cansleep(ts->reset, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ts->vdd, 0);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ts->vcl, 0);
+}
+
+static void sw42902_power_on(struct sw42902 *ts)
+{
+	gpiod_set_value_cansleep(ts->vcl, 1);
+	usleep_range(1000, 2000);
+	gpiod_set_value_cansleep(ts->vdd, 1);
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ts->reset, 0);
+	/* Docomo downstream DT specifies a 90 ms hardware reset delay. */
+	msleep(90);
+}
+
+static int sw42902_start(struct sw42902 *ts)
+{
+	u8 version[4];
+	int ret;
+
+	ret = sw42902_read(ts, SW42902_VERSION, version, sizeof(version));
+	if (ret)
+		return ret;
+	if (version[2] != 10 || (version[3] & 0xf) != 4) {
+		dev_err(&ts->client->dev, "unexpected chip/protocol: %u/%u\n",
+			version[2], version[3] & 0xf);
+		return -ENODEV;
+	}
+
+	ret = sw42902_write(ts, SW42902_SERIAL_SPI_EN, 0);
+	if (ret)
+		return ret;
+	ret = sw42902_write(ts, SW42902_DEVICE_CTL, 1);
+	if (ret)
+		return ret;
+	ret = sw42902_write(ts, SW42902_INTERRUPT_CTL, 1);
+	if (ret)
+		return ret;
+	ret = sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
+	if (ret)
+		return ret;
+	msleep(30);
+	return sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_U3);
+}
+
+static int sw42902_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sw42902 *ts;
+	struct input_dev *input;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -EOPNOTSUPP;
+	if (client->irq <= 0)
+		return dev_err_probe(dev, -EINVAL, "missing interrupt\n");
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+	ts->client = client;
+	i2c_set_clientdata(client, ts);
+
+	ts->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ts->reset))
+		return dev_err_probe(dev, PTR_ERR(ts->reset), "reset GPIO\n");
+	ts->vcl = devm_gpiod_get(dev, "vcl", GPIOD_OUT_LOW);
+	if (IS_ERR(ts->vcl))
+		return dev_err_probe(dev, PTR_ERR(ts->vcl), "3.3 V enable GPIO\n");
+	ts->vdd = devm_gpiod_get(dev, "vdd", GPIOD_OUT_LOW);
+	if (IS_ERR(ts->vdd))
+		return dev_err_probe(dev, PTR_ERR(ts->vdd), "1.8 V enable GPIO\n");
+	ret = devm_add_action_or_reset(dev, sw42902_power_off, ts);
+	if (ret)
+		return ret;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+	ts->input = input;
+	input->name = "Silicon Works SW42902";
+	input->id.bustype = BUS_I2C;
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 1079, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 2459, 0, 0);
+	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 255, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 16383, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 16383, 0, 0);
+	touchscreen_parse_properties(input, true, &ts->prop);
+	ret = input_mt_init_slots(input, SW42902_MAX_CONTACTS,
+				  INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (ret)
+		return ret;
+	ret = devm_request_threaded_irq(dev, client->irq, NULL, sw42902_irq,
+					IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					dev_name(dev), ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "interrupt request failed\n");
+
+	sw42902_power_on(ts);
+	ret = sw42902_start(ts);
+	if (ret)
+		return dev_err_probe(dev, ret, "controller initialization failed\n");
+	ret = input_register_device(input);
+	if (ret)
+		return ret;
+	enable_irq(client->irq);
+	dev_info(dev, "SW42902 initialized using existing flash firmware\n");
+	return 0;
+}
+
+static int sw42902_suspend(struct device *dev)
+{
+	struct sw42902 *ts = i2c_get_clientdata(to_i2c_client(dev));
+
+	disable_irq(ts->client->irq);
+	sw42902_release_contacts(ts);
+	sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
+	sw42902_power_off(ts);
+	return 0;
+}
+
+static int sw42902_resume(struct device *dev)
+{
+	struct sw42902 *ts = i2c_get_clientdata(to_i2c_client(dev));
+	int ret;
+
+	sw42902_power_on(ts);
+	ret = sw42902_start(ts);
+	if (ret) {
+		sw42902_power_off(ts);
+		return ret;
+	}
+	enable_irq(ts->client->irq);
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(sw42902_pm_ops, sw42902_suspend, sw42902_resume);
+
+static const struct of_device_id sw42902_of_match[] = {
+	{ .compatible = "lg,sw42902" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, sw42902_of_match);
+
+static const struct i2c_device_id sw42902_ids[] = {
+	{ "sw42902" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, sw42902_ids);
+
+static struct i2c_driver sw42902_driver = {
+	.driver = {
+		.name = "sw42902",
+		.of_match_table = sw42902_of_match,
+		.pm = pm_sleep_ptr(&sw42902_pm_ops),
+	},
+	.probe = sw42902_probe,
+	.id_table = sw42902_ids,
+};
+module_i2c_driver(sw42902_driver);
+
+MODULE_DESCRIPTION("Silicon Works SW42902 touchscreen driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5

