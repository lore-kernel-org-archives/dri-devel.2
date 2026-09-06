Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD41FC624DB
	for <dri-devel@archiver.kernel.org>; Sun,  6 Sep 2026 01:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 676E210E067;
	Sun,  6 Sep 2026 01:34:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="L46D8KSs";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0011510E093
 for <dri-devel@lists.freedesktop.org>; Sun,  6 Sep 2026 01:34:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 39BFF43778;
 Sun,  6 Sep 2026 01:34:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 059C9C2BCFA;
 Sun,  6 Sep 2026 01:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1788658476;
 bh=d9wUPYj1fcxFp3gWDGtuJ2V5k7ePRRGkBzD7EqpEMCE=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
 b=L46D8KSsPQ6m5RQJrGzyVbUOq5P33crp9YIgw61zIpSiF3SJPONOe+eR6eUzpBFGf
 zsndtsZ3wQa+g4u52bi55E1d2ehoAkeFhV4jT4htV32QY8Vqbn48Xw3/AoZpqBKIt0
 HF8URTVCzJOMG26l6VttxDEtsceUXJfY6aoqwLQ+M+6GJ70CkEKShRx/G6I5fw2UG4
 jUXAPViFpw+hpRV9bb2v0jBb2GTNnO/OwIrqTQfp4sKJXuDK2uErNeyEPs7mj25n3X
 BbMzr0+je5pIftnTL3yxJjamT+eaxRUZA88F+YSgqNB8n7BF2Gst0AlDDa5Dy8BjrQ
 Xa41deH5cFS6Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id DAA58C624DB;
 Sun,  6 Sep 2026 01:34:35 +0000 (UTC)
From: Ryan Brue via B4 Relay <devnull+ryanbrue.dev.gmail.com@kernel.org>
Date: Sat, 05 Sep 2026 20:34:34 -0500
Subject: [PATCH 1/2] dt-bindings: display: panel: add Novatek NT51021
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260905-rbrue-drm-panel-add-novatek-nt51021-v1-1-939f59e89fc9@gmail.com>
References: <20260905-rbrue-drm-panel-add-novatek-nt51021-v1-0-939f59e89fc9@gmail.com>
In-Reply-To: <20260905-rbrue-drm-panel-add-novatek-nt51021-v1-0-939f59e89fc9@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, Ryan Brue <ryanbrue.dev@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788658475; l=3260;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=OucYPSbkdRKOXX71YqLEkAw3zmqM74CD8sy3ta2ahmU=;
 b=PO5JgYFHpu6BgI2fM/vrLk1wZB4hZ/5rErx2tt+ZqYUIvvlMj4yP4Y3HrLUwAg2A2X3qX421g
 G7XEq9T+aibC7+rL8hQK6/c9TtzLqO+v9sA48rNGBPQuNi3i5JUuimW
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=
X-Endpoint-Received: by B4 Relay for ryanbrue.dev@gmail.com/20260906 with
 auth_id=1007
X-Original-From: Ryan Brue <ryanbrue.dev@gmail.com>
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
Reply-To: ryanbrue.dev@gmail.com
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

From: Ryan Brue <ryanbrue.dev@gmail.com>

The Novatek NT51021 is a DSI panel controller driving 1200x1920 WUXGA
panels over four lanes in video mode. It is fitted in the Amazon Fire HD 10
(2017), on a module carrying BOE glass.

The controller has no readable panel identity. MediaTek's LCM framework
identifies panels through a .compare_id callback and the vendor's driver
for this one leaves it unset, and the glass part number is not recorded
anywhere in the vendor tree -- it names the module only "BOE". I had the
compatible name the module after the board it ships in, the way
xiaomi,elish-boe-nt36523 and lenovo,j606f-boe-nt36523w do for this
situation.

The vendor's bootloader and kernel both carry a second register sequence
for Innolux glass, selected from two board ID straps, so a second module
exists as far as the vendor firmware is concerned. I didn't have an
Innolux unit to test with, and I don't know its part number, so it is not
described here. Naming the glass in the compatible leaves room for it as
a second compatible should someone have the hardware and the need.

The rest is panel-common: a power supply, a reset GPIO, an optional
backlight and the DSI port.

Assisted-by: LLM
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
---
 .../bindings/display/panel/novatek,nt51021.yaml    | 65 ++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
new file mode 100644
index 000000000000..ee3adc88ec9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt51021.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT51021 based 1200x1920 DSI display panels
+
+maintainers:
+  - Ryan Brue <ryanbrue.dev@gmail.com>
+
+description:
+  The Novatek NT51021 is a DSI panel controller driving 1200x1920 WUXGA
+  panels over four lanes in video mode. The controller carries no readable
+  panel identity, so each panel module it is fitted to needs its own
+  compatible naming the module.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: amazon,suez-boe-nt51021
+      - const: novatek,nt51021
+
+  reg:
+    maxItems: 1
+
+  power-supply: true
+  reset-gpios: true
+  backlight: true
+  port: true
+
+required:
+  - compatible
+  - reg
+  - power-supply
+  - reset-gpios
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "amazon,suez-boe-nt51021", "novatek,nt51021";
+            reg = <0>;
+            backlight = <&backlight_lcd>;
+            power-supply = <&vgp6>;
+            reset-gpios = <&pio 105 GPIO_ACTIVE_LOW>;
+
+            port {
+                endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };

-- 
2.55.0


