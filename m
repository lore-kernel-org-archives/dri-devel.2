Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94C606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y+/kgYHV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0989610FBA1;
	Wed,  4 Nov 2026 12:37:34 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E165010FB9E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:37:27 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48dee593f18so494108f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 04:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793795846; x=1794400646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o49Az/X7nnRMbCTvuIgrTpIjxf+w39CY1NNO3CjBfDA=;
 b=y+/kgYHV0OXxFEty4Vweq1/yb0Y4WJBExcXSAI1ZZGF3SeXfyMiQR8mDa7suoGCkGv
 2fQKPkHMaxcVIBjzncN2XJJ845zzOk3wmveJtxKHNy+K6M9R7iOk6Hpl+7ZDjBcJ8lXP
 7ueRETqBKab0Nc36p7ACWl3I/g3A0ioOR3JiPvEIHtkmHLqlJcv3Ou6JZBT4ICkALuxf
 MAJFgFIJ/8UnnfYM9XLfVAuTnI9cy+CozH7shhMa4zAnNZq7NYuf2Ko1KBLa9rise+B9
 DLeeCbUXMQGqCifRldT1xpcywr74iYWc2KEpM7TIFF7OkK52A9F5G9u+6hXcS31MCQLs
 yTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795846; x=1794400646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=o49Az/X7nnRMbCTvuIgrTpIjxf+w39CY1NNO3CjBfDA=;
 b=T92mw7ffvw1BopTuT7OiVqDJD3wjH6Vy8cCp6CLLrMS8x7jtOPzJ/6dEPfCfdPw3Vq
 09tX3x/8a3n+j0hCSo1NDVOgfg2TF6A74dhYdVEdUW8xzlKoR3pA1q92didJxs7wtYhT
 1q0iY5qXv3aYWso43Jzr8G6hAXUZgw44ggUTb5G21+7SLmv3h4qxnqyNOKNLTrCLRbDL
 8FUQmXi56t6lNnIVEkXLkOaVCNUzQV6RH/4tM7BQTNf17CQ2n7ZaxXCe2L/IUvyt24Cj
 iO0tShCWAf1SKuTEV/MAPRZ9N70uOcOgqtZc3ze3v+m+UqwKfU0veZYbqglFNfWyQTIh
 Ec1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXFYAnqsTEq4N+bvRJKXCDrI9fQ0clBH7+JJFOj238DfUyuKGHAFK4YKm43sajHidTkUpWC3QAR4s=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/jHFCcxohjpG8W80d4Zc2jQz4Tznwus4FB/SWyq4oMQuQenwKz
 zm8UZUFsl+dq62qtyFpViJvnDIAKzVxL1ESOA8yzaeeO9ue6b/ucS02l
X-Gm-Gg: AYBFou3xMZKtNPxFenTDmdGBTVdhIeUBMTZSrMdrS1aObehybz40B3GIFKaBkl3yYTq
 kwfPP4NsKCLxOoFbRebv6Yy8be3QxHHlKtRmHgmPdOBxVEImpb+fNr66M+I0mssfy/Q5/NHPody
 H71uk4K43OY4M0OmhZlyvrQuFmamyNvHEinW9hAqCdDwEoivpHdcmtTPQDMF/KVsfoSiA5KYuAv
 z7n0oA5PS73S3/d7EvglXkqhDp1G8tkYyMphq9IMqQSVvgHiBDl2vKTF0qM1kKt1u2HbPZCDYIn
 o5C/dKPv92d7XpvmDcGiYMnJgzhldqr2XtsQVpgKVHmOegEaDukJoMhh2QV6/UgDTw+eDT75/bu
 lmqgPKDtmDzosberwzte+uMYJV0u5HuWd7/1HVhLVQew6iWs6HJRrXJ9pZOAtCTiA26d3nGF0Pk
 /Ffq3j2QKXx91ERFROsmfjb0lL0myPw97c32TonUaa/je0C6f90U7RhXBKLnJHBSCRYVWztMmfh
 QuDGv32hm2VvFrhVUDUEyndgwmH90+h7MpQzAheXyFktox2pV9s6587zI7suGoe3/oKE6GrPYJe
 A9OpPvKCke8H8UY0R6kfGrk2bYDFul+kaSJNOsPOknKCPdMM6g==
X-Received: by 2002:a05:6000:22c4:b0:48f:bf3c:1631 with SMTP id
 ffacd0b85a97d-48fbf3c185bmr4984588f8f.21.1793795846185; 
 Wed, 04 Nov 2026 04:37:26 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed553441sm3386155f8f.43.2026.11.04.04.37.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:37:24 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 1/4] dt-bindings: leds: Document Skyworks AAT2870
Date: Wed,  4 Nov 2026 14:37:11 +0200
Message-ID: <20261104123714.234634-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104123714.234634-1-clamor95@gmail.com>
References: <20261104123714.234634-1-clamor95@gmail.com>
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

