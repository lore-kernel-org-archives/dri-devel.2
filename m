Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EF7606A31A
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBwk7Ye+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4101C10E1D1;
	Sun, 15 Nov 2026 08:58:48 +0000 (UTC)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46D4110E1BA
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 08:58:40 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-c40f29667e6so454075966b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 00:58:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794733119; x=1795337919; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o49Az/X7nnRMbCTvuIgrTpIjxf+w39CY1NNO3CjBfDA=;
 b=nBwk7Ye+dyta4trDlm7f39WzvEqLN0gMbR14AMkq6HtlFO5hBvIzC9GxBZ8ogKzCjq
 aWAe2GkZoD6egruLBNRH9H1XdoAjnmoqfEpnsvRI0k9rKx/1HLcnn+2Gh7SnT6YmXkUx
 OPfEptXkNxn+RTCI8jZnETUkPN3EK2xzFL2BXNp/JurkwlGKRZRuxxKHpXNfFEy9sOTV
 +rs4ukiDprIdGF9zSLWh0JCdCgBz95P0iEI4vJO4jNAQ99AJiEn/yklVuGGPwB5uDCxn
 ONprcIHEab6qBCXNEYm5reXTlT/7Lmj9APCk1Y1qxI28HfTV8LvDXdeemtQ+HFdgp8tg
 cQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794733119; x=1795337919;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o49Az/X7nnRMbCTvuIgrTpIjxf+w39CY1NNO3CjBfDA=;
 b=UJh3PbfotH3xeqt+HuEawMv+How/k7QkW8e1QKL+IA7ycBtANOGtgKnOec4Mlz/dw7
 URDtVHx+kEIkULDvv9f5+2Dw43Hu9PrUb7rKgpXvbt1hsAeyAJBQLYFlHFboBI8GX/uq
 PxHIw16QfhGfO/MV6AvlUVYL1EXpOFTty9Oc5wN5WjINY9Jm/kH9gzLQVSua/p4juwED
 90LqBRh6ma2cks8wKPK5b7C0V+INtLdLxKq4zi/g9WL2j2XvY//qqd5DyZseGkC515tw
 e4zfCf81HV9Ud8XoUlkbVK5mY98tVdAdsc8bOmPD0tpKWxXq/Y2ZekhhGXFYGDPfnBGD
 PDrA==
X-Forwarded-Encrypted: i=1;
 AL+hErFwYigt+jI87uJ3qMDm6oqzQIV0ES/O6HdIgf2FAM1kqS8CNhkQJbdJa0a9Zrxnx9wbeA7FfGs+IsY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+s4p0QNzmYrCg/XGU4rGfEJtvMEh7tFQk4mVEw1/9EaI4iRjvG
 NKTxR3TeZa5w6w0QnZ9CJikx81QX3JgDwXtpTHQk062NdmxtZk3Tj8o3
X-Gm-Gg: AYBFou3+8TxePNklW9LFq9w+zaRYHAHT16dQi7vjvczFnuHevsLQiHQo4lH2C/Wl7ao
 Rr3xbJXNLc2ciTZLV6YYT53EUuufG+i3G96cgrIAxB+2h1dMUxbYlVdnR+Pk/HLu5mvSjAhlXJh
 +yiKW7mFXYwx0mdzbc0bjxSop9hGAvaXz4giH+oIKX8k6ZLrsf2BoO9TA/qTEtkhBjcXj+zZbmq
 8zpUSFxCNJBK+d1v8a4+48zCWN+nKrKRWzM9nj3GEGD1r4fAahO2kLjzxICQ+DC4byHdh7w2gK1
 nhKf5x2yDosljE2Sc8K5vvoiwtIRLpbc+WSCyxkIyYMmLjip8RoIBlOVnlXl4B6GyFpp5/FW3h3
 TP5RsVPmG2Cn911pya9XGHrb70TthA6YMxHd4wtZT4ywJCw5YZZZCxR7tIfuc9M5YaB/tn3hM6v
 SK41Wf5/v7X6GIAt7hxLcQEIs/zwjQszr4AjpIIGQv7XqaDgy4g21jQ/AV1Gj/HYsDQ5DBF0CCk
 KW0pLP/5V9t9DLbwMaBgIuAWN7b8m0gFURNNxi2qDw24POuI9XGm6TrNHR9eRuNfd0QJof6SWcw
 0VCbnJKOwwxmuWnm0CHJAsgEzGRWPLgyrLi7fvosaaFnwUfaG9zb/+HefIZvp8FzKVsJSlhRZf4
 rcF38C7iNwg==
X-Received: by 2002:a17:907:9448:b0:c41:8e21:4d58 with SMTP id
 a640c23a62f3a-c5096199393mr579973966b.5.1794733118390; 
 Sun, 15 Nov 2026 00:58:38 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095a5c4b7sm287613266b.1.2026.11.15.00.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 00:58:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v7 1/4] dt-bindings: leds: Document Skyworks AAT2870
Date: Sun, 15 Nov 2026 10:58:22 +0200
Message-ID: <20261115085826.89641-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115085826.89641-1-clamor95@gmail.com>
References: <20261115085826.89641-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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
index 0000000000000..3f3f3058af52d
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
+        default: 27900
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

