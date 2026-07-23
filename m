Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8208DC531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:06:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E289510F06A;
	Thu, 23 Jul 2026 10:06:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rDDcsh+g";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 39C4E10F065
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:06:24 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so376694f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784801182; x=1785405982; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ux9hmvQYpNrioGxp+5tKSBKeWP1obZYcrlrpcPAFDf0=;
 b=rDDcsh+gxSyh3I10zm57g/a2eXuR3KG35M7zIBkVukG15p+efPDId6SVclQ4bq7YaI
 mnFp8ilaw7o6UQMifvrt430kbKu13vMda3nD1Da9uphvUeWpy3E5UpjxjSOelrD5BBNb
 Ap+emZ0967MlA8l2zovN8F9TvCqxetiQLx7V1wQYTfZCWz11tvGWwimz8miQEOpUhxW+
 W2R29CUXnsa5h4+wdPAcZEmr3mY3hIHtjCWUxe5KizPjgbTMkjjaRda98a0LuMN3liRR
 cCMVQF5CLUVw9gigEGvFRlq1M0fNkO/nrDV1bliXO9g8df3Yua6nK6FtzE5W64oClkDM
 j5wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784801182; x=1785405982;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ux9hmvQYpNrioGxp+5tKSBKeWP1obZYcrlrpcPAFDf0=;
 b=ctVSh3fdEc5JCdu/p3wAXeonvYKYz45mYtVBUYQR7LUmZynbDb6aaBTF2M8pQNPzO9
 jaGotVHeQtsYPXHRahwJROwwc0KXQes3UnNuRbTMhoABkJVq39wF6BY8aAaiT70AHhVa
 sjPDg92nxCLwXjsINUb9MHMy/URPU3BJz+6A+2VaxUuxiJ42+ivG+nTRJzmnPNd7GnNo
 nyubqRChPLuS1iTGO3b1Abb7GEP3D06tdbq6JQ9ObQZpZKge0vfzyWDfOQLkiK+T9v1z
 /w7Dm0vNqxQ/cMlPokh9nmL50lLYn2yRWH7Dzzn/AIQdNJ7VGDoydb5VRKpZHZAHDctt
 veeg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqAY2SGaogu2lXfZANHjBkPBVB5zQG6a+uVWoGP/AWhHGbIUTJ6CO9Ok3GLxGw7WdilSdZ8N7hGM2o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz0+iVKwjSY5Z3Hq/t1qRPHSFoBIn+rD0oswzHnRe12YCQ33tZE
 8FCliAus/Z4nFkakJXzzReUTxAt52HLZqJtHsbbE0u0+9VrwZ+suETnS
X-Gm-Gg: AR+sD12D1lGfh8fq9TSfEyjiEKkjldVuiULzPa6w24DM+PJDfYU1MU7z9nooDMmSN2d
 /exwr0iQzNPI+dxyV4FCSo/h8TL4VKZpyUh9g3xXZxYH/F8FsmHIaVM+myYW3BYJfFqXvJ6QusP
 ywiZUICPCwg644rCHOcQkZ/4p5W45xDSl4jUXfA34t4Pxk7zWrFNLlG+d7wlkYQFnp2B6+O2mlk
 HfatZMvCLaEwj63pI2aGHJvRP4TP1wbDngKVIDYedHrk0MeT+Fv7tfYKkaPG6M9i2YSWqUjjSlq
 zyNp44zZPXGtG/J8Aw4dS78QSJjpYN8VF8T0FQo9Ta59tGOELAySMMgt6tpu+jNRp1TogkIg0JU
 c+0IzRtnDsHvdq4uYL7BRO/nmX8jpJiU+UxfexIRXv74C3xyzqDPcwza/ujpsR2uOmcpcm9nnLr
 mPp5MFvoiv5QJ85r9LFS7GLEQK7BHZ5p2LCeO12UqALXiMpjgGOkLoKDA=
X-Received: by 2002:a05:6000:4704:b0:46a:8fab:eb44 with SMTP id
 ffacd0b85a97d-47f8d710897mr2842693f8f.1.1784801182450; 
 Thu, 23 Jul 2026 03:06:22 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:06:22 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v4 3/4] dt-bindings: input: Convert TI TPS65217 power button
 to DT schema
Date: Thu, 23 Jul 2026 10:06:01 +0000
Message-ID: <20260723100605.628882-4-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723100605.628882-1-egbostina@gmail.com>
References: <20260723100605.628882-1-egbostina@gmail.com>
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

Convert the Texas Instruments TPS65217 and TPS65218 Power Button
bindings to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/input/ti,tps65217-pwrbutton.yaml | 42 +++++++++++++++++++
 .../bindings/input/tps65218-pwrbutton.txt     | 30 -------------
 2 files changed, 42 insertions(+), 30 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt

diff --git a/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
new file mode 100644
index 000000000000..3526d8b045fd
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/ti,tps65217-pwrbutton.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPS65217 and TPS65218 Power Button
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+description:
+  This module is part of the TPS65217/TPS65218 PMIC. It provides a simple
+  power button event via an interrupt.
+
+properties:
+  compatible:
+    enum:
+      - ti,tps65217-pwrbutton
+      - ti,tps65218-pwrbutton
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pmic {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        power-button {
+            compatible = "ti,tps65218-pwrbutton";
+            interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt b/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
deleted file mode 100644
index 8682ab6d4a50..000000000000
--- a/Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
+++ /dev/null
@@ -1,30 +0,0 @@
-Texas Instruments TPS65217 and TPS65218 power button
-
-This module is part of the TPS65217/TPS65218. For more details about the whole
-TPS65217 chip see Documentation/devicetree/bindings/regulator/tps65217.txt.
-
-This driver provides a simple power button event via an Interrupt.
-
-Required properties:
-- compatible: should be "ti,tps65217-pwrbutton" or "ti,tps65218-pwrbutton"
-
-Required properties:
-- interrupts: should be one of the following
-   - <2>: For controllers compatible with tps65217
-   - <3 IRQ_TYPE_EDGE_BOTH>: For controllers compatible with tps65218
-
-Examples:
-
-&tps {
-	tps65217-pwrbutton {
-		compatible = "ti,tps65217-pwrbutton";
-		interrupts = <2>;
-	};
-};
-
-&tps {
-	power-button {
-		compatible = "ti,tps65218-pwrbutton";
-		interrupts = <3 IRQ_TYPE_EDGE_BOTH>;
-	};
-};
-- 
2.43.0

