Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8D5606A329
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=Fph5A+JP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5948310E8C1;
	Wed, 25 Nov 2026 02:42:45 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D87BB10E8DA
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795574555; bh=fbu9uDIZ7L32gOC7ibbK3yEo/s2Yqhso0UM/iF/DqSw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Fph5A+JPDd8nSfjTO+kTXuC1m8dUE20cYF5fnk0OpVrA9NmzWQAFcZCpJlll7OEkv
 BTlFn8NcpbC0savwSckoUSEx6yYGwSodVmQM8LChT3jZ6XgloQn2tYccg4GWYMH88C
 ddxsKPTga/a7vK9HuYzdCAIELhXdjBuJEIoSHxuQ=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza63-0.qq.com (NewEsmtp) with SMTP
 id A9B394D4; Wed, 25 Nov 2026 10:42:27 +0800
X-QQ-mid: xmsmtpt1795574553t13bnoa9a
Message-ID: <tencent_7F6A3DBDFF7EA3F68F5B7D5C58F57FBB120A@qq.com>
X-QQ-XMAILINFO: MzNwb/pqyJTk3v8LTyckX8ntDCs5L5+2jfyDrScMMZwM5NUat3vq4vxDCsZ/v8
 LZ7hLj5OIFT9h5Mrb1WnP/Eg2mXzTaEFsj9KoFegYos80Ya23iHAuxvZTSgwHgo0j/Ta39SXUUG1
 GFY/9K788R+teW/+uoLdRpH1WtcgUcaVSwJHt1PrG5jnpGrVXS1HeqvzvScudadkxFcra3tk60pt
 mc9vBNW+9LYqPrRPh91nTLzX2TuYyCPXDRv8dgst6k0Eo/ePMTkiUweXay5xyNMbWC/bV5+U/BtG
 4Wd3tLnyxgmqq5K3JzJj1QamWv/tphS96jSXJ0qFt4DR1cmIkYflVq26/ycviW5z93ZK8jXG9NeY
 lkb7t8INaoK5rZv/V6aFWh272xZ95bTMx45omTN3DeuMyflNaLd2lBScNHCDuLh/xHxrbuaWF02d
 ozF25QVdh9pjmuWFD00D3YL8plc85EG4CMn1mXnvQvatLG5+pcBiP2yfloFZuPZ9vLQNziNSd49B
 kGi0PPTNTnIRnyxTvkpT6BVpN4hw3zJQzPf6ukfVYLhsvCM2lVtEzngBRZwSeeJ8q7VIENNWqGUE
 k3ZelSTDBE6fxsXx3wnXxyLuifLCJQN3e3+7SDaPA1xz2hRfeGxn38emU9wtqMhJre+vBpEYRa4V
 UVfKNqtyOp/rf3Cj7Jaxzh1xW6vTdQ8bW46xC5oALuJo2qfX/LYoL+BPSPrj7l01xyC6Xi8bTEsG
 PAK7KoodBehwzzmDDiBX5bp2uXmQkUsEMjxDLiGJrY0KPFkQbV0cPt13XP+JMOGTr2wXxvwBg8Hi
 DPG4JBhkzsVNTomuFF1j+2A2BDJqcqhkInCUohztoI8v7yhGj6VqQsPM7vz2Poqo34z9JnqjSqIt
 8tF+za0FBbuuZ5klYbsXSbX1n0eJdWpl2nxZ/5hKdcnRnhm+nvdo2S/+PQncmXLzFCHJ44Guf5jq
 nQlB+m9vWYOoQY6d+rn+tT2NwrCz7EBVl9/ws3s9/lt7XcymXHrBxp21PUzFGrow/XT9faNUrQtL
 8ADpo+4U+HSIehTip8MOBxKR2Hu8p/zr9LL0VspApQCD044K+2kDn46Z0Wea9RnCxh0ONLunGnmI
 ccWl8h
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v4 6/6] backlight: add VIEWE 7KF82 I2C backlight driver
Date: Wed, 25 Nov 2026 10:42:26 +0800
X-OQ-MSGID: <20261125024226.1293-7-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125024226.1293-1-3066883572@qq.com>
References: <20261125024226.1293-1-3066883572@qq.com>
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

