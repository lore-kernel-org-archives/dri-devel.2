Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 848BECD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:10:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AED310F502;
	Fri, 19 Jun 2026 10:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SOdOMSg6";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47ABF10F501
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:10:31 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-490bb83a3f6so12788375e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 03:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781863830; x=1782468630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xxommcvayRSmRZH5CG3ACXxOwllN7Vo1/cLsPn9rijE=;
 b=SOdOMSg6r2VWJfL8zdbU2xWmIEl2QflLMJ/2+CRLfA127JajQJvnCapC45gqdA36M3
 dCMSY8/Blb+y9qpGireplxP07lcEFAxlox0NdDRmgg0OgHW0UnODliLclkJoLLZvDWWk
 F/3eZmPAghXGuTDdrcVwPksJAqpHG2jLQcwFrcFYf35RHjE/SyC90Bwfz+VMKnTgZdfu
 M6Ic276OZ/EBbbAlFhiBu97C6wR3S7GfJVxe7YNJ6dn9JZNfof0qJeSRdXaV64Bf1/fb
 Jm/koQOZ2WJhFI0SDPS5bETYPasLV/ONNKQidKNVUt/56WVFYpYA894B9T+HH4GzGcEp
 vJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781863830; x=1782468630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=xxommcvayRSmRZH5CG3ACXxOwllN7Vo1/cLsPn9rijE=;
 b=AMH1p7JwmI88wcHBtug65Cx0A+lE0wl7VJ1tQqjcxKnvbWhHvOlOSAeyTDHG2XjDni
 EeW7llbDEWjKy+EOxiEBhlkd/LWAghp4mF7i9Z1ogW7Oky0zjByCMMCw4950JHK6Q5Tt
 Wrr/cqcp7V11K8EUFle7llPAbBh9V3+vestiAN9unrDGpNRzSeAwfusx14+AmPy7l6oX
 F/vZ+x4xX3gXMK1ZZDpRZEMswob0tRxvPmh2TPa9qEQJnYtYvpkfRRAehgweRxqMdyku
 VocFTM0tSH7iimVGBD2BHXY0tZd5+g9dRImyvsx94GpvoUd4df/f8hqytI70S/Y4kUOK
 xtqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/iMQf0rVBUDyHssplWnzpKSddn7Scky5qM/obXee1g0H7xvgtLjBm6T9oqMDkzvktdb1TTgL7mXC4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu3k0fQThVcFmS7BKl90IRMYS1L379xsBD5cD5fYzXiMf54xmF
 dpVNj473AlTpEvxD+O53b095MlJ2Zkfgbehcq2aXLjTWJaxncYb6ZS7h
X-Gm-Gg: AfdE7ckZnPkBCKRA6POl/YKMlXnkIbpc6Cv6cTN0IuX2kKQGL/ldaPaRntKIfcHIqSw
 D7Yecg2M5RF7eip9ysW54dfyj1RxcZxP/YU/7V+BTQc99N9Jl70z1WtKgpFszXtxBlB0/8sAcOs
 2IP9eMBZAIyLUdlDt2Hi8WYdlwCEFngEF340Po9VYhAb+J76wuWOOnvQJrHRca3sbeghsaMrzxo
 Z7A+BzEx7GxH/BtE0Kv5ECG9n0RjMPnx3qZkwm86V68PrxavXPuH1f2fmMKAZbLoJ6nAj3MTArR
 gsqeRi9KKUtW0IFgCfUGktdSSICl2l0NcAx+5rk5+cnPvE+ZH+TndUhNClO3tI9Hzp1UhRM2Xhk
 vVRSw5NDNiGG8olvZV94QuXzuSpdDSaSTvrbTJOXcCvciZpKpDShriBQpjfW61y+BV/+4rdR9Ro
 /ZLcBPx0B93FNTQfvpVw==
X-Received: by 2002:a05:600c:4ec8:b0:490:44eb:c1e0 with SMTP id
 5b1f17b1804b1-4923f57187fmr55703405e9.21.1781863829640; 
 Fri, 19 Jun 2026 03:10:29 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:435:f63f:6fb:bfa4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fcdd08esm34577555e9.0.2026.06.19.03.10.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 03:10:29 -0700 (PDT)
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
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: display: bridge: Document Renesas RZ/G3L
 LVDS encoder
Date: Fri, 19 Jun 2026 11:10:16 +0100
Message-ID: <20260619101026.323633-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260619101026.323633-1-biju.das.jz@bp.renesas.com>
References: <20260619101026.323633-1-biju.das.jz@bp.renesas.com>
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

