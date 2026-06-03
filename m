Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED07FCD6E4A
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 13:03:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43F5A10FDAF;
	Wed,  3 Jun 2026 13:03:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="I14eYEXp";
	dkim-atps=neutral
Received: from mail-43102.protonmail.ch (mail-43102.protonmail.ch
 [185.70.43.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9954B10FDAF
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 13:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780491797; x=1780750997;
 bh=84hOhCwOr6CZp7OHVWmJONnUUJ7lvZP68eI7P+7cmi8=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=I14eYEXpcuHy6ERxq7xJ1A6DhscBaSKIRksP0rLbFGNpDQxweuCPqFDbfYiXAwkCs
 VrsJ+fKjW9W4B1cJ5MeqdYvIUtg+r6AwmhmrXEm0+kmXprIaODSrpSAhhDs5Xh4+8o
 JSBHBl7FlnNjAQK7mabwkSQOqtfxNK2n596zxabSJYZfFnsH6e9f+eb7SnJB9tWBGT
 huZfQcyR8HBgV8s8d3jEBjEl1rkyUpZApdJldoUJFMxJ/J0QhMGQgtuh8koQWOyLS+
 wHqd6783nD91MpDi2Xf7MnMhppQMCWgl95IJy67f+5CRN2c234Q2oU1GSlSjQ3Fd4U
 Jtos4unqZC5bA==
Date: Wed, 03 Jun 2026 13:03:12 +0000
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
Subject: [PATCH 1/2] dt-bindings: display: panel: Document BOE BF068MWM-TD0
Message-ID: <20260603-asteroids-panel-support-v1-1-109c6ac81c8f@pm.me>
In-Reply-To: <20260603-asteroids-panel-support-v1-0-109c6ac81c8f@pm.me>
References: <20260603-asteroids-panel-support-v1-0-109c6ac81c8f@pm.me>
Feedback-ID: 37836894:user:proton
X-Pm-Message-ID: 8e671c51da754ca6e3ac00f4fb63e6c295ed3ca5
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

Document the BOE BF068MWM-TD0 6.77" 1080x2392 AMOLED display panel used
in the Nothing Phone (3a).

Signed-off-by: Alexander Koskovich <akoskovich@pm.me>
---
 .../bindings/display/panel/boe,bf068mwm-td0.yaml   | 77 ++++++++++++++++++=
++++
 MAINTAINERS                                        |  5 ++
 2 files changed, 82 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/boe,bf068mwm-t=
d0.yaml b/Documentation/devicetree/bindings/display/panel/boe,bf068mwm-td0.=
yaml
new file mode 100644
index 000000000000..840ddff709ea
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/boe,bf068mwm-td0.yaml
@@ -0,0 +1,77 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/boe,bf068mwm-td0.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: BOE BF068MWM-TD0 6.77" 1080x2392 AMOLED Panel
+
+maintainers:
+  - Alexander Koskovich <akoskovich@pm.me>
+
+description:
+  This is a 6.77" AMOLED video mode display panel on a MIPI-DSI 4-lane
+  interface.
+
+  The panel also requires ELVDD/ELVSS/ELAVDD rails but these are
+  internally managed by the panel via EL_ON1 (ELAVDD) and EL_ON2
+  (ELVDD/ELVSS) control signals, they are not managed by the platform.
+
+  The driver IC for this panel assembly is an RM69220.
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: boe,bf068mwm-td0
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
+  - reg
+  - reset-gpios
+  - dvdd-supply
+  - vci-supply
+  - vddio-supply
+  - port
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
+            compatible =3D "boe,bf068mwm-td0";
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
index c9f2780b2d31..63d0224bba3b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8000,6 +8000,11 @@ S:=09Maintained
 T:=09git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:=09drivers/gpu/drm/tiny/bochs.c
=20
+DRM DRIVER FOR BOE BF068MWM-TD0 PANELS
+M:=09Alexander Koskovich <akoskovich@pm.me>
+S:=09Maintained
+F:=09Documentation/devicetree/bindings/display/panel/boe,bf068mwm-td0.yaml
+
 DRM DRIVER FOR BOE HIMAX8279D PANELS
 M:=09Jerry Han <hanxu5@huaqin.corp-partner.google.com>
 S:=09Maintained

--=20
2.53.0


