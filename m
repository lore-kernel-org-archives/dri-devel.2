Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3311606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 09:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kpOXETvv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34CB110FAFF;
	Wed, 28 Oct 2026 09:52:40 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DBE4C10FAFF
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:52:33 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 50CB9601FA;
 Wed, 28 Oct 2026 09:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8E41F01828;
 Wed, 28 Oct 2026 09:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793181153;
 bh=hEViGzVzxjDZEbHPtQQPbmKrNOIvdMciq7SxY05A+2s=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kpOXETvvQ0xtr7E8zrWcFr94dSFB2mP6tTpwV5sS7Aiw3srUdcw5Qu3ZzyB0zi3/A
 mN+cmNboAU0gWg8pqtkw72pmYvOGPkiMId+rrmtAq9zkc7KH6hNMFcz1Bp2CIoeYJq
 CDlAFO8UeixSqNfu7XigDUBVJhteKFoSaH+rtSiVGZW8OIVvRzVhj4K686pAuB4AQx
 /8ntJDopewQCpXdcPmAqtsfmEvyIGDnO3GLgtl2nymaBmtPHiCeqyzsRGlO4a847O/
 71y10WXdLJw2odcnx1iSooyBK4lQTum47Qm9QorjY0esPXqyjgnbJXzI+GFUfjNYUV
 ukHROWkJCKcIw==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Ritesh Kumar <quic_riteshk@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Abel Vesa <abelvesa@kernel.org>, linux-arm-msm@vger.kernel.org
Subject: [PATCH 6/8] drm/panel: novatek-nt36672e: Add support of the C-PHY
 panel module
Date: Wed, 28 Oct 2026 11:51:49 +0200
Message-ID: <20261028095151.1682096-7-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261028095151.1682096-1-vz@kernel.org>
References: <20261028095151.1682096-1-vz@kernel.org>
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The display card for the Qualcomm SM8450 HDK board has an NT36672E panel
module with a resolution of 1080x2400, which is connected over 3 MIPI
C-PHY trios, and runs at 144Hz with Display Stream Compression.

The MIPI PHY type of the DSI link is fixed by the panel module design,
thus select the panel type by the PHY type of the DSI link, MIPI D-PHY
selects the existing panel description, MIPI C-PHY selects the new one.

The initialization sequence, the display timings and the DSC parameters
of the new supported MIPI C-PHY panel module are taken from the Qualcomm
display device tree source of the panel:

  https://git.codelinaro.org/clo/la/platform/vendor/opensource/display-devicetree
  tag DISPLAY.LA.6.0.r12-02500-WAIPIO.QSSI17.0
  display/dsi-panel-nt36672e-fhd-plus-144hz-video-cphy.dtsi

The DSC picture parameter set is sent after the display is switched on,
the display decompression is enabled by the initialization sequence.

Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/gpu/drm/panel/Kconfig                 |   8 +-
 .../gpu/drm/panel/panel-novatek-nt36672e.c    | 496 +++++++++++++++++-
 2 files changed, 486 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 7a520b4d60fe..634d44d26a74 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -720,10 +720,14 @@ config DRM_PANEL_NOVATEK_NT36672E
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
+	select DRM_DISPLAY_DSC_HELPER
+	select DRM_DISPLAY_HELPER
 	help
 	  Say Y here if you want to enable support for Novatek NT36672E DSI Video Mode
-	  LCD panel module. The panel has a resolution of 1080x2408 and uses 24 bit
-	  RGB per pixel.
+	  LCD panel modules. The supported panel modules use 24 bit RGB per pixel,
+	  and have a resolution of 1080x2408 with a 4-lane MIPI D-PHY link, or
+	  a resolution of 1080x2400 with a 3-trio MIPI C-PHY link and Display
+	  Stream Compression.
 
 config DRM_PANEL_NOVATEK_NT37700F
 	tristate "Novatek NT37700F DSI panel"
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
index 33676e334b9f..42d1448ea971 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672e.c
@@ -8,6 +8,8 @@
 #include <linux/of_graph.h>
 #include <linux/regulator/consumer.h>
 
+#include <drm/display/drm_dsc.h>
+#include <drm/display/drm_dsc_helper.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
@@ -33,6 +35,8 @@ struct panel_desc {
 	unsigned long mode_flags;
 	enum mipi_dsi_pixel_format format;
 	unsigned int lanes;
+	u32 phy_type;
+	const struct drm_dsc_config *dsc;
 	const char *panel_name;
 	void (*init_sequence)(struct mipi_dsi_multi_context *ctx);
 };
@@ -45,6 +49,7 @@ struct nt36672e_panel {
 	struct regulator_bulk_data *supplies;
 	struct regulator_bulk_data *bias_supplies;
 	const struct panel_desc *desc;
+	struct drm_dsc_config dsc;
 };
 
 #define NT36672E_DCS_SWITCH_PAGE	0xff
@@ -360,6 +365,401 @@ static void nt36672e_1080x2408_60hz_init(struct mipi_dsi_multi_context *ctx)
 	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x01);
 }
 
+static void nt36672e_1080x2400_144hz_cphy_init(struct mipi_dsi_multi_context *ctx)
+{
+	nt36672e_switch_page(ctx, 0x10);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc0, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc1, 0x89, 0x28, 0x00, 0x08, 0x00, 0xaa, 0x02,
+				     0x0e, 0x00, 0x2b, 0x00, 0x07, 0x0d, 0xb7, 0x0c, 0xb7);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc2, 0x1b, 0xa0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe9, 0x01);
+
+	nt36672e_switch_page(ctx, 0x20);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x66);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x06, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x07, 0x38);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x18, 0x77);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x69, 0x91);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x95, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x96, 0xd1);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf2, 0x65);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf3, 0x74);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf4, 0x65);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf5, 0x74);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf6, 0x65);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf7, 0x74);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf8, 0x65);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf9, 0x74);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x89, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8a, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8d, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8e, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8f, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x91, 0x15);
+
+	nt36672e_switch_page(ctx, 0x24);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x03, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x05, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x08, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x09, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0a, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0b, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x11, 0x17);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x12, 0x13);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x13, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x15, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x16, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x17, 0x18);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1b, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1d, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20, 0x2f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x22, 0x2d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x23, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x29, 0x17);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2a, 0x13);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2b, 0x15);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2f, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x30, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x31, 0x18);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x32, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x34, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x35, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x36, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4d, 0x1b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4e, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4f, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x71, 0x30);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x79, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7a, 0x82);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7b, 0x96);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7d, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x80, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x81, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x82, 0x13);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0x31);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x85, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x86, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x87, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x90, 0x13);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x92, 0x31);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x93, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x94, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x95, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9c, 0xf4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9d, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa0, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa2, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa3, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa4, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa5, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc6, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xc9, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd9, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe9, 0x02);
+
+	nt36672e_switch_page(ctx, 0x25);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x18, 0x22);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x19, 0xe4);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x66, 0xd8);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x68, 0x50);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x69, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6b, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6d, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6e, 0x48);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x72, 0x41);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x73, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x74, 0xd0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x77, 0x62);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x79, 0x81);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7e, 0x1d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x80, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xcf, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd6, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd7, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xef, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xf0, 0x84);
+
+	nt36672e_switch_page(ctx, 0x26);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x15, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x81, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x83, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x85, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x86, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x87, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8a, 0x1a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8b, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8c, 0x24);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8e, 0x42);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8f, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x90, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x91, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9a, 0x81);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9b, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9c, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9d, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9e, 0x00);
+
+	nt36672e_switch_page(ctx, 0x27);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x60);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20, 0x81);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x21, 0xea);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x25, 0x82);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x26, 0x3f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6e, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6f, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x70, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x71, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x72, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x75, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x76, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x77, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7d, 0x09);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7e, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x80, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x82, 0x09);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x83, 0x5f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x88, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x89, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa5, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa6, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa7, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe3, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe4, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe5, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe6, 0x33);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xe9, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xea, 0x5e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xeb, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xec, 0x67);
+
+	nt36672e_switch_page(ctx, 0x2a);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x00, 0x91);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x03, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x04, 0x73);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x07, 0x64);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0a, 0x60);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0c, 0x06);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0d, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0e, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x11, 0x58);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x15, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x16, 0x79);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x19, 0x0d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1a, 0xf2);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1b, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1d, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1e, 0x55);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x1f, 0x55);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x20, 0x55);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x28, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x29, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2a, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2b, 0x05);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2d, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2f, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x30, 0x47);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x31, 0x23);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x33, 0x25);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x34, 0xff);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x35, 0x2c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x36, 0x75);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x37, 0xfb);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x38, 0x2e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x39, 0x73);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x3a, 0x47);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x46, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x47, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4a, 0xf0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4e, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4f, 0x8b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x52, 0x0e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x54, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x56, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x57, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x58, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x59, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x60, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x61, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x62, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x63, 0xed);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x65, 0x05);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x66, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x67, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x68, 0x4d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6a, 0x0a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6b, 0xc9);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6c, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6d, 0xe3);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6e, 0xc6);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6f, 0x20);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x70, 0xe2);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x71, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7a, 0x04);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7b, 0x40);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7c, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7d, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7f, 0xe0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x83, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x84, 0xc5);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x87, 0x0f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x88, 0x42);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x89, 0x14);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8b, 0x36);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8c, 0x33);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8d, 0x33);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x8e, 0x33);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x95, 0x80);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x96, 0xfd);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x97, 0x19);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x98, 0x4a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x99, 0x07);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9a, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9b, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9c, 0x8b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9d, 0xff);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0x8b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa0, 0xff);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa2, 0x4e);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa3, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa4, 0xf8);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa5, 0x52);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa6, 0xfd);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xa7, 0x4b);
+
+	nt36672e_switch_page(ctx, 0x2c);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x00, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x01, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x02, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x03, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x04, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x05, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0d, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x0e, 0x1f);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x16, 0x1b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x17, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x18, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x19, 0x4b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x2a, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4d, 0x16);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x4e, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x54, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x02);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x56, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x58, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x59, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x61, 0x19);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x62, 0x19);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6a, 0x10);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6b, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6c, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x6d, 0x2a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x7e, 0x03);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9d, 0x0b);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9e, 0x04);
+
+	nt36672e_switch_page(ctx, 0x20);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00, 0xe2, 0x00, 0xe9, 0x00, 0xf6, 0x01,
+				     0x01, 0x01, 0x0c, 0x01, 0x15, 0x01, 0x20, 0x01, 0x28);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x01, 0x33, 0x01, 0x51, 0x01, 0x6e, 0x01,
+				     0x9a, 0x01, 0xc0, 0x01, 0xfd, 0x02, 0x34, 0x02, 0x35);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb2, 0x02, 0x6b, 0x02, 0xa9, 0x02, 0xd1, 0x03,
+				     0x04, 0x03, 0x25, 0x03, 0x51, 0x03, 0x5f, 0x03, 0x6d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb3, 0x03, 0x7d, 0x03, 0x90, 0x03, 0xa7, 0x03,
+				     0xbb, 0x03, 0xd4, 0x03, 0xd8, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb4, 0x00, 0xaa, 0x00, 0xb3, 0x00, 0xc4, 0x00,
+				     0xd4, 0x00, 0xe2, 0x00, 0xf0, 0x00, 0xfc, 0x01, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb5, 0x01, 0x12, 0x01, 0x39, 0x01, 0x58, 0x01,
+				     0x8c, 0x01, 0xb5, 0x01, 0xf7, 0x02, 0x30, 0x02, 0x31);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xce, 0x03,
+				     0x01, 0x03, 0x23, 0x03, 0x4e, 0x03, 0x5c, 0x03, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb7, 0x03, 0x7b, 0x03, 0x8e, 0x03, 0xa5, 0x03,
+				     0xbb, 0x03, 0xd4, 0x03, 0xd8, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb8, 0x00, 0x00, 0x00, 0x20, 0x00, 0x47, 0x00,
+				     0x65, 0x00, 0x85, 0x00, 0x99, 0x00, 0xad, 0x00, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb9, 0x00, 0xd2, 0x01, 0x06, 0x01, 0x30, 0x01,
+				     0x70, 0x01, 0x9f, 0x01, 0xe8, 0x02, 0x25, 0x02, 0x26);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xba, 0x02, 0x5f, 0x02, 0x9f, 0x02, 0xc7, 0x02,
+				     0xfd, 0x03, 0x20, 0x03, 0x52, 0x03, 0x63, 0x03, 0x67);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x03, 0x78, 0x03, 0x8b, 0x03, 0xa3, 0x03,
+				     0xb9, 0x03, 0xd4, 0x03, 0xd8, 0x00, 0x00);
+
+	nt36672e_switch_page(ctx, 0x21);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb0, 0x00, 0xe2, 0x00, 0xe9, 0x00, 0xf6, 0x01,
+				     0x01, 0x01, 0x0c, 0x01, 0x15, 0x01, 0x20, 0x01, 0x28);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb1, 0x01, 0x33, 0x01, 0x51, 0x01, 0x6e, 0x01,
+				     0x9a, 0x01, 0xc0, 0x01, 0xfd, 0x02, 0x34, 0x02, 0x35);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb2, 0x02, 0x6b, 0x02, 0xa9, 0x02, 0xd1, 0x03,
+				     0x04, 0x03, 0x25, 0x03, 0x51, 0x03, 0x5f, 0x03, 0x6d);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb3, 0x03, 0x7d, 0x03, 0x90, 0x03, 0xa7, 0x03,
+				     0xbb, 0x03, 0xd4, 0x03, 0xd8, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb4, 0x00, 0xaa, 0x00, 0xb3, 0x00, 0xc4, 0x00,
+				     0xd4, 0x00, 0xe2, 0x00, 0xf0, 0x00, 0xfc, 0x01, 0x08);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb5, 0x01, 0x12, 0x01, 0x39, 0x01, 0x58, 0x01,
+				     0x8c, 0x01, 0xb5, 0x01, 0xf7, 0x02, 0x30, 0x02, 0x31);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb6, 0x02, 0x68, 0x02, 0xa6, 0x02, 0xce, 0x03,
+				     0x01, 0x03, 0x23, 0x03, 0x4e, 0x03, 0x5c, 0x03, 0x6a);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb7, 0x03, 0x7b, 0x03, 0x8e, 0x03, 0xa5, 0x03,
+				     0xbb, 0x03, 0xd4, 0x03, 0xd8, 0x00, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb8, 0x00, 0x00, 0x00, 0x20, 0x00, 0x47, 0x00,
+				     0x65, 0x00, 0x85, 0x00, 0x99, 0x00, 0xad, 0x00, 0xc0);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xb9, 0x00, 0xd2, 0x01, 0x06, 0x01, 0x30, 0x01,
+				     0x70, 0x01, 0x9f, 0x01, 0xe8, 0x02, 0x25, 0x02, 0x26);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xba, 0x02, 0x5f, 0x02, 0x9f, 0x02, 0xc7, 0x02,
+				     0xfd, 0x03, 0x20, 0x03, 0x52, 0x03, 0x63, 0x03, 0x67);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xbb, 0x03, 0x78, 0x03, 0x8b, 0x03, 0xa3, 0x03,
+				     0xb9, 0x03, 0xd4, 0x03, 0xd8, 0x00, 0x00);
+
+	nt36672e_switch_page(ctx, 0xe0);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x35, 0x82);
+
+	nt36672e_switch_page(ctx, 0xf0);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x5a, 0x00);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0xd2, 0x52);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9f, 0x12);
+
+	nt36672e_switch_page(ctx, 0xd0);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x22);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x54, 0x02);
+
+	nt36672e_switch_page(ctx, 0xc0);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9c, 0x11);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x9d, 0x11);
+
+	nt36672e_switch_page(ctx, 0x10);
+	nt36672e_enable_reload_cmds(ctx);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x35, 0x01);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x51, 0xff);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x53, 0x0c);
+	mipi_dsi_dcs_write_seq_multi(ctx, 0x55, 0x00);
+}
+
 static int nt36672e_power_on(struct nt36672e_panel *ctx)
 {
 	struct mipi_dsi_device *dsi = ctx->dsi;
@@ -437,6 +837,14 @@ static int nt36672e_on(struct nt36672e_panel *nt36672e)
 
 	mipi_dsi_msleep(&ctx, 100);
 
+	/* Display decompression is enabled by the initialization sequence */
+	if (desc->dsc) {
+		struct drm_dsc_picture_parameter_set pps;
+
+		drm_dsc_pps_payload_pack(&pps, &nt36672e->dsc);
+		mipi_dsi_picture_parameter_set_multi(&ctx, &pps);
+	}
+
 	return ctx.accum_err;
 }
 
@@ -511,10 +919,59 @@ static const struct panel_desc nt36672e_panel_desc = {
 	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
 	.format = MIPI_DSI_FMT_RGB888,
 	.lanes = 4,
+	.phy_type = PHY_TYPE_DPHY,
 	.panel_name = "nt36672e fhd plus panel",
 	.init_sequence = nt36672e_1080x2408_60hz_init,
 };
 
+static const struct drm_display_mode nt36672e_1080x2400_144hz = {
+	.name = "1080x2400",
+	.clock = (1080 + 76 + 20 + 80) * (2400 + 54 + 10 + 10) * 144 / 1000,
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 76,
+	.hsync_end = 1080 + 76 + 20,
+	.htotal = 1080 + 76 + 20 + 80,
+	.vdisplay = 2400,
+	.vsync_start = 2400 + 54,
+	.vsync_end = 2400 + 54 + 10,
+	.vtotal = 2400 + 54 + 10 + 10,
+	.flags = 0,
+};
+
+static const struct drm_dsc_config nt36672e_1080x2400_dsc = {
+	.dsc_version_major = 1,
+	.dsc_version_minor = 1,
+	.slice_height = 8,
+	.slice_width = 540,
+	.slice_count = 1080 / 540,
+	.bits_per_component = 8,
+	.bits_per_pixel = 8 << 4,	/* 4 fractional bits */
+	.block_pred_enable = true,
+};
+
+static const struct panel_desc nt36672e_cphy_panel_desc = {
+	.display_mode = &nt36672e_1080x2400_144hz,
+	.width_mm = 70,
+	.height_mm = 154,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		      MIPI_DSI_MODE_LPM | MIPI_DSI_CLOCK_NON_CONTINUOUS,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 3,
+	.phy_type = PHY_TYPE_CPHY,
+	.dsc = &nt36672e_1080x2400_dsc,
+	.panel_name = "nt36672e fhd plus c-phy panel",
+	.init_sequence = nt36672e_1080x2400_144hz_cphy_init,
+};
+
+/*
+ * The panel modules share the compatible, the module is selected by the PHY
+ * type of the DSI link, which is fixed by the panel module.
+ */
+static const struct panel_desc * const nt36672e_panel_descs[] = {
+	&nt36672e_panel_desc,
+	&nt36672e_cphy_panel_desc,
+};
+
 static int nt36672e_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector)
 {
 	struct nt36672e_panel *ctx = to_nt36672e_panel(panel);
@@ -569,7 +1026,8 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 	struct device *dev = &dsi->dev;
 	struct nt36672e_panel *ctx;
 	bool avdd, avee;
-	int ret = 0;
+	u32 phy_type;
+	int i, ret = 0;
 
 	ctx = devm_drm_panel_alloc(dev, struct nt36672e_panel, panel,
 				   &nt36672e_drm_funcs,
@@ -577,12 +1035,18 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	ctx->desc = of_device_get_match_data(dev);
-	if (!ctx->desc) {
-		dev_err(dev, "missing device configuration\n");
-		return -ENODEV;
+	phy_type = nt36672e_get_dsi_phy_type(dev);
+	for (i = 0; i < ARRAY_SIZE(nt36672e_panel_descs); i++) {
+		if (nt36672e_panel_descs[i]->phy_type == phy_type) {
+			ctx->desc = nt36672e_panel_descs[i];
+			break;
+		}
 	}
 
+	if (!ctx->desc)
+		return dev_err_probe(dev, -EINVAL,
+				     "Unsupported DSI PHY type %u\n", phy_type);
+
 	ret = devm_regulator_bulk_get_const(dev, ARRAY_SIZE(nt36672e_supplies),
 					    nt36672e_supplies, &ctx->supplies);
 	if (ret < 0)
@@ -626,13 +1090,16 @@ static int nt36672e_panel_probe(struct mipi_dsi_device *dsi)
 	dsi->format = ctx->desc->format;
 	dsi->mode_flags = ctx->desc->mode_flags;
 
-	/* A MIPI D-PHY link to the panel shall have exactly 4 data lanes */
-	if (nt36672e_get_dsi_phy_type(dev) == PHY_TYPE_DPHY) {
-		ret = drm_of_get_data_lanes_count_remote(dev->of_node, 0, -1, 1, 4);
-		if (ret > 0 && ret != 4)
-			return dev_err_probe(dev, -EINVAL,
-					     "%d D-PHY data lanes described, 4 required\n",
-					     ret);
+	/* The DSI link shall have the number of data lanes of the panel */
+	ret = drm_of_get_data_lanes_count_remote(dev->of_node, 0, -1, 1, 4);
+	if (ret > 0 && ret != dsi->lanes)
+		return dev_err_probe(dev, -EINVAL,
+				     "%d DSI data lanes described, %u required\n",
+				     ret, dsi->lanes);
+
+	if (ctx->desc->dsc) {
+		ctx->dsc = *ctx->desc->dsc;
+		dsi->dsc = &ctx->dsc;
 	}
 
 	ret = drm_panel_of_backlight(&ctx->panel);
@@ -665,10 +1132,7 @@ static void nt36672e_panel_remove(struct mipi_dsi_device *dsi)
 }
 
 static const struct of_device_id nt36672e_of_match[] = {
-	{
-		.compatible = "novatek,nt36672e",
-		.data = &nt36672e_panel_desc,
-	},
+	{ .compatible = "novatek,nt36672e" },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, nt36672e_of_match);
-- 
2.51.0

