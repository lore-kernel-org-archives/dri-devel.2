Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF9C982E6
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 19:40:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69C7D10E1FA;
	Sun, 20 Sep 2026 19:40:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gcvss+Pd";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6CF010E1FA
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:39:52 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49b912e4b11so11498025e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 12:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789933191; x=1790537991; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JwS6OKYxBk4f3QV8i+ppCjdL02P7CqhhlR3ok5XoZI0=;
 b=gcvss+Pdr2f+lGn/8wSY37PWF18muyVktK02nWRA8J3+O5FR1mJR/Vng220WE8eQqx
 WS3VScjaC+G9aoF9EeZArrOoUWp+vriIPc3ZgtTuyc2XOh2JMXGdYE3A8q12MvvNMeG5
 tNDfCoHg1m3v11u19M83251bzS64nlaB/deJdb/BxVkdukn5qbcrVs691ZoHEBW99Js1
 UY7Yd6mlqUx1BCh5M/CTlosg2mPyIPtChbNgaZDmA157BHN+Uid8HZ8GTwS62dMh0yD9
 seSFNdFuKfBNhHFtDTfYV2f+IYnJ6742082BuYHTjz4bhlBgREOZzWgz/nhF9Am6TTll
 Eq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789933191; x=1790537991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JwS6OKYxBk4f3QV8i+ppCjdL02P7CqhhlR3ok5XoZI0=;
 b=yiNa0IGFVMrwxmRSPMAWS03diti+xP+99WuuPm+JB5Lr0xbi1MiETNk860XTIyySA2
 8+OFCPc3Od7alrJJi3nUkJYf0Bw0troKjrJtReZtwJcC2MYYB3LLnlNF+rHvvEuaeH9F
 9gKSDc/5i2PcCIe9J9UtBXVtilwZUdrqdj2iyBSc4QjB5WRWucsVcIOob9gM2ZROyX0T
 l8dg8SLCO1HRX38WSgKDaVBtYFcMdVOOfMy92zdKCxosX/VhWmGoEICIseu9ZM9+bvPE
 cjEfh6B2CfalFMDFej7K7Zd4nybzDCebbBWZYfZ/LYXPjXvgH185Uf3FqxhABNdOfBWu
 T4Fw==
X-Gm-Message-State: AFuF++l+FVTri/WUOVwgAhlY1kVWf7+KiZxYOVoocE13k9O37cBaLbuz
 6zMBupygmqeca6sPmN04EEUzGahNT6gEG07ijg0OUd7bKhVhOxuz5hcrOdP2+Ai/
X-Gm-Gg: AYBFou2ktWAu9zPOU/dp6gVw4z/hZSVL91mYXVLc4CjB9zRkCy2EwuHxwE9EA465gCB
 9nDGrMzLuDEz619wURPTmyC4a20kF8ZgLepQCeRAog7E25zYN6rLLD/WeAgJ+RqBMr53ORAYzZM
 1F9BVtfBwx0YIkl6nuWGRggPTm1ddpdF3YEQEbovDIyGzI/dz8cpbT0lZz1ntBrYF7gv0CW4Y7P
 3FvPDN7UZnnbVmP8oAUoo5kbERj0MiVKkQk2Uh7zC6D3WOebHW8gqCrUGyuid2aV1pz2JXlBj+u
 n83/QKyI8c8YAKV0zGdUGZSW6dEkJg+8YOwtvM7YPhBckRpFredmuGQ9/ikcXv38sD0E+sKiAwQ
 xeqe9qt9rv9fGBY7CtsPvms16RSqUNCtl7BNOmtf5lzmTaKjzG4BZqM5KGX9GTwIiA6H8IOOmK/
 5gS+elLpUrlywWCuleEZRwo4Ho1NX3tEa7PXfOZ9s0omngujREcVgvgWQ12EvZwUKMyK7/wkxOL
 8fZZHXCpWeo1YZeZC8NMZW/RFa/Gxz7gBHTqbSSrkRVy22FxaDXXRhKAfVywXFI5ecjbn0CuMFQ
 zccVw69oLSctAoOQqUCS7uiow8KEh13JsjQ5
X-Received: by 2002:a05:600c:3b8a:b0:49d:1d6a:4cfb with SMTP id
 5b1f17b1804b1-49fc56db759mr161874135e9.1.1789933191119; 
 Sun, 20 Sep 2026 12:39:51 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc56aab7csm168250455e9.1.2026.09.20.12.39.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 12:39:50 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v5 1/2] dt-bindings: display: Add GlandaGPU binding
Date: Sun, 20 Sep 2026 21:39:43 +0200
Message-ID: <20260920193944.110983-2-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260920193944.110983-1-kieweg.leander@gmail.com>
References: <20260920193944.110983-1-kieweg.leander@gmail.com>
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
 .../bindings/display/kieweg,gpu.yaml          | 56 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 58 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/kieweg,gpu.yaml

diff --git a/Documentation/devicetree/bindings/display/kieweg,gpu.yaml b/Documentation/devicetree/bindings/display/kieweg,gpu.yaml
new file mode 100644
index 000000000..0ffe34205
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/kieweg,gpu.yaml
@@ -0,0 +1,56 @@
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
+  - interrupts
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

