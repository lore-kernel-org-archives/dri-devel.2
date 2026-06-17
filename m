Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7C3CD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:32:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1DF10EA52;
	Wed, 17 Jun 2026 14:32:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=reznichenko.net header.i=@reznichenko.net header.b="HSiAZdHm";
	dkim-atps=neutral
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com
 [209.85.214.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 542E610EFED
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 14:32:52 +0000 (UTC)
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2c40397e3caso56773135ad.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 07:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=reznichenko.net; s=google; t=1781706772; x=1782311572;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IPleGNVzng5kdj5FBjzjCj+oEBfrDjQ6l1brBNCmGhw=;
 b=HSiAZdHmyHHXMFTzHSdl/Bs9fCZUhFwyWs/qwpIErODhq13Zk+DnJVEEss94S3KHqQ
 UqztCBH0aupg5GZ9t5ACdLogrpkU6nf2B6LtwqWX9fV9l8TSnMka0aI0auEWM8EvTUgw
 LSIWsTnVznGH+TS1GYh5hNrR9qjeycsC5RS8b9qDYrZYr3i0BNE1nKNq2Lw6qgTwT6/c
 Wfn2Caj/tVG6k5iSjdpseX1EQkDFmDsvMbqM47er0aFJL/R0KzI8k1yZbXAlO994znpg
 F8ZxLTxqjsMCR7x7cKKtgr+fjKS+XcUacJdNRlvw8anEYjnSO4D6s2QOHWHTbqv3/Hdw
 0qzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706772; x=1782311572;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IPleGNVzng5kdj5FBjzjCj+oEBfrDjQ6l1brBNCmGhw=;
 b=Mi2q6SR5p/K6KePug+yJhVX0Vh2DsLf61yLsAfcQHSYk7o0X9ONu403ivJLwD0yIXI
 h+a1OiLHNcS5AivhJUImB4oTorbBXhRpIbGNj935MkBp4yxI5Jz9qG06wVnJAdjrBZUG
 B9hrW/S63lQ2r24gGipHsGcRJ/CqdwKSeP9E2M5J1smYHmKwqqk8XetrOw934iq0LoSR
 7TtM4L0UrARHl/K/aWtODzwLyZMyjKZd4hkwSaYkYcNHYIReK/RLYIUPpwCFl5PshCzT
 Fz/w4YDVa8dvKAnF7EkuC/N2Q5/BB1/a7ql73OK6nsOQICVCvfO8XYiQZQmbC3Tr+nu5
 BZ6w==
X-Gm-Message-State: AOJu0YwoRWWCdTxeD8QSCZiX9RA4offeZxs2TLymeia5AuGm7xS6/zjI
 eLfIIEyH4wP/2gIymvs/XpD+ACYtqsGLYaU8Frh5r7S4lehX9e9m28rVCcfe17TEM2Q=
X-Gm-Gg: AfdE7cmncLfNlZG6aYY2F0/qnvTbkPLK9/ABobZXKCmS5CHloiB/PzPfp4bCTIwb7+r
 n6DIMjHyxszRieQkMOVdbJENbPvAvtloooqUud/t54+g5e+RoaYzDMcPAM4MheceCph07l85rFL
 OtbO9FuTeagef0QgLLjdsTh1tlwrlb4uMpenVp81fiMT0KvpOkGex7yaUUERbuYZGUIF2pnomei
 3vyqUuuXl7QFY5oQ36r2zfkSdJy7XhgfrsWgu8kM2vSWgZIsDC5qnXl3++MOQQq1C2iWqjFAL/S
 khDsIj3P8Z/wSuR+X/IFumi4UiZndvlO5fFRn293P3IUdtE93MQOupAyJcLBoUrO6LRtFXEaZBG
 Lyo9oqlnnMjMydL3jk5BAD8+ZC/n+Ojmrlzsr3RidC6vTmC9m/ZezBL5gi5LNnzPHU2sxQPkwm1
 qrvXxm
X-Received: by 2002:a17:902:d4c6:b0:2c0:a555:80e6 with SMTP id
 d9443c01a7336-2c6bbf8c979mr38353525ad.6.1781706771789; 
 Wed, 17 Jun 2026 07:32:51 -0700 (PDT)
Received: from z440.. ([24.21.231.36]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4327aca78sm176065565ad.54.2026.06.17.07.32.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:32:51 -0700 (PDT)
From: Igor Reznichenko <igor@reznichenko.net>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Manivannan Sadhasivam <mani@kernel.org>, "Kael D'Alcamo" <dev@kael-k.io>,
 Kever Yang <kever.yang@rock-chips.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/2] dt-bindings: display: panel: Add Ilitek ILI9488 panel
 controller
Date: Wed, 17 Jun 2026 07:32:44 -0700
Message-ID: <20260617143245.372182-2-igor@reznichenko.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260617143245.372182-1-igor@reznichenko.net>
References: <20260617143245.372182-1-igor@reznichenko.net>
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

Add binding for the Ilitek ILI9488 panel controller which is found on
the FocusLCDs E35GH-I-MW800-CB MIPI DSI panel. Add "focuslcds" to
vendor-prefixes.yaml as it's a brandname and a website
(https://focuslcds.com/) for Focus Display Solutions, Inc.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Igor Reznichenko <igor@reznichenko.net>
---
 .../display/panel/ilitek,ili9488.yaml         | 63 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
new file mode 100644
index 000000000000..ea7449273022
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/ilitek,ili9488.yaml
@@ -0,0 +1,63 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/ilitek,ili9488.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Ilitek ILI9488 based MIPI-DSI panels
+
+maintainers:
+  - Igor Reznichenko <igor@reznichenko.net>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - focuslcds,e35gh-i-mw800cb
+      - const: ilitek,ili9488
+
+  reg:
+    maxItems: 1
+
+  vci-supply: true
+  iovcc-supply: true
+
+required:
+  - compatible
+  - reg
+  - vci-supply
+  - iovcc-supply
+  - reset-gpios
+  - backlight
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
+            compatible = "focuslcds,e35gh-i-mw800cb", "ilitek,ili9488";
+            reg = <0>;
+            vci-supply = <&reg_vci_panel>;
+            iovcc-supply = <&reg_iovcc_panel>;
+            reset-gpios = <&gpio3 6 GPIO_ACTIVE_LOW>;
+            backlight = <&pwm_bl>;
+
+            port {
+                panel_in: endpoint {
+                    remote-endpoint = <&dsi_out>;
+                };
+            };
+        };
+    };
+
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 6d742a317642..db0dc4b44ed5 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -602,6 +602,8 @@ patternProperties:
     description: Flipkart Inc.
   "^focaltech,.*":
     description: FocalTech Systems Co.,Ltd
+  "^focuslcds,.*":
+    description: Focus Display Solutions, Inc.
   "^forlinx,.*":
     description: Baoding Forlinx Embedded Technology Co., Ltd.
   "^foursemi,.*":
-- 
2.43.0

