Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AED7F327D9
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:29:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C205610E854;
	Tue, 21 Apr 2026 17:29:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rceA6E4z";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CECE10E900
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:29:18 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so57433365e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792557; x=1777397357; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nXrLm53G+XO/vzNjvyvj6ec5ugmd6jDhCT4ykP0A6dc=;
 b=rceA6E4zG5jROodB98BcS+xA4YZhZOXk8wFmr+3AeZ9P4L3kmeFU2zNMhkpFXDjw5O
 TogIuNZj+Wr8zy1ieZ+sJBIoR9aq2D1YymfM0gX/b8VX/27KhfaEMwbKzgpScU00Vi2M
 pCnwnP3ZcltH6L3eLLYTYsfALgu3/sXfSZW/12KJkGwrHgC0MGmbTQhbe8zg1kh6knQs
 1lfwvOfqmNLuE5lDz2fGxbzwbu0y+tWlnqvkeAklAqcPPGCUckUvW0x4Sf7f0KjpTZSs
 XC1Cxfx2B5Dq8LOVZWDFQP/VkvNT10/Z/SuyJG5XxUs+0KdQARCVi1kaQWVtb2yWTFwi
 E7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792557; x=1777397357;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nXrLm53G+XO/vzNjvyvj6ec5ugmd6jDhCT4ykP0A6dc=;
 b=AdixvfyrbzbKglbyJteG2VusEWQSAQLrZk7GuJ4WxuJytdR3alpbj1VCz4J9CUh2SB
 ynVae50DjqIkEeSCxQNxq9YIpsvcHXLmewWg0hGjVqLa/bElPeLaagm+V9MbLz0Md9Ow
 5uJWrlGS6977T8nIb7BQ38HG0N+qPJP+IPk3irLXil8tBsLj5+HshfEKpcdK2Xi5RS9L
 VRLKYZtl91p/g8fMKNtBW67SVdrmYv4GPSVKTKPJZDiVWe0B+butug7CmfVXTHikiefm
 6UgnANWsZRNSS2yhYq7sIbfjkLyG/ao0ncu9EBcW5fyF5Y4TAfhV2WmU6S3Hkxf+Woqz
 vSxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/g+/XTZp8utnYoPmzsrAo4y0/9IP4nKqtAEmqkA6SCsyVAg2C6ehTWxZPBWARR8SzV3rhtNaASEg0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxG6oAbh8YCMDri1LUdi7W1vAAPcLAZ850d2RDaK00KpF4o1q/o
 bcUc+onIv2o7LqXmjEwDHus3vzc3raTVt23m5ORlL5ZHEEXFZIf1xdfb
X-Gm-Gg: AeBDieuVnKSTzVsBjuHnBtLGJIlkIyPAWM/k/F3kaSBlQy7t5xleSbPABfTO/t3uoEf
 1WA8sKtc7HFhdK9qakizk2lbBaZg11ylQCHz7O1XCthuMGnUw/bdlAn3bPmTIbe2B16DehXYfbt
 XEQ25b5AzefCChTJCpM1BS24raNePl/K9HVx8HP5p57yfz27d9eK/KTo/7K80xjJexrXDJ0mzwX
 YsLgMLBwZUw1hzJNbOSfrjTil32hSlmrASNcjCG8+a0Mwa4mteT/pS1uQTnDOkPO/w0gjZPLPNA
 m44j5F4TPDbl3ORyUMuM83muCp0c2J9vAsSooypZCz8DqC7LZd45IlWuB7uFqr25VKapQcUALSA
 zYRbmbEf1XVvf0CT4i4NBkvkWruvk3gpBzCmsuW0atvbJmzFWIAi01vucPgwII0DIa+Qh3FvvxD
 h34brkQr2hyiiillnro+7E3nTIr/G5GDzdydjQKQgLjeAsMLoHAbc8rMnbHYo=
X-Received: by 2002:a05:600c:8b2e:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-488fb7469b3mr295630145e9.4.1776792556705; 
 Tue, 21 Apr 2026 10:29:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:de57:c37d:677b:c772])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a525a0b1asm57445855e9.2.2026.04.21.10.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:29:16 -0700 (PDT)
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
 Biju Das <biju.das.au@gmail.com>, Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/3] dt-bindings: display: bridge: Document Renesas RZ/G3L
 LVDS encoder
Date: Tue, 21 Apr 2026 18:29:04 +0100
Message-ID: <20260421172910.218497-3-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421172910.218497-1-biju.das.jz@bp.renesas.com>
References: <20260421172910.218497-1-biju.das.jz@bp.renesas.com>
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

