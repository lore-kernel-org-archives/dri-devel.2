Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85D1DCA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 15:46:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD40810E2F1;
	Sun, 11 Oct 2026 15:46:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qeP1/gmn";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F365C10E2F1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 15:46:05 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso661563f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 08:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791733564; x=1792338364; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DIetfJ/7JjHlui5/FdOLhdp/S9WpwXXJl3LTFgmkhgo=;
 b=qeP1/gmnOpIwD1RYLaqG24cyysAeSdIIXvmvEExAozqimTmZqmsp+pLX8+Cy06wxn7
 1DUZfSr551koZPz06ln5BqBELf3g7svq4+2Ri3SUgjjmj4YdBqynu0BQDBDwExQeldnn
 LD0p18D0dyLsYmW7Vy3XSy/rS+4VyNEdB+6BrKg+pcsfIzlpwa7s9kzvZM2IliFtXKj5
 rXE7KW8txmC9EWPnGFP8W4si2EfIDbIIWlo6pWsIgJji9//uCXNftQRQAUqg22PRqW+g
 6b8xztyivVovCWRQkON8Yw/NZWrttMSlIlDHUqc1pr7qnO8P05Uyp4c2as+PyYMQhiaE
 +lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791733564; x=1792338364;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DIetfJ/7JjHlui5/FdOLhdp/S9WpwXXJl3LTFgmkhgo=;
 b=W4R92wUw5TaXJViXShYgqk2oXDoIuD7Zkwoljbsq2ZZBKtLvbzaG7kPAuYpms7fdn2
 pHzt8URtwTka+G9CrNJmY+htejgIz+QXrTPJlreVav6Q9vFqlHkL0VdPGoHikPCL2qbS
 xXdgV48qwWHEzdNkaqLQFenCE9zc57Nur3MZQnz1X8hTqJ1bompJSRbX7c6UObNTcbws
 z3wWGavekIwb6yt5JY5GUs8ZrO/IgmKdgvsTydf/tJPNAVamRVCy6GGcsjdZ/6qrR9cp
 +gfreJv6+OECSW7oBaKYKkYJP1iw3TswlUpoT94oWmw0z3HOHuFCQEmLHBmlXNZKkp3l
 O03Q==
X-Gm-Message-State: AFq9FYLhleX8j87t74WXkohMYfO900QF4WG/Ptk/RaA7tNxsy3QPkKch
 XX2uTRLT7VopBu5YYOKywqQIrlJqajiRGkl5TTvZa/EGy92lwpEteGq98MFTLej/
X-Gm-Gg: AYBFou2TUKq+G0m+MS5al1Mez1RGDnB1QJBccc2ZguNzoj1AmzQYN2+NgqFXzr2dtu4
 j15es9r4oqmzhMSuqrv3PPeQVW4JjgRVQ8suSr1C0BWxoPmUzQ2hgqzi5xQWRi6SiaX7PQER4kq
 wAoqR+SI9LpbNi8KVVZOwav3x25ZR2oJilJ2LPHUxnIJzgv/2+6KfglFJmg2eu8EqKhAwmHNWg3
 s4KKgFZHftZjF+zcGLfiGDaElJaaBGnAFHXq0TrkX+bI3wl3lnuikCVQ4h8yPCdZJU9XERTaCRg
 gy6oYYZjckJMB8JZqrYvE1lDhLzEkHm4GPQq2SdDkQdXK4lSJpsOke/JaQbLHJIx4o/sb3Ad1az
 uFqhjuV3APF6eKbfX4KKVPd8kb0Ms+Re94w24HSV2NA7ZBDcC0PkUCrbrTK99t6gSSMIWLZXCtQ
 yzhGGxKhSXG82Dzh5w5NhCFvKBSmh7dBVBxE8L7+M5KCUXrIHDy9NwWDS3xAnxBNjEbWAGrq3bl
 wwTyOaVtNoa/NDJ4KuFCCUC79a9751zC+SSbVMeo8cDKo1qDm28TtHW9kh04sK7Vsit3nOvoUYr
 NLWtOaP1E+3z7blsfhkHhCaHT1hAOb/X/d/i0/o=
X-Received: by 2002:a05:6000:491c:b0:488:844f:6034 with SMTP id
 ffacd0b85a97d-48dbad474bamr12837525f8f.48.1791733564150; 
 Sun, 11 Oct 2026 08:46:04 -0700 (PDT)
Received: from localhost.localdomain
 ([2a0d:3341:ed52:5c10:2778:2fcf:de1f:bc08])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db93d6069sm13996176f8f.0.2026.10.11.08.46.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 08:46:03 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v6 1/2] dt-bindings: display: Add GlandaGPU binding
Date: Sun, 11 Oct 2026 17:45:55 +0200
Message-ID: <20261011154556.155831-2-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011154556.155831-1-kieweg.leander@gmail.com>
References: <20261011154556.155831-1-kieweg.leander@gmail.com>
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
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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

