Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57304606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=JD6rEod0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 891C910E870;
	Wed, 25 Nov 2026 02:57:24 +0000 (UTC)
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com
 [162.62.58.211])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4E5610E8CB
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795575406; bh=fbu9uDIZ7L32gOC7ibbK3yEo/s2Yqhso0UM/iF/DqSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JD6rEod0O6lBZJQv3JXsQ6AmCMqcueylZjTsH4Mg8YR4QSNnRZbJPYQ0FSMO4wLyS
 vPBKdOhI+88lSCZ+GRD3doc/oUmcCLlV2g/Fmbe5yTILC/ss/dXYADnNSlEevxNB81
 M5vnApAxJg/qJ47GkdQLdLmgWuR31oxUTYKpgR4I=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id E279BA4D; Wed, 25 Nov 2026 10:56:39 +0800
X-QQ-mid: xmsmtpt1795575405tspp6hzh2
Message-ID: <tencent_BFE1A9E03700F565DCE663D30AE77B8B5005@qq.com>
X-QQ-XMAILINFO: MnyA3vAndR/VFxm9L0VwHaURWIQn4qp0P8vkSakoy9TYUgOhyqNr0mug295VlY
 MigNYF7UmLPiTaz7i7ivOcVCW30wJk+tHBlNpT/M+ug76WFRGPGnuYTne2J4nyTpXr6wL0PmugvE
 1yorDNDcY/gOlETcS6GWkJkvGkZmZyTX8RB4AZE1tkf3p9lqiC+KCY22NeVvUcPfrT+1cr8D07bj
 TYDnTUQMp41Lh/vvQqaMHH02W4jrem6m01Dy1H+cBV+tnjsgQmNcYAZoHk2sfABFdqwYNKNxL7zJ
 scbqaoGu1WxQ3wDly8m5KPrSE5HdP7tyoRzuFV59u59t3iuu+/XtgqlxGj286a9/iQDQdxKAPN0u
 qf4NO0haPr50ocxhsrJWrDbcYaHnwQmYEgKo0CcwQDQUHfOpdP8lC8lxys9lSsP5Q7/5rvmMpBdB
 D295K7G/a5v/omBiyNDTWv5WjW4ptiWvEEj/+L7zx/i+IQLk9VURU/uYvwzl8NxerlYBHsZsGDg2
 AUi/kterh0E0XvVplHCMd2Wir5IUUyHnMh4Mi5STRrf5Xr/pU1eaMWIeiUaaFp8IKJldtJZjmAYE
 hfEWueVmQsIGmYfzxDbDOj3bI8BCocJPiJAPL7zXR97qheShw+bnCBzK6/E21A5ebL0Xkx0hpC/a
 vV+fRY/HkHeWTtiK+XmlBJnA58FL3zro3cV3zjwbrNnyUHHdWA8uKia71W615/uWrtQHdSP43xYA
 X3ynSZ9aqQ2Fd/waHZSHmuddklR7DijpN8ve2ollOMGl7mZAS2TSyegUY7VX6GkwLfcWuYfrsVTh
 4UtaZL0xRvc+K86hBdZNGdF8RId7JeDXiEivH4WUQCfLTk+hUUmvQMccR+L18eeJreO5f67ElxND
 YiOtzNig31CUO6RWpFKZsEfgfjiL8FtDcA+paDQOxp83Lrpko7sQ0N0wDqQXUfturgsRoDzRntL+
 KJGU9A8VhR36n5B1jJSH7YzvWRN1dO89uDTHg3o+bdtNsthZg4THXrYHrmR8Cx5S1hHcTFkP6AAv
 bt1EBk0kHx348F65wDpzNl6XUl7jvcBL5dwzkJBa0ZXEvPt1CquRn4YGh2xWNuK8PaqhYSo55wiT
 DSv7RyBPNE51AOQCkNZVTOI6oo6+sLt6xQOIfaIrtJpnfV8nb38URkb7Y4Tf+O0gXF1Hw5qH9KWG
 ENMaE=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v5 6/6] backlight: add VIEWE 7KF82 I2C backlight driver
Date: Wed, 25 Nov 2026 10:56:38 +0800
X-OQ-MSGID: <20261125025638.1171-7-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125025638.1171-1-3066883572@qq.com>
References: <20261125025638.1171-1-3066883572@qq.com>
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

Drive the VIEWE 7KF82 backlight MCU over I2C (register 0x86).
The MCU has no public discrete part number on the FPC silk.

Signed-off-by: Hefei <3066883572@qq.com>
---
 drivers/video/backlight/Kconfig        |  7 +++
 drivers/video/backlight/Makefile       |  1 +
 drivers/video/backlight/viewe_bl_i2c.c | 82 ++++++++++++++++++++++++++
 3 files changed, 90 insertions(+)
 create mode 100644 drivers/video/backlight/viewe_bl_i2c.c

diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index 7b836f9..8ea7332 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -501,6 +501,13 @@ config BACKLIGHT_LED
 	  If you have a LCD backlight adjustable by LED class driver, say Y
 	  to enable this driver.
 
+config BACKLIGHT_VIEWE_I2C
+	tristate "VIEWE I2C backlight"
+	depends on I2C
+	help
+	  Backlight driver for VIEWE DSI panels. Brightness is written to
+	  the panel MCU at I2C address 0x45, register 0x86.
+
 endif # BACKLIGHT_CLASS_DEVICE
 
 endmenu
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index bcb568a..b82d959 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -61,3 +61,4 @@ obj-$(CONFIG_BACKLIGHT_WM831X)		+= wm831x_bl.o
 obj-$(CONFIG_BACKLIGHT_ARCXCNN) 	+= arcxcnn_bl.o
 obj-$(CONFIG_BACKLIGHT_RAVE_SP)		+= rave-sp-backlight.o
 obj-$(CONFIG_BACKLIGHT_LED)		+= led_bl.o
+obj-$(CONFIG_BACKLIGHT_VIEWE_I2C)	+= viewe_bl_i2c.o
diff --git a/drivers/video/backlight/viewe_bl_i2c.c b/drivers/video/backlight/viewe_bl_i2c.c
new file mode 100644
index 0000000..fe9ed47
--- /dev/null
+++ b/drivers/video/backlight/viewe_bl_i2c.c
@@ -0,0 +1,82 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 VIEWE
+ *
+ * I2C backlight for VIEWE 7KF82 DSI modules (MCU @0x45, register 0x86, 0..255).
+ */
+
+#include <linux/backlight.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/property.h>
+
+#define VIEWE_BL_REG		0x86
+#define VIEWE_BL_MAX		255
+#define VIEWE_BL_DEFAULT	200
+
+static int viewe_bl_update_status(struct backlight_device *bd)
+{
+	struct i2c_client *client = bl_get_data(bd);
+
+	return i2c_smbus_write_byte_data(client, VIEWE_BL_REG,
+					 backlight_get_brightness(bd));
+}
+
+static const struct backlight_ops viewe_bl_ops = {
+	.options = BL_CORE_SUSPENDRESUME,
+	.update_status = viewe_bl_update_status,
+};
+
+static int viewe_bl_probe(struct i2c_client *client)
+{
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.max_brightness = VIEWE_BL_MAX,
+	};
+	struct backlight_device *bd;
+	u32 brightness = VIEWE_BL_DEFAULT;
+	int error;
+
+	device_property_read_u32(&client->dev, "default-brightness", &brightness);
+	if (brightness > VIEWE_BL_MAX)
+		brightness = VIEWE_BL_MAX;
+	props.brightness = brightness;
+
+	bd = devm_backlight_device_register(&client->dev, dev_name(&client->dev),
+					   &client->dev, client, &viewe_bl_ops,
+					   &props);
+	if (IS_ERR(bd))
+		return PTR_ERR(bd);
+
+	error = backlight_update_status(bd);
+	if (error)
+		return error;
+
+	return 0;
+}
+
+static const struct of_device_id viewe_bl_of_match[] = {
+	{ .compatible = "viewe,7kf82-backlight" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, viewe_bl_of_match);
+
+static const struct i2c_device_id viewe_bl_id[] = {
+	{ .name = "7kf82-backlight" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, viewe_bl_id);
+
+static struct i2c_driver viewe_bl_driver = {
+	.driver = {
+		.name = "viewe_bl_i2c",
+		.of_match_table = viewe_bl_of_match,
+	},
+	.probe = viewe_bl_probe,
+	.id_table = viewe_bl_id,
+};
+module_i2c_driver(viewe_bl_driver);
+
+MODULE_AUTHOR("Hefei <3066883572@qq.com>");
+MODULE_DESCRIPTION("VIEWE 7KF82 I2C backlight");
+MODULE_LICENSE("GPL");
-- 
2.55.0.windows.5

