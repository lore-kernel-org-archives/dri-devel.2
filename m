Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71D2BCA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:22:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C645710EB17;
	Mon, 28 Sep 2026 16:22:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mxQomtFQ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD9E110EB1B
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 16:22:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2B64444E7;
 Mon, 28 Sep 2026 16:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23F01F0089B;
 Mon, 28 Sep 2026 16:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790612550;
 bh=VP5IhzUlPxzFJwkYVvuQ8CT3t9rGSF8B7tbh7+IcBQo=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=mxQomtFQOwHyp8GaXlX96reKoFni9WOvkNPFVu1OU4B34F+KZhwjdhUJDwe/vaWG/
 8ESemJ0lgI1f3cXufWfW/gxru/OTihIFTeKgzBVneP4LpKFLKHslm6ByQIfoi95mHI
 fRVPOOWFPxI19ivOMY0oMUU7QBErSgp/7JWGoghYN7WN7g+1S7UtYOsoy+O0iKuNFU
 sKAtDpwziyWRJvsPci8+q9Wg14ZIkPwWaovbwWcym6kCZ0QWk5HyNHoPLBey+/VQZI
 OKeQ1hyFHl0d8ZhHn6LmUblOVDzZE1Coijj7E8t0VDpyUnPoWX/AA88TBpyzKnIjVK
 Pqlvg1OmAjjlQ==
From: Maxime Ripard <mripard@kernel.org>
Date: Mon, 28 Sep 2026 18:22:04 +0200
Subject: [PATCH 4/6] drm/panel: dsi-bpf: Add Raspberry Pi 7-inch panel BPF
 program
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-drm-mipi-dsi-panel-ebpf-v1-4-5244926aace4@kernel.org>
References: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
In-Reply-To: <20260928-drm-mipi-dsi-panel-ebpf-v1-0-5244926aace4@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Albert Esteve <aesteve@redhat.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
 Maxime Ripard <mripard@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6530; i=mripard@kernel.org;
 h=from:subject:message-id; bh=89k9KSU3yiMbMLTJ99z/iNKamETD7Q7S+e0/Ah/AIiY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFm7phgt5/v762E8o1DP13PX7de7zHX5nRtx4Mrug4/nd
 0o4PDBY3jGVhUGYk0FWTJHliUzY6eXti6sc7Ff+gJnDygQyhIGLUwAmsreZsd7LRi5+s4jPn3TD
 9knbrLnmHjuq4nxk4z7tTfEPH+f1/Nt2r/dzvI3Mz+XzrF45e+43Ps3Y8IPxWTunwd3LM/V1Qs9
 9Fr2i4B9szmq46fjd+9sn2/78cGBy0J8KI7V9d8oudElJvf0cCQA=
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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

Translate the raspberrypi,dsi-7inch initialization sequence from
drivers/gpu/drm/panel/panel-ilitek-ili9881c.c into a BPF program.

Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 .../panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c   | 266 +++++++++++++++++++++
 1 file changed, 266 insertions(+)

diff --git a/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c b/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c
new file mode 100644
index 000000000000..1f9ff7f2fd3c
--- /dev/null
+++ b/drivers/gpu/drm/panel/bpf/progs/Raspberrypi__dsi-5inch.bpf.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * BPF panel program for Raspberry Pi 5-inch MIPI-DSI panel (ILI9881C)
+ *
+ * Translated from drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+ * (rpi_5inch_init[] / rpi_5inch_desc)
+ */
+
+#include "vmlinux.h"
+#include "panel-bpf-mipi-dsi.h"
+#include <bpf/bpf_tracing.h>
+
+#define PAGE(p) do {						\
+	const __u8 _d[] = { 0x98, 0x81, (p) };			\
+	panel_bpf_mipi_dsi_dcs_write(pctx, 0xff, _d, sizeof(_d));\
+} while (0)
+
+#define CMD(c, d) panel_bpf_mipi_dsi_dcs_write_byte(pctx, (c), (d))
+
+SEC(PANEL_BPF_MIPI_DSI_PREPARE)
+int BPF_PROG(panel_prepare, struct panel_bpf_mipi_dsi_ctx *pctx)
+{
+	int ret;
+
+	ret = panel_bpf_mipi_dsi_regulator_enable_and_wait(pctx, PANEL_BPF_MIPI_DSI_SUPPLY_IOVCC, 5);
+	if (ret)
+		return ret;
+
+	ret = panel_bpf_mipi_dsi_regulator_enable_and_wait(pctx, PANEL_BPF_MIPI_DSI_SUPPLY_VCC, 5);
+	if (ret)
+		return ret;
+
+	panel_bpf_mipi_dsi_gpio_cycle_and_wait(pctx, PANEL_BPF_MIPI_DSI_GPIO_RESET, 20, 20);
+
+	/* Page 3 */
+	PAGE(3);
+	CMD(0x01, 0x00);
+	CMD(0x02, 0x00);
+	CMD(0x03, 0x73);
+	CMD(0x04, 0x73);
+	CMD(0x05, 0x00);
+	CMD(0x06, 0x06);
+	CMD(0x07, 0x02);
+	CMD(0x08, 0x00);
+	CMD(0x09, 0x01);
+	CMD(0x0a, 0x01);
+	CMD(0x0b, 0x01);
+	CMD(0x0c, 0x01);
+	CMD(0x0d, 0x01);
+	CMD(0x0e, 0x01);
+	CMD(0x0f, 0x01);
+	CMD(0x10, 0x01);
+	CMD(0x11, 0x00);
+	CMD(0x12, 0x00);
+	CMD(0x13, 0x01);
+	CMD(0x14, 0x00);
+	CMD(0x15, 0x00);
+	CMD(0x16, 0x00);
+	CMD(0x17, 0x00);
+	CMD(0x18, 0x00);
+	CMD(0x19, 0x00);
+	CMD(0x1a, 0x00);
+	CMD(0x1b, 0x00);
+	CMD(0x1c, 0x00);
+	CMD(0x1d, 0x00);
+	CMD(0x1e, 0xc0);
+	CMD(0x1f, 0x80);
+	CMD(0x20, 0x04);
+	CMD(0x21, 0x03);
+	CMD(0x22, 0x00);
+	CMD(0x23, 0x00);
+	CMD(0x24, 0x00);
+	CMD(0x25, 0x00);
+	CMD(0x26, 0x00);
+	CMD(0x27, 0x00);
+	CMD(0x28, 0x33);
+	CMD(0x29, 0x03);
+	CMD(0x2a, 0x00);
+	CMD(0x2b, 0x00);
+	CMD(0x2c, 0x00);
+	CMD(0x2d, 0x00);
+	CMD(0x2e, 0x00);
+	CMD(0x2f, 0x00);
+	CMD(0x30, 0x00);
+	CMD(0x31, 0x00);
+	CMD(0x32, 0x00);
+	CMD(0x33, 0x00);
+	CMD(0x34, 0x03);
+	CMD(0x35, 0x00);
+	CMD(0x36, 0x03);
+	CMD(0x37, 0x00);
+	CMD(0x38, 0x00);
+	CMD(0x39, 0x00);
+	CMD(0x3a, 0x00);
+	CMD(0x3b, 0x00);
+	CMD(0x3c, 0x00);
+	CMD(0x3d, 0x00);
+	CMD(0x3e, 0x00);
+	CMD(0x3f, 0x00);
+	CMD(0x40, 0x00);
+	CMD(0x41, 0x00);
+	CMD(0x42, 0x00);
+	CMD(0x43, 0x00);
+	CMD(0x44, 0x00);
+	CMD(0x50, 0x01);
+	CMD(0x51, 0x23);
+	CMD(0x52, 0x45);
+	CMD(0x53, 0x67);
+	CMD(0x54, 0x89);
+	CMD(0x55, 0xab);
+	CMD(0x56, 0x01);
+	CMD(0x57, 0x23);
+	CMD(0x58, 0x45);
+	CMD(0x59, 0x67);
+	CMD(0x5a, 0x89);
+	CMD(0x5b, 0xab);
+	CMD(0x5c, 0xcd);
+	CMD(0x5d, 0xef);
+	CMD(0x5e, 0x10);
+	CMD(0x5f, 0x09);
+	CMD(0x60, 0x08);
+	CMD(0x61, 0x0f);
+	CMD(0x62, 0x0e);
+	CMD(0x63, 0x0d);
+	CMD(0x64, 0x0c);
+	CMD(0x65, 0x02);
+	CMD(0x66, 0x02);
+	CMD(0x67, 0x02);
+	CMD(0x68, 0x02);
+	CMD(0x69, 0x02);
+	CMD(0x6a, 0x02);
+	CMD(0x6b, 0x02);
+	CMD(0x6c, 0x02);
+	CMD(0x6d, 0x02);
+	CMD(0x6e, 0x02);
+	CMD(0x6f, 0x02);
+	CMD(0x70, 0x02);
+	CMD(0x71, 0x06);
+	CMD(0x72, 0x07);
+	CMD(0x73, 0x02);
+	CMD(0x74, 0x02);
+	CMD(0x75, 0x06);
+	CMD(0x76, 0x07);
+	CMD(0x77, 0x0e);
+	CMD(0x78, 0x0f);
+	CMD(0x79, 0x0c);
+	CMD(0x7a, 0x0d);
+	CMD(0x7b, 0x02);
+	CMD(0x7c, 0x02);
+	CMD(0x7d, 0x02);
+	CMD(0x7e, 0x02);
+	CMD(0x7f, 0x02);
+	CMD(0x80, 0x02);
+	CMD(0x81, 0x02);
+	CMD(0x82, 0x02);
+	CMD(0x83, 0x02);
+	CMD(0x84, 0x02);
+	CMD(0x85, 0x02);
+	CMD(0x86, 0x02);
+	CMD(0x87, 0x09);
+	CMD(0x88, 0x08);
+	CMD(0x89, 0x02);
+	CMD(0x8a, 0x02);
+
+	/* Page 4 */
+	PAGE(4);
+	CMD(0x6c, 0x15);
+	CMD(0x6e, 0x2a);
+	CMD(0x6f, 0x57);
+	CMD(0x3a, 0xa4);
+	CMD(0x8d, 0x1a);
+	CMD(0x87, 0xba);
+	CMD(0x26, 0x76);
+	CMD(0xb2, 0xd1);
+
+	/* Page 1 */
+	PAGE(1);
+	CMD(0x22, 0x0a);
+	CMD(0x31, 0x00);
+	CMD(0x53, 0x35);
+	CMD(0x55, 0x50);
+	CMD(0x50, 0xaf);
+	CMD(0x51, 0xaf);
+	CMD(0x60, 0x14);
+	CMD(0xa0, 0x08);
+	CMD(0xa1, 0x1d);
+	CMD(0xa2, 0x2c);
+	CMD(0xa3, 0x14);
+	CMD(0xa4, 0x19);
+	CMD(0xa5, 0x2e);
+	CMD(0xa6, 0x22);
+	CMD(0xa7, 0x23);
+	CMD(0xa8, 0x97);
+	CMD(0xa9, 0x1e);
+	CMD(0xaa, 0x29);
+	CMD(0xab, 0x7b);
+	CMD(0xac, 0x18);
+	CMD(0xad, 0x17);
+	CMD(0xae, 0x4b);
+	CMD(0xaf, 0x1f);
+	CMD(0xb0, 0x27);
+	CMD(0xb1, 0x52);
+	CMD(0xb2, 0x63);
+	CMD(0xb3, 0x39);
+	CMD(0xc0, 0x08);
+	CMD(0xc1, 0x1d);
+	CMD(0xc2, 0x2c);
+	CMD(0xc3, 0x14);
+	CMD(0xc4, 0x19);
+	CMD(0xc5, 0x2e);
+	CMD(0xc6, 0x22);
+	CMD(0xc7, 0x23);
+	CMD(0xc8, 0x97);
+	CMD(0xc9, 0x1e);
+	CMD(0xca, 0x29);
+	CMD(0xcb, 0x7b);
+	CMD(0xcc, 0x18);
+	CMD(0xcd, 0x17);
+	CMD(0xce, 0x4b);
+	CMD(0xcf, 0x1f);
+	CMD(0xd0, 0x27);
+	CMD(0xd1, 0x52);
+	CMD(0xd2, 0x63);
+	CMD(0xd3, 0x39);
+
+	/* Switch to page 0 and finalize */
+	PAGE(0);
+
+	/* set_tear_on with VBLANK mode (0x00) */
+	CMD(0x35, 0x00);
+
+	ret = panel_bpf_mipi_dsi_exit_sleep_mode(pctx);
+	if (ret)
+		return ret;
+
+	ret = panel_bpf_mipi_dsi_set_display_on(pctx);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+SEC(PANEL_BPF_MIPI_DSI_UNPREPARE)
+int BPF_PROG(panel_unprepare, struct panel_bpf_mipi_dsi_ctx *pctx)
+{
+	panel_bpf_mipi_dsi_set_display_off(pctx);
+	panel_bpf_mipi_dsi_enter_sleep_mode(pctx);
+
+	panel_bpf_mipi_dsi_regulator_disable(pctx, PANEL_BPF_MIPI_DSI_SUPPLY_VCC);
+	panel_bpf_mipi_dsi_regulator_disable(pctx, PANEL_BPF_MIPI_DSI_SUPPLY_IOVCC);
+	panel_bpf_mipi_dsi_gpio_enable(pctx, PANEL_BPF_MIPI_DSI_GPIO_RESET);
+
+	return 0;
+}
+
+PANEL_BPF_MIPI_DSI_OPS(raspberrypi_dsi_5inch) = {
+	.panel_id		= "/soc/dsi@7e700000/panel@0",
+	.compatible		= "raspberrypi,dsi-5inch",
+	.format			= MIPI_DSI_FMT_RGB888,
+	.lanes			= 2,
+	.mode_flags		= MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM,
+	.panel_prepare		= (void *)panel_prepare,
+	.panel_unprepare	= (void *)panel_unprepare,
+};
+
+char _license[] SEC("license") = "GPL";

-- 
2.55.0

