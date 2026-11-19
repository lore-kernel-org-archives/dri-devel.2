Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE5D606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 07:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=q1ab5F18
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B173C10FCDD;
	Thu, 19 Nov 2026 07:48:52 +0000 (UTC)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7142910E4EF
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1795056490; bh=LjU6et09z+4LTYCgFxOVr0gqOEbWQOQz9Sm57WvJHzk=;
 h=From:To:Cc:Subject:Date;
 b=q1ab5F18uFkETf7SKcVqxXkj2HtTGeYE6rC/DntEicRGFy+YnffV1XBam8rRU+1IB
 yt3Squv5IzOIG1GxzbRMNH+c+wVOLaiZrPSfojnfIa9b2LiFoJchomR0bTl44mYdGV
 tk3DuJNvO/CSCIyw45Xc9MfJMXGAtbTMl6cgo+Xo=
Received: from [192.168.2.135] ([113.90.236.90])
 by newxmesmtplogicsvrszb43-0.qq.com (NewEsmtp) with SMTP
 id BFA264FE; Thu, 19 Nov 2026 10:47:58 +0800
X-QQ-mid: xmsmtpt1795056487t3936ch7o
Message-ID: <tencent_5A564BDF0E844A4F30BFD9A85EE3C51F3B08@qq.com>
X-QQ-XMAILINFO: OATpkVjS499u9yaGSSvTsV8Hq20O3ghovj+R6JVglP724SnHPGrO07fVV0p2c/
 LXCqTtcJ372Ikt0r67cWk8ru1fcHwEBdJfOdEW0/G9+HQQ7bz9JvKQJo5e1FVXT5vJbGFWswRbTD
 vp1rFY8zCdQXvKJaSer/rx3xfihuIcPK2mHDNPHGRtHVUkEN16AIOLpXf6lSxQjg7Dw9xFstfaIA
 5UTGVssvjWRkdnGN9sTctu2gGmwh5nCKblnnbuen8pEi4XgJp1b+EHhApyuEnPWY8C7Bt53ohzDV
 8i0RdcCnDqvSq32XUKBe96vqiQ5VtS/I82Q11lPDdv8NMWyy40c+D4e2EFYGcDm9tzsKEmXvDK5N
 ybGYVooWtDqbGdO6/PMMAg8oRbQ/CBTQwayD2j/kHnSwU7Z4u3iG3PTt5DDvZXVTyAIUMomBisRq
 GlDIPehstN51rQ0OMB4OUv2+9DrpwStqDmA1LmD4lj0O4bpRRNpEzBgDuLDe209/Mj3iQAPGOTjt
 GaCEyMN+/yDosTmLXcBVtqdsGTmd4MhdWp0Z1qt/QH9hVaEDKZI3chzGK+o3wdQTO4Of7DjXSU42
 6/6KZ7+rXurgUAzO2b65ATmVOk0pFfwijlM/urKiQGXhxAq2t0a1mMPFgznhkbzvbE6TDsHgXBDZ
 PhLfdY0z+kRGzDBBmNZqvPXy/fyuasEIBpVvleyoapTe8GT5ouVNXzMeV5lLWKV2hSnvQ3CSVmi5
 kPvq/eGjNGO9PlmlWSfVrB2bBgGdAC7GguCaDyypZWBwbLHAfSocCRJUQOvTOlszWc7ymhoHHtvY
 3xuqEzk/WFVVL7XGP4m78/NMnzjbMHQoD0GWbg+/mAazlEuf9I+Ua80D9kxhyDrt99yOAYNBG6za
 N1hoBzXoLz2YQH7p3AIe4r/KFeJ8/dVdwtK9E4f+7LDXAq4FLL2IZSdcpxAlUHZbZxcRYLtm1VY8
 am8bfKd5KkllC5RzXJw3UIn4FhcqYiAohZlwdNY4IYZ36NsTn4+bEI6JMf+cjYszlGvpMkPTZiiK
 KECvXBQD0LxUFuhGrkeyHY4vzlFjiZh0Ri0rBwEQ+vwunAxNVpYHXr/s/NVNs=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
From: Hefei <3066883572@qq.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 5/6] Input: add Jadard JD9365TX in-cell touchscreen driver
Date: Thu, 19 Nov 2026 10:48:10 +0800
X-OQ-MSGID: <179505649000.50956.16687767535487291401@qq.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 19 Nov 2026 07:48:39 +0000
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
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a polling I2C touchscreen driver for Jadard JD9365TX in-cell
panels that do not wire an interrupt line on the FPC.

Signed-off-by: Hefei <3066883572@qq.com>
---
 drivers/input/touchscreen/Kconfig           |  12 +
 drivers/input/touchscreen/Makefile          |   1 +
 drivers/input/touchscreen/jadard_jd9365tx.c | 347 ++++++++++++++++++++
 3 files changed, 360 insertions(+)
 create mode 100644 drivers/input/touchscreen/jadard_jd9365tx.c

diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
index e2ee722..da425c8 100644
--- a/drivers/input/touchscreen/Kconfig
+++ b/drivers/input/touchscreen/Kconfig
@@ -540,6 +540,18 @@ config TOUCHSCREEN_IPROC
 	  To compile this driver as a module, choose M here: the
 	  module will be called bcm_iproc_tsc.
 
+config TOUCHSCREEN_JADARD_JD9365TX
+	tristate "Jadard JD9365TX in-cell touchscreen"
+	depends on I2C
+	help
+	  Say Y here if you have a Jadard JD9365TX in-cell touchscreen.
+	  The driver polls over I2C when no interrupt line is wired.
+
+	  If unsure, say N.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called jadard_jd9365tx.
+
 config TOUCHSCREEN_S6SY761
 	tristate "Samsung S6SY761 Touchscreen driver"
 	depends on I2C
diff --git a/drivers/input/touchscreen/Makefile b/drivers/input/touchscreen/Makefile
index 58094f2..5846f4d 100644
--- a/drivers/input/touchscreen/Makefile
+++ b/drivers/input/touchscreen/Makefile
@@ -59,6 +59,7 @@ obj-$(CONFIG_TOUCHSCREEN_IMAGIS)	+= imagis.o
 obj-$(CONFIG_TOUCHSCREEN_IMX6UL_TSC)	+= imx6ul_tsc.o
 obj-$(CONFIG_TOUCHSCREEN_INEXIO)	+= inexio.o
 obj-$(CONFIG_TOUCHSCREEN_IPROC)		+= bcm_iproc_tsc.o
+obj-$(CONFIG_TOUCHSCREEN_JADARD_JD9365TX) += jadard_jd9365tx.o
 obj-$(CONFIG_TOUCHSCREEN_LPC32XX)	+= lpc32xx_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MAX11801)	+= max11801_ts.o
 obj-$(CONFIG_TOUCHSCREEN_MXS_LRADC)     += mxs-lradc-ts.o
diff --git a/drivers/input/touchscreen/jadard_jd9365tx.c b/drivers/input/touchscreen/jadard_jd9365tx.c
new file mode 100644
index 0000000..eec8dc7
--- /dev/null
+++ b/drivers/input/touchscreen/jadard_jd9365tx.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2026 VIEWE
+ *
+ * Jadard JD9365TX in-cell touchscreen (I2C @0x68, polling).
+ * Typical DSI FPC has no interrupt line.
+ */
+
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/input.h>
+#include <linux/input/mt.h>
+#include <linux/input/touchscreen.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/property.h>
+#include <linux/slab.h>
+
+#define JD_CHIP_ID			0x9084
+#define JD_CHIP_ID_ALT			0x9032
+#define JD_SOC_CHIP_ID2			0x40008076
+#define JD_ERAM_BASE			0x20011000
+#define JD_SECTION_READY_VAL		0xA55A
+#define JD_MAX_DSRAM_NUM		25
+#define JD_ESRAM_COORD_IDX		1
+#define JD_ESRAM_SECTION_NUM		6
+#define JD_DEFAULT_COORD_ADDR		0x20011120
+#define JD_TOUCH_DATA_SIZE		78
+#define JD_FINGER_DATA_SIZE		5
+#define JD_FINGER_NUM_ADDR		0
+#define JD_TOUCH_COORD_INFO_ADDR	3
+#define JD_MAX_POINTS			10
+#define JD_DEFAULT_POLL_MS		16
+
+struct jadard_tp {
+	struct i2c_client *client;
+	struct input_dev *input;
+	struct touchscreen_properties prop;
+	u32 coord_addr;
+	u16 touch_data_size;
+	u16 max_points;
+	u16 abs_x_max;
+	u16 abs_y_max;
+	unsigned int poll_interval_ms;
+	bool ready;
+};
+
+static int jd_bus_write(struct i2c_client *client, const u8 *cmd, u8 cmd_len,
+			const u8 *data, u16 data_len)
+{
+	u8 buf[64];
+	struct i2c_msg msg;
+	int ret;
+
+	if (cmd_len + data_len > sizeof(buf))
+		return -EINVAL;
+
+	memcpy(buf, cmd, cmd_len);
+	if (data_len)
+		memcpy(buf + cmd_len, data, data_len);
+
+	msg.addr = client->addr;
+	msg.flags = 0;
+	msg.len = cmd_len + data_len;
+	msg.buf = buf;
+
+	ret = i2c_transfer(client->adapter, &msg, 1);
+	return ret == 1 ? 0 : (ret < 0 ? ret : -EIO);
+}
+
+static int jd_bus_read(struct i2c_client *client, const u8 *cmd, u8 cmd_len,
+		       u8 *data, u16 data_len)
+{
+	struct i2c_msg msg[2];
+	int ret;
+
+	msg[0].addr = client->addr;
+	msg[0].flags = 0;
+	msg[0].len = cmd_len;
+	msg[0].buf = (u8 *)cmd;
+	msg[1].addr = client->addr;
+	msg[1].flags = I2C_M_RD;
+	msg[1].len = data_len;
+	msg[1].buf = data;
+
+	ret = i2c_transfer(client->adapter, msg, 2);
+	return ret == 2 ? 0 : (ret < 0 ? ret : -EIO);
+}
+
+static int jd_enter_backdoor(struct i2c_client *client)
+{
+	const u8 cmd[5] = { 0xF2, 0xAA, 0xF0, 0x0F, 0x55 };
+	const u8 data = 0x68;
+
+	return jd_bus_write(client, cmd, sizeof(cmd), &data, 1);
+}
+
+static int jd_read_reg(struct i2c_client *client, u32 addr, u8 *rdata, u16 rlen)
+{
+	u8 cmd[6];
+
+	cmd[0] = 0xF3;
+	cmd[1] = (addr >> 24) & 0xFF;
+	cmd[2] = (addr >> 16) & 0xFF;
+	cmd[3] = (addr >> 8) & 0xFF;
+	cmd[4] = addr & 0xFF;
+	cmd[5] = 0x03;
+
+	return jd_bus_read(client, cmd, sizeof(cmd), rdata, rlen);
+}
+
+static int jd_get_chip_id(struct i2c_client *client, u16 *id)
+{
+	u8 rbuf[2];
+	int ret;
+
+	ret = jd_read_reg(client, JD_SOC_CHIP_ID2, rbuf, sizeof(rbuf));
+	if (ret)
+		return ret;
+
+	*id = (u16)((rbuf[1] << 8) | rbuf[0]);
+	return 0;
+}
+
+static bool jd_section_ready(struct i2c_client *client)
+{
+	u8 rbuf[2];
+	unsigned int waited = 0;
+
+	do {
+		msleep(2);
+		if (jd_read_reg(client, JD_ERAM_BASE, rbuf, sizeof(rbuf)))
+			return false;
+		waited += 2;
+		if (((rbuf[1] << 8) | rbuf[0]) == JD_SECTION_READY_VAL)
+			return true;
+	} while (waited < 100);
+
+	return false;
+}
+
+static int jd_resolve_coord_addr(struct jadard_tp *ts)
+{
+	u32 esram_num_addr = JD_ERAM_BASE + 4 + JD_MAX_DSRAM_NUM * 8;
+	u32 esram_sec_addr = esram_num_addr + 4;
+	u8 buf[JD_ESRAM_SECTION_NUM * 8];
+	u32 addr, len;
+	int ret;
+
+	ret = jd_read_reg(ts->client, esram_sec_addr, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	addr = buf[JD_ESRAM_COORD_IDX * 8 + 0] |
+	       (buf[JD_ESRAM_COORD_IDX * 8 + 1] << 8) |
+	       (buf[JD_ESRAM_COORD_IDX * 8 + 2] << 16) |
+	       (buf[JD_ESRAM_COORD_IDX * 8 + 3] << 24);
+	len = buf[JD_ESRAM_COORD_IDX * 8 + 4] |
+	      (buf[JD_ESRAM_COORD_IDX * 8 + 5] << 8) |
+	      (buf[JD_ESRAM_COORD_IDX * 8 + 6] << 16) |
+	      (buf[JD_ESRAM_COORD_IDX * 8 + 7] << 24);
+
+	if (addr < JD_ERAM_BASE || addr >= JD_ERAM_BASE + 0x1000 ||
+	    len == 0 || len > JD_TOUCH_DATA_SIZE)
+		return -EINVAL;
+
+	ts->coord_addr = addr;
+	ts->touch_data_size = (u16)len;
+	return 0;
+}
+
+static int jd_hw_init(struct jadard_tp *ts)
+{
+	u16 chip_id = 0;
+	int ret;
+
+	ret = jd_enter_backdoor(ts->client);
+	if (ret)
+		return ret;
+
+	ret = jd_get_chip_id(ts->client, &chip_id);
+	if (ret)
+		return ret;
+
+	if (chip_id != JD_CHIP_ID && chip_id != JD_CHIP_ID_ALT &&
+	    (chip_id == 0 || chip_id == 0xFFFF))
+		return -ENODEV;
+
+	jd_enter_backdoor(ts->client);
+
+	if (jd_section_ready(ts->client) && !jd_resolve_coord_addr(ts))
+		return 0;
+
+	if (!ts->coord_addr)
+		ts->coord_addr = JD_DEFAULT_COORD_ADDR;
+	ts->touch_data_size = JD_TOUCH_DATA_SIZE;
+
+	return 0;
+}
+
+static void jd_report_touches(struct jadard_tp *ts, const u8 *buf)
+{
+	u8 finger_num = buf[JD_FINGER_NUM_ADDR];
+	unsigned int i;
+	bool any = false;
+
+	if (finger_num > ts->max_points)
+		finger_num = ts->max_points;
+
+	for (i = 0; i < ts->max_points; i++) {
+		const u8 *c = buf + JD_TOUCH_COORD_INFO_ADDR +
+			      i * JD_FINGER_DATA_SIZE;
+		u16 x = (c[0] << 8) | c[1];
+		u16 y = (c[2] << 8) | c[3];
+		u8 w = c[4];
+		bool down = false;
+
+		if (i < finger_num &&
+		    x <= ts->abs_x_max && y <= ts->abs_y_max &&
+		    x != 0xFFFF && y != 0xFFFF)
+			down = true;
+
+		input_mt_slot(ts->input, i);
+		input_mt_report_slot_state(ts->input, MT_TOOL_FINGER, down);
+
+		if (down) {
+			touchscreen_report_pos(ts->input, &ts->prop, x, y, true);
+			input_report_abs(ts->input, ABS_MT_TOUCH_MAJOR, w);
+			any = true;
+		}
+	}
+
+	input_mt_sync_frame(ts->input);
+	input_report_key(ts->input, BTN_TOUCH, any);
+	input_sync(ts->input);
+}
+
+static void jd_poll(struct input_dev *input)
+{
+	struct jadard_tp *ts = input_get_drvdata(input);
+	u8 buf[JD_TOUCH_DATA_SIZE];
+	int ret;
+
+	if (!ts->ready) {
+		ret = jd_hw_init(ts);
+		if (ret)
+			return;
+		ts->ready = true;
+	}
+
+	ret = jd_read_reg(ts->client, ts->coord_addr, buf, ts->touch_data_size);
+	if (!ret)
+		jd_report_touches(ts, buf);
+}
+
+static int jadard_tp_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct jadard_tp *ts;
+	struct input_dev *input;
+	u32 val;
+	int ret;
+
+	ts = devm_kzalloc(dev, sizeof(*ts), GFP_KERNEL);
+	if (!ts)
+		return -ENOMEM;
+
+	ts->client = client;
+	ts->max_points = JD_MAX_POINTS;
+	ts->abs_x_max = 719;
+	ts->abs_y_max = 1279;
+	ts->poll_interval_ms = JD_DEFAULT_POLL_MS;
+	ts->touch_data_size = JD_TOUCH_DATA_SIZE;
+
+	if (!device_property_read_u32(dev, "poll-interval", &val) &&
+	    val >= 8 && val <= 100)
+		ts->poll_interval_ms = val;
+
+	if (!of_property_read_u32(dev->of_node, "touchscreen-size-x", &val) && val)
+		ts->abs_x_max = val - 1;
+
+	if (!of_property_read_u32(dev->of_node, "touchscreen-size-y", &val) && val)
+		ts->abs_y_max = val - 1;
+
+	if (!of_property_read_u32(dev->of_node, "jadard,coord-addr", &val) && val)
+		ts->coord_addr = val;
+
+	input = devm_input_allocate_device(dev);
+	if (!input)
+		return -ENOMEM;
+
+	input->name = "Jadard JD9365TX Touchscreen";
+	input->id.bustype = BUS_I2C;
+	input->dev.parent = dev;
+
+	__set_bit(EV_ABS, input->evbit);
+	__set_bit(EV_KEY, input->evbit);
+	__set_bit(BTN_TOUCH, input->keybit);
+
+	input_set_abs_params(input, ABS_MT_POSITION_X, 0, ts->abs_x_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_POSITION_Y, 0, ts->abs_y_max, 0, 0);
+	input_set_abs_params(input, ABS_MT_TOUCH_MAJOR, 0, 255, 0, 0);
+
+	touchscreen_parse_properties(input, true, &ts->prop);
+
+	ret = input_mt_init_slots(input, ts->max_points, INPUT_MT_DIRECT);
+	if (ret)
+		return ret;
+
+	input_set_drvdata(input, ts);
+	ts->input = input;
+	i2c_set_clientdata(client, ts);
+
+	ret = input_setup_polling(input, jd_poll);
+	if (ret)
+		return ret;
+
+	input_set_poll_interval(input, ts->poll_interval_ms);
+
+	return input_register_device(input);
+}
+
+static const struct of_device_id jadard_tp_of_match[] = {
+	{ .compatible = "jadard,jd9365tx" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, jadard_tp_of_match);
+
+static const struct i2c_device_id jadard_tp_id[] = {
+	{ "jd9365tx", 0 },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, jadard_tp_id);
+
+static struct i2c_driver jadard_tp_driver = {
+	.driver = {
+		.name = "jadard-tp-jd9365tx",
+		.of_match_table = jadard_tp_of_match,
+	},
+	.probe = jadard_tp_probe,
+	.id_table = jadard_tp_id,
+};
+module_i2c_driver(jadard_tp_driver);
+
+MODULE_AUTHOR("Hefei <3066883572@qq.com>");
+MODULE_DESCRIPTION("Jadard JD9365TX in-cell touchscreen");
+MODULE_LICENSE("GPL");
-- 
2.55.0.windows.5

