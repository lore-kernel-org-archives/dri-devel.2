Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23077F327B2
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51EB510EB71;
	Tue, 21 Apr 2026 07:09:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="iXEj3hOy";
	dkim-atps=neutral
Received: from out28-147.mail.aliyun.com (out28-147.mail.aliyun.com
 [115.124.28.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FD4810E10C
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 02:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1776652749; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
 bh=Ir0KxAAn4FerualjHK4s3pLwwnuJV0oEPtqxTbJrSq0=;
 b=iXEj3hOyU2zf+2E1nK6+K71i0EazzY49iNqUicILBMK4SKbW4umlBEDuHrqBEI0ljo5V5+nIzGA3JutOEdxvMnynhAiMN7U8MxBypjfUAS1yTACaW7KAiM1G1P8IyH4F41Loj9rZ46qKsnyBE2jtB9VfdOjwHZkVVJ0LYZyEniKGrs5jNu8b9lDnOYR7HUXidmZBtzVZlGBQxoqGl5J/k8aY1in2EuF1kKIaNoWBEBIfO3PZUAttYwjQL2vFfSYdRj/3/5SVxH4dqxoqA+btl6sd2PpOqp/7tVnAeGk3EMqO1VaM9lw46CcDm4M4aDI4EMTrvr3FXuWoJgpKM/wAYw==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00847375-0.000234493-0.991292;
 FP=13482438463041654523|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033032062159; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=19; RT=19; SR=0; TI=SMTPD_---.hFmvE5U_1776652444; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hFmvE5U_1776652444 cluster:ay29) by smtp.aliyun-inc.com;
 Mon, 20 Apr 2026 10:34:05 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@ideasonboard.com,
 jonas@kwiboo.se, jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 Sunyun Yang <syyang@lontium.com>
Subject: [PATCH 2/2] drm/bridge: Add LT7911EXC edp to mipi bridge driver
Date: Mon, 20 Apr 2026 10:33:54 +0800
Message-Id: <20260420023354.1192642-3-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420023354.1192642-1-syyang@lontium.com>
References: <20260420023354.1192642-1-syyang@lontium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Apr 2026 07:09:47 +0000
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

From: Sunyun Yang <syyang@lontium.com>

LT7911EXC is a high performance  eDP1.4 to MIPI chip for 
VR/Display application.

-eDP1.4Receiver 
 1.Support SSC
 2.Support 1/2/4 lanes
 3.Support up to 4K@60HzRGB/YCbCr4:4:48bpc
 4.Support lane swap and PN swap

-MIPI Transmitter
 1.CompliantwithD-PHY1.2&DSI1.1&CSI-22.0；1 clock lane,
   and1/2/3/4 configurable data lanes:2.5Gbpsperdatalane
 2.CompliantwithC-PHY1.0&DSI-21.0&CSI-22.0;
   1/2/3 configurable data trio；2.5Gsps perdatatrio
 3.Support1/2configurable ports
 4.DSISupport16/20/24-bit YCbCr4:2:2,16/18/24/30-bit RGB

Signed-off-by: Sunyun Yang <syyang@lontium.com>
---
 drivers/gpu/drm/bridge/Kconfig             |  18 +
 drivers/gpu/drm/bridge/Makefile            |   1 +
 drivers/gpu/drm/bridge/lontium-lt7911exc.c | 571 +++++++++++++++++++++
 3 files changed, 590 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c3209b0f4678..bae8cdaea666 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -202,6 +202,24 @@ config DRM_LONTIUM_LT8713SX
 	  to 3 configurable Type-C/DP1.4/HDMI2.0 outputs
 	  Please say Y if you have such hardware.
 
+config DRM_LONTIUM_LT9611C
+	tristate "Lontium LT9611C DSI/HDMI bridge"
+	select SND_SOC_HDMI_CODEC if SND_SOC
+	depends on OF
+	select CRC8
+	select FW_LOADER
+	select DRM_PANEL_BRIDGE
+	select DRM_KMS_HELPER
+	select DRM_MIPI_DSI
+	select DRM_DISPLAY_HELPER
+	select DRM_DISPLAY_HDMI_STATE_HELPER
+	select REGMAP_I2C
+	help
+	  Driver for Lontium DSI to HDMI bridge
+	  chip driver that converts dual DSI and I2S to
+	  HDMI signals
+	  Please say Y if you have such hardware.
+
 config DRM_ITE_IT66121
 	tristate "ITE IT66121 HDMI bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index beab5b695a6e..54b293d1663e 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
 obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o
+obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) += lontium-lt7911exc.o
 obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
 obj-$(CONFIG_DRM_MICROCHIP_LVDS_SERIALIZER) += microchip-lvds.o
diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
new file mode 100644
index 000000000000..d1c1d9e073ef
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
@@ -0,0 +1,571 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Lontium Semiconductor, Inc.
+ */
+
+#include <linux/crc32.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <drm/drm_of.h>
+
+#define FW_SIZE (64 * 1024)
+#define LT_PAGE_SIZE 32
+#define FW_FILE  "LT7911EXC.bin"
+#define LT7911EXC_PAGE_CONTROL 0xff
+
+struct lt7911exc {
+	struct device *dev;
+	struct i2c_client *client;
+	struct drm_bridge bridge;
+	struct drm_bridge *panel_bridge;
+	struct regmap *regmap;
+	/* Protects all accesses to registers by stopping the on-chip MCU */
+	struct mutex ocm_lock;
+	struct regulator_bulk_data supplies[2];
+
+	struct gpio_desc *reset_gpio;
+	const struct firmware *fw;
+	int fw_version;
+	u32 fw_crc;
+
+	bool enabled;
+};
+
+static const struct regmap_range_cfg lt7911exc_ranges[] = {
+	{
+		.name = "register_range",
+		.range_min =  0,
+		.range_max = 0xffff,
+		.selector_reg = LT7911EXC_PAGE_CONTROL,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0,
+		.window_len = 0x100,
+	},
+};
+
+static const struct regmap_config lt7911exc_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = 0xffff,
+	.ranges = lt7911exc_ranges,
+	.num_ranges = ARRAY_SIZE(lt7911exc_ranges),
+};
+
+static u32 cal_crc32_custom(const u8 *data, u64 length)
+{
+	u32 crc = 0xffffffff;
+	u8 buf[4];
+	u64 i;
+
+	for (i = 0; i < length; i += 4) {
+		buf[0] = data[i + 3];
+		buf[1] = data[i + 2];
+		buf[2] = data[i + 1];
+		buf[3] = data[i + 0];
+		crc = crc32_be(crc, buf, 4);
+		}
+
+	return crc;
+}
+
+static inline struct lt7911exc *
+		bridge_to_lt7911exc(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct lt7911exc, bridge);
+}
+
+static int lt7911exc_regulator_enable(struct lt7911exc *lt7911exc)
+{
+	int ret;
+
+	ret = regulator_enable(lt7911exc->supplies[0].consumer);
+	if (ret < 0)
+		return ret;
+
+	usleep_range(5000, 10000);
+
+	ret = regulator_enable(lt7911exc->supplies[1].consumer);
+	if (ret < 0) {
+		regulator_disable(lt7911exc->supplies[0].consumer);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lt7911exc_regulator_disable(struct lt7911exc *lt7911exc)
+{
+	int ret;
+
+	ret = regulator_disable(lt7911exc->supplies[1].consumer);
+	if (ret < 0)
+		return ret;
+
+	ret = regulator_disable(lt7911exc->supplies[0].consumer);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static void lt7911exc_reset(struct lt7911exc *lt7911exc)
+{
+	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
+	msleep(20);
+
+	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
+	msleep(20);
+
+	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
+	msleep(400);
+
+	dev_dbg(lt7911exc->dev, "lt7911exc reset");
+}
+
+static int lt7911exc_parse_dt(struct lt7911exc *lt7911exc)
+{
+	int ret;
+
+	lt7911exc->supplies[0].supply = "vcc";
+	lt7911exc->supplies[1].supply = "vdd";
+
+	ret = devm_regulator_bulk_get(lt7911exc->dev, 2, lt7911exc->supplies);
+	if (ret) {
+		dev_err(lt7911exc->dev, "failed get regulator\n");
+		return ret;
+	}
+
+	lt7911exc->reset_gpio = devm_gpiod_get(lt7911exc->dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(lt7911exc->reset_gpio)) {
+		dev_err(lt7911exc->dev, "failed to acquire reset gpio\n");
+		return PTR_ERR(lt7911exc->reset_gpio);
+	}
+
+	return 0;
+}
+
+static int lt7911exc_read_version(struct lt7911exc *lt7911exc)
+{
+	u8 buf[2];
+	int ret;
+
+	ret = regmap_bulk_read(lt7911exc->regmap, 0xe081, buf, 3);
+	if (ret)
+		return ret;
+
+	return (buf[0] << 16) | (buf[1] << 8) | buf[2];
+}
+
+static void lt7911exc_lock(struct lt7911exc *lt7911exc)
+{
+	mutex_lock(&lt7911exc->ocm_lock);
+	regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
+}
+
+static void lt7911exc_unlock(struct lt7911exc *lt7911exc)
+{
+	regmap_write(lt7911exc->regmap, 0xe0ee, 0x00);
+	mutex_unlock(&lt7911exc->ocm_lock);
+}
+
+static int lt7911exc_prepare_firmware_data(struct lt7911exc *lt7911exc)
+{
+	struct device *dev = lt7911exc->dev;
+	int ret;
+	u8 *buffer;
+	size_t total_size = FW_SIZE - 4;
+
+	ret = request_firmware(&lt7911exc->fw, FW_FILE, dev);
+	if (ret) {
+		dev_err(dev, "failed load file '%s', error type %d\n", FW_FILE, ret);
+		return ret;
+	}
+
+	if (lt7911exc->fw->size > total_size) {
+		dev_err(dev, "firmware too large (%zu > %zu)\n", lt7911exc->fw->size, total_size);
+		release_firmware(lt7911exc->fw);
+		lt7911exc->fw = NULL;
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "firmware size: %zu bytes\n", lt7911exc->fw->size);
+
+	buffer = kzalloc(total_size, GFP_KERNEL);
+	if (!buffer) {
+		release_firmware(lt7911exc->fw);
+		lt7911exc->fw = NULL;
+		return -ENOMEM;
+	}
+
+	memset(buffer, 0xff, total_size);
+	memcpy(buffer, lt7911exc->fw->data, lt7911exc->fw->size);
+
+	lt7911exc->fw_crc = cal_crc32_custom(buffer, total_size);
+	dev_dbg(dev, "firmware crc: 0x%08x\n", lt7911exc->fw_crc);
+
+	kfree(buffer);
+	return 0;
+}
+
+static void lt7911exc_block_erase(struct lt7911exc *lt7911exc)
+{
+	struct device *dev = lt7911exc->dev;
+	const u32 addr = 0x00;
+
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(0xe0ee, 0x01),
+		REG_SEQ0(0xe054, 0x01),
+		REG_SEQ0(0xe055, 0x06),
+		REG_SEQ0(0xe051, 0x01),
+		REG_SEQ0(0xe051, 0x00),
+		REG_SEQ0(0xe054, 0x05),
+		REG_SEQ0(0xe055, 0xd8),
+		REG_SEQ0(0xe05a, (addr >> 16) & 0xff),
+		REG_SEQ0(0xe05b, (addr >> 8) & 0xff),
+		REG_SEQ0(0xe05c, addr & 0xff),
+		REG_SEQ0(0xe051, 0x01),
+		REG_SEQ0(0xe050, 0x00),
+	};
+
+	regmap_multi_reg_write(lt7911exc->regmap, seq_write, ARRAY_SIZE(seq_write));
+
+	msleep(200);
+	dev_dbg(dev, "erase flash done.\n");
+}
+
+static void lt7911exc_prog_init(struct lt7911exc *lt7911exc, u64 addr)
+{
+	const struct reg_sequence seq_write[] = {
+		REG_SEQ0(0xe0ee, 0x01),
+		REG_SEQ0(0xe05f, 0x01),
+		REG_SEQ0(0xe05a, (addr >> 16) & 0xff),
+		REG_SEQ0(0xe05b, (addr >> 8) & 0xff),
+		REG_SEQ0(0xe05c, addr & 0xff),
+	};
+
+	regmap_multi_reg_write(lt7911exc->regmap, seq_write, ARRAY_SIZE(seq_write));
+}
+
+static int lt7911exc_write_data(struct lt7911exc *lt7911exc, u64 addr)
+{
+	struct device *dev = lt7911exc->dev;
+	int ret;
+	int page = 0, num = 0, page_len = 0;
+	u64 size, offset;
+	const u8 *data;
+
+	data = lt7911exc->fw->data;
+	size = lt7911exc->fw->size;
+	page = (size + LT_PAGE_SIZE - 1) / LT_PAGE_SIZE;
+	if (page * LT_PAGE_SIZE > FW_SIZE) {
+		dev_err(dev, "firmware size out of range\n");
+		return -EINVAL;
+	}
+
+	dev_dbg(dev, "%u pages, total size %llu byte\n", page, size);
+
+	for (num = 0; num < page; num++) {
+		offset = num * LT_PAGE_SIZE;
+		page_len = (offset + LT_PAGE_SIZE <= size) ? LT_PAGE_SIZE : (size - offset);
+		lt7911exc_prog_init(lt7911exc, addr);
+
+		ret = regmap_raw_write(lt7911exc->regmap, 0xe05d, &data[offset], page_len);
+		if (ret) {
+			dev_err(dev, "write error at page %d\n", num);
+			return ret;
+		}
+
+		if (page_len < LT_PAGE_SIZE) {
+			regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
+			regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
+			//hardware requires delay
+			usleep_range(1000, 2000);
+		}
+
+		regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
+		addr += LT_PAGE_SIZE;
+	}
+
+	return 0;
+}
+
+static int lt7911exc_write_crc(struct lt7911exc *lt7911exc, u64 addr)
+{
+	u8 crc[4];
+	int ret;
+
+	crc[0] = lt7911exc->fw_crc & 0xff;
+	crc[1] = (lt7911exc->fw_crc >> 8) & 0xff;
+	crc[2] = (lt7911exc->fw_crc >> 16) & 0xff;
+	crc[3] = (lt7911exc->fw_crc >> 24) & 0xff;
+
+	regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
+	regmap_write(lt7911exc->regmap, 0xe05a, (addr >> 16) & 0xff);
+	regmap_write(lt7911exc->regmap, 0xe05b, (addr >> 8) & 0xff);
+	regmap_write(lt7911exc->regmap, 0xe05c, addr & 0xff);
+
+	ret = regmap_raw_write(lt7911exc->regmap, 0xe05d, crc, 4);
+	if (ret)
+		return ret;
+	regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
+	regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
+	usleep_range(1000, 2000);
+	regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
+
+	return 0;
+}
+
+static int lt7911exc_firmware_upgrade(struct lt7911exc *lt7911exc)
+{
+	struct device *dev = lt7911exc->dev;
+	int ret;
+
+	ret = lt7911exc_prepare_firmware_data(lt7911exc);
+	if (ret < 0)
+		return ret;
+
+	dev_dbg(dev, "starting firmware upgrade, size: %zu bytes\n", lt7911exc->fw->size);
+
+	lt7911exc_block_erase(lt7911exc);
+
+	ret = lt7911exc_write_data(lt7911exc, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to write firmware data\n");
+		return ret;
+	}
+
+	release_firmware(lt7911exc->fw);
+	lt7911exc->fw = NULL;
+
+	ret = lt7911exc_write_crc(lt7911exc, FW_SIZE - 4);
+	if (ret < 0) {
+		dev_err(dev, "failed to write firmware crc\n");
+		return ret;
+	}
+
+	return 0;
+}
+
+static int lt7911exc_upgrade_result(struct lt7911exc *lt7911exc)
+{
+	struct device *dev = lt7911exc->dev;
+	u32 read_hw_crc = 0;
+	u8 crc_tmp[4];
+	int ret;
+
+	regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
+	regmap_write(lt7911exc->regmap, 0xe07b, 0x60);
+	regmap_write(lt7911exc->regmap, 0xe07b, 0x40);
+	msleep(150);
+	ret = regmap_bulk_read(lt7911exc->regmap, 0x22, crc_tmp, 4);
+	if (ret) {
+		dev_err(lt7911exc->dev, "Failed to read CRC: %d\n", ret);
+		return ret;
+	}
+
+	read_hw_crc = crc_tmp[0] << 24 | crc_tmp[1] << 16 |
+				crc_tmp[2] << 8 | crc_tmp[3];
+
+	if (read_hw_crc != lt7911exc->fw_crc) {
+		dev_err(dev, "lt7911exc firmware upgrade failed, expected CRC=0x%08x, read CRC=0x%08x\n",
+			lt7911exc->fw_crc, read_hw_crc);
+		return -EIO;
+	}
+
+	dev_dbg(dev, "lt7911exc firmware upgrade success, CRC=0x%08x\n", read_hw_crc);
+	return 0;
+}
+
+static void lt7911exc_pre_enable(struct drm_bridge *bridge)
+{
+	struct lt7911exc *lt7911exc = bridge_to_lt7911exc(bridge);
+	int ret;
+
+	if (lt7911exc->enabled)
+		return;
+
+	ret = lt7911exc_regulator_enable(lt7911exc);
+	if (ret)
+		return;
+
+	lt7911exc_reset(lt7911exc);
+
+	lt7911exc->enabled = true;
+}
+
+static void lt7911exc_disable(struct drm_bridge *bridge)
+{
+	/* Delay after panel is disabled */
+	msleep(20);
+}
+
+static void lt7911exc_post_disable(struct drm_bridge *bridge)
+{
+	struct lt7911exc *lt7911exc = bridge_to_lt7911exc(bridge);
+	int ret;
+
+	if (!lt7911exc->enabled)
+		return;
+
+	lt7911exc->enabled = false;
+
+	ret = lt7911exc_regulator_disable(lt7911exc);
+	if (ret)
+		return;
+
+	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
+}
+
+static int lt7911exc_attach(struct drm_bridge *bridge,
+			    struct drm_encoder *encoder,
+			    enum drm_bridge_attach_flags flags)
+{
+	struct lt7911exc *lt7911exc = bridge_to_lt7911exc(bridge);
+
+	return drm_bridge_attach(lt7911exc->bridge.encoder, lt7911exc->panel_bridge,
+				 &lt7911exc->bridge, flags);
+}
+
+static const struct drm_bridge_funcs lt7911exc_bridge_funcs = {
+	.pre_enable = lt7911exc_pre_enable,
+	.disable = lt7911exc_disable,
+	.post_disable = lt7911exc_post_disable,
+	.attach = lt7911exc_attach,
+};
+
+static int lt7911exc_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct lt7911exc *lt7911exc;
+	struct drm_bridge *panel_bridge;
+	bool fw_updated = false;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
+		dev_err(dev, "device doesn't support I2C\n");
+		return -ENODEV;
+	}
+
+	lt7911exc = devm_drm_bridge_alloc(dev, struct lt7911exc, bridge,
+					  &lt7911exc_bridge_funcs);
+	if (IS_ERR(lt7911exc))
+		return PTR_ERR(lt7911exc);
+
+	panel_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 0, 0);
+	if (IS_ERR(panel_bridge))
+		return PTR_ERR(panel_bridge);
+
+	lt7911exc->panel_bridge = panel_bridge;
+	lt7911exc->client = client;
+	lt7911exc->dev = dev;
+	i2c_set_clientdata(client, lt7911exc);
+	mutex_init(&lt7911exc->ocm_lock);
+
+	lt7911exc->regmap = devm_regmap_init_i2c(client, &lt7911exc_regmap_config);
+	if (IS_ERR(lt7911exc->regmap)) {
+		dev_err(dev, "regmap i2c init failed\n");
+		return PTR_ERR(lt7911exc->regmap);
+	}
+
+	ret = lt7911exc_parse_dt(lt7911exc);
+	if (ret)
+		return ret;
+
+	ret = lt7911exc_regulator_enable(lt7911exc);
+	if (ret)
+		return ret;
+
+	lt7911exc_reset(lt7911exc);
+	lt7911exc->enabled = true;
+	lt7911exc_lock(lt7911exc);
+
+retry:
+	lt7911exc->fw_version = lt7911exc_read_version(lt7911exc);
+	if (lt7911exc->fw_version < 0) {
+		dev_err(dev, "failed to read FW version\n");
+		lt7911exc_unlock(lt7911exc);
+		goto err_disable_regulators;
+
+	} else if (lt7911exc->fw_version == 0) {
+		if (!fw_updated) {
+			fw_updated = true;
+			ret = lt7911exc_firmware_upgrade(lt7911exc);
+			if (ret < 0) {
+				lt7911exc_unlock(lt7911exc);
+				goto err_disable_regulators;
+			}
+
+			lt7911exc_reset(lt7911exc);
+
+			ret = lt7911exc_upgrade_result(lt7911exc);
+			if (ret < 0) {
+				lt7911exc_unlock(lt7911exc);
+				goto err_disable_regulators;
+			}
+
+			goto retry;
+
+		} else {
+			dev_err(dev, "fw version 0x%04x, update failed\n", lt7911exc->fw_version);
+			ret = -EOPNOTSUPP;
+			lt7911exc_unlock(lt7911exc);
+			goto err_disable_regulators;
+		}
+	}
+
+	lt7911exc_unlock(lt7911exc);
+
+	lt7911exc->bridge.type = DRM_MODE_CONNECTOR_DSI;
+	lt7911exc->bridge.of_node = dev->of_node;
+	drm_bridge_add(&lt7911exc->bridge);
+
+	return 0;
+
+err_disable_regulators:
+	regulator_bulk_disable(ARRAY_SIZE(lt7911exc->supplies), lt7911exc->supplies);
+	if (lt7911exc->fw) {
+		release_firmware(lt7911exc->fw);
+		lt7911exc->fw = NULL;
+	}
+
+	return ret;
+}
+
+static void lt7911exc_remove(struct i2c_client *client)
+{
+	struct lt7911exc *lt7911exc = i2c_get_clientdata(client);
+
+	drm_bridge_remove(&lt7911exc->bridge);
+	mutex_destroy(&lt7911exc->ocm_lock);
+}
+
+static const struct i2c_device_id lt7911exc_i2c_table[] = {
+	{"lontium, lt7911exc", 0},
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(i2c, lt7911exc_i2c_table);
+
+static const struct of_device_id lt7911exc_devices[] = {
+	{.compatible = "lontium,lt7911exc",},
+	{}
+};
+MODULE_DEVICE_TABLE(of, lt7911exc_devices);
+
+static struct i2c_driver lt7911exc_driver = {
+	.id_table	= lt7911exc_i2c_table,
+	.probe		= lt7911exc_probe,
+	.remove		= lt7911exc_remove,
+	.driver		= {
+		.name	= "lt7911exc",
+		.of_match_table = lt7911exc_devices,
+	},
+};
+module_i2c_driver(lt7911exc_driver);
+
+MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
+MODULE_DESCRIPTION("Lontium lt7911exc edp to mipi dsi bridge driver");
+MODULE_LICENSE("GPL v2");
-- 
2.34.1

