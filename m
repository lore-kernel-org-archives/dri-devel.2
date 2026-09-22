Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04AB9C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:17:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B258010EB77;
	Tue, 22 Sep 2026 06:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="4S28kEZy";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F382E10E742
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=ELRD9D9yQHZnUKwCihLb3MnasJ8QLZIMU47gaHub3Qk=; t=1790057856; x=1791267456; 
 b=4S28kEZyx4hBzic/SE9F7ZyqE2hVVV5VNsWwJrGSOBiOA9rEG4qEffHaGbT7+Y1uU7AV5SNwBHq
 kzFrojCYOZ67pbipsmo+YpOO6DCnnXz2PUEOEEgkDq8OSciHBTH1NmqUcZcGAlSTFDnxQ1fkw9aLt
 WpjaZFvF8IsPjUOT4SQsum7r/EfilvElYsq7Us6e9yJAqCkyZdrY1yIpG3Q/JwUfkLbBiYNECIeah
 ev/grbop2a6VjcXDRhSCXio3R+XYrFOoJn4xl1bE9dRhAoThDAXUFpnVU8Z2pWxXI8Xx9IXEfOYkw
 /jLObycIa8ZJHDusWmG59bOUAwDYDYaZY4AQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:03 +0200
Subject: [PATCH RFC 6/9] drm/bridge: tc358762: read back ID register
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-6-45ff36b364cf@kemnade.info>
References: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
In-Reply-To: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 hns@goldelico.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=3066; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=TMC/lfc+5oFMfDMPWbiQ9mLH12CvS8Mph8VMxN/fWCo=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBMlp0xQKZ5dco+1zn6jYfKW985W/kHeB2OEY1mLc
 hZdNDzbUcrCIMbFICumyPLLWsHtk8qz3OCpEfYwc1iZQIYwcHEKwEREwxj+lxpofgxhCNv28lma
 y76DLH4PBKq8RZ03ppjuV4+MK5kxgeGvRFlE2epbT/98V/CoMbsixlGwLuSx4g9h/hNJnKu0FM7
 yAQA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

to check if reading works and in preparation for the PLL setup, read back
the ID register value. Also this produces better errors if chip is not
connected. In the Epson Moverio BT200, the DSI busses are on a (probably
not hot-) detachable cable.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 40 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 8024e49e2868..1bea89fb03a8 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -50,6 +50,8 @@
 #define DSI_LANEENABLE_L0EN	BIT(1)
 #define DSI_LANEENABLE_L1EN	BIT(2)
 
+#define RDPKTLN			0x0410 /* Packet length */
+
 /* LCDC/DPI Registers */
 #define LCDCTRL			0x0420 /* Video Path Control */
 #define LCDCTRL_MSF		BIT(0) /* Magic square in RGB666 */
@@ -97,6 +99,8 @@
 #define SYSCTRL_PCLKDIV_DIV_2	2
 #define SYSCTRL_PCLKDIV_DIV_3	4
 
+#define IDREG			0x04A0 /* Chip and Revision ID */
+
 #define LPX_PERIOD		3
 
 struct tc358762 {
@@ -119,6 +123,27 @@ static int tc358762_clear_error(struct tc358762 *ctx)
 	return ret;
 }
 
+static int tc358762_read(struct tc358762 *ctx, u16 addr, u32 *val)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	ssize_t ret;
+	u8 addr_buf[2];
+	u8 buf[4];
+
+	put_unaligned_le16(addr, addr_buf);
+
+	ret = mipi_dsi_generic_read(dsi, addr_buf, 2, buf, sizeof(buf));
+	if (ret < 0) {
+		dev_err(ctx->dev, "gen read failed: %d\n", ret);
+		return ret;
+	}
+	dev_dbg(ctx->dev, "read return %02x %02x %02x %02x\n",
+		buf[0], buf[1], buf[2], buf[3]);
+
+	*val = get_unaligned_le32(buf);
+	return ret;
+}
+
 static void tc358762_write(struct tc358762 *ctx, u16 addr, u32 val)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -182,6 +207,7 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 	struct drm_display_mode *mode;
 	u32 lcdctrl;
 	int ret;
+	u32 id;
 
 	ret = regulator_enable(ctx->regulator);
 	if (ret < 0)
@@ -205,6 +231,8 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 	 */
 	tc358762_write(ctx, LCDCTRL, 0);
 
+	tc358762_write(ctx, RDPKTLN, 3);
+
 	tc358762_write(ctx, SYSCTRL,
 		       FIELD_PREP(SYSCTRL_DPIDATA_IO_MASK, SYSCTRL_DPIDATA_IO_4MA) |
 		       FIELD_PREP(SYSCTRL_DPISTB_IO_MASK, SYSCTRL_DPISTB_IO_4MA) |
@@ -283,6 +311,18 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 	if (ret < 0)
 		dev_err(ctx->dev, "error initializing bridge (%d)\n", ret);
 
+	/*
+	 * This generates an ack with error if the device is reinitialized
+	 * without reset, ignore the error here, the second read should be
+	 * successful.
+	 */
+	tc358762_read(ctx, IDREG, &id);
+	ret = tc358762_read(ctx, IDREG, &id);
+	if (ret < 0)
+		dev_err(ctx->dev, "read id  failed (%d)\n", ret);
+	else if (id != 0x6200)
+		dev_info(ctx->dev, "unknown chip with id %x\n", id);
+
 	ctx->pre_enabled = true;
 }
 

-- 
2.47.3

