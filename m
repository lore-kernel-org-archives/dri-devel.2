Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C42B606A323
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 03:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sXHF5838
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 394DB10EBE9;
	Wed, 25 Nov 2026 03:28:27 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D01210EBAE
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 03:28:17 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a2000d5fb1so30158365e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795577295; x=1796182095; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=neRHwZ4PcekzFePF+ojssqeeGgodG3OmNINdD0aY8HA=;
 b=sXHF5838fta96sav6svRf9qc1FwZKcA3NrRDP9l6nq8HqC6rWJEG2e5wrLWAXaoje1
 ZdGVf8XXRgeSpbb1pu6VVpDWXfMbAmI0gvscqRl0Zc0oZC68HX8cym2ST/8MC81d85aT
 +p1cLx8eQ0RupLpwRpKn460B8ucBdaHGC51IzcQrvIsRz2DCOX0yLo0jp6uBZOcfyJLT
 blrCokjUsuBZvCP7vxfVCoC4WFl4J9IIw/iV/E0YSIBTb2AwC2BVyme60mNAU7PCmJgU
 rmgIajzmKpcOcQ1K7SkVa7YAWRm2tHjXt/CnYJpIMmRLTsl5grqxVGV89wI0vXRMYSZS
 fodA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795577295; x=1796182095;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=neRHwZ4PcekzFePF+ojssqeeGgodG3OmNINdD0aY8HA=;
 b=2JjvE+u19swCqSo5WUvqvafvCSyzJeUCL/ZVmUukcUuK9ubBopJIAKbdQYTJyt0aJy
 e2zJsCQzliVcFYUs6K0aItxTe7fIGA8MsUkxUM8ZpyS7AQId/jiHeSA6LseHIUq8Wpku
 xA0KbjVpM+S1kW5/EWIbJj4ZJvRHzEFajFl1pMUyh0FCWPjLkAwAuYqlaYxl4gbf5oU8
 TG0t72QLjlrCmv1ErXH31i0h4R7i3cGuotDEEwXJcJAN3n8uuNQywmOTbGgcIe++oze1
 WcIsSQsQSQHRJe9qlveH3w/I7VK26V2DGX0YAi3CB6SW4FfMdobCz/8BwPrxtIxNTZaj
 mD4Q==
X-Forwarded-Encrypted: i=1;
 AL+hErEvjASLtqyv4e854+FLcBdwnjzwtY97ftrKiQCx6KqmyqWvhJ19nApBsP4KCIeipzhYTSFPakyd3Ec=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9WwxKEADWdOEDisjs8vSptoJF4fkKdpa4MUFFp4HW3mNmVVYbX
 tDAwgtsTNZDW+unF7+FzGIm0TsCgabhrKyn8IX6JlIEJixe0SoGU9Sck
X-Gm-Gg: AZFdTZcGHG71AS/8CWoMu4rt3UWadkYGdf2OQEUk+/LMFL7cpbL9MMnG7olx/qy+55N
 DW1SnkZGlg9klRDFelbQs5EQp4FPc7NXzUwbH+VHMAnF5QHnAs2j6yxKqaAzvcvvuYnas+JE8Ru
 /Z2EjKhrFuAvGyw9DG8hxuBDTu6RhcEOsyQkTwoOAxtXmlSzckRTb3UqLylFqpzQc3M3WlkTBL0
 m9koRkq1Bg+Lq1ufhvQ9/OpyJrMtZeyk26wVzOIpyEo8WUn4WS194FK29HEDVeSRiTNJATPjnyR
 KEx+xd+N8c+/c/wRX2ZsWBCd33l4NH4sppf9kxDo1Kp6A3OXLZhCXn1/FY7Qlm1OBypFAkJrAph
 iOxq+2ADzQNzeesBY4Fim3Jl09A5SVtfnuwW3RgEGlMS956CiGyAdAuT4x/OP8lUuS5BtJJLk9Y
 HgZHWMCh13X7AZ7v8U1JirxjsNImbtUfU3Grx0f6aAkgGEWyCN9ZPSnDfgkhR3Xkt76SsrDu99h
 78T6uB9GBGUkEYuqaZHx7NVljw0Y7gByYBj5PKcc/yXm3vkr6584eNquaX+XbPx3o5aS9zO7tqK
 yBlUDFUdRmWTSEhMKcQdVVPeL7lUl3q6qwqCyXUIANHLE867XtRHCgIAVby1COZUhKJc8BgK1H+
 oJorlxvE+7/0db9hlaYcd6TLZx7+rMDo=
X-Received: by 2002:a05:600c:3e0e:b0:4bb:6a5a:783d with SMTP id
 5b1f17b1804b1-4bb88929c63mr304761965e9.18.1795577295489; 
 Tue, 24 Nov 2026 19:28:15 -0800 (PST)
Received: from DESKTOP-BJ3EVC4.lan (178-164-182-185.pool.digikabel.hu.
 [178.164.182.185]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4ab6a67fe48sm28918822f8f.23.2026.11.24.19.28.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 19:28:14 -0800 (PST)
From: Abdur Rofik <rofikcoga@gmail.com>
To: linux-arm-msm@vger.kernel.org
Cc: devicetree@vger.kernel.org, phone-devel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Abdur Rofik <rofikcoga@gmail.com>
Subject: [PATCH v6 5/6] Input: touchscreen: add LG SW42902 support
Date: Wed, 25 Nov 2026 04:28:01 +0100
Message-Id: <20261125032802.8460-6-rofikcoga@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261125032802.8460-1-rofikcoga@gmail.com>
References: <20261125032802.8460-1-rofikcoga@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Add basic multitouch support for the SW42902 controller. Implement the
power and reset sequence using regulator supplies and use the firmware
already present in controller flash; no firmware update is performed.

Signed-off-by: Abdur Rofik <rofikcoga@gmail.com>
---
 MAINTAINERS                         |   1 +
 drivers/input/touchscreen/Kconfig   |  13 +
 drivers/input/touchscreen/Makefile  |   1 +
 drivers/input/touchscreen/sw42902.c | 360 ++++++++++++++++++++++++++++
 4 files changed, 375 insertions(+)
 create mode 100644 drivers/input/touchscreen/sw42902.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c88429e647ba..3585dbff41be9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15216,6 +15216,7 @@ M:	Abdur Rofik <rofikcoga@gmail.com>
 L:	linux-input@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/input/touchscreen/lg,sw42902.yaml
+F:	drivers/input/touchscreen/sw42902.c
 
 LG SW43103 PANEL DRIVER
 M:	Abdur Rofik <rofikcoga@gmail.com>
diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7fd..6a70a20383ffa 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -1299,6 +1299,19 @@ config TOUCHSCREEN_SURFACE3_SPI
 	  To compile this driver as a module, choose M here: the
 	  module will be called surface3_spi.
 
+config TOUCHSCREEN_SW42902
+	tristate "LG SW42902 touchscreen"
+	depends on I2C
+	depends on GPIOLIB
+	help
+	  Say Y here if you have an LG SW42902 touchscreen
+	  connected to your system (e.g. LG V60).
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called sw42902.
+
 config TOUCHSCREEN_SX8654
 	tristate "Semtech SX8654 touchscreen"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bfd9de83389d8..1ee2590014535 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -86,6 +86,7 @@ obj-$(CONFIG_TOUCHSCREEN_STMPE)		+= stmpe-ts.o
 obj-$(CONFIG_TOUCHSCREEN_SUN4I)		+= sun4i-ts.o
 obj-$(CONFIG_TOUCHSCREEN_SUR40)		+= sur40.o
 obj-$(CONFIG_TOUCHSCREEN_SURFACE3_SPI)	+= surface3_spi.o
+obj-$(CONFIG_TOUCHSCREEN_SW42902)	+= sw42902.o
 obj-$(CONFIG_TOUCHSCREEN_TI_AM335X_TSC)	+= ti_am335x_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHIT213)	+= touchit213.o
 obj-$(CONFIG_TOUCHSCREEN_TOUCHRIGHT)	+= touchright.o
diff --git a/drivers/input/touchscreen/sw42902.c b/drivers/input/touchscreen/sw42902.c
new file mode 100644
index 0000000000000..0724f8a9c0bc9
--- /dev/null
+++ b/drivers/input/touchscreen/sw42902.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2026 Abdur Rofik <rofikcoga@gmail.com>
+ * LG SW42902 touchscreen, as used by LG V60 (timelm).
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
+#include <linux/regulator/consumer.h>
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
+static const char * const sw42902_supplies[] = {
+	"vcl",
+	"vdd",
+};
+
+struct sw42902 {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+	struct gpio_desc *reset;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(sw42902_supplies)];
+	bool suspended;
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
+	int error;
+
+	error = i2c_transfer(ts->client->adapter, msgs, ARRAY_SIZE(msgs));
+	if (error < 0)
+		return error;
+	return error == ARRAY_SIZE(msgs) ? 0 : -EIO;
+}
+
+static int sw42902_write(struct sw42902 *ts, u16 reg, u32 value)
+{
+	u8 command[6] = { 0x40 | (reg >> 8), reg & 0xff };
+	int error;
+
+	put_unaligned_le32(value, command + 2);
+	error = i2c_master_send(ts->client, command, sizeof(command));
+	if (error < 0)
+		return error;
+	return error == sizeof(command) ? 0 : -EIO;
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
+	int error;
+
+	error = sw42902_read(ts, SW42902_IC_STATUS, ts->report,
+			     sizeof(ts->report));
+	if (error) {
+		dev_err_ratelimited(&ts->client->dev, "report read failed: %d\n", error);
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
+	/* Pre-scan for palm report to avoid queueing partial touch events */
+	for (i = 0; i < count; i++) {
+		const u8 *contact = ts->report + 36 + 12 * i;
+		u32 a = get_unaligned_le32(contact);
+
+		if ((a & 0x1f) == 15) {
+			sw42902_release_contacts(ts);
+			return IRQ_HANDLED;
+		}
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
+	if (ts->suspended)
+		return;
+
+	gpiod_set_value_cansleep(ts->reset, 1);
+	usleep_range(1000, 2000);
+	regulator_bulk_disable(ARRAY_SIZE(ts->supplies), ts->supplies);
+	ts->suspended = true;
+}
+
+static int sw42902_power_on(struct sw42902 *ts)
+{
+	int error;
+
+	error = regulator_bulk_enable(ARRAY_SIZE(ts->supplies), ts->supplies);
+	if (error)
+		return error;
+
+	usleep_range(10000, 11000);
+	gpiod_set_value_cansleep(ts->reset, 0);
+	/* Docomo downstream DT specifies a 90 ms hardware reset delay. */
+	msleep(90);
+
+	return 0;
+}
+
+static int sw42902_start(struct sw42902 *ts)
+{
+	u8 version[4];
+	int error;
+
+	error = sw42902_read(ts, SW42902_VERSION, version, sizeof(version));
+	if (error)
+		return error;
+	if (version[2] != 10 || (version[3] & 0xf) != 4) {
+		dev_err(&ts->client->dev, "unexpected chip/protocol: %u/%u\n",
+			version[2], version[3] & 0xf);
+		return -ENODEV;
+	}
+
+	error = sw42902_write(ts, SW42902_SERIAL_SPI_EN, 0);
+	if (error)
+		return error;
+	error = sw42902_write(ts, SW42902_DEVICE_CTL, 1);
+	if (error)
+		return error;
+	error = sw42902_write(ts, SW42902_INTERRUPT_CTL, 1);
+	if (error)
+		return error;
+	error = sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
+	if (error)
+		return error;
+	msleep(30);
+	error = sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_U3);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static int sw42902_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct sw42902 *ts;
+	struct input_dev *input;
+	int error, i;
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
+
+	for (i = 0; i < ARRAY_SIZE(sw42902_supplies); i++)
+		ts->supplies[i].supply = sw42902_supplies[i];
+
+	error = devm_regulator_bulk_get(dev, ARRAY_SIZE(ts->supplies), ts->supplies);
+	if (error)
+		return dev_err_probe(dev, error, "failed to get regulators\n");
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+	ts->input = input;
+	input->name = "LG SW42902";
+	input->id.bustype = BUS_I2C;
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, 1079, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, 2459, 0, 0);
+	input_set_abs_params(input, ABS_MT_PRESSURE, 0, 255, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 16383, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MINOR, 0, 16383, 0, 0);
+	touchscreen_parse_properties(input, true, &ts->prop);
+	error = input_mt_init_slots(input, SW42902_MAX_CONTACTS,
+				    INPUT_MT_DIRECT | INPUT_MT_DROP_UNUSED);
+	if (error)
+		return error;
+
+	error = sw42902_power_on(ts);
+	if (error)
+		return error;
+
+	error = devm_add_action_or_reset(dev, sw42902_power_off, ts);
+	if (error)
+		return error;
+
+	error = devm_request_threaded_irq(dev, client->irq, NULL, sw42902_irq,
+					  IRQF_ONESHOT | IRQF_NO_AUTOEN,
+					  dev_name(dev), ts);
+	if (error)
+		return error;
+
+	error = sw42902_start(ts);
+	if (error)
+		return dev_err_probe(dev, error, "controller initialization failed\n");
+	error = input_register_device(input);
+	if (error)
+		return error;
+	enable_irq(client->irq);
+	dev_info(dev, "SW42902 initialized using existing flash firmware\n");
+	return 0;
+}
+
+static int sw42902_suspend(struct device *dev)
+{
+	struct sw42902 *ts = i2c_get_clientdata(to_i2c_client(dev));
+
+	if (ts->suspended)
+		return 0;
+
+	disable_irq(ts->client->irq);
+	sw42902_release_contacts(ts);
+	sw42902_write(ts, SW42902_DRIVING_CTL, SW42902_DRIVING_STOP);
+	sw42902_power_off(ts);
+
+	return 0;
+}
+
+static int sw42902_resume(struct device *dev)
+{
+	struct sw42902 *ts = i2c_get_clientdata(to_i2c_client(dev));
+	int error;
+
+	if (!ts->suspended)
+		return 0;
+
+	error = sw42902_power_on(ts);
+	if (error)
+		return error;
+
+	ts->suspended = false;
+
+	error = sw42902_start(ts);
+	if (error) {
+		sw42902_power_off(ts);
+		return error;
+	}
+	enable_irq(ts->client->irq);
+
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
+	{ .name = "sw42902" },
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
+MODULE_AUTHOR("Abdur Rofik <rofikcoga@gmail.com>");
+MODULE_DESCRIPTION("LG SW42902 touchscreen driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5

