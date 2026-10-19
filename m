Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C718FCCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED3D910E97F;
	Mon, 19 Oct 2026 10:09:58 +0000 (UTC)
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8631310E972
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:09:44 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4980fe6b3beso18510695e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792404583; x=1793009383; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=nWZSnVHau6Npi7hsSuIlFMNZUS/p2QupozYmLvTM/rg=;
 b=VyNYKr0yn5O9u9nW8uSNiJXQKo5tS9J7OQiy3Iag791SvEqie6ZgwfGoaVd/HE0kXH
 r3x96gRxD40tOjCximQK5nZL/qjiEE7GJLQsKaD1y/tHgWnN1c3W68TKp05EZvQv6e8l
 k8ZrSD4oYgXn4o69j3A2Uwpv3SnFZSQ49CFclnx2Swx9oh7FkD7HCIwKUmNsQZVWgSgb
 8GeQLiynCyqn0Cj3P8W75mbb8zbGiCJyPKFgNIHYau0FmM9dqUNH2a476Xu8hrrE0vrC
 MadoA31Dn18ThCepZLRUVb/iIMlnejUqYL5Il8oYxC94sFgNwaeVcDtqr4xCVpcyTqu7
 nqWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792404583; x=1793009383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=nWZSnVHau6Npi7hsSuIlFMNZUS/p2QupozYmLvTM/rg=;
 b=236HfQ1zzrWp8dNTxJzGubIHBYOvg8Uujx/NRDg1d01Kx+yDrB9+TyVwpI3A7/3YPY
 jRxK55bR6DVfzbERjwoa+KxUY38QacrCZwsZ/moENAcqCn2KK5OXS4J8zAbi+6cCtmFc
 wjoI20TCsvDBhvm4ZtPkQF5so2YGuJNwL2YZuyquQWmM/kULnVCV6jJXgNX1d5Yelzk/
 XHYq/FJikQZ8eRVoxGeE9HGl1jUrBqemBd/VSv52/yqFrUZmWrwBVDFnHohaIP5KekvM
 lX4mlEls6+oOgwJl4eQP6Ee1PURYXq0LMPAD3fEBgDiWOtZlxbPutHzZvzPEWua2HGBk
 STgQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx71j2ZVaUsGf1zyUPAAKIa+OZ4b4zWmUh0/lH6CgMZs+FqC/KcruPnlAyS3S5Hdt/ZAuTOE2hT0PY=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLwRVD89kVxqM1QI/rMMTQIsZuYHuuUBtOX9KwpUagWohyytfES
 2ojPuYSITYgdY2RkR8xCbAeVl+HJmSwUv6ET/IOYfU2Wizifc17M4uo8
X-Gm-Gg: AYBFou3bN7ig6YlwQYt27X4Rd0Y193DsBOtghGNnQRNgzz0x5S5BXpj0V+WgioD9efL
 KCmRNSh1PM27vWL3ag9IdPazVQ1a/wx8N8S/Gr7hq9DWGhh+TIWxZ8B1+KBiNG6F3wIO/+hVMpS
 5cc3HJTRAD5fO3MxKY28yVnuce/7FkX3NTdnJk74uTOLypnWJbndPzqC3/qRmGtMSUSnxJx1RGZ
 n6hYYzGxqsVocp+vYu7m5zhCckiG+hVNb35QplHhTMuuO83Q6DnlmbflhpK0UvASQmV+6YqiSM5
 Ujed8i4V1c4N1h2gxwgscezXRgLvyYCUqsVq/kB1qW+E21lSDk+yp3fD0EhtMJcObwCT41GdC0h
 GTsH343ZjYI9vaSmHk7/UNZKCt9+xPh+4yKSinK+WJnAx/wyGWzxaVGBvJ6kSkPi+pUuOtPxkZ9
 LoSM/4Igmf/aSIxVu1RTWnRWYRJOEFLocAtJOQxWDAT6qV5ZDdO9y+W5WhHdM73RbHFYd+nTVfW
 /nHZheGRQSo3h+ewzASLaeaD/hSyg==
X-Received: by 2002:a05:600c:3484:b0:4a0:34a:588c with SMTP id
 5b1f17b1804b1-4a1d7605e04mr153405815e9.14.1792404582625; 
 Mon, 19 Oct 2026 03:09:42 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm510533485e9.1.2026.10.19.03.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:09:42 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 1/4] dt-bindings: mfd: Document Skyworks AAT2870
Date: Mon, 19 Oct 2026 13:09:27 +0300
Message-ID: <20261019100930.110954-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019100930.110954-1-clamor95@gmail.com>
References: <20261019100930.110954-1-clamor95@gmail.com>
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

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> # for backlight
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

