Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD0060A261D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FK7qXiG/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC13410F3EE;
	Tue, 27 Oct 2026 11:33:08 +0000 (UTC)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com
 [209.85.218.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 418A310F3F0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:32:55 +0000 (UTC)
Received: by mail-ej1-f42.google.com with SMTP id
 a640c23a62f3a-c37b612635bso531325666b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793100773; x=1793705573; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bleP8syB94cG1bo4A3J3eIEtjKnK9hoV/0t42kw/sr4=;
 b=FK7qXiG/XGUuH1+84uhOefNFXe4LdH1mdQy1GvuMXtbKX58EaOdbdt1BftUGQha0MH
 oMrsYB1QMjSZlbylYuYwq2Uje6Ddm+/RgDejSd6cLmkmq4S9w2nbW5+ny03NiUh/UXDS
 6rwHHxfucL1Jn6qPw32a46FEBMAkOCe/g4B6hbK/br9LGOjO9ARPz0k1AhNpU0wSJGR2
 IUwWd+LNodX+5iY+DmoygTALUlH0L19Z/Rt2RuOSQzRjdDmoP4v52eCpomPy8IKZ1K7n
 wHLiJSXLlzBlNgchnMzM73HeNfA4jVdnqF570qdQKAICaGsUrOzRAgdyorOjIrH6rb2L
 9ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100773; x=1793705573;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bleP8syB94cG1bo4A3J3eIEtjKnK9hoV/0t42kw/sr4=;
 b=QpiYgl/rJATvuTtt1FKsVzMR89SCPUk2KyWL5a8rwnHSq0vtKnX3ydN3zEqISEAZXj
 eBqknmtm6UQ1wQ7wtJdsN82o4SZOaSsSWZtCepRyZkD2AFief9uaxy8jGoG4xCYqt3qg
 aAmIc3wwKII6UdDPB9901NNbeoYqP+lQRkq4BF49yOIw5hlEp+VJkUO4OaPOjvT+FsM9
 UNNBDOTkK3Hpnr4JkpFUq/1dfQBo0lBV3aDce+jzMU/3VOEKrf6yxsCVeYbviIcXBG2a
 pKSH34DIzrSkx6HO7f/f1ROS4GV/GYuftq0WEOVutmLcxIbS2Ejr++jSK9Uga8j0vDR0
 xwLg==
X-Forwarded-Encrypted: i=1;
 AKwUvByeUs7G1aP8LPvB7F533BkJ2dmI1XleTxwh7I8qB4+QGIyDq19UCe0JWNjZ/MvTOrBqYSdjlF08gg0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI8sO8/IPmT/yKI5TzYoVhQUma7ll5gE6FxlhlSuU+TSK2/h1ZX
 4iAD0sjrSVmjXJN0Mik9cU2ov573bm6cYVsVBcGQj9mBziin+b3yTBlc
X-Gm-Gg: AYBFou0pomM4fgKXQde5miFQY5+HwDEwkEAsZmKmLpELCwljpffcUI/TzElI9A7Y/eD
 DFlfAbSASORIMdR/n97CdGRZn4lkMzwR6jmGGgX4WeNdZmPXEoxPUQKfoKJqUcZ7389akQk1WUj
 cumPnAt5yN4ulgvG8JRAUMSYNxPmymwudDSaYqPrJx6wEkmMPEl2y5ie0zm7BOFWMOA16pd4u/g
 MKHrqVcNhgrN1Y/SKjBC/hGZC9gY64kg60cdMa6xRWMH6iRpHyk2qIkXUylQrUSmtRpPJNT1ryx
 K0l6Y4sHoD19nWBCU80/e52at4a2sEZub0YovB2rSrWNzPh6cfz1+JEvSdr2T05W1Weck1K0glG
 soLFq8dE8vlj+KqZLBP1Acaup/K8VLSb046SRise/HHuNtQyGqQi4NH7ZOn6Y7k+OGAUZ15VGJk
 YI0WWjf+sUpOfAiTX/4lRPa+AewXilKp60MQaPUenEgoR1qOVQFjVc2b84HerXeNaNR0KYA9fQb
 VJC9V8DQsycrLN3OgvNNtAlTRbjV5za9BZ+rTDmbgI6GVwUIiPMM2swjXJ2MwWdZUB3+5iHxQfp
X-Received: by 2002:a17:907:6092:b0:c31:82aa:dd4c with SMTP id
 a640c23a62f3a-c46bde48accmr960707066b.24.1793100773381; 
 Tue, 27 Oct 2026 04:32:53 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea608sm428920566b.21.2026.10.27.04.32.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:32:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v5 1/4] dt-bindings: leds: Document Skyworks AAT2870
Date: Tue, 27 Oct 2026 13:32:27 +0200
Message-ID: <20261027113230.47538-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027113230.47538-1-clamor95@gmail.com>
References: <20261027113230.47538-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document Skyworks AAT2870 LED Backlight Driver and Multiple LDO Lighting
Management Unit.

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> # for backlight
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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

