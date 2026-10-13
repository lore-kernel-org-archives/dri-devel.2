Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B268CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:10:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DB8E10E64F;
	Tue, 13 Oct 2026 18:09:59 +0000 (UTC)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 776EF10E67E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:09:48 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48b02b1b4cfso3420417f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791914987; x=1792519787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tz+S9WWYS0rGAJFtNukpledNMiYQuQWNPssN/kQCQUY=;
 b=LxGdnmlIIHh1wM7E4eLuJXLRUJvdc9l6JPEUL8uyr7+0AF6MMVNOhWPHlFAF35ev63
 BCTwy2r3SJjTwopBcsT48PuMZgG+reT07gmCZf0k8Hiu2Vfqj4pLPUosjNb8TjxQcWwL
 DJ9ozh46/gQlmQ7ccsWw7Trt64OoQsaaPn7lYei6augtIM4nHMAEYWCNrS2Z5P/46cm5
 tRzYtvD2hjhs+8drS5BAHtjrlB7vF37+0/zckrMo9L1IvhrfoRZaQNwvgpWUCeRNUkrn
 W1uVKbtj9Vuy0c+orJuH3WQECQiVynkwklxq8X60TeCEjlk5SuWxieYJ0Ma4xpjA8kSP
 SR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791914987; x=1792519787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tz+S9WWYS0rGAJFtNukpledNMiYQuQWNPssN/kQCQUY=;
 b=w0C/F0w4oU5+yrEw3B+8KEvtOBgoS403hC3j4sNUj3D3PMO7vyq5izlV7PiHcMkusU
 LwkGYAMrjptau40WLMY+pv+KghUUxm6YwgN+iKUkg/DyAPosHdnDBopM2vdN3iGhG6Es
 FEpeRqmgaoh1h/TQrWFgdQr1VxX6ep4HOgTTVGN9CGRcnb2uqCAIIKWxPuAKDJ6opQKl
 zTS/6PfAIgCx9mrgUd7azbHTTXM4bfKES61xIX0sMSflglEDRWiXumLbQyygSzJfJB4n
 LeAVJxG877U17hxPEkYQkKroCHlQ3DNBZmXh/+aAxwb55zaqj0lBsFiuM+yPgiIhrO1W
 fYzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxR623QFZuVsusp/cAoJgWi9FX5lqZB07S6TtnhqzmS2Z10Q9oPeyTiKhTBcew4H2oVRMHVMYWLSgk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLogqddkhNcSGj2S5ioHLJ7ia6YjhUB3zAjSx36PIYy2gs+K0VU
 Diw7Dv5Q+2VVO+4H2wyL7rwui9kkTtJkcrvblBTZaVQlTF0bJaxW08gV
X-Gm-Gg: AYBFou2klS9qp0Et6z/YfU3IxyrG+u4ei2gR8Ff8seNE7USVaU5rtMT3APAzo4qrRW5
 c0a/BBEmBBR+LGmN/+3365Y9dfOo/YaoM2poryVztpYvutSch+yH9Rm1ruiTTpVp5De1pQcOqNa
 dScs+M87jTdFp+jeEGYRrXqjhDaefshN/iZnWHY4ysqoMZvvE2Ds+4f8RntDqqA+3hQG3GLXuCS
 GxnalhWC2nbfvJXACrO3yZpdDgJM3wUg/L08Y25CXCm59BVErVtGaL8oTmFkfi9QnoaPH01dtUD
 ZaihLff+/2Rgx7v/0kugVOjJSXDxlKt5ty7p5kglOgiBzFIIf72Bmby9rYw/T0U+YCGuxW0Xff3
 T1W7ZSRnbo9vwYv1u56g82oDqb1A7ytGcm5nMpCCjN7+bzWx6B7z0egdnsFx9kjoXaMFB7OxEdz
 PE16nRmnQZmUPm5qtk6x6pUM37PtGvcBEcZIxi4pa9BRWfK6eC+sMvnfSWBYqXm6IIrnCjCsjsK
 FRXUXVPeLPFC6unRJo=
X-Received: by 2002:a5d:6a0e:0:b0:48c:6566:9ec5 with SMTP id
 ffacd0b85a97d-48dbacdeef4mr20658640f8f.16.1791914986751; 
 Tue, 13 Oct 2026 11:09:46 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaaebsm6854498f8f.14.2026.10.13.11.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 11:09:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3 1/4] dt-bindings: mfd: Document Skyworks AAT2870
Date: Tue, 13 Oct 2026 21:09:30 +0300
Message-ID: <20261013180933.487013-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013180933.487013-1-clamor95@gmail.com>
References: <20261013180933.487013-1-clamor95@gmail.com>
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
 .../bindings/leds/skyworks,aat2870.yaml       | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml

diff --git a/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
new file mode 100644
index 0000000000000..0b4b8be9015bf
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml
@@ -0,0 +1,124 @@
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
+      "^ldo-(a|b|c|d)$":
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

