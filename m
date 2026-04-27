Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF77BFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 17:11:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E97810E82C;
	Mon, 27 Apr 2026 17:11:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BBTd+1fp";
	dkim-atps=neutral
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com
 [209.85.161.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEB6810E82A
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 17:11:43 +0000 (UTC)
Received: by mail-oo1-f47.google.com with SMTP id
 006d021491bc7-6948ff6b006so4654588eaf.2
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 10:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777309903; x=1777914703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ff3Oah9+sf3dvTFmRGJs44c/nx8rxOEtIEmQFlJnbJA=;
 b=BBTd+1fpvA7PLBN2pL4vX3GHWBN6wPrZij0rHhu3QZ83H/gTlpfynsHXwYxclvtUeh
 ep68eoQO4eQDkSQBN7qHzZqXm8++PSyhkysHr/kpXa2KaeyrtA8S0kqq8kX3Tajosy51
 sWveAqlgLU3O9h4Lyf78nLDRrtqWActa3ynQzJZbHMlh0kbvqu75JVxtk0izlDj/Qg9p
 NmgsO+WTanSLpxub5jKFv3UvoUOR+q5JSD/SqXmel3GlVw4oFSJexrabiSWE8aukTO0D
 FkFdNCQWCLPEdvYwNYJBm0B+PNLsRP4PqO8qtyojXGraKm+h+mVXkLq3aC5rv7wQEo1l
 Wgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777309903; x=1777914703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Ff3Oah9+sf3dvTFmRGJs44c/nx8rxOEtIEmQFlJnbJA=;
 b=DN4vIQP51x/OeRjSy5loc2FrLGMLmRNyqsgXLh374LZ0wT2R6CeFsoqJRcH93LdES2
 bYsKH+lAd21iKs0piIFf6fH4Kvw+XEVbKg9Hze5nxbyryURSkiUqwtKjfKYXJkDsT433
 z9B4eTiHeIW9T1VOcbqFHNY8htDmoanTOLs9GKDA5TLcifb34RZ2PrbBPQULYM6shIeK
 O3j5ILfbiBl3G67oQduDx6h1WHTQTEwJ02SuRwbVTTVSnC+dTqBR2oy0JEi+Wc9c5+b4
 dleme/Q1+n+VEG4/wW9UnAqoH+o7XNfMfeiC65zZejkxtJ3g5CxKtaXLwrRcF7kAWPVD
 tY9A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+o+qA+KWxbsU0HHO7in4GoFDyV/0TMC41fGJAMuZcU9w0x3BOjwkOJQyfur24yNqbPPavypUYVRww=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZoJfXZLWpiRi9CbYEo0VRr0KUBC0JnWXkWafxtmzFEhrdv9En
 CuFHN4fRlKZcTm4DsfbZd8AviBIZBmIEIr4n0Lqf/r9GUWydqM0Z7tTK
X-Gm-Gg: AeBDieuL/VQBSbUxcBFg/axK+pf+FxyCJX6D1MtwbFDjA+ongDn4hOwPgUskhYSdLWQ
 j4oKT9Rc7grvPkrR7Mupel/Sh4pxFZbbILaPFe/iynD8PD9kaw3zvzMvxXr1z5kbIelIuI6tJlV
 xlXOd96Cef0Gg7yfmHIVs7NJL25j+G+cRw7wZdF/obXcCxtCq7vEl58ZxTZBtd0RuYeB+bSHilQ
 5cfCbHRrbyivGKG0a7tFA0XofZnhiJ4HorMLIpKswERGAlGwKAft82mb40vrr52M6q90S79Yzjt
 P2+OKvR2J6cO2GH9cdLEA9l9PQvxnyGjLYk1j8ncpeEIGGXQqd/aLo8OC1S7Xpk34vA8o1qRjya
 uxx2vJyvvNCwhgluwkMR1YkaM9na5zGbNkKaj1O9hTfdlO1DtUm3aFhoQeaw6Gg9Uw3GUxnacnm
 dWTtU/P8fPAnkUMOhYZw17g+fl507V/qc=
X-Received: by 2002:a05:6820:1b10:b0:684:5041:9296 with SMTP id
 006d021491bc7-69462de2716mr23720910eaf.10.1777309903103; 
 Mon, 27 Apr 2026 10:11:43 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6955036558esm10261236eaf.14.2026.04.27.10.11.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 10:11:42 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-rockchip@lists.infradead.org
Cc: linux-pm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, xsf@rock-chips.com, sre@kernel.org,
 simona@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 jesszhan0024@gmail.com, neil.armstrong@linaro.org, heiko@sntech.de,
 conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH 1/6] dt-bindings: power: supply: sgm41542: document sgm41542
Date: Mon, 27 Apr 2026 12:09:09 -0500
Message-ID: <20260427170914.5062-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427170914.5062-1-macroalpha82@gmail.com>
References: <20260427170914.5062-1-macroalpha82@gmail.com>
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

From: Chris Morgan <macromorgan@hotmail.com>

Document the SG Micro sgm41542 battery charger/boost converter.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
 .../supply/sgmicro,sgm41542-charger.yaml      | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml

diff --git a/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
new file mode 100644
index 000000000000..3e5041e5b551
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/supply/sgmicro,sgm41542-charger.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/supply/sgmicro,sgm41542-charger.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SGM41542 Battery Charger
+
+description: |
+  The SGMicro SGM41542 is a single cell battery charger/boost controller.
+
+maintainers:
+  - Chris Morgan <macromorgan@hotmail.com>
+  - Xu Shengfei <xsf@rock-chips.com>
+
+properties:
+  compatible:
+    const: sgmicro,sgm41542
+
+  input-current-limit-microamp:
+    description:
+      Optional value to clamp the maximum input current limit to for
+      the device. If omitted, the default value for the hardware will
+      be used (2400000).
+    minimum: 100000
+    maximum: 3800000
+
+  input-voltage-limit-microvolt:
+    description:
+      Optional value to clamp the maximum input voltage limit to for
+      the device. If omitted, the default value for the hardware will
+      be used (4500000).
+    minimum: 3900000
+    maximum: 12000000
+
+  interrupts:
+    maxItems: 1
+
+  monitored-battery:
+    description: |
+        A phandle to a monitored battery node. Values for the following
+        are used by the driver and if not present will result in default
+        values being applied:
+        constant-charge-current-max-microamp
+        constant-charge-voltage-max-microvolt
+        charge-term-current-microamp
+        precharge-current-microamp
+
+  reg:
+    maxItems: 1
+
+  regulators:
+    type: object
+    properties:
+      otg-vbus:
+        type: object
+        description: OTG boost regulator
+        $ref: /schemas/regulator/regulator.yaml
+        unevaluatedProperties: false
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    battery: battery {
+      compatible = "simple-battery";
+      constant-charge-current-max-microamp = <10000000>;
+      constant-charge-voltage-max-microvolt = <4350000>;
+      precharge-current-microamp = <180000>;
+      charge-term-current-microamp = <300000>;
+    };
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      charger@3b {
+        compatible = "sgmicro,sgm41542";
+        reg = <0x3b>;
+        input-current-limit-microamp = <3000000>;
+        input-voltage-limit-microvolt = <4500000>;
+        interrupt-parent = <&gpio0>;
+        interrupts = <26 IRQ_TYPE_EDGE_FALLING>;
+        monitored-battery = <&battery>;
+
+        regulators {
+          otg-vbus {
+            regulator-max-microvolt = <5000000>;
+            regulator-min-microvolt = <5000000>;
+          };
+        };
+      };
+    };
-- 
2.43.0

