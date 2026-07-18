Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FF7C44524
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE48110E785;
	Mon, 20 Jul 2026 07:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RykApjf2";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2045A10E604
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 21:56:59 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4954f5e8020so4313755e9.2
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784411817; x=1785016617; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6hEJAtA2FmuGbMms2Cfe5VvNicgq5ngesjv9wLRLgDE=;
 b=RykApjf2aJi8wT2JE8EDZr6P5K4VDzTU9elz3Om5sG+vX4BFGTHFimWXU1EnwI2246
 Ka6W4Lz79K9CqSXLGwep8mgOQFXqDbNL3raK+7f7c949VZGm1dE0QsOdg2fhQK85rjNY
 gf00I9vtSImiLHI6dWrHzFsajdy9gOWpHf+q/qToH8t/t/b7MhAg0gP3dnichfcymBMk
 dxbnKckoexl17WdEXFSNLgOg2Rc4MQ6bGN7ATrXt8gzfjjqHB6ameWdDWky0tIwg/zn0
 ZaBeBOzh+IrMol4MxTATMkTNgA543XL14DhuUIz7xpGg5jXhvMKkvRrn01rL2YAWPvSM
 JmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784411817; x=1785016617;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6hEJAtA2FmuGbMms2Cfe5VvNicgq5ngesjv9wLRLgDE=;
 b=CEUczHp10ulOaoB8+WBogdq8V3/jdB5n7GkwwIJzOzW5y+JOGSgJPomtQKiX9Zd3LG
 2Cgeg0QN5/u+3H/AvcuCOqNugQCW3vziLMReCZotRNbd5okNz0d/UQq5Yd6PvrNqTzoj
 40U/4+UftHVvEM/1jLmZuPsQKuKpjwfw6mh1SLjSNfNiClG89cEnOGX92loFbb7zeR8e
 arysIGexCPq+NZcfAuovkQtQshO2zQMwp6wA6CtEEq7F1mitlHruQuJxcJ0wOo2i3ohh
 dzC9r1i/KMxip4paGZ2AEe3EufPi6f59h413URmRZG4MOlnHyIHLbpXv5xQ96Fnl73gM
 kaLw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpscfx+BfEhtpJTgMrZfvEBLjQVYub1wAozuPFu1++Q5f5QzMI+3c22pdQOmRO30amsGXGoAq2du6c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGzxOiZUcP/6oHUdJx7+IpzH2eeun0qmuVpPhG74dUQY16mpqz
 EgCGQ7bi17GZ3jLoCpwmRCclsDg+iKyywmqYYSAk9rSZWnOHwycoRGV8
X-Gm-Gg: AfdE7cmXrzMS1Ot1u5MKCMVo0OHhhu8D+Z3Pl3RWqwVWsrOBXxtlhqZuxhsbmoQLRCF
 EOk8gKJuf4Ar58n2Bc1XNLtIZpkBKTLV0zkmm4cUAAk5x9rq1FiNQ75WW0/eOTtDAWYxkNMVULv
 FG5fk9RLyDPTbBCUy/7rTV6DS0vUR6jNRIEynkRHHO1ZgWmwZ+yhD20JZ7JoX2yVW/VsnxBrmMe
 N1+EJVTgfiswzKp9kODv9Rf6BmTeX6AuyuzzJrBcugkI9p5kcGS37HDO9ZKgG1bl8zRMaVMBjmN
 aqFCWKteXgJdEDiDvp68gyjjY0wJNmtBKCKsINlCDXXc+BZ59tCB8UpjbDw/ILUT5ABD9HwAAxq
 20Pze/CJoPdd9enK3htW5Vzr9oVPE7TINmW7fpHSQmOTVXve7nmOFy57XWEnpy/RzrJNixOuW6V
 EnpuwSao49iqXixn4UrEE2k0RI0x9xYUVXSXcguwlwRjwtOEzJNfCWDI8=
X-Received: by 2002:a05:600c:1d18:b0:495:3e08:ad19 with SMTP id
 5b1f17b1804b1-4954aa1a264mr86084215e9.9.1784411817252; 
 Sat, 18 Jul 2026 14:56:57 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4954c0a81f7sm101199835e9.1.2026.07.18.14.56.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 14:56:56 -0700 (PDT)
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
Subject: [PATCH v2 2/3] dt-bindings: input: Convert TI TPS65217 power button
 to DT schema
Date: Sat, 18 Jul 2026 21:56:31 +0000
Message-ID: <20260718215632.3295049-3-egbostina@gmail.com>
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

Convert the Texas Instruments TPS65217 and TPS65218 Power Button
bindings to DT schema.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
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

