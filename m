Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F407C88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 20:50:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D20A010E9B7;
	Sun, 13 Sep 2026 20:50:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T2WK70Jx";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CCC710E9B5
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 20:50:15 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so5260575e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 13:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789332614; x=1789937414; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ufiy72rg5aTwvEqEphUP2HlQ3RzqokHOttH88+KP0Uk=;
 b=T2WK70JxcPmgRLRNXR9TFZLnVOdNzYoDwQqJ80VoZqgSKww+XpC33/ejl2q9WMCdCo
 1mwfCLACYL4v1BFgFvPBcNmsN2Rckzbyy8LRoDgMN9BDctENx8fVOcpbfV8h4Cim5Dt7
 GgjB0b4s5rftPXGsRNQtaFa3/D0Biy35X6zrWwfA0T+OEd/BQ8URTw7ZyIzVh/st9MNC
 ne+DLIaUA0Zik6h/byrKsox+Cipp0JlpqhTWn+xwCxRIj3c10H+y8usIrhGoeLRmzvo/
 rwbfigqgnjA1WApOPsVGEjXkCDb4gvOwcw3lc4icEq9PqKTyDExlUNPbjkFxtndtDUG1
 KWrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789332614; x=1789937414;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ufiy72rg5aTwvEqEphUP2HlQ3RzqokHOttH88+KP0Uk=;
 b=XDy+U/PaGS9j6FRUX19NDQlc4FA6yJzfUx0fmnbMo7dQ65QEmuCjWc9kYlkh6besp1
 4c6fy8BQf7w09huobr93/sKM+Wk8LrhFZLbUH4V5kZCz2EogCJTKNjV/xHzPaeaLOfQg
 brnrDCT2IAMu05ijY8oNyDsbfbd4p7gdUWat0Cz2peEyl5r2GsrtcgL0Ylvte5R+naA1
 umGyTIFJ/pCTxo2uUJPSzMfIv111YgVHgJELKtV1xB7uhwODP+9S5hcjOIwqSfTdNtZr
 OKYZ4qn8sxEj5ZrE+akb/kkCMtgpouNya5S/tYHuVL/j1LPh8baN1z8o/yqqepfQx922
 lYSg==
X-Gm-Message-State: AFuF++n1YrLExY5VUGJbxdZvSxpZCwUMcObmXDDhXJvSAmJd0onDa9GL
 0+Z/TU4fyf/TSHxTMcWUgpVLgsuwGsIxZYCOBPr8ZO/4p9C+vxjbive91Tlz1MEY
X-Gm-Gg: AYBFou06nQPzZs1ucGIFuxMi/p6vALt7q3R0FNfLhmVFFnNFodVRLmXw5om299MlPl5
 EzZOdDbiF9qzJO+t7gkgdcB5HMaAk4kehCPYAvpziWeH34ZaFkS1rVPQK+YQ4rADqRrZiJ2NtRi
 mpg+UXJYhzviXnMDZAGQdb+eN060u/BumTwjjg0QfrktbqeaK4EHZpqBQDWyQ7aNbajjwQJTs7P
 TdPiMXDYj/+xqRyAssiOQXDCuY4QxO8bd1KoksVUv9QB9fAs8N0i/wLlypw2bWMdy2f9T+F0iYS
 qSlyFFt6zXIbIPkzG+HMC5g3tXuRQih2Xdt7TIjm4hUoHJY8r5NufdaDHQKQ8lQiR/bzfmnSoZj
 cUE5Dfm4zDYD+uCiXywfFB1MZF2YplYUuADSB6VDYiNG5DnbEebrcorWTUFen3GLT4lQ4fRedVk
 j5Phge4O/aJoUmTKqvtuUV7qCNDtwNuOpTMxKG5d7rsplFiH5/pp5q57/4hiG+fIG3YnOsuHxT6
 4+8AWlbOJVZ2S57ar92iHjxMH9XIWxrQbw6TAoDCTDyo8PAPZ0uxu8Lc/0TQc4z4y/89K3rauSv
 Q0/011YMCiPx1to0zTtb1my2kFlXPj0BJQUuug==
X-Received: by 2002:a05:600c:c490:b0:49c:f4e1:4c2d with SMTP id
 5b1f17b1804b1-49e619c0423mr160644645e9.16.1789332613554; 
 Sun, 13 Sep 2026 13:50:13 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e7723d458sm54986345e9.0.2026.09.13.13.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 13:50:13 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: display: Add GlandaGPU binding
Date: Sun, 13 Sep 2026 22:50:06 +0200
Message-ID: <20260913205007.118552-2-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260913205007.118552-1-kieweg.leander@gmail.com>
References: <20260913205007.118552-1-kieweg.leander@gmail.com>
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

Add Device Tree binding documentation for GlandaGPU, a custom
FPGA-based 2D display controller.

For hardware designs and RTL sources, see:
https://github.com/stiangglanda/GlandaGPU

Signed-off-by: Leander Kieweg <kieweg.leander@gmail.com>
---
 .../bindings/display/kieweg,gpu.yaml          | 55 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml

diff --git a/Documentation/devicetree/bindings/display/kieweg,gpu.yaml b/Documentation/devicetree/bindings/display/kieweg,gpu.yaml
new file mode 100644
index 000000000..c0fda8438
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/kieweg,gpu.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/kieweg,gpu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: GlandaGPU 2D Hardware Accelerated Display Controller
+
+maintainers:
+  - Leander Kieweg <kieweg.leander@gmail.com>
+
+description: |
+  GlandaGPU is a custom FPGA soft-IP core providing a simple
+  2D hardware-accelerated drawing engine with a VGA-compatible
+  display output. The register window covers a combined VRAM + MMIO
+  region, with MMIO registers at a fixed offset within it.
+
+  For hardware designs and RTL sources, see:
+  https://github.com/stiangglanda/GlandaGPU
+
+properties:
+  compatible:
+    const: kieweg,gpu-1.0
+
+  reg:
+    maxItems: 1
+    description:
+      Combined VRAM + MMIO register window (VRAM at offset 0,
+      MMIO registers at offset 0x00200000 within this range).
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+    description: Bus and pixel clock provided to the FPGA IP.
+
+required:
+  - compatible
+  - reg
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    gpu@c0000000 {
+        compatible = "kieweg,gpu-1.0";
+        reg = <0xc0000000 0x1000000>;
+        interrupt-parent = <&intc>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&osc1>;
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b1af9deac..3a9d15dd7 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -893,6 +893,8 @@ patternProperties:
     description: Khadas
   "^kiebackpeter,.*":
     description: Kieback & Peter GmbH
+  "^kieweg,.*":
+    description: Leander Kieweg
   "^kinetic,.*":
     description: Kinetic Technologies
   "^kingdisplay,.*":
-- 
2.43.0

