Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BDAC44500
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73AF10E692;
	Sat,  4 Jul 2026 09:34:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RI1ol1o8";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D577710E066
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:42 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so14294545e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157681; x=1783762481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9/dzwCtwRsf4jvkojppL8L2pC35nv095p5pFGvFxaFc=;
 b=RI1ol1o8DTLnlICk01VRTKfpXjIXm3Onf13vhMMqXXWUyKGPOPCDCFH1lzopzRJf6a
 /8ryjiW0Dm7TtDfLw0ICctRRjIjLzwjWJmnymL42K4f8FAFOjNUXih4BM3L6jMlIvKl6
 O2q9fCatIBU/WeWqAo0WXsxxa26jDgkXHmfzbpf7xn1/g67GVsNp4Vbww/DDUev7CFDR
 GF2shtMwFthvhvvC9n90GwPKxCo6hHJhDDLgNze5heB8fsb18V7uPJMOqiJy2BQFrjoP
 9cWrhevvji8tN4Qrj/6nIkR/h/uqBIDspWSv58I4PENUqbkkiYN0jdHPi7BvuPqT/rU6
 mC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157681; x=1783762481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9/dzwCtwRsf4jvkojppL8L2pC35nv095p5pFGvFxaFc=;
 b=OMdNloYtOY8kop/VjiE9YRQ1w/v4bwMVDim30lWncD7EkYB+ySa8/ZX7sl7md+XYEn
 JtAXEcnaCQvDEsgMOx6/nKmE/LXGvmx5gHalpq2YQImVmcUeZntgEP8wZp0IvxMdwqRH
 m7eElCleDn3pXkPhDMPNJw/XG+M4t/ZDRn362qHIWpiElQNV1EsoIyVYHXkXmxqTlVZK
 zYp846LXZ7hHDY6lyGuf2rt3oOLiGxthD5feZO74gPt/oiHVO5rcw0/qXpZWBsx7Bnw/
 PzY4a2zg3YmINnXrQFoJVR9ke/VN6te5wRzPn5q29E2txawfSXCZ97hr6KWtBkKnCQhh
 kf1g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8w+ICy+da1N0AkzX3TZQ+FNfJ5So/6tJUrjKVNMcnoZ+OpI8jEs+yGgoIlPGHRyZDMwObRCUFu06g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEEZxMi082BEPY97+pD953sFWPWHoFGKKBdnupK48jnn1mwokU
 sciC7PFoMdbJ/XV32ai8MjAfxmctLsWzEiChMuTUVBgmVh8oMIxuqCms
X-Gm-Gg: AfdE7cmjFnwRSyk6WyD8EIXfI2GQpSktFCeK/9jQ1Kcc3nQuzmXDhejdyiOuufHmNLS
 pWuHn1Ha6/+F9j1b7i1qBGMuUFk3ubpi2PHmOPdKa72QslICTa6tN6Lb4TrLkrIA2s0ZD3xoZVE
 Mx6jWtrwFynlDJrhhWGtPZbUO/2NS/toOtuPYbSJir6a78Y/fVDEPhJ1Pa0YAsTRodhKLkzRCJ3
 NBerh2b/PIwhXr3BKkVCAMh7Qd4r0V/iLdmRRMgG4H128koNlGXQi+M6I5KQxA7kT7FUXLZq+Cj
 79wzXMvvMhOdGyPRsCBYoPGq5yi05VaCRz5CWj2mKgJWhZphc6BSO6B/DLXgxvrbf44n/zf9qAt
 BYMNhej46iHvTo0/30NF/jEGF7p0ue2DBBnM2Psf8/5FQKKB+L8htFCCfmrkB/T4wvm3vFamLFh
 Wrv1l61G+77v6S/aYFt2NZ
X-Received: by 2002:a05:600c:64c7:b0:492:7019:caca with SMTP id
 5b1f17b1804b1-493d11f52f9mr26388245e9.26.1783157681044; 
 Sat, 04 Jul 2026 02:34:41 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:34:40 -0700 (PDT)
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
Subject: [PATCH 09/16] dt-bindings: display: bridge: Document Renesas RZ/G3L
 LVDS encoder
Date: Sat,  4 Jul 2026 10:34:19 +0100
Message-ID: <20260704093433.273672-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
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
v5[1]->v1:
 * No change.
v5 [1] https://lore.kernel.org/all/20260625172359.292631-2-biju.das.jz@bp.renesas.com/#t
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

