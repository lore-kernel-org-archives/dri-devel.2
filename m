Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68237CA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:41:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B44110EA96;
	Sun,  4 Oct 2026 16:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MUKNs7gK";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67ABE10EA90
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:41:42 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-4a0280d4f56so6324835e9.2
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791132101; x=1791736901; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1oRhn0Uw3oG9VGKyBezr/4J0WUv4cf3LeMydSJnIiuw=;
 b=MUKNs7gKOWwGhAfaGO7tUif/5pruLXXTUYexTGsSqqj2e0ahqH0oNsEVLDynKSAg/r
 73dUZBclliMLLk2NEjggyi1we7A7eoStIt9xrS5v04t8YRX7UzTeCmXQwyJUkBfX3XFI
 wIX2pfKAeDiLw3Vq/sLMA2PwvyLDB431+4qhdNYW7ZTg6bbolsZfJg2NJvBXPp9NtkvZ
 vShCt39al43AKrrGKGbxfN/jLTYuNrBiSjsfrIxOahs0TJpme87eOiA1u0oCaIUn+Oi4
 PliESBoojjymJwItJi7OrR0cVC7USeUobmPCyoOKiJgmp1AshKNpEJhh0NMsNzZkE2rD
 E6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132101; x=1791736901;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1oRhn0Uw3oG9VGKyBezr/4J0WUv4cf3LeMydSJnIiuw=;
 b=zpSz34TJPjtWlRDvl4cqShvXEL7B6g4KBWgRUV7O4qGwQzE3y7D08AzDSAB9NxoN+X
 l8olrksOY6fysYP26E8Y3Bj8QtaCsMOw6UM27j+tXg6kI8ebzXlbj4zV7x+7QZR6aBvw
 Svvi3j3g3WM35yrMrMngqSEpCNtgiCIOqh8y4NEgIKJ/rh4A0N3t4s4+hbZcipAgL2R6
 XaQ9X6MV4SqteJ9u7lXrPSyGKy3La5r6j6Br6uYgwE/O4rEUYBeBug6J0MaxrY1AiLlI
 eZwSW6HB/lih3+09iox2voAoMgVecU2l6ii86KOMKlIOGDYPPAJeteZrztbiO51AlFfx
 De0A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwU5Wh0cuxa4J2lszJFSUEwmYjo7EE3bGC2wseJ9aHAAeKcEpdRdomCwqUtU2IbbhbvE1psmdS2VvM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l5FSbRzAwF2Zrt5PI+zeGaXn0EXDCyo1Za0DExj4yFM3sVBEVg
 EJKrdayboD/6BAHglueZj2hP2N2uFbr6AHasIh2UoXGl0UUkPENz7hOH
X-Gm-Gg: AYBFou34kDy3jtkaqN7kVERnQhwcIrIK9AqLS6hZ8dpres+lWAUuYXjOyw9/sJHuz8A
 wc8a2b/1HWkY5i75e7LCy0dt0SU6RzqQ9eO/qMsov10ywAgYYbvoLiJ949QL1Ynzr4lVxba3w4p
 MNwsdkVvxw3MWVIyTquE7Ft+NHyT40N12Rxs41o/4oASkIA/68B3s68FeWHvKMNWBbY1h6xDO5k
 GFQyPzGpDa2kYlGo4vsYt0YFVlB2UAyRGLb4iTJ9zpNnK0uF+5siKRYtxF0+tGbub2OwYFBg/0o
 IV5RT+CbObGORdMzb58UPKSzxDkS7E5pIBc4Q5U+B8LCRhhWk6BWBFv5UNoJZeRqhdLShNLM8In
 TLL4XiDlmrUnu7BUiPliHRD81cbka9oj8k1pwK9RuHdYR/sO0KWG0YM2cgo6f9UIOPOZo/7hl0p
 +oELrkmEGzY6WkWcX+fDYw/bKQXrbVFR2+4eCZvVQqSjyPcPQZqxm2YTZDCJ71eq2JMo3laYiRh
 xP351zVW0iDyEgPZwA=
X-Received: by 2002:a05:600c:6085:b0:49e:6c11:c4fc with SMTP id
 5b1f17b1804b1-4a027575983mr125492155e9.7.1791132100715; 
 Sun, 04 Oct 2026 09:41:40 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f07cdsm18765185f8f.10.2026.10.04.09.41.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:41:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 1/3] dt-bindings: mfd: Document Skyworks AAT2870
Date: Sun,  4 Oct 2026 19:41:19 +0300
Message-ID: <20261004164121.193514-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004164121.193514-1-clamor95@gmail.com>
References: <20261004164121.193514-1-clamor95@gmail.com>
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
index 0000000000000..014678616076f
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
+        minimum: 450
+        maximum: 27900
+        default: 450
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
+                led-max-microamp = <27900>;
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

