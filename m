Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F213C982FE
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:17:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5663D10E35D;
	Tue, 22 Sep 2026 06:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="RLLLsB9r";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80A410E65E
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:In-Reply-To:References:Subject:From:
 Reply-To:Content-ID:Content-Description;
 bh=AwsqmmNGM1CwkfnwhjdwYP4bj/OynYd8p0qPRgSwWUk=; t=1790057854; x=1791267454; 
 b=RLLLsB9rZtJ766q33vuGaL/ke8+AxUwBgmi+IXSOUY/s/hVxMqlspr1VCBQsqv+UPaQ0lvGeiLB
 xU38txLYyHlZvOI1EB4v82LFrq0bp6w2dkrSvyF0VPIJZlambkusNCyvhaa1ktBtLSb2j2mNbu/e7
 XgejaVDN0NFKnUKjY/k5MLhYccN6YMy+8mYn13UIsMy2PxolXVq+fvJul4L7SdtgX7XqOGH0965Wt
 2Z6yL857yBQ+r5h0RrYj7SkseYAzTLnclZzZw/v7ZTToj1/T1StjxWZQoAWQ+i1qkUwIMg5ezl/ir
 DLfPNbnNu3tAXbmDDVzD6BjyvZmRF+TcaZSA==;
From: Andreas Kemnade <andreas@kemnade.info>
Date: Tue, 22 Sep 2026 08:16:58 +0200
Subject: [PATCH RFC 1/9] dt-bindings: display: panel: Add panel for Epson
 Moverio BT-200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260922-b2-panel-via-bridge-v1-1-45ff36b364cf@kemnade.info>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1702; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=sN0jHjhiKPr+hku2Fc2l8CjScf+8Lhcf3qtojt/qNiQ=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBP6cuLjH32J65lfquB/cqbhhouTOW+cPpHqOdVv+
 2X2XKGFHaUsDGJcDLJiiiy/rBXcPqk8yw2eGmEPM4eVCWQIAxenAEwkZzbDX8EXm7Ma/I4c2n8j
 yfXl5olaq6+2bl236/Wuq+1e77a/eB/O8D/s8p427Xmf9x7bq3LnSvnv2DNxewW5b1xaFlH6I12
 oqoIZAA==
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

The Epson Moverio BT200 has two DPI panels with SPI control
input in its glasses. The chip is unknown and not feasible to
non-destructively find out more, so just add a more generic
compatible.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 .../bindings/display/panel/epson,panel-bt200.yaml  | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/epson,panel-bt200.yaml b/Documentation/devicetree/bindings/display/panel/epson,panel-bt200.yaml
new file mode 100644
index 000000000000..b3ea09d194aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/epson,panel-bt200.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/epson,panel-bt200.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Panels of the Epson Moverio BT-200 head unit
+
+maintainers:
+  - Andreas Kemnade <andreas@kemnade.info>
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: epson,panel-bt200
+
+  reg:
+    const: 0
+
+required:
+  - compatible
+  - port
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel: panel@0 {
+            compatible = "epson,panel-bt200";
+            reg = <0>;
+
+            port {
+                lcd_in: endpoint {
+                    remote-endpoint = <&dpi_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.47.3

