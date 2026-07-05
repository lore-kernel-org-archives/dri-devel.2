Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D73A2C44500
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:35:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 572CA10E247;
	Sun,  5 Jul 2026 21:35:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="W7POoZQy";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5E7710E247
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 21:35:46 +0000 (UTC)
Received: from killaraus.ideasonboard.com
 (2001-14ba-70f3-e800--a06.rev.dnainternet.fi [IPv6:2001:14ba:70f3:e800::a06])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id AC1A38E0;
 Sun,  5 Jul 2026 23:34:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1783287297;
 bh=X0bi44pGGq2wkUprmik/FLgZa+jUE+P80H0Y+kHrkJg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=W7POoZQyk8iVfz22iValS6Xrp/Q7rkZOiDtjGsuM2nfaHRjG8wRe1GsYVguD8NCxD
 WZ+mMdaS22dZwyLL0WMrhPi9je5xmHgRoS+T2X2aLKlLJqsG2RN9At8X46ahqw5voC
 RzfIWFQfVmmOC8S3zZA7m3AD9wUFjUoMrsBz8+LQ=
From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 linux-renesas-soc@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: display: vga-connector: Allow hardcoding EDID
Date: Mon,  6 Jul 2026 00:35:39 +0300
Message-ID: <20260705213542.28987-2-laurent.pinchart+renesas@ideasonboard.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
References: <20260705213542.28987-1-laurent.pinchart+renesas@ideasonboard.com>
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

Since DDC version 2, introduced in 1996, VGA monitors have exposed EDID
data over an I2C bus. The bus is also used to detect the presence of a
connected monitor by trying to read the EDID data.

Some devices where the VGA display is integrated in the device and
always connected do not connect the DDC pins. Some development boards,
such as the Renesas M3N Salvator-XS, also do not connect the DDC pins.

To support those, add the ability to provide hardcoded EDID data in the
device tree. This is mutually exclusive with specifying a DDC bus, and
can only be done when the VGA display is guaranteed to be always
connected.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 .../bindings/display/connector/vga-connector.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/connector/vga-connector.yaml b/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
index 25f868002000..7e1b8e798e5b 100644
--- a/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
+++ b/Documentation/devicetree/bindings/display/connector/vga-connector.yaml
@@ -19,10 +19,25 @@ properties:
     description: phandle link to the I2C controller used for DDC EDID probing
     $ref: /schemas/types.yaml#/definitions/phandle
 
+  edid:
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    description:
+      When the DDC signals are not wired to the connector, and the connected
+      display is not removable, this property is used to supply a binary EDID
+      blob for the display.
+
   port:
     $ref: /schemas/graph.yaml#/properties/port
     description: Connection to controller providing VGA signals
 
+allOf:
+  - if:
+      required:
+        - ddc-i2c-bus
+    then:
+      properties:
+        edid: false
+
 required:
   - compatible
   - port
-- 
Regards,

Laurent Pinchart

