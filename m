Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E223F8DFF9
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1FF010E0BF;
	Fri, 17 Apr 2026 17:52:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="oGOyl2WF";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 931E710E0BF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 17:52:40 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-488af9fdaa7so6934345e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 10:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776448359; x=1777053159; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JzAtXQjauknA1e9f55ELLhSNN5mP1FnYcEPzv2Nn1ds=;
 b=oGOyl2WFk9w35VwVsktTMrRKDle0xYw0cYLrDkHg6+RywnC9QeLfrnlyEX373ql8ZI
 oIOhbgRqbBBfXFL7aabalBf0Tmnb3EhsDlFjMNmKter0cjl2ttacdNJDwk1aR95T187q
 DOHELmCK4AxnVsSsXudKhHO7M7YP9CxwaJjoH5tlMquQhtYpQw0AMUYRgLIqW1H/Ve95
 OIb4I0fozKu1kcitocxAGiH1dfpn3BGXmkpUfZVhFY32L/ilZESsI6SGIKWqOt8GbPGC
 peqc/PKCeRH4sBrwhma1UqyJyce3tU8saSxn44GAbx/23Y3R2XdAp8yx6KrnXTSx69Hb
 EfAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776448359; x=1777053159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JzAtXQjauknA1e9f55ELLhSNN5mP1FnYcEPzv2Nn1ds=;
 b=LSuDarCEQDjQ0v2j7p6OBq0tS6kDBj01/MeZa8KSbc+7t1xvtp/dZXwnWRRqCCjRc8
 5wz+ko4sQao/aLKeq6liVVSoXNdRYg0HwX1q/iMC0kb7pZVyA0aZQr4hcROjoQY7dk/q
 +Vu0v3B1R6vMeID2Gdnr9ia6SuKIsQc7VfuuEfE1AN9nJX4Mo15l2Io7hDKWd4jLEM38
 qptT+O+miJcmcu/FwYoJpfd1eHrTnHE8D2bkfUQfU0MSuDNEhp5TwDkwHIK6XpcfxsD3
 ZqBIPwRTM91FktqNYSzmKuXEFoZLTjt/LhFdoGdLnSi4CApoSOEYkSDVIyYRhMEOJLLT
 kpNQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9HGD4GljFSyq7mIg9y6Gze8Wtt3Toche2cD+mFosfU3nN2iWhxAv7PGmCO4W70W4N3SaXXO8dM/fc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwAO6mu+ZBZxMssYFNNTjgl/2GZjjp/IA+5j8YxUzWi/MvQ/8lm
 ihUQztfzjAivhu/Y9IaZ6QnJgM3ZpmMqF5j9433hu9BnHKs0pnLaOL9h
X-Gm-Gg: AeBDiesigNK59ehc0HbYSqmf3LIDHYv2pMHC8nUU6j03QhzlSEuEHuez10Zak6MoP9C
 0FjQ7S2pw52TC0H8Wlp7Rbe7jS0cex2RKx7QCu5wLJka9QjHC1biNg95Tjj9ijMeziau3QeknnC
 Xkm/VueiZ1YwPvbS+8hOIzWimJ6noetM1FsgcQQZACOV/Gas9ohtPfns74c5jt3Q8+y+sN/yVe4
 MHbA2xZxVtXDacG6rCWI1Y87oqZZVTits4YYgoLV1ry5bDjEj93URE5uzDYZeOVcrrwetHoCzfX
 mS/6m7s9SipPtte+sqldS11fvQSM6f90Lf5L3GpPK2ySl6RlxJICY+odo5rTMQXB0HQZNRn36sV
 I/SsUKfKSh55QcC1xtlMpZUg8yiPPtugO7LNN4x9+WCAj5txTbtM0xFZ0I7Q7ken5CY5r9PKuo1
 X3srE9ZJQ6jtMSARsoqtMzaOvAmHF16oVVrCzQRyRr
X-Received: by 2002:a05:600c:c084:b0:485:39d1:b4dd with SMTP id
 5b1f17b1804b1-488fb74a495mr42654155e9.10.1776448358967; 
 Fri, 17 Apr 2026 10:52:38 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:528c:590:5bef:9bc8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c773fsm56166535e9.12.2026.04.17.10.52.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:52:38 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 2/3] dt-bindings: display: bridge: Document Renesas RZ/G3L
 LVDS encoder
Date: Fri, 17 Apr 2026 18:52:29 +0100
Message-ID: <20260417175235.224809-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
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
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
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

