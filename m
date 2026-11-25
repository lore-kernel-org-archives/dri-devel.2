Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40794606A68C
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=VNyBuJp7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D241610F98A;
	Wed, 25 Nov 2026 02:11:45 +0000 (UTC)
Received: from out203-205-221-173.mail.qq.com (out203-205-221-173.mail.qq.com
 [203.205.221.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2908F10F98D
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795572696; bh=ipKz2wPLfbybINwrZdLYba/QZlFaNiTQwOXAfGrryTk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=VNyBuJp7NzuGr4hZmVUN3rq0nV1gBs+ugfc/uHe1U11NdpAKzH3zqBx8DLZnRVgzd
 RqGTjjnvU0uiu46+aBWb/gBjYKLLgpopZPW+RlQsLw+elz1qb9NvFJyEpa/3sqqON0
 WTHgv3zn+4yzaPRM5w9JTyuW90+mCLAzVk9dXzZs=
Received: from HF ([113.90.236.90])
 by newxmesmtplogicsvrsza73-0.qq.com (NewEsmtp) with SMTP
 id 2DCBA053; Wed, 25 Nov 2026 10:11:28 +0800
X-QQ-mid: xmsmtpt1795572694t36dn6367
Message-ID: <tencent_5185BF35A815E3151FD856BCDF3E84F14F08@qq.com>
X-QQ-XMAILINFO: MOwTdzJUflUIdCsmSClPON9Fcmo0DOhCtyoW0HsqeLz53esi/dcFDmIGTNfwu5
 cBR7F+evB2JSB+kwEba74FEbuh+uNvo+F2aKIqc2cxLfEW8v3JKrxNj0JoH5RjqzTPBajxa9+9FQ
 uUGsKNVO1v8z4oBnbN/huONbuWqJrSlpC1KyhQHDLXugafaGSBxCJqhRH54TyBHegjYKkDdBk2x2
 lmzsNtdoJE9U57KHQSk3+R+pGEaIEfb8B7dQJfe8bOVOUG/fNY399f8DiQYMXhf9yja+vPksjJWT
 d43yMfhlrdNKsMwVLtMMlO0DF5VtbrSIh7tnayUg4UNs8p0wLkCsWNUFQbZQRxPfjORT6EVTkXk6
 RYUH8Cc63+IatOY5mkBrK6BgcvkuIJFTZfEJcyRHurFQD7iBLytcoFdRJ7N530QZWTfUlQpzYGJ5
 7m6inEITBB7B2QogeDvBNiubsmMWMciU9LVF+tb3SJDcZDpXpfqliJPFprXfgGzvIqhn7DiqauNM
 3uIrm13p7EBKx05lxwFgXwPe8fkdw9kXv6n3IysPZCMW/Pso99RJJIDBc7xD9Dlo7j1VFWwozzUT
 0QWjdOucsJrb7nKUqLo5kza2Sj4ExpSzfCZYexM8xmB0Gh5L6chhuROj090nfD0a9j+gkE1OwME9
 qE6wORLEIk2w8CfHahYB6ePzDX9lXTKO78lT6ate/IHFjFyWsWeT4cN3St3ekmXQ6EnUPUkOupXi
 Ls6Xi6gPKM6/CtgelJuMa96t6dA91xYyqG3xusDRMFIjuME2br0QKm7Rw/1T7SOA3vaWsGn0huvN
 YFpll0rxeuAsvUk19UhSB3X2L88q2Q7se+sdZA5kTeMIRzdafMQuaDku3PfVWP67iOIOSzGrJKp1
 S2dyEWV9q1a7ZG9u3iaxzFygDUP04nYNAV+Bf37VBDblOcAtIBYsn0xzZ/jHCT+W6Q3AhRz88M7c
 v/8+n9Vm/K6eO1NHVr3wkLnZFIuQjjxre78omSbGis8OnqJAFFvXdBCUqGZIzQugssGe8gun/Bxt
 YB6esJIBNjlr0WbLlqBSXVTW7azO7v+ebE3AvH2+waZiJf1rkqtMD/r+yUoNsFoZviBTtp1G1Wge
 KjvI7YItgj124GbI1d3a/atcuzHHWie9ukjZVg2yeVqCdFsXj2YVTUsgqSlyEQvSN+t3YBwy8n0t
 XXgFY=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org, conor@kernel.org,
 Hefei <3066883572@qq.com>
Subject: [PATCH v3 6/6] backlight: add VIEWE I2C backlight driver
Date: Wed, 25 Nov 2026 10:11:27 +0800
X-OQ-MSGID: <20261125021127.1430-7-3066883572@qq.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261125021127.1430-1-3066883572@qq.com>
References: <20261125021127.1430-1-3066883572@qq.com>
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

