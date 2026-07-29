Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15FA9C53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:55:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C7610EC0A;
	Wed, 29 Jul 2026 12:55:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lPhRpbbY";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F2B710EBF8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:39 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4956242332dso7868845e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329738; x=1785934538; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BCw3ZoTpTvwXL1Q/JdFXSpFnxqVRykvwjEQzV4GY3so=;
 b=lPhRpbbYs8bzGAtJiRZWo1bZXH1yv8gZ7IGQaUxl8e68KLHGsAAVAAnVheyxUKBplm
 ofz0sQlno3dOIor1Cfu4EThc5Ib0w5krp5ifYFAamUSpOSaSOO2UvQ9+gC7g6hzFr3ds
 NarHK+tckX7VciScGdYBJOjITyH5deS6JlTCHNcfShzKEqWsS/dsNDEDaDn8lnlR2FuK
 UGO1Ao5XsPE0o1EtvDfFzu3Z+UtAxyMhepO9l7QuB0atOafIFuEW7BcpnOoFg7ucUppY
 1NcQm3295KLLE+Rwfn8tnJnpzJtWIjUP+9r5t88fEoxV+ql+nlEmITKEkaeU4nmt8mxG
 Q+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329738; x=1785934538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=BCw3ZoTpTvwXL1Q/JdFXSpFnxqVRykvwjEQzV4GY3so=;
 b=VRbSRHDQQf/0OHUciKCR3Bp/13SZ7sn1Wy0PHNzgFDFpld7Ef+/XmWz2LX63/gl5Ch
 nUwyzcRXmbLQ5qyZURH7atbt4+w/pIbVZpZEoY/tywkDgHulQzVUc7R0uBA5Ke3CIjye
 aCnW4QvlLC7pma06bqfcm8PhUSzHUJAZy5YWMEP6vaepD1fNBirKB/8SD05k8o+lo5uM
 6fyPUJ5xhfGwjbvkeA7bThG6crrHPndZ+MSsGPRTVLPmoQnIEYOE+TSGxmno/tyFj41n
 pR7ExL1LJNAgwv0Qk8R5xMhLB76WDQeE2CrN1wzhOdw0Xnmwhhejyhpmst4aVo2qTrXD
 y7vA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKMhxlUVPDRL1Z0W7aYHQGn7BxwQMIazRuqu0AwRee6BWgUUNXjETwGzG/NeWIkMKYJ0X+m+FSC3k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwukmQ9o6zp2CPkitDfiW+Du7ImdLwJkQbPjZ0YLg6KPoFTrTEO
 NlYA/9SjDF2jdv0hmakn3Z0eeJJL+JPUpuB6CXy9rMkJkyKVor1jAO3T
X-Gm-Gg: AR+sD13RfTUBe0cVuPAeLiVLJzJBodGjsG9yl5AeM3ybi8H1YeWVd1ffjUiSspPlkAB
 69gM9CKqes9VmIEiyTj/EISKGU2CP1hp2+GbUq/icTxT3ONf/bvYNrwG/2pQcHmpA7qcAksG5gn
 sL/av7Tlhj+Dhq1Ea2Bh+68ZdAR9/0IjrXo09Ekw56yvEov0iH+BGPjJFZeMFXVRfQAg1vETsHQ
 bXEhRzTJ+UymXh2+v51K9yrLiCq64KC4p0DBF1+6h5yE8TGO6V1Ch9LXAU46e/MzDHvEnkNLjhj
 OPTESyyxbAHTFFQlHOOUNBf/lo/ZF9ddmbWBfjjjnMWXXOK+/y20JRl3rPxZB4dJmEnVxd3IMfA
 gdvCvOsNT1a5UHL29/aJMef76oToRzcYvy8/IsNjYoO2B3jUe97viF67M21GoFd2IJHPiGMSrZJ
 KucEfCVxLE7Sj1HSRXn2AXNJXZyx74FRCR3ga5Ip+N2H52FOsdGAufwkyxbyp26JNf2s52w0xag
 l1YkN349xmVoA==
X-Received: by 2002:a05:600c:3e06:b0:495:5b4a:53b7 with SMTP id
 5b1f17b1804b1-496c65906c8mr73830425e9.19.1785329737590; 
 Wed, 29 Jul 2026 05:55:37 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:36 -0700 (PDT)
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
Subject: [PATCH v2 09/16] dt-bindings: display: bridge: Document Renesas
 RZ/G3L LVDS encoder
Date: Wed, 29 Jul 2026 13:55:01 +0100
Message-ID: <20260729125516.230757-10-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
References: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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
v1->v2:
 * No change.
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

