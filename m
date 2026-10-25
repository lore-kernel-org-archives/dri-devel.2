Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CC3606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 08:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mg-crea-com.20251104.gappssmtp.com header.i=@mg-crea-com.20251104.gappssmtp.com header.a=rsa-sha256 header.s=20251104 header.b=K6YQyj1B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1453910EC50;
	Mon, 26 Oct 2026 08:36:45 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88BF210E879
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 08:58:23 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48b042c0759so1218583f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 25 Oct 2026 01:58:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mg-crea-com.20251104.gappssmtp.com; s=20251104; t=1792918702; x=1793523502;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=At55VbEIUsasl7OxdFDzlSnsOUvX8xe1OzwnO0ut21E=;
 b=K6YQyj1BV5KpImtUdWfxC0PyOF9CNetuvWRR72FhP+1werXpBWI87VC81Ig2dF8Kp5
 eIGUCE029j7KHutjZTNW5AdhN0GVfnym5/4c0oOo6s7Nk7HiO4fg7+v7XAZxZrcGhU+o
 4/GZtCFhpnrTV0WRp1owdY9FzNnnfYJPh6pxtbwPrSj0M4h28U6wB47HgCqYtPKOp4M9
 qZiagjq8oofj2EXCvwjzAxszGL6ilhqEgXMGhZ/yBlryod6tMROEZ15649Y4nHZ3EDix
 g0T5xNFkrR8EiuEPBh/8ySoAZxFJ6uCdD1FVoK6ugYQZyrYwA3iJhmG4VdIgJgs/HbUg
 XsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792918702; x=1793523502;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=At55VbEIUsasl7OxdFDzlSnsOUvX8xe1OzwnO0ut21E=;
 b=SrDUt930+4trylNWaodSMngaBHK5sP0Wt9SUhnpJPXH1D26kJJZh/eV0w+03I1Jw74
 546eO9XSpmb6nPMfVFBJBS3W8ngNmt5Ri+mzDrMQaBt/o/CuD3hTOGWQrau+4T1/9sT/
 LhqhdRHrAtUCbzCgbKa67GjlH5+tjySfUYWqJTdTCqaeSoxC2Foxgi+qIleirD8l8m4T
 gLERMgcHTzyJzFnOoGbYx80rHB8kG4RDUrkqG6rcKcnxCaM3OS3pCr73kU2GyOW5AeRk
 09w1XaVIThqXK8xSbwRVXnA1XHHrLqG71eFwGyMKoML1jBXsCC7eGCOc8+gbUVPAG4mR
 7VXg==
X-Forwarded-Encrypted: i=1;
 AKwUvByP2zQT35ysko/F+FCTc+VvzAYZcMREXKhI/VUz38O0LNPIGecMOrh/YI7SR3+svKgy6QrBdhLoRqM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLb/kPN3nxxO2R2M4aFmtrtDDFjMfGL8OxKa+sQqfp7y1NjEGy/
 PBuvkKTzGaDWrBPQueHD3ALzgMoXt99HHt6FsTqjMbFy0J1yOBFDV3hYapbOISZg8p0=
X-Gm-Gg: AYBFou1IYafx/E98cmUVoy1/vcWmp2aR4qpuACfhj59AcPNEnXGMlfo9Q4Etne3s97h
 JK/VgmAaw6/bswTfee9YF8KipJXwt3Smqxd+H34gmJexdEfCWA3grkVDorkYFoBqJJfV8+H38Wu
 KzjCG/7dL8B3B6/kBbnhNCzyIgqyCATBPuTAkoTQmnTPGKVFAl7sfgHiFK7rGtN0K+1BLglIKQG
 sDwqwkaJGEFXHbB1eu9WCMuy4cHK8PyE8QVNIosno3yjT3tpuRrQ4Ti3mdbIVxOHjLCUEA99MZj
 R7+4LpG2GecIlaq9tD0A+ChaGg5tqcMxccQOPCsT9MlCnyWWM9bA7KybNFeDQliwt2wiffTsKJM
 whJfKYF3teAye/yDFrxqrLAO198aWQuRJZXm1lttuLf/zZrYaeUWPldObyr83I8onBPjhSHsEoP
 tYa2C6upySSy30STnFkjtTo+nVcI4W6qqriZaYEu4/Zh6lI7NlvcqWEly2FZ/cnHPnfv7D/6mju
 jGOXDxvmTkz19AuvLVlu2EWqqicpwlmwwXcNBuk39K9HyKjYIrgqhNgmC9yYLj8rcmLTnpYsThZ
 W3WrI2Snxo7Mw0lnhpGDRw4bhC3zT1jUqeiIelxkmp4qCtVS8ir0IHJ25y9ecKqYXOlVnZgXdw=
 =
X-Received: by 2002:a05:6000:481b:b0:48e:82f:48fc with SMTP id
 ffacd0b85a97d-48e3eb971ccmr6935030f8f.31.1792918701855; 
 Sun, 25 Oct 2026 01:58:21 -0700 (PDT)
Received: from localhost.localdomain
 (2a01cb060184ad00bcfbae5efa3e0f0b.ipv6.abo.wanadoo.fr.
 [2a01:cb06:184:ad00:bcfb:ae5e:fa3e:f0b])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3cfasm9094542f8f.17.2026.10.25.01.58.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 25 Oct 2026 01:58:21 -0700 (PDT)
From: Olivier Louvignes <olivier@mgcrea.io>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Paul Cercueil <paul@crapouillou.net>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
 Olivier Louvignes <olivier@mgcrea.io>
Subject: [PATCH 5/5] drm/panel: Add the HiBy LG35583
Date: Sun, 25 Oct 2026 09:58:16 +0100
Message-ID: <20261025085816.60405-6-olivier@mgcrea.io>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261025085816.60405-1-olivier@mgcrea.io>
References: <20261025085816.60405-1-olivier@mgcrea.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 26 Oct 2026 08:36:44 +0000
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
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The 480x800 parallel RGB panel of the HiBy R1. It is set up over a 3-wire
SPI bus with 16-bit words, each carrying a register address byte or a
data byte, which no existing panel driver speaks. The set-up sequence is
the vendor kernel's; prepare sends it up to sleep-out, and enable and
disable switch the display on and off. It asks for BGR666: in RGB order the
R1 shows red and blue swapped.

Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
---
 MAINTAINERS                                |   1 +
 drivers/gpu/drm/panel/Kconfig              |  10 +
 drivers/gpu/drm/panel/Makefile             |   1 +
 drivers/gpu/drm/panel/panel-hiby-lg35583.c | 342 +++++++++++++++++++++
 4 files changed, 354 insertions(+)
 create mode 100644 drivers/gpu/drm/panel/panel-hiby-lg35583.c

diff --git a/MAINTAINERS b/MAINTAINERS
index e65500a70c9d..994847735999 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8156,6 +8156,7 @@ DRM DRIVER FOR HIBY LG35583 PANEL
 M:	Olivier Louvignes <olivier@mgcrea.io>
 S:	Maintained
 F:	Documentation/devicetree/bindings/display/panel/hiby,lg35583.yaml
+F:	drivers/gpu/drm/panel/panel-hiby-lg35583.c
 
 DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
 M:	Ondrej Jirman <megi@xff.cz>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7a520b4d60fe..164ac349abd6 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -209,6 +209,16 @@ config DRM_PANEL_LVDS
 	  handling of power supplies or control signals. It implements automatic
 	  backlight handling if the panel is attached to a backlight controller.
 
+config DRM_PANEL_HIBY_LG35583
+	tristate "HiBy LG35583 RGB/SPI panel"
+	depends on OF && SPI
+	help
+	  Say Y here if you want to enable support for the LG35583, the
+	  480x800 parallel RGB panel of the HiBy R1 digital audio player,
+	  which is set up over a 3-wire SPI bus.
+
+	  To compile this driver as a module, choose M here.
+
 config DRM_PANEL_HIMAX_HX8279
 	tristate "Himax HX8279-based panels"
 	depends on OF
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index da5175909d54..a2b34ed7cdba 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -21,6 +21,7 @@ obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) += panel-elida-kd35t133.o
 obj-$(CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02) += panel-feixin-k101-im2ba02.o
 obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) += panel-feiyang-fy07024di26a30d.o
 obj-$(CONFIG_DRM_PANEL_FOCALTECH_OTA7290B) += panel-focaltech-ota7290b.o
+obj-$(CONFIG_DRM_PANEL_HIBY_LG35583) += panel-hiby-lg35583.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX8279) += panel-himax-hx8279.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83102) += panel-himax-hx83102.o
 obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) += panel-himax-hx83112a.o
diff --git a/drivers/gpu/drm/panel/panel-hiby-lg35583.c b/drivers/gpu/drm/panel/panel-hiby-lg35583.c
new file mode 100644
index 000000000000..47aba09e91a4
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-hiby-lg35583.c
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * The LG35583 panel of the HiBy R1
+ *
+ * Copyright (c) 2026 Olivier Louvignes <olivier@mgcrea.io>
+ *
+ * A 480x800 parallel RGB panel, set up over a 3-wire SPI bus with 16-bit
+ * words: 0x20 and a register's high byte, 0x00 and its low byte, then 0x40
+ * and each data byte. HiBy calls it the LG35583; its controller is not
+ * identified. The set-up sequence is the one the vendor kernel sends.
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/media-bus-format.h>
+#include <linux/module.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+
+#define LG35583_ADDR_HI		0x2000
+#define LG35583_ADDR_LO		0x0000
+#define LG35583_DATA		0x4000
+
+#define LG35583_SLPIN		0x1000
+#define LG35583_SLPOUT		0x1100
+#define LG35583_DISPOFF		0x2800
+#define LG35583_DISPON		0x2900
+#define LG35583_RAMWR		0x2c00
+
+struct lg35583_write {
+	u16 reg;	/* 0: wait val milliseconds */
+	s16 val;	/* -1: no data */
+};
+
+#define REG(r, v)	{ (r), (v) }
+#define CMD(r)		{ (r), -1 }
+#define DELAY(ms)	{ 0, (ms) }
+
+static const struct lg35583_write lg35583_init[] = {
+	REG(0xb100, 0x06), REG(0xb101, 0x01), REG(0xb102, 0x54),
+	REG(0xb104, 0x07), REG(0xb105, 0x06), REG(0xb106, 0x06),
+	REG(0xb107, 0x4a), REG(0xb108, 0x21), REG(0xb109, 0x08),
+	REG(0xf101, 0xc0), REG(0xf103, 0x01),
+	DELAY(5),
+	REG(0xb400, 0x01), REG(0xb600, 0x10),
+	REG(0x3a00, 0x77), REG(0x3b00, 0x03), REG(0x5e04, 0x02),
+	REG(0x3600, 0x08),
+	DELAY(5),
+	/* Gamma */
+	REG(0xe000, 0x00), REG(0xe001, 0x2f), REG(0xe002, 0x3f),
+	REG(0xe003, 0x1f), REG(0xe004, 0x21), REG(0xe005, 0x2c),
+	REG(0xe006, 0x2c), REG(0xe007, 0x61), REG(0xe008, 0x1c),
+	REG(0xe009, 0x18), REG(0xe00a, 0xbc), REG(0xe00b, 0x27),
+	REG(0xe00c, 0x59), REG(0xe00d, 0x6a), REG(0xe00e, 0xbb),
+	REG(0xe00f, 0xbe), REG(0xe010, 0x3e), REG(0xe011, 0x48),
+	REG(0xe100, 0x00), REG(0xe101, 0x32), REG(0xe102, 0x45),
+	REG(0xe103, 0x26), REG(0xe104, 0x21), REG(0xe105, 0x2c),
+	REG(0xe106, 0x5c), REG(0xe107, 0x63), REG(0xe108, 0x1c),
+	REG(0xe109, 0x19), REG(0xe10a, 0xd3), REG(0xe10b, 0x28),
+	REG(0xe10c, 0x59), REG(0xe10d, 0x6b), REG(0xe10e, 0xdb),
+	REG(0xe10f, 0xde), REG(0xe110, 0x5f), REG(0xe111, 0x6b),
+	REG(0xe200, 0x7f), REG(0xe201, 0x7d), REG(0xe202, 0x86),
+	REG(0xe203, 0x89), REG(0xe204, 0x10), REG(0xe205, 0x1e),
+	REG(0xe206, 0x41), REG(0xe207, 0x77), REG(0xe208, 0x0d),
+	REG(0xe209, 0x1d), REG(0xe20a, 0xc8), REG(0xe20b, 0x30),
+	REG(0xe20c, 0x5f), REG(0xe20d, 0x71), REG(0xe20e, 0xc3),
+	REG(0xe20f, 0xbe), REG(0xe210, 0x3e), REG(0xe211, 0x48),
+	REG(0xe300, 0x7f), REG(0xe301, 0x7f), REG(0xe302, 0x86),
+	REG(0xe303, 0x93), REG(0xe304, 0x10), REG(0xe305, 0x1e),
+	REG(0xe306, 0x41), REG(0xe307, 0x89), REG(0xe308, 0x0d),
+	REG(0xe309, 0x1d), REG(0xe30a, 0xe0), REG(0xe30b, 0x30),
+	REG(0xe30c, 0x5f), REG(0xe30d, 0x70), REG(0xe30e, 0xe4),
+	REG(0xe30f, 0xdf), REG(0xe310, 0x5f), REG(0xe311, 0x6b),
+	REG(0xe400, 0x00), REG(0xe401, 0x43), REG(0xe402, 0x6f),
+	REG(0xe403, 0x60), REG(0xe404, 0x21), REG(0xe405, 0x2c),
+	REG(0xe406, 0x5a), REG(0xe407, 0x6d), REG(0xe408, 0x1c),
+	REG(0xe409, 0x18), REG(0xe40a, 0xc6), REG(0xe40b, 0x27),
+	REG(0xe40c, 0x59), REG(0xe40d, 0x6a), REG(0xe40e, 0xbb),
+	REG(0xe40f, 0xbe), REG(0xe410, 0x3e), REG(0xe411, 0x48),
+	REG(0xe500, 0x00), REG(0xe501, 0x46), REG(0xe502, 0x75),
+	REG(0xe503, 0x67), REG(0xe504, 0x21), REG(0xe505, 0x2c),
+	REG(0xe506, 0x5a), REG(0xe507, 0x7e), REG(0xe508, 0x1c),
+	REG(0xe509, 0x19), REG(0xe50a, 0xdd), REG(0xe50b, 0x28),
+	REG(0xe50c, 0x59), REG(0xe50d, 0x6b), REG(0xe50e, 0xdb),
+	REG(0xe50f, 0xde), REG(0xe510, 0x5f), REG(0xe511, 0x6b),
+	DELAY(5),
+	REG(0xc200, 0x70), REG(0xc202, 0x70), REG(0xc203, 0x44),
+	DELAY(20),
+	REG(0xc200, 0x51), REG(0xc201, 0x06), REG(0xc202, 0x51),
+	REG(0xc203, 0x66),
+	DELAY(20),
+	REG(0xc100, 0x45),
+	DELAY(5),
+	REG(0xc700, 0x46), REG(0xc000, 0xa3), REG(0xc002, 0x8a),
+	DELAY(5),
+	CMD(LG35583_SLPOUT),
+	DELAY(130),
+};
+
+struct lg35583 {
+	struct drm_panel panel;
+	struct spi_device *spi;
+	struct gpio_desc *reset;
+	struct regulator *vcc;
+	struct regulator *vccio;
+};
+
+static const struct drm_display_mode lg35583_mode = {
+	.clock = 28000,
+	.hdisplay = 480,
+	.hsync_start = 480 + 24,
+	.hsync_end = 480 + 24 + 24,
+	.htotal = 480 + 24 + 24 + 24,
+	.vdisplay = 800,
+	.vsync_start = 800 + 14,
+	.vsync_end = 800 + 14 + 5,
+	.vtotal = 800 + 14 + 5 + 8,
+	.flags = DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static struct lg35583 *to_lg35583(struct drm_panel *panel)
+{
+	return container_of(panel, struct lg35583, panel);
+}
+
+static int lg35583_word(struct lg35583 *ctx, u16 word)
+{
+	/* Copied to a DMA-safe buffer. */
+	return spi_write_then_read(ctx->spi, &word, sizeof(word), NULL, 0);
+}
+
+static int lg35583_cmd(struct lg35583 *ctx, u16 reg)
+{
+	int ret;
+
+	ret = lg35583_word(ctx, LG35583_ADDR_HI | (reg >> 8));
+	if (ret)
+		return ret;
+	return lg35583_word(ctx, LG35583_ADDR_LO | (reg & 0xff));
+}
+
+static int lg35583_write(struct lg35583 *ctx, const struct lg35583_write *w)
+{
+	int ret;
+
+	if (!w->reg) {
+		msleep(w->val);
+		return 0;
+	}
+
+	ret = lg35583_cmd(ctx, w->reg);
+	if (ret || w->val < 0)
+		return ret;
+	return lg35583_word(ctx, LG35583_DATA | w->val);
+}
+
+static int lg35583_prepare(struct drm_panel *panel)
+{
+	struct lg35583 *ctx = to_lg35583(panel);
+	unsigned int i;
+	int ret;
+
+	ret = regulator_enable(ctx->vccio);
+	if (ret)
+		return ret;
+	usleep_range(5000, 6000);
+
+	ret = regulator_enable(ctx->vcc);
+	if (ret)
+		goto err_vccio;
+	usleep_range(5000, 6000);
+
+	gpiod_set_value_cansleep(ctx->reset, 0);
+	usleep_range(5000, 6000);
+	gpiod_set_value_cansleep(ctx->reset, 1);
+	msleep(50);
+	gpiod_set_value_cansleep(ctx->reset, 0);
+	msleep(30);
+
+	for (i = 0; i < ARRAY_SIZE(lg35583_init); i++) {
+		ret = lg35583_write(ctx, &lg35583_init[i]);
+		if (ret) {
+			dev_err(panel->dev, "Unable to set up the panel: %d\n", ret);
+			goto err_vcc;
+		}
+	}
+
+	return 0;
+
+err_vcc:
+	gpiod_set_value_cansleep(ctx->reset, 1);
+	regulator_disable(ctx->vcc);
+err_vccio:
+	regulator_disable(ctx->vccio);
+	return ret;
+}
+
+static int lg35583_enable(struct drm_panel *panel)
+{
+	struct lg35583 *ctx = to_lg35583(panel);
+	int ret;
+
+	ret = lg35583_cmd(ctx, LG35583_DISPON);
+	if (ret)
+		return ret;
+
+	return lg35583_cmd(ctx, LG35583_RAMWR);
+}
+
+static int lg35583_disable(struct drm_panel *panel)
+{
+	struct lg35583 *ctx = to_lg35583(panel);
+	int ret;
+
+	ret = lg35583_cmd(ctx, LG35583_DISPOFF);
+	usleep_range(5000, 6000);
+	return ret;
+}
+
+static int lg35583_unprepare(struct drm_panel *panel)
+{
+	struct lg35583 *ctx = to_lg35583(panel);
+
+	lg35583_cmd(ctx, LG35583_SLPIN);
+	usleep_range(5000, 6000);
+
+	gpiod_set_value_cansleep(ctx->reset, 1);
+	regulator_disable(ctx->vccio);
+	regulator_disable(ctx->vcc);
+	return 0;
+}
+
+static int lg35583_get_modes(struct drm_panel *panel, struct drm_connector *connector)
+{
+	/* Red and blue are swapped on the R1 without it. */
+	static const u32 bus_format = MEDIA_BUS_FMT_BGR666_1X18;
+	struct drm_display_mode *mode;
+
+	mode = drm_mode_duplicate(connector->dev, &lg35583_mode);
+	if (!mode)
+		return -ENOMEM;
+
+	drm_mode_set_name(mode);
+	drm_mode_probed_add(connector, mode);
+
+	connector->display_info.bpc = 6;
+	connector->display_info.bus_flags = DRM_BUS_FLAG_DE_HIGH |
+					    DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE;
+	drm_display_info_set_bus_formats(&connector->display_info, &bus_format, 1);
+
+	return 1;
+}
+
+static const struct drm_panel_funcs lg35583_funcs = {
+	.prepare = lg35583_prepare,
+	.enable = lg35583_enable,
+	.disable = lg35583_disable,
+	.unprepare = lg35583_unprepare,
+	.get_modes = lg35583_get_modes,
+};
+
+static int lg35583_probe(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	struct lg35583 *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct lg35583, panel, &lg35583_funcs,
+				   DRM_MODE_CONNECTOR_DPI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ctx->spi = spi;
+	spi_set_drvdata(spi, ctx);
+
+	spi->bits_per_word = 16;
+	ret = spi_setup(spi);
+	if (ret)
+		return dev_err_probe(dev, ret, "Unable to set up SPI\n");
+
+	ctx->vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(ctx->vcc))
+		return dev_err_probe(dev, PTR_ERR(ctx->vcc), "Unable to get vcc\n");
+
+	ctx->vccio = devm_regulator_get(dev, "vccio");
+	if (IS_ERR(ctx->vccio))
+		return dev_err_probe(dev, PTR_ERR(ctx->vccio), "Unable to get vccio\n");
+
+	/*
+	 * Deasserted, which keeps a panel the boot loader left on as it is, but
+	 * as an output: after a reset the pin is an input, and prepare's reset
+	 * pulse would never reach the panel.
+	 */
+	ctx->reset = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->reset))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset), "Unable to get reset\n");
+
+	ret = drm_panel_of_backlight(&ctx->panel);
+	if (ret)
+		return ret;
+
+	drm_panel_add(&ctx->panel);
+	return 0;
+}
+
+static void lg35583_remove(struct spi_device *spi)
+{
+	struct lg35583 *ctx = spi_get_drvdata(spi);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id lg35583_of_match[] = {
+	{ .compatible = "hiby,lg35583" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lg35583_of_match);
+
+static const struct spi_device_id lg35583_ids[] = {
+	{ "lg35583" },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, lg35583_ids);
+
+static struct spi_driver lg35583_driver = {
+	.probe = lg35583_probe,
+	.remove = lg35583_remove,
+	.id_table = lg35583_ids,
+	.driver = {
+		.name = "panel-hiby-lg35583",
+		.of_match_table = lg35583_of_match,
+	},
+};
+module_spi_driver(lg35583_driver);
+
+MODULE_AUTHOR("Olivier Louvignes <olivier@mgcrea.io>");
+MODULE_DESCRIPTION("HiBy R1 LG35583 panel driver");
+MODULE_LICENSE("GPL");
-- 
2.39.5

