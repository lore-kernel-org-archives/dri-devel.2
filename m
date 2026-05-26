Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93335CD5BCF
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:47:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2527B10E52A;
	Tue, 26 May 2026 07:47:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="be8x5jNQ";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B660810E526
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:47:53 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso46486975e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 00:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779781672; x=1780386472; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LBh+uiKYVAcFVXpV57ihLoKRc6InQ9I4cC8J3sHjzn4=;
 b=be8x5jNQPKPGBOKYrhmiBOZht9iEMzyTgwRQggV3Q4/KJvBCEa25W4WWGmFsduMJPO
 TXPoFo6WMX4UIVvYihM3X9enHW8ZKgPAtMFATNBhA7klvKBYNEOWOzgE12z1rFVqRZ39
 bgFoGwfOKyZm+7kyklX8Xts0VKb10RDldMplQq5DuJPIUPmob30cIIUbfb/K0GRp0eaj
 8xMsWlSSBdy+gI9H8zFt5svNasNCx6RfnnNSDQQhriB1ApdyI4eAHISg4pZDcMxlgNNu
 jpLYcQLIdu5Q3hxX4Ol8dtem+QvxQmYllevyCFvuF00mRwLDf7N9AxVwo7LQWx/gcDHK
 ccMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779781672; x=1780386472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LBh+uiKYVAcFVXpV57ihLoKRc6InQ9I4cC8J3sHjzn4=;
 b=HRGaZkZTf8QaejOY16r7vBe68nFlvp+qjsu85bSX9sWqpjiBA9zGAGqjv3OgyeMreb
 4dr3VfZEV9nzgcSnPLrlnd7s0hdYDZGRjhNElmdfVPY2IgZ9Wahlt74TMc9j+GI7pLUs
 Yir5xub55D/lkokQIGrhl+lCsu7iBulHQmGeM0Jte7Rj+bScUbqlVbwiI2hmNlASBBAu
 Yo/692UnfKhnS+tbwUsf46zIJhN6rtjAU9/nD6HJ4qRKqcNtwcrlirX++nKdk5YkdNEF
 Q+yTBHHlWw/M85iJjGyR2sOALHeR7E/PY/F+dsoTjuG/Tme0Sb11pDksxlbSxPtrrX21
 jHZg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+y3JlBk+WLbCH1MGfiLHlDzASu7TivlfNnLBxfFSj6qOfx6h9MN92DIwk2EsAf80/c0FUQzO/Va2g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZXIn2O5MqHcyU+m8asrx9sWE1pB2IPuB52UOBxIsSg5PdxwcC
 T5RkfZpvMcb/m3Z01BN1tILLxz19CJcJu0YdHnlUU2IXaZgycdN1P7/2
X-Gm-Gg: Acq92OHerFdk3Lt5WfMSojPukyWuGgJ3x3uVIhrDpBPsiPaPwKLMk3VtC94GSNtPNM6
 AWJ5pxutrC9u2MAb+TJLzBxctRsnqJSRsnxZRVtqcFGpV/rDYlPo8d52HlUk+Uv0yuj8H+2Kall
 4rzpG2f4dCGO5s0nG9UwQQFnuNnhdxBTpJLOgXqEpbOvPs+M9s1rNphHt6tiwco6W73xLxeleN0
 AP4VA1CEmRVN+ieDPKAqXQlTD7Hy1dDUjh/j1QjIdG50D7EKkYGeEhSKSdES4TPrFinANe/aQlV
 92WDq53tlyAjfTNEJRLpkavH/g4XdEzxkZ7NlMdYLt56Bu/V4o9wuqKFOBXOnE9mNYPfkeAW5Jm
 rPKUiOCAtpMn+NtkteArrkKHyu8tFIpu6b+wFU63rnlGlYw611eaa6m1P2ypgyxWXJrNlGc7f3V
 RFETySygtoqljzIlgF6MDiLIvBTXslURxgUvnRfdfn0S/Y4jXJQyuxqiidCBs=
X-Received: by 2002:a05:600c:470e:b0:489:1cd2:610a with SMTP id
 5b1f17b1804b1-490426aa413mr288737895e9.9.1779781671902; 
 Tue, 26 May 2026 00:47:51 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a700:7301:c204:f511:e9bc:10b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428d63f8sm102848155e9.18.2026.05.26.00.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 00:47:51 -0700 (PDT)
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
Subject: [PATCH v3 1/2] dt-bindings: display: bridge: Document Renesas RZ/G3L
 LVDS encoder
Date: Tue, 26 May 2026 08:47:42 +0100
Message-ID: <20260526074746.20371-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260526074746.20371-1-biju.das.jz@bp.renesas.com>
References: <20260526074746.20371-1-biju.das.jz@bp.renesas.com>
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
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v2->v3:
 * Collected tag.
v2->v2[1]:
 * No change.
[1] https://lore.kernel.org/all/20260524195829.960401F000E9@smtp.kernel.org/
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

