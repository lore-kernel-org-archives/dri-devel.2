Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B00F7C982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:17:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A79710E65E;
	Tue, 22 Sep 2026 06:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="ute7qoKt";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E713F10E35D
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=HXDSp/hZMea/g/uCBirxGqC15DoS4eWxIXlEZsOk6QI=; t=1790057854; x=1791267454; 
 b=ute7qoKtC38ukxKhB19AlHhuyEWBhssWO6YUOojBjPN/sL0g2W9eeHWcjUAErR77MG9uLu7CKRU
 Y/49iSLmmogHK6h17qAx8lFVfWS2CLmfBkCVtgEkhRi8RoV0ASAdqboV3YlgkqfJ0L/KkblNvgaO4
 aJ86cIwXQ5lWsy2Elfss7/OxqdJYXHuWDWg9GeTZET2XFh9c29vQrkt3onPgBnE/ZZHmshn4zGnxV
 JmvWsQWsXfsTMXx7t6/j1c7pV8pB/QFcyiact6U7wrCMX28evrl7ggArfu7tPHdxoqYG3urCYm7iB
 ibN53Ib1mmoyQz/WJDK5azfc0k2W7rNa7M2w==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:17:00 +0200
Subject: [PATCH RFC 3/9] dt-bindings: display: bridge: tc358762: Add some
 missing properties
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-3-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1304; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=FgdE4S79rUwu02PcPAK2OqiniqhAhf0hXGN4VJbaZeI=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBMM2DiZ03boOdxYssnOlrXzoYTQNc4jdorbZzBEb
 Ph7Syu2o5SFQYyLQVZMkeWXtYLbJ5VnucFTI+xh5rAygQxh4OIUgIlMmsPwv3j75NqyZU4uYTM/
 bpa4duPmRqM/X27bJc5cpV3H1vlEo4Xhv1/773nhOX9bsifymHyqcFLIYXne+Jx9evHkjKS+i2E
 F3AA=
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

The TC358762 can act as an SPI master with two CS for controlling DPI
slave devices. Add a spi subnode for that.
Add a property to describe number of DSI data lanes. If two lanes
are used, an external clock is required.

There is the LPTXTIMECNT register which needs to be set to a non-standard
value on Epson Moverio BT-200, add a property for it. I know nothing about
it besides the required value.
---
 .../bindings/display/bridge/toshiba,tc358762.yaml          | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml
index 6c1de0b21722..0e380f2a56e6 100644
--- a/Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml
+++ b/Documentation/devicetree/bindings/display/bridge/toshiba,tc358762.yaml
@@ -44,6 +44,20 @@ properties:
     required:
       - port@1
 
+  spi:
+    $ref: /schemas/spi/spi-controller.yaml#
+    unevaluatedProperties: false
+
+  dsi-lanes:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2]
+
+  toshiba,lptxtimecnt:
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+  clocks:
+    maxItems: 1
+
 required:
   - compatible
   - reg

-- 
2.47.3

