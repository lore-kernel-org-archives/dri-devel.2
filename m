Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A0F606A893
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AitVldWE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCCF10E055;
	Wed, 11 Nov 2026 20:37:23 +0000 (UTC)
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com
 [209.85.222.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E85A410E055
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 20:37:17 +0000 (UTC)
Received: by mail-ua1-f46.google.com with SMTP id
 a1e0cc1a2514c-99075306daaso1733538241.3
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794429436; x=1795034236; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MbMz2QduqBl0mlCaXRQxtGdqnfX132c6wYdK6b13hWY=;
 b=AitVldWERn81kC4qA1XELo+dzHk7Tupz5ghj6QrYC80sefXRJ+BMMBQl0Dm9V5D00Y
 k+NII3AnvNuifgpGEleEw9bfrP2/hTlWgKOX5jzuOY8+zO7Y6Ne+LjqZleN2eMvG4a57
 X0H6QbQq52EfPOwGyUMVcWmDaMQXyHdY/hoCQspqUqlSTEsBMuS8t5tnndA1c00/LUi9
 6NZq0lPyIy/0P9eKlFm3KBRJVgN1OiwXAcHutClMRkq8FtQ2qnBmXE4Oia1IEw5tbwE+
 oYG3sKAwEn/t1HtI70hmMB+341ckt09PNbVEa/vymZGMhrlyzzzSH0C3K6zvJumO7sFN
 Fzjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794429436; x=1795034236;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MbMz2QduqBl0mlCaXRQxtGdqnfX132c6wYdK6b13hWY=;
 b=NaxnkP9zEe9r9jQWpIl3cBq83IoErUnstEFlwG4EyvES00yOe3yrlPeRpbEnmgbEem
 zLng8ytnIzSMd2brQJS+Syun1zENmfrUSp6m9g5GoHGqL2lWST7tBT/6o7+Ps7OaaSH7
 MyCjeBX/tZD8gv/dU3UhYktxKoHnIIWt9tYx+D9hrM6i2z47+ychwP5bIsP2Lcu+RGyZ
 fkLIgCKyFMjC3oELxtsgN75tcw9dRPcT9j1caa8MtmuMZV1xROijhxpK5fRccH21+flU
 7HpTDIs1ZKgL8c3n8SYrdYJEY6ycfqTug5bLLM1HVx6mfMkYnH9nbO+/UyIbFiecJrDZ
 eDpw==
X-Forwarded-Encrypted: i=1;
 AL+hErGdMKoHFkGNPQ4Ey4Mbr2yj3fPG6dZVTNN6dXvU3tiCtz89/ErS9YqzCvogPyxgg5T7JzxLomxTiXM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/FER/9InwSNx0XFvET9mYd1ey5ybjJBhz37StXemK5S6eCZXZa
 Y1F7KKpbktrIfJRWU8V1sr2Qs0pkYD1kp6rVtCjWl2uz9FYyeWfExfY+
X-Gm-Gg: AYBFou0AR2nFSfoUE+0mR96zRwapDDUsEbCCMQqEau8pg4gVlLIUKktByx2v09HZa/V
 QT4I4UrS9WK4DIE41TJz/pTwCHGCMxgkiiTwJe0FAok68RLQWHk9qzufLYE3y4ILJQzXTaYnfxv
 J8I0YS7HTodiL5GCxcT/HRYDOHBx7sZzOT53sQgpV3FR8p5+xJzU0TZ6Tl3HZiX8gk0py3uzqtG
 ODHSvW875EtWq7Ai6MOTprZeqUGoxOc1lL4IJDoPlaj70lmvO97Qv29zzZrVHqf6+jDia/bF8N4
 dqAY4jiCu8kddjmW2mUI4MZxzTjbIiwR7dWhkHRffF47j3HUHdXM0mPhxfUuxPTwF6uqYoz0UH0
 B2To3t1FSeWadMOrLX6yrkeQBs09lDGSUbAiX8fY+5GVffr9FEqOOTpujdt0M9Fwvg3OE+pe2ie
 Vb1i22ijFtvpkyx0AgkrtfCDyD6CPVmO5DJzEodD0jQ38423c+CDotfjc9tj/rE4dm1UQ1PyKTP
 Q5KjzC8mWggn4XWyEffoYEMLVbD8OHodK4dqpDRSEvPRFXrhJsjqiErjp5ktRoxpBwknMeDkS6f
 fa9GUzad51SWp9GW3a6teIfjAdbhVFLluwavpYMuIaYzoGUO8gk8OziN64KuWM1a0QwYotYvOEy
 CNnXUCI89mqery/UoLtf2Dw==
X-Received: by 2002:a05:6102:3585:b0:7c3:2f13:d905 with SMTP id
 ada2fe7eead31-7d4eff7be7dmr1694934137.3.1794429436467; 
 Wed, 11 Nov 2026 12:37:16 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net
 ([2804:1b3:a803:1afe:5307:7968:510:1cbd])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-7d62241eca6sm1564816137.11.2026.11.11.12.37.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2026 12:37:15 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: p.zabel@pengutronix.de
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, Frank.Li@nxp.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v3] dt-bindings: display: imx: Describe legacy display nodes
Date: Wed, 11 Nov 2026 17:36:56 -0300
Message-ID: <20261111203656.725823-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Legacy i.MX LCD display nodes have no schema, leaving their properties
unvalidated and causing dt-core.yaml warnings for fsl,pcr on several
i.MX25 and i.MX27 boards:

  imx27-phytec-phycard-s-rdk.dtb: display: fsl,pcr:
  b'\xf0\xc8\x80\x80' is not of type
  'object', 'integer', 'array', 'boolean', 'null'

Add a display schema selected by the presence of fsl,pcr. Describe the
panel model, framebuffer pixel depth, interface width and LCDC settings,
and reference panel-common.yaml for common panel properties and display
timings. Reject properties not covered by these definitions.

Keep the LCD controller schema limited to controller properties.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v2:
- Add a separate display-node schema selected by the presence of fsl,pcr. (Rob)
- Describe model, bits-per-pixel, bus-width and fsl,aus-mode, and reference panel-common.yaml.
- Reject unknown display properties with unevaluatedProperties: false.

 .../display/imx/fsl,imx-fb-display.yaml       | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/imx/fsl,imx-fb-display.yaml

diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb-display.yaml b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb-display.yaml
new file mode 100644
index 000000000000..72e567b9ed98
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb-display.yaml
@@ -0,0 +1,73 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/imx/fsl,imx-fb-display.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX framebuffer display
+
+maintainers:
+  - Fabio Estevam <festevam@gmail.com>
+
+description:
+  Legacy display nodes referenced by the display property of the i.MX
+  LCD controller describe the panel and its interface configuration.
+
+select:
+  required:
+    - fsl,pcr
+
+allOf:
+  - $ref: /schemas/display/panel/panel-common.yaml#
+
+properties:
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: Display panel model name.
+
+  bits-per-pixel:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of bits per pixel in the framebuffer.
+
+  bus-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Number of data lines connected to the panel.
+
+  fsl,pcr:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: LCDC Panel Configuration Register value.
+
+  fsl,aus-mode:
+    type: boolean
+    description: Enable AUS mode on i.MX21 and later LCD controllers.
+
+required:
+  - bits-per-pixel
+  - display-timings
+  - fsl,pcr
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    display {
+        model = "Primeview-PD050VL1";
+        bits-per-pixel = <16>;
+        fsl,pcr = <0xf0c88080>;
+
+        display-timings {
+            native-mode = <&timing0>;
+
+            timing0: timing0 {
+                hactive = <640>;
+                vactive = <480>;
+                hback-porch = <112>;
+                hfront-porch = <36>;
+                hsync-len = <32>;
+                vback-porch = <33>;
+                vfront-porch = <33>;
+                vsync-len = <2>;
+                clock-frequency = <25000000>;
+            };
+        };
+    };
-- 
2.43.0

