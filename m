Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91863606A323
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 08:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gOXOV6fX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC53A112A12;
	Fri, 23 Oct 2026 08:21:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A62F7112A12
 for <dri-devel@lists.freedesktop.org>; Fri, 23 Oct 2026 08:21:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16A1660A8A;
 Fri, 23 Oct 2026 08:21:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1792743682;
 b=Iq96Cq8NRzXYfh2GxHAqYj3K4Ne7/El3Hku7jcUkon0ZaHE7fI9D07wb2/wmXILdTuIT
 iTMVPQbzEl4DvEraMSK/KB6xdiN+i09UB5wdeiELlnAo/VYa5SIxD54rDoRKaFLsvH/pm
 N4gU44Co2hfE2J7HNPfVpNu/kZBTyRnmiQkCyiqW17ntOY3Cld7m6IsH/ui6Tj4zaZ+po
 JB/ZswxerZ6F3u6HtNMDXUMVMTieOAO6mzQKQPR2y1FeFytyVM3NrZ68dgZUhZvqhuweQ
 Sjnheb8EEuNmvvr6aCAxD59Cn4GNFMVT0ChxUk+pm6jwnFMQ9LQQEW45SYVp6ZCv95A==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1792743682;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To:Content-Transfer-Encoding;
 bh=Zud1xG1OtpJkAsHzNUeJ8tLSQi2672z5e1FNMGJkov8=;
 b=QRSDLYME5M4fI0kMCFZs0vO5LN+FGMBP7CmEiOpzVADRuqhqxTpeax+kqSZ8O8bk49+k
 yQaYun0kCwbvuoFcdXXNYDOG0IoTug7CKbF9ixRgXFzNNibintb0iNv6Q/pJf/1hJdLQP
 TAVkdXY7sJY+9tldD72i1fRlidHrz02qrCuZHOHxENrIoCXfm9EquxzylXdIHq2e7D5K7
 xAuCyiwhEhW/OpsqmKbZqwkd1LCBNJXhrnydzxIZBUg9Hu934oS/4a65PfnZq1Ptc7FOg
 IVxqXsZmO+Rwcuci/NszyHQ+rZXCUzxNw43swZwu8e4sJDqdcsb+uF94UNKnMerL0Qw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 44C6D1F031E0;
 Fri, 23 Oct 2026 08:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792743682;
 bh=Zud1xG1OtpJkAsHzNUeJ8tLSQi2672z5e1FNMGJkov8=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=gOXOV6fXKasCvuIv6lf/IUX1siDrco8yV49Q+qB5n7t5+ZyFlgeBYb9m0oq12ht2f
 SVmD0EUml0n3U1EJqPLoUCVRtpxZI7LV5IGM2ZJw4DNEycIcHNnFNhetcEEtvdx+Yq
 m+4M3/WFazaEhfQ7BP62jhxJ8EDCTAFyggRI+ZYQuU/nh9iyjbnog5JiXSJf8BNEhu
 BDx+CKiUZI4VU/ES9/LqNncxS+2HwHI+kdt+rGCXw4aH/H9occckf99EYFwnl5p1RN
 rsT3uRQx8CPG/xerii3VArKCyKYlhiU7Rt977FgQsJYdRB5Cfmk7G46hjrvdnkoWV5
 hlQTJPJvYuOaA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id CA6B344427;
 Fri, 23 Oct 2026 08:21:20 +0000 (UTC)
From: Ishu Brar via B4 Relay <devnull+patches.brar.si@kernel.org>
Date: Fri, 23 Oct 2026 13:51:17 +0530
Subject: [PATCH 2/2] drm/panel: Add Samsung AMS644VK04 panel driver
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261023-panel-ams644vk04-v1-2-56096aecd0ff@brar.si>
References: <20261023-panel-ams644vk04-v1-0-56096aecd0ff@brar.si>
In-Reply-To: <20261023-panel-ams644vk04-v1-0-56096aecd0ff@brar.si>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ishu Brar <patches@brar.si>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792743679; l=16340;
 i=patches@brar.si; h=from:subject:message-id;
 bh=qfcpODlADwF5aBKuH0qsXsVq8GHCNtDooMSQs8wT4F4=;
 b=Hh3qQGa7veRbgRhwvLjpatBjmHZ9EsLz6QxuVZJLUOB6lEypgis5LvJErFBxom7yzQGOTg0SY
 6uc8Bn4upInBzCGlDADuQz8D4zvMbrbuFP8jBnAty8SmyQnsplZI9dP
X-Developer-Key: i=patches@brar.si; a=ed25519;
 pk=Ds+E23E3ntzjPzuBDyVRkOouclcNI5k75R+N42yJtCk=
X-Endpoint-Received: by B4 Relay for patches@brar.si/default with auth_id=1189
X-Original-From: Ishu Brar <patches@brar.si>
Content-Transfer-Encoding: 7bit
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
Reply-To: patches@brar.si
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ishu Brar <patches@brar.si>

Add a driver for the Samsung AMS644VK04, a 1080x2400 DSI command mode
AMOLED panel with DSC found in the OnePlus Nord (SM7250). It uses four
lanes and DSC 1.1 at 8 bits per pixel.

The initialisation sequence and the DSC picture parameter set come from
the downstream driver. The PPS is sent as a fixed DCS 0x9e command
because it differs from what drm_dsc_pps_payload_pack() computes for the
same geometry: the downstream first_line_bpg_offset is 15 while the
helper gives 12, which also changes a few derived values and the last
rate control ranges. Only the 90 Hz mode is described for now.

Tested on a OnePlus Nord with the msm DSI host, including suspend and
resume.

Assisted-by: Claude
Signed-off-by: Ishu Brar <patches@brar.si>
---
 MAINTAINERS                                      |   1 +
 drivers/gpu/drm/panel/Kconfig                    |  15 +
 drivers/gpu/drm/panel/Makefile                   |   1 +
 drivers/gpu/drm/panel/panel-samsung-ams644vk04.c | 373 +++++++++++++++++++++++
 4 files changed, 390 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1eec53b0e..0cdb25220 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8467,6 +8467,7 @@ M:	Ishu Brar <patches@brar.si>
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/panel/samsung,ams644vk04.yaml
+F:	drivers/gpu/drm/panel/panel-samsung-ams644vk04.c
 
 DRM DRIVER FOR SAMSUNG DB7430 PANELS
 M:	Linus Walleij <linusw@kernel.org>
diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7a520b4d6..b3c1c4f4b 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -956,6 +956,21 @@ config DRM_PANEL_SAMSUNG_AMS639RQ08
 	  Say Y or M here if you want to enable support for the
 	  Samsung AMS639RQ08 FHD Plus (2340x1080@60Hz) CMD mode panel.
 
+config DRM_PANEL_SAMSUNG_AMS644VK04
+	tristate "Samsung AMS644VK04 panel"
+	depends on OF
+	depends on DRM_MIPI_DSI
+	depends on BACKLIGHT_CLASS_DEVICE
+	depends on GPIOLIB
+	depends on REGULATOR
+	help
+	  Say Y or M here if you want to enable support for the
+	  Samsung AMS644VK04 FHD Plus (1080x2400) DSC command mode AMOLED
+	  panel, found in the OnePlus Nord.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called panel-samsung-ams644vk04.
+
 config DRM_PANEL_SAMSUNG_S6E88A0_AMS427AP24
 	tristate "Samsung AMS427AP24 panel with S6E88A0 controller"
 	depends on GPIOLIB && OF && REGULATOR
diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makefile
index da5175909..01c1ca740 100644
--- a/drivers/gpu/drm/panel/Makefile
+++ b/drivers/gpu/drm/panel/Makefile
@@ -92,6 +92,7 @@ obj-$(CONFIG_DRM_PANEL_RENESAS_R69328) += panel-renesas-r69328.o
 obj-$(CONFIG_DRM_PANEL_RONBO_RB070D30) += panel-ronbo-rb070d30.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_AMS581VF01) += panel-samsung-ams581vf01.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_AMS639RQ08) += panel-samsung-ams639rq08.o
+obj-$(CONFIG_DRM_PANEL_SAMSUNG_AMS644VK04) += panel-samsung-ams644vk04.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_ATNA33XC20) += panel-samsung-atna33xc20.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_DB7430) += panel-samsung-db7430.o
 obj-$(CONFIG_DRM_PANEL_SAMSUNG_LD9040) += panel-samsung-ld9040.o
diff --git a/drivers/gpu/drm/panel/panel-samsung-ams644vk04.c b/drivers/gpu/drm/panel/panel-samsung-ams644vk04.c
new file mode 100644
index 000000000..66c589f0b
--- /dev/null
+++ b/drivers/gpu/drm/panel/panel-samsung-ams644vk04.c
@@ -0,0 +1,373 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Samsung AMS644VK04 AMOLED DSI command mode panel driver (DSC)
+ *
+ * 1080x2400, 4 lanes, DSC 1.1 8 bpc -> 8 bpp, 90 Hz.
+ * Found in the OnePlus Nord (avicii).
+ *
+ * The initialisation sequences were generated from the downstream panel
+ * description ("samsung ams644vk04 fhd cmd mode dsc dsi panel").
+ */
+
+#include <linux/backlight.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/regulator/consumer.h>
+
+#include <drm/display/drm_dsc.h>
+#include <drm/drm_mipi_dsi.h>
+#include <drm/drm_modes.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+#define AMS644VK04_WIDTH		1080
+#define AMS644VK04_HEIGHT		2400
+
+#define AMS644VK04_MAX_BRIGHTNESS	0x7ff
+#define AMS644VK04_DEFAULT_BRIGHTNESS	0x140
+
+/* Power-on order and expected load as given by the downstream supply entries */
+static const struct regulator_bulk_data ams644vk04_supplies[] = {
+	{ .supply = "vddio", .init_load_uA = 62000 },
+	{ .supply = "vout", .init_load_uA = 857000 },
+	{ .supply = "vdd", .init_load_uA = 857000 },
+};
+
+struct ams644vk04 {
+	struct drm_panel panel;
+	struct mipi_dsi_device *dsi;
+	struct drm_dsc_config dsc;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data *supplies;
+	bool prepared;
+};
+
+static inline struct ams644vk04 *to_ams644vk04(struct drm_panel *panel)
+{
+	return container_of(panel, struct ams644vk04, panel);
+}
+
+/*
+ * DSC Picture Parameter Set as sent by the downstream driver: DCS 0x9e with
+ * the first 88 bytes of the PPS.  drm_dsc_pps_payload_pack() computes a
+ * different set for the same geometry: the downstream first_line_bpg_offset
+ * is 15 (the helper gives 12), which also changes nfl_bpg_offset,
+ * initial_dec_delay and scale_increment_interval, and the last rate control
+ * ranges differ.  This is the combination known to work with this panel.
+ */
+static const u8 ams644vk04_pps_cmd[] = {
+	0x9e, 0x11, 0x00, 0x00, 0x89, 0x30, 0x80, 0x09,
+	0x60, 0x04, 0x38, 0x00, 0x30, 0x02, 0x1c, 0x02,
+	0x1c, 0x02, 0x00, 0x02, 0x52, 0x00, 0x20, 0x04,
+	0x23, 0x00, 0x07, 0x00, 0x0f, 0x02, 0x8e, 0x02,
+	0x1f, 0x18, 0x00, 0x10, 0xf0, 0x03, 0x0c, 0x20,
+	0x00, 0x06, 0x0b, 0x0b, 0x33, 0x0e, 0x1c, 0x2a,
+	0x38, 0x46, 0x54, 0x62, 0x69, 0x70, 0x77, 0x79,
+	0x7b, 0x7d, 0x7e, 0x01, 0x02, 0x01, 0x00, 0x09,
+	0x40, 0x09, 0xbe, 0x19, 0xfc, 0x19, 0xfa, 0x19,
+	0xf8, 0x1a, 0x38, 0x1a, 0x78, 0x1a, 0xb6, 0x2a,
+	0xb6, 0x2a, 0xf4, 0x2a, 0xf4, 0x4b, 0x34, 0x63,
+	0x74,
+};
+
+static void ams644vk04_send_on(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x9d, 0x01);
+	mipi_dsi_dcs_write_buffer_multi(dsi_ctx, ams644vk04_pps_cmd, sizeof(ams644vk04_pps_cmd));
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_exit_sleep_mode_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 20);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_set_tear_on_multi(dsi_ctx, MIPI_DSI_DCS_TEAR_MODE_VBLANK);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_set_column_address_multi(dsi_ctx, 0, AMS644VK04_WIDTH - 1);
+	mipi_dsi_dcs_set_page_address_multi(dsi_ctx, 0, AMS644VK04_HEIGHT - 1);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf5, 0x85);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf8, 0xc4);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x04);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf8, 0x41, 0x47, 0x11, 0xb8, 0xb8);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x02);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf8, 0xcc);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf2, 0x82);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf5, 0x87);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x03);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xdd, 0x40);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_msleep(dsi_ctx, 110);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x06);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb0, 0x05);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x13);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xb7, 0x01, 0x37);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x53, 0x20);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x60, 0x10);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0x55, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xbd, 0x01);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0x5a, 0x5a);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xe6, 0x00);
+	mipi_dsi_dcs_write_seq_multi(dsi_ctx, 0xf0, 0xa5, 0xa5);
+	mipi_dsi_dcs_set_display_on_multi(dsi_ctx);
+}
+
+static void ams644vk04_send_off(struct mipi_dsi_multi_context *dsi_ctx)
+{
+	mipi_dsi_dcs_set_display_off_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 10);
+	mipi_dsi_dcs_enter_sleep_mode_multi(dsi_ctx);
+	mipi_dsi_msleep(dsi_ctx, 120);
+}
+
+static void ams644vk04_reset(struct ams644vk04 *ctx)
+{
+	/* Same timing as downstream: 10 ms steps, the logical value 1 asserts reset */
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 10100);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	usleep_range(10000, 10100);
+	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
+	usleep_range(10000, 10100);
+}
+
+static void ams644vk04_supplies_disable(struct ams644vk04 *ctx, int first)
+{
+	int i;
+
+	for (i = first; i >= 0; i--)
+		regulator_disable(ctx->supplies[i].consumer);
+}
+
+static int ams644vk04_supplies_enable(struct ams644vk04 *ctx)
+{
+	struct device *dev = &ctx->dsi->dev;
+	int i, ret;
+
+	/* The rails come up one after the other, vddio and vout need time to settle */
+	for (i = 0; i < ARRAY_SIZE(ams644vk04_supplies); i++) {
+		ret = regulator_enable(ctx->supplies[i].consumer);
+		if (ret) {
+			dev_err(dev, "Failed to enable %s: %d\n",
+				ams644vk04_supplies[i].supply, ret);
+			ams644vk04_supplies_disable(ctx, i - 1);
+			return ret;
+		}
+
+		if (i < ARRAY_SIZE(ams644vk04_supplies) - 1)
+			msleep(20);
+	}
+
+	return 0;
+}
+
+static int ams644vk04_prepare(struct drm_panel *panel)
+{
+	struct ams644vk04 *ctx = to_ams644vk04(panel);
+	struct device *dev = &ctx->dsi->dev;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+	int ret;
+
+	ret = ams644vk04_supplies_enable(ctx);
+	if (ret)
+		return ret;
+
+	ams644vk04_reset(ctx);
+
+	ams644vk04_send_on(&dsi_ctx);
+	if (dsi_ctx.accum_err) {
+		ret = dsi_ctx.accum_err;
+		dev_err(dev, "Failed to send on sequence: %d\n", ret);
+		goto err_power_down;
+	}
+
+	ctx->prepared = true;
+
+	return 0;
+
+err_power_down:
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	ams644vk04_supplies_disable(ctx, ARRAY_SIZE(ams644vk04_supplies) - 1);
+
+	return ret;
+}
+
+static int ams644vk04_unprepare(struct drm_panel *panel)
+{
+	struct ams644vk04 *ctx = to_ams644vk04(panel);
+	struct device *dev = &ctx->dsi->dev;
+	struct mipi_dsi_multi_context dsi_ctx = { .dsi = ctx->dsi };
+
+	ctx->prepared = false;
+
+	ams644vk04_send_off(&dsi_ctx);
+	if (dsi_ctx.accum_err)
+		dev_err(dev, "Failed to send off sequence: %d\n", dsi_ctx.accum_err);
+
+	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
+	ams644vk04_supplies_disable(ctx, ARRAY_SIZE(ams644vk04_supplies) - 1);
+
+	return 0;
+}
+
+/*
+ * Timings are the downstream ones.  The clock is htotal * vtotal * refresh:
+ * the msm DSI host scales the pixel clock for DSC by itself, so the mode
+ * describes the uncompressed picture.
+ */
+static const struct drm_display_mode ams644vk04_mode = {
+	.clock = (1080 + 52 + 24 + 24) * (2400 + 4 + 4 + 8) * 90 / 1000,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 52,
+	.hsync_end = 1080 + 52 + 24,
+	.htotal = 1080 + 52 + 24 + 24,
+	.vdisplay = 2400,
+	.vsync_start = 2400 + 4,
+	.vsync_end = 2400 + 4 + 4,
+	.vtotal = 2400 + 4 + 4 + 8,
+	.width_mm = 67,
+	.height_mm = 149,
+	.type = DRM_MODE_TYPE_DRIVER,
+};
+
+static int ams644vk04_get_modes(struct drm_panel *panel,
+				struct drm_connector *connector)
+{
+	return drm_connector_helper_get_modes_fixed(connector, &ams644vk04_mode);
+}
+
+static const struct drm_panel_funcs ams644vk04_panel_funcs = {
+	.prepare = ams644vk04_prepare,
+	.unprepare = ams644vk04_unprepare,
+	.get_modes = ams644vk04_get_modes,
+};
+
+static int ams644vk04_bl_update_status(struct backlight_device *bl)
+{
+	struct ams644vk04 *ctx = bl_get_data(bl);
+
+	if (!ctx->prepared)
+		return 0;
+
+	/* The panel takes the 11 bit level most significant byte first */
+	return mipi_dsi_dcs_set_display_brightness_large(ctx->dsi,
+							 backlight_get_brightness(bl));
+}
+
+static const struct backlight_ops ams644vk04_bl_ops = {
+	.update_status = ams644vk04_bl_update_status,
+};
+
+static int ams644vk04_probe(struct mipi_dsi_device *dsi)
+{
+	struct device *dev = &dsi->dev;
+	const struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.brightness = AMS644VK04_DEFAULT_BRIGHTNESS,
+		.max_brightness = AMS644VK04_MAX_BRIGHTNESS,
+	};
+	struct backlight_device *bl;
+	struct ams644vk04 *ctx;
+	int ret;
+
+	ctx = devm_drm_panel_alloc(dev, struct ams644vk04, panel,
+				   &ams644vk04_panel_funcs,
+				   DRM_MODE_CONNECTOR_DSI);
+	if (IS_ERR(ctx))
+		return PTR_ERR(ctx);
+
+	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(ams644vk04_supplies),
+					    ams644vk04_supplies, &ctx->supplies);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to get regulators\n");
+
+	ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
+	if (IS_ERR(ctx->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
+				     "Failed to get reset-gpios\n");
+
+	ctx->dsi = dsi;
+	mipi_dsi_set_drvdata(dsi, ctx);
+
+	dsi->lanes = 4;
+	dsi->format = MIPI_DSI_FMT_RGB888;
+	dsi->mode_flags = MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS |
+			  MIPI_DSI_MODE_DSC_ALL_SLICES_IN_PKT;
+
+	/*
+	 * DSC 1.1, 8 bpc, 8 bpp (4 fractional bits), block prediction, two
+	 * 540x48 slices per line, both in the same packet.  The DSI host
+	 * derives the remaining rate control parameters from this.
+	 */
+	ctx->dsc.dsc_version_major = 1;
+	ctx->dsc.dsc_version_minor = 1;
+	ctx->dsc.slice_width = 540;
+	ctx->dsc.slice_height = 48;
+	ctx->dsc.slice_count = AMS644VK04_WIDTH / ctx->dsc.slice_width;
+	ctx->dsc.bits_per_component = 8;
+	ctx->dsc.bits_per_pixel = 8 << 4;
+	ctx->dsc.block_pred_enable = true;
+	dsi->dsc = &ctx->dsc;
+
+	ctx->panel.prepare_prev_first = true;
+
+	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ctx,
+					    &ams644vk04_bl_ops, &props);
+	if (IS_ERR(bl))
+		return dev_err_probe(dev, PTR_ERR(bl), "Failed to register backlight\n");
+	ctx->panel.backlight = bl;
+
+	drm_panel_add(&ctx->panel);
+
+	ret = mipi_dsi_attach(dsi);
+	if (ret < 0) {
+		drm_panel_remove(&ctx->panel);
+		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
+	}
+
+	return 0;
+}
+
+static void ams644vk04_remove(struct mipi_dsi_device *dsi)
+{
+	struct ams644vk04 *ctx = mipi_dsi_get_drvdata(dsi);
+	int ret;
+
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+
+	drm_panel_remove(&ctx->panel);
+}
+
+static const struct of_device_id ams644vk04_of_match[] = {
+	{ .compatible = "samsung,ams644vk04" },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, ams644vk04_of_match);
+
+static struct mipi_dsi_driver ams644vk04_driver = {
+	.probe = ams644vk04_probe,
+	.remove = ams644vk04_remove,
+	.driver = {
+		.name = "panel-samsung-ams644vk04",
+		.of_match_table = ams644vk04_of_match,
+	},
+};
+module_mipi_dsi_driver(ams644vk04_driver);
+
+MODULE_DESCRIPTION("Panel driver for the Samsung AMS644VK04 AMOLED DSI panel");
+MODULE_LICENSE("GPL");

-- 
2.56.0


