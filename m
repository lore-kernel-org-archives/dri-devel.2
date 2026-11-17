Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B74A606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Eu2W/C+G
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DC5D10F60E;
	Tue, 17 Nov 2026 10:44:08 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F262E10F60E
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:43:59 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so20159145e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 02:43:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794912238; x=1795517038; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=YwpqfN8lJu8asLWP5aaIGvd4SFUE7wK2TlSTg22KEc8=;
 b=Eu2W/C+Gf6gk206D/m95Sh+a/p+kc/Yd4/SOstpud9v+xq4NU4uccSR+5jGL4AhETZ
 1tmkb+c+wMoTTdnAJnfbaQhXmuP2QMOl2BvtmKEjK1oWmMYkO23jW0PeRPc4JTQeTGVi
 WAVHVQdEpFWtHThe6vyack5PJ8qUI9xJ++DVgxyYCJheK8ye3o8iedyiSId9ZVtE+l9C
 nwgJnFNcWbpdqs4JGkXkbIVTwa5xNxixCgjK4Rm5MqIib4HYbotPD8TjsgLaWGjJ+gW5
 Ca9teCn8JhSD96BDobG3SgBRu0fDGVe2a2HvKggNUXANjHMiocbVpR0ObvUCoMOq6Zfq
 /kKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794912238; x=1795517038;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=YwpqfN8lJu8asLWP5aaIGvd4SFUE7wK2TlSTg22KEc8=;
 b=nCW++KmJlgnnqIqXBVFHFGmPqX15pmq/aVZxa+1UCkuYD5Vlz+xEQ7UIDxqJolYMRx
 iwXY1treo7B8ZRYGqhaNotwXQ5drN+LWgnnnpG9a45u5era8XMbXtjFEg5VIUQ0aTOBK
 EOS6yD8wZI8E/D0qGLLM8mFcuSYnZU3Yy1lNs+lgxIV2zyXXypoY8KshxUCJjsvo/KAL
 HqgiTI6AOjkGf7k1KQyD+O5XawXi82JZ2Plhzat1cLK+StMaYiz0m7+MAlU5RsHCsNj8
 M4Xr1VkTSkbwXFZrvG0uVb3lIA/InB7Cr6wrNzXbJgrrUNV3Vk+ufK0PdGvPjHj1q/hG
 QOOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE8teAvbA4f25qn0DjvKzdFLU4/sG+Gt89+UqwGg0RWIJkMjAztIaObXZ3LGBexntgbVKA4ogfXqwA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/swfmcGZ9RgR21PLE6EjXOLoaYDEJKaGOxexxl7D8ZIY24BzAS
 jTrrBdlm+nWY1tg8YpP+GRKM8+mS4g3WfgYRYteN9m6OQjikJRI3RbDFNUvv8YO2UtfWNQ==
X-Gm-Gg: AYBFou0T7G8Q9McE3DsDnnkUT4i8+mHmdreryehgUM1tgvCGgDza3rMJ5z7BigrkNkM
 cvKjYu1Wt4uXsJvVk9GADEmkX8ffmSm9xrbRUkGpTg8wQt+68iiDQJIP64xKyjeoyrQJ5ktF1x/
 quJ/Xtxoic1K2aphcXSZbuzmev02NKTSU4DSSrN9lHYJDfoD6N3VhcBUvDhAU0zpsB9ukvtTYFT
 8AOZnhO25J75lp9wmfs18BIH6Me0qtXZvW6GfgVtKACrwgHUWCe+YIGvYAD3TKIrJ4naO60lhVE
 QA0OwzhfovgYrwBWqcw0Tg07tjh42MYekDBQJzf24634CeBnORhTvPWSIkyKGBl3ZefhIJKm3r4
 mcn7B1W/AY+bVe7/VDqwntJR9/HxtY1t6WfqOjzKFCD2LYQruVts0dassm1SPKqCVEDdY2XPwVl
 oIj9qYPgVDYFJxRPQsnhXLacx098DZR9K/8bYO8VQYBW456Y36aPjK1IoFvOccKVs5CJUr9KH0f
 siBuLSCIj1AWkfVq9pm5iSyxNFqgljHhgO11aXWOqYrjtMNHeThoKLrRFUVYOPHY0+gq/wV4Igh
 geOYvYDva5CP
X-Received: by 2002:a05:600c:6099:b0:4ab:cc03:7f60 with SMTP id
 5b1f17b1804b1-4bb55a753f8mr256550145e9.18.1794912238087; 
 Tue, 17 Nov 2026 02:43:58 -0800 (PST)
Received: from dl360p ([130.61.107.245]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb783f7eecsm104578445e9.3.2026.11.17.02.43.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 02:43:57 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: neil.armstrong@linaro.org, jesszhan0024@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v2 2/2] drm/panel: novatek-nt36525: fix v1 review issues
Date: Tue, 17 Nov 2026 13:43:53 +0300
Message-ID: <20261117104353.1180634-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117104353.1180634-1-tadilhusrev@gmail.com>
References: <20261116070212.314228-1-tadilhusrev@gmail.com>
 <20261117104353.1180634-1-tadilhusrev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Addresses the issues Sashiko AI flagged on v1
(https://sashiko.dev/#/patchset/20261116070212.314228-1-tadilhusrev@gmail.com?part=2):

- Set prepare_prev_first = true before drm_panel_add(). Without it,
  drm_atomic_bridge_chain_pre_enable()/post_disable() call this panel's
  prepare()/unprepare() on the wrong side of the DSI host bridge's own
  enable/disable, which host_transfer() rejects on bridge-based hosts
  (e.g. samsung-dsim).
- Fix the reset_gpio polarity: the driver drove the physical level
  directly instead of using gpiod logical values, which inverts under
  the GPIO_ACTIVE_LOW DT flag added in the matching binding patch.
  RESX is active-low (the 1-0-1 physical pulse the vendor sequence
  describes); switch the DT flag and all gpiod_set_value_cansleep()/
  devm_gpiod_get() calls to logical values with the same physical
  outcome.
- Request the "vpos" and "vneg" regulators the driver already needed
  (matching the binding fix) so dtbs_check and probe agree.
- Use drm_connector_helper_get_modes_fixed() in nt36525_get_modes()
  instead of open-coding drm_mode_duplicate() + drm_mode_set_name() +
  manual display_info updates and returning -ENOMEM on failure (which
  drm_helper_probe_get_modes() logs as an error; the helper returns 0
  instead).
- Rename the compatible string to novatek,nt36525-xcover5, matching
  the fixed binding; the old samsung,xcover5-nt36525 never matched
  this driver's of_match_table.

Tested on a Samsung Galaxy XCover5 running 7.4-rc1 plus this driver
and the matching DTS/binding fixes: debugfs now reports the reset gpio
as ACTIVE LOW, and the DSI panel connector probes and reports
"connected".

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 drivers/gpu/drm/panel/panel-novatek-nt36525.c | 419 +++++++++++++-----
 1 file changed, 306 insertions(+), 113 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36525.c b/drivers/gpu/drm/panel/panel-novatek-nt36525.c
index d6d805791..ba3e003e6 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36525.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36525.c
@@ -1,21 +1,16 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * Novatek NT36525 MIPI DSI panel driver — Samsung Galaxy XCover5
+ * Novatek NT36525 MIPI DSI panel driver for the Samsung Galaxy XCover5
  *
- * Panel timing + DCS init stream from Samsung GPL kernel
- * (SM-G525F_EUR_14/kernel/drivers/video/fbdev/exynos/panel/nt36525/
- *  nt36525_xcover5_panel.h) — 207 packets, 220 ordered steps.
- *
- * The DCS table is included from "panel-novatek-nt36525-init.h", which
- * is generated from Samsung's header (see scripts/panel/gen-nt36525.py
- * in the project tree; the lab tree ships the generated file at
- *   drivers/gpu/drm/panel/panel-novatek-nt36525-init.h).
+ * Panel timing and the DCS initialisation sequence are taken from the
+ * Samsung GPL kernel release for the SM-G525F
+ * (drivers/video/fbdev/exynos/panel/nt36525/nt36525_xcover5_panel.h).
  */
 
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/mod_devicetable.h>
 #include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
@@ -23,27 +18,7 @@
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_panel.h>
-
-enum nt36525_cmd_type {
-	INIT_DCS,
-	INIT_DELAY,
-};
-
-struct nt36525_init_cmd {
-	enum nt36525_cmd_type type;
-	union {
-		struct { const u8 *data; size_t len; };
-		unsigned int delay_ms;
-	};
-};
-
-/* Convenience constructors so the generated table reads clean. */
-#define DCS(buf) { .type = INIT_DCS, .data = (buf), .len = ARRAY_SIZE(buf) }
-#define DLY(ms)  { .type = INIT_DELAY, .delay_ms = (ms) }
-
-/* 207 packet arrays + 220-step init table. Generated from Samsung GPL
- * header. Kept in a separate .h so this .c stays focused on logic. */
-#include "panel-novatek-nt36525-init.h"
+#include <drm/drm_probe_helper.h>
 
 struct nt36525 {
 	struct drm_panel panel;
@@ -51,7 +26,7 @@ struct nt36525 {
 	struct regulator *vdd;		/* vdd_ldo28, 1.8 V */
 	struct regulator *vpos;		/* LCD positive bias */
 	struct regulator *vneg;		/* LCD negative bias */
-	struct gpio_desc *reset_gpio;	/* panel RESX, active-high per Samsung */
+	struct gpio_desc *reset_gpio;	/* panel RESX, active-low; gpiod value 1 = asserted */
 };
 
 static inline struct nt36525 *panel_to_nt36525(struct drm_panel *p)
@@ -75,29 +50,263 @@ static const struct drm_display_mode nt36525_xcover5_mode = {
 	.type		= DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
 };
 
-static int nt36525_send(struct nt36525 *p, const struct nt36525_init_cmd *cmd)
+static int nt36525_on(struct nt36525 *p)
 {
-	ssize_t ret;
-
-	if (cmd->type == INIT_DELAY) {
-		msleep(cmd->delay_ms);
-		return 0;
-	}
-	ret = mipi_dsi_dcs_write_buffer(p->dsi, cmd->data, cmd->len);
-	if (ret < 0) {
-		dev_err(&p->dsi->dev, "DCS write failed: %zd (first byte 0x%02x)\n",
-			ret, cmd->data[0]);
-		return ret;
-	}
-	return 0;
+	struct mipi_dsi_multi_context ctx = { .dsi = p->dsi };
+
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x20);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x00, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x01, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x03, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x05, 0xa9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x73);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x08, 0xc1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0e, 0x91);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0f, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x69, 0xa9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x94, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x95, 0xeb);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x96, 0xeb);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x24);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x04, 0x21);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x06, 0x22);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x08, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0a, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0b, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0c, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0d, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0f, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x10, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x13, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x14, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x16, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1a, 0x21);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1c, 0x22);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1d, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1e, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x22, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x23, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x25, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x26, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x28, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2a, 0x1e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x2f, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x33, 0x07);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x34, 0x09);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x37, 0x33);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x39, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3a, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3b, 0x94);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3d, 0x92);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4d, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x4e, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x51, 0x43);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x52, 0x21);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x86);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x56, 0x34);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5a, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5b, 0x94);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5c, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5d, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5e, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x60, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x61, 0x72);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x64, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x82, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x83, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x85, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x86, 0x51);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x92, 0xba);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x93, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x94, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xab, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xac, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xad, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xaf, 0x04);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0xb5);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x25);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0a, 0x82);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0b, 0x50);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x0c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x17, 0x82);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x18, 0x06);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x19, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x58, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x59, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5a, 0x40);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5b, 0x80);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5d, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5e, 0x94);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x5f, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x60, 0x94);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x61, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x62, 0x94);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x65, 0x05);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x66, 0xb5);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xca, 0x1c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xcc, 0x1c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd3, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd4, 0xc8);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd5, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd6, 0x1c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xd7, 0x11);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x26);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x00, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x27);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x13, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x15, 0xb4);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1f, 0x55);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x26, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc0, 0x18);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc1, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc2, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc3, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc4, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc5, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc6, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xc7, 0x03);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x23);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x07, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x08, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x12, 0xa6);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x15, 0xfc);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x16, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x04, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x19, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1b, 0x08);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1c, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1d, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1e, 0x12);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x1f, 0x16);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x20, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x21, 0x1c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x22, 0x20);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x23, 0x24);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x24, 0x28);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x25, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x26, 0x30);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x27, 0x38);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x28, 0x3c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x29, 0x10);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x30, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x31, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x32, 0xfe);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x33, 0xfd);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x34, 0xfd);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x35, 0xfc);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x36, 0xfb);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x37, 0xf9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x38, 0xf7);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x39, 0xf3);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3a, 0xea);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3b, 0xe6);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3d, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x3f, 0xdd);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x40, 0xdb);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x41, 0xd9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x20);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00, 0x08, 0x00, 0x18, 0x00, 0x34, 0x00, 0x4c,
+				     0x00, 0x61, 0x00, 0x74, 0x00, 0x86, 0x00, 0x96);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x00, 0xa5, 0x00, 0xdb, 0x01, 0x02, 0x01, 0x43,
+				     0x01, 0x71, 0x01, 0xbd, 0x01, 0xf7, 0x01, 0xfa);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb2, 0x02, 0x34, 0x02, 0x6f, 0x02, 0x98, 0x02, 0xcc,
+				     0x02, 0xf1, 0x03, 0x1d, 0x03, 0x2d, 0x03, 0x3b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb3, 0x03, 0x4d, 0x03, 0x60, 0x03, 0x7a, 0x03, 0x94,
+				     0x03, 0xa6, 0x03, 0xa7);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x00, 0x08, 0x00, 0x18, 0x00, 0x34, 0x00, 0x4c,
+				     0x00, 0x61, 0x00, 0x74, 0x00, 0x86, 0x00, 0x96);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5, 0x00, 0xa5, 0x00, 0xdb, 0x01, 0x02, 0x01, 0x43,
+				     0x01, 0x71, 0x01, 0xbd, 0x01, 0xf7, 0x01, 0xfa);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x02, 0x34, 0x02, 0x6f, 0x02, 0x98, 0x02, 0xcc,
+				     0x02, 0xf1, 0x03, 0x1d, 0x03, 0x2d, 0x03, 0x3b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb7, 0x03, 0x4d, 0x03, 0x60, 0x03, 0x7a, 0x03, 0x94,
+				     0x03, 0xa6, 0x03, 0xa7);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb8, 0x00, 0x08, 0x00, 0x18, 0x00, 0x34, 0x00, 0x4c,
+				     0x00, 0x61, 0x00, 0x74, 0x00, 0x86, 0x00, 0x96);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9, 0x00, 0xa5, 0x00, 0xdb, 0x01, 0x02, 0x01, 0x43,
+				     0x01, 0x71, 0x01, 0xbd, 0x01, 0xf7, 0x01, 0xfa);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x02, 0x34, 0x02, 0x6f, 0x02, 0x98, 0x02, 0xcc,
+				     0x02, 0xf1, 0x03, 0x1d, 0x03, 0x2d, 0x03, 0x3b);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbb, 0x03, 0x4d, 0x03, 0x60, 0x03, 0x7a, 0x03, 0x94,
+				     0x03, 0xa6, 0x03, 0xa7);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x21);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb0, 0x00, 0x00, 0x00, 0x10, 0x00, 0x2c, 0x00, 0x44,
+				     0x00, 0x59, 0x00, 0x6c, 0x00, 0x7e, 0x00, 0x8e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb1, 0x00, 0x9d, 0x00, 0xd3, 0x00, 0xfa, 0x01, 0x3b,
+				     0x01, 0x69, 0x01, 0xb5, 0x01, 0xef, 0x01, 0xf2);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb2, 0x02, 0x2c, 0x02, 0x79, 0x02, 0xaa, 0x02, 0xe6,
+				     0x03, 0x0f, 0x03, 0x3f, 0x03, 0x4f, 0x03, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb3, 0x03, 0x71, 0x03, 0x86, 0x03, 0xa0, 0x03, 0xbc,
+				     0x03, 0xce, 0x03, 0xd9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb4, 0x00, 0x00, 0x00, 0x10, 0x00, 0x2c, 0x00, 0x44,
+				     0x00, 0x59, 0x00, 0x6c, 0x00, 0x7e, 0x00, 0x8e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb5, 0x00, 0x9d, 0x00, 0xd3, 0x00, 0xfa, 0x01, 0x3b,
+				     0x01, 0x69, 0x01, 0xb5, 0x01, 0xef, 0x01, 0xf2);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb6, 0x02, 0x2c, 0x02, 0x79, 0x02, 0xaa, 0x02, 0xe6,
+				     0x03, 0x0f, 0x03, 0x3f, 0x03, 0x4f, 0x03, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb7, 0x03, 0x71, 0x03, 0x86, 0x03, 0xa0, 0x03, 0xbc,
+				     0x03, 0xce, 0x03, 0xd9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb8, 0x00, 0x00, 0x00, 0x10, 0x00, 0x2c, 0x00, 0x44,
+				     0x00, 0x59, 0x00, 0x6c, 0x00, 0x7e, 0x00, 0x8e);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xb9, 0x00, 0x9d, 0x00, 0xd3, 0x00, 0xfa, 0x01, 0x3b,
+				     0x01, 0x69, 0x01, 0xb5, 0x01, 0xef, 0x01, 0xf2);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x02, 0x2c, 0x02, 0x79, 0x02, 0xaa, 0x02, 0xe6,
+				     0x03, 0x0f, 0x03, 0x3f, 0x03, 0x4f, 0x03, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xbb, 0x03, 0x71, 0x03, 0x86, 0x03, 0xa0, 0x03, 0xbc,
+				     0x03, 0xce, 0x03, 0xd9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0xd0);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x25, 0xa9);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xff, 0x10);
+	mipi_dsi_msleep(&ctx, 1);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xfb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0xba, 0x02);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x55, 0x01);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x53, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x51, 0x0f, 0xff);
+	mipi_dsi_dcs_write_seq_multi(&ctx, 0x68, 0x00, 0x01);
+	mipi_dsi_dcs_exit_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 100);
+	mipi_dsi_dcs_set_display_on_multi(&ctx);
+
+	return ctx.accum_err;
 }
 
 static int nt36525_prepare(struct drm_panel *panel)
 {
 	struct nt36525 *p = panel_to_nt36525(panel);
-	int ret, i;
+	int ret;
 
-	dev_info(&p->dsi->dev, "MODESET panel: prepare enter (power+reset+207 DCS)\n");
 	/* Power-up sequence from Samsung decon_board_nt36525 panel_power_enable */
 	ret = regulator_enable(p->vdd);
 	if (ret)
@@ -112,35 +321,27 @@ static int nt36525_prepare(struct drm_panel *panel)
 		goto disable_vpos;
 	usleep_range(1000, 1500);
 
-	/* Reset pulse — Samsung sequence from panel_reset */
+	/*
+	 * Reset pulse, Samsung sequence from panel_reset. Logical values are
+	 * inverted from the physical levels the vendor sequence describes
+	 * (RESX is active-low): deassert, assert, deassert.
+	 */
 	usleep_range(10000, 11000);
-	gpiod_set_value_cansleep(p->reset_gpio, 1);
-	usleep_range(1000, 1500);
 	gpiod_set_value_cansleep(p->reset_gpio, 0);
-	usleep_range(3500, 4000);
+	usleep_range(1000, 1500);
 	gpiod_set_value_cansleep(p->reset_gpio, 1);
+	usleep_range(3500, 4000);
+	gpiod_set_value_cansleep(p->reset_gpio, 0);
 	usleep_range(10000, 11000);
 
-	dev_info(&p->dsi->dev, "MODESET panel: power/reset done, sending %u DCS cmds (LPM)\n",
-		 (unsigned)ARRAY_SIZE(nt36525_init_cmds));
-	/* Replay DCS init stream (207 packets + delays) */
-	for (i = 0; i < ARRAY_SIZE(nt36525_init_cmds); i++) {
-		ret = nt36525_send(p, &nt36525_init_cmds[i]);
-		if (ret) {
-			dev_err(&p->dsi->dev,
-				"MODESET panel: DCS stream failed at step %d (ret=%d)\n",
-				i, ret);
-			goto fail;
-		}
-	}
-	dev_info(&p->dsi->dev, "MODESET panel: init stream OK (%zu steps)\n",
-		 ARRAY_SIZE(nt36525_init_cmds));
-	dev_info(&p->dsi->dev, "MODESET panel: all DCS sent, prepare COMPLETE\n");
+	ret = nt36525_on(p);
+	if (ret)
+		goto fail;
+
 	return 0;
 
 fail:
-	dev_err(&p->dsi->dev, "MODESET panel: DCS #%d FAILED (ret=%d)\n", i, ret);
-	gpiod_set_value_cansleep(p->reset_gpio, 0);
+	gpiod_set_value_cansleep(p->reset_gpio, 1);
 	regulator_disable(p->vneg);
 	usleep_range(1000, 1500);
 disable_vpos:
@@ -154,13 +355,12 @@ static int nt36525_prepare(struct drm_panel *panel)
 static int nt36525_unprepare(struct drm_panel *panel)
 {
 	struct nt36525 *p = panel_to_nt36525(panel);
-	static const u8 cmd_display_off[] = { MIPI_DCS_SET_DISPLAY_OFF };
-	static const u8 cmd_sleep_in[]    = { MIPI_DCS_ENTER_SLEEP_MODE };
+	struct mipi_dsi_multi_context ctx = { .dsi = p->dsi };
 
-	mipi_dsi_dcs_write_buffer(p->dsi, cmd_display_off, sizeof(cmd_display_off));
-	msleep(20);
-	mipi_dsi_dcs_write_buffer(p->dsi, cmd_sleep_in, sizeof(cmd_sleep_in));
-	msleep(60);
+	mipi_dsi_dcs_set_display_off_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 20);
+	mipi_dsi_dcs_enter_sleep_mode_multi(&ctx);
+	mipi_dsi_msleep(&ctx, 60);
 
 	usleep_range(3000, 3500);
 	regulator_disable(p->vneg);
@@ -169,30 +369,18 @@ static int nt36525_unprepare(struct drm_panel *panel)
 	usleep_range(5000, 5500);
 	regulator_disable(p->vdd);
 	msleep(30);
-	gpiod_set_value_cansleep(p->reset_gpio, 0);
+	gpiod_set_value_cansleep(p->reset_gpio, 1);
 	return 0;
 }
 
-static int nt36525_enable(struct drm_panel *panel) { return 0; }
-static int nt36525_disable(struct drm_panel *panel) { return 0; }
-
 static int nt36525_get_modes(struct drm_panel *panel, struct drm_connector *conn)
 {
-	struct drm_display_mode *m = drm_mode_duplicate(conn->dev,
-						        &nt36525_xcover5_mode);
-	if (!m) return -ENOMEM;
-	drm_mode_set_name(m);
-	drm_mode_probed_add(conn, m);
-	conn->display_info.width_mm = m->width_mm;
-	conn->display_info.height_mm = m->height_mm;
-	return 1;
+	return drm_connector_helper_get_modes_fixed(conn, &nt36525_xcover5_mode);
 }
 
 static const struct drm_panel_funcs nt36525_funcs = {
 	.prepare	= nt36525_prepare,
 	.unprepare	= nt36525_unprepare,
-	.enable		= nt36525_enable,
-	.disable	= nt36525_disable,
 	.get_modes	= nt36525_get_modes,
 };
 
@@ -202,7 +390,6 @@ static int nt36525_probe(struct mipi_dsi_device *dsi)
 	struct nt36525 *p;
 	int ret;
 
-	dev_info(dev, "NT36525: probe entry\n");
 	p = devm_drm_panel_alloc(dev, struct nt36525, panel, &nt36525_funcs,
 				 DRM_MODE_CONNECTOR_DSI);
 	if (IS_ERR(p))
@@ -226,46 +413,52 @@ static int nt36525_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(p->vneg), "vneg supply\n");
 
 	/*
-	 * Request RESX released (high) rather than asserting it here.  At probe the
-	 * TDDI may still be running the image the bootloader (or a kernel that
-	 * kexec'd into this one) left on screen; asserting RESX mid-stream made the
-	 * touch half of the chip raise its interrupt before any driver had mapped it.
-	 * The real fix for that livelock is in pinctrl-exynos (inherited EINTs are
-	 * masked at init); this only avoids resetting a live panel needlessly.
-	 * prepare() still performs the full 1-0-1 reset pulse, and vdd_ldo28 is
-	 * always-on, so driving RESX high never drives an unpowered chip.
+	 * Request RESX deasserted (logical 0, active-low) rather than asserting it
+	 * here. At probe the TDDI may still be running the image the bootloader (or
+	 * a kernel that kexec'd into this one) left on screen; asserting RESX
+	 * mid-stream made the touch half of the chip raise its interrupt before any
+	 * driver had mapped it. The real fix for that livelock is in pinctrl-exynos
+	 * (inherited EINTs are masked at init); this only avoids resetting a live
+	 * panel needlessly. prepare() still performs the full deassert-assert-
+	 * deassert reset pulse, and vdd_ldo28 is always-on, so leaving RESX
+	 * deasserted here never drives an unpowered chip.
 	 */
-	p->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	p->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
 	if (IS_ERR(p->reset_gpio))
 		return dev_err_probe(dev, PTR_ERR(p->reset_gpio), "reset gpio\n");
 
 	/* MIPI DSI config from Samsung panel node: 3-lane, video mode, RGB888 */
 	dsi->lanes	 = 3;
 	dsi->format	 = MIPI_DSI_FMT_RGB888;
+	/*
+	 * MIPI_DSI_MODE_LPM is load-bearing: .prepare sends the DCS init sequence
+	 * before the DSIM video stream is running. Without LPM those writes go out
+	 * in HS, which blocks waiting for a stream that does not exist yet, so
+	 * .prepare never returns and the modeset hangs. In LP mode the init goes
+	 * over the low-power escape clock, independent of the video stream.
+	 */
 	dsi->mode_flags	 = MIPI_DSI_MODE_VIDEO		/* video (non-burst) */
 			 | MIPI_DSI_MODE_VIDEO_SYNC_PULSE
 			 | MIPI_DSI_MODE_LPM		/* force LP for all transfers */
 			 | MIPI_DSI_CLOCK_NON_CONTINUOUS;
+
 	/*
-	 * MIPI_DSI_MODE_LPM is load-bearing: .prepare sends the 207-packet DCS init
-	 * BEFORE the DSIM video stream is running. Without LPM those DCS writes go out
-	 * in HS, which blocks waiting for a stream that doesn't exist yet -> .prepare
-	 * never returns -> the fbdev modeset commit (and the whole boot) hangs. In LP
-	 * mode the init goes over the low-power escape clock, independent of the video
-	 * stream, so it completes and the stream starts cleanly afterwards.
-	 * ponytail: `display_mode[7]=0x12` in Samsung dts hints MIPI_DSI_MODE_VIDEO_HSE;
-	 * add only if tearing shows up — simplest common config first. */
-
-	dev_info(dev, "NT36525: regulator+gpio ok, drm_panel_add + mipi_dsi_attach...\n");
+	 * This panel's DCS init sequence runs in .prepare(), before the DSI host
+	 * bridge's own atomic_pre_enable(). On bridge-based hosts (e.g.
+	 * samsung-dsim) that ordering matters: without this, host_transfer()
+	 * rejects the LP writes because the host bridge isn't enabled yet.
+	 */
+	p->panel.prepare_prev_first = true;
+
 	drm_panel_add(&p->panel);
 
 	mipi_dsi_set_drvdata(dsi, p);
 	ret = mipi_dsi_attach(dsi);
 	if (ret) {
 		drm_panel_remove(&p->panel);
-		return ret;
+		return dev_err_probe(dev, ret, "failed to attach to DSI host\n");
 	}
-	dev_info(dev, "NT36525: probe COMPLETE\n");
+
 	return 0;
 }
 
@@ -294,5 +487,5 @@ static struct mipi_dsi_driver nt36525_driver = {
 module_mipi_dsi_driver(nt36525_driver);
 
 MODULE_DESCRIPTION("Novatek NT36525 panel driver for Samsung Galaxy XCover5");
-MODULE_AUTHOR("Adil Hüsrev Tepe");
-MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Adil Hüsrev Tepe <tadilhusrev@gmail.com>");
+MODULE_LICENSE("GPL");
-- 
2.53.0

