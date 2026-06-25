Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD040CDE000
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:24:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0B4A10E250;
	Thu, 25 Jun 2026 17:24:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BcLJUuHm";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFE510E259
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 17:24:06 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490b64c8311so1150755e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782408245; x=1783013045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PidaMhOttb9JyteieWoJIjZN6iGRBadvbwWLav79Hos=;
 b=BcLJUuHm6IwJEf2s1yKB/LHCbGgorSTct1MGxM9Bh+wIB/rT+Zqb47mq8VVPP25GGo
 iOEuwKBwNUdAIYf2rhHJXroBr1c9A6QWgvkT91+bWH1BCSmto41beXq44sRElS8BmaDD
 fZqhWvc+KlNoNHrWhB09fSFMcAR/FshCz65LN2b8UK9iH0t7ib0jDOPSDkvkjgxK3Q3E
 IszAD/myyF1VDBP2F8PlCNDdE9/2Bs/XM8Waqd9UzM55Pyoto1ngIc++nXK8pcRYiGFN
 1sHuo0m2I8meR2wVUXNa8RACJUVgwZBWbN5J9fhk/sPK00Ray+zkFRlbLrnJaohkgwIV
 5M8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408245; x=1783013045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PidaMhOttb9JyteieWoJIjZN6iGRBadvbwWLav79Hos=;
 b=Y9wubwL8UNx+/2kEPuSK2UUxCa3dsNrSLNSu3B5WZXjUa0o72veQKHnLUAiKOy9qL0
 b/OiIaoAl2XXVpbRocqvlB7/JRIZnRpGR3hoDOrcy8eSje3oMXy0ThXBXag5KkWu1L6T
 svNr3vPaO38AJaDKUUSnPtJO1OBoLkk2WBl0Oj6qpSF1U6QcRz2hymfO42He2EKZqrzO
 yUsJAQsZJE1Sbmi/E0N+7if3QuerSbQjk/ysKXRipangCCbzxV3IX03NNe+EgzSvt7IR
 4ud8kV6JKxdomzz9eyyfJRHozwUXYftU+AQIEtHy0E+yH3kZImgwLysnO0I1+hholmuy
 pMDg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wHAHLb/3iCjs5RBTxGe3KZ1rxoY8zdHwdFxCRMFHrzk5vy3qkv5GcOtUXTSHLmNrFOlKqpc6FdDA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFF8+mgD8ik+fnir7ao4m9qMgKZfJP9FeY2/gCk7haU6548hAy
 71GtT/fsMdHfFDJLFRJrx9ynSnVOU0DYp2haBgm36pChhvgIrjsi+oHQ
X-Gm-Gg: AfdE7cmBGUxE33Fc723bkBZtRdh0Xnno5GgfbVlu9XoX1eIRHLBkdhkql0oOhjG2coN
 Cixaf4TKOYS2pSjFJ/WzRnqa+FOd4D7JT2QplhvARoKj3w97+v2zoKW+hAFHW8KwP4SnSD/ICe2
 PJoNsDRwniphiC2sCr+QeGnbhoc2zXh5sw2ZyHScCyaoRLdD46Rrxj0RfTFftJJteCMLd1E2Amb
 k4QjIhrYArTbByq0ogMOOx/sAvWT6wVbxbSfDdADol9n0xXiQSHmEdMGtQNhOv4Ebfh73WbTDH9
 R8ol+vrqKo/YaptYECmA4KQymZHXxMrB8eLjLF3tVe2lt9mZu6dxDAzGlvoGBIg610bJHS4v6Wd
 TLLykYrQhskI9QlszmKTXYO7bpo0dWpay2bqLKFvDk/cIJx2XJpcfOYlieRsmp1gx6zBs3hfR9c
 X0sz0eLiIgTHbiwJEogvDeq2ScstK2W1EVaTLNq7CUQBIvWHw=
X-Received: by 2002:a05:600c:810c:b0:492:2ffd:8f8 with SMTP id
 5b1f17b1804b1-49266873f6amr45253485e9.15.1782408244999; 
 Thu, 25 Jun 2026 10:24:04 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:6aa7:b2d:3460:b689])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fd9e77sm11167265e9.4.2026.06.25.10.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:24:04 -0700 (PDT)
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
 Biju Das <biju.das.au@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/2] dt-bindings: display: bridge: Document Renesas RZ/G3L
 LVDS encoder
Date: Thu, 25 Jun 2026 18:23:48 +0100
Message-ID: <20260625172359.292631-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625172359.292631-1-biju.das.jz@bp.renesas.com>
References: <20260625172359.292631-1-biju.das.jz@bp.renesas.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v4->v5:
 * Collected tag.
v3->v4:
 * Dropped the tags as it is a rework dropping parent node that contains
   simple-mfd and syscon.
v2->v3:
 * Collected tag.
v2->v2[1]:
 * No change.
[1] https://lore.kernel.org/all/20260524195829.960401F000E9@smtp.kernel.org/
v1->v2:
 * Collected tag.
---
 .../bridge/renesas,r9a08g046-lvds.yaml        | 120 ++++++++++++++++++
 1 file changed, 120 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml

diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
new file mode 100644
index 000000000000..4cd7b688fbf7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
@@ -0,0 +1,120 @@
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
+  This binding describes the LVDS encoder embedded in the Renesas RZ/G3L
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
+    lvds@108a0000 {
+        compatible = "renesas,r9a08g046-lvds";
+        reg = <0x108a0000 0x10000>;
+        clocks = <&cpg CPG_MOD R9A08G046_MIPI_DSI_PCLK>,
+                 <&cpg CPG_MOD R9A08G046_LVDS_PLLCLK>,
+                 <&cpg CPG_MOD R9A08G046_LVDS_CLK_DOT0>;
+        clock-names = "pclk", "phyclk", "dotclk";
+        resets = <&cpg R9A08G046_LVDS_RESET_N>,
+                 <&cpg R9A08G046_MIPI_DSI_PRESET_N>,
+                 <&cpg R9A08G046_MIPI_DSI_CMN_RSTB>,
+                 <&cpg R9A08G046_MIPI_DSI_ARESET_N>;
+        reset-names = "lvdrst", "prst", "rst", "arst";
+        power-domains = <&cpg>;
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+                lvds0_in: endpoint {
+                    remote-endpoint = <&du_out_lvds0>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+                lvds0_out: endpoint {
+                    remote-endpoint = <&panel_in>;
+                };
+            };
+        };
+    };
+...
-- 
2.43.0

