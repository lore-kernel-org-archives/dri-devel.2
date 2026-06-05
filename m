Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D903CCD6E7C
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 18:27:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5093110E741;
	Fri,  5 Jun 2026 18:27:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="T0OjfAo5";
	dkim-atps=neutral
Received: from mail-244123.protonmail.ch (mail-244123.protonmail.ch
 [109.224.244.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A01A010E741
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 18:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780684053; x=1780943253;
 bh=tx75P+P7ozafjtRnuFZTBl8obCQW842DsBNmRgarzJE=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=T0OjfAo5HDT1ZU6MHnwOLpwxFQdZG0ZnMUVKlar7qQOEYkFYhnkIZEN6Ww5RSQb1x
 /PQ4RjiqSkKwcjW3LkGA46gytFLbXn7F4WFEycRhQfO3fecO47Oa/2MwVikBGI7qQm
 viQdiFll4zouhTeLYgzSJFmtUGaAEMA53sM89XBhaDqUPpQXv3tuh19SEbVbfD/4/a
 aYLi8AAUSu9tKfZ+MI4VbZYgdrvzdGg++49pE6S5Na+aOlrkAIrrsGts5MB+rIGji0
 AZJBQQC5xrTDInZI2uneQmC4cUHwXGozHNiHaYqjudcE3BaH+WTpga1Vz/XNjrUy02
 3FGCnYiKLCYcQ==
Date: Fri, 05 Jun 2026 18:27:28 +0000
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
From: Alexander Koskovich <akoskovich@pm.me>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alexander Koskovich <akoskovich@pm.me>
Subject: [PATCH v2 1/2] dt-bindings: display: panel: Document Raydium RM69220
 DDIC
Message-ID: <20260605-asteroids-panel-support-v2-1-44b96c6eca91@pm.me>
In-Reply-To: <20260605-asteroids-panel-support-v2-0-44b96c6eca91@pm.me>
References: <20260605-asteroids-panel-support-v2-0-44b96c6eca91@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 92ce6ad62654657bc34b31db8652216b856de177
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Document the Raydium RM69220 DDIC and the BOE BF068MWM-TD0 6.77"
1080x2392 AMOLED display panel used in the Nothing Phone (3a).

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 .../bindings/display/panel/raydium,rm69220.yaml    | 74 ++++++++++++++++++=
++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/raydium,rm6922=
0.yaml b/Documentation/devicetree/bindings/display/panel/raydium,rm69220.ya=
ml
new file mode 100644
index 000000000000..7423b192d892
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raydium,rm69220.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Raydium RM69220 based MIPI-DSI panels
+
+maintainers:
+  - Alexander Koskovich <akoskovich@pm.me>
+
+description:
+  The Raydium RM69220 is a generic DSI Panel IC used to control
+  AMOLED panels.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - boe,bf068mwm-td0
+      - const: raydium,rm69220
+
+  reg:
+    maxItems: 1
+
+  dvdd-supply:
+    description: Digital voltage rail
+
+  vci-supply:
+    description: Analog voltage rail
+
+  vddio-supply:
+    description: I/O voltage rail
+
+required:
+  - compatible
+  - dvdd-supply
+  - port
+  - reg
+  - reset-gpios
+  - vci-supply
+  - vddio-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    dsi {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        panel@0 {
+            compatible =3D "boe,bf068mwm-td0", "raydium,rm69220";
+            reg =3D <0>;
+
+            reset-gpios =3D <&tlmm 12 GPIO_ACTIVE_LOW>;
+            dvdd-supply =3D <&vreg_oled_dvdd_1p8>;
+            vci-supply =3D <&vreg_l19b>;
+            vddio-supply =3D <&vreg_l9b>;
+
+            port {
+                panel_in_0: endpoint {
+                    remote-endpoint =3D <&dsi0_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index c9f2780b2d31..ca2417d9d238 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8354,6 +8354,11 @@ S:=09Maintained
 F:=09Documentation/devicetree/bindings/display/panel/raydium,rm67191.yaml
 F:=09drivers/gpu/drm/panel/panel-raydium-rm67191.c
=20
+DRM DRIVER FOR RAYDIUM RM69220 PANELS
+M:=09Alexander Koskovich <akoskovich@pm.me>
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/display/panel/raydium,rm69220.yaml
+
 DRM DRIVER FOR SAMSUNG DB7430 PANELS
 M:=09Linus Walleij <linusw@kernel.org>
 S:=09Maintained

--=20
2.53.0


