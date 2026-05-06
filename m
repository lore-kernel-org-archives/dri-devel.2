Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47BF9CD3427
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 01:32:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A48710E4B8;
	Wed,  6 May 2026 01:32:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=lontium.com header.i=@lontium.com header.b="Jh3BGe1d";
	dkim-atps=neutral
Received: from out28-1.mail.aliyun.com (out28-1.mail.aliyun.com [115.124.28.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE28C10E4B8
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 01:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lontium.com; s=default;
 t=1778031122; h=From:To:Subject:Date:Message-Id:MIME-Version;
 bh=zIVHhqIkWuavpvABXBsPyCmHX/+ZDKDfyFuIyfPH2fQ=;
 b=Jh3BGe1d7hyLeSthWOe3JaPJztVojCth/RByT2GULGJdTXWmbcpNKyrJemd6DsHN7rpi6PlyvjIXZjNlZoq3acvGR5asT29e614kw5xc1gzJN6NBW/7PLW2voCfVBoBRLopBm5zgKUp7eXHZ4DnOgI1TjXqnNFFJ6jaTvF2yf4Q0HMZgk9vnMNkn2XNvb6SF1lUlinoEgSYGrxhSL5Zaex6VCovMw6Q2+V0kKuC254VYNgIPjYgeMT+6H76wKKKhogviWvZ8zIPzu0I1uQtIY4nBLG0XHxeS06baEFQHRhshIC3NYd5E1sgqFg/QRZ2PrYT8aBE26cfDO09juemEIw==
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07436259|-1; CH=green;
 DM=|CONTINUE|false|;
 DS=CONTINUE|ham_system_inform|0.00694244-0.000684144-0.992373;
 FP=13770664448520374011|0|0|0|0|-1|-1|-1;
 HT=maildocker-contentspam033037022039; MF=syyang@lontium.com; NM=1; PH=DS;
 RN=22; RT=22; SR=0; TI=SMTPD_---.hQNamnX_1778031119; 
Received: from DESKTOP-V2MKAT2.localdomain(mailfrom:syyang@lontium.com
 fp:SMTPD_---.hQNamnX_1778031119 cluster:ay29) by smtp.aliyun-inc.com;
 Wed, 06 May 2026 09:32:01 +0800
From: syyang@lontium.com
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 dmitry.baryshkov@oss.qualcomm.com, maarten.lankhorst@linux.intel.com,
 rfoss@kernel.org, mripard@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, tzimmermann@suse.de, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 yangsunyun1993@gmail.com, xmzhu@lontium.corp-partner.google.com,
 xmzhu@lontium.com, rlyu@lontium.com, xbpeng@lontium.com,
 Sunyun Yang <syyang@lontium.com>
Subject: [PATCH v5 2/2] drm/bridge: Add Lontium LT7911EXC eDP to MIPI DSI
 bridge
Date: Wed,  6 May 2026 09:31:53 +0800
Message-Id: <20260506013153.2240-3-syyang@lontium.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260506013153.2240-1-syyang@lontium.com>
References: <20260506013153.2240-1-syyang@lontium.com>
MIME-Version: 1.0
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

From: Sunyun Yang <syyang@lontium.com>

The LT7911EXC is an I2C-controlled bridge that Receiver eDP1.4
and output signal/dual port mipi dsi.

Signed-off-by: Sunyun Yang <syyang@lontium.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/Kconfig             |  13 +
 drivers/gpu/drm/bridge/Makefile            |   1 +
 drivers/gpu/drm/bridge/lontium-lt7911exc.c | 493 +++++++++++++++++++++
 3 files changed, 507 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt7911exc.c

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c3209b0f4678..fe45a9052aa0 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -132,6 +132,19 @@ config DRM_ITE_IT6505
 	help
 	  ITE IT6505 DisplayPort bridge chip driver.
 
+config DRM_LONTIUM_LT7911EXC
+	tristate "Lontium eDP/MIPI DSI bridge"
+	depends on OF
+	select CRC32
+	select FW_LOADER
+	select DRM_PANEL
+	select DRM_KMS_HELPER
+	help
+	  DRM driver for the Lontium LT7911EXC bridge chip.
+	  The LT7911EXC converts eDP input to single/dual port
+	  MIPI DSI output.
+	  Please say Y if you have such hardware.
+
 config DRM_LONTIUM_LT8912B
 	tristate "Lontium LT8912B DSI/HDMI bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index beab5b695a6e..70ddca75dd3a 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_DRM_I2C_NXP_TDA998X) += tda998x.o
 obj-$(CONFIG_DRM_INNO_HDMI) += inno-hdmi.o
 obj-$(CONFIG_DRM_ITE_IT6263) += ite-it6263.o
 obj-$(CONFIG_DRM_ITE_IT6505) += ite-it6505.o
+obj-$(CONFIG_DRM_LONTIUM_LT7911EXC) += lontium-lt7911exc.o
 obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
 obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
diff --git a/drivers/gpu/drm/bridge/lontium-lt7911exc.c b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
new file mode 100644
index 000000000000..02648b396343
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lontium-lt7911exc.c
@@ -0,0 +1,493 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 Lontium Semiconductor, Inc.
+ */
+
+#include <linux/crc32.h>
+#include <linux/firmware.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <drm/drm_bridge.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
+
+#define FW_SIZE (64 * 1024)
+#define LT_PAGE_SIZE 32
+#define FW_FILE  "lt7911exc_fw.bin"
+#define LT7911EXC_PAGE_CONTROL 0xff
+
+struct lt7911exc {
+	struct device *dev;
+	struct i2c_client *client;
+	struct drm_bridge bridge;
+	struct regmap *regmap;
+	/* Protects all accesses to registers by stopping the on-chip MCU */
+	struct mutex ocm_lock;
+	struct regulator_bulk_data supplies[2];
+	struct gpio_desc *reset_gpio;
+	int fw_version;
+};
+
+static const struct regmap_range_cfg lt7911exc_ranges[] = {
+	{
+		.name = "register_range",
+		.range_min =  0,
+		.range_max = 0xe8ff,
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
+	.max_register = 0xe8ff,
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
+	}
+
+	return crc;
+}
+
+static inline struct lt7911exc *bridge_to_lt7911exc(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct lt7911exc, bridge);
+}
+
+static void lt7911exc_reset(struct lt7911exc *lt7911exc)
+{
+	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
+	msleep(20);
+
+	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
+	msleep(20);
+
+	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 0);
+	msleep(400);
+
+	dev_dbg(lt7911exc->dev, "lt7911exc reset.\n");
+}
+
+static int lt7911exc_parse_dt(struct lt7911exc *lt7911exc)
+{
+	struct device *dev = lt7911exc->dev;
+	int ret;
+
+	lt7911exc->supplies[0].supply = "vcc";
+	lt7911exc->supplies[1].supply = "vdd";
+
+	ret = devm_regulator_bulk_get(dev, 2, lt7911exc->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed get regulator\n");
+
+	lt7911exc->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(lt7911exc->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(lt7911exc->reset_gpio),
+				     "failed to acquire reset gpio\n");
+
+	return 0;
+}
+
+static int lt7911exc_read_version(struct lt7911exc *lt7911exc)
+{
+	u8 buf[3];
+	int ret;
+
+	ret = regmap_write(lt7911exc->regmap, 0xe0ee, 0x01);
+	if (ret)
+		return ret;
+	ret = regmap_bulk_read(lt7911exc->regmap, 0xe081, buf, sizeof(buf));
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
+static int lt7911exc_write_data(struct lt7911exc *lt7911exc, const struct firmware *fw, u64 addr)
+{
+	struct device *dev = lt7911exc->dev;
+	int ret;
+	int page = 0, num = 0, page_len = 0;
+	u64 size, offset;
+	const u8 *data;
+
+	data = fw->data;
+	size = fw->size;
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
+static int lt7911exc_write_crc(struct lt7911exc *lt7911exc, u32 crc32, u64 addr)
+{
+	u8 crc[4];
+	int ret;
+
+	crc[0] = crc32 & 0xff;
+	crc[1] = (crc32 >> 8) & 0xff;
+	crc[2] = (crc32 >> 16) & 0xff;
+	crc[3] = (crc32 >> 24) & 0xff;
+
+	regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
+	regmap_write(lt7911exc->regmap, 0xe05a, (addr >> 16) & 0xff);
+	regmap_write(lt7911exc->regmap, 0xe05b, (addr >> 8) & 0xff);
+	regmap_write(lt7911exc->regmap, 0xe05c, addr & 0xff);
+
+	ret = regmap_raw_write(lt7911exc->regmap, 0xe05d, crc, 4);
+	if (ret)
+		return ret;
+
+	regmap_write(lt7911exc->regmap, 0xe05f, 0x05);
+	regmap_write(lt7911exc->regmap, 0xe05f, 0x01);
+	usleep_range(1000, 2000);
+	regmap_write(lt7911exc->regmap, 0xe05f, 0x00);
+
+	return 0;
+}
+
+static int lt7911exc_upgrade_result(struct lt7911exc *lt7911exc, u32 crc32)
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
+	if (read_hw_crc != crc32) {
+		dev_err(dev, "lt7911exc firmware upgrade failed, expected CRC=0x%08x, read CRC=0x%08x\n",
+			crc32, read_hw_crc);
+		return -EIO;
+	}
+
+	dev_dbg(dev, "lt7911exc firmware upgrade success, CRC=0x%08x\n", read_hw_crc);
+	return 0;
+}
+
+static int lt7911exc_firmware_upgrade(struct lt7911exc *lt7911exc)
+{
+	struct device *dev = lt7911exc->dev;
+	const struct firmware *fw;
+	u8 *buffer;
+	size_t total_size = FW_SIZE - 4;
+	u32 crc32;
+	int ret;
+
+	/*1. load firmware*/
+	ret = request_firmware(&fw, FW_FILE, dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to load '%s'\n", FW_FILE);
+
+	/*2. check size*/
+	if (fw->size > total_size) {
+		dev_err(dev, "firmware too large (%zu > %zu)\n", fw->size, total_size);
+		ret = -EINVAL;
+		goto out_release_fw;
+	}
+
+	/*3. calculate crc32 */
+	buffer = kzalloc(total_size, GFP_KERNEL);
+	if (!buffer) {
+		ret = -ENOMEM;
+		goto out_release_fw;
+	}
+	memset(buffer, 0xff, total_size);
+	memcpy(buffer, fw->data, fw->size);
+
+	crc32 = cal_crc32_custom(buffer, total_size);
+	kfree(buffer);
+
+	/*4. firmware upgrade */
+	dev_dbg(dev, "starting firmware upgrade, size: %zu bytes\n", fw->size);
+
+	lt7911exc_block_erase(lt7911exc);
+
+	ret = lt7911exc_write_data(lt7911exc, fw, 0);
+	if (ret < 0) {
+		dev_err(dev, "failed to write firmware data\n");
+		goto out_release_fw;
+	}
+
+	ret = lt7911exc_write_crc(lt7911exc, crc32, FW_SIZE - 4);
+	if (ret < 0) {
+		dev_err(dev, "failed to write firmware crc\n");
+		goto out_release_fw;
+	}
+
+	/*5. check upgrade of result*/
+	lt7911exc_reset(lt7911exc);
+
+	ret = lt7911exc_upgrade_result(lt7911exc, crc32);
+
+out_release_fw:
+	release_firmware(fw);
+	return ret;
+}
+
+static void lt7911exc_atomic_pre_enable(struct drm_bridge *bridge, struct drm_atomic_state *state)
+{
+	struct lt7911exc *lt7911exc = bridge_to_lt7911exc(bridge);
+	int ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(lt7911exc->supplies), lt7911exc->supplies);
+	if (ret)
+		return;
+
+	lt7911exc_reset(lt7911exc);
+}
+
+static void lt7911exc_atomic_disable(struct drm_bridge *bridge, struct drm_atomic_state *state)
+{
+	/* Delay after panel is disabled */
+	msleep(20);
+}
+
+static void lt7911exc_atomic_post_disable(struct drm_bridge *bridge, struct drm_atomic_state *state)
+{
+	struct lt7911exc *lt7911exc = bridge_to_lt7911exc(bridge);
+	int ret;
+
+	ret = regulator_bulk_disable(ARRAY_SIZE(lt7911exc->supplies), lt7911exc->supplies);
+	if (ret)
+		return;
+
+	gpiod_set_value_cansleep(lt7911exc->reset_gpio, 1);
+}
+
+static int lt7911exc_attach(struct drm_bridge *bridge,
+			    struct drm_encoder *encoder,
+			    enum drm_bridge_attach_flags flags)
+{
+	struct lt7911exc *lt7911exc = bridge_to_lt7911exc(bridge);
+
+	return drm_bridge_attach(lt7911exc->bridge.encoder, lt7911exc->bridge.next_bridge,
+				 &lt7911exc->bridge, flags);
+}
+
+static const struct drm_bridge_funcs lt7911exc_bridge_funcs = {
+	.attach = lt7911exc_attach,
+	.atomic_pre_enable = lt7911exc_atomic_pre_enable,
+	.atomic_disable = lt7911exc_atomic_disable,
+	.atomic_post_disable = lt7911exc_atomic_post_disable,
+};
+
+static int lt7911exc_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct lt7911exc *lt7911exc;
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
+		return dev_err_probe(dev, PTR_ERR(lt7911exc), "drm bridge alloc failed.\n");
+
+	lt7911exc->bridge.next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+	if (IS_ERR(lt7911exc->bridge.next_bridge))
+		return PTR_ERR(lt7911exc->bridge.next_bridge);
+
+	lt7911exc->client = client;
+	lt7911exc->dev = dev;
+	i2c_set_clientdata(client, lt7911exc);
+
+	ret = devm_mutex_init(dev, &lt7911exc->ocm_lock);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to init mutex\n");
+
+	lt7911exc->regmap = devm_regmap_init_i2c(client, &lt7911exc_regmap_config);
+	if (IS_ERR(lt7911exc->regmap))
+		return dev_err_probe(dev, PTR_ERR(lt7911exc->regmap), "regmap i2c init failed\n");
+
+	ret = lt7911exc_parse_dt(lt7911exc);
+	if (ret)
+		return ret;
+
+	ret = regulator_bulk_enable(ARRAY_SIZE(lt7911exc->supplies), lt7911exc->supplies);
+	if (ret)
+		return ret;
+
+	lt7911exc_reset(lt7911exc);
+	lt7911exc_lock(lt7911exc);
+
+retry:
+	lt7911exc->fw_version = lt7911exc_read_version(lt7911exc);
+	if (lt7911exc->fw_version < 0) {
+		dev_err(dev, "failed to read chip fw version\n");
+		ret = -EOPNOTSUPP;
+		goto err_disable_regulators;
+
+	} else if (lt7911exc->fw_version == 0) {
+		if (!fw_updated) {
+			fw_updated = true;
+			ret = lt7911exc_firmware_upgrade(lt7911exc);
+			if (ret < 0)
+				goto err_disable_regulators;
+
+			goto retry;
+
+		} else {
+			dev_err(dev, "fw version 0x%04x, update failed\n", lt7911exc->fw_version);
+			ret = -EOPNOTSUPP;
+			goto err_disable_regulators;
+		}
+	}
+
+	lt7911exc_unlock(lt7911exc);
+
+	lt7911exc->bridge.of_node = dev->of_node;
+	devm_drm_bridge_add(dev, &lt7911exc->bridge);
+
+	return 0;
+
+err_disable_regulators:
+	lt7911exc_unlock(lt7911exc);
+	regulator_bulk_disable(ARRAY_SIZE(lt7911exc->supplies), lt7911exc->supplies);
+	return ret;
+}
+
+static const struct i2c_device_id lt7911exc_i2c_table[] = {
+	{"lt7911exc"},
+	{/* sentinel */}
+};
+
+MODULE_DEVICE_TABLE(i2c, lt7911exc_i2c_table);
+
+static const struct of_device_id lt7911exc_devices[] = {
+	{.compatible = "lontium,lt7911exc"},
+	{/* sentinel */}
+};
+MODULE_DEVICE_TABLE(of, lt7911exc_devices);
+
+static struct i2c_driver lt7911exc_driver = {
+	.id_table	= lt7911exc_i2c_table,
+	.probe		= lt7911exc_probe,
+	.driver		= {
+		.name	= "lt7911exc",
+		.of_match_table = lt7911exc_devices,
+	},
+};
+module_i2c_driver(lt7911exc_driver);
+
+MODULE_AUTHOR("SunYun Yang <syyang@lontium.com>");
+MODULE_DESCRIPTION("Lontium LT7911EXC EDP to MIPI DSI bridge driver");
+MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(FW_FILE);
-- 
2.34.1

