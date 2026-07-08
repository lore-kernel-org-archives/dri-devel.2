Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59641C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 07:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5738110F41F;
	Thu,  9 Jul 2026 07:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gCUFlvrM";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6BE910E601
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 12:33:23 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-474303f3c72so422065f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 05:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783514002; x=1784118802; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0nZ45JHYuzQLGUmd70CLEeCtwiQyXvCK/RVBBWky/xc=;
 b=gCUFlvrMOk/RbMt3r9bPXPvyuQ+6apT5ZEJJhAkEAvPRzhER+K74uuqD+kWQ3OM6p5
 6hELa/FgkrUj2JlDePTDtjG6x6u0Y32++apWaYdC9Fh9gBeXXaTC6WV5+4DLlqYRoDR4
 +v/z7bmQJeftPlI5Ho6s++O5UTCGnfS2oC1/JLCEVvT1bvSyU9kR7HwQgWl7o8NLrD7f
 rPacbVgj6p6aTgiRUZsm7AF9dIsqm2ShbmkEGU3nYFkldjdLr1r7CkddZnI0PDJXzZ5X
 jW67jsKjt2R/7C66dBKIBx5C/zd1H+dYxRS3Wdlgw6fsRmR7BuzAFtUJTBtfoaoYmuGn
 kVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783514002; x=1784118802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0nZ45JHYuzQLGUmd70CLEeCtwiQyXvCK/RVBBWky/xc=;
 b=HmH2Js1unK2j9Y4+DkDxf9fe+SixHSfBqi1TC89rp9SbJ6Mk5hGCu08/3xxaj/lqfK
 +dPgN1MPZsX8V8ho7diMoGbaxo5fJ2BcNWP7pJdU4DeK7Ftu3T5LchzICTLvc7uVfHJd
 lSvdToU8CKrp5EumA1g4ObtGoFPlAfa4mC5Y4/m0rakEeoJ7OxR5+2VxIzMqfZGEwSUg
 8eo87/yj4trIbUCM5nIxLZwmM3jGsGIVcCRfcukaOozeUuxvzmNv4yPdNC3PTXT8AwpO
 tlq9Qavd3liQT/mEjgSoCwXlN+mzbjQ2raXc8lmA8heFlKR2+GksfbeOtAYAJ8zBemMx
 7tYQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLRceLIj9ypeU1VbYMnIBwuxgv1Ao3Y2fDcwf2yaNpJgI6lz/DA2x9d/CU9f/kNeMimKt3rpDlnDE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxdN63Lju7VcT7QP42DlPmT9NPLcuoqmo7kJ0ZygX60X914uLLH
 DvF/UAFWeRWU/cpzS+H8UZyTVJYeGSJBP7/HbiNbS4nTPOS4dO5xBdI2
X-Gm-Gg: AfdE7cmKWWReh8hGDf4MUruMVsa6Cm6U3Gqft2JKe3804Zfqdkza0xy+II0UBOh9msv
 YqQtyBufuARtYZH5k08ddVafAiA/MVeDkZ15bzBn23Sgb3+gXjRg6/O6c5VprpMnNSv0hUS/UGA
 camTUrA7xnYphiJuz5sn2rjYI+OCL1HP2WLB38bA9my5YOw5dcvCzI5FqN+AI2gF8/rbfV4lIIy
 e1iD4XAoTe+q3qBvlfeR2wO3aW/Xhs1SoO3DTyV6JeD2DvsYTDVMnJFI13DtPIJKcx9Q4EdHZqK
 qtdRSLUipI6yZHfML849Mlj2aa335+6bEOccsU/zbe3Ks99X7wp1DZFdGP3y7JaFJhISobrCjga
 jpyBWvtnMhTGF+Yxj1aNYB3LEOQg1cI6RbcfBNeM1QnCg1Y6ayHdL6yGq6E//QgIjETKBIPIW1l
 IglCIR66CbE0uGBsfrSA/xDmHCCmocVUS3dsZYZ4lJ6cy6Q0Dv1GgXzPU=
X-Received: by 2002:a05:6000:41d0:b0:475:5454:49f2 with SMTP id
 ffacd0b85a97d-47df07c1f26mr2231695f8f.24.1783514002112; 
 Wed, 08 Jul 2026 05:33:22 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.173])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47ad69519c2sm45760242f8f.37.2026.07.08.05.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jul 2026 05:33:21 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Conor Dooley <conor+dt@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Eduard Bostina <egbostina@gmail.com>, Jingoo Han <jingoohan1@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH] dt-bindings: leds: backlight: Convert TPS65217 to DT schema
Date: Wed,  8 Jul 2026 12:33:17 +0000
Message-ID: <20260708123317.1768641-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 09 Jul 2026 07:25:20 +0000
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

Convert the Texas Instruments TPS65217 PMIC bindings to DT schema.

During the conversion, the following updates were made:
- Make the 'backlight' node optional to resolve dtbs_check warnings.
  Some boards declare a bare TPS65217 node without implementing the
  backlight configuration.
- Document the 'isink-en' property in the backlight subnode to resolve
  dtbs_check warnings. This property is used (am335x-guardian.dts)
  to manage the backlight current sinks. It was missing from the old
  txt binding.
- 'additionalProperties: true' is at the top level because the
  TPS65217 node is documented across multiple independent schemas
  matching the same compatible string.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/leds/backlight/ti,tps65217.yaml  | 82 +++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     | 27 ------
 2 files changed, 82 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
new file mode 100644
index 000000000000..07b15cab4b63
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
@@ -0,0 +1,82 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/backlight/ti,tps65217.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TPS65217 family of regulators
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description: |
+  The TPS65217 chip contains a boost converter and current sinks which can be
+  used to drive LEDs for use as backlights.
+
+properties:
+  compatible:
+    const: ti,tps65217
+
+  reg:
+    maxItems: 1
+    description: I2C slave address
+
+  backlight:
+    type: object
+    additionalProperties: false
+    description:
+      Node for specifying WLED1 and WLED2 lines in TPS65217.
+
+    properties:
+      isel:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [1, 2]
+        description: |
+          Selection bit. Valid values:
+            1 - ISEL1 (low-level)
+            2 - ISEL2 (high-level)
+
+      fdim:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [100, 200, 500, 1000]
+        description:
+          PWM dimming frequency in Hz.
+
+      default-brightness:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        minimum: 0
+        maximum: 100
+
+      isink-en:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Enable backlight current sinks.
+
+    required:
+      - isel
+      - fdim
+      - default-brightness
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: true
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        tps@24 {
+            reg = <0x24>;
+            compatible = "ti,tps65217";
+
+            backlight {
+                isel = <1>;   /* 1 - ISET1, 2 ISET2 */
+                fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
+                default-brightness = <50>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt b/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
deleted file mode 100644
index 5fb9279ac287..000000000000
--- a/Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
+++ /dev/null
@@ -1,27 +0,0 @@
-TPS65217 family of regulators
-
-The TPS65217 chip contains a boost converter and current sinks which can be
-used to drive LEDs for use as backlights.
-
-Required properties:
-- compatible: "ti,tps65217"
-- reg: I2C slave address
-- backlight: node for specifying WLED1 and WLED2 lines in TPS65217
-- isel: selection bit, valid values: 1 for ISEL1 (low-level) and 2 for ISEL2 (high-level)
-- fdim: PWM dimming frequency, valid values: 100, 200, 500, 1000
-- default-brightness: valid values: 0-100
-
-Each regulator is defined using the standard binding for regulators.
-
-Example:
-
-	tps: tps@24 {
-		reg = <0x24>;
-		compatible = "ti,tps65217";
-		backlight {
-			isel = <1>;  /* 1 - ISET1, 2 ISET2 */
-			fdim = <100>; /* TPS65217_BL_FDIM_100HZ */
-			default-brightness = <50>;
-		};
-	};
-
-- 
2.43.0

