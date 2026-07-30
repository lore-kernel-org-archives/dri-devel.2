Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E90C54FDF
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 09:23:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D71D10EE60;
	Thu, 30 Jul 2026 09:23:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZuQBlslF";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F38F510EE60
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 09:23:10 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-495590dde14so18501765e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 02:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785403389; x=1786008189; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=51WDwBX8UuHOu3YfsGA9ozMS4JtSAKzLcDeFZmmn9U8=;
 b=ZuQBlslFySBztOQUg1lkiU6NT1705QsFAS6j486xWRMui4dRw5lTRsJk5gjbIAuf7a
 EMbMFFZ5+tsKGZjlBC4eSQ3MNtGWNXgnKh6hpg3VgxQ2gn6rrdtfWimwct3Kaf8tiZvU
 2v9JrRh9TycL/SIOx0o5udHlBvbtyaGvImVN8J6XquPlobNmg/GacIcRdw4/COqYjB1p
 vKz2luCKxy3yEKpG5PHhEsfVeJPYpfwT6HwtaDEifm49NtJJbuE/b39QRgO6omm0gS+j
 begZIyqnCB29mv4hX2Q4k9slHnOyfcQ6wlaq4V1pI1vIFbIsXPo5+8L/eZ3LaE6z8MUB
 +gjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785403389; x=1786008189;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=51WDwBX8UuHOu3YfsGA9ozMS4JtSAKzLcDeFZmmn9U8=;
 b=KVuhTiYmK4fr5XTWMhJrtzV2O8e6C9SDL+GbzsW1ZW2t5XmFP2E2Ml9mx7eeed8Psq
 EadMN/YkO6g8755xf6lq11nfWj1il2hO3qRkSwe3qQdbuyiCYiXHVfI9hbczgxC0y42Z
 W8oAarzJu3sSJKbSYkVp1dXMD3Swli7m1UMCMqlPiNIiNgdvQBfIbLvkeha0eh9dzN7J
 YJ6Wz+OSHJ1nwBxb4f3Fd3ETlGxz41p90zJlEno+Wcr8oJaLSNhRBSdDmqkT+KCCOurP
 rQLBg934pmUpN4dCts8kJQDDb5BJ8UKKyPKOwaETNiAfWKo6/HdnG2HdtnTJJwHOxifk
 8NLQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp+M1goqBZ/uZCLpe+VY/P0gap19h8+EFKsr7YnMmKqq1jBKdDezHuHstzPXZ/lHAcxzvMm9SZI4DY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2vteTano1yyl9k+rjNAAM5cxSS2tZBkvDNMVY/ijikRbmkuuc
 yCPn7ipLC0whWW4vjDzF99G/AhgaT0swas3V5wUXxg70fXFTFQxsEPHs
X-Gm-Gg: AR+sD12duT/vYbX0NHd+xOXUUciCrKjiBVrqtCkNE64qDU7scM4DeIKCLuBTfEkLyXs
 +4rfmTcevqhOKn1nkXM6mmcGgkHKu5JZ9FRb4pNQdApjVXFj8uzjKbV1ipQfoadl5IYu0+5Nw+S
 6h6QiGd0ac4o9G6SLGzp4gGuDaPOFrMZMn76UT53AjPQT+56ta6a3nHrSmnQrZeJfBusGySU0xp
 QvTU3hQT/HvVtH4gwvaeC4/yq4lSm/fvHgWqUemBCI+bECSQhovx74CXhFufKU8bFtOG8N2X8Zc
 ZqQ3sse0OKvQC28PYWutdXVWuBX3SHwZP0H8uNTr0hZ2hZsKmZYFAxW25VqEyTb7BDRVy0M05Qi
 8DKVLGjS0CbeezjGEDv0zZJlLcVGOWvmihn9ZAoRlc/g0KuwdkY7jsYrJCvlqW8zEaFh8LtmKJO
 I8euLcFHmckHquNXslVf/hf3DMfWGLlsiSAJ28jJ8TzV7tQnE5rSQiO/b1pvASZaLpDLw4CRfs9
 Ccz67fdkky9M59jv2vs/WncM1dwzWUTYw==
X-Received: by 2002:a05:600c:8b66:b0:495:7379:17b1 with SMTP id
 5b1f17b1804b1-49800ebb8a2mr21092445e9.30.1785403388303; 
 Thu, 30 Jul 2026 02:23:08 -0700 (PDT)
Received: from fedora.tail6d6c39.ts.net ([82.77.79.56])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47fc88e64d5sm4308425f8f.15.2026.07.30.02.23.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 02:23:07 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 David Airlie <airlied@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-omap@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH 1/2] dt-bindings: display: ti: Convert ti,
 tpd12s015 to DT schema
Date: Thu, 30 Jul 2026 12:22:44 +0300
Message-ID: <20260730092245.52034-2-egbostina@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260730092245.52034-1-egbostina@gmail.com>
References: <20260730092245.52034-1-egbostina@gmail.com>
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

Convert the Texas Instruments TPD12S015 HDMI level shifter and
ESD protection chip bindings to DT schema.

During the conversion, the following updates were made:
- Added the 'ti,tpd12s016' compatible string, which is used in
  am57xx device trees.
- The 'gpios' property now allows up to 5 items, as the
  omap5-igep0050 device tree routes additional control pins
  beyond the standard 3 documented in the old text file.

Signed-off-by: Eduard Bostina <egbostina@gmail.com>
---
 .../bindings/display/ti/ti,tpd12s015.txt      | 44 -----------
 .../bindings/display/ti/ti,tpd12s015.yaml     | 78 +++++++++++++++++++
 2 files changed, 78 insertions(+), 44 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
 create mode 100644 Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml

diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
deleted file mode 100644
index 26e6d32e3..000000000
--- a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.txt
+++ /dev/null
@@ -1,44 +0,0 @@
-TPD12S015 HDMI level shifter and ESD protection chip
-====================================================
-
-Required properties:
-- compatible: "ti,tpd12s015"
-
-Optional properties:
-- gpios: CT CP HPD, LS OE and HPD gpios
-
-Required nodes:
-- Video port 0 for HDMI input
-- Video port 1 for HDMI output
-
-Example
--------
-
-tpd12s015: encoder@1 {
-	compatible = "ti,tpd12s015";
-
-	gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>,	/* 60, CT CP HPD */
-		<&gpio2 9 GPIO_ACTIVE_HIGH>,	/* 41, LS OE */
-		<&gpio2 31 GPIO_ACTIVE_HIGH>;	/* 63, HPD */
-
-	ports {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		port@0 {
-			reg = <0>;
-
-			tpd12s015_in: endpoint@0 {
-				remote-endpoint = <&hdmi_out>;
-			};
-		};
-
-		port@1 {
-			reg = <1>;
-
-			tpd12s015_out: endpoint@0 {
-				remote-endpoint = <&hdmi_connector_in>;
-			};
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
new file mode 100644
index 000000000..bda4bbab7
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/ti/ti,tpd12s015.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/ti/ti,tpd12s015.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments TPD12S015 HDMI level shifter and ESD protection
+
+maintainers:
+  - Eduard Bostina <egbostina@gmail.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: ti,tpd12s015
+      - items:
+          - const: ti,tpd12s016
+          - const: ti,tpd12s015
+
+  gpios:
+    minItems: 3
+    maxItems: 5
+    description: CT CP HPD, LS OE, HPD, and optional supplementary control gpios
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for HDMI input
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Video port for HDMI output
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    encoder {
+        compatible = "ti,tpd12s015";
+
+        gpios = <&gpio2 28 GPIO_ACTIVE_HIGH>, /* 60, CT CP HPD */
+                <&gpio2 9 GPIO_ACTIVE_HIGH>,  /* 41, LS OE */
+                <&gpio2 31 GPIO_ACTIVE_HIGH>; /* 63, HPD */
+
+        ports {
+            #address-cells = <1>;
+            #size-cells = <0>;
+
+            port@0 {
+                reg = <0>;
+
+                tpd12s015_in: endpoint {
+                    remote-endpoint = <&hdmi_out>;
+                };
+            };
+
+            port@1 {
+                reg = <1>;
+
+                tpd12s015_out: endpoint {
+                    remote-endpoint = <&hdmi_connector_in>;
+                };
+            };
+        };
+    };
-- 
2.54.0

