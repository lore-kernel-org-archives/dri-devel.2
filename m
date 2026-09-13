Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3574C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:55:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D086E10EA14;
	Sun, 13 Sep 2026 20:54:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="QgGKLoMG";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="mkTbQsNw";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3836F10E927
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 14:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1789311025; bh=vanJVYCX5tmAfvAO2xkAeWN
 mZni7Fj8bByNJHW2QcjA=; b=QgGKLoMGczKExBN7pK3JEP30WfOAN6/2Jg0Yt9/ckfIUbDTGNN
 DPPm1AM0ER4QFs6mMD4tr0m6jOBsKcMu84z2lrAyeMs+2jSeheOS4RxOOIgr01e/XoDRKsRL8BM
 QoAJluWg7MJTMjYV9aFMYCyllIMGdrPJEr9nEjGFNJ3s6rFyoosagWNBl0LVUCn1GXtcRfOykWS
 eDCvQLXYPuUWn1kvvPY9EvY2RJu4w/2jOidYGmJk1RnCtsD4OSdK5mOYvYlUyFdBIhHTc0rTidR
 j/NLEBbrovIp0KYC3iWHpVeM0uvdGGc56KRH2TP1gqPmvPdFYBMdpp/XjUJ/Qx6/7pg==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=To:Message-Id:Subject:Date:From; t=1789311025; bh=vanJVYCX5tmAfvAO2xkAeWN
 mZni7Fj8bByNJHW2QcjA=; b=mkTbQsNwmq3fhrs1QfrLL/QlJBdLvbnSvAoTSN0bOTVCLYmdTV
 O5rvQrdTpZmSAAQsSh0TIju1qOWaxz3oYEDQ==;
From: Nickolay Goppen <setotau@mainlining.org>
Date: Sun, 13 Sep 2026 17:50:16 +0300
Subject: [PATCH v3 1/3] dt-bindings: display: panel: Add Novatek NT51021
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-qcom-novatek-nt51021-panels-v3-1-266bc5d7e8c9@mainlining.org>
References: <20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org>
In-Reply-To: <20260913-qcom-novatek-nt51021-panels-v3-0-266bc5d7e8c9@mainlining.org>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Nickolay Goppen <setotau@mainlining.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Ryan Brue <ryanbrue.dev@gmail.com>, 
 Alexey Minnekhanov <alexeymin@minlexx.ru>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789311023; l=3462;
 i=setotau@mainlining.org; s=20250815; h=from:subject:message-id;
 bh=fIAzVXn4jZZ9w9eunmhJMQdtSVwjf25c05q0X0unbZ4=;
 b=hp8GWvWSaOHsLyZHiR5rZmPcw/g6lWGMwIs99+kkiIfLzIL4rPwUyG1zCbekkcipTQRwiHlZV
 5n9umwQDFiRBBzLvBykbfnIsKVM8QYhmCvvuRGXtWXtoHhU3w4m8mjF
X-Developer-Key: i=setotau@mainlining.org; a=ed25519;
 pk=Og7YO6LfW+M2QfcJfjaUaXc8oOr5zoK8+4AtX5ICr4o=
X-Mailman-Approved-At: Sun, 13 Sep 2026 20:53:15 +0000
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

Novatek NT51021 is a display driver IC that can drive DSI panel. It
is also present in the BOE TV101WUM-NX0 video mode panel, which is a WUXGA
panel with a resolution of 1200x1920 and 10.1 inches size. It is found in
Xiaomi Mi Pad 4 Plus. Also it's present in the BOE-TV080WUM-NX2 video mode
panel, which also has a resolution of 1200x1920, but 8 inches size. It is
found in Xiaomi Mi Pad 4. And also it's present in the BOE-TV101WUM-NM0.
It's found in Amazon Fire HD 10 (2017).

Add the bindings for display driver for the IC, with support added
for this BOE TV101WUM-NX0 and TV080WUM-NX2 WUXGA video mode panels.

Co-developed-by: Ryan Brue <ryanbrue.dev@gmail.com>
Signed-off-by: Ryan Brue <ryanbrue.dev@gmail.com>
Signed-off-by: Nickolay Goppen <setotau@mainlining.org>
---
 .../bindings/display/panel/novatek,nt51021.yaml    | 87 ++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
new file mode 100644
index 000000000000..e51ef40f9e7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/novatek,nt51021.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/novatek,nt51021.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Novatek NT51021 based DSI display Panels
+
+maintainers:
+  - Nickolay Goppen <setotau@mainlining.org>
+
+description:
+  The NT51021 IC from Novatek is a generic DSI Panel IC used to drive dsi
+  panels.
+  Right now, support is added only for a BOE WUXGA LCD display panels with a
+  resolution of 1200x1920. They are video mode DSI panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - boe,tv101wum-nm0
+          - boe,tv101wum-nx0
+          - boe,tv080wum-nx2
+      - const: novatek,nt51021
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description: phandle of gpio for reset line - This should be 8mA, gpio
+      can be configured using mux, pinctrl, pinctrl-names (active low)
+
+  vdd-supply:
+    description: phandle of the regulator that provides the supply voltage
+      for digital circuits
+
+  avdd-supply:
+    description: phandle of the regulator that provides the supply voltage
+      for analog circuits
+
+  havdd-supply:
+    description: phandle of the regulator that provides the supply voltage
+      for analog circuits
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - avdd-supply
+  - havdd-supply
+  - reset-gpios
+  - port
+
+unevaluatedProperties: false
+
+examples:
+  - |+
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        panel@0 {
+            compatible = "boe,tv101wum-nx0", "novatek,nt51021";
+            reg = <0>;
+            vdd-supply = <&lcd_pwr>;
+            avdd-supply = <&lcd_pwr>;
+            havdd-supply = <&lcd_pwr>;
+
+            backlight = <&i2c_backlight>;
+            reset-gpios = <&tlmm 62 GPIO_ACTIVE_LOW>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...

-- 
2.55.0
