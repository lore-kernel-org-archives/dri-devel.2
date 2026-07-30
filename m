Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B38BCC5516E
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 17:38:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C96D10EFC5;
	Thu, 30 Jul 2026 17:38:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hpdi+tKm";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B04BE10E68C
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 17:38:32 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-49557167508so339165e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 10:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785433111; x=1786037911; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PM3BRrh2FNXUCkcSKqT+U8kC/SFlU1y7/LSteg7Tts0=;
 b=hpdi+tKmivosgPJGzc6sOAL9txOw3cHoo5Xzlp/zHmqmmcWp9lkxvJARm6lRBBlJ14
 ZLd0/k0PuW/TyooWbyymeURuLq1M7oCXDCiom6i5MdF/HkEbOxuza9vack2CtjqUq44W
 idOdS9YT18iJfYU5maHoB1e0zrLZVUSOW4pB8EQ6HHGo0+OKt5TXliHBKefzrE8Y9YcM
 H82EH9HcTVI4DVYw2pz2BNUOvJdYhftw8B3URoJ/waqUom1umTWUj9HcbJ+7Ti6XrQ+D
 Asj2s3AxEfVZ2f7FXcjrTmV3L82MPpMTyOMYk/TYcBjmfngiva23IUvzaZvYehk+4MW4
 +ptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785433111; x=1786037911;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PM3BRrh2FNXUCkcSKqT+U8kC/SFlU1y7/LSteg7Tts0=;
 b=cg+BC4+mBipUF9TZkT6LrAZxZULbaoflZB8zbbQEwxA2kBuPh5lIHDmitkpt5IGs+N
 5aY5G8CtWOZ6CiSvPWVRHxBMbyCwU5r0q9nrMp0F/+xH1ioyPYYVUiMotfv3RP2lTU1/
 nhzbP+xcxiaCjC8snIYYgg9jWg4Q0UcaA15mPr4ev620S9FVurN+4bxiY7bOZ6cgatMo
 rbe00T+e36197GOOgt6dfkjIIYCtEz/72Ye4l9971FPVjzgWDgXDc/+yVUwZksK26ELP
 4RVxCBL2Cc1ytFMkBmnuapsrNY95wnjoEjTjHcrN9Cnetq2YzEKWC/G44vRxf/tEE4qx
 IcKA==
X-Gm-Message-State: AOJu0YypyJC+UJvNcd1g5YC/6MBaZQ38j8Lp0yJEYiIULYWawctqnM4b
 cR0aRPiz2OEQJh/JKtK1Vu0pe9C4QyMtaAM+JxBg/x30A3gRWZZ400owVyTnAmgvYcE=
X-Gm-Gg: AR+sD11ZktUkJpqmUvT1IpBHolVSxL+4J46oi5YYaHCEuxwIRkBTw+g/2FlI3L7Ckk4
 LAu7gS7mfFvLsSbuF+6zSQIbxIBSt+Hnad+lbtswZ97tawi1C/4qnoOGptI6JV8EwENlREcBKcZ
 HuG7kG4NXVkdOSd4YoFOnFaiTrBjajPsCxzK8ur9ltsADEPOrzJo2JVHPj798tJyR6iq//b0Bv0
 eboUNCiAdkxrMju15qlL3n9sce4IcjXdTCVEll9lZll3c8E8h06hmubZQqOfuIfrnKCcBz1PBYW
 gFub76zRTqTCo7ApKDNVCYY/wxcycHH4FizDqL1tNtsDZ1bptYXRO4RR0QyqfED9In/YY/ph7GS
 WbiXRwp2Z4nt1RMQazj800H+dA/slRKqSeaiIGQAFMi5hTxkJfDWdP4Oo/FWQkMsZn82D7LmX81
 S5sKjRrMcaxeYH2pFn4Y0X9NTuXI5ZEVgFNz+SpebdANp2kDFuYlg0v8MlWkvLqFzgTW3avAYJ+
 eAzTOwSc8DNkcV1Fns7uWvjsljPW8kIXE+nmMwv4wdhX0HL6Lt2rFWQecJVOozMyfNiWfCkICZD
 mIcvUMCEJjXsuHw9KUEpiUtt6AM=
X-Received: by 2002:a05:600c:e557:10b0:493:f140:c3fb with SMTP id
 5b1f17b1804b1-49800e898e4mr37361575e9.7.1785433110898; 
 Thu, 30 Jul 2026 10:38:30 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49800f0ecd4sm71603455e9.1.2026.07.30.10.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 10:38:30 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: display: Add GlandaGPU binding
Date: Thu, 30 Jul 2026 19:36:41 +0200
Message-ID: <20260730173643.256052-2-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730173643.256052-1-kieweg.leander@gmail.com>
References: <20260730173643.256052-1-kieweg.leander@gmail.com>
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
 .../bindings/display/glanda,gpu.yaml          | 55 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/glanda,gpu.yaml

diff --git a/Documentation/devicetree/bindings/display/glanda,gpu.yaml b/Documentation/devicetree/bindings/display/glanda,gpu.yaml
new file mode 100644
index 000000000..988a30946
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/glanda,gpu.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/glanda,gpu.yaml#
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
+    const: glanda,gpu-1.0
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
+        compatible = "glanda,gpu-1.0";
+        reg = <0xc0000000 0x1000000>;
+        interrupt-parent = <&intc>;
+        interrupts = <GIC_SPI 43 IRQ_TYPE_LEVEL_HIGH>;
+        clocks = <&osc1>;
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index b1af9deac..b8b7a5401 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -666,6 +666,8 @@ patternProperties:
     description: Giantplus Technology Co., Ltd.
   "^gira,.*":
     description: Gira Giersiepen GmbH & Co. KG
+  "^glanda,.*":
+    description: GlandaGPU
   "^glinet,.*":
     description: GL Intelligence, Inc.
   "^globalscale,.*":
-- 
2.43.0

