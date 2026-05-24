Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D14CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 19:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 933E110E395;
	Sun, 24 May 2026 19:45:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="btolVOGq";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B91910E170
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 19:45:02 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4903cbfad68so21776565e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 12:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779651901; x=1780256701; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+Y9GPXTLGAUIBWqeRqyMnJLPiEzYcwSV+9lPF8ht34M=;
 b=btolVOGqv4GZS+U0nxngFkuONekBwROeVqpru+Wyc42lZHnkz+a7pZ44Op6CNevPoc
 SuZMMPwJKiLSfeiBoi4CYJIY5AmG4hOhBuPbsMT2WB+9xyxKthP4Cq1FPXpRPCkSOwqA
 Jfn/wwG2ThCegTeq8+OmfyIk54ThI3lvoTngbcEW8ce1/KUDB6HCWTyQ+3LZg6nCWaAy
 lm1bLnSmpRNt+posV75KGvKk/yP6et7nCmBZKhG4XHFQ6y74jmJvMh4/jS0W9jHfKcz7
 HS7UdLjkJ8XH4zACWh/XrHbLOZyIcyLp+nVjtROnj/783PBqtdX2gz/StDu7bgOvWKFZ
 IYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779651901; x=1780256701;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+Y9GPXTLGAUIBWqeRqyMnJLPiEzYcwSV+9lPF8ht34M=;
 b=rt4AqZSn6ZuYYR/h1JhsIYmHjwljOiZBEDl0X8obnItLBZvTESb10x1Fj+ilFfd6RH
 vbbOpbpsKe6TQ8ebVtqVjYGrFiXe9k1zgD3easPOKJ/3gab0RsLIl42Z1tLOeiBkk+lC
 Vl2SCJsQ10lZEUCyVrgeUVEEvHfgMZiJH1kTmpE/nIlzYR14YmmCcyEco/Q8ARAjEHRW
 5eS9yIRrjjgn4IJ3ejROt0YAmkrHTINodJDQrU9oQa0TdpErvgZJXrw3a5pOdQlNIBrM
 UX0Ijdpmflw6ZiaTsvxSdEJfpOcmwWxNwZzmLUcMSsMkFWKcE0mwe2WDlGwrT5Fx3r4J
 Kgow==
X-Forwarded-Encrypted: i=1;
 AFNElJ+DqaRpT7zkPQxBdniDCdvYZMNTZifvEk5GjjBtyrD9e11z74caMscnv5FYtxdLXeTeiGscs6gLBiU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCEo9tN6g31OFair03J/fTkgXLfLYV3aM0k4LrTtsnqBueKl96
 tceH7u3T95tSNNZRv5a39EIrOgUO7Et7HfOUHMUsxI4PbjcT9X3BjBrf
X-Gm-Gg: Acq92OEvcsXDvAf6RJnq2ZAsIIvwj534Dhyyown41htIy7BSRWc7c5X8LJpru9ZEh6H
 sojIq48QzuTuxIrwTfKA5c5VRa0POgK3SW6J2iryTl/DjNTSydI1ploNFTeqqJ3ZN+yIMJ/IZCj
 H/at3BYVPYDwpu9nczvN4Bcf5DBSUQK31w+ITUEgPMKM62kFbEx/tIPQNuwOrGGK67b6bb8WD+D
 muFVQVAAGiIdolZAI2kfS7td20AMQPqPlyakncwNcmdR8YeYs/voLHU7wXCfht6gmDHNFXw3H+Q
 0wOEmym/kDrfVbaBuFdVNvPfvDvOhrfRuMovCeCottk+NohR6aayX4AidB3Vdg80vO/h9m8ktNw
 lz6nt1L6uAkNKeLKtyj0URPRgpnd13AFXDf/acZP9Y3AZSeawqcZVqdrf4XC7pFdRLYwlsHvi0F
 rLtxnyfGiAG8QVOXxVSqahb5LpqXgyjbY=
X-Received: by 2002:a05:600c:46cb:b0:48f:e044:927d with SMTP id
 5b1f17b1804b1-49042480f2dmr161584355e9.10.1779651900589; 
 Sun, 24 May 2026 12:45:00 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a700:7301:ae73:a12b:ca55:91be])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042cde62csm68224515e9.32.2026.05.24.12.44.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 12:45:00 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 1/2] dt-bindings: display: bridge: Document Renesas RZ/G3L
 LVDS encoder
Date: Sun, 24 May 2026 20:44:50 +0100
Message-ID: <20260524194457.479681-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260524194457.479681-1-biju.das.jz@bp.renesas.com>
References: <20260524194457.479681-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Document the LVDS encoder IP found on the RZ/G3L SoC. It supports
single-link mode. LVDS and the DSI interface share a peripheral clock and
the MIPI_DSI_PRESET_N reset signal. However, the LVDS module cannot be
used at the same time as MIPI-DSI.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * No change.
v1->v2:
 * Collected tag.
---
 .../bridge/renesas,r9a08g046-lvds.yaml        | 128 ++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
new file mode 100644
index 000000000000..b1f6d020ae7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
@@ -0,0 +1,128 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/bridge/renesas,r9a08g046-lvds.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3L LVDS Encoder
+
+maintainers:
+  - Biju Das <biju.das.jz@bp.renesas.com>
+  - Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
+
+description: |
+  This binding describe the LVDS encoder embedded in the Renesas RZ/G3L
+  SoC. The encoder can operate in LVDS Single-link mode with 4 lanes
+  (Data) + 1 lane (Clock).
+
+properties:
+  compatible:
+    const: renesas,r9a08g046-lvds
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: Peripheral clock
+      - description: PHY clock
+      - description: Dot clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: phyclk
+      - const: dotclk
+
+  resets:
+    items:
+      - description: LVDS_RESET_N
+      - description: MIPI_DSI_PRESET_N
+      - description: MIPI_DSI_CMN_RSTB
+      - description: MIPI_DSI_ARESET_N
+
+  reset-names:
+    items:
+      - const: lvdrst
+      - const: prst
+      - const: rst
+      - const: arst
+
+  power-domains:
+    maxItems: 1
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input channel, directly connected to the Display Unit.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: |
+          Output channel, directly connected to the LVDS panel or bridge.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - ports
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/renesas,r9a08g046-cpg.h>
+
+    lvds-cmn@108a0000 {
+        compatible = "renesas,r9a08g046-lvds-cmn",
+                     "simple-mfd", "syscon";
+        reg = <0x108a0000 0x10000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        lvds0: lvds@10 {
+            compatible = "renesas,r9a08g046-lvds";
+            reg = <0x10 0x8>;
+            clocks = <&cpg CPG_MOD R9A08G046_MIPI_DSI_PCLK>,
+                     <&cpg CPG_MOD R9A08G046_LVDS_PLLCLK>,
+                     <&cpg CPG_MOD R9A08G046_LVDS_CLK_DOT0>;
+            clock-names = "pclk", "phyclk", "dotclk";
+            resets = <&cpg R9A08G046_LVDS_RESET_N>,
+                     <&cpg R9A08G046_MIPI_DSI_PRESET_N>,
+                     <&cpg R9A08G046_MIPI_DSI_CMN_RSTB>,
+                     <&cpg R9A08G046_MIPI_DSI_ARESET_N>;
+            reset-names = "lvdrst", "prst", "rst", "arst";
+            power-domains = <&cpg>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    lvds0_in: endpoint {
+                        remote-endpoint = <&du_out_lvds0>;
+                    };
+                };
+
+                port@1 {
+                    reg = <1>;
+                    lvds0_out: endpoint {
+                        remote-endpoint = <&panel_in>;
+                    };
+                };
+            };
+        };
+    };
+...
-- 
2.43.0

