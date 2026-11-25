Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6D3606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=nxvP1682
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E76D10F968;
	Wed, 25 Nov 2026 02:10:21 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26FC610E0E8
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795572594; bh=0oJdvttkxU0i0y40La9zHpYAzZjXWhAZE4nXYC1fcFY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nxvP1682HWzN8DQlswRPvuC39+mOkWS1oI87SPtUwunNL4JKpw2jTLo4KJDJOg0Kd
 7Z6BwbJWp2bX9ZK4C8RpJ9GlvGYHDA1LGCca+CxXvrPqH5BfwEXtk2Xiihf3JR2xaR
 5Qbv6totQCXdIibldNgd7huftUi7g86+Eql1WSvw=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
 id 26DABE38; Wed, 25 Nov 2026 10:09:45 +0800
X-QQ-mid: xmsmtpt1795572592te4du5ev4
Message-ID: <tencent_42CFAF0E2AFDF8C8C784D5DCB700E1E65306@qq.com>
X-QQ-XMAILINFO: MeukCuWaRbQlRvPH68syz+NWAahhRs4fHVKVW7dBQKudoAjUVsXSpA2/DLjE/k
 Iacyv+RwpfVjb7o8JzPmIUWm2bkIoFrNFfNiRh+pd0rGC2ZIH6O/uZkO/u/uspJR/bYsEV1cvGRo
 VDADQBnMfnvDU7HE30LNvLce0FmpZCLO/xmBcZ3fx2oe/9hPAX+DVK+IiKn14J5idA7rQuo0fB2U
 cRRiQzjgJGCeMSrA8QutAwc5rKvZQZ9re8w9/XyjXXHETV6vDB0DvhIQVQXPWE0OsM5OJyRIlpto
 MiUsZSpAbuxZIVGYSBBym+yUCMrJ8B9W68IqKUEvSBRxlsn3tXr5ft5k0SV/Uq9h+KghvXY+nJl2
 TOR7Dt4oqKyyaPtmK+yuV99a9uwVl48zsJ71hRePrJqigrb4+6CJdizc6Yd5AyuPoa4eArdEmKXa
 LYlg7VFg0+wxK4wBU10Py66dYwTYtpu74YPug2leDsxgeaqrE+UWLbK/vVKMRxwna4HbwOX8Y6nd
 Qc0t5DQLFH69DTaXtVadkM/6S3uBUaEzCERZBaGxlX3mz3e01AOtR4dFAhTRZCEmpe433Q03Tg3r
 QXGZC6t9C5xTaj9tgG4o+edrGihVU9dFuBvkcypTbe+mEvABvDknHyxHSDQuVvE2nheRJ5/DeXxt
 SDVOpaTcADTP7WH8k4gqRWFL0Ze27QdocyUKpTsborrNTcOmoCyOtr35ntrCdUVWU8DPHIwWcuDH
 41IkRj1hh2vVS1wEDuSZ+RTpd+raEX7J4egxz5OKwmgCI+4+omE+Frc+9ROYeZ53smOt3YwfsYj1
 W3wxrSv6kJUeknDcmvdJQAzxla95vK7lorqBix4jhpCXOtouOzVQacaUx+FDXJsqBOBcGbkwiQLz
 c4SYEjqqocGzrmauHWZ83An1yUcEXaZLSs710rGFdT6Gb85lG6X3qDj+IadbO63y0jHcQmf9RtQw
 ufdAQPSN23rMMov/XySWFn51YtchPaPNQGIgZtZ5qmUGkjFcnDRzIhitbUpeph/VMHI0n3+AA/jC
 kdJtOmWl8p03tuuxRgnDNCcUT3W8NobklTu6/uLIfXDhLvvq46a907seJL2T88LDAmNPEbWO5Pbk
 etFpwt
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>, Cursor <cursoragent@cursor.com>
Subject: [PATCH v2 6/6] backlight: add VIEWE I2C backlight driver
Date: Wed, 25 Nov 2026 10:09:44 +0800
X-OQ-MSGID: <20261125020944.137-7-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125020944.137-1-3066883572@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
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

Signed-off-by: Hefei <3066883572@qq.com>
Co-authored-by: Cursor <cursoragent@cursor.com>
---
 drivers/video/backlight/Kconfig        |  7 +++
 drivers/video/backlight/Makefile       |  1 +
 drivers/video/backlight/viewe_bl_i2c.c | 79 ++++++++++++++++++++++++++
 3 files changed, 87 insertions(+)
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
index 0000000..53dcf08
--- /dev/null
+++ b/drivers/video/backlight/viewe_bl_i2c.c
@@ -0,0 +1,79 @@
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
+
+#define VIEWE_BL_REG		0x86
+#define VIEWE_BL_MAX		255
+#define VIEWE_BL_DEFAULT	200
+
+static int viewe_bl_update_status(struct backlight_device *bd)
+{
+	struct i2c_client *client = bl_get_data(bd);
+	u8 buf[2] = { VIEWE_BL_REG, (u8)backlight_get_brightness(bd) };
+	struct i2c_msg msg = {
+		.addr = client->addr,
+		.flags = 0,
+		.len = sizeof(buf),
+		.buf = buf,
+	};
+	int ret;
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	return ret == 1 ? 0 : (ret < 0 ? ret : -EIO);
+}
+
+static const struct backlight_ops viewe_bl_ops = {
+	.update_status = viewe_bl_update_status,
+};
+
+static int viewe_bl_probe(struct i2c_client *client)
+{
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = VIEWE_BL_DEFAULT,
+		.max_brightness = VIEWE_BL_MAX,
+	};
+	struct backlight_device *bd;
+
+	bd = devm_backlight_device_register(&client->dev, "viewe_bl",
+					   &client->dev, client, &viewe_bl_ops,
+					   &props);
+	if (IS_ERR(bd))
+		return PTR_ERR(bd);
+
+	i2c_set_clientdata(client, bd);
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
+	{ "viewe_bl", 0 },
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

