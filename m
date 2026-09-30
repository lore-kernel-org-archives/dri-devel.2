Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4EE3CA5FB1
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A616710F200;
	Wed, 30 Sep 2026 07:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SCqfLf8l";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1339E10F1FC
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:15:27 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso20482715e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790752525; x=1791357325; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bshOoGO6/a2WohdGzsO4t4N/wsEAXwivylUfNFmKjAo=;
 b=SCqfLf8lLxqRhtwryMZUxFAcm9wEgHfGldUKh77L58If6hnGRzOA3LuTPNDbBk4cvq
 geqL7M05rpwKQANWWVd6gqBEDPXQfEVwRVA2pgWf6OmHx2Pkw0hEZl2nW3xD40BvXVkf
 bmoh11ooimr1zkuxMDpaENXl3FNTi4sRI6VmNx+IUio3DHX9xanUt7TaNcZCpsepox4Q
 glb8OGvCZ5a42DETATEkEJagrGzK6P3rkLMy1oOT0goeNnrBnqEzt8UsykMPI13eSXbc
 CT+w+A16+TQ7Nx6AGuEwwnzgJpPZQZgdxBI0V/r4poVflp2IyGG9vSxhCs8ipsR9sJjj
 Qibw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752525; x=1791357325;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bshOoGO6/a2WohdGzsO4t4N/wsEAXwivylUfNFmKjAo=;
 b=jx1bIJhnRFO/ZMtDs6d+EKWmKL2Jezt18XZVjQxKjPRqR3wbucsc9ikP2RJEponUTS
 MxBPG0TUV8rCkduH0c0c7k/y/fI5VD9ripIq+Xn3CDCxkInImiKhAoC6iK5K0H7iK4La
 75IZgkmVO7mmik+kacfI5QFTlQTqI+8Aa2RB5wOg0jSNkz10+IyzUCSwAbbr3ifEhcSx
 +1gWy2/ZLjKqyrDmVH25kDTes46ygmljhnzLmG5J/D0LaBR/NQfU1J1ZRjh3Hlc/vZ1T
 dODbgUL+gCse+EXzxenV8C5vjb6fakfhVcGuYArskftUdwPIfQkjZxHTcaiE8Z2RrxeE
 t1UQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxCSS52JGMQMriVK07jxHfMZw2mHw7le7iMi2P8+EoqEAtbNeK9l66s/ctyBH+dCeEJSW46rmnYzms=@lists.freedesktop.org
X-Gm-Message-State: AFuF++ljVu6jWOTyEd5S4DmynEZO0yULuTRBTJ6dOhBedYlwHxvjlott
 L0Drrzje3JcJIBQ4K/s7+AHoUdjXO9ssGUY9iVIJYsh3V8O9ijBgBrBA
X-Gm-Gg: AYBFou08DTrf1EoEdN6PhHnDy/FuhZx4DdqpG5BafbaRcSInVok71A1EqNjWR5Ntz7w
 QGtj2lSiys/5zjTMjAyiHp+3P5jSPqNXNBXJRKZez27qnu7MwDj6kjzoS93WrCyBuYqL4c9E0Xx
 2yd7Ak+nSeznMSc922z+S1Am14ttTSEPr9IJMkmKv57CS77d9g4stJERuqqF+lnX3PkrxhJCos5
 Fz/4n/ed0zCWzHCXSx1T3eDPrK3S/Xr6UWHeJ80fcmDXkUBHLrwu1cTxocUZq/nsIxxrpSi9oRC
 ggQvQP+q0bYl9zCF8HKQ5jacM23mOCaJg/BPqG5fRUd4QRfN6f592ESsAxHwMWiJXVXOtXb3u50
 pnm11wZD2Sjjw/oHBtSPdN+DmgfQT6HoZFR3LUM4cSUWeE0Ay/Fb+ZlRaW1BSPA79+Cjvv0I0Yk
 PkhguDUJP/y2TEEc837WVaERQWML3AEHhDKk7e69xKOIxF4oLjVoQdUwBpi23pyu9W0wKeVkGQf
 eSayZLkwMvs0TpHRIIoyIpLy0qt/4A=
X-Received: by 2002:a05:600c:1c29:b0:49e:6c11:c4fc with SMTP id
 5b1f17b1804b1-4a01aff0d75mr5571755e9.7.1790752525426; 
 Wed, 30 Sep 2026 00:15:25 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029be7e4sm1256979f8f.12.2026.09.30.00.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:15:24 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v1 1/3] dt-bindings: mfd: Document Skyworks AAT2870
Date: Wed, 30 Sep 2026 10:15:11 +0300
Message-ID: <20260930071513.54697-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930071513.54697-1-clamor95@gmail.com>
References: <20260930071513.54697-1-clamor95@gmail.com>
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

Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lighting
Management Unit.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 .../bindings/leds/skyworks,aat2870.yaml       | 127 ++++++++++++++++++
 1 file changed, 127 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml

diff --git a/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
new file mode 100644
index 0000000000000..6dfcd1fa399ca
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
@@ -0,0 +1,127 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/skyworks,aat2870.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AAT2870 LED Backlight Driver and Multiple LDO Lighting Management Unit
+
+maintainers:
+  - Svyatoslav Ryhel <clamor95@gmail.com>
+
+properties:
+  compatible:
+    const: skyworks,aat2870
+
+  reg:
+    maxItems: 1
+
+  enable-gpios:
+    description: GPIO connected to EN pin.
+    maxItems: 1
+
+  vin-supply:
+    description: Regulator providing power to the "IN" pin.
+
+  backlight:
+    $ref: /schemas/leds/backlight/common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      compatible:
+        const: skyworks,aat2870-backlight
+
+      led-max-microamp:
+        minimum: 450000
+        maximum: 27900000
+        default: 450000
+
+      max-brightness:
+        default: 255
+
+      skyworks,channels:
+        description: layout of active channels, where each bit represents
+          one of 8 channels.
+        $ref: /schemas/types.yaml#/definitions/uint8
+        default: 0xff
+
+    required:
+      - compatible
+
+  regulators:
+    type: object
+    additionalProperties: false
+
+    properties:
+      compatible:
+        const: skyworks,aat2870-regulator
+
+      in-ldo-supply:
+        description: Phandle to parent supply of regulators populated under
+          regulators node. They all share same parent.
+
+    patternProperties:
+      "^(ldo-(a|b|c|d))$":
+        $ref: /schemas/regulator/regulator.yaml#
+        unevaluatedProperties: false
+
+    required:
+      - compatible
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        led-controller@60 {
+            compatible = "skyworks,aat2870";
+            reg = <0x60>;
+
+            enable-gpios = <&gpio 139 GPIO_ACTIVE_HIGH>;
+            vin-supply = <&vdd_3v3_vbat>;
+
+            backlight {
+                compatible = "skyworks,aat2870-backlight";
+
+                skyworks,channels = /bits/ 8 <0xff>;
+                led-max-microamp = <27900000>;
+            };
+
+            regulators {
+                compatible = "skyworks,aat2870-regulator";
+
+                in-ldo-supply = <&vdd_3v3_vbat>;
+
+                ldo-a {
+                    regulator-min-microvolt = <1200000>;
+                    regulator-max-microvolt = <1200000>;
+                };
+
+                ldo-b {
+                    regulator-min-microvolt = <3300000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-always-on;
+                };
+
+                ldo-c {
+                    regulator-min-microvolt = <1800000>;
+                    regulator-max-microvolt = <3300000>;
+                    regulator-boot-on;
+                };
+
+                ldo-d {
+                    regulator-min-microvolt = <2700000>;
+                    regulator-max-microvolt = <2800000>;
+                };
+            };
+        };
+    };
-- 
2.53.0

