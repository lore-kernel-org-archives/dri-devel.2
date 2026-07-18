Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 472F3C4452E
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:17:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 586E610E7B3;
	Mon, 20 Jul 2026 07:16:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FDtwiWQu";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55F2610E604
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 21:57:01 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49557167508so2295605e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784411820; x=1785016620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lpxItdTSSRPz8qQrNM+YynkVLo80ONeSs8p2LlFqFRA=;
 b=FDtwiWQuJoUx0kEKcxgFq8xriI+DbzEOtcQHuoXqyMhf/+u/Y6iZB7HU6J6Kyd43Qi
 ljzedKGc5F4bvOvK1IkXBWmRSBY0GxhLEBob50EJyUr0asnEIg1mufFUzZbVArWJyRs6
 s+CTtWbOEl2yP8d+lojs+cKmdscz5fwoc42YvvSzZpAa9t1Z/7kfOkQYOnZDvssKRYHs
 ieFMxw6/9jr6ZygKyQmCYuwPbwXU5fFHNn3bii1kZqFiSLBqsph+lJK8/Qie9xX++8p5
 7tmDg8V1izeZA4bLWnLwTsGAyKAeqtsISrDE+LcOlasxrlX6hqpz4/gfr718OJK7QxXl
 /vOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784411820; x=1785016620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=lpxItdTSSRPz8qQrNM+YynkVLo80ONeSs8p2LlFqFRA=;
 b=lw15zfN6fT/o8+NIABAxJ1kA02jRV6WPtlRsyl/cSkWnkrIrg40vGiP4IpSqM4BK4A
 lPtvBAw+Rfmw73ZuM0/emwoOyfMRH2R4mRvsMYrIfBzKxg711ULstlwf860XLZ2y8oDx
 Ou/zqQZBErsieEGWhSRwgNqPEl0QstXAtWUw1lUlKT2XGukfMTAUS961pRTJjuTPXREE
 3sBEz8pFCgtjkZpHUNrVH0QjhQWiaxmneX7D4xU1AQbombboCoHiES9yEyHNUSnvIn34
 CsvAJjTHBv/k7JCqG9Wo/55jJm+Vw8CRX06Gk+LQaIGMweGf4SX/MAoz9+KXZAr7yjXL
 W9PA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3knWe1i6EiRXGiwGior0DH2somPzhPKoO259eat2fCzxXZjqt2z6tYBtlp3JVK4J3xmXzSu1YJto=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz00nIxCmTetU3qzPMWqybZg2SeUniqu4175DwW82x4925qNH1S
 1aM9F6OPI0cD92rZOS1/C1+HR+tjdzRG131BcUsDa8rKtWYyfuvCTBx+
X-Gm-Gg: AfdE7ckk42LvUl83VyOolbtDpJ1VUGOMem034rtv6ICH24TlaHKWUTWC/GnY7iaClvc
 eANmC1yMPp7vkzl6T/+qmTWmACqT48wDS+Ze4DAyfuvTYL+5qkLj3C1aHTd7Ut/PNpnpf6TRqRX
 4lTAzB6la6LY99vpdRVImojBQbfJUvvNwmHVVVA/54q27LDRWiNwNXhEOpkefwsM2fYgCgEAiKy
 7MqON1TAV3VqpfiVe2LEHpssCPCMYukbd1H21g3R0qaecYysQtPortmnZQFMvPMbYMPc+7Y8p0l
 J9IQoWg+/s+Mrey2QOKORH25TrXnx5hv2uWhnxj1OWGC8ykWLNn+WlAg1UnN8lQZaONhVr8sHDe
 FODe8lwjsfjWolLVCFrsdx/OCWPrx1458qpjUdcIyNDJSCX2fx6/gnC4JUqdfvVKRCMKwqVioJl
 cRHT9jvnTgN5yBpN73sSwzqejwgkJCmHa20IJdrfq+9QYk
X-Received: by 2002:a05:600c:1911:b0:495:4fd4:619b with SMTP id
 5b1f17b1804b1-4954fd46219mr50068585e9.1.1784411819680; 
 Sat, 18 Jul 2026 14:56:59 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4954c0a81f7sm101199835e9.1.2026.07.18.14.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 14:56:59 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-omap@vger.kernel.org,
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH v2 3/3] dt-bindings: leds: backlight: Convert TPS65217 to DT
 schema
Date: Sat, 18 Jul 2026 21:56:32 +0000
Message-ID: <20260718215632.3295049-4-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260718215632.3295049-1-egbostina@gmail.com>
References: <20260718215632.3295049-1-egbostina@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Convert the Texas Instruments TPS65217 bindings to DT schema.

During the conversion, the following updates were made:
- Documented the 'regulators', 'charger' and 'pwrbutton' child nodes,
  which are used by the boards but were missing from the old txt
  binding.
- Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
  and 'ti,pmic-shutdown-controller' properties, which are used by the
  am335x boards and read by the driver.
- Named the regulators 'regulator@[0-6]' to match what the boards use
  instead of the dcdc/ldo node names from the txt binding.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/leds/backlight/ti,tps65217.yaml  | 123 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ----
 2 files changed, 123 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt

diff --git a/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
new file mode 100644
index 000000000000..9586e08f1b1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
@@ -0,0 +1,123 @@
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
+description:
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
+  interrupts:
+    maxItems: 1
+
+  interrupt-controller: true
+
+  "#interrupt-cells":
+    const: 1
+
+  ti,pmic-shutdown-controller:
+    type: boolean
+    description:
+      Set the PMIC to shutdown on PWR_EN toggle.
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
+    required:
+      - isel
+      - fdim
+      - default-brightness
+
+  regulators:
+    type: object
+    additionalProperties: false
+    description:
+      List of child nodes that specify the regulator initialization data.
+      Not all regulators for the given device need to be present.
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^regulator@[0-6]$":
+        type: object
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+        properties:
+          reg:
+            maxItems: 1
+
+          regulator-compatible:
+            $ref: /schemas/types.yaml#/definitions/string
+
+  charger:
+    $ref: /schemas/power/supply/tps65217-charger.yaml#
+
+  pwrbutton:
+    $ref: /schemas/input/ti,tps65217-pwrbutton.yaml#
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
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

