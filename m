Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F91C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 19:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C501010E57F;
	Mon, 24 Aug 2026 19:54:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WaLlDxW9";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4820910E57F
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 19:54:37 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c16794450aeso567506666b.2
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 12:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787601276; x=1788206076; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d7769R8m5fjpUM/KSgOtTNE43hbaxs0YKNppnGOC6Rk=;
 b=WaLlDxW9FJRjDV7hUHyk9FiAZKc1IHJGv9xZ7sU0Uz0nenyjmvS+gDwf8H62a2o28H
 wfWCz8ear+oek+0mGjfkNEl06L40+Eh672g1St4YQwFo5RKyemp9hYYdwdxgTB/5iPEx
 z5aqm1GIeabl0bazy3zh3JQoCYCPNmE3JqHOG6hyH/+YOY8isg24hcbNLA6shfr2k5V+
 NL33VlRR2zcFQxfllK8J8yBt4I5WcTYuVm6CQqnYXqG3JEtJQsPpbYZWfKk+Lo69IOB+
 oTaaY+lPIQPKM47SXZilzYpSMxKh2oblhtMzCBiBkz0h6sWyfMu4Soo0CgeLAZyDV/o/
 HhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787601276; x=1788206076;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d7769R8m5fjpUM/KSgOtTNE43hbaxs0YKNppnGOC6Rk=;
 b=sXOTV6rM65ErMV8GFyQAz7VP/YlAn3QrveFmc/VkjBRJ4oQoCe0KUX5CbDqsGyOZ6Z
 hMdfW/66eXmbWiA/partRzNg9QwBr5wadGhf56Al7EQ+ezLZt7W2q54Q5yTu0k4qoQW4
 +EtiDNMB7iRVMADqCIW1vCdzu7j017Ooo2DIfCEK+3+UeBk+ManMaEQHt+k8DdmMkNCn
 prVrAJsMVGjgp/95SlqwZiW2sIhQkxLAiF5q885e1U1rCRMHukwWX/uxbx3YY7MF0Dux
 AmgA7jl5+YoMmrsvGnYpb4iSRygCbyXYzRATmFSQUmi0vd4CFscRtLSMKGqu8/BZoB+d
 eNVA==
X-Gm-Message-State: AFuF++k4DDF4oNKhYQiDB9LVB7E4x3+ofa4asQRIv0m0gcrkNcBFInwZ
 W6ZsCr371mo+gSLl27TZxhUiQHDxrnb/4Xc7rW5IwPYl8QpIFfzQsfw0g4PB4hEg
X-Gm-Gg: AR+sD11dXebYu6cjdHvozRGmfmqFrr+bJFLjdzvmp3I//a+5wC8QuqFojPZ4tiS5t6A
 yDu3oDhjKNENYEn7PrFbPM3SuxBk7B4yywf/xHOyeRuyp+ypOQsiJJk2MupwMfGP7bcYF8wJF1M
 Sj0xOQNqyIamhve116VeN8OCq6drtTB00/Eei2YHLBwP7ijVpRb/3MT0MGE/EGclW4gNbfCtN7c
 hFhfXN8GjyPzjjVOQe6OnB5Du6HaarAhhCYc7ToqGbT8lkQhgn90HFP/BZo+jw+/CFzMtJIwaWQ
 rVX7VCuglPzoQCyKvY/r0jE9sNhHTyY12Vd5T3ewEUlDCH+RwM8yaoXrcopTvzpoxNcrYsf+0y8
 +CP28w9p467U7DmUo18/HUXYJnXCc3kaRhlk6BnRPkd8vSaggRK6/7G7MmdZsqZ/Uw0zjIwm5Io
 hcxi913HV7w/5i0hP0YTAzx/p6/caH2hdBqCcgUC0s+N+CsGG03UGOE3w9vFXVIJst5c06xEvm8
 VYJmUSM07+IBWxjfpsgrEIbp6ODvmljQJHbzwqvNeXOvHfx6NlZWUaBzx85gIzg3O1OS9TL4Uhe
 Z8m+KPnuP3ELXePe96uqQDVJbaY=
X-Received: by 2002:a17:907:e1d0:20b0:c20:f864:d480 with SMTP id
 a640c23a62f3a-c246a6559aemr2325229166b.13.1787601275565; 
 Mon, 24 Aug 2026 12:54:35 -0700 (PDT)
Received: from stiangglanda-IdeaPad.. ([85.233.101.104])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a59e025158sm11410217a12.11.2026.08.24.12.54.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 12:54:35 -0700 (PDT)
From: Leander Kieweg <kieweg.leander@gmail.com>
To: dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org
Cc: airlied@gmail.com, simona@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, u.kleine-koenig@baylibre.com,
 Leander Kieweg <kieweg.leander@gmail.com>
Subject: [PATCH v3 1/2] dt-bindings: display: Add GlandaGPU binding
Date: Mon, 24 Aug 2026 21:54:17 +0200
Message-ID: <20260824195418.17707-2-kieweg.leander@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824195418.17707-1-kieweg.leander@gmail.com>
References: <20260824195418.17707-1-kieweg.leander@gmail.com>
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
index b1af9deac..fd2fd5ea2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -666,6 +666,8 @@ patternProperties:
     description: Giantplus Technology Co., Ltd.
   "^gira,.*":
     description: Gira Giersiepen GmbH & Co. KG
+  "^kieweg,.*":
+    description: Leander Kieweg
   "^glinet,.*":
     description: GL Intelligence, Inc.
   "^globalscale,.*":
-- 
2.43.0

