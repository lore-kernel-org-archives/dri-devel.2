Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 587FBFF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 12:27:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7E4410E533;
	Tue,  5 May 2026 12:27:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mpmf6QcL";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97E3010E45A
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 12:27:53 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2ba5c126afaso245525ad.3
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 05:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777984073; x=1778588873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2f9qY6qIojyC+n3cwV4DcJgl1Mh7dbRflEA4i8ZvFGU=;
 b=mpmf6QcLmEGolkrr7/IWmoNb9TM/JrlOKVSLDSMR7htX1Gk4iB6jmfNuV4fJsQQe/W
 JEHMbZQX7TSlyb0D4lv9yvOR+eA2A6+bL3I0NyQ0OP6/zkSsN5G4npZVBESPt0GHsfPb
 k5B3HZgl5Dwln3tA/CAF+XzXl5Pt4xTPf8UCxzDI0pnKau8r6LrAiNouwm6NAyNxjdrb
 fQPqPBSkZ+04dNRYrGh1vN5QLRZyKwSsWZ33CyuDyYXPVpmlF6+sf8su4S3dl1LkYVPM
 muryymz6qK9XjfcW/8nIsmWJeyTRKMzwk4YKO6CtOKZ+K7PU8q21SJfmt5LWHuQKtzAu
 LzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777984073; x=1778588873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2f9qY6qIojyC+n3cwV4DcJgl1Mh7dbRflEA4i8ZvFGU=;
 b=X54Hi6W9PvZTJ3P69EeyFJPQ+MmWIj31xUVdJc8gkvmaBOIAI8zVt7lKxmkiljSoKf
 OfeQ7J056NsHPz6f6dE1R1udVdXsfoY9gdsStfj6lOZfvtnxJ7iZaZHn+TXWqKssMjU+
 8bVCJquM6rxofYIcgI0wS6rQGp2txysP7cIQp4AEdXpaTgJbAnpE7I/ZRKNbBZC/1Ngi
 IQ7htH3yLMWg31VDztYAVcgyemhN7iNroVEqjUh9SQo2JTgcx5/9azih4en+xNi9HgYQ
 1Uw3ySAFPabFbV6fWKeSgvqCkrZTVFI69XPdrI6E/4nJmEs85S1yHBm08KWfFeLquRKi
 oY1g==
X-Gm-Message-State: AOJu0Ywisb/MCD4prW8bABPr8mVj4pqUoy+FeGtjy1N0BDEjMgozNahU
 R+pe5Va/1N32wY8okIPJSXGNg7atMLW88oP2fYv3VWedmuVsfn/GfYOh
X-Gm-Gg: AeBDieu9cxqCP2kmwrRd+OYytSiQmfMi0aK/LvaRkRdqRex4xHseTsj7TZBZmLWix1m
 u+0BZtHArAwN6GUq1tAKxig9w2M4tgHlDTl+PdcdYOMJhnOFtkoBr1HSdikSGEkWGO1AdDZt8y7
 xUxeMgNUsJHEhdidAl42SaJYp3Ae0QnHpgCYwFu6uvIVrrsd6RdOSIBekgGBeV99O533w5gHNZx
 NwyHwOhUnSApdTnVjRfVMILm3xs7Ckun4q3UzuGIjwQb3py61X7/h82QcNaiWbJ/ayov+QfAxhG
 0jk2mT2hu6+OFHsRkyyP18IOMpLNBU8IOfEQ2pFeFSO5GxpXv2/YLQsfWe+QkdWkLN25kLcTOvT
 InUbyyO/wvfu1ucQM4RYWVRt4JFDlaUU32EmmTbWFyN2SteJaOvSvkX7aG0K9PBAFRTQSCp9RW0
 R6sJAhmOwIH2hjYUny8VzNlE3phcAtMp8o
X-Received: by 2002:a17:903:380b:b0:2b2:5857:5847 with SMTP id
 d9443c01a7336-2b9f2600a87mr72494105ad.5.1777984072821; 
 Tue, 05 May 2026 05:27:52 -0700 (PDT)
Received: from marchy ([2405:3800:88c:d085:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b9cae0e5fasm134390295ad.54.2026.05.05.05.27.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 05:27:52 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: devicetree@vger.kernel.org, Adam Azuddin <azuddinadam@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 "Kael D'Alcamo" <dev@kael-k.io>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 1/2] dt-bindings: display: panel: Add RAiO RA8875
 display controller
Date: Tue,  5 May 2026 20:26:29 +0800
Message-ID: <20260505122636.11859-2-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505122636.11859-1-azuddinadam@gmail.com>
References: <20260505122636.11859-1-azuddinadam@gmail.com>
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

The RA8875 is an SPI-connected TFT display controller by RAiO
Technology Inc. It supports display resolutions of up to 800x480.

Add YAML binding schema for the RA8875 controller, along with
the raio vendor prefix for RAiO Technology Inc.

Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 .../bindings/display/panel/raio,ra8875.yaml   | 76 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 78 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
new file mode 100644
index 000000000000..a49521242763
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/raio,ra8875.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RAiO RA8875 Display Controller
+
+maintainers:
+  - Adam Azuddin <azuddinadam@gmail.com>
+
+description: |
+  This binding is for display panels using an RAiO RA8875 controller
+  connected via SPI.
+
+allOf:
+  - $ref: panel-common.yaml#
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: raio,ra8875
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 25000000
+
+  reset-gpios:
+    maxItems: 1
+    description: GPIO used to reset the controller, optional
+
+  vcc-supply:
+    description: Regulator that provides the VCC voltage, optional
+
+  display-timings:
+    $ref: /schemas/display/panel/display-timings.yaml#
+
+required:
+  - compatible
+  - reg
+  - display-timings
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ra8875: ra8875@0 {
+            compatible = "raio,ra8875";
+            reg = <0>;
+            spi-max-frequency = <16000000>;
+            reset-gpios = <&gpio 25 GPIO_ACTIVE_LOW>;
+
+            display-timings {
+                native-mode = <&timing0>;
+                timing0: timing0 {
+                    clock-frequency = <25000000>;
+                    hactive = <800>;
+                    vactive = <480>;
+                    hfront-porch = <40>;
+                    hsync-len = <40>;
+                    hback-porch = <40>;
+                    vfront-porch = <10>;
+                    vsync-len = <10>;
+                    vback-porch = <20>;
+                };
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 28784d66ae7b..ca453042f6a2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1361,6 +1361,8 @@ patternProperties:
     description: Radxa
   "^raidsonic,.*":
     description: RaidSonic Technology GmbH
+  "^raio,.*":
+    description: RAiO Technology Inc.
   "^ralink,.*":
     description: Mediatek/Ralink Technology Corp.
   "^ramtron,.*":
-- 
2.54.0

