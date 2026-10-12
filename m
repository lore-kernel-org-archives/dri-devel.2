Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B9BBCA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D95E810E4F7;
	Mon, 12 Oct 2026 06:45:39 +0000 (UTC)
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com
 [209.85.214.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2298610E481
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:45:34 +0000 (UTC)
Received: by mail-pl1-f169.google.com with SMTP id
 d9443c01a7336-2dd4b3c311fso1282825ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 23:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791787533; x=1792392333; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=kUR3aroC7QKMpKgOnRgDOdhqgqz4M+XtodQ65N8R+f4=;
 b=JBySVLc43YifncTg8JFSffhuCl3cfJ63ByC2ARTFGpJ7o6MxUOLGRHCFKXeWVJ3nE0
 CF6sHXvO27q9GjhPxbrN51x0B4AFtM3BqnFErXLaf+DYggj0bOi+cauaoxnh4wdB2SVd
 F0NeKgpfW14grujJ0vj5a9OcPUo65DcoeHnS1g8tfVmVIu6/q2vNWH6sp5iNVcrVkOlN
 hrfb5TZiNqzhTyedIQDZ0Qj6rgJnpqxdSjYb9MW7FoJYVprXtC7W573NoaBgLZtMB6k0
 BR/jB4uSELkF2E+ANDOZWaXhMG0HzvaWskpNiF0/h3eRsmuraUE8N1v14Eq5+tauWbSH
 6XiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791787533; x=1792392333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=kUR3aroC7QKMpKgOnRgDOdhqgqz4M+XtodQ65N8R+f4=;
 b=IhitBqHIIzlEpqvofcPSLsdQtCkJxEYzYRxS6rpaomZr146Y+MCLSb4oX0SaPStPK/
 iFMCVDvZTbpgwV+aKVdbG96B6s7YZOPaBd+Z5+AxLBZ9OZHlv4HUPgmqDRrjsBv3D4Lf
 Cbuh8X+VFuenLf5sE/8oY53x/POC9YM9Bud4gFQz0/PdB1SFN1akMzhHxHpd0R4oEzt6
 hj30F27H5QfN0I90U4OcYVDPJmjYbq0umdPUd2GYvDO+MEMXSdfQMZTzZRw8sWpMEFZ6
 9vJdtOAylSPg9Qxb3OvLdCJSGFECObHW1EuJXkrdQq7nmMaIeY0jXEkV5VGC43BG3/Jg
 gQrw==
X-Forwarded-Encrypted: i=1;
 AKwUvBx4GoGzhVtEkcCu90wEp3Sa2zq4bU8iycdaddoYQUrdKjkCidCcNaqvJlB3Dcyi5jPGpDZiqjG+N0k=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJshtNKoAOUmH7qsQZpjvOXblyTucUrqwsM05aRYZQIX/GqBrA8
 EormLfZWg44ct3MEfb2Y/fJy74P7joOFw+YgM6frjl5+duhHKgmwGAqQ
X-Gm-Gg: AYBFou0az4J8w1IVfE2UsmOat/yXNzwZBZRRj7wcLG+0GEvA9cvJ2w6OWr3q9NtdUV1
 xVdrGxsC6zFOfr99QriW7GomhfX6JjfsXFsZbtM1Xv4IN7haDUFkmxKomVIs0ScXvDh6PF3tDSY
 iOM/f0lMrBa6fyjqY1grocPmvb0LNmcmKmY9sK5qIGDprz2qOYMHyaHt5D3FvQE+clQmcbEtSaI
 GuWaTOBEko+bG6snoP++4lAUUsBq8AdPVGyD3RksGvo0tA6NyvFGiprLAWFVm/ze0hrS74QJxDl
 55ZS/lwz5Ar6Tf5zzcBGChnSgpb7ym6zBZf946rdta9ZCgVe9+kC7yQetjiSeCGba2zwuNteTen
 9Bi2UbrqEFEpf/NkZCL3EQc+MO7OSxPU67baDxIiB9VbMXMpizVuuoAngwCAoVe5L2+wEXgsiHP
 VJgukPtI4GOpbU2EPfTd9A8IYu3ilty70W1YWxmtA5wruGJOfsXJjcseN8OltnwyJz9d0W2A3jq
 OYSUMk=
X-Received: by 2002:a17:90a:d49:b0:3ab:be66:ddc5 with SMTP id
 98e67ed59e1d1-3abbe66df3bmr3052672a91.6.1791787533505; 
 Sun, 11 Oct 2026 23:45:33 -0700 (PDT)
Received: from marchy ([2405:3800:8a8:86f0:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cd5fe84dc3dsm870713a12.13.2026.10.11.23.45.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 23:45:33 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 azuddinadam@gmail.com
Subject: [PATCH v4 1/2] dt-bindings: display: panel: Add RAiO RA8875 display
 controller
Date: Mon, 12 Oct 2026 14:45:04 +0800
Message-ID: <20261012064518.3497285-2-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261012064518.3497285-1-azuddinadam@gmail.com>
References: <20261012064518.3497285-1-azuddinadam@gmail.com>
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

Assisted-by: LLM
Signed-off-by: Adam Azuddin <azuddinadam@gmail.com>
---
 .../bindings/display/panel/raio,ra8875.yaml   | 77 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 79 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
new file mode 100644
index 000000000000..86777e2cec57
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
@@ -0,0 +1,77 @@
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
+description:
+  The RA8875 is a TFT LCD controller for panels up to 800x480 pixels.
+  It can be connected to the controller via 8080/6800 parallel interface,
+  SPI or I2C.
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
+  vdd-supply:
+    description:
+      3.3 V supply for the IO pins, the oscillator IO pins, the ADC pins
+      and the internal LDO. The 1.8 V core rail is generated internally.
+
+  reset-gpios:
+    description:
+      GPIO connected to the active-low RST# pin. Optional, since the board
+      may instead use an RC reset circuit.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - display-timings
+  - vdd-supply
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
+        display@0 {
+            compatible = "raio,ra8875";
+            reg = <0>;
+            spi-max-frequency = <16000000>;
+            vdd-supply = <&vcc_3v3>;
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
index ba2002969373..99d5113fb035 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1395,6 +1395,8 @@ patternProperties:
     description: Radxa
   "^raidsonic,.*":
     description: RaidSonic Technology GmbH
+  "^raio,.*":
+    description: RAiO Technology Inc.
   "^ralink,.*":
     description: Mediatek/Ralink Technology Corp.
   "^ramtron,.*":
-- 
2.55.0

