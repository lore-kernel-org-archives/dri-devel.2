Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66803C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 373D210E73F;
	Tue, 22 Sep 2026 06:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="R5FOoYa4";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E818C10E73F
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=3ek7mJzGL/9yBolrQvEtoJoyM66ZQqkeJgFGLDJjQUc=; t=1790057854; x=1791267454; 
 b=R5FOoYa4N2Livn0rJLRfa22PsIXURyH5ZWOIB2HEUVahqMhbOKK2vkoowhdXoI1tCoMTYet2JvE
 T80lEfO0HIXD3bLIrxd6yAm/3CoV4rFC58PS1BeNdkqR2hmk4PqGv3tIdN6qiz3AXenBjBehyWzsT
 Vj1Q1Y8Dg6PxjKNEWIJDNSZMCQwNXSd0GkfmwH0ubX9vUFBagmx3fKkWlFzLl6+VuYZiXx6DSDNRW
 TBMtl64LcBN5K5jGaUDZ/Lap/gVXdilNa0UGOUwLqoyLxlGdnvBU9yi6/n4O9oIULOYUghCeAG9tM
 9JphbU6bIU/4vNgsUlpWxa/BvtkRHqJreeCQ==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:04 +0200
Subject: [PATCH RFC 7/9] drm/bridge: tc358762: make LPTXTIMECNT
 configurable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-7-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1753; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=0ao++1qEowCnecwI5jgyBfK+9SvJvTxqa1J5MX+7yTk=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBP3lnEYsDT8vnSsiYtbS3mP8PS81sUrzv3za2F6J
 pKQe0Oyo5SFQYyLQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIlYVzD8z/v7h3F2sIHUllv8
 rt1WPpz/t8t11GvJch68G2S+Y09kIsM/09uFbS+CY2L583ncJjGEHvrma3XS+VvX43NvNmt/Voz
 gAwA=
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

On the Epson Moverio BT-200, reading back registers does not work with the
default value, so make it configurable. Real meaning of this value is not
known from public sources.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/gpu/drm/bridge/tc358762.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 1bea89fb03a8..194785bff997 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
 #include <linux/of_graph.h>
+#include <linux/property.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
 
@@ -101,8 +102,6 @@
 
 #define IDREG			0x04A0 /* Chip and Revision ID */
 
-#define LPX_PERIOD		3
-
 struct tc358762 {
 	struct device *dev;
 	struct drm_bridge bridge;
@@ -112,6 +111,7 @@ struct tc358762 {
 	struct spi_controller *spi;
 	bool pre_enabled;
 	int error;
+	u32 lpx_period;
 	bool use_vtg;
 };
 
@@ -246,7 +246,7 @@ static void tc358762_pre_enable(struct drm_bridge *bridge,
 	tc358762_write(ctx, PPI_D1S_CLRSIPOCOUNT, 5);
 	tc358762_write(ctx, PPI_D0S_ATMR, 0);
 	tc358762_write(ctx, PPI_D1S_ATMR, 0);
-	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
+	tc358762_write(ctx, PPI_LPTXTIMECNT, ctx->lpx_period);
 
 	if (ctx->use_vtg) {
 		struct videomode vm = { 0 };
@@ -367,6 +367,9 @@ static int tc358762_parse_dt(struct tc358762 *ctx)
 	if (IS_ERR(ctx->reset_gpio))
 		return PTR_ERR(ctx->reset_gpio);
 
+	ctx->lpx_period = 3;
+	device_property_read_u32(dev, "toshiba,lptxtimecnt", &ctx->lpx_period);
+
 	return 0;
 }
 

-- 
2.47.3

