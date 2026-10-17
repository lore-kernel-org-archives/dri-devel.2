Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DEC606A319
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=S4BzDB/B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F38A910F308;
	Tue, 20 Oct 2026 07:36:38 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9969F10E107
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 14:08:47 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a1cef0439aso8267495e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 17 Oct 2026 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792246126; x=1792850926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=C+1f1lj3zLciCCO8Mc5INC/JSPS2g2K5CtomKct7Fmg=;
 b=S4BzDB/BFtSBTZktGGJuNkkaq1E0/RISwMICqwNEddWu+ne63xfH5vcuQVKwkhszav
 Ao2TFI4RhbSwUHjug/zC/iTPXB/EvtP7feny/rjbXxf19FEP6UaXlOf/NQIkFwRQw2Pn
 +G1WLwr0XLYbyrfulHxV3iMc7WvpSRIMb+ovXhdIsGd2UNa2LvJEKTb4keRSSXob2jHO
 oW9neFpr3hXr1gSV5Yj/uBMLfuuuG+dkcbS+24vW1b8fDCQgysFL5eWB2CWpKDYNPtdA
 MmoaHSsap/zcIz/bCp32t0ArbCZXyKPBgMinrl1Gw2fYXfipCWIgGMwtMD8I+BW5Id/w
 RhQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792246126; x=1792850926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C+1f1lj3zLciCCO8Mc5INC/JSPS2g2K5CtomKct7Fmg=;
 b=KKBE7mKE0fIEboGdET3K19MYOKqZlaXF5hAcDtsK5jNOXIGSsnmNQqTeD68XvsCmfl
 Jj+JRDUs+sJaPzcN53JTXLg8D0TSpBGw5xNLIKlOKXYmtkznbVHxZtYzto9X8LBDbpno
 yn+yexHZjr/U914cgFvaoX+NhIOP3oz9PfdDv45rVCEu1oYhfJiIMgYd7Oq1QGqblOAS
 /N3SPFERzFbwrQ1bjhbrq5YeOyRk7+tdkD+g5NIfcPAeJ/8qFdfdAszIXy/O7xoXv7SU
 0A+xG50TeokQIp7s/HHAXocPJs6U5Wlr82enyXS6hjiG6O7TMcWuKdIt2cBmerLHzgLX
 rHgw==
X-Forwarded-Encrypted: i=1;
 AKwUvByuiM4rGbmPaQFcjhTeJdtp8+xktdKOhZ5eChxX8fW55lHFT69DNswjazfWkjkUaDoIe+5HW8Rn0jA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIsLymYWCj5mmH72AU4J0YXNRS6lVkRMwGxjPSBbmIZBGy7BQwr
 ui24/8Zg/wQ5FKcQEWuTQaALfUn/kfntieCLqWjyM5pKoUwZjW7mQKEq
X-Gm-Gg: AYBFou03NRwf7xHMeEjTPZWyEv1cyZQRzi3G5sjeBshgyKuMli8cgAMcYL6Cu79lvJL
 QMUbw6V51+BLh6DaF///PpGkRDDzOorQxLgcoDMxxbGo3XZi7kGSglT2HBSCmYilrBqnqgDC1To
 IA5kZvratBFnFpQAC+DtReBOKFTDi8QwF7f2xQOnAOsP2HEVSFFHSbr4fEAfpK6CLFTYamcK82c
 Sd3wR9sQ4jUZf2vDlTKMDhKQTOpLjOjVJTJHm+gHUIDMyDHZnwF2A9QlUxHnYOvjOqLVT957fNo
 7LLv7HkWd0AWMxT6MwIxlKQb9GAkSDEGJ12vlPCnBYkFrOo2f3n043H9dhvzJyh3mpTC4sXPcIy
 vXk7+wmrzHDYRKBsASwlmZ8Fu766xu5RPtEiWbV/iYnmnN7Xf3hlq1lyytOtRxTNBDW+4ULG2QN
 IkXQCO4SKhAIAjUFiwDNoj0gyn3OnMZJqM2N4JKREGlxf5Y+FW7SPLIynwXIGZDbpC2VhMUD9mx
 IpTQexK+DHCHAzytcMCB9SqBD/DTmHQ5nc7pVwiGdn8v2gjK0f9iq+kbaIJ5IEYDU9859SbPF1b
 ww==
X-Received: by 2002:a05:600c:34d2:b0:4a1:cfa7:e968 with SMTP id
 5b1f17b1804b1-4a1d760d2camr53930535e9.21.1792246125729; 
 Sat, 17 Oct 2026 07:08:45 -0700 (PDT)
Received: from machine.home.arpa ([2a0d:3344:57f6::1046])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1ce3302b5sm84430745e9.4.2026.10.17.07.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Oct 2026 07:08:45 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Henrik Rydberg <rydberg@bitmath.org>,
 Douglas Anderson <dianders@chromium.org>, linux-input@vger.kernel.org,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Luka Panio <lukapanio@gmail.com>
Subject: [PATCH 6/7] Input: edt-ft5x06 - add SPI transport and FT8722 support
Date: Sat, 17 Oct 2026 16:07:54 +0200
Message-ID: <20261017140827.290666-7-lukapanio@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017140827.290666-1-lukapanio@gmail.com>
References: <20261017140827.290666-1-lukapanio@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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

Add an SPI bus driver and FT8722 support to edt-ft5x06.

The FT8722 TDDI has no flash, so add a boot hook that downloads the
firmware every time the controller comes out of reset: enter the boot
ROM, write the program and data RAM, verify both with the ROM's ECC
and start the application.

Signed-off-by: Luka Panio <lukapanio@gmail.com>
---
 drivers/input/touchscreen/Kconfig          |  14 +
 drivers/input/touchscreen/Makefile         |   1 +
 drivers/input/touchscreen/edt-ft5x06-spi.c | 475 +++++++++++++++++++++
 3 files changed, 490 insertions(+)
 create mode 100644 drivers/input/touchscreen/edt-ft5x06-spi.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index 9b9ae8ac3f7f..92840ea9c65f 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -805,6 +805,20 @@ config TOUCHSCREEN_EDT_FT5X06
 	  To compile this driver as a module, choose M here: the
 	  module will be called edt-ft5x06.
 
+config TOUCHSCREEN_EDT_FT5X06_SPI
+	tristate "EDT FocalTech FT5x06 SPI Touchscreen support"
+	depends on TOUCHSCREEN_EDT_FT5X06 && SPI
+	select CRC_CCITT
+	help
+	  Say Y here if you have a FocalTech touchscreen controller based
+	  on the FocalTech FT5x06 family of controllers that is connected over
+	  SPI.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called edt-ft5x06-spi.
+
 config TOUCHSCREEN_RASPBERRYPI_FW
 	tristate "Raspberry Pi's firmware base touch screen support"
 	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n && COMPILE_TEST)
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index bfd9de83389d..263c7e8039af 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -33,6 +33,7 @@ obj-$(CONFIG_TOUCHSCREEN_DA9034)	+= da9034-ts.o
 obj-$(CONFIG_TOUCHSCREEN_DA9052)	+= da9052_tsi.o
 obj-$(CONFIG_TOUCHSCREEN_DYNAPRO)	+= dynapro.o
 obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06)	+= edt-ft5x06.o
+obj-$(CONFIG_TOUCHSCREEN_EDT_FT5X06_SPI)	+= edt-ft5x06-spi.o
 obj-$(CONFIG_TOUCHSCREEN_HAMPSHIRE)	+= hampshire.o
 obj-$(CONFIG_TOUCHSCREEN_HYCON_HY46XX)	+= hycon-hy46xx.o
 obj-$(CONFIG_TOUCHSCREEN_GUNZE)		+= gunze.o
diff --git a/drivers/input/touchscreen/edt-ft5x06-spi.c b/drivers/input/touchscreen/edt-ft5x06-spi.c
new file mode 100644
index 000000000000..d0ae0d4b621d
--- /dev/null
+++ b/drivers/input/touchscreen/edt-ft5x06-spi.c
@@ -0,0 +1,475 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Luka Panio, <lukapanio@gmail.com>
+ *
+ * SPI transport for FocalTech touchscreen controllers handled by the
+ * edt-ft5x06 driver, with firmware download for the RAM-only FT8722.
+ *
+ * Protocol and boot sequence based on the FocalTech vendor driver:
+ * Copyright (c) 2012-2020, FocalTech Systems, Ltd.
+ */
+
+#include <linux/crc-ccitt.h>
+#include <linux/delay.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/input.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/property.h>
+#include <linux/regmap.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/unaligned.h>
+
+#include "edt-ft5x06.h"
+
+#define FTS_SPI_CTRL_WRITE		0x00
+#define FTS_SPI_CTRL_READ		BIT(7)
+#define FTS_SPI_CTRL_CRC		BIT(5)
+#define FTS_SPI_STATUS_ERR		(BIT(7) | BIT(5))
+#define FTS_SPI_HEADER_LEN		4
+#define FTS_SPI_DUMMY_LEN		3
+#define FTS_SPI_CRC_LEN			2
+#define FTS_SPI_RETRIES			3
+#define FTS_SPI_CS_HIGH_US		150
+
+/* Boot ROM commands */
+#define FTS_BOOT_CMD_START		0x55
+#define FTS_BOOT_CMD_READ_ID		0x90
+#define FTS_BOOT_CMD_START_APP		0x08
+#define FTS_BOOT_CMD_SET_ADDR		0xad
+#define FTS_BOOT_CMD_WRITE		0xae
+#define FTS_BOOT_CMD_ECC		0xcc
+#define FTS_BOOT_CMD_ECC_READ		0xcd
+#define FTS_BOOT_CMD_ECC_FINISH		0xce
+#define FTS_BOOT_ECC_FINISH_OK		0xa5
+#define FTS_BOOT_ECC_POLY		0x8408
+
+#define FTS_REG_CHIP_ID			0xa3
+
+/* Firmware image layout */
+#define FTS_FW_INFO_OFFSET		0x100
+#define FTS_FW_MIN_LEN			0x120
+
+#define FTS_BOOT_RETRIES		3
+#define FTS_ECC_RETRIES			100
+
+struct fts_ram_chip {
+	u8 boot_id[2];
+	u8 chip_id;
+	u8 len_unit;
+	u32 pram_max;
+	u32 dram_base;
+	u32 packet_len;
+	unsigned int boot_delay_ms;
+	const char *default_fw;
+};
+
+static int fts_spi_xfer(struct spi_device *spi, const u8 *tx, u8 *rx,
+			size_t len)
+{
+	struct spi_transfer xfer = {
+		.tx_buf = tx,
+		.rx_buf = rx,
+		.len = len,
+	};
+	int ret;
+
+	ret = spi_sync_transfer(spi, &xfer, 1);
+	fsleep(FTS_SPI_CS_HIGH_US);
+
+	return ret;
+}
+
+static int fts_spi_write(struct spi_device *spi, u8 reg, const void *val,
+			 size_t len)
+{
+	size_t xlen = FTS_SPI_HEADER_LEN + (len ? FTS_SPI_DUMMY_LEN + len : 0);
+	u8 *tx, *rx;
+	int ret, i;
+
+	if (len > U16_MAX)
+		return -EINVAL;
+
+	tx = kzalloc(2 * xlen, GFP_KERNEL);
+	if (!tx)
+		return -ENOMEM;
+	rx = tx + xlen;
+
+	tx[0] = reg;
+	tx[1] = FTS_SPI_CTRL_WRITE;
+	put_unaligned_be16(len, &tx[2]);
+	if (len)
+		memcpy(&tx[FTS_SPI_HEADER_LEN + FTS_SPI_DUMMY_LEN], val, len);
+
+	for (i = 0; i < FTS_SPI_RETRIES; i++) {
+		ret = fts_spi_xfer(spi, tx, rx, xlen);
+		if (!ret && !(rx[3] & FTS_SPI_STATUS_ERR))
+			break;
+		if (!ret)
+			ret = -EIO;
+	}
+
+	kfree(tx);
+	return ret;
+}
+
+static int fts_spi_read(struct spi_device *spi, u8 reg, void *val,
+			size_t len)
+{
+	size_t dp = FTS_SPI_HEADER_LEN + FTS_SPI_DUMMY_LEN;
+	size_t xlen = dp + len + FTS_SPI_CRC_LEN;
+	u8 *tx, *rx;
+	int ret, i;
+
+	if (!len || len > U16_MAX)
+		return -EINVAL;
+
+	tx = kzalloc(2 * xlen, GFP_KERNEL);
+	if (!tx)
+		return -ENOMEM;
+	rx = tx + xlen;
+
+	tx[0] = reg;
+	tx[1] = FTS_SPI_CTRL_READ | FTS_SPI_CTRL_CRC;
+	put_unaligned_be16(len, &tx[2]);
+
+	for (i = 0; i < FTS_SPI_RETRIES; i++) {
+		ret = fts_spi_xfer(spi, tx, rx, xlen);
+		if (ret)
+			continue;
+
+		if (rx[3] & FTS_SPI_STATUS_ERR) {
+			ret = -EIO;
+			continue;
+		}
+
+		if (crc_ccitt(0xffff, &rx[dp], len) !=
+		    get_unaligned_le16(&rx[dp + len])) {
+			ret = -EBADMSG;
+			continue;
+		}
+
+		memcpy(val, &rx[dp], len);
+		break;
+	}
+
+	kfree(tx);
+	return ret;
+}
+
+static int fts_spi_regmap_write(void *context, const void *data,
+				size_t count)
+{
+	const u8 *buf = data;
+
+	return fts_spi_write(context, buf[0], buf + 1, count - 1);
+}
+
+static int fts_spi_regmap_read(void *context, const void *reg,
+			       size_t reg_size, void *val, size_t val_size)
+{
+	return fts_spi_read(context, *(const u8 *)reg, val, val_size);
+}
+
+static const struct regmap_bus fts_spi_regmap_bus = {
+	.write = fts_spi_regmap_write,
+	.read = fts_spi_regmap_read,
+};
+
+static const struct regmap_config fts_spi_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+};
+
+static int fts_boot_enter(struct spi_device *spi, struct gpio_desc *reset,
+			  const struct fts_ram_chip *chip)
+{
+	u8 id[2] = { };
+	int ret, i;
+
+	for (i = 0; i < FTS_BOOT_RETRIES; i++) {
+		/* The boot ROM only listens shortly after reset */
+		if (i && reset) {
+			gpiod_set_value_cansleep(reset, 1);
+			usleep_range(1000, 2000);
+			gpiod_set_value_cansleep(reset, 0);
+		}
+		fsleep(chip->boot_delay_ms * USEC_PER_MSEC);
+
+		ret = fts_spi_write(spi, FTS_BOOT_CMD_START, NULL, 0);
+		if (ret)
+			continue;
+
+		fsleep(chip->boot_delay_ms * USEC_PER_MSEC);
+
+		ret = fts_spi_read(spi, FTS_BOOT_CMD_READ_ID, id, sizeof(id));
+		if (ret)
+			continue;
+
+		if (!memcmp(id, chip->boot_id, sizeof(id)))
+			return 0;
+
+		ret = -ENODEV;
+	}
+
+	dev_err(&spi->dev, "boot ROM not responding, last id %02x%02x: %d\n",
+		id[0], id[1], ret);
+	return ret;
+}
+
+static int fts_boot_write_ram(struct spi_device *spi,
+			      const struct fts_ram_chip *chip, u32 base,
+			      const u8 *data, u32 len)
+{
+	u8 addr[3];
+	u32 off, n;
+	int ret;
+
+	for (off = 0; off < len; off += n) {
+		n = min(len - off, chip->packet_len);
+
+		put_unaligned_be24(base + off, addr);
+		ret = fts_spi_write(spi, FTS_BOOT_CMD_SET_ADDR, addr,
+				    sizeof(addr));
+		if (ret)
+			return ret;
+
+		ret = fts_spi_write(spi, FTS_BOOT_CMD_WRITE, data + off, n);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static u16 fts_boot_ecc(const u8 *data, u32 len)
+{
+	u16 ecc = 0;
+	u32 i;
+	int j;
+
+	for (i = 0; i + 1 < len; i += 2) {
+		ecc ^= get_unaligned_be16(data + i);
+		for (j = 0; j < 16; j++)
+			ecc = (ecc & 1) ? (ecc >> 1) ^ FTS_BOOT_ECC_POLY :
+					  ecc >> 1;
+	}
+
+	return ecc;
+}
+
+static int fts_boot_check_ecc(struct spi_device *spi, const u8 *data,
+			      u32 len)
+{
+	u8 cmd[6], val[2];
+	int ret, i;
+
+	put_unaligned_be24(0, &cmd[0]);
+	put_unaligned_be24(len, &cmd[3]);
+	ret = fts_spi_write(spi, FTS_BOOT_CMD_ECC, cmd, sizeof(cmd));
+	if (ret)
+		return ret;
+
+	usleep_range(2000, 3000);
+
+	for (i = 0; i < FTS_ECC_RETRIES; i++) {
+		ret = fts_spi_read(spi, FTS_BOOT_CMD_ECC_FINISH, val, 1);
+		if (ret)
+			return ret;
+		if (val[0] == FTS_BOOT_ECC_FINISH_OK)
+			break;
+		usleep_range(1000, 2000);
+	}
+	if (i == FTS_ECC_RETRIES)
+		return -ETIMEDOUT;
+
+	ret = fts_spi_read(spi, FTS_BOOT_CMD_ECC_READ, val, sizeof(val));
+	if (ret)
+		return ret;
+
+	if (get_unaligned_be16(val) != fts_boot_ecc(data, len)) {
+		dev_err(&spi->dev, "ECC mismatch: %04x != %04x\n",
+			get_unaligned_be16(val), fts_boot_ecc(data, len));
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static u32 fts_fw_len(const struct firmware *fw, unsigned int off,
+		      const struct fts_ram_chip *chip)
+{
+	const u8 *info = fw->data + FTS_FW_INFO_OFFSET + off;
+	u16 len = get_unaligned_be16(info);
+
+	if ((u16)(len + get_unaligned_be16(info + 2)) != 0xffff)
+		return 0;
+
+	return len * chip->len_unit;
+}
+
+static int fts_ram_boot(struct device *dev, struct gpio_desc *reset,
+			const struct fts_ram_chip *chip)
+{
+	struct spi_device *spi = to_spi_device(dev);
+	const struct firmware *fw;
+	const char *fw_name = chip->default_fw;
+	u32 pram_len, dram_len;
+	u8 id;
+	int ret, i;
+
+	device_property_read_string(dev, "firmware-name", &fw_name);
+
+	ret = request_firmware(&fw, fw_name, dev);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
+	if (fw->size < FTS_FW_MIN_LEN) {
+		dev_err(dev, "firmware %s too short\n", fw_name);
+		goto out;
+	}
+
+	pram_len = fts_fw_len(fw, 0, chip);
+	dram_len = fts_fw_len(fw, 8, chip);
+	if (!pram_len || pram_len > chip->pram_max ||
+	    pram_len + dram_len > fw->size) {
+		dev_err(dev, "invalid firmware %s\n", fw_name);
+		goto out;
+	}
+
+	ret = fts_boot_enter(spi, reset, chip);
+	if (ret)
+		goto out;
+
+	ret = fts_boot_write_ram(spi, chip, 0, fw->data, pram_len);
+	if (!ret)
+		ret = fts_boot_check_ecc(spi, fw->data, pram_len);
+	if (ret) {
+		dev_err(dev, "failed to load program RAM: %d\n", ret);
+		goto out;
+	}
+
+	if (dram_len) {
+		ret = fts_boot_write_ram(spi, chip, chip->dram_base,
+					 fw->data + pram_len, dram_len);
+		if (!ret)
+			ret = fts_boot_check_ecc(spi, fw->data + pram_len,
+						 dram_len);
+		if (ret) {
+			dev_err(dev, "failed to load data RAM: %d\n", ret);
+			goto out;
+		}
+	}
+
+	ret = fts_spi_write(spi, FTS_BOOT_CMD_START_APP, NULL, 0);
+	if (ret)
+		goto out;
+
+	/* Wait for the application to report the chip ID */
+	for (i = 0; i < 20; i++) {
+		fsleep(10 * USEC_PER_MSEC);
+		if (!fts_spi_read(spi, FTS_REG_CHIP_ID, &id, 1) &&
+		    id == chip->chip_id)
+			break;
+	}
+	if (i == 20) {
+		dev_err(dev, "firmware did not start\n");
+		ret = -EIO;
+		goto out;
+	}
+
+	dev_dbg(dev, "loaded %s (%u + %u bytes)\n", fw_name, pram_len,
+		dram_len);
+out:
+	release_firmware(fw);
+	return ret;
+}
+
+static const struct fts_ram_chip fts_ft8722 = {
+	.boot_id = { 0x87, 0x22 },
+	.chip_id = 0x87,
+	.len_unit = 2,
+	.pram_max = 88 * 1024,
+	.dram_base = 0xd00000,
+	.packet_len = 32 * 1024 - 16,
+	.boot_delay_ms = 8,
+	.default_fw = "focaltech/ft8722.bin",
+};
+
+static int ft8722_boot(struct device *dev, struct gpio_desc *reset)
+{
+	return fts_ram_boot(dev, reset, &fts_ft8722);
+}
+
+static const struct edt_ft5x06_chip_data edt_ft8722_data = {
+	.max_support_points = 10,
+	.tdata_reg = 0x01,
+	.boot = ft8722_boot,
+};
+
+static int edt_ft5x06_spi_probe(struct spi_device *spi)
+{
+	const struct edt_ft5x06_chip_data *chip_data;
+	struct regmap *regmap;
+	int ret;
+
+	chip_data = spi_get_device_match_data(spi);
+	if (!chip_data)
+		return -ENODEV;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+	ret = spi_setup(spi);
+	if (ret)
+		return ret;
+
+	regmap = regmap_init(&spi->dev, &fts_spi_regmap_bus, spi,
+			     &fts_spi_regmap_config);
+	if (IS_ERR(regmap))
+		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
+				     "failed to init regmap\n");
+
+	return edt_ft5x06_probe(&spi->dev, regmap, spi->irq, chip_data,
+				BUS_SPI, NULL);
+}
+
+static void edt_ft5x06_spi_remove(struct spi_device *spi)
+{
+	edt_ft5x06_remove(&spi->dev);
+}
+
+static const struct of_device_id edt_ft5x06_spi_of_match[] = {
+	{ .compatible = "focaltech,ft8722-ts", .data = &edt_ft8722_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, edt_ft5x06_spi_of_match);
+
+static const struct spi_device_id edt_ft5x06_spi_ids[] = {
+	{ "ft8722-ts", (kernel_ulong_t)&edt_ft8722_data },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, edt_ft5x06_spi_ids);
+
+static struct spi_driver edt_ft5x06_spi_driver = {
+	.driver = {
+		.name = "edt_ft5x06_spi",
+		.dev_groups = edt_ft5x06_groups,
+		.of_match_table = edt_ft5x06_spi_of_match,
+		.pm = pm_sleep_ptr(&edt_ft5x06_pm_ops),
+		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
+	},
+	.id_table = edt_ft5x06_spi_ids,
+	.probe = edt_ft5x06_spi_probe,
+	.remove = edt_ft5x06_spi_remove,
+};
+module_spi_driver(edt_ft5x06_spi_driver);
+
+MODULE_IMPORT_NS("EDT_FT5X06");
+MODULE_AUTHOR("Luka Panio <lukapanio@gmail.com>");
+MODULE_DESCRIPTION("EDT FT5x06 SPI Touchscreen Driver");
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE("focaltech/ft8722.bin");
-- 
2.55.0

